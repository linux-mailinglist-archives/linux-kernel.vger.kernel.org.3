Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE28575653
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 22:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239903AbiGNUZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 16:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbiGNUZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 16:25:10 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1FC27B36;
        Thu, 14 Jul 2022 13:25:09 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 80A352B05ABD;
        Thu, 14 Jul 2022 16:25:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 14 Jul 2022 16:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pjd.dev; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1657830305; x=1657833905; bh=dEHQ4rwrUu
        F1UGpd+DLi5Y852uMVTewadoYXIvYJyJM=; b=wRYAFZ/7xoGteRVuspPfArr2Wv
        QxSlR3KayGoBNWtidEUqGY1ThClRBiPK3OjVq5PRdJfEF4zZ+xtjym31cJ/taLb4
        gxbhcYJ9AibBSgIev/GG8WaWBROGmnz8mJ8mU2YmBmWQI5iQYRSjQvHXMS3qebMk
        EpuqmuPvfMeEEi4VOnNjqSrIKtsN/JcsNQRYPTS1GKIFNSNS8oLHo5GJakO/dW0X
        CRZ1kuqsJWiQr3uQL8oc1N125W7DywFqwYKvgLy/+BQ5wzCIrEP7SY2AAp9QTtDd
        gbaoiA7IseY+dDNSSSoVKKA3BgZ3O38f8j2Ob7NuXu2Vl3R88UTrd21b9y7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1657830305; x=1657833905; bh=dEHQ4rwrUuF1UGpd+DLi5Y852uMV
        TewadoYXIvYJyJM=; b=w9n6I+xL9nIeF9NVBJz20HOQFomsC8mPpKBrKhetOET3
        dCgUR+cnC0xytQ7JUEv/Yjs620/ZeFIM16VdbHw8ecI+1cOw6fjq9FDkpDF0WhoX
        JamGjntgTRcfHMjpAmH22+S0Zt/DB55+2PA1zP9dr7yJnmQdTdLe0SKMuOr3O5hi
        /Rf9wVG9GRwXZWm7soku5Qzzfmb2rn8fS6NzMX7ekFNMELnG5V4T6OKTLFWjf5rP
        WD7iSsrXT5pKtVi0uDziPmIVDfxugelQFEh7QUV0gsA+4s47JvQCJT9DT8czXpP6
        E0PDGBAMMGdEt6JBwoesC41AgItNRD7aLiEHANcnZQ==
X-ME-Sender: <xms:n3vQYoxYrmLBvOTZxcr3XQ0RYmp21wtQnMVw1C5VGdTILhNaplnGLQ>
    <xme:n3vQYsSXz_jfKXJPBkdrI2wQH7_aqZTqHWIqFmCrvENEW23PJJjm-C-b4-cLaTqLa
    KsKX3K_JnL-K1m70_s>
X-ME-Received: <xmr:n3vQYqUOzkq8L_zwBJd9Ss6Pu0qV0mcWN-jPwBBozzLfQtPWoPUo-QxWojK_OYE2akWaR0oQtY_8InXWUIDm4c9G>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudejledgudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrvght
    vghrucffvghlvghvohhrhigrshcuoehpvghtvghrsehpjhgurdguvghvqeenucggtffrrg
    htthgvrhhnpeejudfgfedvhffhffeiudefvdffhfegffegjefffedtheekgfehgfefveeh
    feejteenucffohhmrghinhepohhpvghntghomhhpuhhtvgdrohhrghdpkhgvrhhnvghlrd
    horhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpvghtvghrsehpjhgurdguvghv
X-ME-Proxy: <xmx:n3vQYmjm49W_-Ii0_MrEhS1Lf1UCW8CV_EUm3sbSxYsUDAfaMJG2ww>
    <xmx:n3vQYqBOLqcQiHvi3fs9StcThDD2I5sa8v7_OASlZEAdCjvFD2jT3g>
    <xmx:n3vQYnLWwYUykBvsuk04ZbYlmpNwAetcXgYBIoHf8e1otp9W9jJABg>
    <xmx:oHvQYiZNTe8EZhARh8DUBjNpok7vd-vCVkqg1KEhDJWmklGDc12oaETh6Zg>
