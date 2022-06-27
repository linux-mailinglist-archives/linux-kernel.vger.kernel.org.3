Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A078A55D5CD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235847AbiF0Nb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235734AbiF0NbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:31:16 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108E76464;
        Mon, 27 Jun 2022 06:31:16 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id o4so6007564ilm.9;
        Mon, 27 Jun 2022 06:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=LtzvoZ7h5igET6i8THXPAZcwOLCBY2ELyGc79uNyoyY=;
        b=j2gqXczQvlilAygKlonqwsW3rcqI8IiMVMfhTeQ3nrdqpjL9BD4DAUzOluo9ILCgP3
         yJftuz3MjFyY4wlf4LVl69YZuC3MtsZ0aJsBCwLFFoAKaLiaNUec5jZ35tGTv86FaJUF
         KL30Ynj6CjKA0c3/+5bbqeDKpI0UiVN42K69HvbWwgXPOmZfqfuWmOad7u6kAL4SymIq
         XOfHVf37SAEulCRDG4YISRWBfXDFM7d1qzNQdMtmLNr08OMzJGzz5I+pkpNHfngyGYRO
         +n6eps1jKNzZJXYsk7aP6TUxy5JHeHRcUN+d+UYXvNsJVwGJo/MvQ9qzj1B8YUSOpIeV
         zFuA==
X-Gm-Message-State: AJIora8xxQwDGEj/Zl6wVZQ7nyHnyWBfccQrTr28zb6EKYM0K/vOF5hc
        j+QQborUVuaF5exW4x/Ep1+ZC8kTjg==
X-Google-Smtp-Source: AGRyM1t3dHcseGI2deMwdUEop3Mnu1zq3XfE63FQzk/dovJ2L1IsmcMcxvjB9s68MZ1YGiRnYRiMfw==
X-Received: by 2002:a92:7a10:0:b0:2d9:401e:db19 with SMTP id v16-20020a927a10000000b002d9401edb19mr7226596ilc.87.1656336675274;
        Mon, 27 Jun 2022 06:31:15 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id r14-20020a92cd8e000000b002d11397f4f9sm4521040ilb.74.2022.06.27.06.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 06:31:14 -0700 (PDT)
Received: (nullmailer pid 2285168 invoked by uid 1000);
        Mon, 27 Jun 2022 13:31:09 -0000
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        linux-arm-msm@vger.kernel.org, ~okias/devicetree@lists.sr.ht
In-Reply-To: <20220626183247.142776-3-david@ixit.cz>
References: <20220626183247.142776-1-david@ixit.cz> <20220626183247.142776-3-david@ixit.cz>
Subject: Re: [PATCH v4 3/3] dt-bindings: firmware: convert Qualcomm SCM binding to the yaml
Date:   Mon, 27 Jun 2022 07:31:09 -0600
Message-Id: <1656336669.648862.2285167.nullmailer@robh.at.kernel.org>
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

On Sun, 26 Jun 2022 20:32:47 +0200, David Heidelberg wrote:
> Convert Qualcomm SCM firmware binding to the yaml format.
> 
> This commit also:
>  - adds qcom,scm-mdm9607 into list which has only core clock
>  - adds qcom,scm-sm6125, qcom,scm-ipq6018
>  - #reset-cells, because the property is already used
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> --
> v4:
>  - added clocks minItems and maxItems
>  - removed quotes from $id and $schema
>  - adjusted description of TCSR HW block
> v3:
>  - add preceding patches for ARM and arm64 adding missing compatible strings
>  - extended with missing compatible strings
>  - added two additional maintainers, see https://lkml.org/lkml/2022/6/23/1969
> v2:
>  - changed maintainer to Bjorn
>  - document #reset-cells
> ---
>  .../devicetree/bindings/firmware/qcom,scm.txt |  57 -------
>  .../bindings/firmware/qcom,scm.yaml           | 140 ++++++++++++++++++
>  2 files changed, 140 insertions(+), 57 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/firmware/qcom,scm.txt
>  create mode 100644 Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/firmware/qcom,scm.example.dts:18.17-18 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:383: Documentation/devicetree/bindings/firmware/qcom,scm.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1404: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

