Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3551448DF81
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 22:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbiAMVTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 16:19:21 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:45409 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231592AbiAMVTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 16:19:20 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id BC6545802C1;
        Thu, 13 Jan 2022 16:19:19 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute4.internal (MEProxy); Thu, 13 Jan 2022 16:19:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm1; bh=wKnJN
        fNAdFvszmvv1j06We4V9Pb2eZZdg/QXVQobFuk=; b=GbbNa22XndxUtAHAhTE2L
        1F/Z3QJ4CAxKGineSw57g7VwjzeXB7EOchaSaFvTEIWighJ2AJyDHOtctbnRO9rQ
        6glhegdBfx38cMOX9mSENrDi1zczCJOYrJNZwF8tkfD7A57neKOIGj0SItQamO47
        8D65hF3P92vAhshegJQ41tSRHVDtXp/gf2RdvBa0u4WIAJwrxcVliVp6woPJKt0K
        +ti0GWhGlejEfRXJL1kssPefKwEDhAQ3ng/qxAxm1B1+UkWq0HybCZC3ikvi7pOc
        ExeshA2MPg3jthBPndpr7qnprV0ngZm6hfkJqX5kt8yQyE+fnLg9dJxD6RueCUdy
        g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=wKnJNfNAdFvszmvv1j06We4V9Pb2eZZdg/QXVQobF
        uk=; b=FkQTeMkFqRts4ecT3UGrUHaPsYewTtHYGm765kQRlPiktnXVPcF2CBi+2
        0pTzd6oxhwGNHklde1ZYGJAKdndvbm67a0FgTREjso+b1W+gS870mjT8CBCDbvIo
        pxYq1t47ctlg5MTaAxHXz2OJaP7cHDF2OXBfY0V+8/JFe47uogrj/EklZKSI0sro
        RDIxslljwHXRzrbLYPyhWVI4Asezhafv94/JglRFioAstFMuejhrkcaC5p6TwpVa
        eJJeR8RHVX4DQP7juTLWdcjiC15Q0ClpR+GjL6L8WFJ5CjBtaU3MfNVdhRBho1wT
        blDPE/K/ieq1ya+9wIgp9zfUOK78g==
X-ME-Sender: <xms:V5fgYedW_mDDUQC5msqTs4bniSMR5B2j20f5uVnLHvmHB6y5DUH4ag>
    <xme:V5fgYYOmSIUhL3KYTNOAGzggREhlGpYOk0hxUaJQFVKobEGk8wigK68geyy-2aCP7
    CdKKXZzChCPgMXNV7I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrtdefgddugeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
    rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
    eqnecuggftrfgrthhtvghrnhepuddvhfdvgeekgeduheelhefgjeeuhfegieelueevfffg
    kefgudevfefgkeduffeinecuffhomhgrihhnpehgohhoghhlvghsohhurhgtvgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgr
    gihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:V5fgYfjvrBdAqKEVNrX2RumJ3-MH6J8d6CwfikLAi8UmqjaqeJmf5Q>
    <xmx:V5fgYb9ovgEZeUSeaOsB-AVTx3brp60BnVeb0JAXarr1QhxtT1WkLw>
    <xmx:V5fgYav3hT6oqnt_p7OMifaK7ymHS8-prtT0A9vq6JSmHTl6tutprw>
    <xmx:V5fgYUI3yyGI6baEz5Q69Cm7sjBfaBT_q03bRF7cdSQaNagWYnGI_g>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2926AFA0AA6; Thu, 13 Jan 2022 16:19:19 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4569-g891f756243-fm-20220111.001-g891f7562
Mime-Version: 1.0
Message-Id: <90a1b3b0-97d7-4880-a42f-44c450cbc2fb@www.fastmail.com>
In-Reply-To: <20220113201920.3201760-3-laurent@vivier.eu>
References: <20220113201920.3201760-1-laurent@vivier.eu>
 <20220113201920.3201760-3-laurent@vivier.eu>
Date:   Thu, 13 Jan 2022 21:18:53 +0000
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Laurent Vivier" <laurent@vivier.eu>, linux-kernel@vger.kernel.org
Cc:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Alessandro Zummo" <a.zummo@towertech.it>,
        linux-m68k@lists.linux-m68k.org,
        "John Stultz" <john.stultz@linaro.org>, linux-rtc@vger.kernel.org,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v6 2/4] rtc: goldfish: use __raw_writel()/__raw_readl()
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E5=9C=A82022=E5=B9=B41=E6=9C=8813=E6=97=A5=E4=B8=80=E6=9C=88 =E4=B8=8B=E5=
=8D=888:19=EF=BC=8CLaurent Vivier=E5=86=99=E9=81=93=EF=BC=9A
> As android implementation defines the endianness of the device is the =
one
> of the architecture replace all writel()/readl() by
> __raw_writel()/__raw_readl()
>
> https://android.googlesource.com/platform/external/qemu/+/refs/heads/e=
mu-master-dev/hw/timer/goldfish_timer.c#177
>
> The same change has been done for goldfish-tty:
>
>   commit da31de35cd2f ("tty: goldfish: use __raw_writel()/__raw_readl(=
)")
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Acked-by: Jiauxn Yang <jiaxun.yang@flygoat.com>

Well I do think it's a mistake by Android. They only considered little e=
ndian as they only have little endian devices.

But given that the implementation is already a part of QEMU, we must liv=
e with that :-)

Thanks.