Feedback-ID: i9e814621:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Jul 2022 16:25:01 -0400 (EDT)
Date:   Thu, 14 Jul 2022 13:24:59 -0700
From:   Peter Delevoryas <peter@pjd.dev>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Logananth Sundararaj <logananth13.hcl@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        naveen.mosess@hcl.com, thangavel.k@hcl.com,
        SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Olof Johansson <olof@lixom.net>,
        garnermic@gmail.com, velumanit@hcl.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3] The Yosemite V3.5 is a facebook multi-node server
 platform that host four OCP server. The BMC in the Yosemite V3.5 platform
 based on AST2600 SoC.
Message-ID: <YtB7mw1YSahFg0xI@pdel-mbp.dhcp.thefacebook.com>
References: <20220707132054.GA10610@logan-ThinkPad-T14-Gen-1>
 <CAK8P3a0P2u+LdXcU7As=dfNbg_J2eWfhgB9TT1-xVyH0v6OM5Q@mail.gmail.com>
 <YtBazSo/uJzFeF+L@pdel-mbp>
 <CAK8P3a1juHV6N2QtXaEcobWs6kQHBqqUn9MynvobyJtFFyOsfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1juHV6N2QtXaEcobWs6kQHBqqUn9MynvobyJtFFyOsfg@mail.gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_FMBLA_NEWDOM28,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 10:15:15PM +0200, Arnd Bergmann wrote:
> On Thu, Jul 14, 2022 at 8:05 PM Peter Delevoryas <peter@pjd.dev> wrote:
> > On Thu, Jul 07, 2022 at 03:33:48PM +0200, Arnd Bergmann wrote:
> > > > +       model = "Facebook fby35";
> > > > +       compatible = "facebook,fby35", "aspeed,ast2600";
> > > > +
> > > > +       aliases {
> > > > +               serial4 = &uart5;
> > > > +       };
> > >
> > > Why not start at serial0 here?
> >
> > Hey, Facebook person jumping in here (using a personal email):
> >
> > I think you're right, it should be like this:
> >
> >         aliases {
> >                 serial0 = &uart5;
> >                 serial1 = &uart1;
> >                 serial2 = &uart2;
> >                 serial3 = &uart3;
> >                 serial4 = &uart4;
> >         };
> 
> Are you actually using all five uarts though?

Actually yes, I should have mentioned this in my previous message.

YosemiteV3.5 is similar to YosemiteV3, which you can see here:

https://www.opencompute.org/products/423/wiwynn-yosemite-v3-server

This dts is for the BMC on the sled baseboard, and it manages the 4 slots in the
sled. Each slot has a "Bridge Interconnect" (BIC) (an AST1030) that manages the
slot CPU/etc. uart1 is connected to a uart on slot1's BIC, uart2 to slot2, etc.

We also have a work-in-progress QEMU model for this:

https://lore.kernel.org/qemu-devel/20220714154456.2565189-1-clg@kaod.org/

> 
> > > > +       chosen {
> > > > +               stdout-path = &uart5;
> > > > +               bootargs = "console=ttyS4,57600n8 root=/dev/ram rw vmalloc=384M";
> > > > +       };
> >
> > Also: if we do serial0 = &uart5, it should be console=ttyS0, not ttyS4.
> >
> > >
> > > The bootargs should really come from the boot loader.
> >
> > What if we want to boot the kernel by itself with QEMU? It's kinda annoying to
> > have to specify '-append "console=ttyS0,57600n8...' everytime, or to have to use
> > a wrapper script. But, it's also a source of bugs: I realized yesterday the
> > dts we were using here:
> >
> > https://github.com/facebook/openbmc-linux/blob/e26c76992e0761d9e440ff514538009384c094b4/arch/arm/boot/dts/aspeed-bmc-facebook-fby35.dts
> >
> > Has the wrong console setting.
> 
> You can encode the uart settings like
> 
>            stdout-path = "serial0:115200n8"
> 
> the rest really should be passed on the command line, not in
> the DT shipped with the kernel.
> 
>         Arnd
