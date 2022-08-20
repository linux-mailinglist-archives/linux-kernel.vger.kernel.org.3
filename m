Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6363959AF23
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 19:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346294AbiHTRZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 13:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346166AbiHTRZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 13:25:04 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F066B4DB3C;
        Sat, 20 Aug 2022 10:25:01 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A31565C0040;
        Sat, 20 Aug 2022 13:24:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 20 Aug 2022 13:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1661016297; x=
        1661102697; bh=5Fma7zGYExQkO+bwyNYDf8Z3vOM0RX6XTYyF0I2rGsU=; b=W
        lKvcgPSERJCgolbdz/GETypfPUNCvgWksfRm3H6sdJMQdCnRMESNof2kG49mujSY
        1iY4SdZMO504xEorFUZbzSFnDsP4KKJiOd440Xx7Mgpz1166ynTEJylG4mupCUmO
        8EFXHuxL6OEZcqf9g8W38N6wOalxumJEZNji8AHlWRcN0F9D3sKWSd/u0PATIB8k
        iKjqBUDkiwSPf7ggD2WVDDD/10H85Phn64sw8jpMt2Bc7Ulkj2hmMEFL7LCf0txd
        HWFnNXoopdQbfnXVSnPU2pZKMB+6J2iTNMJBEvm9fw2TuDZwQbFpySMzqZWycdPw
        3u3BkCqUULmwsEh/ch5yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1661016297; x=
        1661102697; bh=5Fma7zGYExQkO+bwyNYDf8Z3vOM0RX6XTYyF0I2rGsU=; b=q
        T6DYYNAXtipupjclWIzfxsvrYblX9n/SuIQ/QlvV9OWI2tgEGEyjPt+Q/Dv8zozD
        kbr0ijTopaT4LjyGzxHc1i0XeCczuVDpb2S34nd3uhPYidwvsHThS9LxQFpYHuJC
        SiKgfcMjfQ/MXvvx/4xOd2PRt3gVe+ct1hNGpy9YZsRmTyNns4opsTKsW/YFpgfb
        i9rtkEAA408UqBoK4gowOjmFCiyDkjGPcWMx+m/JFNoz1Ol6T/eJUGCrHfW6uLjX
        NScDecR1ikueguxic01qQqRxlFb2DO75IePRIYeDG1igaXTPjGVado5CDnQ76kNY
        IIEt+Q+g+vbg8Gu5y8MeA==
X-ME-Sender: <xms:6BgBYxd17tt4aZ9s18Pnxo1ew_dyPPEbdhArw2c2VwGX4LXTELWQ_A>
    <xme:6BgBY_Og5Axxreetq2ECM8K0xyYSpSgZ60IN3iMemnOvKfYS7wHiPHpYlGtdLWK67
    c-Q47JufROJAskV6g>
X-ME-Received: <xmr:6BgBY6gxV_dyEx0Xh7Hfb19t4BdK-fSZ2xJ3EKsq_iGPN76iqaS1SmIrYoqqHU6tIkbTEjLqmQzqlev5N0-p2g97vTTn8cCWYG_SkKBPGeLztQgG0QkxdoV8KA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeifedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepuffvvehfhffkffgfgggjtgfgse
    htjeertddtfeejnecuhfhrohhmpefurghmuhgvlhcujfholhhlrghnugcuoehsrghmuhgv
    lhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrghtthgvrhhnpeelteejffdvgeehke
    dtkeevueeuteffteffhedufeeujedvudefudetieeijeevleenucffohhmrghinhepkhgv
    rhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:6BgBY6-AgGL8GQicpNUXP8F7CNZzu1BcxEmk559pKMwnt9pN7wm-pg>
    <xmx:6BgBY9vI6wNEgSKrJxoGQw7Q5EXsJFt695CIyxxNhQh78O7dWgCenA>
    <xmx:6BgBY5HjoxZPY-tDi3U_-obTyKr-3eqtB080j2qYNazGwcKPjkS6fA>
    <xmx:6RgBY5H8rcO7mRAvevVMavBWMmw6HAkqBVSuWLvs_UHwPE3ND4N8Rw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Aug 2022 13:24:56 -0400 (EDT)
Subject: Re: [PATCH 06/12] riscv: dts: allwinner: Add the D1 SoC base
 devicetree
To:     Conor.Dooley@microchip.com, andre.przywara@arm.com
Cc:     wens@csie.org, jernej.skrabec@gmail.com,
        linux-sunxi@lists.linux.dev, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
References: <20220815050815.22340-1-samuel@sholland.org>
 <20220815050815.22340-7-samuel@sholland.org>
 <20220815141159.10edeba5@donnerap.cambridge.arm.com>
 <3cd9ed5b-8348-38ac-feb1-9a7da858cebc@microchip.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <932aaefd-e2ca-ef26-bf30-e315fb271ec5@sholland.org>
Date:   Sat, 20 Aug 2022 12:24:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <3cd9ed5b-8348-38ac-feb1-9a7da858cebc@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/22 12:01 PM, Conor.Dooley@microchip.com wrote:
> On 15/08/2022 14:11, Andre Przywara wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On Mon, 15 Aug 2022 00:08:09 -0500
>> Samuel Holland <samuel@sholland.org> wrote:
>>
>> Hi,
>>
>> thanks for all the efforts in getting those SoC peripherals supported!
>>
>>> D1 is a SoC containing a single-core T-HEAD Xuantie C906 CPU, as well as
>>> one HiFi 4 DSP. The SoC is based on a design that additionally contained
>>> a pair of Cortex A7's. For that reason, some peripherals are duplicated.
>>
>> So because of this, the Allwinner R528 and T113 SoCs would share almost
>> everything in this file. Would it be useful to already split this DT up?
>> To have a base .dtsi, basically this file without /cpus and /soc/plic,
>> then have a RISC-V specific file with just those, including the base?
>> There is precedence for this across-arch(-directories) sharing with the
>> Raspberry Pi and Allwinner H3/H5 SoCs.
> 
> For those playing along at home, one example is the arm64 bananapi m2
> dts which looks like:
>> /dts-v1/;
>> #include "sun50i-h5.dtsi"
>> #include "sun50i-h5-cpu-opp.dtsi"
>> #include <arm/sunxi-bananapi-m2-plus-v1.2.dtsi>
>>
>> / {
>> 	model = "Banana Pi BPI-M2-Plus v1.2 H5";
>> 	compatible = "bananapi,bpi-m2-plus-v1.2", "allwinner,sun50i-h5";
>> };
> 
> I think this is a pretty good idea, and putting in the modularity up
> front seems logical to me, so when the arm one does eventually get
> added it can be done by only touching a single arch.

This is not feasible, due to the different #interrupt-cells. See
https://lore.kernel.org/linux-riscv/CAMuHMdXHSMcrVOH+vcrdRRF+i2TkMcFisGxHMBPUEa8nTMFpzw@mail.gmail.com/

Even if we share some file across architectures, you still have to update files
in both places to get the interrupts properties correct.

I get the desire to deduplicate things, but we already deal with updating the
same/similar nodes across several SoCs, so that is nothing new. I think it would
be more confusing/complicated to have all of the interrupts properties
overridden in a separate file.

Regards,
Samuel
