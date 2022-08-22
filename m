Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB48859C83E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 21:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238231AbiHVTMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 15:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238340AbiHVTMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 15:12:32 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC91B50192;
        Mon, 22 Aug 2022 12:10:59 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-f2a4c51c45so14061074fac.9;
        Mon, 22 Aug 2022 12:10:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=RyQ2R2dv/3M8lzsIjXV0R+NCfbe4VzghtrRY+W8bSpw=;
        b=NgASn6HwOi7Ul2finqIyuP+L6l7CvFEdLq1GEKX/jlp+4Oque+xqsoEG44nmMDdX6u
         afl/cLtOu1ctBMjaIzELMoS9/TLnbpgWOoUJnDxmu7wqs9YgrqCb5mRpJh+50FC1D6Ad
         Eoad+YvuNWq2zO6p1Jc/nfVJBz+zPgadz37aeCkUsCBqSEu++F6GTh3vEqSjYwc4Md2g
         V+6V5/XKGvYUXnDdcG/hw6f9S1zRpz2Bw2h7698g4yV9ZjetVzlZEHu+4Sy8GwOki58I
         ljAbrIsJXJT5WIIhwXCQy1WgceIskKv5oL93hTP5mR+hXBl7neL9am+f0Xz5OWlW2dQ8
         Qijg==
X-Gm-Message-State: ACgBeo0z8saK6DL5cXNczgQyuBB6I6UKzInwDb22LC4DGxgNPVAL37/l
        VMluwo86M/ZVt7EZ3mhurA==
X-Google-Smtp-Source: AA6agR5bA4WycmNTvTD2/U7R6fOagPZP//u9KeaYWrui4/55tDupOwumUUqlIU8jnWDyBbSuSIc46Q==
X-Received: by 2002:a05:6870:1715:b0:11d:80d4:9972 with SMTP id h21-20020a056870171500b0011d80d49972mr1394577oae.52.1661195458566;
        Mon, 22 Aug 2022 12:10:58 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j23-20020a056808035700b003449ff2299esm2752348oie.4.2022.08.22.12.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 12:10:58 -0700 (PDT)
Received: (nullmailer pid 223613 invoked by uid 1000);
        Mon, 22 Aug 2022 19:10:57 -0000
Date:   Mon, 22 Aug 2022 14:10:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>,
        devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v4 5/6] dt-bindings: drm/msm/gpu: Add optional resets
Message-ID: <20220822191057.GA223526-robh@kernel.org>
References: <1660927246-11327-1-git-send-email-quic_akhilpo@quicinc.com>
 <20220819221017.v4.5.Ieffadd08a071a233213ced4406bf84bb5922ab9a@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819221017.v4.5.Ieffadd08a071a233213ced4406bf84bb5922ab9a@changeid>
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

On Fri, 19 Aug 2022 22:10:44 +0530, Akhil P Oommen wrote:
> Add an optional reference to GPUCC reset which can be used to ensure cx
> gdsc collapse during gpu recovery.
> 
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---
> 
> Changes in v4:
> - New patch in v4
> 
>  Documentation/devicetree/bindings/display/msm/gpu.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
