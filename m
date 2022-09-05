Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D655AD324
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 14:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238402AbiIEMoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 08:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238366AbiIEMnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 08:43:33 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D125FF7F;
        Mon,  5 Sep 2022 05:40:59 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id h20-20020a056830165400b00638ac7ddba5so6084193otr.4;
        Mon, 05 Sep 2022 05:40:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=vdBwwKn2Xl4pm4tpPtpu48ujTi08Q+jwgvphGlSojxg=;
        b=rB7WngDafgSRnsw7RXQmkpsMtUPDrEqxTlQ70ZjPjIU5J87NVpCWib03IxRqEzU5R9
         plzzH4ogw4xEuemIauQL+UDJCvhAS+Lq3hpGPd/zScvza7yqFZ0+0TUblUtVaWR5jniV
         /R7Xi90y7YFVM579tov/2oJkppF3vA1q+nrcuFmLfi0NhDcRL4hmzLfDZI70go2u72Zt
         SyGOAYG70TllNxwMr/WVk8kddk6EI2mzm54QQoV6SUfEkDbu5OPChRwJdywXoJN+/KbR
         jljpfLjFBrgxjxWkVZYRVXb+JlTHb/UTuzWgnIFQGo2bF249JrODeHMVYZ4Pi9H4y4MH
         LQww==
X-Gm-Message-State: ACgBeo0A3jf9D3pi9wuKEBsYTc88mBWB7rK/fyJHU/OLRM/6MnckHO0b
        6+wnYXMnGBuLe7rNz0oQGA==
X-Google-Smtp-Source: AA6agR7SwXlWCoYqEo/sNvj+gGGVxCebcT/z95Z8+eS1E6Gz52y6Bu0EWp1jCYQVysDCw5HYtof5OQ==
X-Received: by 2002:a9d:5f05:0:b0:638:9ae3:59e with SMTP id f5-20020a9d5f05000000b006389ae3059emr19362668oti.271.1662381658484;
        Mon, 05 Sep 2022 05:40:58 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e38-20020a05687023a600b001048f70e03dsm4945117oap.15.2022.09.05.05.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 05:40:58 -0700 (PDT)
Received: (nullmailer pid 1957045 invoked by uid 1000);
        Mon, 05 Sep 2022 12:40:57 -0000
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        David Heidelberg <david@ixit.cz>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org
In-Reply-To: <20220905103715.955786-1-abel.vesa@linaro.org>
References: <20220905103715.955786-1-abel.vesa@linaro.org>
Subject: Re: [PATCH v6 1/2] dt-bindings: misc: fastrpc convert bindings to yaml
Date:   Mon, 05 Sep 2022 07:40:57 -0500
Message-Id: <1662381657.354400.1957044.nullmailer@robh.at.kernel.org>
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

On Mon, 05 Sep 2022 13:37:14 +0300, Abel Vesa wrote:
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
> Changes since v5:
>  * Removed the txt file
> 
>  .../devicetree/bindings/misc/qcom,fastrpc.txt |  88 --------------
>  .../bindings/misc/qcom,fastrpc.yaml           | 108 ++++++++++++++++++
>  2 files changed, 108 insertions(+), 88 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
>  create mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/misc/qcom,fastrpc.example.dtb: smd-edge: 'qcom,smd-edge' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/qcom,smd-edge.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/misc/qcom,fastrpc.example.dtb: smd-edge: 'oneOf' conditional failed, one must be fixed:
	'mboxes' is a required property
	'qcom,ipc' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/qcom,smd-edge.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/misc/qcom,fastrpc.example.dtb: smd-edge: 'oneOf' conditional failed, one must be fixed:
	'interrupts' is a required property
	'interrupts-extended' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/qcom,smd-edge.yaml

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

