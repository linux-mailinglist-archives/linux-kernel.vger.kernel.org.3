Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9975926A0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 23:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240376AbiHNV0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 17:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236100AbiHNV0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 17:26:20 -0400
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E349E4F;
        Sun, 14 Aug 2022 14:25:23 -0700 (PDT)
Received: by mail-pl1-f178.google.com with SMTP id o3so4950552ple.5;
        Sun, 14 Aug 2022 14:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Qo7JqMyBl98Dfi1GLWq2+D40THRpPwUbZg2FaTyray4=;
        b=p0vQAsG3/dy/JTUKA7ZNpWVmPrDj+J4Oy5ecuw/4lKSYdN1oBl3aH938q9KQQoHidr
         yt6rIafB7uMuk+hn/5F+6NQ0ePQz1+HMVh0DkG/8RFWrln+wZiCWUK3LkFidFC+PXiJy
         qk8vedt9FX4l2nq+Tpwz11tlabmIJZCG3m4L+QxZHlFJPOVrvi47cTSVYnAxTmSTeOGZ
         bFA5VD8kU7dcDxfnJKrXOL77LW179iHYfYxDcOalMhR+prOIhGR0KsH5viHJXtI4bnFE
         hHXTUlrM7HlZeOHFWUu748R8YdqRn6QdIvkw5Fg1sFpfqKnkfxtdSFYHjWqMtNP4gr4Q
         AOmw==
X-Gm-Message-State: ACgBeo2ik6SnWuOBdH7MwEZ6TCxmIXna0miJhRL8dMfVJJIy6H7lgeoE
        67FPMp/5yWou+E+wTjlmtJZzlZlzmg==
X-Google-Smtp-Source: AA6agR6CPtGSg5LrG2ATwGoXMf1RpAO/eKlw9Rdknyh9z164drqoQsdZs5vV+g2HhnZkK+fhVMn1Kw==
X-Received: by 2002:a17:90a:8808:b0:1f7:4bd3:3760 with SMTP id s8-20020a17090a880800b001f74bd33760mr15279401pjn.170.1660512322794;
        Sun, 14 Aug 2022 14:25:22 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:282b:ad51:2025:80dc:3a15:a2de])
        by smtp.gmail.com with ESMTPSA id a6-20020a170902710600b0016ed20eacd2sm5730887pll.150.2022.08.14.14.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 14:25:22 -0700 (PDT)
Received: (nullmailer pid 736117 invoked by uid 1000);
        Sun, 14 Aug 2022 21:25:17 -0000
Date:   Sun, 14 Aug 2022 15:25:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: display/msm: dpu-msm8998: add missing
 DPU opp-table
Message-ID: <20220814212517.GA716652-robh@kernel.org>
References: <20220811084331.83715-1-krzysztof.kozlowski@linaro.org>
 <20220811084331.83715-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811084331.83715-2-krzysztof.kozlowski@linaro.org>
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

On Thu, Aug 11, 2022 at 11:43:27AM +0300, Krzysztof Kozlowski wrote:
> The 'display-controller' child (DPU) of Display SubSystem (MDSS) uses
> opp-table, so reference it which allows restricting DPU schema to fixed
> list of properties.
> 
> Fixes: 6e986a8f1cf1 ("dt-bindings: display: msm: Add binding for msm8998 dpu")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  Documentation/devicetree/bindings/display/msm/dpu-msm8998.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dpu-msm8998.yaml b/Documentation/devicetree/bindings/display/msm/dpu-msm8998.yaml
> index 2df64afb76e6..7ed438bc7dce 100644
> --- a/Documentation/devicetree/bindings/display/msm/dpu-msm8998.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dpu-msm8998.yaml
> @@ -62,6 +62,7 @@ patternProperties:
>    "^display-controller@[0-9a-f]+$":
>      type: object
>      description: Node containing the properties of DPU.
> +    additionalProperties: false
>  
>      properties:
>        compatible:
> @@ -105,6 +106,8 @@ patternProperties:
>          maxItems: 1
>  
>        operating-points-v2: true
> +      opp-table: true

type: object

Otherwise, 'opp-table;' would be accepted.

> +
>        ports:
>          $ref: /schemas/graph.yaml#/properties/ports
>          description: |
> -- 
> 2.34.1
> 
> 
