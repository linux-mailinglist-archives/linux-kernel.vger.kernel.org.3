Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAB44F1FC6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 01:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238202AbiDDXFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 19:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241388AbiDDXFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 19:05:34 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1376EB0F;
        Mon,  4 Apr 2022 15:27:49 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id k10so11621780oia.0;
        Mon, 04 Apr 2022 15:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=21RYx1siUXFRLcSMfYzZjQ6/E/QTCX038TIQLde76lI=;
        b=7d5l8+rrTgeuOPwvzBZ5TVDccqB/y5/2pR8xe4Yl3dc39EBQTQxXvd14T95JRya3kQ
         pgPqbz5ew54u01E8PM6AICug5z1vSyDAZoeXS/juKKaiYrL9XOLlv5+mKNdWjX4V2Fxd
         l+vHMw94EdbkKu9pCWGdyz6EH6iU3WRTS6lcQStVpW6qiHs79Kx4ebd4g4+TBftkwEBD
         4DrpXuuEHmwM+R28+sUQ0Ay/YsRQVgBf6gewZtdgn2UWd+9dDNLbMXl4ZhLx2kgERPsl
         wWxDtyKqhdxllr74svRe8uxGA51T2r6DRmkTiTH1vgi/w5MB/EnaquxJ/Hmh12BzZQea
         rEWA==
X-Gm-Message-State: AOAM53077qKhIIAWuYXKwbEpidC6LyB5uDL8GmX7FX0zH0eLSevRv3Xg
        WpkGLXKNzwkAG/mNegmYXw==
X-Google-Smtp-Source: ABdhPJyWF91xQnODnm0DqGriBHyrjc+a5lRFRjRBgVc75n8XH2jeXM4ob5qMfO6szxo4J8zdWEKH2g==
X-Received: by 2002:aca:f10:0:b0:2ef:9dd9:79fb with SMTP id 16-20020aca0f10000000b002ef9dd979fbmr229194oip.282.1649111268742;
        Mon, 04 Apr 2022 15:27:48 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 11-20020a05687013cb00b000dd9b5dd71csm4731995oat.56.2022.04.04.15.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 15:27:48 -0700 (PDT)
Received: (nullmailer pid 2113248 invoked by uid 1000);
        Mon, 04 Apr 2022 22:27:47 -0000
Date:   Mon, 4 Apr 2022 17:27:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-remoteproc@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 08/10] dt-bindings: soc: qcom,smd: convert to dtschema
Message-ID: <Yktw42ujYEJQH2l9@robh.at.kernel.org>
References: <20220401201035.189106-1-krzysztof.kozlowski@linaro.org>
 <20220401201035.189106-9-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401201035.189106-9-krzysztof.kozlowski@linaro.org>
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

On Fri, 01 Apr 2022 22:10:33 +0200, Krzysztof Kozlowski wrote:
> Convert the Qualcomm Shared Memory Driver bindings to DT Schema.
> 
> Changes against original bindings: enforce only specific names of child
> nodes, instead of any names.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../regulator/qcom,smd-rpm-regulator.yaml     |   2 +-
>  .../bindings/remoteproc/qcom,q6v5.txt         |   2 +-
>  .../bindings/remoteproc/qcom,wcnss-pil.txt    |   2 +-
>  .../bindings/soc/qcom/qcom,smd-rpm.yaml       |   4 +-
>  .../devicetree/bindings/soc/qcom/qcom,smd.txt |  98 -------------
>  .../bindings/soc/qcom/qcom,smd.yaml           | 137 ++++++++++++++++++
>  6 files changed, 142 insertions(+), 103 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
