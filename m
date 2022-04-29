Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FE4515869
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381493AbiD2WdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239832AbiD2WdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:33:20 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0738219C0D;
        Fri, 29 Apr 2022 15:30:01 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id o10-20020a4abe8a000000b0035eac0a004aso969348oop.11;
        Fri, 29 Apr 2022 15:30:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n4U2D4DtHj/erg1Dx99IVHk+H7AocH0NMWQwhEikyq0=;
        b=TimB+KJ7wKuzjbARxOYeipgFq4IicISv+NuLht2+2wn/Vs1LrGEqWGJWTTWEQINV+a
         E6XRhwXqtwRTWXzkpLYLvgFRAR1ApeM28tWqe0qUHuWXf0NCESEW32FX2tCKKP3rwjyi
         TCiuoja9WyTfQY2MNy58UxX31jMkJtKvZzolBvtI9ysR1A6Tr3jiQEyrmxn9fRvJVrRa
         elYq5WE7MOkVoyGXBW77xR4fRbr/ZUk8jR2Emu5QFScgCQGqgz1uW8Vnus0iwWOgXpwh
         mSAylMTNkrCy5znHPPziMgZH5pwgT9UHMtf2d0vHA4pbj+bPZ+QOUBLMDdEJ1YhZMHnz
         gsdw==
X-Gm-Message-State: AOAM533kNNeK2TbVwpvr/HlEOjLJnAUPFIDdiQmIf2X4trJY8GHAdQyG
        Ht+9DHFIRPhdAj2cBcC2cw==
X-Google-Smtp-Source: ABdhPJwnTEM8iwmV12TDZFrMJQXwNVCvovIwDwl3UImNsRyMy1q4WN+hTereEkjTpAAiI4QrSw8flg==
X-Received: by 2002:a05:6820:616:b0:33a:524a:e98c with SMTP id e22-20020a056820061600b0033a524ae98cmr524079oow.95.1651271400235;
        Fri, 29 Apr 2022 15:30:00 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c9-20020a9d2789000000b0060603221279sm202886otb.73.2022.04.29.15.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 15:29:59 -0700 (PDT)
Received: (nullmailer pid 3016711 invoked by uid 1000);
        Fri, 29 Apr 2022 22:29:59 -0000
Date:   Fri, 29 Apr 2022 17:29:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Lee Jones <lee.jones@linaro.org>, ~okias/devicetree@lists.sr.ht,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: spmi: convert QCOM PMIC SPMI bindings to
 yaml
Message-ID: <Ymxm5zhiH8rwCCtH@robh.at.kernel.org>
References: <20211227170151.73116-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227170151.73116-1-david@ixit.cz>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2021 18:01:50 +0100, David Heidelberg wrote:
> Convert Qualcomm PMIC SPMI binding to yaml format.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> 
> ---
> v2:
>  - add #address and #size-cells
>  - add reg and remove spmi include from example
> v3:
>  - fix doc reference error (make refcheckdocs)
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../bindings/mfd/qcom,spmi-pmic.txt           |   2 +-
>  .../bindings/spmi/qcom,spmi-pmic-arb.txt      |  65 ----------
>  .../bindings/spmi/qcom,spmi-pmic-arb.yaml     | 120 ++++++++++++++++++
>  3 files changed, 121 insertions(+), 66 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
>  create mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
> 

Looks like this one got missed.

Applied, thanks!
