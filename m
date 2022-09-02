Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1928A5AAB80
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbiIBJfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235471AbiIBJfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:35:00 -0400
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FACE026;
        Fri,  2 Sep 2022 02:34:58 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 871352B05965;
        Fri,  2 Sep 2022 05:34:56 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Fri, 02 Sep 2022 05:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1662111296; x=1662114896; bh=uzP2BTOvx9
        B1JqfpE816Vor6uj+jKwcwYjNS21O8AC8=; b=OqYzw3jv6r/dQ7IyYO/ABg5QV6
        2PaXmd4idaKmu+9pMGyza+Nc93Nxzsb1aDXzja6QClzCFvRIpOYGciAwVYEKDB8D
        AwggKFTYAu8kvp3qI1Hi5A7V3VEjkX4AG09TYHKYc1lRPuRUyJbI3EQJwwWBCub0
        3CB/BBgd4yO0sWpZ8AzghfUZYcne93EeHmyEdwddkxAlcl0mwa+vJUsmrqtBQ3X2
        U/DQy48zmWcfcIIuwiyUhBlzV4it3GyCo2708o8E63usOoCRJTTIFM0lcPJm8SO+
        ZmqXRsBOTEMX29TCWYIYMwONGNg/dSmolGrffFjjNmIlV9sRp3TTi8rUSIrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        i56a14606.fm1; t=1662111296; x=1662114896; bh=uzP2BTOvx9B1JqfpE8
        16Vor6uj+jKwcwYjNS21O8AC8=; b=FYGPnO/FLMJCHzB07bHkt0aAdbsjQ/1MSb
        4r1YV0NXhv2JwV0icU++Sj8SYpMKGNtg+FhUnl13sbEVpDpKh3A3J+nKbvH51foL
        lGj+PBCDA/b0a5ty4GpL4H5taxxfwSiCJCteN2ziG9xkd+OnjRAYkfwM91+SNgcx
        ETOJyigDa2Mg60Hu2kHX/9tiTeoT/p11uG9WIDr4sXGvFzhfKST1KDN6ilosjaz2
        0Ix9MzPuuomKO+C3D/v60dAxvwkkClmyh6UlOaHp98+onPdZuAqCQZdxkoPcrq/4
        1AuPzXVfy2ZvoH6QkfbkRftTl2WDvhGeDBrUySD5sXnzN1aKtnVQ==
X-ME-Sender: <xms:P84RY4wwzJwd9ByesmKSVZlRa89Uu_XWD-4wHVjJ0oXPdZfINEZnxw>
    <xme:P84RY8SPlKfNSqG3iEnAIwqsCo18ypP6VskXDQf83IwrluyxYR-CvAhRl5wYR4ah2
    Smnk7I6ZjoVjMMnLSo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeltddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffgeffuddtvdehffefleethfejjeegvdelffejieegueetledvtedtudelgfdu
    gfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:P84RY6Wme0tsYzXkC4FcAPI8cyij5t7MEmFEJJ952DEMkFgGqsaHZA>
    <xmx:P84RY2ieXTYpanCAxPYPK46WfLfrB2cPHlvk9g_TxkpBQhUR6d5G6w>
    <xmx:P84RY6CmUbYZtZ-rPnvDKc1RA3Wg6u452jwFHo7xXRxlqNV69JLhlw>
    <xmx:P84RYyspN20-QlDhOuzLnuGQKZLCzuLNMHFfZBDmlkPU-YQPF3FyXGOXZFc>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7D91FB60083; Fri,  2 Sep 2022 05:34:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <81ed8e35-fa70-4b0e-9601-131c9d0c46d4@www.fastmail.com>
In-Reply-To: <20220831141218.516100-1-krzysztof.kozlowski@linaro.org>
References: <20220831141218.516100-1-krzysztof.kozlowski@linaro.org>
Date:   Fri, 02 Sep 2022 11:34:34 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@somainline.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        arm@kernel.org, soc@kernel.org, "Olof Johansson" <olof@lixom.net>
Subject: Re: [RESEND PATCH] arm64: defconfig: enable newer Qualcomm SoC sound drivers
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

On Wed, Aug 31, 2022, at 4:12 PM, Krzysztof Kozlowski wrote:
> Enable sound support (machine drivers) for Qualcomm SC7180 and SC7280
> SoCs.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>
> Resending because I missed ARM SoC maintainers and Bjorn.

No objections to the patch, but I'm unsure what I'm supposed to
do with it. Is this for Bjorn or me to pick up? Do we need it
as a 6.0 fix or should this wait for 6.1?
