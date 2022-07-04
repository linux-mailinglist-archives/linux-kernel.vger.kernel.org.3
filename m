Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57240565D93
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 20:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbiGDSo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 14:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbiGDSo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 14:44:26 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B640DEC3;
        Mon,  4 Jul 2022 11:44:24 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id CE35F5C009A;
        Mon,  4 Jul 2022 14:44:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 04 Jul 2022 14:44:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1656960261; x=
        1657046661; bh=Y7/0H0LtknpulWBJ0EkEICLOIKb2956OYsLyqEUrSq8=; b=P
        aFA4+bMTXrw+1SmXFiiMpHk5KFam5nqstIeP4IAw5hnXU0I8v33cebVC+4Scg4mZ
        6Wa0TM1pYgyQadTbnxOUUMYMKCPQN6paDu76MbZx7/h6xlgsYwPGXc/vDM4Bfl1v
        iPJU8Ty60ZIvFMGH61oYrjpSG80hirOvs1kBqfO8RbxXI17+kSkkWnP7ksSF+LAD
        jXj+XOy79TEswWa7ZBlAI3ahnKRBLHCLf5lOr6sHpV8NUjFm08C7SJ5X9WC1yw2R
        mP1VTjkcl7rau4sU15oQnaDSOXczCRtOwWu0BVOQoD6urzUNq5HwB8vhGX9HvqaX
        tKVZOvoEJFlB12Q2yMkzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656960261; x=
        1657046661; bh=Y7/0H0LtknpulWBJ0EkEICLOIKb2956OYsLyqEUrSq8=; b=B
        7OcMqbGALJcj9hAgYWibtk0M/RiYJ8B5WBBAouhFygxb16C5nA6lzTzuSmprlQMu
        FF/Kl1VUhu7ryXeBDxQ6pwXrzwDCiFQHytIXuAR5TvtqUC6dLvbGm1QXUa4cZfBE
        H+moKqyJffAffajUB1q+pNmsXkghC9BbQmH2xHFy7MSTE6rKk+3el1F5O4jABDtp
        HBKbGfdrrKGf6alHVOwGSEZDEtRhPtDl/TPbr0fcekgGKv+2JvyImUuiDsgfYu0r
        5JGo6Fwfhe7CEV8PB8CwcQA1eRU5vNumao5LjCJgfzHJ5cxPNlRuJ5KOtcjC8FHt
        3VRug/X7jzxK7lAjhF29Q==
X-ME-Sender: <xms:BTXDYugnh0ckU8YWq1Bz1PCZE-JPfGKle5rSJeXyRbLg4DaO2UmWgA>
    <xme:BTXDYvCJPCQ0jIEb2YhKJQNgWQ4oVvTyU4hfPk6_DSS7FmVXDmVYOfuUmTRoYF1N8
    MCLLVUbx4X23dAdPg>
X-ME-Received: <xmr:BTXDYmGzVBLNNcLOTtN-XNFPBxOpTdZZimONkRszcdK9CUPrECEmlnKB8A5pfBqVcyJYBNcex0KVJoUxP82iv0eefL3t20rY1--uUn2n2F8qPB134jfQo56gxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehledgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuvfevfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepufgr
    mhhuvghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqne
    cuggftrfgrthhtvghrnheptdevhfehhefgvdekteffleduueduheduuedvtdevleelkeev
    vdeuvdeihfekueehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:BTXDYnTyiKefvrWVuxeUfBBO9XViXGn3638bqiqpr5Lzvvc9axY44Q>
    <xmx:BTXDYrw3V7bNZDrx2xxPpYplGm08Ese4LFWCp-p40My1W513qcae6Q>
    <xmx:BTXDYl4_bOl3HLpOhu8nhFtLn4QY0Cmh6XqxdUXKWEbRBVu4wi86Fg>
    <xmx:BTXDYik2izDsmPxEpJmzihWal4unPwOnKBsa-KPrCOOF0qZZxOx99w>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Jul 2022 14:44:20 -0400 (EDT)
Subject: Re: [PATCH v11 3/6] arm64: dts: allwinner: Add Allwinner H616 .dtsi
 file
To:     Andre Przywara <andre.przywara@arm.com>,
        =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220428230933.15262-1-andre.przywara@arm.com>
 <3165164.aeNJFYEL58@kista> <20220630010410.38fc117f@slackpad.lan>
 <2985997.CbtlEUcBR6@jernej-laptop>
 <20220704143057.76163208@donnerap.cambridge.arm.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <3063662c-8d1c-e767-b30b-83d1c4820108@sholland.org>
Date:   Mon, 4 Jul 2022 13:44:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220704143057.76163208@donnerap.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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

Hi Andre,

