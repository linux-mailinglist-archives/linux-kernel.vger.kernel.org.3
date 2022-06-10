Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9D354672A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 15:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345684AbiFJNMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 09:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbiFJNMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 09:12:43 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E2D101D3;
        Fri, 10 Jun 2022 06:12:39 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id p128so5780972iof.1;
        Fri, 10 Jun 2022 06:12:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=P6vSzHEUiako1y5dB9/gimIULLRnQi4GWLiXOFtbXkE=;
        b=twpd+Lk+KaANN5pWa0hN6nfSl/GoGPi7BEL2MmT47i5VBklltcOhkiF3VwWL+lMPMj
         mLlzx3r0XhhsApxNIFfY7CfKPRTkiuCg+GRPhgnVG1F8FIPgbxtjW7NXwllb7Z/V0JCH
         2IPWB7BO5wgbX1J0mvTNnEXOqy3DEYlTOdXEIsyR4r3j121zKa0RIvH0CIJiNEUhRtxB
         7iuYJ8YsUxRszFfU94Yd5Xce2nddGJmIo5Y5ZYVJuIPalFfD7HBbMPkqyGb4XwwjGy6V
         L6KWG+2MfzZTiAtyvfCEmtOWxDA9b11M5cikmAOR8aSdb99UyWG4O5mYLHKtr1nTGLgS
         9OAA==
X-Gm-Message-State: AOAM530iuXiLJJrV3E74rsxxOXxdpy3/y+kshA+V83j2KEC44JeOeBrx
        H+QqZZdmvp0WaT+4xD4HOTA+ict9Mg==
X-Google-Smtp-Source: ABdhPJz5wGx6Ou1JgXidNNZx2owmPU+xXR1z5MNKoC9tJp1MevK60+xBnAQnpCQ3en4ELcTh0ns5wQ==
X-Received: by 2002:a5e:c30b:0:b0:668:825c:8556 with SMTP id a11-20020a5ec30b000000b00668825c8556mr21667029iok.68.1654866758196;
        Fri, 10 Jun 2022 06:12:38 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id y14-20020a927d0e000000b002d53be43069sm6628542ilc.64.2022.06.10.06.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 06:12:37 -0700 (PDT)
Received: (nullmailer pid 1529402 invoked by uid 1000);
        Fri, 10 Jun 2022 13:12:35 -0000
From:   Rob Herring <robh@kernel.org>
To:     Mao Jinlong <quic_jinlmao@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tao Zhang <quic_taozha@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Hao Zhang <quic_hazha@quicinc.com>,
        Mike Leach <mike.leach@linaro.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        coresight@lists.linaro.org, Konrad Dybcio <konradybcio@gmail.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>
In-Reply-To: <20220610032144.5173-4-quic_jinlmao@quicinc.com>
References: <20220610032144.5173-1-quic_jinlmao@quicinc.com> <20220610032144.5173-4-quic_jinlmao@quicinc.com>
Subject: Re: [PATCH v9 03/10] dt-bindings: arm: Adds CoreSight TPDM hardware definitions
Date:   Fri, 10 Jun 2022 07:12:35 -0600
Message-Id: <1654866755.742985.1529401.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jun 2022 11:21:37 +0800, Mao Jinlong wrote:
> Adds new coresight-tpdm.yaml file describing the bindings required
> to define tpdm in the device trees.
> 
> Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Reviewed-by: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  .../bindings/arm/qcom,coresight-tpdm.yaml     | 92 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.example.dtb: tpdm@684c000: reg: [[0, 109363200], [0, 4096]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

