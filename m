Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53710591737
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 00:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbiHLWTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 18:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbiHLWTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 18:19:17 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE41B56DD;
        Fri, 12 Aug 2022 15:19:16 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 13666320090B;
        Fri, 12 Aug 2022 18:19:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 12 Aug 2022 18:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1660342751; x=
        1660429151; bh=NVr5DzIN9NKJQUZlYZVN75R1jb8BrZu1TnV/2szNqjE=; b=m
        I5vUYZij+qXU/ROI+66uPkBL619Mef1RJBFZ+3rmE4kOSiCWpAi00+Q6sZh9VHvW
        qou+IMBWADBUCAKpyWsMEP7l2I1bD3ZusX7EzqZW1ynrre7TCK9LK+Nt1g97hv2B
        RjtvFUEj33b4MN5F/PJpHbFtNQc2x5/rK+B0VlhYVJfRK/OVArMRzrs9lMF4ZWBz
        krH23CWJkFVxh7fzNa75Y8EvnXMYbC52XoH6oRpZf4JRU6QXexBAmBxWH1/jLfi7
        ROdEARNOtsYwm8vCIkFqxw6kk6A51nIG9/o+JOBEAxy5Vg6SkMB4RGkpZUro2W2m
        /6ovzConFN92Jx94AHcQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660342751; x=
        1660429151; bh=NVr5DzIN9NKJQUZlYZVN75R1jb8BrZu1TnV/2szNqjE=; b=3
        w2I2KtneyJRrNU/zU6nBp2HhOXWu2ohfygEjjVkPQ13+u7lCFfZSjbs015YnDvMd
        CUbjdaDO+KA4sc1Q1pgzBpLrGX4BNT5CJGymH6FrrcSHdtWD+qWDeq/2N1sEFIOZ
        n3aZ8c4D3bC48TpgJQMExeNpZsf1/Fb/B8t0eGaGZOJo1kVhasXKYCqIAaL1favL
        Ilej5dQPIAHs5L4mzv5Icf+beYBok/3urMO0N2pIOnYBcHD5xNGl+5kpaTQyZJ9I
        ngKLUscSiXnSe8jva6HP4cVGx818dfZGGHHbhEN6l9nsE2rEfbxHzd+PkSZMaF33
        rlyTHMgmILospVnGZXfyQ==
X-ME-Sender: <xms:3tH2Yncjry_pDlR5oP1yGLk1Ps59m1m5YugvR3AGnHaK8iNEr2BJeg>
    <xme:3tH2YtMfGdOOLYv3P0nF_UkMQXZMafbD86E65beOWJYwtUKWsjmi089YXMPNNDrHQ
    J4aG0Wbyhprsq90NQ>
X-ME-Received: <xmr:3tH2Ygh3Lrzmpqax50VdLw-8ZNdfayoD5O8KIacFCmNyN0MerbMBzqUcj6kx6h5HFZFQXPYY3BcAIm2lfVfV8ll4z1dAB88-eGg-cuQoYcgPPYYZlLBPkLD6NQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegjedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefftdevkedvgeekueeutefgteffieelvedukeeuhfehledvhfei
    tdehudfhudehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:3tH2Yo9K_c6QrdiWmmZVkCK52HZaXRFSfHMIFcP5kemqa43LN69x3g>
    <xmx:3tH2Yjv97Kxp0a_cp9bEDaQjLT208DtQ2wvXTuBJ_lRKDr4up83Bvg>
    <xmx:3tH2YnFwtan-9303L_NzLLViZLKHOlFngP9HgzbI4rSCJ4aVYXPThw>
    <xmx:39H2YjFT5MFvRIsHyQBkGpvfvyygQeSFHRwAbrLugi7MP2STqKGiYA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Aug 2022 18:19:10 -0400 (EDT)
Subject: Re: [PATCH 1/8] dt-bindings: sun6i-a31-mipi-dphy: Add the interrupts
 property
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <20220812075603.59375-1-samuel@sholland.org>
 <20220812075603.59375-2-samuel@sholland.org>
 <c85ec3a3-fa6e-aa71-a847-22062b9683e9@linaro.org>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <0d2bf232-8aa6-2dc1-121d-f0439bfd7b54@sholland.org>
Date:   Fri, 12 Aug 2022 17:19:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <c85ec3a3-fa6e-aa71-a847-22062b9683e9@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/22 5:45 AM, Krzysztof Kozlowski wrote:
> On 12/08/2022 10:55, Samuel Holland wrote:
>> The sun6i DPHY can generate several interrupts, mostly for reporting
>> error conditions, but also for detecting BTA and UPLS sequences.
>> Document this capability in order to accurately describe the hardware.
>>
>> The DPHY has no interrupt number provided in the vendor documentation
>> because its interrupt line is shared with the DSI controller.
>>
>> Fixes: c25b84c00826 ("dt-bindings: display: Convert Allwinner DSI to a schema")
> 
> I don't understand what is being fixed in that commit. That commit did
> not have interrupts in D-PHY, so what was broken by it?
> 
> The Fixes tag annotates the commit which introduced a bug.

The binding had a bug because it did not accurately describe the hardware. If
you don't think this warrants a Fixes tag, I can remove it. Or are you
suggesting that the Fixes tag should instead reference the commit adding the
original .txt binding?

Regards,
Samuel
