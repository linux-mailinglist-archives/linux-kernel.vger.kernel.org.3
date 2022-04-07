Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4CA4F8266
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344425AbiDGPGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344418AbiDGPGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:06:12 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396E11EF9C0;
        Thu,  7 Apr 2022 08:04:11 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-de48295467so6646097fac.2;
        Thu, 07 Apr 2022 08:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rIFirC+hrkJJZLD+rhTVtR0S3qBIL5Kp1loYfP1qXKs=;
        b=YsG4dnwrd95oUeeUcGkuSji7n8zU4Rcb5paVLjrmpxslmtIrXCf36RwGob57OXEH37
         qq6DvlB4JgP5H2yaQi+LFYKMyL526O5j0QSo6ctk2rtVnMW52QvJh+I52CuKXNMAAfZ3
         MhQay3yDRmkCekqnTOOghtIYlCTPG6UnvVfzPO5yp5uC3NcKGRO64TIx9qDbIFpYEMS8
         ZitZev/+imywMELjZ1n5zHFTxT8ltvpcuU4Jnl5ifwgxnFbfmsF9laBTXkuvzKUufI3q
         6EUgWKIpn/ah+jLbABAnXHab0DrURt2+LiSpMYMTfwKoj9ZLcMjOryv6xbYDinJXKeXu
         IMKg==
X-Gm-Message-State: AOAM531oTBh58Eby/IdC7+ZuvcywXS0gKezQiXmVGwsQWdCRvtqFDMDh
        61zUClqMqIiAYkuJKhbOOg==
X-Google-Smtp-Source: ABdhPJxwquMJUiYkV4ltSOgoQUwGo+ob/LNkodx/eg5e/D6v7vXATUJuGCiGgcXyfb4oNPEV/gL0qQ==
X-Received: by 2002:a05:6870:80cc:b0:e2:6a85:1ed3 with SMTP id r12-20020a05687080cc00b000e26a851ed3mr1484019oab.146.1649343850502;
        Thu, 07 Apr 2022 08:04:10 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h186-20020acab7c3000000b002ef5106248asm7664344oif.45.2022.04.07.08.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 08:04:10 -0700 (PDT)
Received: (nullmailer pid 1086295 invoked by uid 1000);
        Thu, 07 Apr 2022 15:04:09 -0000
Date:   Thu, 7 Apr 2022 10:04:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     krzk@kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org,
        kernel@axis.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, alim.akhtar@samsung.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: timer: exynos4210-mct: Add ARTPEC-8
 MCT support
Message-ID: <Yk79acnuZE1Wj/3s@robh.at.kernel.org>
References: <20220407074432.424578-1-vincent.whitchurch@axis.com>
 <20220407074432.424578-2-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407074432.424578-2-vincent.whitchurch@axis.com>
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

On Thu, Apr 07, 2022 at 09:44:29AM +0200, Vincent Whitchurch wrote:
> The ARTPEC-8 has an MCT with 4 global and 8 local timer interrupts.
> 
> The SoC has a quad-core Cortex-A53 and a single-core Cortex-A5 which
> share one MCT with one global and eight local timers.  The Cortex-A53
> and Cortex-A5 do not have cache-coherency between them, and therefore
> run two separate kernels.
> 
> The Cortex-A53 boots first and starts the global free-running counter
> and also registers a clock events device using the global timer.  (This
> global timer clock events is usually replaced by arch timer clock events
> for each of the cores.)
> 
> When the A5 boots (via the A53), it should not use the global timer
> interrupts or write to the global timer registers.  This is because even
> if there are four global comparators, the control bits for all four are
> in the same registers, and we would need to synchronize between the
> cpus.  Instead, the global timer FRC (already started by the A53) should
> be used as the clock source, and one of the local timers which are not
> used by the A53 can be used for clock events on the A5.
> 
> To support this hardware, add a compatible for the MCT as well as two
> new properties to describe the hardware-mandated sharing of the FRC and
> dedicating local timers to specific processors.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
> 
> Notes:
>     v3:
>     - Add all required bindings for ARTPEC-8 in one patch
>     - Rename and split local-timer-only to samsung,local-timers and
>       samsung,frc-shared
>     - Restrict above properties to the ARTPEC-8 compatible.
>     - Rewrite descriptions of properties to hopefully describe hardware.
>     
>     v2:
>     - Use devicetree property instead of module parameter.
> 
>  .../timer/samsung,exynos4210-mct.yaml         | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)

What's this based on? Doesn't apply on v5.18-rc1.

Rob
