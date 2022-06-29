Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033F555FFD3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 14:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiF2MXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 08:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiF2MXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 08:23:45 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFF931DDB
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 05:23:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1656504487; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=bua+jMImc+TrGG0k/DW7Zq89Q5FV+VyVHYSwXyKURgqVoSC0qaDuogK7LVxo78yA54N13uUsblx2Ut+N9SKkkvmdfU2NjVtmP1y3QZM2BfXyyFrRlKAUQ+m6CjRD22o/kt2cv3V9u7fdYOj+NpeR2qNouqDjjXLPOVrBe9XQqhI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1656504487; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=ukTu6MJ3bj33YMWpWKj7wdJBBihYnF+q/gqNaxzzG7Y=; 
        b=MMNhmEY57rRPUGHyB/05wbKu1+gJbL33o4erNLvIPQDHvKaE8YycxN0vR5QFu6HVY3GKkJuJBNSyELEUHTkE3f+y9AV0ABmSjAmX9COQ3iqCPMSmUPWWEs7jfW9VrmuaTTs8qTph3KEF4bEmNfN7PmH9W0tvk2rhGpZ9uBKW1Ws=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1656504487;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=ukTu6MJ3bj33YMWpWKj7wdJBBihYnF+q/gqNaxzzG7Y=;
        b=ghUSA36wtapzBy8Ahob4QwwwNxMkjs5/rn9kxrFi/6Mqubh+NUZCvIkQ0Gf1kq7B
        N4RRX9/wPr6mvTrhXSQO0jgRxIVdHIhvu3vJdrTvPbLiDLK34BOs41HOOelmcojyHJ3
        MncuyWPK7yoNTLtDf7zfVRTpYAHsllnL5zvd3byE=
Received: from [10.10.10.122] (37.120.152.236 [37.120.152.236]) by mx.zohomail.com
        with SMTPS id 1656504486014929.4381961201594; Wed, 29 Jun 2022 05:08:06 -0700 (PDT)
Message-ID: <3394a6fa-dc55-bf5d-c06e-ddf70d95c26b@arinc9.com>
Date:   Wed, 29 Jun 2022 15:08:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] MIPS: dts: correct gpio-keys names and properties
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     Rahul Bedarkar <rahulbedarkar89@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220624170740.66271-1-krzysztof.kozlowski@linaro.org>
 <ZVVZDR.R2QT2GMTT9WS1@crapouillou.net>
 <89b6a40b-eb6b-eba5-78c3-6b5f35bed717@linaro.org>
 <EXU1ER.FH53VZXY9EYP3@crapouillou.net>
 <cc81b6ae-c1c1-78ec-b4e2-e165dcd5015b@linaro.org>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <cc81b6ae-c1c1-78ec-b4e2-e165dcd5015b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.06.2022 23:25, Krzysztof Kozlowski wrote:
