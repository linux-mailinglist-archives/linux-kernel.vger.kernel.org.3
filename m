Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C054D8721
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 15:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240170AbiCNOoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 10:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238554AbiCNOoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 10:44:06 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8FD2657;
        Mon, 14 Mar 2022 07:42:56 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id r2so18430576iod.9;
        Mon, 14 Mar 2022 07:42:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=ZFm3098Qq38ZihocmoyjymWLRXt7L5rX0Wix1tDlZKI=;
        b=7XCQEwPqbLm5tVah6hX9ZlYpSUfbq7s9t1GRlAWDlOfwQZxwH/yzmW6slLpGKUurL8
         qou+/KHhapWzDM4MIHyzqGSE0x5S8tR4B/bOsAVDIbolpI/7/bj+lRGb0b8ZtYkXS1Zx
         IY7MdBp4Srg+KIyT5EF21LR81ZlTf34u1xr8Fgg9OQIJGkPiCAYF0lNCMdKtwkdabGNa
         c+4E1oK8nkJ1vehfZeYTm9oWDuqoTIJ/+Y1iZ/LHI3q3A/SAOTU1jMvLRSZ9XttD2pr9
         EC++C/iZdgBs0Uq/zrhc7YwBli5+kkXiO+0ZmnUck8rqTPPk4thPRFxE1oLrPnUDQ/50
         yVvA==
X-Gm-Message-State: AOAM530/bxXQ4Sqy/ZUGxbVRnKQa0dNEobHsQlGhImkJBUEfVvoxblYX
        wifZ93gP4PCeQU9vfPL6NL/S00Fb6w==
X-Google-Smtp-Source: ABdhPJyQaBTGAIetjdRf6giyx6SU7LHoFADIdsRp3lXRCDkqAdzyIb0mzuwjvoX1KW3dUpVp8++XJA==
X-Received: by 2002:a02:6910:0:b0:319:4f4c:eede with SMTP id e16-20020a026910000000b003194f4ceedemr20591642jac.301.1647268976134;
        Mon, 14 Mar 2022 07:42:56 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id a4-20020a5d9544000000b00640a6eb6e1esm8957167ios.53.2022.03.14.07.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 07:42:55 -0700 (PDT)
Received: (nullmailer pid 12511 invoked by uid 1000);
        Mon, 14 Mar 2022 14:42:49 -0000
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
In-Reply-To: <20220313190419.2207-17-ansuelsmth@gmail.com>
References: <20220313190419.2207-1-ansuelsmth@gmail.com> <20220313190419.2207-17-ansuelsmth@gmail.com>
Subject: Re: [PATCH 16/16] dt-bindings: arm: msm: Convert kpss driver Documentation to yaml
Date:   Mon, 14 Mar 2022 08:42:49 -0600
Message-Id: <1647268969.336967.12510.nullmailer@robh.at.kernel.org>
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

On Sun, 13 Mar 2022 20:04:19 +0100, Ansuel Smith wrote:
> Convert kpss-acc and kpss-gcc Documentation to yaml. Fix multiple
> Documentation error and provide additional example for kpss-gcc-v2.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/arm/msm/qcom,kpss-acc.txt        | 49 ----------
>  .../bindings/arm/msm/qcom,kpss-acc.yaml       | 97 +++++++++++++++++++
>  .../bindings/arm/msm/qcom,kpss-gcc.txt        | 44 ---------
>  .../bindings/arm/msm/qcom,kpss-gcc.yaml       | 62 ++++++++++++
>  4 files changed, 159 insertions(+), 93 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml:62:4: [error] no new line character at the end of file (new-line-at-end-of-file)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1604836

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

