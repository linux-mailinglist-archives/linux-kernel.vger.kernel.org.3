Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C12651FC37
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 14:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbiEIMNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 08:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbiEIMNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 08:13:12 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB83E32;
        Mon,  9 May 2022 05:09:19 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id g184so9370567pgc.1;
        Mon, 09 May 2022 05:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZCKR2KVToumZXg10SfRvbk1URc/xJPQvsDbss1BO/1o=;
        b=ePKFMJwL5M1xzt0w76+6VlSDEby4h4o0iY4YRShL+32c2fNBngdZDBkJ8+lYgsifg1
         JZ2yaxHPvbFrydTuxN9q91HvF5fv9hZvt35W+3wSMEZNIPaN3Tw5lO0uaNCR2JR2tlt8
         o/FNAtivqYH3yIf+HOVGe8VtMMZHmkyLbhMRSqrkrXRqjedOxVFYV72tpvxfz9iqDLdS
         xjO9YXahuk/4G5wCYGnJFObReCScziM3Rl7J9SUv0aDDIx2DGvpYbaLQpPSYgJIDrxLl
         qjqFUgWKmPx9OGYuJisuhkoMB+226LCqRj+PH30FmG8NSFPalGLRRj2ry/mBRk3Yo+Jx
         YMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZCKR2KVToumZXg10SfRvbk1URc/xJPQvsDbss1BO/1o=;
        b=dYNtyqgnmeSbq7k7y/FPy4GVsYnHBys5lYD9eomYnoDwaF947jSr0NZ0mU3SNTtwik
         Lisglgl4UnsiASg89SodLbv5lPQXsOyGu+sEdbsYHkL5wGMUwxEsHpHQCoBQ8h7attFo
         2zPtbKrGAQSW4Id8LjXBvI1ysqQrfNoJi/xaR++auNnMWv7PrzOOayx0dvBFaytAUDNr
         uQA+/UmnO9GoPWQ4y36FWV7KVH1QsNr+kjnPdU+Kh49DNnCdB/c7oa5Cijxk9zB98aVZ
         W5RNyTXyG/AEze7+qwUswsvx6NnRJbcej5M2SRB92O5l/pfaBDTOfNGQ6szz9HJSYi9h
         85sQ==
X-Gm-Message-State: AOAM531vG7eGFVvKOFkdwYTvtMCzXqlSomb8L8ueYPb1BY77Yi+qMag+
        qHdIh1d2Ac5ENiemQ9LS4b8=
X-Google-Smtp-Source: ABdhPJwCNlzwTWdyYUV9nLIUQ8FyUrTnDjVEBuHktiZQfP4Wryqs2YCdeWG4ZYYFdtjeADhw7PCaWg==
X-Received: by 2002:a05:6a00:1307:b0:4b0:b1c:6fd9 with SMTP id j7-20020a056a00130700b004b00b1c6fd9mr15621633pfu.27.1652098158457;
        Mon, 09 May 2022 05:09:18 -0700 (PDT)
Received: from [172.30.1.40] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id y10-20020a170902d64a00b0015e8d4eb2d8sm6916016plh.290.2022.05.09.05.09.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 05:09:18 -0700 (PDT)
Message-ID: <94efefab-918d-2367-4b74-076dd6f23936@gmail.com>
Date:   Mon, 9 May 2022 21:09:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 1/2] dt-bindings: interconnect: Add MediaTek CCI
 dt-bindings
Content-Language: en-US
To:     Johnson Wang <johnson.wang@mediatek.com>, cw00.choi@samsung.com,
        krzk+dt@kernel.org, robh+dt@kernel.org, kyungmin.park@samsung.com
Cc:     khilman@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, jia-wei.chang@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220425125546.4129-1-johnson.wang@mediatek.com>
 <20220425125546.4129-2-johnson.wang@mediatek.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20220425125546.4129-2-johnson.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22. 4. 25. 21:55, Johnson Wang wrote:
> Add devicetree binding of MediaTek CCI on MT8183 and MT8186.
> 
> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> ---
>   .../bindings/interconnect/mediatek,cci.yaml   | 139 ++++++++++++++++++
>   1 file changed, 139 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml b/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
> new file mode 100644
> index 000000000000..e5221e17d11b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
> @@ -0,0 +1,139 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/mediatek,cci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Cache Coherent Interconnect (CCI) frequency and voltage scaling
> +
> +maintainers:
> +  - Jia-Wei Chang <jia-wei.chang@mediatek.com>

Why did you add your author information?
Please add your author information.

And add this dt-binding information to MAINTAINERS
as following: because I cannot catch the later patch
of modification.

cwchoi00@chanwoo:~/kernel/linux.chanwoo$ d
diff --git a/MAINTAINERS b/MAINTAINERS
index edc96cdb85e8..a11e9c1947b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5698,6 +5698,7 @@ L:        linux-pm@vger.kernel.org
  S:     Maintained
  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
  F:     Documentation/devicetree/bindings/devfreq/
+F:     Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
  F:     drivers/devfreq/
  F:     include/linux/devfreq.h
  F:     include/trace/events/devfreq.h


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
> +          The multiplexer for clock input of CPU cluster.
> +      - description:
> +          A parent of "cpu" clock which is used as an intermediate clock source
> +          when the original CPU is under transition and not stable yet.
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
> +      voltage. When it presents, the cci devfreq driver needs to do
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


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
