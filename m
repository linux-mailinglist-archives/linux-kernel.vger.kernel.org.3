Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D349153C176
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 02:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239889AbiFCAj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 20:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiFCAj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 20:39:56 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E89344C4
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 17:39:51 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220603003948epoutp04546ac09c105b7e473489b1456c66e1e9~09Wd-Foe40834208342epoutp04G
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 00:39:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220603003948epoutp04546ac09c105b7e473489b1456c66e1e9~09Wd-Foe40834208342epoutp04G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654216788;
        bh=qV2RZDuOC+NLNi/reDeA+VSns9m5hOCk/GH43ETyVv4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=VwFLJA+tMfzm91iYt0XnGiNTYWJjoNLT0qGaT7RyshFeYR5M2xdCigjfPdPyfa6eO
         MUo2iXeCc6rtzHghb5k4iWCscAZyAnKiiq+QH0q0NLfVaVUlu9lKquqyLiUi2sogtw
         07DA3oJfXWr6apPjGk2cj8QJBM1xJFRu0D6F7uBg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220603003947epcas1p2573fdd0c119bb0b6582590173ab14289~09WdNi0cW1131411314epcas1p2P;
        Fri,  3 Jun 2022 00:39:47 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.234]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LDkYF37Zcz4x9Q2; Fri,  3 Jun
        2022 00:39:45 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        71.EB.09785.15859926; Fri,  3 Jun 2022 09:39:45 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220603003945epcas1p2dc8eba48f7027beb7cf066836f153370~09WbLrmHh0516205162epcas1p21;
        Fri,  3 Jun 2022 00:39:45 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220603003944epsmtrp180b6ac701cb9c15970dc07fb385e9b0b~09WbKs85r2717627176epsmtrp1Q;
        Fri,  3 Jun 2022 00:39:44 +0000 (GMT)
X-AuditID: b6c32a36-c9dff70000002639-b2-629958514480
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        05.A9.11276.05859926; Fri,  3 Jun 2022 09:39:44 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220603003944epsmtip1fe9113c4cccfc887037aaa1a3b0bdfba~09WasoZYi1012510125epsmtip1z;
        Fri,  3 Jun 2022 00:39:44 +0000 (GMT)
Subject: Re: [PATCH v6 1/2] dt-bindings: interconnect: Add MediaTek CCI
 dt-bindings
To:     Johnson Wang <johnson.wang@mediatek.com>, krzk+dt@kernel.org,
        robh+dt@kernel.org, kyungmin.park@samsung.com, djakov@kernel.org