> ---
>  drivers/rtc/rtc-goldfish.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/rtc/rtc-goldfish.c b/drivers/rtc/rtc-goldfish.c
> index 7ab95d052644..3e76160d40b9 100644
> --- a/drivers/rtc/rtc-goldfish.c
> +++ b/drivers/rtc/rtc-goldfish.c
> @@ -41,8 +41,8 @@ static int goldfish_rtc_read_alarm(struct device *de=
v,
>  	rtcdrv =3D dev_get_drvdata(dev);
>  	base =3D rtcdrv->base;
>=20
> -	rtc_alarm_low =3D readl(base + TIMER_ALARM_LOW);
> -	rtc_alarm_high =3D readl(base + TIMER_ALARM_HIGH);
> +	rtc_alarm_low =3D __raw_readl(base + TIMER_ALARM_LOW);
> +	rtc_alarm_high =3D __raw_readl(base + TIMER_ALARM_HIGH);
>  	rtc_alarm =3D (rtc_alarm_high << 32) | rtc_alarm_low;
>=20
>  	do_div(rtc_alarm, NSEC_PER_SEC);
> @@ -50,7 +50,7 @@ static int goldfish_rtc_read_alarm(struct device *de=
v,
>=20
>  	rtc_time64_to_tm(rtc_alarm, &alrm->time);
>=20
> -	if (readl(base + TIMER_ALARM_STATUS))
> +	if (__raw_readl(base + TIMER_ALARM_STATUS))
>  		alrm->enabled =3D 1;
>  	else
>  		alrm->enabled =3D 0;
> @@ -71,18 +71,18 @@ static int goldfish_rtc_set_alarm(struct device *d=
ev,
>=20
>  	if (alrm->enabled) {
>  		rtc_alarm64 =3D rtc_tm_to_time64(&alrm->time) * NSEC_PER_SEC;
> -		writel((rtc_alarm64 >> 32), base + TIMER_ALARM_HIGH);
> -		writel(rtc_alarm64, base + TIMER_ALARM_LOW);
> -		writel(1, base + TIMER_IRQ_ENABLED);
> +		__raw_writel((rtc_alarm64 >> 32), base + TIMER_ALARM_HIGH);
> +		__raw_writel(rtc_alarm64, base + TIMER_ALARM_LOW);
> +		__raw_writel(1, base + TIMER_IRQ_ENABLED);
>  	} else {
>  		/*
>  		 * if this function was called with enabled=3D0
>  		 * then it could mean that the application is
>  		 * trying to cancel an ongoing alarm
>  		 */
> -		rtc_status_reg =3D readl(base + TIMER_ALARM_STATUS);
> +		rtc_status_reg =3D __raw_readl(base + TIMER_ALARM_STATUS);
>  		if (rtc_status_reg)
> -			writel(1, base + TIMER_CLEAR_ALARM);
> +			__raw_writel(1, base + TIMER_CLEAR_ALARM);
>  	}
>=20
>  	return 0;
> @@ -98,9 +98,9 @@ static int goldfish_rtc_alarm_irq_enable(struct devi=
ce *dev,
>  	base =3D rtcdrv->base;
>=20
>  	if (enabled)
> -		writel(1, base + TIMER_IRQ_ENABLED);
> +		__raw_writel(1, base + TIMER_IRQ_ENABLED);
>  	else
> -		writel(0, base + TIMER_IRQ_ENABLED);
> +		__raw_writel(0, base + TIMER_IRQ_ENABLED);
>=20
>  	return 0;
>  }
> @@ -110,7 +110,7 @@ static irqreturn_t goldfish_rtc_interrupt(int irq,=20
> void *dev_id)
>  	struct goldfish_rtc *rtcdrv =3D dev_id;
>  	void __iomem *base =3D rtcdrv->base;
>=20
> -	writel(1, base + TIMER_CLEAR_INTERRUPT);
> +	__raw_writel(1, base + TIMER_CLEAR_INTERRUPT);
>=20
>  	rtc_update_irq(rtcdrv->rtc, 1, RTC_IRQF | RTC_AF);
>=20
> @@ -128,8 +128,8 @@ static int goldfish_rtc_read_time(struct device=20
> *dev, struct rtc_time *tm)
>  	rtcdrv =3D dev_get_drvdata(dev);
>  	base =3D rtcdrv->base;
>=20
> -	time_low =3D readl(base + TIMER_TIME_LOW);
> -	time_high =3D readl(base + TIMER_TIME_HIGH);
> +	time_low =3D __raw_readl(base + TIMER_TIME_LOW);
> +	time_high =3D __raw_readl(base + TIMER_TIME_HIGH);
>  	time =3D (time_high << 32) | time_low;
>=20
>  	do_div(time, NSEC_PER_SEC);
> @@ -149,8 +149,8 @@ static int goldfish_rtc_set_time(struct device=20
> *dev, struct rtc_time *tm)
>  	base =3D rtcdrv->base;
>=20
>  	now64 =3D rtc_tm_to_time64(tm) * NSEC_PER_SEC;
> -	writel((now64 >> 32), base + TIMER_TIME_HIGH);
> -	writel(now64, base + TIMER_TIME_LOW);
> +	__raw_writel((now64 >> 32), base + TIMER_TIME_HIGH);
> +	__raw_writel(now64, base + TIMER_TIME_LOW);
>=20
>  	return 0;
>  }
> --=20
> 2.34.1

--=20
- Jiaxun
