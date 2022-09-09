Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AD75B2D8C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 06:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiIIEhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 00:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiIIEhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 00:37:48 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AE4BC109;
        Thu,  8 Sep 2022 21:37:47 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 1528F5C008C;
        Fri,  9 Sep 2022 00:37:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 09 Sep 2022 00:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1662698264; x=
        1662784664; bh=lgWE+h8k8CPjrHKGGM4gEM/OqNYn4B7ZsXMD/6Q3Clc=; b=Q
        4EauHNXlnQogRYaXMZDBEiUvHbOqsvSyH+2kN6jX6kuF76ebRCeM5dn7acezOCtT
        aXaLebajew5IURbUjL71cuTjpYEq+XBX40t64zzRzdh5Xj+UXgSC/Wuv2s9hmeeT
        GESeAPnIh1XzuLvDcrkoc00lUSRbSmHG0wqK4MGyJLF5UDjCzbWr98pvfaRrdilY
        tEvMVmLcCTSbEsLGab02D+oloIkVe+oLZdCcN8YvxtL3WA8HGBIr5Z0P1JZ+YsXK
        +j2h48YtMSiQMTYRKZKPn0XroJpJq/kIZPq0yjzpyMcp96ZLxrP6c2TQSrQvCU3m
        3PUPrtPksoZdWDUBWAUyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1662698264; x=
        1662784664; bh=lgWE+h8k8CPjrHKGGM4gEM/OqNYn4B7ZsXMD/6Q3Clc=; b=g
        WAJ4iYM2rQ2Z309ZBPWmsXQXNkGVEw/LoPirSvUUQzeD3CyrlRuG2+bD8aOgh2XA
        jE/5Mvhi4D7s6AjHiumU8X0tMRHPP81PgywwB2m1WgX1+qWdmWiD/x1oNQF7Hi6F
        vcvb3/hutsI09mEERtSlDkYhc5p6ig4f/TkL3R/2B9ckIcvKYnvcr5m/+Aa50/et
        hiH5X/VPqnahX4vtJOZCLcLCrwhedtM/D2yN/P0oqjvn1Aixzv1h0BegseMmLq83
        j5RTbXj5T3UK3vbBqAiaHujXSK+R3J+nDAICWqeOcOriFcQSAIFjPaerV2i9PEa6
        Obbp1eVbuVYNq0hAPG67w==
X-ME-Sender: <xms:F8MaY6W0Ro7Kv_m6ezgXQj5c3L3VTZaMMpevDz4xaX2TyLR7G11HcQ>
    <xme:F8MaY2lEeQCgghcj9GY5HMBJiAfSJBfyLy8vmTkcnIzYrdNZFrvCD83epXXdHoO69
    J6Xui7qY64DInHSsA>
X-ME-Received: <xmr:F8MaY-bORD3HcCvwGA6Mijwj4MqCsyt0PVFPpf4glrfEeYWX0l1HKGM6qhP6tdq3I2OZ6N5FwcxidhoG_N3So_IHqg5nANUtLaENO-4SEVoG7L_ZWfwc21D30w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedtgedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefhtdeuhefgueehffegleevieevjeeufeduveefffdvkeehuefh
    feefheelvdekhfenucffohhmrghinhepthifihhtthgvrhdrtghomhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhl
    lhgrnhgurdhorhhg
X-ME-Proxy: <xmx:F8MaYxUoGl08c8YRH0qtyIaslOwHc10ehluUyGI67HUebe-ZAqnE4g>
    <xmx:F8MaY0mzxYnBLmA66DavPynG5l2T0NB4U3E3-l4NNpr2sIcb8PGeNA>
    <xmx:F8MaY2eIc17f3dsO8QzYr7wgnW9CT90Nfis4Xlbx7aftGtkVViU9Wg>
    <xmx:GMMaYymX6xEu2fn8AXMzw4eg6b1jP5WFCtcIiuT-fz9-vjKNrxK83w>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Sep 2022 00:37:42 -0400 (EDT)
