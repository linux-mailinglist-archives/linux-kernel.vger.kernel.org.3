Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF45B53C8C7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 12:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243796AbiFCKcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 06:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbiFCKb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 06:31:56 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1C5AE4E;
        Fri,  3 Jun 2022 03:31:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B756CCE230F;
        Fri,  3 Jun 2022 10:31:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F38C385A9;
        Fri,  3 Jun 2022 10:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654252310;
        bh=uxKDQNP2ZIM59sJd/+dQG5xkTcM55eNMWdyr2X32D6g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=o0hRM0IG/I22H9wIGay8MPt5gSxCJKew0MZ30/YttjF4KPdOUZAt9tWKlZOAztKOf
         Bc2u2bb6ZRKIEhtWoCREM2Ss+6zn+bVDKMqX1lpJL3CkCuIKZa2/OABcKljV3flWJ7
         GUzT053LmCTaQePuKcPLfMtEz/K1InO0HxGIjH1DV8sYcThBtdkWfwanoJDdAqQiLi
         HKMQQrbTu/tltcWEHf6/1uRLp/T1RQmqfYtAANrjIzNe7jTxyWfCql6mEtSjmvWlgq
         XLMF025l17iff2AShrujEzMyBxWFGaz6ngHGwcnVqUwPUYsYZJvvzJaNEqyTrM7Jyx
         k4XpJmBUQrWMw==
Message-ID: <5e57a1f3-1159-9277-5f8c-6ed0ad030a00@kernel.org>
Date:   Fri, 3 Jun 2022 13:31:44 +0300
MIME-Version: 1.0
Subject: Re: [PATCH v6 1/2] dt-bindings: interconnect: Add MediaTek CCI
 dt-bindings
Content-Language: en-US
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Johnson Wang <johnson.wang@mediatek.com>, krzk+dt@kernel.org,
        robh+dt@kernel.org, kyungmin.park@samsung.com
Cc:     khilman@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, jia-wei.chang@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220527110036.8810-1-johnson.wang@mediatek.com>
 <CGME20220527110145epcas1p4c7f18d9c279de790634bffb8550ad552@epcas1p4.samsung.com>
 <20220527110036.8810-2-johnson.wang@mediatek.com>
 <a29667c5-9c84-b2c7-7027-926703cfe473@samsung.com>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <a29667c5-9c84-b2c7-7027-926703cfe473@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3.06.22 3:39, Chanwoo Choi wrote:
> Hi Georgi,
> 
> If you agree this dt-bidning into .../bindings/interconnect,
> I'll merge it. Could you please review it?
> 
> On 5/27/22 8:00 PM, Johnson Wang wrote:
>> Add devicetree binding of MediaTek CCI on MT8183 and MT8186.
>>
>> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
>> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

Acked-by: Georgi Djakov <djakov@kernel.org>

Looks good to me. Thanks!

BR,
Georgi

