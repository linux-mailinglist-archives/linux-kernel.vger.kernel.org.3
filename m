Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E943E50CDBC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 23:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236678AbiDWVcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 17:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237271AbiDWVck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 17:32:40 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2AA1F604;
        Sat, 23 Apr 2022 14:29:32 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id D3E0A5C00D1;
        Sat, 23 Apr 2022 17:29:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 23 Apr 2022 17:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1650749371; x=
        1650835771; bh=Pj0wzKf6dex5toiA0Kiw7U4VWCF5jYwgc7tf+MRocTc=; b=W
        hdQMsMqi+xCWMjbGqY+t5oRH6pqQ34asy6z49IHhxNi7yc829+nDlcQfz8/i1Hh6
        b3ICSgvcN6/c4Jlt0X95wy1pZ/7vXIl8P01QIK5SH9NN39zvD5oq9e+st/LFWuIl
        AiSMCDXoAqEiIYpDvrk1sA4sUwn90n3ZrtBpMI50jHyCHXaT9plDkbMAfVlWB/HB
        cX8yGiNEIPyr2ogEAqG9JD2rCQJ7o3SsasSWvNBFRDydokiK4BhmorEy3EkCxG3o
        zGMMyHyV/TB5rCN9L5pKkRhNw8hAMNYW3aGPlQBGM5d4smczpNr43SdCgf1V27+F
        5l5PUCICVXYqM5WZfpF/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1650749371; x=1650835771; bh=Pj0wzKf6dex5t
        oiA0Kiw7U4VWCF5jYwgc7tf+MRocTc=; b=aawUbErFS6LqyNtEnu+g7ebqgQBUY
        8ltMy1fzWyw3OVl/IS5vOTSwEaJoDTiyPsDSextiHOZDAxzU/KO9hTuvepVpCAc+
        Ph5tDE62olgcpHfWr2JK9LNs9H6MPpYx7tf+rP4MfsZTc/dksML6eQKDwssARs/u
        cj5Vo9c+yuq/2+Xlo9koQRhtoLLjTMz+n78Aar21TJyCT5hSEwjLU33eyBESUzkv
        rMiUvNEhekB18sRa6TU0/9QDEWd/x6TtNl8WKZIyQpVTWxXWVuXAyf/fQpQrgcKc
        989QI01FOFP1OtAHlG+kZQwaoxo8p+kfk40pnAeB+FWExeMV4KBN//Gzg==
X-ME-Sender: <xms:u29kYiXsnQfGLWnHZMduinOBBMS3-yxQ-0PmgAUCvWmbjyCExjnKEg>
    <xme:u29kYunleDDiYBkDAbsnLMO7FkoJR4C64kHFIsQ3xThU92yir5oS2RdU5aSJzF1U8
    G3V1sBlJr7WI-1qNg>
X-ME-Received: <xmr:u29kYmaSNTpZmwyHuFKdHQwc-AccgRATbJBQSRnQYm2IbdHUW0ZBY-V9pkzBLzz5AYUH4FToyE5k9WoytJLqT9638EKsDpJ-c9Unnr_iCFUEGSIWgwwtmpDFbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdeigdduiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeelteejffdvgeehkedtkeevueeuteffteffhedufeeujedvudef
    udetieeijeevleenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhl
    rghnugdrohhrgh
X-ME-Proxy: <xmx:u29kYpVlQpm8em9p5f8vrWn6XKOgbu6dOvUdawBinBTHHWZCH0mqsQ>
    <xmx:u29kYsniKACYKNioTk0gWytNv0JU-vfXSIWvGWM3hBfj9VYEXKiNWA>
    <xmx:u29kYufBW60TawUWpqRJ6uYBn1apqYH05N3icgqADiFAg6FMMhClIQ>
    <xmx:u29kYle5oQ9uOaZIgFNEyLHX0JUy5eIG_aoexcMdT4rMHDpLbr6Aag>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 23 Apr 2022 17:29:30 -0400 (EDT)
Subject: Re: [PATCH 02/12] pinctrl: sunxi: add support for R329 CPUX pin
 controller
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@aosc.io>
References: <20220422140902.1058101-1-icenowy@aosc.io>
 <BYAPR20MB2472B703E377AA813EE55B26BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <d82f6c90-1926-f3b1-02a0-b82e5ee179b0@sholland.org>
Date:   Sat, 23 Apr 2022 16:29:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <BYAPR20MB2472B703E377AA813EE55B26BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/22 10:40 AM, icenowy@outlook.com wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
> 
> Allwinner R329 SoC has two pin controllers similar to ones on previous
> SoCs, one in CPUX power domain and another in CPUS.
> 
> This patch adds support for the CPUX domain pin controller.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

This is identical to the previous version. Please see my comments on that, as
they still apply:

https://lore.kernel.org/linux-sunxi/2f6de069-7983-efc2-3c4a-7c1355c4cbc5@sholland.org/
