Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317704B9D3D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 11:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239117AbiBQKe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 05:34:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbiBQKey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:34:54 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B011A1389;
        Thu, 17 Feb 2022 02:34:39 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id A59FE1F45962
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645094078;
        bh=SVtmAhjbCcfy60glzhGufZJi/SGBEgXxMHHvfrInk78=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Hir6ZAzP5xKsuWQJOkhmD4vmeuRqOSqkuXfR5V6cDif2zWwrK1EiCJKXbHqjUymQv
         hK3JJK7UtdpfXb6vWnjhQLk5DT5SogIyZjUq+3Mddf8u/+Bws8877ifRtK0VKf96oV
         vtH/MoPn4acGO0u0QFn9vpZZzTvXlC52V/QwXAruED9l3UfddfbfMdG4h18XC3bTOM
         NLisby2js2QXmSlS9eqEwBncQIGW8OVIUkVMKBjK2rw7L/y3dfTVkTXPKjdew6n7g5
         NNSZ93bQiuyKWMlWMtyRz4k7RcRR3R4k5AvgR9zp9KZ27EhkO3ahufxwORHUxSvPS+
         TsdLmKayGDXIQ==
Message-ID: <0c91da54-190f-7039-ca5d-414e397f7a95@collabora.com>
Date:   Thu, 17 Feb 2022 11:34:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2] arm64: dts: mediatek: Add Mediatek mt8192 cpufreq
 device nodes
Content-Language: en-US
To:     "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
References: <1609223471-24325-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <20220210144659.2vkuuh74xagic3ud@notapiano>
 <20220210185603.lmgf4ppppe3ccscj@notapiano>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220210185603.lmgf4ppppe3ccscj@notapiano>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/02/22 19:56, Nícolas F. R. A. Prado ha scritto:
> Hi again,
> please see my comment below.
> 
> On Thu, Feb 10, 2022 at 09:47:04AM -0500, Nícolas F. R. A. Prado wrote:
>> Hi Andrew,
>>
>> On Tue, Dec 29, 2020 at 02:31:11PM +0800, Andrew-sh.Cheng wrote:
>>> From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
>>>
>>> Correct dts node name in patch v1: performance-domain
>>> This patch depends on [1] and [2].
>>>
>>> [1]http://lists.infradead.org/pipermail/linux-mediatek/2020-November/019378.html
>>> [2]https://patchwork.kernel.org/project/linux-mediatek/patch/1607586516-6547-3-git-send-email-hector.yuan@mediatek.com/
>>
>> Those two series are now merged, so no dependencies missing for this patch any
>> longer.
>>
>> Please rebase this patch, as there are some conflicts. I've already verified it,
>> and after you rebase I can send a reviewed-by.
>>
>> Thanks,
>> Nícolas
>>
>>>
>>> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
>>> ---
>>>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 14 ++++++++++++++
>>>   1 file changed, 14 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> index 69d45c7b31f1..a907ee7e650a 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> @@ -39,6 +39,7 @@
>>>   			compatible = "arm,cortex-a55";
>>>   			reg = <0x000>;
>>>   			enable-method = "psci";
>>> +			performance-domains = <&performance 0>;
>>>   			clock-frequency = <1701000000>;
>>>   			next-level-cache = <&l2_0>;
>>>   			capacity-dmips-mhz = <530>;
>>> @@ -49,6 +50,7 @@
>>>   			compatible = "arm,cortex-a55";
>>>   			reg = <0x100>;
>>>   			enable-method = "psci";
>>> +			performance-domains = <&performance 0>;
>>>   			clock-frequency = <1701000000>;
>>>   			next-level-cache = <&l2_0>;
>>>   			capacity-dmips-mhz = <530>;
>>> @@ -59,6 +61,7 @@
>>>   			compatible = "arm,cortex-a55";
>>>   			reg = <0x200>;
>>>   			enable-method = "psci";
>>> +			performance-domains = <&performance 0>;
>>>   			clock-frequency = <1701000000>;
>>>   			next-level-cache = <&l2_0>;
>>>   			capacity-dmips-mhz = <530>;
>>> @@ -69,6 +72,7 @@
>>>   			compatible = "arm,cortex-a55";
>>>   			reg = <0x300>;
>>>   			enable-method = "psci";
>>> +			performance-domains = <&performance 0>;
>>>   			clock-frequency = <1701000000>;
>>>   			next-level-cache = <&l2_0>;
>>>   			capacity-dmips-mhz = <530>;
>>> @@ -79,6 +83,7 @@
>>>   			compatible = "arm,cortex-a76";
>>>   			reg = <0x400>;
>>>   			enable-method = "psci";
>>> +			performance-domains = <&performance 1>;
>>>   			clock-frequency = <2171000000>;
>>>   			next-level-cache = <&l2_1>;
>>>   			capacity-dmips-mhz = <1024>;
>>> @@ -89,6 +94,7 @@
>>>   			compatible = "arm,cortex-a76";
>>>   			reg = <0x500>;
>>>   			enable-method = "psci";
>>> +			performance-domains = <&performance 1>;
>>>   			clock-frequency = <2171000000>;
>>>   			next-level-cache = <&l2_1>;
>>>   			capacity-dmips-mhz = <1024>;
>>> @@ -99,6 +105,7 @@
>>>   			compatible = "arm,cortex-a76";
>>>   			reg = <0x600>;
>>>   			enable-method = "psci";
>>> +			performance-domains = <&performance 1>;
>>>   			clock-frequency = <2171000000>;
>>>   			next-level-cache = <&l2_1>;
>>>   			capacity-dmips-mhz = <1024>;
>>> @@ -109,6 +116,7 @@
>>>   			compatible = "arm,cortex-a76";
>>>   			reg = <0x700>;
>>>   			enable-method = "psci";
>>> +			performance-domains = <&performance 1>;
>>>   			clock-frequency = <2171000000>;
>>>   			next-level-cache = <&l2_1>;
>>>   			capacity-dmips-mhz = <1024>;
>>> @@ -194,6 +202,12 @@
>>>   		compatible = "simple-bus";
>>>   		ranges;
>>>   
>>> +		performance: performance-controller@0011bc00 {
> 
> Actually there is a warning being introduced here on dtbs_check:
> 
> 	soc: 'performance-controller@0011bc00' does not match any of the regexes: '@(0|[1-9a-f][0-9a-f]*)$', '^[^@]+$', 'pinctrl-[0-9]+'
> 		From schema: [...]/dtschema/schemas/simple-bus.yaml
> 
> So you should also change the address to not start with zeros: 11bc00
> 
> Thanks,
> Nícolas
> 
>>> +			compatible = "mediatek,cpufreq-hw";
>>> +			reg = <0 0x0011bc10 0 0x120>, <0 0x0011bd30 0 0x120>;
>>> +			#performance-domain-cells = <1>;
>>> +		};
>>> +
>>>   		gic: interrupt-controller@c000000 {
>>>   			compatible = "arm,gic-v3";
>>>   			#interrupt-cells = <4>;
>>> -- 
>>> 2.12.5

Hello Andrew,

are you still interested in upstreaming this patch?
If you are, please update it with the suggested changes.

Thank you,
Angelo
