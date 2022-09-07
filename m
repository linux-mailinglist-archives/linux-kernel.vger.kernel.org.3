Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077A25B0BD7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 19:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiIGRxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 13:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiIGRxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 13:53:04 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22579E885;
        Wed,  7 Sep 2022 10:53:02 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1278624b7c4so19688358fac.5;
        Wed, 07 Sep 2022 10:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=0N7indwEWNDLUfh9nzv03hTWDqZDGMDUSanpWNLjPkE=;
        b=ZRmnoTngUTwewA5ohg96sZEXphzkFfiNwoHcvceoZdfq28To/soRw8kipUa5lHDyxt
         o3RyKCGFsQb/ueGmUV3j6Bxd1oc5G5wn+r5K2mVc5Mz3gUNfpq6/qcLffdroWuc1XVJk
         uIz8MKds5NNAKnQoLM2vcenxzP076SKvsy97gK31zgLsY8LRnnb3WZzqCPigwCdJ7T2B
         6GSvnumCuEaYHSXSImozDAIrLdyYMG9eK3KDxqot3HASsSwH0xiTeH9X+qxgSXVjpnGr
         l3idncPqTydgQ4p2i+ZJrNtxvW448tOs0n6LGQRytbJVsbseiWIpU3QTGwV+xmQmYp1V
         Zo9A==
X-Gm-Message-State: ACgBeo2tB2ipmWsavqjG1kBJY0ew3v69ZNPQlpJhasrMTYbGhAVZLmkY
        9smwIsrX3O/oHZeki1OwgA==
X-Google-Smtp-Source: AA6agR7k0HGz1SBz7Bg+JULUAdmjfDYE7RHVkqJna8fZHBQdcH3EcCL3VFYCMpMNoCP853yvFELu4A==
X-Received: by 2002:a05:6870:4614:b0:125:72da:9b2b with SMTP id z20-20020a056870461400b0012572da9b2bmr12652128oao.118.1662573181889;
        Wed, 07 Sep 2022 10:53:01 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l3-20020a056870f14300b0012752d3212fsm4937419oac.53.2022.09.07.10.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 10:53:01 -0700 (PDT)
Received: (nullmailer pid 3789429 invoked by uid 1000);
        Wed, 07 Sep 2022 17:53:00 -0000
Date:   Wed, 7 Sep 2022 12:53:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Richard Acayan <mailingradian@gmail.com>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tdas@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, caleb@connolly.tech,
        jo@jsfamily.in
Subject: Re: [PATCH 1/3] dt-bindings: clock: gcc-sdm845: add sdm670 global
 clocks
Message-ID: <20220907175300.GA3779566-robh@kernel.org>
References: <20220907025035.15609-1-mailingradian@gmail.com>
 <20220907025035.15609-2-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907025035.15609-2-mailingradian@gmail.com>
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

On Tue, Sep 06, 2022 at 10:50:33PM -0400, Richard Acayan wrote:
> The Snapdragon 670 clocks will be added into the sdm845 gcc driver. Most
> of the new clocks, GDSCs, and resets already have reserved IDs but there
> are some resources that don't. Add the new clock and extra BCR from
> Snapdragon 670 and document the differences between the SoC parent clocks.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
>  .../bindings/clock/qcom,gcc-sdm845.yaml       | 24 +++++++++++++++----
>  include/dt-bindings/clock/qcom,gcc-sdm845.h   |  2 ++
>  2 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml b/Documentation/defaced/bindings/clock/qcom,gcc-sdm845.yaml
> index daf7906ebc40..ba94dd32e619 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml
> @@ -19,23 +19,21 @@ description: |
>  
>  properties:
>    compatible:
> -    const: qcom,gcc-sdm845
> +    enum:
> +      - qcom,gcc-sdm670
> +      - qcom,gcc-sdm845
>  
>    clocks:
>      items:
>        - description: Board XO source
>        - description: Board active XO source
>        - description: Sleep clock source
> -      - description: PCIE 0 Pipe clock source
> -      - description: PCIE 1 Pipe clock source

You just changed the clocks from 5 to 3. Please test your changes:

/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.example.dtb: clock-controller@100000: clocks: [[4294967295, 0], [4294967295, 1], [4294967295], [4294967295], [4294967295]] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.example.dtb: clock-controller@100000: clock-names: ['bi_tcxo', 'bi_tcxo_ao', 'sleep_clk', 'pcie_0_pipe_clk', 'pcie_1_pipe_clk'] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.example.dtb: clock-controller@100000: clocks: [[4294967295, 0], [4294967295, 1], [4294967295], [4294967295], [4294967295]] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.example.dtb: clock-controller@100000: clock-names:0: 'pcie_0_pipe_clk' was expected
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.example.dtb: clock-controller@100000: clock-names:1: 'pcie_1_pipe_clk' was expected
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.example.dtb: clock-controller@100000: clock-names: ['bi_tcxo', 'bi_tcxo_ao', 'sleep_clk', 'pcie_0_pipe_clk', 'pcie_1_pipe_clk'] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml

What you want here I think is 'minItems: 3' and then restrict the clocks 
to 3 or 5 in the if/then schema.

Rob
