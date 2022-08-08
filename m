Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E04858BE78
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 02:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbiHHAaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 20:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiHHAae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 20:30:34 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E66270A;
        Sun,  7 Aug 2022 17:30:32 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 3341C5C00E7;
        Sun,  7 Aug 2022 20:30:29 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Sun, 07 Aug 2022 20:30:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1659918629; x=1660005029; bh=vUg4jzb8rp
        TB+PxxVtsFWKsRKVaRqX5qBQyFHHywWLw=; b=ul2sTnvJcx6bvj1kq/rAQxb99P
        aCxhnjnuDUYyGfTdJOAsBbmSWPvd7h7hecTnq0LDXdybBGv29uZcvSj2j7kYbQnX
        ihhtwnD7aHDXxfbRfRZgkOtx9zlaJyq63GBtl3s1T03UwdiT9z7sP3QSeedPkGu8
        x05fTZ2oUCwfTKr/5QOUaS9f24v5fIyPTpcX39p6ZfbNnYaDCRb5zlK/K675/Q2i
        3Y1biK1qt+QK9Y8gfydg2VAwfaXm6AgvxAT+Ii1ruToYJbJpfgolPf9yVRo11mE0
        jHnvX/iMmCrfRu/JL/qcfr0H5E1/1AFqDk2m418aSgBoI4SymlEJJuwm8yaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1659918629; x=1660005029; bh=vUg4jzb8rpTB+PxxVtsFWKsRKVaR
        qX5qBQyFHHywWLw=; b=pan93dAt3RorWn/i4ZOUsL4jhGye0xO+tiPzW69qbDpi
        UTd6G/UXb0P0e4pijH+gw17B86X3NKy8w7OiYDSs/I8PUfZZDTh5t/r2xxxeVZTr
        yGPBa28D40WWWtnLVw1yTG5Tb5LEmHnHelEOIxXLRFt4gCdOWSs1HzbZNDyFgWzp
        ef7wgdJXdMA88/P1YT+A6LuFlex2uUEYZYclDlD+G1NjujdvHGiw00VFMDFqMU1V
        SnizgizcEy42/Uq4s5WABMlOUOe6ZtJaf6PMIf1VZRCGZwgid5LRSsMVhKIJy1VN
        GXTVoIxlaXLtT7c8IZ/HGzRZnRCFGv4bcyIYuKWu6g==
X-ME-Sender: <xms:JFnwYpPUe1WCB0VXlpfZMdEy7TjWHvCfvWd26ni1CPPQ-NBQvk5P4w>
    <xme:JFnwYr-wL2BHNmswcoeZAr3ApbeHhqmqNl0BSPkwmtskRWA7wnbEpteAuLZvm5Vf_
    v9DUZXnSuB-qY2gHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefjedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtf
    frrghtthgvrhhnpeekvdekjeekgfejudffteetgeejkeetteduvedtffdtledutdfhheev
    feetkeeiteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:JFnwYoQzjlafM2BZNwjWfq0UB3EyuEiMLqRe4NxAd7mI80N47DRfgw>
    <xmx:JFnwYlvzZ9cxIFR4y-ejEDvE03eadETZAZ5S3qnda9FwV3yfKCY8Zg>
    <xmx:JFnwYhckDpqxTEKteuF9gtTMCSFxw_R1NSk2nXbW9PWQbl9DVYWkBA>
    <xmx:JVnwYrvocnTQhp5uHJITtSoHcwbUuddhD62EerLVp3ua8XdjBP-zsg>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3B5B6170007E; Sun,  7 Aug 2022 20:30:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-758-ge0d20a54e1-fm-20220729.001-ge0d20a54
Mime-Version: 1.0
Message-Id: <d52e126e-3dc3-4645-a9f0-2f4e3411010a@www.fastmail.com>
In-Reply-To: <20220805090957.470434-1-j220584470k@gmail.com>
References: <20220805090957.470434-1-j220584470k@gmail.com>
Date:   Mon, 08 Aug 2022 10:00:08 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Ken Chen" <j220584470k@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>, "Joel Stanley" <joel@jms.id.au>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Potin Lai" <Potin.Lai@quantatw.com>, Cosmo.Chou@quantatw.com,
        "Michael Garner" <garnermic@fb.com>
Subject: Re: [PATCH 1/1] ARM: dts: aspeed-g6: enable more UART controllers
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 5 Aug 2022, at 18:39, Ken Chen wrote:
> Setup the configuration of UART6, UART7, UART8, and UART9 in
> aspeed-g6.dtsi.
>
> Signed-off-by: Ken Chen <j220584470k@gmail.com>
> ---
>  arch/arm/boot/dts/aspeed-g6.dtsi | 64 +++++++++++++++++++++++++++++++-
>  1 file changed, 62 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
> index 8c0de3f27883b..fe7cef6b5e976 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -34,8 +34,12 @@ aliases {
>  		serial2 = &uart3;
>  		serial3 = &uart4;
>  		serial4 = &uart5;
> -		serial5 = &vuart1;
> -		serial6 = &vuart2;
> +		serial5 = &uart6;
> +		serial6 = &uart7;
> +		serial7 = &uart8;
> +		serial8 = &uart9;
> +		serial9 = &vuart1;
> +		serial10 = &vuart2;
>  	};
> 

Have you tested the AST2600 systems in OpenBMC with this patch to see 
if you're not breaking any assumptions made by userspace about serial 
numbering, given the aliases exist?

Andrew
