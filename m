Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4176581482
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 15:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239090AbiGZNv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 09:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiGZNvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 09:51:24 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AFA248F8;
        Tue, 26 Jul 2022 06:51:23 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id j8-20020a4ac548000000b00435a8dd31a2so2704394ooq.5;
        Tue, 26 Jul 2022 06:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=HiXEINpO7lJwQ19AUjXbs1PrMxkFfOMOx70lfbDqY6E=;
        b=n6u9f+MiaF5bB9z9KxYv1EEoIQolktMrFcXlZaR6elUb1eYhMSRT9h9wrcht2WuN1a
         8IVVTkDIN/fLLxZz6/jHXcP2Nqnbq8bN+kI01bTrMZyn/rD+68vqqsor1Hyk+uX4Q+9E
         4WERYLZiZrj3ZZKMnCrkZbXHmOTqYRTn/mvNxY19vEhNrMcXOa3QzyZCix1s1m6iX+x6
         znI3LWD2BzD458fJw4siScIcTA6EnPJXmNll7vdvF7gow/+p914mSQdABJ3zzN0tMELP
         9r/b8AzV0zdh2IgbDC+69QAhtC1Ow0F04w78kCBZw5deZVekUm43c06/YH1ST2adHyan
         koew==
X-Gm-Message-State: AJIora/+IzkY8KUC/6ysRVwtSPrsGIEhG24PyAGvnS3SItywS2XtX8Wt
        n13TU/8FmqLB1AopeRHsfQ==
X-Google-Smtp-Source: AGRyM1tISzQEnJ8IXUsJMJfyTM8WpziZTe+jkOfpOkFJ3zID1mQUqV+7u+K4BWFImbPYBl39ld4cXw==
X-Received: by 2002:a4a:d74b:0:b0:435:e367:d096 with SMTP id h11-20020a4ad74b000000b00435e367d096mr4204102oot.50.1658843482493;
        Tue, 26 Jul 2022 06:51:22 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id l11-20020a9d550b000000b0061ca92ae442sm6082110oth.72.2022.07.26.06.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 06:51:21 -0700 (PDT)
Received: (nullmailer pid 179938 invoked by uid 1000);
        Tue, 26 Jul 2022 13:51:16 -0000
From:   Rob Herring <robh@kernel.org>
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     sboyd@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        lee.jones@linaro.org, linux-clk@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, zhang.lyra@gmail.com,
        mturquette@baylibre.com, baolin.wang7@gmail.com,
        orsonzhai@gmail.com
In-Reply-To: <20220726102404.564498-2-gengcixi@gmail.com>
References: <20220726102404.564498-1-gengcixi@gmail.com> <20220726102404.564498-2-gengcixi@gmail.com>
Subject: Re: [PATCH V6 1/2] dt-bindings: mfd: sprd: Add bindings for ums512 global registers
Date:   Tue, 26 Jul 2022 07:51:16 -0600
Message-Id: <1658843476.642236.179937.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2022 18:24:03 +0800, Cixi Geng wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> Add bindings for Unisoc system global register which provide register map
> for clocks.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/mfd/sprd,ums512-glbreg.yaml      | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/clock/sprd,ums512-clk.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.example.dtb: syscon@71000000: clock-controller@0: False schema does not allow {'compatible': ['sprd,ums512-apahb-gate'], 'reg': [[0, 8192]], '#clock-cells': [[1]]}
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.example.dtb:0:0: /example-0/syscon@71000000/clock-controller@0: failed to match any schema with compatible: ['sprd,ums512-apahb-gate']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

