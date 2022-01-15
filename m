Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A44048F9A9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 23:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbiAOW0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 17:26:25 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:60083 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230464AbiAOW0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 17:26:24 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 2B30D2B001D1;
        Sat, 15 Jan 2022 17:26:23 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute4.internal (MEProxy); Sat, 15 Jan 2022 17:26:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm1; bh=GmKOC
        EuMn8GQgtCLVZiEgJqH55Q45JknrWSsBbMngLI=; b=WQO5YUwnDN6rc8tCRR3Eh
        1qB/UoUoyDj10qanPA11rfz+gjF3aqfLDZfpy0PrzPOH5pNo8lBJa/tIPXnEwP7v
        NLhUBYdDJoAspfs01zGXjEa4b3JJG0Jfz2KTyJC9Mt9AYMSaaN8jG9efdTtQ02YC
        e/qe3Z6nWTmh/PC6Uwv9CIORB//Bey2dVkKLdR6m9cGdQ7jL4lOutikMPvH4U2kO
        lrDksICkT5q64z4FPGW2U4IjOJ2P/sNfJv2buUdpw/3r2xIANZ1pcxi+4EtOTrOL
        uphWID5Epb3ioFg8oz4W63zSVyPbpcLLdgQvdUOSOzQJUYyl+i3L9vP9lWZRkPaH
        Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=GmKOCEuMn8GQgtCLVZiEgJqH55Q45JknrWSsBbMng
        LI=; b=V6+M9jS1uQov96onjFx0eoJwKucGF/D9LSwzpj6yjng0KGL1/86j2XG2R
        7xhoBJiwdKdlC+HU4yrGdI93awwzMjhW/TkmvwwjnpfTh3RfEhHdm9WAHAc4279U
        4lm2dUhGe9kCKz2kI3cdUAdRj15dZq/KBlePAlyCKyr8iFP7r6eCnzX+q+gIicpR
        OdEsQHWr5l8ykA/90kTD1yRahc68Q6/N8dSPZiCBYGj31rh1Zplar34Rcy7pfB20
        49VxidC+PYTlHZIFD2mGEsS3IwITP27mhA47s29WurNwymnEBEpa5wmK6Y8Ru1ph
        h22trHLZaanpE4g91UlMQnDKzmf4Q==
X-ME-Sender: <xms:DUrjYY7E31sjimgksyoYl8YS1iGN87dOMstybIUIE9IHTX02XBMWsw>
    <xme:DUrjYZ5gvMcfXjE8IJCjtS1DBt9LZzNIWkLrhaBzz0pwyoSZ9EaPjLkTuc2KOgBjk
    r6u-nRJYAvWxwMEOmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrtdejgdduieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
    rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
    eqnecuggftrfgrthhtvghrnhepuddvhfdvgeekgeduheelhefgjeeuhfegieelueevfffg
    kefgudevfefgkeduffeinecuffhomhgrihhnpehgohhoghhlvghsohhurhgtvgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgr
    gihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:DUrjYXdvC1eovAQHLkA3aBXeIKPv0ZkbQL-Nn4gftwRb62fLYb7YSA>
    <xmx:DUrjYdLLmo6EoCy31fccZAo6kh6XYiEsw7yAN5UFqGC4lSq73cDr3w>
    <xmx:DUrjYcI44wjkot0uoJH0yfAg267B1IIlPW_HhiopeKsQC4Fwy6D3Mg>
    <xmx:DkrjYRWFIqNmKYKtOf7Z48JGcUZEtpI7-t_rdO0rWbB4eXEAUltoUl0N2DI>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D1B5AFA0AA6; Sat, 15 Jan 2022 17:26:21 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4569-g891f756243-fm-20220111.001-g891f7562
Mime-Version: 1.0
Message-Id: <f6e1858c-a31f-4f07-96ed-fb1d792dab49@www.fastmail.com>
In-Reply-To: <20220115193245.3777833-3-laurent@vivier.eu>
References: <20220115193245.3777833-1-laurent@vivier.eu>
 <20220115193245.3777833-3-laurent@vivier.eu>
