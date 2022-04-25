Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D534A50E1DD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242064AbiDYNea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242045AbiDYNe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:34:27 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E713A29A;
        Mon, 25 Apr 2022 06:31:21 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id m11so6287699oib.11;
        Mon, 25 Apr 2022 06:31:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=GUfySEJJQHigKKbyCdUKKYOqIxCh0oO9rPKwD6ultJ0=;
        b=Q5cvUAHbTFFraAFzgookFfGEjQZPwO4QP3peH+LWvHZBsu2ALM2KEB2MICtPjlyKWO
         qE/gH2bQESi+Ups/Ksg6hVVaocgag/iIav57exGeKb+OszyqMCSk7Rtu7mfpWT1WniIC
         0fsjBByGH8NGrlFE9qiAw//sixcyHRVIvQ+zCw1IHc57ubD3ZczAEC7wb7KxLxI4Mwpf
         No7KuZBvvjIRw7lciBsqQdB4Q2Jm311bpQ5AT/pZlz7CeWYsQ0J9hui04H1YAriSit2c
         AZKZv4AAXYSo4GafxTriBn3gx9iFhkKSlB6HceK2hspIgxU5LmFnBISq8loVpdPbTpEP
         Dz0Q==
X-Gm-Message-State: AOAM5314w7uXfmYB8wV/hWAL50B1DZNXBvygjN3wAWS3pshbJ6TZZkQP
        Hq3hjfDGqXlPBF/5b4dpog==
X-Google-Smtp-Source: ABdhPJxa46qPKjUROvXBgyXHn1w+wkciL8kidB567QnbYwcBqFlbJMT1L4DOwjjfyAJunbcJUTUk6g==
X-Received: by 2002:a05:6808:1998:b0:323:2818:86c0 with SMTP id bj24-20020a056808199800b00323281886c0mr8261044oib.294.1650893480691;
        Mon, 25 Apr 2022 06:31:20 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o19-20020a4a9593000000b0032176119e65sm4395149ooi.34.2022.04.25.06.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 06:31:20 -0700 (PDT)
Received: (nullmailer pid 3715962 invoked by uid 1000);
        Mon, 25 Apr 2022 13:31:19 -0000
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        devicetree@vger.kernel.org, Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
In-Reply-To: <20220424131522.14185-2-david@ixit.cz>
References: <20220424131522.14185-1-david@ixit.cz> <20220424131522.14185-2-david@ixit.cz>
Subject: Re: [PATCH v2 2/3] dt-bindings: mailbox: qcom-ipcc: add missing properties into example
Date:   Mon, 25 Apr 2022 08:31:19 -0500
Message-Id: <1650893479.245343.3715961.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Apr 2022 15:15:20 +0200, David Heidelberg wrote:
> These missing required properties are needed for
> smp2p binding reference checks.
> 
> Misc: adjusted examples properties formatting from dtsi.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../devicetree/bindings/mailbox/qcom-ipcc.yaml        | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


mailbox@ed18000: compatible:0: 'qcom,sm8450-ipcc' is not one of ['qcom,sm6350-ipcc', 'qcom,sm8250-ipcc', 'qcom,sm8350-ipcc', 'qcom,sc7280-ipcc']
	arch/arm64/boot/dts/qcom/sm8450-hdk.dtb
	arch/arm64/boot/dts/qcom/sm8450-qrd.dtb

