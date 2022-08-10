Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F22358ED37
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbiHJN2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbiHJN2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:28:23 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5442F002;
        Wed, 10 Aug 2022 06:28:20 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id x64so12141221iof.1;
        Wed, 10 Aug 2022 06:28:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=4epIfRahObDv/a6dumDmRQy3l18v8+waUrRo2YnWvdM=;
        b=eHEUr1XZSj9OYrBVxxDKBDVWfgO8OLCPY8KibmX04ivuiDcIFPtDDME3s5oxjeb/cQ
         tYTebl5IHdiHEuAnMWUBWNL8MRpRwERnwbUe3FK2/v6ALbBChg//U20f4Zv4+qdZCcza
         wEO5qKTRPa8l2J89H9y8kF6YIcJkN3w3vvP4+4nZ6iL3sphYPogiLdwxU47ZmOuQ5eiu
         9tjzvzVAF8vVeRz1AvsSafOk36bH/2gtTf7QBllkzqlVjxypSSHFOknXrNNNFi4tf2jD
         033eu5LQXx88/wg9a0D2JeqbzWU7DupjyS4MzZ8tPYF5q7L+LNBSLjySftOQ/JuqJxq8
         X8KQ==
X-Gm-Message-State: ACgBeo0xH3ZMeCCZs8nOnSpABVTwbXY4MRbZXaqGqCpVQeubLNFjJadO
        q4zO7B5gfsW12hO6vep8TpNJijBehA==
X-Google-Smtp-Source: AA6agR6Y72wFm60tqJ+C1vVwSKALhtNNXerxG30Sj4nbpvo6VW5QJA0hxBdJ221EXQ/rdDb/R4f2aw==
X-Received: by 2002:a05:6638:450:b0:343:af3:dc0 with SMTP id r16-20020a056638045000b003430af30dc0mr6247769jap.287.1660138099765;
        Wed, 10 Aug 2022 06:28:19 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id b9-20020a92c149000000b002dd16300beasm2219717ilh.51.2022.08.10.06.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 06:28:19 -0700 (PDT)
Received: (nullmailer pid 3991544 invoked by uid 1000);
        Wed, 10 Aug 2022 13:28:15 -0000
From:   Rob Herring <robh@kernel.org>
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        orsonzhai@gmail.com, linux-kernel@vger.kernel.org,
        baolin.wang@linux.alibaba.com, devicetree@vger.kernel.org,
        zhang.lyra@gmail.com, lee@kernel.org
In-Reply-To: <20220810130344.1488578-1-gengcixi@gmail.com>
References: <20220810130344.1488578-1-gengcixi@gmail.com>
Subject: Re: [PATCH] dt-bindings: mfd: sprd: Add bindings for ums512 global registers
Date:   Wed, 10 Aug 2022 07:28:15 -0600
Message-Id: <1660138095.903227.3991543.nullmailer@robh.at.kernel.org>
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

On Wed, 10 Aug 2022 21:03:44 +0800, Cixi Geng wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> Add bindings for Unisoc system global register which provide register map
> for clocks.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
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

