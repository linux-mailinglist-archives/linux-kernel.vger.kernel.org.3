Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDCD519163
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 00:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243699AbiECWZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 18:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243649AbiECWZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 18:25:30 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4F640A26;
        Tue,  3 May 2022 15:21:57 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id v65so19617920oig.10;
        Tue, 03 May 2022 15:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=OSLTDCz5wo2JoJLvzX6uS8zgmzcMDJX9Q7s2zJJuaxA=;
        b=IK7+9NrERJiwVThbT5W4NKGMf3QL62lRTf7TRLZChOjBhl30usCNIGSi4vCeR61+jh
         EDgMG7OLSk7nnGa+a8R4gaN3BPU0GpqTsoMTMcbBBSrn2NMlz1RT9w70Kp5o1U+LXk2N
         ES31TLwoDi64166alXcaNYgV1MaGRl8M7i2efKNMQnnJiOSY2+/DgPwbZGbBw7rN2wPB
         8JrMdz9GqVxeO7kWuC5Gng3SVogVQcipM3XoayZvxroDpgkw9uHWlE4DAtswlbTrodDA
         8vUQ/pImX+38YT+ie6KpIgd9VALZvHQU6fzXEwz/gYl296N8dGrI7/MLCBGIgqpYiXpV
         PJBg==
X-Gm-Message-State: AOAM5315xf6PH57r8hWhVMMebxJmBQDc7pTpVPYtyEVT0g27BWxIVwZD
        kK6KBDv5cnyzCg8BiWgp9dZwS4yB4w==
X-Google-Smtp-Source: ABdhPJx5INNn38v4TDM5wD8bxSFNca1P0/aa3o058Xc7kDhuig9wsXCfl69wBBxg+VrUV1x9E+mPfQ==
X-Received: by 2002:a05:6808:1441:b0:325:7604:4ec1 with SMTP id x1-20020a056808144100b0032576044ec1mr2746356oiv.1.1651616516541;
        Tue, 03 May 2022 15:21:56 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z17-20020a05683020d100b0060603221244sm4497062otq.20.2022.05.03.15.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 15:21:56 -0700 (PDT)
Received: (nullmailer pid 139792 invoked by uid 1000);
        Tue, 03 May 2022 22:21:51 -0000
From:   Rob Herring <robh@kernel.org>
To:     Quentin Schulz <foss+kernel@0leil.net>
Cc:     linux-kernel@vger.kernel.org, mchehab@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        robh+dt@kernel.org, linux-media@vger.kernel.org,
        shawnx.tu@intel.com
In-Reply-To: <20220503154259.1166203-1-foss+kernel@0leil.net>
References: <20220503154259.1166203-1-foss+kernel@0leil.net>
Subject: Re: [PATCH 1/3] media: dt-bindings: ov5675: document YAML binding
Date:   Tue, 03 May 2022 17:21:51 -0500
Message-Id: <1651616511.172886.139791.nullmailer@robh.at.kernel.org>
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

On Tue, 03 May 2022 17:42:57 +0200, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> This patch adds documentation of device tree in YAML schema for the
> OV5675 CMOS image sensor from Omnivision.
> 
> Cc: Quentin Schulz <foss+kernel@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
>  .../bindings/media/i2c/ovti,ov5675.yaml       | 137 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 138 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov5675.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/media/i2c/ovti,ov5675.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/media/i2c/ovti,ov5675.yaml#
Error: Documentation/devicetree/bindings/media/i2c/ovti,ov5675.example.dts:30.39-40 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:364: Documentation/devicetree/bindings/media/i2c/ovti,ov5675.example.dtb] Error 1
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

