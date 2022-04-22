Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC3350C31C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbiDVWTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbiDVWSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:18:49 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130B6694B7;
        Fri, 22 Apr 2022 14:10:49 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-e5ca5c580fso9912442fac.3;
        Fri, 22 Apr 2022 14:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Tkutjbl6M6F7ROD9a26bDdNrkbSWhhcwmMr6zx2IOcE=;
        b=ZirOYALXVp6GpUyspYwVQMB5/ICgiyzdUUCALQdL5D0dC4yyfuofhyDQOOf5gCb3L/
         hNkS3ERBwQIvcphCUsvMlB3EKZej8bPNbgaDjz9XGJDgJ3qoPm8hx0v4/QdMVrEEH7yU
         iOpNLhHuOCEbNJlWDJuFdV9xtb07K9qM4sJeeRQbH36bIa2xkCktRzWjLpJTTO2OLLVj
         GMZIjIftJ2VnInLi7VVe1dNc/uPVd0qyIk6WDzUY18sR6EHihbMkUPitBOTcoiCjfK+b
         kLlBvY2nZRBaQ9HhuxH0HMa7RANK3O7qSz/2lFP06xTGeDqJc5tN0uH5yJ08+zzVGHza
         vC5Q==
X-Gm-Message-State: AOAM530w44R8gm1wa/QEw6zZLxTgVfXf/LXDBWVIvBoKlZa0t/MVTuYC
        DEyeYTpoeSdVLsL+EDAjJQ==
X-Google-Smtp-Source: ABdhPJxgDVs7xvcysn1Di8tXdOlKYuPI1U7BFRO4ay+lXkeVtgeYsglZ1My+1O/4c4tx67VSav4XdA==
X-Received: by 2002:a05:6870:9689:b0:e6:bcf:4b6 with SMTP id o9-20020a056870968900b000e60bcf04b6mr6980687oaq.64.1650661848365;
        Fri, 22 Apr 2022 14:10:48 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u20-20020a4a9e94000000b003291f6ac4b2sm1238286ook.28.2022.04.22.14.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 14:10:47 -0700 (PDT)
Received: (nullmailer pid 2784281 invoked by uid 1000);
        Fri, 22 Apr 2022 21:10:47 -0000
From:   Rob Herring <robh@kernel.org>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220422071534.15653-1-tinghan.shen@mediatek.com>
References: <20220422071534.15653-1-tinghan.shen@mediatek.com>
Subject: Re: [PATCH v1] dt-bindings: dsp: mediatek: add mt8186 dsp document
Date:   Fri, 22 Apr 2022 16:10:47 -0500
Message-Id: <1650661847.232289.2784280.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022 15:15:34 +0800, Tinghan Shen wrote:
> This patch adds mt8186 dsp document. The dsp is used for Sound Open
> Firmware driver node. It includes registers, clocks, memory regions,
> and mailbox for dsp.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
> 
> This patch depends on MT8186 clock bindings.
> https://lore.kernel.org/all/20220409132251.31725-2-chun-jie.chen@mediatek.com/
> 
> ---
>  .../bindings/dsp/mediatek,mt8186-dsp.yaml     | 93 +++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dsp/mediatek,mt8186-dsp.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/dsp/mediatek,mt8186-dsp.example.dts:22:18: fatal error: dt-bindings/clock/mt8186-clk.h: No such file or directory
   22 |         #include <dt-bindings/clock/mt8186-clk.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:364: Documentation/devicetree/bindings/dsp/mediatek,mt8186-dsp.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1401: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

