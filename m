Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFCE4F9E8F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 23:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239625AbiDHVFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 17:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239618AbiDHVFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 17:05:50 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50B512A8C3;
        Fri,  8 Apr 2022 14:03:44 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-de3eda6b5dso11067070fac.0;
        Fri, 08 Apr 2022 14:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C+x8ZDIEAu58/qLjFjtQ5oRbajmmffUfiq5am/S1jSM=;
        b=Xgr0auzG1mfn9IynqWe5K3xgJAN0Vpqix+YT70KO1jiyv9EHjBQ6lZ5Q8oy96ZxFxk
         mylurOhYz35SzxxxerXu5cqnGTNJPzXtjaDsfi6zXQ8yICOmFHCSmFW/MsGgjZI2yiEM
         a//0w/BmKr2kSV92B5zsbJF9ryyX5C0Ap2QHCCzjnJVcz+/3vj/+FZKerShB99miGeyS
         So1lCUEulUyxUkQiHXKxALdxh0REDvmyuP2RANuvlBIzgMV2vfoNR+WiTeWfbFVCSIb6
         hAaj/tNfqehNXvoModDpJ4fxFndCpXRa3NO7eLo8+sCMBRMOQE7Yzu8VfH8V+9WZrjsM
         uabA==
X-Gm-Message-State: AOAM5314NBca1NyPSm3VP7dca+is33GtjB0elrZps6MH0NdCR3h21avv
        iW/Qnr3C52vE5ITz3E5Cnw==
X-Google-Smtp-Source: ABdhPJyqR1rcZiYumuNSsmbWhNIxMsTNouVKNDRqlRoqVLkZzYlmhKEOWlU36j0YipUBOXzEAtmx5w==
X-Received: by 2002:a05:6871:85:b0:d9:ac7a:7a5a with SMTP id u5-20020a056871008500b000d9ac7a7a5amr9620880oaa.9.1649451823947;
        Fri, 08 Apr 2022 14:03:43 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f8-20020a4ace88000000b00321598cd45dsm8827941oos.33.2022.04.08.14.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 14:03:43 -0700 (PDT)
Received: (nullmailer pid 4062188 invoked by uid 1000);
        Fri, 08 Apr 2022 21:03:43 -0000
Date:   Fri, 8 Apr 2022 16:03:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Alban Bedel <albeu@free.fr>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 02/14] dt-bindings: reset: ath79: Convert to yaml
Message-ID: <YlCjL5aG+1iVkwLU@robh.at.kernel.org>
References: <20220407154338.4190674-1-p.zabel@pengutronix.de>
 <20220407154338.4190674-2-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407154338.4190674-2-p.zabel@pengutronix.de>
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

On Thu, 07 Apr 2022 17:43:26 +0200, Philipp Zabel wrote:
> Convert the device tree bindings for the Qualcomm Atheros AR7xxx/AR9XXX
> reset controller to YAML schema to allow participating in DT validation.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Alban Bedel <albeu@free.fr>
> ---
>  .../devicetree/bindings/reset/ath79-reset.txt | 20 ----------
>  .../bindings/reset/qca,ar7100-reset.yaml      | 40 +++++++++++++++++++
>  2 files changed, 40 insertions(+), 20 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/reset/ath79-reset.txt
>  create mode 100644 Documentation/devicetree/bindings/reset/qca,ar7100-reset.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
