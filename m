Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881735B08DB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 17:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiIGPmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 11:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiIGPma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:42:30 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969F6B0B3A;
        Wed,  7 Sep 2022 08:42:28 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id v2-20020a056830090200b006397457afecso10506495ott.13;
        Wed, 07 Sep 2022 08:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=O0C9t0VY3tvvvQVSv0/pXgbdUBlFzo5v3zMl5r02uQU=;
        b=bgzhqVpt3OnLIuZ4VSICRTvj52t4nOdgrYHD1y7VDdcV9Tt9EEca40jpiknKjpPhF5
         mvRy5nQyWg6m1MFd9mmH8eJxS2rPoLGk+uD5+fAWazGRZAO2+prTERsCg73RgKR7kU81
         YXisgGzu7p/gpS/XmEyH7vr3d1tVDf3/fIsbFTeBJjq4gedUej1rDy30B48YXxSr1vDS
         7lREDqwoci4m1nIAh5guBSPeCrOGrYFNrt2cvMVYfD/D3Nht/dxeWUz1J4mQP8wjgbQZ
         LXhJSEZVNEag7VwNcd+BFGxm8AHcSELLMbKJLlxKhGMvn1DBsXnsWogNb4bx1rgn5H1Q
         rvqQ==
X-Gm-Message-State: ACgBeo0cR1G46Dqs2qBDJFLsID4oW0UqtoMJMRAP/IXjIZYC59vdypx0
        n2UqR98QTu4Sa78g4sOoi+oTjWMsGQ==
X-Google-Smtp-Source: AA6agR7LI/fVhUFeKz5sWm4Jx6IOy+RzpBAsW5Hc/i9i0RkMlpD3hfgjX5MK8MKQzdWCsaBTRik4MQ==
X-Received: by 2002:a9d:67c1:0:b0:63b:2b5c:90bd with SMTP id c1-20020a9d67c1000000b0063b2b5c90bdmr1653134otn.237.1662565347815;
        Wed, 07 Sep 2022 08:42:27 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a11-20020a4a988b000000b00435a8024bc1sm5159957ooj.4.2022.09.07.08.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 08:42:27 -0700 (PDT)
Received: (nullmailer pid 3505199 invoked by uid 1000);
        Wed, 07 Sep 2022 15:42:26 -0000
Date:   Wed, 7 Sep 2022 10:42:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        David Heidelberg <david@ixit.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12] dt-bindings: misc: fastrpc convert bindings to yaml
Message-ID: <20220907154226.GA3505117-robh@kernel.org>
References: <20220907074301.3996021-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907074301.3996021-1-abel.vesa@linaro.org>
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

On Wed, 07 Sep 2022 10:43:01 +0300, Abel Vesa wrote:
> Convert Qualcomm FastRPC bindings to yaml format, so that we could validate
> dt-entries correctly and any future additions can go into yaml format.
> 
> Use compute-cb@ subnodes instead of just cb@. Add qcom,glink-channels and
> qcom,smd-channels missing properties to make sure dtbs_check doesn't fail
> right off the bat. Correct the name of the parent node in the example from
> smd-edge to glink-edge.
> 
> Since now the qcom,fastrpc bindings document is yaml, update the
> reference to it in qcom,glink-edge and also use $ref.
> 
> Also update the MAINTAINERS file to point to the yaml version.
> 
> Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Co-developed-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> Changes since v11:
>  * added 'additionalProperties: false' to the patternProperties,
>    as suggested by Krzysztof
> 
>  .../devicetree/bindings/misc/qcom,fastrpc.txt |  88 -------------
>  .../bindings/misc/qcom,fastrpc.yaml           | 124 ++++++++++++++++++
>  .../bindings/remoteproc/qcom,glink-edge.yaml  |   4 +-
>  MAINTAINERS                                   |   2 +-
>  4 files changed, 127 insertions(+), 91 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
>  create mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> 

Applied, thanks!
