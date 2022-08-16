Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31F2595368
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbiHPHHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiHPHH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:07:27 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2D7125D4D;
        Mon, 15 Aug 2022 19:42:15 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 6C16E32006F5;
        Mon, 15 Aug 2022 22:42:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 15 Aug 2022 22:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1660617729; x=
        1660704129; bh=HaNW5dTGTh6zJmCxeaRGccdi0HcEeWElpDsk1nTJqRI=; b=t
        O3umcuiU77ia+LxIcGxlsoBkD7xGUydhdJ15OVQ8IJk9/9QnSs6Nw4VOHLJvQZPR
        Ca1LbWEeCaqVL2cKflNzJaTwpFPgJEqXlAmZ2T6VBtQD6Yr37epnef8pxbcXYlvW
        N+5zRAps2D9YmYCHJxmyjgvszqrWn0AYMVHhKNPANOYg1IV4dvYgouGLe+vwgl5e
        rrYL2n3bnJgPrD3fgSj6c8U7+KftUG8ATZfp86bgdH8fJ0zvZQDRu4A/LdJzCh3Z
        uq7KzhuzOoGpxprxU+n2WwFfyjR8y08ICKbOgOGeDL+Es3zqUy0I7fqSS5SMTu3O
        cT5VlqGObjDw605UnpXyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660617729; x=
        1660704129; bh=HaNW5dTGTh6zJmCxeaRGccdi0HcEeWElpDsk1nTJqRI=; b=D
        pBGByD80wJUgFGnrCdO0dVRLJ7XXMteN7lEhuAw8XdBCtKAdlFlI/MdiBGdK3YI3
        SxubzMPY0N8bSAPjjfYi3ndKcjo9C4eeGDAyKvSMmphrrHQb8XMitiNTNhBbTI9Q
        uONwdbhGXDhEV1pdB8Gb6n2tXqxzHSaOBABa3z2uZYPlwo/pXqO8V+riWzLnETnO
        dzyZkMx9RaJGtrk0sRqpeLCehCs64PSxExpZ+spgWbT0Fyh6QOKkAXj2V6EO0eL7
        BZoFKE9czxotQfQg/WJIazwYjK8fkK6ZVvVa7ULKQdrs95sQ5uOWxqcGHijHbNvR
        N/forPXnfLqWuj/R5IX2g==
X-ME-Sender: <xms:AQT7YgPH9943MR27JtlDLBMQ1UDWv047NevytleYTJvMF2n4a1I9-A>
    <xme:AQT7Ym-KBuVqpclJKq1G-J0IMAKHEuQ6tmR4qAdEgb9RiweiBQIlCmPzKTYZGrNzY
    tKAJTDiCTh44ADd_g>
X-ME-Received: <xmr:AQT7YnQD3TuKms4VX3_s7lvp7z8BjA6ZAq4wP1Dq_F1qJqgmtQujYSv8MZOY2rJBUF7_XWg0GrRH-2pVBgiffAeEAdxhH1X2clArD9SXWfbpDmcjYE9FkRQDVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehfedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefuvfevfhfhkffffgggjggtgfesth
    ekredttdefjeenucfhrhhomhepufgrmhhuvghlucfjohhllhgrnhguuceoshgrmhhuvghl
    sehshhholhhlrghnugdrohhrgheqnecuggftrfgrthhtvghrnhepjeelfedutdeggeevvd
    ekheefjeefvefgfeeiffefgeduieeutdehkeejleegueejnecuffhomhgrihhnpehkvghr
    nhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:AQT7YoscCBqM9HQ9Yup77uhI-lPB4SA5oRa0GwitHz5blQu4F_fpJg>
    <xmx:AQT7YofNgHWbEhKUo6Q17YMlIynT7IQXQLpYbhxVchQ_K0jSM441vA>
    <xmx:AQT7Ys1o2cu0k8uFmGdfJrpCjLqalFsZA60oI0oGL2RajLzD0iQhgw>
    <xmx:AQT7YpXP4SgluZnONeW9Hylpj8Z5FhmZ0jq6Vt-1cLdxys3KCAl3kA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 22:42:08 -0400 (EDT)
Subject: Re: [PATCH 00/12] riscv: Allwinner D1 platform support
To:     Conor.Dooley@microchip.com, wens@csie.org,
        jernej.skrabec@gmail.com, linux-sunxi@lists.linux.dev,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-kernel@vger.kernel.org
References: <20220815050815.22340-1-samuel@sholland.org>
 <50dc816c-3129-f5aa-9777-99c6f0fa58f1@microchip.com>
 <6b8cd27d-5671-7bcb-549d-e903cf019fe3@microchip.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <6d54da3f-d4fc-7c40-38d6-4f02c7346458@sholland.org>