On 7/4/22 8:30 AM, Andre Przywara wrote:
> On Sat, 02 Jul 2022 23:16:53 +0200
> Jernej Škrabec <jernej.skrabec@gmail.com> wrote:
>> Dne četrtek, 30. junij 2022 ob 02:04:10 CEST je Andre Przywara napisal(a):
>>> On Tue, 03 May 2022 21:05:11 +0200
>>> Jernej Škrabec <jernej.skrabec@gmail.com> wrote:
>>>> Dne petek, 29. april 2022 ob 01:09:30 CEST je Andre Przywara napisal(a):  
>>>>> This (relatively) new SoC is similar to the H6, but drops the (broken)
>>>>> PCIe support and the USB 3.0 controller. It also gets the management
>>>>> controller removed, which in turn removes *some*, but not all of the
>>>>> devices formerly dedicated to the ARISC (CPUS).
>>>>> And while there is still the extra sunxi interrupt controller, the
>>>>> package lacks the corresponding NMI pin, so no interrupts for the PMIC.
>>>>>
>>>>> The reserved memory node is actually handled by Trusted Firmware now,
>>>>> but U-Boot fails to propagate this to a separately loaded DTB, so we
>>>>> keep it in here for now, until U-Boot learns to do this properly.
>>>>>
>>>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>>>> ---
>>>>>
>>>>>  .../arm64/boot/dts/allwinner/sun50i-h616.dtsi | 574 ++++++++++++++++++
>>>>>  1 file changed, 574 insertions(+)
>>>>>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
>>>>> b/arch/arm64/  
>>>>
>>>> boot/dts/allwinner/sun50i-h616.dtsi
>>>>   
>>>>> new file mode 100644
>>>>> index 000000000000..cc06cdd15ba5
>>>>> --- /dev/null
>>>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
>>>>> @@ -0,0 +1,574 @@
>>>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>>>> +// Copyright (C) 2020 Arm Ltd.
>>>>> +// based on the H6 dtsi, which is:
>>>>> +//   Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
>>>>> +
>>>>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>>>> +#include <dt-bindings/clock/sun50i-h616-ccu.h>
>>>>> +#include <dt-bindings/clock/sun50i-h6-r-ccu.h>
>>>>> +#include <dt-bindings/reset/sun50i-h616-ccu.h>
>>>>> +#include <dt-bindings/reset/sun50i-h6-r-ccu.h>
>>>>> +
>>>>> +/ {
>>>>> +	interrupt-parent = <&gic>;
>>>>> +	#address-cells = <2>;
>>>>> +	#size-cells = <2>;
>>>>> +
>>>>> +	cpus {
>>>>> +		#address-cells = <1>;
>>>>> +		#size-cells = <0>;
>>>>> +
>>>>> +		cpu0: cpu@0 {
>>>>> +			compatible = "arm,cortex-a53";
>>>>> +			device_type = "cpu";
>>>>> +			reg = <0>;
>>>>> +			enable-method = "psci";
>>>>> +			clocks = <&ccu CLK_CPUX>;
>>>>> +		};
>>>>> +
>>>>> +		cpu1: cpu@1 {
>>>>> +			compatible = "arm,cortex-a53";
>>>>> +			device_type = "cpu";
>>>>> +			reg = <1>;
>>>>> +			enable-method = "psci";
>>>>> +			clocks = <&ccu CLK_CPUX>;
>>>>> +		};
>>>>> +
>>>>> +		cpu2: cpu@2 {
>>>>> +			compatible = "arm,cortex-a53";
>>>>> +			device_type = "cpu";
>>>>> +			reg = <2>;
>>>>> +			enable-method = "psci";
>>>>> +			clocks = <&ccu CLK_CPUX>;
>>>>> +		};
>>>>> +
>>>>> +		cpu3: cpu@3 {
>>>>> +			compatible = "arm,cortex-a53";
>>>>> +			device_type = "cpu";
>>>>> +			reg = <3>;
>>>>> +			enable-method = "psci";
>>>>> +			clocks = <&ccu CLK_CPUX>;
>>>>> +		};
>>>>> +	};
>>>>> +
>>>>> +	reserved-memory {
>>>>> +		#address-cells = <2>;
>>>>> +		#size-cells = <2>;
>>>>> +		ranges;
>>>>> +
>>>>> +		/* 512KiB reserved for ARM Trusted Firmware (BL31) */
>>>>> +		secmon_reserved: secmon@40000000 {
>>>>> +			reg = <0x0 0x40000000 0x0 0x80000>;
>>>>> +			no-map;
>>>>> +		};
>>>>> +	};  
>>>>
>>>> I'm not a fan of above. If anything changes in future in BL31, U-Boot
>>>> would
>>>> need to reconfigure it anyway. Can we just skip it?  
>>>
>>> I am not a fan neither, but last time I checked this is needed to boot.
>>> Indeed TF-A inserts this node, with the right values, into U-Boot's DT.
>>> And that's nicely preserved if you use that DT ($fdtcontroladdr) for
>>> the kernel as well.
>>> But if someone *loads* a DTB into U-Boot (to $fdt_addr_r), then
>>> U-Boot fails to propagate the /reserved-memory node into that copy.
>>> There does not seem to be a global notion of reserved memory in U-Boot.
>>> Some commands (like tftp) explicitly parse the control DT to find and
>>> respect reserved memory regions. bootm does that also, but only to
>>> avoid placing the ramdisk or DTB into reserved memory. The information
>>> ends up in images->lmb, but is not used to generate or amend nodes in
>>> the target DT.
>>> So the bits and pieces are there, but it will require some code to be
>>> added to the generic U-Boot code.
>>>
>>> So what do you think? Leaving this out will prevent loading DTBs into
>>> U-Boot, at the moment, which sounds bad. I suggest we keep it in, for
>>> now, it should not really hurt. U-Boot will hopefully start to do the
>>> right thing soon, then we can either phase it out here (maybe when we
>>> actually change something in TF-A), or let U-Boot fix it.  
>>
>> TBH, if "soon" is really soon, I would rather wait with H616 DT until U-Boot 
>> supports carrying over reserved memory nodes.
> 
> But this also carries compatibility issues. U-Boot support the H616 for
> more than a year now, and the earliest possible U-Boot release having that
> propagation code would be the one released in October. And then people
> would still need to update first, so that's quite some months out.
> And I was actually hoping to get at least the H616 DT patches off my
> plate, and get them into the tree to have a stable and agreed upon base
> (before this series turns into a teenager ;-)
> Then we could for instance update the U-Boot H616 support.

There is no compatibility issue here if people are using $fdtcontroladdr.

>> Whatever we do now, it will have 
>> compatibility issues. If we introduce reserved memory node now, we can't 
>> easily drop it later. Bootloaders are not very often updated, but kernels and 
>> DTB files are, at least in my experience. So when we decide to drop the node?
> 
> I think of the three possibilities:
> - Drop the node now, and ask people to not load DTBs explicitly

This is my preferred solution. My position has always been that the devicetree
is provided by platform firmware, not the OS. The only reason for even
submitting the devicetree to Linux is because that is the location of the
bindings and validation tooling.

I have been using this approach for D1, and so far there have been no unsolvable
problems. Yes, most image builders assume you want to load a DTB from disk, but
teaching them not to do that is fairly simple. And yes, it means we have to do
better about keeping the U-Boot DTSs in sync, but I think we can manage that.

> - Drop the node when U-Boot learned to propagate the reservation
> - Keep the node
> the last one is the least painful: having this node in does not really
> hurt, so we can be very relaxed with this removal decision:

Supporting explicitly-loaded DTBs is the most painful option going forward,
because that means U-Boot has to know about and propagate _every_ runtime change
made by any firmware component (not just changes made by it) to the control FDT.

For example, consider TF-A patching in information about idle states, or SID
contents in secure mode, or marking nodes as "reserved" because it delegates
those devices to a secure enclave. This problem is solved if we say "we support
$fdtcontroladdr, and we support overlays; but you are on your own if you load a
DTB from disk."

Distros will continue loading DTBs from disk as long as it sorta-kinda-mostly
works, and then years later users will complain that their phone uses 4 watts at
idle, because their explicitly-loaded DTB contained idle states that their
firmware did not support (this is a true story).

"Don't load DTBs" is a much easier story to tell if doing so is obviously broken
out of the box from day 1.

Regards,
Samuel

> - If U-Boot does not add the reserved node, we are covered.
> - If U-Boot adds the node, it will do so in a way where it deals with
> existing reservations. So either it doesn't actually change anything, or
> it extends the reservation.
> - Should the TF-A location actually move (and we have no plans or needs to
> do that), people would only get this by updating the firmware, at which
> point the U-Boot part would surely be in place already. We don't really
> support updating just BL31 in an existing binary firmware image, so you
> would get an updated U-Boot as well.
> 
> I think the worst case scenario is that users end up with an unneeded 512K
> reservation. If they care, a firmware update should solve this problem.
> 
> As for the time to remove that node: we could do that at the time when
> (or rather: if) we actually change the TF-A reservation. At the moment
> there are no plans to do this, and the size reservation is more than
> generous (the current debug build is actually 77 KB or so only). If there
> is no change, and the node stays in the .dtsi, it doesn't really hurt, see
> above.
> 
>> After 10 years? Alternatively, reserved memory node can be just dropped and 
>> anyone loading DTB file from outside would need to make sure it's patched. But 
>> that's unexpected from user perspective, although patching DT files is done by 
>> some distros.
> 
> Yeah, let's not go there. As you know, I already dislike the idea of
> explicitly loading DTBs at all, but I understand this is what people, and
> distributions, do, so I'd rather have them covered. Hence the node to
> work with existing firmware.
> 
> Does that make sense?
> 
> Cheers,
> Andre
> 

