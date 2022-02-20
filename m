Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FCE4BD094
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 19:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244495AbiBTSSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 13:18:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242648AbiBTSSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 13:18:45 -0500
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6C8427D1;
        Sun, 20 Feb 2022 10:18:23 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 376C45801BE;
        Sun, 20 Feb 2022 13:18:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 20 Feb 2022 13:18:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=liWN/E4xK+rlUO
        0QnIzJpz65TbThjTDzor1pWEPiuWU=; b=mracQp4azr1fcGJFjPZCraQEJultUg
        jE7YEze00c0S0dV6JmgiJ0eTjI75yEPxiEjojlgJfEeXgTUjEkuQVCWlM9BqJ9P4
        szLi5VApIzLNYhJlLi7BP1OjmmBSEjbYz7QVnrdX4AWxm5bwRRTeSRV5hF1VeDNU
        wTx/h/w5VIm/Y8eqwrjan/5c5xhaBl6ndEHBHhwoJR1zblbYvmVwhmXnuC4Vbym1
        +vZJwm0WhR7UVIT2ImaArpZUyFgOSQ+yGiMoI2mgybiNfn9d3RDJ3kULXGUDu94u
        gQR5HLj+SdQXNFHnEgVgNthrWrMSd9A3yZJuUO03nkUDKp3yx0Zd15ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=liWN/E4xK+rlUO0QnIzJpz65TbThjTDzor1pWEPiu
        WU=; b=d+8cPWBnFL8Yz3NgYFPItn4S3AFEdPiy9gghRogx+eJO34QxVmyeEvv0I
        rjvBQ6eSC7F3pKjv3+RPPjk5V/ujl5XVSO3xbMpiyAqxv90Pbws7xGQXop5jcqwv
        iFcZbRwAfMSjR/70leWMV/rup4hVhFJ8miW4pSFo7z99dQhZIsB+HSnAy4+Khp0Q
        zBa43ZkSASi624VNAlD0gYTp+uDS00TiRD8Cf1ycxaSsPfg9/vMYGguEwIPD5QGT
        1vcAvDzD43NM0BCitNTLIhVrLYUJjTtNy3bOlNEsCKRptZKTnCrBi7hdFOtH2p56
        o4vF4CzfR77FBbVIyKG4esCgveLKw==
X-ME-Sender: <xms:6oUSYmWDsQHGR0rJ6xAyEvUjvgG-IB6EJryZpjOPXF-AfQJ07nVLlg>
    <xme:6oUSYinMszPlKKZ8ewylic5XHfaCMWYf91pxrgi7P5sl2OCiI5wH2WEkGPYcuHtbo
    J1nH0vLrwyKo5WO1Cw>
X-ME-Received: <xmr:6oUSYqYbJ0jtlE___cswy9vv_UI-dq26wk-MmAI2KYpD7-tOA6tnP9eFUA2s6S0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeeggdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvfhfhjggtgfesthekredttdefjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeehieduvdevhfekjeeftddtkeeitefhudekvdeiueeulefgleei
    jeeghedvkeduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:6oUSYtVVaZECgZ8snVnbNafx4qpbtAM4ZQ4UZljTIKU8sddKAXZtBg>
    <xmx:6oUSYgmulp_PVDJWosZziuQH-wLnzHP5M6TSUAyMfBXh8zWJ__1A4Q>
    <xmx:6oUSYifMthJ7Jv88REhrV6ATVCRqlVlN_FfZINnjUdggzQzsAh8F7A>
    <xmx:7IUSYiU0LZt7osj-SlxZS0GZfWhFWkFUURqJy-QjWRkraTT0BpoY1g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Feb 2022 13:18:15 -0500 (EST)
Message-ID: <a865b770-126e-a7c0-48bb-4f072b8dc5bd@flygoat.com>
Date:   Sun, 20 Feb 2022 18:18:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v10 1/4] MIPS: Loongson64: dts: update the display
 controller device node
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
        Qing Zhang <zhangqing@loongson.cn>,
        suijingfeng <suijingfeng@loongson.cn>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20220220145554.117854-1-15330273260@189.cn>
 <20220220145554.117854-2-15330273260@189.cn>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20220220145554.117854-2-15330273260@189.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/2/20 14:55, Sui Jingfeng 写道:
> From: suijingfeng <suijingfeng@loongson.cn>
>
> The display controller is a pci device, its PCI vendor id is 0x0014
> its PCI device id is 0x7a06.
>
> 1) In order to let the driver to know which chip the DC is contained
>     in, the compatible string of the display controller is updated
>     according to the chip's name.
>
> 2) Add display controller device node for ls2k1000 SoC
>
> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
^ The usage of Reported-by flag seems wired here.
In most case we use it to credit people who find a bug that is already 
in-tree.
Reviewing effort is already credited by Reviewed-by flag.

If you intend to let maintainers track their suggestions easier, the common
practice is to append suggester's name after each entry of changelog
between versions.

Thanks.

> Signed-off-by: suijingfeng <suijingfeng@loongson.cn>
> Signed-off-by: Sui Jingfeng <15330273260@189.cn>
> ---
>   arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi | 8 ++++++++
>   arch/mips/boot/dts/loongson/ls7a-pch.dtsi          | 7 ++-----
>   2 files changed, 10 insertions(+), 5 deletions(-)
>
[...]
- Jiaxun
