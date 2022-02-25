Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5984C4F8E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 21:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236307AbiBYUVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 15:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbiBYUVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 15:21:37 -0500
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680AA20A96B;
        Fri, 25 Feb 2022 12:21:05 -0800 (PST)
Received: by mail-oo1-f50.google.com with SMTP id p206-20020a4a2fd7000000b0031bfec11983so7800776oop.13;
        Fri, 25 Feb 2022 12:21:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cVQN4rhbQ0VOMwlW4HIOTs15wpfmF5Ue6t6aR8MNAkQ=;
        b=ttXO8h/T2hCHNgYLo2Ly1WTisNJqnuHDJ64oVr9xNOgKaNk2LJoOV7GlSW+TGKRfbr
         qXUaMC1lg6+qh0a9mbxLmYlRlsRYVG4ToV1fRj3XIO3Grjh7NDb2rUXdQNZQgBiAcKud
         WbXMvm77iafPPpFXKl+ouXp1mw6J5EEF4NcnhSY5YwWvJw4dmZ5qOi15+08ugY6+K2o+
         O/14gTl9psOEasPfus3KsibfxdgVAUQPaBP0aplA2/PNYu2p3Ra/NwBkpXAhLFpqRjkZ
         6NuDoaCWxMlnBJK6vRSdvMlGoP53bNhV2smnxjiRbxoUrmGi2VyoN0TOM9Moo0qFM7Rt
         yy0A==
X-Gm-Message-State: AOAM533z8AK8evg2CK0qBSilWCkNJqiFcOsWqayV2OmxQ9IdLk8vgHm1
        G2xi/XcPmJJ+VLBacYZ8yQ6ojME8kw==
X-Google-Smtp-Source: ABdhPJx8Y+SLyadWMmRFoYqEtYcO0Fuazi2wPPSrB7KFEXUBA6VreCaYupIKMIMx/c3Yt/sE+8pjYg==
X-Received: by 2002:a05:6870:494e:b0:d1:4708:9247 with SMTP id fl14-20020a056870494e00b000d147089247mr2143738oab.160.1645820464751;
        Fri, 25 Feb 2022 12:21:04 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l7-20020a9d4c07000000b005afa8981a42sm1578029otf.8.2022.02.25.12.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 12:21:03 -0800 (PST)
Received: (nullmailer pid 1367683 invoked by uid 1000);
        Fri, 25 Feb 2022 20:21:03 -0000
Date:   Fri, 25 Feb 2022 14:21:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     vkoul@kernel.org, yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        quic_srivasam@quicinc.com
Subject: Re: [PATCH v2 2/3] dt-bindings: soundwire: qcom: document optional
 wake irq
Message-ID: <Yhk6L+Z7cOs5z6hr@robh.at.kernel.org>
References: <20220224133125.6674-1-srinivas.kandagatla@linaro.org>
 <20220224133125.6674-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224133125.6674-3-srinivas.kandagatla@linaro.org>
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

On Thu, Feb 24, 2022 at 01:31:24PM +0000, Srinivas Kandagatla wrote:
> Wake IRQ is optional interrupt that can be wired up on SoundWire controller
> instances like RX path along with MBHC(Multi Button Headset connection).
> Document this in bindings.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  Documentation/devicetree/bindings/soundwire/qcom,sdw.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt b/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
> index b93a2b3e029d..bade68f429b0 100644
> --- a/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
> +++ b/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
> @@ -22,7 +22,7 @@ board specific bus parameters.
>  - interrupts:
>  	Usage: required
>  	Value type: <prop-encoded-array>
> -	Definition: should specify the SoundWire Controller IRQ
> +	Definition: should specify the SoundWire Controller and optional wake IRQ

What about 'wakeup-source' property?

>  
>  - clock-names:
>  	Usage: required
> -- 
> 2.21.0
> 
> 
