Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D354E27AE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348037AbiCUNhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347981AbiCUNgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:36:44 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150A24578D;
        Mon, 21 Mar 2022 06:35:18 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id s207so16173705oie.11;
        Mon, 21 Mar 2022 06:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=S2GuADLnX7EW41noVu93sHqs9Lbgazi9/yDQcIAi5Wc=;
        b=y1jDAZwMYKPkZuMJYL0bHxrZTG1u3Ed/FQU0EANSRrWwYGqJXqj2YaI+ms1+JZD9ta
         s0cqgRrtREFask2bFpi86MUZcZ9bXufXkpjGNzlWPm7AINqdHFYfWrl142wb4h3mDAOZ
         WweeY2f6ijkZy54VPkb9k2H4KE1UbzsD3bs84XcLBmw14A9bOtoSe8G+oWJYLxuVmKsx
         iPv80yLuzNK7kWNI9ynsU7+gvsJBjaG9r6ld5dnfNwBd6DfCYcCVCjEa+AtNEV2ZEEV9
         2lRElvwrA23BpO+vxJ2pBA3/POg8w7EDN4YnHyYV+evipfErwDdoVqXi+2NCCfvZySw0
         7b9w==
X-Gm-Message-State: AOAM533IXxWF8k54AT4RPTp5zMQhZnHzqxwgWZ78+cv2coavpNBRVrq6
        EqKQUK1Cw+XcmWZQecY/zA==
X-Google-Smtp-Source: ABdhPJxEA74G16aYEqeW41u74KbLaxDoBd85+ca8QMYz0TXyuzP2MUVWIRB/erpgsYlB7cwckcSjOQ==
X-Received: by 2002:a05:6808:2112:b0:2da:58c4:ec54 with SMTP id r18-20020a056808211200b002da58c4ec54mr13866628oiw.32.1647869717400;
        Mon, 21 Mar 2022 06:35:17 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 37-20020a9d0ea8000000b005cb439f7a8csm4737237otj.62.2022.03.21.06.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 06:35:16 -0700 (PDT)
Received: (nullmailer pid 4125322 invoked by uid 1000);
        Mon, 21 Mar 2022 13:35:11 -0000
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220320113430.26076-19-ansuelsmth@gmail.com>
References: <20220320113430.26076-1-ansuelsmth@gmail.com> <20220320113430.26076-19-ansuelsmth@gmail.com>
Subject: Re: [PATCH v3 18/18] dt-bindings: arm: msm: Convert kpss-gcc driver Documentation to yaml
Date:   Mon, 21 Mar 2022 08:35:11 -0500
Message-Id: <1647869711.869921.4125321.nullmailer@robh.at.kernel.org>
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

On Sun, 20 Mar 2022 12:34:30 +0100, Ansuel Smith wrote:
> Convert kpss-gcc driver Documentation to yaml.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/arm/msm/qcom,kpss-gcc.txt        | 44 ------------
>  .../bindings/arm/msm/qcom,kpss-gcc.yaml       | 68 +++++++++++++++++++
>  2 files changed, 68 insertions(+), 44 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml:20:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1607459

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

