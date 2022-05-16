Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798F65288B2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239767AbiEPPXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbiEPPXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:23:49 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB023BF8F;
        Mon, 16 May 2022 08:23:48 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id i66so18954161oia.11;
        Mon, 16 May 2022 08:23:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qUebPv8QwG9bv3Ct/54X53c2K97ko7btR5+8WxOHvFs=;
        b=SO3R3r/fHwrkdf5rfyxmPs9FJ3g4gU0fzPG4cOYV93wC6KzLCavu217sAU7nOLsvG+
         bUv0MLruOkFz0fwjCGrSDAOrQ8v4wHcdMlY3tRy6+iHhohThHENaSQwN70ViFo5emjo0
         7e/kYZZrB4ZaJspM31lVDSwk8zTHSVJMkJkm3GTqK1wHa0yUV0N+rsPKVyJAe0i3QhvH
         idLzRfULHLm9vXQFGe7PDDdbkyzRdIV5iGl8BxIpqamEOej9cXT3EHDhaz2Z+3AYkXVn
         1u3jCFLBZT3HmZZlZIZ6//+BoydKVcuoYolMLquIVRpFZqFXPxgHFc3yh2Y1DLd7n7wb
         q1yw==
X-Gm-Message-State: AOAM531T45E5N6ecuzB0E+iTYN4SR/MoMUlXw6RtI1WcvADT/Wz//zZH
        Y7D3GqadY9thY2egAGMJ7A==
X-Google-Smtp-Source: ABdhPJx33k0GQSQFVgU1JM+JPqexotQR6ro7YUH7l9wpmto50JaG3h/jXGffkezrxvtwVmZBuIp9Og==
X-Received: by 2002:a05:6808:218c:b0:328:c5e6:b2a with SMTP id be12-20020a056808218c00b00328c5e60b2amr9709258oib.173.1652714627585;
        Mon, 16 May 2022 08:23:47 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z18-20020a544592000000b00325cda1ffb2sm3903476oib.49.2022.05.16.08.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 08:23:46 -0700 (PDT)
Received: (nullmailer pid 2672616 invoked by uid 1000);
        Mon, 16 May 2022 15:23:45 -0000
Date:   Mon, 16 May 2022 10:23:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 07/12] dt-bindings: remoteproc: qcom,glink-edge: define
 re-usable schema for glink-edge
Message-ID: <20220516152345.GA2672576-robh@kernel.org>
References: <20220512100006.99695-1-krzysztof.kozlowski@linaro.org>
 <20220512100006.99695-8-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512100006.99695-8-krzysztof.kozlowski@linaro.org>
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

On Thu, 12 May 2022 12:00:01 +0200, Krzysztof Kozlowski wrote:
> 'glink-edge' property appears in multiple bindings, so split it into one
> place which can be re-used.  This reduces code duplication and strict
> schema matching for glink-edge nodes (instead of just "type:object").
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/remoteproc/qcom,adsp.yaml        |  2 +-
>  .../bindings/remoteproc/qcom,glink-edge.yaml  | 72 +++++++++++++++++++
>  .../remoteproc/qcom,sc7280-wpss-pil.yaml      | 18 ++---
>  3 files changed, 77 insertions(+), 15 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,glink-edge.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
