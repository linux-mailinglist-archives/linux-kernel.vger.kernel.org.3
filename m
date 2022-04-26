Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9330850EF19
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 05:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242844AbiDZDV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 23:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240250AbiDZDV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 23:21:26 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F2E939B3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 20:18:18 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id i38so11589990ybj.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 20:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ymvQGhwLD6LrQR70e/w6ZPsiExN1hAhcmAPj4jy8dAs=;
        b=hl9cabfzvJuk6NdpihUW2V6JgM6pg6VorWRkIKdEdXpq9fhgiWK1MzSd5HZrlZyDu5
         y9jb2HFJ4/ItQpenFhNgKyZCt9bfvcDzFEb6/J/2Mhi6v4gBi67b/bpNwZpHbDJcmNjE
         yxZ8PbmBCRO+dNafHrM8EWAipoRe7jmCdoCeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ymvQGhwLD6LrQR70e/w6ZPsiExN1hAhcmAPj4jy8dAs=;
        b=klvTuU5kaeljCNxdS2Z43PjDDW7UlPRSiR/KXBbz9VaRtpDgypfH9ux+qQuOH8/ohG
         hp2q4kDkAr3e5pAj7LnpmIxMecgN/Jl1DS73mSCYF+9WbKpYviZCXCy+HSXHkHrdUoRv
         dsSG4bA4B0+IZbvgbENoGa3hz7iJsrCFQJfPqmKQKQh8VfxCuOxT8XxRGyy4RyuY7STh
         572sUeY34vzm6zIb0if62CUvaSyOhnnSA2D59QcdUxX2ysXv4prqDM3uwS1FpmxphOC/
         6uoCVwOdtqzs6hy2nn46WV9p/7ARzLewZ8n81itucqAkXXzxd2oqRp5jVHHc78D7ztkn
         aPfg==
X-Gm-Message-State: AOAM531Exl5Sb4hSc7EuwSVGek1YPqVG+G1AJl8FqhdfW7sCnqaX1zuq
        W1EOzYlrh1/7SbBSXSOGohA6tE+zPW1XN5KAXeQR8g==
X-Google-Smtp-Source: ABdhPJyhHmusCSOHXNUImfAEEzGb8B8HQK3f3IeirnXiVrdZPW5jq5AEGz0c4s9rGNFdKqdnfg94FcKxSxPYMEgzAMs=
X-Received: by 2002:a5b:34a:0:b0:645:4966:b5d3 with SMTP id
 q10-20020a5b034a000000b006454966b5d3mr18130893ybp.461.1650943097894; Mon, 25
 Apr 2022 20:18:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220425125546.4129-1-johnson.wang@mediatek.com> <20220425125546.4129-2-johnson.wang@mediatek.com>
In-Reply-To: <20220425125546.4129-2-johnson.wang@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 26 Apr 2022 11:18:06 +0800
Message-ID: <CAGXv+5HgyN+kp86M2GgFtbruXSAMSLxsh9vf8zVE5TxRMyTyaA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: interconnect: Add MediaTek CCI dt-bindings
To:     Johnson Wang <johnson.wang@mediatek.com>, krzk+dt@kernel.org
Cc:     cw00.choi@samsung.com, robh+dt@kernel.org,
        kyungmin.park@samsung.com, khilman@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, jia-wei.chang@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 8:56 PM Johnson Wang <johnson.wang@mediatek.com> wrote:
>
> Add devicetree binding of MediaTek CCI on MT8183 and MT8186.
>
> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> ---
>  .../bindings/interconnect/mediatek,cci.yaml   | 139 ++++++++++++++++++
>  1 file changed, 139 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
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

of the bus, not CPU cluster.

> +      - description:
> +          A parent of "cpu" clock which is used as an intermediate clock source
> +          when the original CPU is under transition and not stable yet.

This really should be handled in the clk controller, and not by every device
that happens to take a clock from a mux with upstream PLLs that can change
in clock rate. The end device hardware only takes one clock input. That's it.

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

When it is present, the implementation needs to ...

ChenYu

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
> --
> 2.18.0
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
