Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9670533087
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 20:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240378AbiEXSfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 14:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240359AbiEXSfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 14:35:11 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DD77C171;
        Tue, 24 May 2022 11:35:10 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-f18e6ff0f6so23293475fac.11;
        Tue, 24 May 2022 11:35:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9pEiFzWktAIYSIqxnQCyUiU00uSbkRvQrnM0DTH+JtY=;
        b=HsNIbBtOocHE2lf5ZAEqmyty/2pRKwgkWDGFfG3eVbrQqrti1EmpXILJ+ZTatnC/5q
         VeDWg9B30hyQuHGt/0/4GFpWs59c5Ce/O9HwxncaZx96WUSVAGkU+qUiQc3X2vxN+cB2
         OIDAEoQExTCcPGtKFCcbw5AuBoSx7HXaIv7l0s57EGuIq4ODPVQCwamEKsn8oY2EqCIf
         zIDdN2P030tAtIcMDPVTqKZ4nYWQ4atnNhQdSCoe8QL7b0RtYzdPlHZxog+r2RpFAfdB
         TpK90Uo4iJvV1/ZMoVkrX4gIK88K0Aszer97bCRfFPB8k461v2x+nnqyzCFamXmpfM0l
         ZVyw==
X-Gm-Message-State: AOAM5325/rK4gm3eGyVUqaBH4TqvV6oBAyjbkLzSx3z5OxY92yzkqE8d
        RQeD+oFtErI0yreWvIeLgA==
X-Google-Smtp-Source: ABdhPJxeWMoQDRKTB02w4DP8BpteNHZl4V2vXyNzCFN51shPjwcNk1RVXTiB2GEtkNAyZjVQ82lC8g==
X-Received: by 2002:a05:6870:350b:b0:f1:8e0a:af4 with SMTP id k11-20020a056870350b00b000f18e0a0af4mr3410100oah.6.1653417309674;
        Tue, 24 May 2022 11:35:09 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y1-20020a4a9c01000000b0035eb4e5a6d3sm5823667ooj.41.2022.05.24.11.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 11:35:08 -0700 (PDT)
Received: (nullmailer pid 4137682 invoked by uid 1000);
        Tue, 24 May 2022 18:35:08 -0000
Date:   Tue, 24 May 2022 13:35:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, devicetree@vger.kernel.org,
        linux-leds@vger.kernel.org, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        Kyle Swenson <kyle.swenson@est.tech>
Subject: Re: [PATCH v2 2/2] dt-bindings: leds: fix indentation in examples
Message-ID: <20220524183508.GA4137648-robh@kernel.org>
References: <20220524070815.42997-1-krzysztof.kozlowski@linaro.org>
 <20220524070815.42997-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524070815.42997-2-krzysztof.kozlowski@linaro.org>
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

On Tue, 24 May 2022 09:08:15 +0200, Krzysztof Kozlowski wrote:
> The examples were mixing 4-space with 2- and 3-space indentations, so
> correct them to use 4-space one.  No functional change.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. None
> 
> Cc: Kyle Swenson <kyle.swenson@est.tech>
> ---
>  .../devicetree/bindings/leds/leds-lp50xx.yaml | 110 ++++-----
>  .../devicetree/bindings/leds/leds-lp55xx.yaml | 222 +++++++++---------
>  .../bindings/leds/leds-pwm-multicolor.yaml    |  36 +--
>  3 files changed, 184 insertions(+), 184 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