Date:   Sat, 15 Jan 2022 22:25:58 +0000
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Laurent Vivier" <laurent@vivier.eu>, linux-kernel@vger.kernel.org
Cc:     "John Stultz" <john.stultz@linaro.org>, linux-rtc@vger.kernel.org,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Alessandro Zummo" <a.zummo@towertech.it>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Arnd Bergmann" <arnd@arndb.de>, linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH v8 2/4] rtc: goldfish: introduce
 goldfish_ioread32()/goldfish_iowrite32()
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E5=9C=A82022=E5=B9=B41=E6=9C=8815=E6=97=A5=E4=B8=80=E6=9C=88 =E4=B8=8B=E5=
=8D=887:32=EF=BC=8CLaurent Vivier=E5=86=99=E9=81=93=EF=BC=9A
> The goldfish device always uses the same endianness as the architecture
> using it:
> https://android.googlesource.com/platform/external/qemu/+/refs/heads/e=
mu-master-dev/hw/timer/goldfish_timer.c#177
>
> On a big-endian machine, the device is also big-endian, on a
> little-endian machine the device is little-endian.
>
> So we need to use the right accessor to read/write values to the goldf=
ish
> registers: ioread32()/iowrite32() on a little-endian machine,
> ioread32be()/iowrite32be() on a big-endian machine.
>
> This patch introduces goldfish_ioread32()/goldfish_iowrite32() that us=
es
> the expected accessor according to the machine endianness.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Acked-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