Subject: Re: [PATCH 07/12] riscv: dts: allwinner: Add Allwinner D1 Nezha
 devicetree
To:     Conor.Dooley@microchip.com
Cc:     wens@csie.org, jernej.skrabec@gmail.com,
        linux-sunxi@lists.linux.dev, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        Peter Korsgaard <peter@korsgaard.com>,
        Icenowy Zheng <uwu@icenowy.me>
References: <20220815050815.22340-1-samuel@sholland.org>
 <20220815050815.22340-8-samuel@sholland.org>
 <adc4a8e2-7347-7616-99b9-59762023b2ff@microchip.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <8a2194bf-93bd-de4d-8d39-0cd72aabb0a9@sholland.org>
Date:   Thu, 8 Sep 2022 23:37:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <adc4a8e2-7347-7616-99b9-59762023b2ff@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On 8/19/22 5:10 PM, Conor.Dooley@microchip.com wrote:
> Finally got around to giving this a go with the fix for loading
> modules which is mostly what was blocking me before..
> 
> On 15/08/2022 06:08, Samuel Holland wrote:
>> "D1 Nezha" is Allwinner's first-party development board for the D1 SoC.
>> It was shipped with 512M, 1G, or 2G of DDR3. It supports onboard audio,
> 
> I am really not keen on the way you have things, with the memory
> nodes removed from the device tree. I know your preferred flow
> for booting these things might be to pass the dtb up from U-Boot,
> but I think the devicetree in the kernel should be usable in a
> standalone manner, even if that is the barest-minimum memory
> config.

That is simply not possible to guarantee. As an obvious example, consider the
MangoPi MQ-Pro board with socketed DRAM:

https://twitter.com/mangopi_sbc/status/1516225559214583808

But focusing on the /memory node misses the bigger picture. The DTB is passed
through _all_ of the firmware stages, and gets patched by every one of them:

 - SPL/boot0 adds the /memory node with the detected DRAM size.
   If the in-tree DTS has a "minimum memory config" (which for a
   board with socketed DRAM means the smallest possible die), I
   guarantee people will use it and complain about missing DRAM.

 - The SBI implementation reserves memory for itself and any
   possible secure partitions. Right now, booting happens to work
   without the reserved-memory node because the SBI implementation
   is loaded at the beginning of RAM, and Linux ignores RAM below
   the kernel load address.

   However, memory-constrained devices (e.g. D1s) will need to get
   those 2 MiB back by loading the kernel at the start of DRAM and
   SBI at the end of DRAM. Then the reserved-memory node becomes
   quite important.

   It also adds nodes for CPU idle states, since the available
   states and their latencies depend on the SBI implementation.

   It also reserves devices used by it or by a secure partition.
   And it is responsible for extracting data (e.g. MAC addresses)
   from "secure" eFuses which the OS may not have access to.

 - U-Boot adds other information, like boot arguments, the address
   of the initramfs and framebuffer, etc. These are less of a
   concern because of course U-Boot can patch these in to a DTB
   loaded from disk, but they are relevant if you want to load a
   DTB from a later bootloader like GRUB.

If you load a DTB from disk, you lose all of the changes made by the earlier
firmware stages. On ARM, U-Boot tries to work around this by copying a few
specific bits of information from the firmware DTB to the DTB loaded from disk.
But this misses the point that the SBI implementation can modify *any* part of
the DTB. (So in practice U-Boot on ARM already loses CPU idle states and
reserved memory nodes that were added by the PSCI implementation.)

As an extreme example, consider paravirtualization, where only a small subset of
DRAM and peripherals may be made available to any one OS partition.

Fundamentally, I reserve the right to make arbitrary changes to the DTB in the
SBI implementation, and thus I cannot condone using the DTBs generated from the
Linux source tree for any purpose other than validation.

Regards,
Samuel
