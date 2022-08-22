Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BD159C5AE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 20:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbiHVSEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 14:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236608AbiHVSEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 14:04:08 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD202DA88;
        Mon, 22 Aug 2022 11:04:07 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-11d08d7ece2so7123053fac.0;
        Mon, 22 Aug 2022 11:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=pA++Iu9p2JopuB6JUITUXG7KLROVNcmOWnSn6LTggfc=;
        b=iMvqlpnTAyzMy6YSMmpUUtVGGUVzUw2mi8e2ON665cV0m300q42CHR60kVXitbCVW/
         wr9bfYRxIEFvQbPKEOIYvZFLoOmC0M6G0nWPLT2XMgY84eZl2JM2PAcyTCdkGCWNM5GZ
         bLF6f1fAJgx2+yfxHvBZUJnN0U9P2j92ZQQZScm0Yv9thvniimZ8Sbn3n6T4bzZvjsVH
         rewclG8QHnF2Qz/Vg+wW1//dloBN+iIUm8CZYT0WQf3IlLWKPFgqXIT6yAyie1ZpiK3O
         4OsDMYrl2mKlCD7XOFXH7eXU0h0fP+i+F9tBF/kxfgtHWrsD/6+5X8Z9ymZ85imKspCA
         V3bQ==
X-Gm-Message-State: ACgBeo16ouc7EDhN8PPvprJbntj3gycagVPtNRPDt4a8PHg64Ai4EpHz
        RiaUe47z7RzvilScfgFXh0NcD2dzVg==
X-Google-Smtp-Source: AA6agR5hUiVd/6srf4Qzt7WmWVXXxN/fKwe2rBX366NnnuCtZ0xEIzK1+aEvcrFiEU87ZRniN+D4lw==
X-Received: by 2002:a05:6870:64a1:b0:11c:5ca9:e519 with SMTP id cz33-20020a05687064a100b0011c5ca9e519mr12661713oab.4.1661191446430;
        Mon, 22 Aug 2022 11:04:06 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v23-20020a544497000000b0034480f7eec4sm2724879oiv.12.2022.08.22.11.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 11:04:06 -0700 (PDT)
Received: (nullmailer pid 75047 invoked by uid 1000);
        Mon, 22 Aug 2022 18:04:05 -0000
Date:   Mon, 22 Aug 2022 13:04:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>
Subject: Re: [PATCH v2] dt-bindings: gpu: arm,mali: restrict opp-table to
 objects
Message-ID: <20220822180405.GA75021-robh@kernel.org>
References: <20220818061713.9611-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818061713.9611-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 18 Aug 2022 09:17:13 +0300, Krzysztof Kozlowski wrote:
> Simple 'opp-table:true' accepts a boolean property as opp-table, so
> restrict it to object to properly enforce real OPP table nodes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Correct typo in msg.
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml | 3 ++-
>  Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml  | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 

Applied, thanks!