> ---
>  drivers/rtc/rtc-goldfish.c | 39 +++++++++++++++++++++++---------------
>  1 file changed, 24 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/rtc/rtc-goldfish.c b/drivers/rtc/rtc-goldfish.c
> index 7ab95d052644..b0cae4729b03 100644
> --- a/drivers/rtc/rtc-goldfish.c
> +++ b/drivers/rtc/rtc-goldfish.c
> @@ -23,6 +23,15 @@
>  #define TIMER_ALARM_STATUS	0x18
>  #define TIMER_CLEAR_INTERRUPT	0x1c
>=20
> +/* goldfish endianness depends on CPU endianness */
> +#ifdef CONFIG_CPU_BIG_ENDIAN
> +#define goldfish_ioread32 ioread32be
> +#define goldfish_iowrite32 iowrite32be
> +#else
> +#define goldfish_ioread32 ioread32
> +#define goldfish_iowrite32 iowrite32
> +#endif
> +
>  struct goldfish_rtc {
>  	void __iomem *base;
>  	int irq;
> @@ -41,8 +50,8 @@ static int goldfish_rtc_read_alarm(struct device *de=
v,
>  	rtcdrv =3D dev_get_drvdata(dev);
>  	base =3D rtcdrv->base;
>=20
> -	rtc_alarm_low =3D readl(base + TIMER_ALARM_LOW);
> -	rtc_alarm_high =3D readl(base + TIMER_ALARM_HIGH);
> +	rtc_alarm_low =3D goldfish_ioread32(base + TIMER_ALARM_LOW);
> +	rtc_alarm_high =3D goldfish_ioread32(base + TIMER_ALARM_HIGH);
>  	rtc_alarm =3D (rtc_alarm_high << 32) | rtc_alarm_low;
>=20
>  	do_div(rtc_alarm, NSEC_PER_SEC);
> @@ -50,7 +59,7 @@ static int goldfish_rtc_read_alarm(struct device *de=
v,
>=20
>  	rtc_time64_to_tm(rtc_alarm, &alrm->time);
>=20
> -	if (readl(base + TIMER_ALARM_STATUS))
> +	if (goldfish_ioread32(base + TIMER_ALARM_STATUS))
>  		alrm->enabled =3D 1;
>  	else
>  		alrm->enabled =3D 0;
> @@ -71,18 +80,18 @@ static int goldfish_rtc_set_alarm(struct device *d=
ev,
>=20
>  	if (alrm->enabled) {
>  		rtc_alarm64 =3D rtc_tm_to_time64(&alrm->time) * NSEC_PER_SEC;
> -		writel((rtc_alarm64 >> 32), base + TIMER_ALARM_HIGH);
> -		writel(rtc_alarm64, base + TIMER_ALARM_LOW);
> -		writel(1, base + TIMER_IRQ_ENABLED);
> +		goldfish_iowrite32((rtc_alarm64 >> 32), base + TIMER_ALARM_HIGH);
> +		goldfish_iowrite32(rtc_alarm64, base + TIMER_ALARM_LOW);
> +		goldfish_iowrite32(1, base + TIMER_IRQ_ENABLED);
>  	} else {
>  		/*
>  		 * if this function was called with enabled=3D0
>  		 * then it could mean that the application is
>  		 * trying to cancel an ongoing alarm
>  		 */
> -		rtc_status_reg =3D readl(base + TIMER_ALARM_STATUS);
> +		rtc_status_reg =3D goldfish_ioread32(base + TIMER_ALARM_STATUS);
>  		if (rtc_status_reg)
> -			writel(1, base + TIMER_CLEAR_ALARM);
> +			goldfish_iowrite32(1, base + TIMER_CLEAR_ALARM);
>  	}
>=20
>  	return 0;
> @@ -98,9 +107,9 @@ static int goldfish_rtc_alarm_irq_enable(struct dev=
ice *dev,
>  	base =3D rtcdrv->base;
>=20
>  	if (enabled)
> -		writel(1, base + TIMER_IRQ_ENABLED);
> +		goldfish_iowrite32(1, base + TIMER_IRQ_ENABLED);
>  	else
> -		writel(0, base + TIMER_IRQ_ENABLED);
> +		goldfish_iowrite32(0, base + TIMER_IRQ_ENABLED);
>=20
>  	return 0;
>  }
> @@ -110,7 +119,7 @@ static irqreturn_t goldfish_rtc_interrupt(int irq,=20
> void *dev_id)
>  	struct goldfish_rtc *rtcdrv =3D dev_id;
>  	void __iomem *base =3D rtcdrv->base;
>=20
> -	writel(1, base + TIMER_CLEAR_INTERRUPT);
> +	goldfish_iowrite32(1, base + TIMER_CLEAR_INTERRUPT);
>=20
>  	rtc_update_irq(rtcdrv->rtc, 1, RTC_IRQF | RTC_AF);
>=20
> @@ -128,8 +137,8 @@ static int goldfish_rtc_read_time(struct device=20
> *dev, struct rtc_time *tm)
>  	rtcdrv =3D dev_get_drvdata(dev);
>  	base =3D rtcdrv->base;
>=20
> -	time_low =3D readl(base + TIMER_TIME_LOW);
> -	time_high =3D readl(base + TIMER_TIME_HIGH);
> +	time_low =3D goldfish_ioread32(base + TIMER_TIME_LOW);
> +	time_high =3D goldfish_ioread32(base + TIMER_TIME_HIGH);
>  	time =3D (time_high << 32) | time_low;
>=20
>  	do_div(time, NSEC_PER_SEC);
> @@ -149,8 +158,8 @@ static int goldfish_rtc_set_time(struct device=20
> *dev, struct rtc_time *tm)
>  	base =3D rtcdrv->base;
>=20
>  	now64 =3D rtc_tm_to_time64(tm) * NSEC_PER_SEC;
> -	writel((now64 >> 32), base + TIMER_TIME_HIGH);
> -	writel(now64, base + TIMER_TIME_LOW);
> +	goldfish_iowrite32((now64 >> 32), base + TIMER_TIME_HIGH);
> +	goldfish_iowrite32(now64, base + TIMER_TIME_LOW);
>=20
>  	return 0;
>  }
> --=20
> 2.34.1

--=20
- Jiaxun
