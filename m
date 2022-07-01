Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED03563B3B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 22:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbiGAUmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 16:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiGAUmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 16:42:22 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7172F5A2EC;
        Fri,  1 Jul 2022 13:42:21 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id l24so3315561ion.13;
        Fri, 01 Jul 2022 13:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vM/upYcwOh1+SZ1rqeo3tt3B3M86DMnseUqG48wZe5k=;
        b=7xG7mc92qYmhyXmNXYy5Hqs2QuctA89zwan3DdDemet+/Viry344T8gzqWsdr1WL+J
         VaMsRHMDK2RNY2OFkxD3wcKaea7hhiIiSI0d3GvnVQdFXe1EJDpPXNfTdAnk1io1fTp9
         lvvSXZonWxNgXrT/IS603DyaXB0ql5fHh38VgpbK3dUDPich6dT2l6nyYjY4rbzPVmtd
         oqiMzxmbIyF8zaNxYDXXb7f6TjgV7f6D4TIL4WW//Q3yk1iSN5capaXyHCp8FuQ+3F1N
         TlVIgetM8GPSmmP/Ml/81AvkkqOoIp4pwYDojeZfPLdz42c9ha5/vxb2a3eEsLhH8Vr7
         pc+g==
X-Gm-Message-State: AJIora+bBkpPV2Gs2cSTuMeebBL2aAlH8c8UGpQqsFF/vPVFst8Iux+j
        vo6mkG5K/uXt7K4yqir9SMRFRPVtbg==
X-Google-Smtp-Source: AGRyM1v30pRisZeVusp5pd7mbB1cRaCLYFygRA7dI5dnmQ0SINatHfddKzyi0/9QX6rZPAvfD4uPNQ==
X-Received: by 2002:a05:6602:1409:b0:5e7:487:133c with SMTP id t9-20020a056602140900b005e70487133cmr8708481iov.196.1656708140714;
        Fri, 01 Jul 2022 13:42:20 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id a14-20020a056638018e00b00335d7c314b1sm10199730jaq.53.2022.07.01.13.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 13:42:20 -0700 (PDT)
Received: (nullmailer pid 1490617 invoked by uid 1000);
        Fri, 01 Jul 2022 20:42:18 -0000
Date:   Fri, 1 Jul 2022 14:42:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Subject: Re: [PATCH] dt-bindings: qcom: readme: document preferred compatible
 naming
Message-ID: <20220701204218.GA1478943-robh@kernel.org>
References: <20220701074659.12680-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701074659.12680-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 09:46:59AM +0200, Krzysztof Kozlowski wrote:
> Compatibles can come in two formats.  Either "vendor,ip-soc" or
> "vendor,soc-ip".  Qualcomm bindings were mixing both of usages, so add a
> readme file documenting preferred policy.

Is this all I needed to do to stop this from QCom? </sarcasm>

This convention is not QCom specific, though the error mostly is. 
Perhaps this should be documented generically.

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Alex Elder <elder@linaro.org>
> Cc: Robert Foss <robert.foss@linaro.org>
> Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  .../devicetree/bindings/soc/qcom/README.rst      | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/README.rst
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/README.rst b/Documentation/devicetree/bindings/soc/qcom/README.rst
> new file mode 100644
> index 000000000000..322b329ac7c1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/README.rst
> @@ -0,0 +1,16 @@
> +.. SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +
> +Qualcomm SoC compatibles naming convention
> +==========================================
> +1. When adding new compatibles in new bindings, use the format:
> +   ::
> +
> +     qcom,SoC-IP
> +
> +   For example:
> +   ::
> +
> +     qcom,sdm845-llcc-bwmon

Assuming the list of possible SoCs was maintained, you could make this a 
schema. Though there might be false positives.

> +
> +2. When adding new compatibles to existing bindings, use the format
> +   in the existing binding, even if it contradicts the above.
> -- 
> 2.34.1
> 
> 