Cc:     khilman@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, jia-wei.chang@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <a29667c5-9c84-b2c7-7027-926703cfe473@samsung.com>
Date:   Fri, 3 Jun 2022 09:39:44 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20220527110036.8810-2-johnson.wang@mediatek.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmvm5gxMwkgwszRC3mHznHavHsViOb
        xfH9S9gtjv0Ktni6+TGTxctZ99gszja9YbfY9Pgaq8XlXXPYLC43X2S0+Nx7hNHi07oOFovW
        vUfYHXg9Nq3qZPPYvKTeo+XkfhaPvi2rGD0+b5ILYI3KtslITUxJLVJIzUvOT8nMS7dV8g6O
        d443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBOlFJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9c
        YquUWpCSU2BaoFecmFtcmpeul5daYmVoYGBkClSYkJ1x7OMW9oIvJhU9uy+wNTD2qHUxcnJI
        CJhIPP23ib2LkYtDSGAHo8T3fV9YIZxPjBK79s5jhnC+MUrcm3OBFaZl9prlUC17GSX61q6D
        qnrPKLF882kWkCphgVCJRTO+MoIkRARaGCWufe0EG8ws0M0ksffJTXaQKjYBLYn9L26wgdj8
        AooSV388ZgSxeQXsJE4unAu2j0VAReLg1wNgNaICYRInt7VA1QhKnJz5BGwbJ1D90hu7wOqZ
        BcQlbj2ZzwRhy0tsfzsH7DwJgTMcEs83vmKHeMJF4sPJDmYIW1ji1fEtUHEpiZf9bewQDc2M
        Eg0vbjNCOD2MEkef9bFAVBlL7F86GWgFB9AKTYn1u/QhwooSO3/PZYTYzCfx7msPK0iJhACv
        REebEESJssTlB3eZIGxJicXtnWwTGJVmIflnFpIfZiH5YRbCsgWMLKsYxVILinPTU4sNC4zg
        MZ6cn7uJEZyEtcx2ME56+0HvECMTB+MhRgkOZiUR3pJdU5OEeFMSK6tSi/Lji0pzUosPMZoC
        Q3gis5Rocj4wD+SVxBuaWBqYmBkZm1gYmhkqifOumnY6UUggPbEkNTs1tSC1CKaPiYNTqoHJ
        RcldO+HSPMaT0+vMVzptWbaXPzh0Z8PxGc9F2jUXqGckl+iJxPbb67F/PmAe6LPi6n3Z8Mv8
        ZioTkm5fVZhRcYnNwDD4mITTRvGEnarzJikdfPXCRqw+bH/wY8WHaR5LH1gwba5cytBhH+eg
        abBsVuPC3VUKVpyfJCqT2JfI1qUeXNy7XP97eVbQ74qXLe31NsFTN89P7wt0U1Jnr2jhlrrW
        V2L+yO37zp2Pp7+5s7mev/N12NkLPHMXm13kFs7J+hiyy313h77oyS+6xXOEF/Yxb9a8coG/
        1K/y14mNlwt2u5+7UHE3f4alwhN2jdOBT3mrO9s23N+tM1G/bG7oczGBPqN7v6dlWljrTVRi
        Kc5INNRiLipOBAD/BaKMSwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsWy7bCSnG5AxMwkg1WLzS3mHznHavHsViOb
        xfH9S9gtjv0Ktni6+TGTxctZ99gszja9YbfY9Pgaq8XlXXPYLC43X2S0+Nx7hNHi07oOFovW
        vUfYHXg9Nq3qZPPYvKTeo+XkfhaPvi2rGD0+b5ILYI3isklJzcksSy3St0vgyjj2cQt7wReT
        ip7dF9gaGHvUuhg5OSQETCRmr1nO3sXIxSEksJtRYtevU2wQCUmJaRePMncxcgDZwhKHDxeD
        hIUE3jJK9J7JBLGFBUIlFs34ygjSKyLQwiix78kRMIdZoJNJ4s7q7UwQU48ySkz4MYsVpIVN
        QEti/4sbYBv4BRQlrv54zAhi8wrYSZxcOBeshkVAReLg1wNgNaICYRI7lzxmgqgRlDg58wkL
        iM0JVL/0xi6wemYBdYk/8y4xQ9jiEreezGeCsOUltr+dwzyBUXgWkvZZSFpmIWmZhaRlASPL
        KkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4EjU0tzBuH3VB71DjEwcjIcYJTiYlUR4
        S3ZNTRLiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qBaeO5
        +MZYXc2WJd5ilTa3HPkCbxwp3n+d7fmSqzNLHgbqc3g/nuxXsC1EPkDQYM6r08svh//Vfeg1
        b3+Zd+hkRaNa141n21geeVk4rRNa8UL37aWaGxHue9qsVKaUpajc0lvz96T9/f3ae4/Y5J8P
        vPHo6T3XvxtaXuicy746ZfntrEvCG1i2ab+z+t7ovOrrEo5t2tPWrv2cMO/ZRNV761ivVyS/
        uL9x8cHr335XaiXP5L28tf67uuuSWX/2eYZdE2azKPWYcjf31d5JWvc27PLc5Xvhwr/GhtN5
        1831ZppNOzfPe0OPx1FjuefXKzM5z/3dMefYl477hhIJDEn+ziu7p0yuXf7k4Y1dKvckwpbw
        KbEUZyQaajEXFScCAOPXECszAwAA
X-CMS-MailID: 20220603003945epcas1p2dc8eba48f7027beb7cf066836f153370
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220527110145epcas1p4c7f18d9c279de790634bffb8550ad552
References: <20220527110036.8810-1-johnson.wang@mediatek.com>
        <CGME20220527110145epcas1p4c7f18d9c279de790634bffb8550ad552@epcas1p4.samsung.com>
        <20220527110036.8810-2-johnson.wang@mediatek.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Georgi,

If you agree this dt-bidning into .../bindings/interconnect,
I'll merge it. Could you please review it?

