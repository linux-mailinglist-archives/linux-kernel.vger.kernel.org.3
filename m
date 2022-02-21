Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA424BD402
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 03:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343912AbiBUCgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 21:36:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343899AbiBUCgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 21:36:39 -0500
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8123DDE0;
        Sun, 20 Feb 2022 18:36:17 -0800 (PST)
Received: by mail-il1-f180.google.com with SMTP id v3so3705222ilc.7;
        Sun, 20 Feb 2022 18:36:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=wRFWj5y7LotFUBPpzxeU6otCQ7nXTU9SS+1E8PK2qJM=;
        b=mzZ7iR4UMsXBYtdmauaqH3R33lIfa/yioCpz1b3BljoMYTkMbTea45XlxBVGbPzbyb
         EKlLfM+KkWXgaZUw7TUsWhiqASS+E25PKIZP3jgfPhxg5byt46eBUQgT0XgfKnEb8eKM
         sOfM1+34y9LBBP9IslYGaBfBJKv6R5iatLY90vVTXEBDKveVIVi3XnbhHvVCNZnCHj7i
         g7e7nb2S7NofOyWUAAhHH3f+mRvq3sLjob0+2jSC26hXyqKc587zBmCIdNiQ+ny6C16W
         GZE9A4zpwwtXybHZjoJIBGKbIWFPdSQYVE+7vYBpSOENcPAu2kKBjj4QTNKhkwSxHyKN
         f3Qg==
X-Gm-Message-State: AOAM533peMlbzxmNMNaNwCPun4IOmJ7zFVrOEbVuyY9kCMdX/m41diEp
        2u1sI4aBdC5/kOolg52KjQ==
X-Google-Smtp-Source: ABdhPJygy6KKg5suAr0e2xSLMVxXh3lQT8BgBETmXxuwuEoAWuxc8fjfq5Z3jV+QHiMRkztWvbEg3A==
X-Received: by 2002:a05:6e02:1d0d:b0:2c2:1d2c:5b2d with SMTP id i13-20020a056e021d0d00b002c21d2c5b2dmr5666690ila.168.1645410977178;
        Sun, 20 Feb 2022 18:36:17 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id c21sm4035829ioh.35.2022.02.20.18.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 18:36:16 -0800 (PST)
Received: (nullmailer pid 2041537 invoked by uid 1000);
        Mon, 21 Feb 2022 02:36:09 -0000
From:   Rob Herring <robh@kernel.org>
To:     Max Buchholz <max.buchholz@gmx.de>
Cc:     devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-input@vger.kernel.org, Max Buchholz <Max.Buchholz@gmx.de>
In-Reply-To: <20220218101011.22988-1-max.buchholz@gmx.de>
References: <20220218101011.22988-1-max.buchholz@gmx.de>
Subject: Re: [PATCH] dt-bindings: nvidia,tegra20-kbc: Convert to json-schema
Date:   Sun, 20 Feb 2022 20:36:09 -0600
Message-Id: <1645410969.330994.2041536.nullmailer@robh.at.kernel.org>
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

On Fri, 18 Feb 2022 11:10:10 +0100, Max Buchholz wrote:
> From: Max Buchholz <Max.Buchholz@gmx.de>
> 
> This converts the Nvidia Tegra keyboard controller bindings to YAML
> and fix them up a bit.
> 
> Acked-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: Max Buchholz <max.buchholz@gmx.de>
> ---
>  .../bindings/input/nvidia,tegra20-kbc.txt     |  55 ---------
>  .../bindings/input/nvidia,tegra20-kbc.yaml    | 114 ++++++++++++++++++
>  2 files changed, 114 insertions(+), 55 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt
>  create mode 100644 Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.yaml: properties:nvidia,wakeup-source: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.yaml: properties:nvidia,wakeup-source: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.yaml: properties:nvidia,wakeup-source: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.yaml: ignoring, error in schema: properties: nvidia,wakeup-source
Error: Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.example.dts:19.19-20 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:378: Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1398: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):
Documentation/devicetree/bindings/power/wakeup-source.txt: Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt

See https://patchwork.ozlabs.org/patch/1594620

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

