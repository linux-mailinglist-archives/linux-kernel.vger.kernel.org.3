Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E215ADD54
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 04:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbiIFCaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 22:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiIFCaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 22:30:00 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A49F13D13;
        Mon,  5 Sep 2022 19:30:00 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-11f34610d4aso25092334fac.9;
        Mon, 05 Sep 2022 19:30:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=bgR9Dm7RR5gy3vWeeBp7FcKJWvBmN2YdFy8Dv8gJKQE=;
        b=XRSD/tHu3mDbAYLrqQkykRrKB4dgcOx5QOHshQLu84iBVPsW1EIBHmd1ecMaJ0o8AE
         6eeQJwS0VtM8YjtOAnYST5fdYc1MgHrZ7Ow/6KO71j/VzKXhxq1EaKVpK30781061LQ9
         kc4KR/bNert1+OtLaNbl4Ht6XjApUJXIR5vtu0xAFigRCs1PmTgaRzp2AzhNSpIef+rO
         ZhAltJY+vtitIfKhva/Q6QsyKz2ZDVLjP+LEtgIlX+SisOSL+TGw9USgUsWkvPAm+01Y
         N0z2i/v2AcOfHOEUYTRwSzUaRPJ7e4xat+7VgNbTV26eemZvMPKIldSMYe4Wb5IXlbii
         m5xA==
X-Gm-Message-State: ACgBeo0FbgXWZHWSaKSOoyGcT/ko21X1qA3Fs0NCtr/95fmRUPnaQVGF
        nNPG9/X6cKQW6el3/I61SxXtW8FQ6w==
X-Google-Smtp-Source: AA6agR453kgOl7QJNbxXMSvEeEKK/ga5wy8mSasvv0WthRCBCxzzWFERYf/TOjtk9667ew6xSZLW4Q==
X-Received: by 2002:a05:6870:4410:b0:122:520b:2159 with SMTP id u16-20020a056870441000b00122520b2159mr10794228oah.27.1662431399440;
        Mon, 05 Sep 2022 19:29:59 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k12-20020a056870818c00b00127a91041a9sm846270oae.38.2022.09.05.19.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 19:29:59 -0700 (PDT)
Received: (nullmailer pid 3334458 invoked by uid 1000);
        Tue, 06 Sep 2022 02:29:58 -0000
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        David Heidelberg <david@ixit.cz>
In-Reply-To: <20220905144554.1772073-1-abel.vesa@linaro.org>
References: <20220905144554.1772073-1-abel.vesa@linaro.org>
Subject: Re: [PATCH v7 1/2] dt-bindings: misc: fastrpc convert bindings to yaml
Date:   Mon, 05 Sep 2022 21:29:58 -0500
Message-Id: <1662431398.288835.3334457.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Sep 2022 17:45:53 +0300, Abel Vesa wrote:
> Convert Qualcomm FastRPC bindings to yaml format, so that we could validate
> dt-entries correctly and any future additions can go into yaml format.
> 
> Use compute-cb@ subnodes instead of just cb@.
> 
> Also add qcom,non-secure-domain, qcom,glink-channels and
> qcom,smd-channels missing properties to make sure dtbs_check doesn't
> fail right off the bat.
> 
> Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Co-developed-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> Changes since v6:
>  * renamed the parent node name in the example from smd-edge to glink-edge
> 
>  .../devicetree/bindings/misc/qcom,fastrpc.txt |  88 -------------
>  .../bindings/misc/qcom,fastrpc.yaml           | 118 ++++++++++++++++++
>  2 files changed, 118 insertions(+), 88 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
>  create mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):
Documentation/devicetree/bindings/remoteproc/qcom,glink-edge.yaml: Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
MAINTAINERS: Documentation/devicetree/bindings/misc/qcom,fastrpc.txt

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