> On 25/06/2022 22:15, Paul Cercueil wrote:
>> Hi Krzysztof,
>>
>> Le sam., juin 25 2022 at 21:58:08 +0200, Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> a écrit :
>>> On 24/06/2022 20:40, Paul Cercueil wrote:
>>>>   Hi Krzysztof,
>>>>
>>>>   Le ven., juin 24 2022 at 19:07:39 +0200, Krzysztof Kozlowski
>>>>   <krzysztof.kozlowski@linaro.org> a écrit :
>>>>>   gpio-keys children do not use unit addresses.
>>>>>
>>>>>   Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>>
>>>>>   ---
>>>>>
>>>>>   See:
>>>>>   
>>>>> https://lore.kernel.org/all/20220616005224.18391-1-krzysztof.kozlowski@linaro.org/
>>>>>   ---
>>>>>    arch/mips/boot/dts/img/pistachio_marduk.dts   |  4 +--
>>>>>    arch/mips/boot/dts/ingenic/gcw0.dts           | 31
>>>>>   +++++++++----------
>>>>>    arch/mips/boot/dts/ingenic/rs90.dts           | 18 +++++------
>>>>>    arch/mips/boot/dts/pic32/pic32mzda_sk.dts     |  9 ++----
>>>>>    .../boot/dts/qca/ar9132_tl_wr1043nd_v1.dts    |  6 ++--
>>>>>    arch/mips/boot/dts/qca/ar9331_dpt_module.dts  |  4 +--
>>>>>    .../mips/boot/dts/qca/ar9331_dragino_ms14.dts |  6 ++--
>>>>>    arch/mips/boot/dts/qca/ar9331_omega.dts       |  4 +--
>>>>>    .../qca/ar9331_openembed_som9331_board.dts    |  4 +--
>>>>>    arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts   |  8 ++---
>>>>>    10 files changed, 37 insertions(+), 57 deletions(-)
>>>>>
>>>>>   diff --git a/arch/mips/boot/dts/img/pistachio_marduk.dts
>>>>>   b/arch/mips/boot/dts/img/pistachio_marduk.dts
>>>>>   index a8708783f04b..a8da2f992b1a 100644
>>>>>   --- a/arch/mips/boot/dts/img/pistachio_marduk.dts
>>>>>   +++ b/arch/mips/boot/dts/img/pistachio_marduk.dts
>>>>>   @@ -59,12 +59,12 @@ led-1 {
>>>>>
>>>>>    	keys {
>>>>>    		compatible = "gpio-keys";
>>>>>   -		button@1 {
>>>>>   +		button-1 {
>>>>>    			label = "Button 1";
>>>>>    			linux,code = <0x101>; /* BTN_1 */
>>>>>    			gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
>>>>>    		};
>>>>>   -		button@2 {
>>>>>   +		button-2 {
>>>>>    			label = "Button 2";
>>>>>    			linux,code = <0x102>; /* BTN_2 */
>>>>>    			gpios = <&gpio2 14 GPIO_ACTIVE_LOW>;
>>>>>   diff --git a/arch/mips/boot/dts/ingenic/gcw0.dts
>>>>>   b/arch/mips/boot/dts/ingenic/gcw0.dts
>>>>>   index 4abb0318416c..5d33f26fd28c 100644
>>>>>   --- a/arch/mips/boot/dts/ingenic/gcw0.dts
>>>>>   +++ b/arch/mips/boot/dts/ingenic/gcw0.dts
>>>>>   @@ -130,89 +130,86 @@ backlight: backlight {
>>>>>
>>>>>    	gpio-keys {
>>>>>    		compatible = "gpio-keys";
>>>>>   -		#address-cells = <1>;
>>>>>   -		#size-cells = <0>;
>>>>
>>>>   Are you sure you can remove these?
>>>
>>> Yes, from DT spec point of view, DT bindings and Linux implementation.
>>> However this particular change was not tested, except building.
>>>
>>>>
>>>>   Looking at paragraph 2.3.5 of the DT spec, I would think they have
>>>> to
>>>>   stay (although with #address-cells = <0>).
>>>
>>> The paragraph 2.3.5 says nothing about regular properties (which can
>>> be
>>> also child nodes). It says about children of a bus, right? It's not
>>> related here, it's not a bus.
>>
>> I quote:
>> "A DTSpec-compliant boot program shall supply #address-cells and
>> #size-cells on all nodes that have children."
> 
> And paragraph 2.2.3 says:
> "A unit address may be omitted if the full path to the node is unambiguous."
> 
> You have address/size cells for nodes with children having unit
> addresses. If they don't unit addresses, you don't add address/size
> cells (with some exceptions).
> 
> The paragraph 2.3.5 mentions "child device nodes" and these properties
> are not devices, although I agree that DT spec here is actually confusing.
> 
>>
>> The gpio-keys node has children nodes, therefore it should have
>> #address-cells and #size-cells, there's no room for interpretation here.
>>
>>> Second, why exactly this one gpio-keys node is different than all
>>> other
>>> gpio-keys everywhere and than bindings? Why this one has to be
>>> incompatible/wrong according to bindings (which do not allow
>>> address-cells and nodes with unit addresses)?
>>
>> Nothing is different. I'm just stating that your proposed fix is
>> invalid if we want to enforce compliance with the DT spec.
> 
> In such case, we rather enforce the compliance with the bindings.
> 
> Best regards,
> Krzysztof

I recall them to be unnecessary as well. I have a patch of mine applied 
identical to this:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=8c9f00d4b05134164e462f27b21c8295255ffa64

Also, I don't see any warnings with this patch applied:

$ ARCH=mips CROSS_COMPILE=mipsel-linux-gnu- make clean dtbs -j$(nproc)
   SYNC    include/config/auto.conf.cmd
   HOSTCC  scripts/basic/fixdep
   HOSTCC  scripts/kconfig/conf.o
   HOSTCC  scripts/kconfig/confdata.o
   HOSTCC  scripts/kconfig/expr.o
   LEX     scripts/kconfig/lexer.lex.c
   YACC    scripts/kconfig/parser.tab.[ch]
   HOSTCC  scripts/kconfig/menu.o
   HOSTCC  scripts/kconfig/preprocess.o
   HOSTCC  scripts/kconfig/symbol.o
   HOSTCC  scripts/kconfig/util.o
   HOSTCC  scripts/kconfig/lexer.lex.o
   HOSTCC  scripts/kconfig/parser.tab.o
   HOSTLD  scripts/kconfig/conf
   HOSTCC  scripts/dtc/dtc.o
   HOSTCC  scripts/dtc/flattree.o
   HOSTCC  scripts/dtc/fstree.o
   HOSTCC  scripts/dtc/data.o
   HOSTCC  scripts/dtc/livetree.o
   HOSTCC  scripts/dtc/treesource.o
   HOSTCC  scripts/dtc/srcpos.o
   HOSTCC  scripts/dtc/checks.o
   HOSTCC  scripts/dtc/util.o
   LEX     scripts/dtc/dtc-lexer.lex.c
   YACC    scripts/dtc/dtc-parser.tab.[ch]
   HOSTCC  scripts/dtc/libfdt/fdt.o
   HOSTCC  scripts/dtc/libfdt/fdt_ro.o
   HOSTCC  scripts/dtc/libfdt/fdt_wip.o
   HOSTCC  scripts/dtc/libfdt/fdt_sw.o
   HOSTCC  scripts/dtc/libfdt/fdt_rw.o
   HOSTCC  scripts/dtc/libfdt/fdt_strerror.o
   HOSTCC  scripts/dtc/libfdt/fdt_empty_tree.o
   HOSTCC  scripts/dtc/libfdt/fdt_addresses.o
   HOSTCC  scripts/dtc/libfdt/fdt_overlay.o
   HOSTCC  scripts/dtc/fdtoverlay.o
   HOSTCC  scripts/dtc/dtc-lexer.lex.o
   HOSTCC  scripts/dtc/dtc-parser.tab.o
   HOSTLD  scripts/dtc/fdtoverlay
   HOSTLD  scripts/dtc/dtc
   DTC     arch/mips/boot/dts/ingenic/gcw0.dtb

Have my acked-by.

Acked-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Arınç
