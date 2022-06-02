Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDE153BACB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 16:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235964AbiFBOcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 10:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbiFBOcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 10:32:48 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2BF27ED90;
        Thu,  2 Jun 2022 07:32:47 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id h188so6765841oia.2;
        Thu, 02 Jun 2022 07:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+XaxE4rPLjVoV9JRTROBnf5ZLA1J4kOTKBNPishDofY=;
        b=YXWrVqzmhOpDg8QkniZZfpUZilmYXJ1q2yYXWSxRCTWs8Qm80tpSmq/wD2v9x57QoJ
         95APRTYyY67UnppXWa7ZsQ8FI/ojVAI8jf4Teh/fEUO7hDd/BixzPlv+dCc8ZMiNQ09I
         rk+hG1l1ElurHwNa0sbRVLQwx0hkXnI57NqAcvbZH/KVNNHcm+cYHk/h9Y2XRfhkvlwZ
         7NvzdnwXqX4KZVYxcdKV7PO1jPnPG6tf+uD7YyXOba9ip0bPJGUdbWtwA6ux9dbDhVGK
         q3i+E02hIr/p5HzmeQt5Ujw5xVcK+zCDiYYLwgy2RitQ0dMUmHMnUR1rb7jiYS/e0Yn/
         h8WA==
X-Gm-Message-State: AOAM532UmHLif4IWQyWL+k83D4T7mo9TUtB2I3aZek4KADO7/8brinKD
        GhoeZgh6ns2hWLmKUjLa9w==
X-Google-Smtp-Source: ABdhPJyWiiAKe/UbWmNUNQ/FQ+S2DMuUIpmbFtfNXN9RGhS3gWjfztpwD6ap26gWXzQPR8y2FqhZwA==
X-Received: by 2002:a05:6808:17a8:b0:327:9efa:cf1a with SMTP id bg40-20020a05680817a800b003279efacf1amr17612095oib.81.1654180366543;
        Thu, 02 Jun 2022 07:32:46 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k13-20020a54470d000000b0032603df9d24sm2232704oik.47.2022.06.02.07.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 07:32:46 -0700 (PDT)
Received: (nullmailer pid 2261171 invoked by uid 1000);
        Thu, 02 Jun 2022 14:32:45 -0000
Date:   Thu, 2 Jun 2022 09:32:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, quic_plai@quicinc.com, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        quic_rohkumar@quicinc.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: lpass-cpu: Update external mclck0
 name
Message-ID: <20220602143245.GA2256965-robh@kernel.org>
References: <1654169206-12255-1-git-send-email-quic_srivasam@quicinc.com>
 <1654169206-12255-2-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1654169206-12255-2-git-send-email-quic_srivasam@quicinc.com>
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

On Thu, Jun 02, 2022 at 04:56:45PM +0530, Srinivasa Rao Mandadapu wrote:
> Update "audio_cc_ext_mclk0" name to "core_cc_ext_mclk0",
> as MI2S mclk is being used is from lpass core cc.

This is safe to change breaking the ABI because ...

Names are supposed to be local to the module, not based on their source. 

> 
> Fixes: 98b7630a583f ("ASoC: dt-bindings: lpass-cpu: Update clocks and power domain names for sc7280 platform")
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> ---
>  Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
> index e9a5330..8438ef77 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
> +++ b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
> @@ -195,7 +195,7 @@ allOf:
>            oneOf:
>              - items:   #for I2S
>                  - const: aon_cc_audio_hm_h
> -                - const: audio_cc_ext_mclk0
> +                - const: core_cc_ext_mclk0
>                  - const: core_cc_sysnoc_mport_core
>                  - const: core_cc_ext_if0_ibit
>                  - const: core_cc_ext_if1_ibit
> -- 
> 2.7.4
> 
> 
