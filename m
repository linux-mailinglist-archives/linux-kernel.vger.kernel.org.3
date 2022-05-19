Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0A452DDC3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 21:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244526AbiESTXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 15:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243925AbiESTXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 15:23:06 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7120C58E43;
        Thu, 19 May 2022 12:23:05 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-f1eafa567cso4539458fac.8;
        Thu, 19 May 2022 12:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=xUdBpJfFH6LsWjA2eoyMRt5PLk894PaKnYn1kRRc6EM=;
        b=S3p/lOOvitntaO0p4qxXxG3uRZB7nk+Ha4aZOGejrs50Wbi/mW0Zhd/JVN/f8AqsBC
         Btar3UDwkW0/OOLNUSL4UW1MCCb7R0eWYd9SEnS7n7del3Owa+/H+U9jrXddkWh+c5NW
         ho0r4HicsYsUySJXx+qwRm2KNJEpGbsdltjHZWh8iz0qZu8gvS44L0uAtVqvia9rthc5
         X525jYjrTeVwudjAlvqQidMYGWxboW8rmo+E3TOEXdM+1Q8Uv5ibbDzwef0BlavIl1oM
         4luguN8jKmWNjEWGUTdOwSGjCx8hDo5sWmTD4sj4Z85OAUcJ5GYfBiixMMQcePPIHVUs
         LKRw==
X-Gm-Message-State: AOAM530+mdkTYxvIsAHkRS7dpfC+hVCJrBcYCFuBiYPhJTxT0Bm/EhdL
        E9G/oEGhNR6/IPsrpKjGwg==
X-Google-Smtp-Source: ABdhPJxlKaVBcMdiefUM0cnmhHo2Lr8eBJpDbB9PytEPQAGPaO56TKyr0H1SyDe14GDzXH7AZl00sg==
X-Received: by 2002:a05:6870:6307:b0:e9:6ed6:cb2f with SMTP id s7-20020a056870630700b000e96ed6cb2fmr3606109oao.26.1652988184484;
        Thu, 19 May 2022 12:23:04 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i186-20020acab8c3000000b00325cda1ffb9sm43087oif.56.2022.05.19.12.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 12:23:03 -0700 (PDT)
Received: (nullmailer pid 2044191 invoked by uid 1000);
        Thu, 19 May 2022 19:23:01 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, robh+dt@kernel.org,
        mka@chromium.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, agross@kernel.org, mathieu.poirier@linaro.org,
        devicetree@vger.kernel.org, ohad@wizery.com,
        krzysztof.kozlowski+dt@linaro.org, bjorn.andersson@linaro.org,
        linux-remoteproc@vger.kernel.org
In-Reply-To: <1652978825-5304-3-git-send-email-quic_sibis@quicinc.com>
References: <1652978825-5304-1-git-send-email-quic_sibis@quicinc.com> <1652978825-5304-3-git-send-email-quic_sibis@quicinc.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: remoteproc: qcom: Convert SC7280 MSS bindings to YAML
Date:   Thu, 19 May 2022 14:23:01 -0500
Message-Id: <1652988181.135820.2044190.nullmailer@robh.at.kernel.org>
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

On Thu, 19 May 2022 22:17:04 +0530, Sibi Sankar wrote:
> Convert SC7280 MSS PIL loading bindings to YAML.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
> 
> v4:
>  * Remove older bindings [Matthias/Krzysztof]
>  * Misc. Fixes [Krzysztof]
>  * Rebased on v2 of Krzysztof's bindings cleanups
> 
> v3:
>  * Re-ordered clock list, fixed pdc_sync typo [Rob/Matthias]
> 
>  .../devicetree/bindings/remoteproc/qcom,q6v5.txt   |  31 +--
>  .../bindings/remoteproc/qcom,sc7280-mss-pil.yaml   | 250 +++++++++++++++++++++
>  2 files changed, 252 insertions(+), 29 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/remoteproc/qcom,glink-edge.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.example.dtb: remoteproc@4080000: glink-edge: False schema does not allow {'interrupts-extended': [[4294967295, 2, 0, 1]], 'mboxes': [[4294967295, 2, 0]], 'label': ['modem'], 'qcom,remote-pid': [[1]]}
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

