Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9457D5B0384
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiIGL7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiIGL7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:59:32 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BCAE03D;
        Wed,  7 Sep 2022 04:59:31 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id CF3F42B05B84;
        Wed,  7 Sep 2022 07:59:27 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 07 Sep 2022 07:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1662551967; x=
        1662555567; bh=93TgYd152lsMJGukyVn+n+/KYrXdTp+yDhOzZKjQ6j4=; b=a
        wpcaSjMpvQxH/r24XuOYbW7qzgwqAdiOOcxmaxHRSpFS2LCPs7/QaE7SECr3bjYK
        2Z+jM3dw7YVeZ8RXWAD7G7FUfk+9OS3ywJEyDpRJAe7FpvG4kn8iLIETYUC2kkd4
        eYqMwh/QjEC4DT3fuqot48hq6mCjuNZWUI8khrReQASrv67oy9hh2WdIRJHDANKT
        ECnpC46+2xeAQE2iO1DLlrVGJx/+4bvljtivxPZkM2/eFoT2AVIwwXF0hNviWEpq
        DOGp/Nfe3w+yxCXNN5cPZcEEVqwFDyA/E1K3DLpHistUEIn/z3bmlTVTr5ygN47z
        Cvsrm/UjC2Fd3YRLfC83g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1662551967; x=
        1662555567; bh=93TgYd152lsMJGukyVn+n+/KYrXdTp+yDhOzZKjQ6j4=; b=a
        vHCxVUc2IdvYCG0t9AqWn7NS7WrBBG4UCH6F/qqtXeczJkJrszU9X1x2ZwdoIX/o
        9qLujK/2ikjuw90nv2kxe+NZrtQB37QxU8HR+t8ibz6DgkUrk93UJ6ieXq89vNsI
        /A+BKCEclvpZh0zRJoTINAHLB86Rjx91Yyqwlr1Xd4mQIwzm1xoiF/vM1C+QzzEo
        q0gx5JitIaESQZ/3OX9Racmy3WsUUfhIl/QdfHwXTkV4JpazE1QXscwrqpXcXrAT
        B1gOuIa/T5SEAmbA6PasO47lvyTWMOvkWuZh+gtFAjCAFBTIte9R6hrOZG4OwVBY
        fGNqnc2owYBFb3g/YRBkg==
X-ME-Sender: <xms:nYcYY1oX_Y-wC5X1wR2qHcedMPqDeTl2ns1mCbB3eSVEVlX0S7vCRQ>
    <xme:nYcYY3rpq4yC_ZlA8DKRZLFXe4CRkFFkZ69MaOfwy-hjPWdrhiqqxEV64gkUfkY3U
    wP2LK3OVcLpOVO3kTM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedttddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpefgkeeuleegieeghfduudeltdekfeffjeeuleehleefudettddtgfevueef
    feeigeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:nocYYyNdzljoXCNjYeoa-shYLTaCax1-IzEHxZfwDo5DB0KdeyFC2Q>
    <xmx:nocYYw6GsrKwte3Wldp8tl1SQ6nCpsO-Hhgts03HjI9va09UlTVk0g>
    <xmx:nocYY05sn2_rs2Wz_CWm0LztL1KRLOObjYocAb11SdH-hhMiYV0sMQ>
    <xmx:n4cYY6F0VJXmjySOdLPk-Wkcz93cHgkwuV-QLF1CUOJbLpr4VVDN7a0cUh4>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DB8EBB60083; Wed,  7 Sep 2022 07:59:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-927-gf4c98c8499-fm-20220826.002-gf4c98c84
Mime-Version: 1.0
Message-Id: <715b40ba-1bcc-4582-bed1-ef41126c7b94@www.fastmail.com>
In-Reply-To: <4e9b4471-a6f2-4b16-d830-67d253ae4e6a@linux.intel.com>
References: <20220906104805.23211-1-jslaby@suse.cz>
 <Yxcvbk281f/vy4vb@hovoldconsulting.com>
 <dec6d5c4-45b7-f087-95f4-bf1dae9e9d27@kernel.org>
 <4e9b4471-a6f2-4b16-d830-67d253ae4e6a@linux.intel.com>
