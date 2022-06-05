Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C7253D93B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 04:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345610AbiFECSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 22:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239486AbiFECRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 22:17:55 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4891A82F;
        Sat,  4 Jun 2022 19:17:53 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-e93bbb54f9so15214105fac.12;
        Sat, 04 Jun 2022 19:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=lQ4WDAfIbQoDCBB4B+MAW+ijNY272OTmgCMkNTc+Uvc=;
        b=bh43+VMw6g+mPjOJ60pNM4ZIZQ6mF1d9TZ9gGWo4WVWj3/xdCJneORFY3NCNXDMdfY
         LKLIRwfdC8u/YwOvSRKONZuLPPaUrwCh4zshKG7lfNEkegy0JL9/kkMcRBP9UuxOZrm2
         iW8QO3gm5sLfFTO6rqaXdV4kEX4QpqQf4iZ+xgebyCcLZXRFt712u72PAKJkueAkZONc
         4kZ/UCN6A5rPJBh/z7VRgqXE1b3CuZoNnnyyaHV/Wvaz9cR+wMKMhOI6ymvsqrHxk/oH
         waRPp00zRrTs4Dk5RAvu1GPlOI1/B/5ZgiNV0uGvTWnAzrmYl90a6EhCtvf9GMDZLFAO
         dj3g==
X-Gm-Message-State: AOAM5319N8Qx3MXx5inJldCUxyO7TBcsMS7FbqXxFrsuNxHJCd/fkC8V
        w0cg3josQSC4pjjUxtSi4A==
X-Google-Smtp-Source: ABdhPJzU8BDDcCbf/hdWWbHSyuiipZ4q19linmO5W5eMQ60JU5K7XyQVF6AYRByp35JPWgvTN+vLBA==
X-Received: by 2002:a05:6870:ec90:b0:f3:4c28:5acf with SMTP id eo16-20020a056870ec9000b000f34c285acfmr16846652oab.28.1654395472806;
        Sat, 04 Jun 2022 19:17:52 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k84-20020aca3d57000000b0032e2599df3dsm5731389oia.10.2022.06.04.19.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 19:17:52 -0700 (PDT)
Received: (nullmailer pid 3371067 invoked by uid 1000);
        Sun, 05 Jun 2022 02:17:50 -0000
From:   Rob Herring <robh@kernel.org>
To:     Harsh Agarwal <quic_harshq@quicinc.com>
Cc:     ahalaney@redhat.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quic_ppratap@quicinc.com, quic_jackp@quicinc.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, quic_pkondeti@quicinc.com,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Felipe Balbi <balbi@kernel.org>
In-Reply-To: <1654276362-28930-2-git-send-email-quic_harshq@quicinc.com>
References: <1654276362-28930-1-git-send-email-quic_harshq@quicinc.com> <1654276362-28930-2-git-send-email-quic_harshq@quicinc.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: usb: dwc3: Add support for multiport related properties
Date:   Sat, 04 Jun 2022 21:17:50 -0500
Message-Id: <1654395470.146119.3371066.nullmailer@robh.at.kernel.org>
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

On Fri, 03 Jun 2022 22:42:40 +0530, Harsh Agarwal wrote:
> Added support for multiport, mport, num_usb2_phy and num_usb3_phy
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

