Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A343F55C775
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235880AbiF0Nbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235862AbiF0Nba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:31:30 -0400
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A25464D1;
        Mon, 27 Jun 2022 06:31:22 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id f15so5554357ilj.11;
        Mon, 27 Jun 2022 06:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=O3oWnTG8KQeUOXE+tF99Ob8V+uF1Dfm/P8wjh/JeAlk=;
        b=j66T7JSDLYVgJD+9TeOc3oJLuEEniGTj3RAZCFPu6lpmD2vgRgfmPpaGuvf5/Rerwf
         PuluGF3h4aa5fW0MKR/shST0GwWlALwInFHvg3l+n37BTmA+yq1XPOsGCsnTwNbHF2JM
         zlqlRHyI4PBjXU0AzLUr3YrgvRMXsbOMLx/Q7+h2VD7kIc1bXranXSxvBy2yP+LtzRGe
         OpgqfaSAfcbSpdtMo7LwMcqWifZ9b8kK4lKssWQd8IXLdD0UA7aANKqdLs1TA2RjYoHR
         nxj2WNjQbV9VWzViFy9lVPZ2stHN6XSTU9ZRWqLnK8l2D3DELXYm0BeQPYoEt2t7HmSI
         Nbmw==
X-Gm-Message-State: AJIora8xP7sNdBTM5cS9LJt53D92AOoZ/AU10QjNNwwXyc4dQ/1tXZPv
        o4sHI/nmgnQS7R8yO2sG9Q==
X-Google-Smtp-Source: AGRyM1vWtaIhACOQOQMsgnt+n3jf+IKZqVw4040pmWlao9K1ELx7Bq4lfexSogX/+UwoY8nmusC7Uw==
X-Received: by 2002:a05:6e02:180e:b0:2d3:c497:710 with SMTP id a14-20020a056e02180e00b002d3c4970710mr7211011ilv.166.1656336681749;
        Mon, 27 Jun 2022 06:31:21 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id bt6-20020a056638430600b0033c9beb0e19sm1294495jab.22.2022.06.27.06.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 06:31:21 -0700 (PDT)
Received: (nullmailer pid 2285170 invoked by uid 1000);
        Mon, 27 Jun 2022 13:31:09 -0000
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Caleb Connolly <caleb@connolly.tech>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>, ~okias/devicetree@lists.sr.ht,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20220626191630.176835-1-david@ixit.cz>
References: <20220626191630.176835-1-david@ixit.cz>
Subject: Re: [PATCH v3] dt-bindings: mfd: convert to yaml Qualcomm SPMI PMIC
Date:   Mon, 27 Jun 2022 07:31:09 -0600
Message-Id: <1656336669.656251.2285169.nullmailer@robh.at.kernel.org>
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

On Sun, 26 Jun 2022 21:16:30 +0200, David Heidelberg wrote:
> Convert Qualcomm SPMI PMIC binding to yaml format.
> 
> Additional changes:
>  - filled many missing compatibles
> 
> Co-developed-by: Caleb Connolly <caleb@connolly.tech>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v3:
>  - added subnodes, there are two not converted to YAML yet, but it works
>  - now it prints milion directly unrelated warning to this binding
>    (it's related to the included subnodes bindings, can be merged,
>     but it'll generate more warnings and preferably anyone can takeover
>     from here)
>  - add qcom,pmx65
> 
> v2:
>  - changed author to myself, kept Caleb as co-author
>  - moved nodename to properties
>  - add nodenames for pm* with deprecated property
>  - add ^$ to pattern properties
>  - dropped interrupt-names property
>  - added reg prop. to the nodes which have register in nodename
>  - added compatible pmx55
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../bindings/mfd/qcom,spmi-pmic.txt           |  94 ---------
>  .../bindings/mfd/qcom,spmi-pmic.yaml          | 191 ++++++++++++++++++
>  2 files changed, 191 insertions(+), 94 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/thermal/qcom,spmi-temp-alarm.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