On 5/27/22 8:00 PM, Johnson Wang wrote:
> Add devicetree binding of MediaTek CCI on MT8183 and MT8186.
> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  .../bindings/interconnect/mediatek,cci.yaml   | 141 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 142 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml b/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
> new file mode 100644
> index 000000000000..449c7c988229
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
> @@ -0,0 +1,141 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: https://protect2.fireeye.com/v1/url?k=ad4ad61b-cc317c8c-ad4b5d54-74fe4860001d-01f34b7b1b45f9dd&q=1&e=81fe0992-6204-4794-b412-8ba4ca747e10&u=http%3A%2F%2Fdevicetree.org%2Fschemas%2Finterconnect%2Fmediatek%2Ccci.yaml%23
> +$schema: https://protect2.fireeye.com/v1/url?k=a032f6c0-c1495c57-a0337d8f-74fe4860001d-83ce1b32f63b7f35&q=1&e=81fe0992-6204-4794-b412-8ba4ca747e10&u=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23
> +
> +title: MediaTek Cache Coherent Interconnect (CCI) frequency and voltage scaling
> +
> +maintainers:
> +  - Jia-Wei Chang <jia-wei.chang@mediatek.com>
> +  - Johnson Wang <johnson.wang@mediatek.com>
> +
> +description: |
> +  MediaTek Cache Coherent Interconnect (CCI) is a hardware engine used by
> +  MT8183 and MT8186 SoCs to scale the frequency and adjust the voltage in
> +  hardware. It can also optimize the voltage to reduce the power consumption.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt8183-cci
> +      - mediatek,mt8186-cci
> +
> +  clocks:
> +    items:
> +      - description:
> +          The multiplexer for clock input of the bus.
> +      - description:
> +          A parent of "bus" clock which is used as an intermediate clock source
> +          when the original clock source (PLL) is under transition and not
> +          stable yet.
> +
> +  clock-names:
> +    items:
> +      - const: cci
> +      - const: intermediate
> +
> +  operating-points-v2: true
> +  opp-table: true
> +
> +  proc-supply:
> +    description:
> +      Phandle of the regulator for CCI that provides the supply voltage.
> +
> +  sram-supply:
> +    description:
> +      Phandle of the regulator for sram of CCI that provides the supply
> +      voltage. When it is present, the implementation needs to do
> +      "voltage tracking" to step by step scale up/down Vproc and Vsram to fit
> +      SoC specific needs. When absent, the voltage scaling flow is handled by
> +      hardware, hence no software "voltage tracking" is needed.
> +
> +required:
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - operating-points-v2
> +  - proc-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt8183-clk.h>
> +    cci: cci {
> +        compatible = "mediatek,mt8183-cci";
> +        clocks = <&mcucfg CLK_MCU_BUS_SEL>,
> +                 <&topckgen CLK_TOP_ARMPLL_DIV_PLL1>;
> +        clock-names = "cci", "intermediate";
> +        operating-points-v2 = <&cci_opp>;
> +        proc-supply = <&mt6358_vproc12_reg>;
> +    };
> +
> +    cci_opp: opp-table-cci {
> +        compatible = "operating-points-v2";
> +        opp-shared;
> +        opp2_00: opp-273000000 {
> +            opp-hz = /bits/ 64 <273000000>;
> +            opp-microvolt = <650000>;
> +        };
> +        opp2_01: opp-338000000 {
> +            opp-hz = /bits/ 64 <338000000>;
> +            opp-microvolt = <687500>;
> +        };
> +        opp2_02: opp-403000000 {
> +            opp-hz = /bits/ 64 <403000000>;
> +            opp-microvolt = <718750>;
> +        };
> +        opp2_03: opp-463000000 {
> +            opp-hz = /bits/ 64 <463000000>;
> +            opp-microvolt = <756250>;
> +        };
> +        opp2_04: opp-546000000 {
> +            opp-hz = /bits/ 64 <546000000>;
> +            opp-microvolt = <800000>;
> +        };
> +        opp2_05: opp-624000000 {
> +            opp-hz = /bits/ 64 <624000000>;
> +            opp-microvolt = <818750>;
> +        };
> +        opp2_06: opp-689000000 {
> +            opp-hz = /bits/ 64 <689000000>;
> +            opp-microvolt = <850000>;
> +        };
> +        opp2_07: opp-767000000 {
> +            opp-hz = /bits/ 64 <767000000>;
> +            opp-microvolt = <868750>;
> +        };
> +        opp2_08: opp-845000000 {
> +            opp-hz = /bits/ 64 <845000000>;
> +            opp-microvolt = <893750>;
> +        };
> +        opp2_09: opp-871000000 {
> +            opp-hz = /bits/ 64 <871000000>;
> +            opp-microvolt = <906250>;
> +        };
> +        opp2_10: opp-923000000 {
> +            opp-hz = /bits/ 64 <923000000>;
> +            opp-microvolt = <931250>;
> +        };
> +        opp2_11: opp-962000000 {
> +            opp-hz = /bits/ 64 <962000000>;
> +            opp-microvolt = <943750>;
> +        };
> +        opp2_12: opp-1027000000 {
> +            opp-hz = /bits/ 64 <1027000000>;
> +            opp-microvolt = <975000>;
> +        };
> +        opp2_13: opp-1092000000 {
> +            opp-hz = /bits/ 64 <1092000000>;
> +            opp-microvolt = <1000000>;
> +        };
> +        opp2_14: opp-1144000000 {
> +            opp-hz = /bits/ 64 <1144000000>;
> +            opp-microvolt = <1025000>;
> +        };
> +        opp2_15: opp-1196000000 {
> +            opp-hz = /bits/ 64 <1196000000>;
> +            opp-microvolt = <1050000>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 41c9c8f2b96d..7239f0e0c47b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5735,6 +5735,7 @@ L:	linux-pm@vger.kernel.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
>  F:	Documentation/devicetree/bindings/devfreq/
> +F:	Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
>  F:	drivers/devfreq/
>  F:	include/linux/devfreq.h
>  F:	include/trace/events/devfreq.h
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