Date:   Mon, 15 Aug 2022 21:42:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <6b8cd27d-5671-7bcb-549d-e903cf019fe3@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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

On 8/15/22 12:12 PM, Conor.Dooley@microchip.com wrote:
> On 15/08/2022 08:05, Conor Dooley wrote:
>> Hey Samuel,
>> Apologies for the last email, the first 5 patches in this series
>> didn't correctly land in my inbox and I skimmed & replied to the
>> wrong cover letter... I blame it being pre 8 AM ;)
>>
>> On 15/08/2022 06:08, Samuel Holland wrote:
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>
>>> This series adds the Kconfig/defconfig plumbing and devicetrees for a
>>> range of Allwinner D1-based boards. Many features are already enabled,
>>> including USB, Ethernet, and WiFi.
>>>
>>> The SoC devicetree uses bindings from the following series which have
>>> not yet been merged:
>>> - SRAM controller:
>>>    https://lore.kernel.org/lkml/20220815041248.53268-1-samuel@sholland.org/
>>> - NVMEM cell bits property change:
>>>    https://lore.kernel.org/lkml/20220814173656.11856-1-samuel@sholland.org/
>>> - In-package LDO regulators:
>>>    https://lore.kernel.org/lkml/20220815043436.20170-1-samuel@sholland.org/
>>>
>>> All three of these are required to set the correct I/O domain voltages
>>> in the pin controller, which I would consider important to have in the
>>> initial version of the devicetree.
>>>
>>> The SoC devicetree does contain one small hack to avoid a dependency on
>>> the audio codec binding, since that is not ready yet: the codec node
>>> uses a bare "simple-mfd", "syscon" compatible.
>>
>>
>> I tried this series on top of both 6.0-rc1 & next, but I saw a shed
>> load of errors from dtbs_check. I'll take a look at the rest of the
>> series later on, but just FYI. This time I did at least read the
>> right cover letter and actually applied your dependent series..
>> /facepalm
>>
>> I have been trying to get riscv down to 0 warnings and would not be
>> in favour of accepting patches that go in the other direction.
>> (This patchset currently produces about 47 new warnings)

Only 4 unique ones :)

Thanks for checking this. I had done a couple of passes cleaning things up. The
remaining warnings are the ones I was unsure how to fix.

> FWIW this is what I see, LMK if I am missing something.
> allwinner/sun20i-d1-lichee-rv.dtb: i2c@2502000: Unevaluated properties are not allowed ('dma-names', 'dmas' were unexpected)

This one is new with dt-schema 2022.08.1 (I was previously on d1f3102e locally).
I'm not sure if it is a bug in the binding or in the dt-schema tool. The
warnings go away if I do:

--- a/Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml
@@ -72,6 +72,7 @@ required:
   - interrupts

 allOf:
+  - $ref: /schemas/dma/dma.yaml#
   - $ref: /schemas/i2c/i2c-controller.yaml#
   - if:
       properties:

But I wouldn't expect this to be necessary, since dma.yaml has "select: true".
Compare the this with the UARTs. Neither serial/snps-dw-apb-uart.yaml nor
serial/serial.yaml references any DMA properties, yet there is no warning for those.

> allwinner/sun20i-d1-clockworkpi-v3.14.dtb: pmic@34: compatible: 'oneOf' conditional failed, one must be fixed:
> allwinner/sun20i-d1-devterm-v3.14.dtb: pmic@34: compatible: 'oneOf' conditional failed, one must be fixed:

The new compatible is in linux-next. I can add it to the cover letter for v2:
https://lore.kernel.org/linux-devicetree/20220810013430.27061-1-samuel@sholland.org/
https://git.kernel.org/lee/mfd/c/97ecda0f615e

> allwinner/sun20i-d1-lichee-rv.dtb: ethernet@4500000: Unevaluated properties are not allowed ('mdio', 'reset-names', 'resets' were unexpected)

This showed up with a dt-schema update in the last year or so. This may be a bug
in the binding? allwinner,sun8i-a83t-emac.yaml picks up these three properties
from snps,dwmac.yaml, but does not have them in its own "properties" block.
(resets and reset-names are even in "required"!)

> allwinner/sun20i-d1-lichee-rv-86-panel-720p.dtb: ethernet@4500000: Unevaluated properties are not allowed ('phy-supply' was unexpected)
> allwinner/sun20i-d1-dongshan-nezha-stu.dtb: ethernet@4500000: Unevaluated properties are not allowed ('phy-supply' was unexpected)

I think this one is just flat out missing from the binding. It is present in the
other two Allwinner Ethernet MAC bindings, but not this one.

Regards,
Samuel
