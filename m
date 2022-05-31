Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BAF5391BE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 15:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344717AbiEaNVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 09:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344691AbiEaNVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 09:21:31 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A232395DCE;
        Tue, 31 May 2022 06:21:29 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id k187so13199844oif.1;
        Tue, 31 May 2022 06:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=n2YWFk0y3q/d7S62mzm/mupBj+kGA49hA3r4JP1ldJU=;
        b=UqsmQS/PhlikB+EugfjiGGPxJwTfuBvKe2jER/nsjc57mx4xPj5HLoF1CHBopg693H
         ac3hEBnR5zeGnGTgcjHjY/etY9fY8T2K/2rmycMu2YqC1a/QtWr1CrdrkOv/kkVrfwlT
         Id9GMrwWI+bH5nNgbNpeuftaJKh1UjkJQmaRbe93RKpoyiwPrfVZedfCqhLO/K8mE9HY
         PGtQLvOI0GrrG5Nb2Mc/AM1cAg9aUx8skQPhess86mtvkozKKcoKbDWmh7v11OSSsh/Q
         uVi0vrSJzUxKzbDRO+gFzyIr2RdFSs8/i48Y4LMU1uUd2r1Q5oVFV5bwRJ+d4FMDFqkN
         pJKw==
X-Gm-Message-State: AOAM531R3t5D31yQh+W+kQa3tRLBHWXiMIzr6D5JeQK9/vNvxLfeiKN7
        ab2PJ081+bzXdSfYZ9HqLw==
X-Google-Smtp-Source: ABdhPJw/uns3WPs2X+MsfGF5nr1CcrWwKzdKVdZtYl2nRuFZii2epEbochmc6fHJTtwW1+OebjuDSA==
X-Received: by 2002:a05:6808:10d1:b0:32b:a63b:fdda with SMTP id s17-20020a05680810d100b0032ba63bfddamr12450526ois.257.1654003288954;
        Tue, 31 May 2022 06:21:28 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w11-20020a0568080d4b00b0032b4ae1fc2csm5715934oik.21.2022.05.31.06.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 06:21:28 -0700 (PDT)
Received: (nullmailer pid 1610158 invoked by uid 1000);
        Tue, 31 May 2022 13:21:25 -0000
From:   Rob Herring <robh@kernel.org>
To:     Harsh Agarwal <quic_harshq@quicinc.com>
Cc:     linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, quic_pkondeti@quicinc.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quic_ppratap@quicinc.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        quic_jackp@quicinc.com
In-Reply-To: <1653985217-20953-2-git-send-email-quic_harshq@quicinc.com>
References: <1653985217-20953-1-git-send-email-quic_harshq@quicinc.com> <1653985217-20953-2-git-send-email-quic_harshq@quicinc.com>
Subject: Re: [PATCH 1/3] dt-bindings: usb: dwc3: Add support for multiport related properties
Date:   Tue, 31 May 2022 08:21:25 -0500
Message-Id: <1654003285.276061.1610157.nullmailer@robh.at.kernel.org>
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

On Tue, 31 May 2022 13:50:15 +0530, Harsh Agarwal wrote:
> Added support for multiport, mport, num-ssphy and num-hsphy
> properties. These properties are used to support devices having
> a multiport controller.
> 
> Signed-off-by: Harsh Agarwal <quic_harshq@quicinc.com>
> ---
>  .../devicetree/bindings/usb/snps,dwc3.yaml         | 55 ++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/usb/snps,dwc3.yaml:366:8: [warning] wrong indentation: expected 6 but found 7 (indentation)
./Documentation/devicetree/bindings/usb/snps,dwc3.yaml:367:10: [warning] wrong indentation: expected 11 but found 9 (indentation)
./Documentation/devicetree/bindings/usb/snps,dwc3.yaml:369:11: [warning] wrong indentation: expected 11 but found 10 (indentation)

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/usb/snps,dwc3.example.dts:86.27-89.15: Warning (unit_address_vs_reg): /example-2/usb@4a000000/multiport/mport@1: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/usb/snps,dwc3.example.dts:91.27-93.15: Warning (unit_address_vs_reg): /example-2/usb@4a000000/multiport/mport@2: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/usb/snps,dwc3.example.dts:95.27-97.15: Warning (unit_address_vs_reg): /example-2/usb@4a000000/multiport/mport@3: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/usb/snps,dwc3.example.dts:99.27-101.15: Warning (unit_address_vs_reg): /example-2/usb@4a000000/multiport/mport@4: node has a unit name, but no reg or ranges property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/snps,dwc3.example.dtb: usb@4a000000: multiport: 'mport' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/snps,dwc3.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

