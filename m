Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D0157C86D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbiGUKAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 06:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbiGUKAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:00:00 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [5.144.164.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9869820F3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:59:57 -0700 (PDT)
Received: from SoMainline.org (D57D4C6E.static.ziggozakelijk.nl [213.125.76.110])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 08E341F661;
        Thu, 21 Jul 2022 11:59:53 +0200 (CEST)
Date:   Thu, 21 Jul 2022 11:59:46 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        jamipkettunen@somainline.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: power: rpmpd: Add SM6375 power domains
Message-ID: <20220721095946.wy3wbeib4ycwghzl@SoMainline.org>
References: <20220716193201.455728-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220716193201.455728-1-konrad.dybcio@somainline.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-16 21:32:00, Konrad Dybcio wrote:
> Add the bindings for SM6375 RPMPDs.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  .../devicetree/bindings/power/qcom,rpmpd.yaml        |  1 +
>  include/dt-bindings/power/qcom-rpmpd.h               | 12 ++++++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> index ad77a6380f38..8b58cbc298a1 100644
> --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> @@ -39,6 +39,7 @@ properties:
>        - qcom,sm6115-rpmpd
>        - qcom,sm6125-rpmpd
>        - qcom,sm6350-rpmhpd
> +      - qcom,sm6375-rpmpd
>        - qcom,sm8150-rpmhpd
>        - qcom,sm8250-rpmhpd
>        - qcom,sm8350-rpmhpd
> diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
> index 6cce5b7aa940..8b770bfcf46b 100644
> --- a/include/dt-bindings/power/qcom-rpmpd.h
> +++ b/include/dt-bindings/power/qcom-rpmpd.h
> @@ -36,6 +36,18 @@
>  #define SM6350_MSS	4
>  #define SM6350_MX	5
>  
> +/* SM6350 Power Domain Indexes */
> +#define SM6375_VDDCX		0
> +#define SM6375_VDDCX_AO	1
> +#define SM6375_VDDCX_VFL	2
> +#define SM6375_VDDMX		3
> +#define SM6375_VDDMX_AO	4
> +#define SM6375_VDDMX_VFL	5
> +#define SM6375_VDDGX		6
> +#define SM6375_VDDGX_AO	7
> +#define SM6375_VDD_LPI_CX	8
> +#define SM6375_VDD_LPI_MX	9

Looking at the naming/pattern of these constants I think they should
reside near the bottom of this file with SM6125 and friends, rather than
here with SM8150 and friends' MX/CX (and no _VFL).

- Marijn

>  /* SM8150 Power Domain Indexes */
>  #define SM8150_MSS	0
>  #define SM8150_EBI	1
> -- 
> 2.37.0
> 
