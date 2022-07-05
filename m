Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02967567796
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 21:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbiGETPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 15:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbiGETPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 15:15:37 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C17A21825;
        Tue,  5 Jul 2022 12:15:36 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id h85so12071382iof.4;
        Tue, 05 Jul 2022 12:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kxzYA6KZ8a4zIqx67GnwhuMBCfJafkrQxxi0Ms3fzsM=;
        b=19wJThwslRmrqLixjdYxhVr10u/EPRHDPrWA+/GdhNTuO/njxXRqTXRmdp7BBih4Zx
         ASAfGIm9PIdo0Tk4kMErzXmEtsz3dpnow57C7SXVLHvbla7VFAp1Lw5pFT2gizIggVNq
         hsPmvElgf99SkI27fs9hSKbpmBiCxnx52GSf0zKxrFPM49mWSY2KloGzD6mYkPyQWUvY
         4AfvBeESDjDnTA+t7XO1d2bv4TYFN+GyQlZ4gI4OF3mLx5IDuJ0XgtOxjCIWn4AxBDT+
         Ce2/SOLE7S6CBbN5yfWPwi9BiZ0uISdD4vHk9X1o6lLG/m7YmxHX59ZC2K4kOje7ETwQ
         IXMQ==
X-Gm-Message-State: AJIora+5Ifn37+eR2Hy8jCBeER40wsy3qdazyvELiY5nqptLG82Sq66x
        lO1W3iiMNAGTEhRzV9Tzig==
X-Google-Smtp-Source: AGRyM1tJBq+vZqIhRnBSmnyhF2kTg4Ul3hctlrl7dB8AHGjpQQNhrPX0aVyHJ7t8yIxnOpQtEbE/4A==
X-Received: by 2002:a05:6638:16cf:b0:33c:8c82:b460 with SMTP id g15-20020a05663816cf00b0033c8c82b460mr22231164jat.32.1657048535710;
        Tue, 05 Jul 2022 12:15:35 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id ck22-20020a0566383f1600b0033ef7f3c5f7sm679260jab.90.2022.07.05.12.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 12:15:35 -0700 (PDT)
Received: (nullmailer pid 2465625 invoked by uid 1000);
        Tue, 05 Jul 2022 19:15:33 -0000
Date:   Tue, 5 Jul 2022 13:15:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, swboyd@chromium.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, mka@chromium.org,
        mathieu.poirier@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [V5 1/2] dt-bindings: remoteproc: qcom: Convert SC7280 MSS
 bindings to YAML
Message-ID: <20220705191533.GA2465521-robh@kernel.org>
References: <1657020721-24939-1-git-send-email-quic_sibis@quicinc.com>
 <1657020721-24939-2-git-send-email-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1657020721-24939-2-git-send-email-quic_sibis@quicinc.com>
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

On Tue, 05 Jul 2022 17:02:00 +0530, Sibi Sankar wrote:
> Add a separate YAML binding to act as a superset of the PAS and non-PAS
> compatible for SC7280 MSS PIL. This also serves as a way to increase
> readability.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
> 
> Depends on Krzysztof's remoteproc cleanups and improvements:
> https://patchwork.kernel.org/project/linux-arm-msm/cover/20220517070113.18023-1-krzysztof.kozlowski@linaro.org/
> 
> Previous discussions on PAS vs non-PAS bindings:
> https://lore.kernel.org/lkml/YUps1JfGtf6JdbCx@ripper/ [Bjorn]
> https://lore.kernel.org/lkml/CAE-0n51KBYjZvwGNy06_okmEWjEfRLQO54CYaY6-JnbBk6kOhA@mail.gmail.com/ [Stephen]
> 
> v5:
>  * Improve phandle-array schemas [Stephen/Rob/Krzysztof]
>  * Add more details to the firmware-name/memory region string array [Stephen/Rob]
>  * Drop 'items' from label [Rob]
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
>  .../bindings/remoteproc/qcom,sc7280-mss-pil.yaml   | 266 +++++++++++++++++++++
>  2 files changed, 268 insertions(+), 29 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
