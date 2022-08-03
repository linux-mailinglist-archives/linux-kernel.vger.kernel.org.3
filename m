Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D73458934C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 22:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238098AbiHCUe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 16:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbiHCUeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 16:34:23 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A4BF68;
        Wed,  3 Aug 2022 13:34:21 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id z145so399475iof.9;
        Wed, 03 Aug 2022 13:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=fyYePxjSKLpCDUc26DEQ4fndG8Oeo8s9amEB/iAl1Uw=;
        b=B9chz2vbmiyrgJ4ZSrG5/kS+47Yys1O9pR8hotAi7MulpUOv2gUj9nBcBzD/6QLcCz
         1PS11KVoobDqgAdFJbuDZJJwUWZygNS68U5HgggOZC7pvNgayfEoakE1wA9LJCpxKXJK
         VBBZT1ZtEfRHtASTWMvu73kXTHyV0GMVaPSw4sgDdpDuoI0q1aBHUSj8/3PkrvCJL5VE
         fel71z8o4X1ybSLOW6Wjvp+UA4S0xpivG0AxAyGaygN4PNrey7rv6L39biXFLiHq4xgh
         1fQGmTsF7XUcLAteh9WMOIHRxRASRJlN4+vBqPDSQP+ywPTctUGE9xvfUwOiv0fq8ECf
         VOaQ==
X-Gm-Message-State: AJIora8mmjSciM9fHUSXMBCRkywsy1ydlDG/TAZFPd+Afzg0xwsRNCH/
        lhWtZS6dneykG9HUXihLLA==
X-Google-Smtp-Source: AGRyM1vhjM0ZBmXAJQ1EAzwnqAbTEo4T9AGfF470cX6CscugTD4dxGUNvWDuPeOPW7zL+gtBSXv+Iw==
X-Received: by 2002:a05:6638:d93:b0:341:5cab:4d9 with SMTP id l19-20020a0566380d9300b003415cab04d9mr11383863jaj.146.1659558860997;
        Wed, 03 Aug 2022 13:34:20 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id d11-20020a023f0b000000b00339e669df91sm8131503jaa.153.2022.08.03.13.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 13:34:20 -0700 (PDT)
Received: (nullmailer pid 2576745 invoked by uid 1000);
        Wed, 03 Aug 2022 20:34:18 -0000
From:   Rob Herring <robh@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     quic_plai@quicinc.com, tiwai@suse.com,
        linux-arm-msm@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, quic_rohkumar@quicinc.com,
        bgoswami@quicinc.com, srinivas.kandagatla@linaro.org,
        perex@perex.cz, agross@kernel.org, broonie@kernel.org,
        robh+dt@kernel.org, linux-remoteproc@vger.kernel.org,
        bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <1659536480-5176-3-git-send-email-quic_srivasam@quicinc.com>
References: <1659536480-5176-1-git-send-email-quic_srivasam@quicinc.com> <1659536480-5176-3-git-send-email-quic_srivasam@quicinc.com>
Subject: Re: [PATCH 2/8] dt-bindings: remoteproc: qcom: adsp: Add compatible name for SC7280
Date:   Wed, 03 Aug 2022 14:34:18 -0600
Message-Id: <1659558858.555688.2576744.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Aug 2022 19:51:14 +0530, Srinivasa Rao Mandadapu wrote:
> Add compatible name and update max reg items for SC7280 base platforms.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> ---
>  .../devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.yaml          | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.example.dtb: remoteproc@17300000: reg: [[389021696, 1036]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