Date:   Wed, 07 Sep 2022 13:59:05 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Jiri Slaby" <jirislaby@kernel.org>,
        "Johan Hovold" <johan@kernel.org>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Tobias Klauser" <tklauser@distanz.ch>,
        "Richard Genoud" <richard.genoud@gmail.com>,
        "Nicolas Ferre" <nicolas.ferre@microchip.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>,
        "Vladimir Zapolskiy" <vz@mleia.com>,
        "Liviu Dudau" <liviu.dudau@arm.com>,
        "Sudeep Holla" <sudeep.holla@arm.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "Shawn Guo" <shawnguo@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        "Fabio Estevam" <festevam@gmail.com>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        "Manivannan Sadhasivam" <mani@kernel.org>,
        "Russell King" <linux@armlinux.org.uk>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        "Kevin Cernekee" <cernekee@gmail.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Orson Zhai" <orsonzhai@gmail.com>,
        "Baolin Wang" <baolin.wang7@gmail.com>,
        "Chunyan Zhang" <zhang.lyra@gmail.com>,
        "Patrice Chotard" <patrice.chotard@foss.st.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 0/4] tty: TX helpers
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 7, 2022, at 12:16 PM, Ilpo J=C3=A4rvinen wrote:
> On Wed, 7 Sep 2022, Jiri Slaby wrote:
>> On 06. 09. 22, 13:30, Johan Hovold wrote:
>> > On Tue, Sep 06, 2022 at 12:48:01PM +0200, Jiri Slaby wrote:
>> > NAK
>>=20
>> I'd love to come up with something nicer. That would be a function in
>> serial-core calling hooks like I had [1] for example. But provided al=
l those
>> CPU workarounds/thunks, it'd be quite expensive to call two functions=
 per
>> character.
>>=20
>> Or creating a static inline (having =C2=B1 the macro content) and the=
 hooks as
>> parameters and hope for optimizations to eliminate thunks (also sugge=
sted in
>> the past [1]).
>>=20
>> [1] https://lore.kernel.org/all/20220411105405.9519-1-jslaby@suse.cz/
>
> I second Jiri here.
>
> Saving lines in drivers is not that important compared with all removi=
ng=20
> all the variants of the same thing that have crept there over the year=
s.
>
> I suspect the main reason for the variants is that everybody just used=20
> other drivers as examples and therefore we've a few "main" variant=20
> branches depending on which of the drivers was used as an example for =
the=20
> other. That is hardly a good enough reason to keep them different and =
as=20
> long as each driver keeps its own function for this, it will eventuall=
y=20
> lead to similar differentiation so e.g. a one-time band-aid similariza=
tion=20
> would not help in the long run.
>
> Also, I don't understand why you see it unreadable when the actual cod=
e is=20
> out in the open in that macro. It's formatted much better than e.g.=20
> read_poll_timeout() if you want an example of something that is hardly=20
> readable ;-). I agree though there's a learning-curve, albeit small, t=
hat=20
> it actually creates a function but that doesn't seem to me as big of a=
n=20
> obstacle you seem to think.

I think it would help to replace the macro that defines
the function with a set of macros that can be used in
function bodies. This would avoid the __VA_ARGS__ stuff
and allow readers that are unfamiliar with tty drivers to
treat it as a function call.

So e.g. instead of=20

static DEFINE_UART_PORT_TX_HELPER_LIMITED(altera_jtaguart_do_tx_chars,
		true,
		writel(ch, port->membase + ALTERA_JTAGUART_DATA_REG),
		({}));

the altera_jtaguart driver would contain a function like

static int altera_jtaguart_do_tx_chars(struct uart_port *port,
                                       unsigned int count)
{
       char ch;

       return uart_port_tx_helper_limited(port, ch, count, true,
                writel(ch, port->membase + ALTERA_JTAGUART_DATA_REG),
                ({}));
}

or some variation of that. It's a few more lines, but those
extra lines would help me understand what is actually going on
while still avoiding the usual bugs and duplication.

If the caller of that function is itself trivial (like
serial21285_tx_chars), then the intermediate function can
be omitted in order to save some of the extra complexity.

       Arnd