>> ---
>>   .../bindings/interconnect/mediatek,cci.yaml   | 141 ++++++++++++++++++
>>   MAINTAINERS                                   |   1 +
>>   2 files changed, 142 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml b/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
>> new file mode 100644
>> index 000000000000..449c7c988229
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
>> @@ -0,0 +1,141 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: https://protect2.fireeye.com/v1/url?k=ad4ad61b-cc317c8c-ad4b5d54-74fe4860001d-01f34b7b1b45f9dd&q=1&e=81fe0992-6204-4794-b412-8ba4ca747e10&u=http%3A%2F%2Fdevicetree.org%2Fschemas%2Finterconnect%2Fmediatek%2Ccci.yaml%23
>> +$schema: https://protect2.fireeye.com/v1/url?k=a032f6c0-c1495c57-a0337d8f-74fe4860001d-83ce1b32f63b7f35&q=1&e=81fe0992-6204-4794-b412-8ba4ca747e10&u=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23
>> +
>> +title: MediaTek Cache Coherent Interconnect (CCI) frequency and voltage scaling
>> +
>> +maintainers:
>> +  - Jia-Wei Chang <jia-wei.chang@mediatek.com>
>> +  - Johnson Wang <johnson.wang@mediatek.com>
>> +
>> +description: |
>> +  MediaTek Cache Coherent Interconnect (CCI) is a hardware engine used by
>> +  MT8183 and MT8186 SoCs to scale the frequency and adjust the voltage in
>> +  hardware. It can also optimize the voltage to reduce the power consumption.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - mediatek,mt8183-cci
>> +      - mediatek,mt8186-cci
>> +
>> +  clocks:
>> +    items:
>> +      - description:
>> +          The multiplexer for clock input of the bus.
>> +      - description:
>> +          A parent of "bus" clock which is used as an intermediate clock source
>> +          when the original clock source (PLL) is under transition and not
>> +          stable yet.
>> +
>> +  clock-names:
>> +    items:
>> +      - const: cci
>> +      - const: intermediate
>> +
>> +  operating-points-v2: true
>> +  opp-table: true
>> +
>> +  proc-supply:
>> +    description:
>> +      Phandle of the regulator for CCI that provides the supply voltage.
>> +
>> +  sram-supply:
>> +    description:
>> +      Phandle of the regulator for sram of CCI that provides the supply
>> +      voltage. When it is present, the implementation needs to do
>> +      "voltage tracking" to step by step scale up/down Vproc and Vsram to fit
>> +      SoC specific needs. When absent, the voltage scaling flow is handled by
>> +      hardware, hence no software "voltage tracking" is needed.
>> +
>> +required:
>> +  - compatible
>> +  - clocks
>> +  - clock-names
>> +  - operating-points-v2
>> +  - proc-supply
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/mt8183-clk.h>
>> +    cci: cci {
>> +        compatible = "mediatek,mt8183-cci";
>> +        clocks = <&mcucfg CLK_MCU_BUS_SEL>,
>> +                 <&topckgen CLK_TOP_ARMPLL_DIV_PLL1>;
>> +        clock-names = "cci", "intermediate";
>> +        operating-points-v2 = <&cci_opp>;
>> +        proc-supply = <&mt6358_vproc12_reg>;
>> +    };
>> +
>> +    cci_opp: opp-table-cci {
>> +        compatible = "operating-points-v2";
>> +        opp-shared;
>> +        opp2_00: opp-273000000 {
>> +            opp-hz = /bits/ 64 <273000000>;
>> +            opp-microvolt = <650000>;
>> +        };
>> +        opp2_01: opp-338000000 {
>> +            opp-hz = /bits/ 64 <338000000>;
>> +            opp-microvolt = <687500>;
>> +        };
>> +        opp2_02: opp-403000000 {
>> +            opp-hz = /bits/ 64 <403000000>;
>> +            opp-microvolt = <718750>;
>> +        };
>> +        opp2_03: opp-463000000 {
>> +            opp-hz = /bits/ 64 <463000000>;
>> +            opp-microvolt = <756250>;
>> +        };
>> +        opp2_04: opp-546000000 {
>> +            opp-hz = /bits/ 64 <546000000>;
>> +            opp-microvolt = <800000>;
>> +        };
>> +        opp2_05: opp-624000000 {
>> +            opp-hz = /bits/ 64 <624000000>;
>> +            opp-microvolt = <818750>;
>> +        };
>> +        opp2_06: opp-689000000 {
>> +            opp-hz = /bits/ 64 <689000000>;
>> +            opp-microvolt = <850000>;
>> +        };
>> +        opp2_07: opp-767000000 {
>> +            opp-hz = /bits/ 64 <767000000>;
>> +            opp-microvolt = <868750>;
>> +        };
>> +        opp2_08: opp-845000000 {
>> +            opp-hz = /bits/ 64 <845000000>;
>> +            opp-microvolt = <893750>;
>> +        };
>> +        opp2_09: opp-871000000 {
>> +            opp-hz = /bits/ 64 <871000000>;
>> +            opp-microvolt = <906250>;
>> +        };
>> +        opp2_10: opp-923000000 {
>> +            opp-hz = /bits/ 64 <923000000>;
>> +            opp-microvolt = <931250>;
>> +        };
>> +        opp2_11: opp-962000000 {
>> +            opp-hz = /bits/ 64 <962000000>;
>> +            opp-microvolt = <943750>;
>> +        };
>> +        opp2_12: opp-1027000000 {
>> +            opp-hz = /bits/ 64 <1027000000>;
>> +            opp-microvolt = <975000>;
>> +        };
>> +        opp2_13: opp-1092000000 {
>> +            opp-hz = /bits/ 64 <1092000000>;
>> +            opp-microvolt = <1000000>;
>> +        };
>> +        opp2_14: opp-1144000000 {
>> +            opp-hz = /bits/ 64 <1144000000>;
>> +            opp-microvolt = <1025000>;
>> +        };
>> +        opp2_15: opp-1196000000 {
>> +            opp-hz = /bits/ 64 <1196000000>;
>> +            opp-microvolt = <1050000>;
>> +        };
>> +    };
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 41c9c8f2b96d..7239f0e0c47b 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -5735,6 +5735,7 @@ L:	linux-pm@vger.kernel.org
>>   S:	Maintained
>>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
>>   F:	Documentation/devicetree/bindings/devfreq/
>> +F:	Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
>>   F:	drivers/devfreq/
>>   F:	include/linux/devfreq.h
>>   F:	include/trace/events/devfreq.h
>>
> 
> 

