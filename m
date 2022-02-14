Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A30E4B4186
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 06:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240581AbiBNFyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 00:54:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbiBNFyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 00:54:19 -0500
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724F95005C;
        Sun, 13 Feb 2022 21:54:12 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id C8E14580250;
        Mon, 14 Feb 2022 00:54:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 14 Feb 2022 00:54:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=7G1lu+Rs8krLJ/
        ey20PWYfJYeLvb+/uRN91S0nKBhFA=; b=zJHdmFpN/e/OJdqwKifAMyFVTpteDm
        Okgo/yjwGIcpIo3hy4N2PRAolI2CJWLdxdobtD6LAUfY7NAgxy63NcyNJJSu49gv
        220erR8Q6vPwDG3K5oIzw4Hi75qhds8OG4BE6+EMMU9SO4y4sGyjxnvlE6QIC1oN
        Rcmcc7KdBcUqHDphMWsnzYiCCPFsWdXZdufoDgE6jfwIzgrB3kbsdbWJlaz+1Dnp
        fL8tst1uzkVNYFPsdsi6fZqmLQIhHmcRnm2TidDbdPks9ENOGt5yD0qwDGR22aAv
        UG9EBDFHwBBWZwZLqjSYEY4TLcq0B+uU7W48akP8N5CQoLyUzu7lfEQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=7G1lu+Rs8krLJ/ey20PWYfJYeLvb+/uRN91S0nKBh
        FA=; b=Cvwydq+wnq3Hzm9BrFnHlgK86hB8Cl7f6wb90EbKyok6ldYahY5HCKYI+
        mocig9T8pQ2IRMMcHgkm2Drt3c4BYugPmw++Ykm2o2/7UN7o2KPD8eruLmrQ2nUQ
        vGvsJV4fr/0jLpwwgSrit13XJpRmwe9dwcNmfl7nm65Wzi21psfwJTbApOSxLVwz
        q9QQg84BiawRIAykblueIWmrBUVYGZx/NjGUI494P1pDVbRmrY6P+sQaJ8GdK5Ve
        X0Aeu3f3w4QN3WnVfisqQa3nAAjdDChHUJfGzxj2i9efa9DtInCzGgiAbrLEMTsz
        QXWyfdQvdf6LqOkSiup8EyaC8URLA==
X-ME-Sender: <xms:gO4JYmVkUDIw-TmSNyP-uYrXQEZ6sa0sdLzpahEl7nXqN14QFZo6Iw>
    <xme:gO4JYimZfxFsyYrfHs8oiKFrAOI-7j4u1Mq0Fo2Oep80VlWDmBQFGDC_GJJf0yvpc
    FbebeRHiWu8NVSWlvE>
X-ME-Received: <xmr:gO4JYqZkG85YzKfCyoeGZMjP1arMjHFNWzWGiI7OuEOyj1ZJKNTPVvp4h2WXFLs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjedugdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfhfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeflihgrgihu
    nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
    ftrfgrthhtvghrnhepheeiuddvvefhkeejfedttdekieethfdukedvieeuueelgfelieej
    geehvdekudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:gO4JYtVqAmCKxJ13watKGjz3LW7X3ztU7BHdcrEWYxiyb55YoGiQzA>
    <xmx:gO4JYgmfonsGJ1mZwsQEqAfYdIri49t64ViQ7dnBz9Lzc_tVhQavNQ>
    <xmx:gO4JYidpUqqJo-QziOaNhambD0tDI1XwUwhcr0NN1ue335KMVor7HQ>
    <xmx:ge4JYqFR_fLxkl3mGl74OWIpn5adHaquvTV4RpEQpXATbx5ytSAnVQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Feb 2022 00:54:05 -0500 (EST)
Message-ID: <380d93a4-6f36-00d2-6cd3-e4428534cbb1@flygoat.com>
Date:   Mon, 14 Feb 2022 05:54:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v7 0/7] drm/lsdc: add drm driver for loongson display
 controller
To:     Sui Jingfeng <15330273260@189.cn>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "David S . Miller" <davem@davemloft.net>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Qing Zhang <zhangqing@loongson.cn>, Li Yi <liyi@loongson.cn>,
        suijingfeng <suijingfeng@loongson.cn>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20220213141649.1115987-1-15330273260@189.cn>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20220213141649.1115987-1-15330273260@189.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/2/13 14:16, Sui Jingfeng 写道:
> There is a display controller in loongson's LS2K1000 SoC and LS7A1000
> bridge chip, the DC is a PCI device in those chips. It has two display
> pipes but with only one hardware cursor. Each way has a DVO interface
> which provide RGB888 signals, vertical & horizontal synchronisations,
> data enable and the pixel clock. Each CRTC is able to scanout from
> 1920x1080 resolution at 60Hz. The maxmium resolution is 2048x2048
> according to the hardware spec.

Hi Jiangfeng,

I see you added dts for those boards, but I didn't see you wire up them
in Makefile and code? How can you use them in present systems?

I guess to make those dts work for general all-in-one kernel, what you
need to do is, for example Lemota A1901:

1. Add __dtb_lemote_a1901 to builtin_dtbs.h

2. Wire up with something like:

if (!strcmp("LEMOTE-/LS3A4000/-7A1000-1w-V01-pc", eboard->name)
     loongson_fdt_blob = __dtb_lemote_a1901

In arch/mips/loongson64/env.c.

Thanks.
- Jiaxun
