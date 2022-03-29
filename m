Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B55D4EA454
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 03:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiC2BCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 21:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiC2BCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 21:02:21 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1488D23F9C3;
        Mon, 28 Mar 2022 18:00:39 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id p34-20020a4a95e5000000b003248d73d460so2851731ooi.1;
        Mon, 28 Mar 2022 18:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qsEldasqSmPH+uyKPG9uvo/NU8uKdGNTwdCF9sy/D/E=;
        b=6HFD1myHIe4Oz25NBwXFDddKLJRZMwBSBAVE/VIiTPdolT6SHLA3IgJCDaLeH8W2gc
         0vmrfcpQS7+F0J5xD0OIAXWM7/ZYLziHJ1FJEKgSX9GPGCRAJJ7kmQ01Hr4HiQG6Lp9z
         ayboApYop9rqWom+nsHmtys7HRY+j8yP9K8PBIqDms8m7pqmSK3dkIHxrmpAz0SJQ08H
         +1+OEhTdC3/KnomS7/6O5iBHhk+EfUT+mOXunEAR3ISq8FCpKAMiyjulmwnTg+BAY4Q5
         CgVOHRXLudbj/6TxTcq8aLHUemwXHJn1qCB7EGl6hDcJk31nzrnL1HdPQQIf9iwaaK+x
         RUCQ==
X-Gm-Message-State: AOAM533pVxyNNY+03LvCwKqpeajRp3B3fFYHO9bkXMXkY5t73AsfuwTS
        h2LWHgELpNvobDwAn7/3vyz26DSxDA==
X-Google-Smtp-Source: ABdhPJygqRqHhRk4OiSo6iQBjfgsT2QvY6ZZ2r8mczpG9SMPz5GWtegFSl3boIRZpO//0kXJL1k3YA==
X-Received: by 2002:a4a:1784:0:b0:324:5b06:dd0d with SMTP id 126-20020a4a1784000000b003245b06dd0dmr75661ooe.77.1648515638332;
        Mon, 28 Mar 2022 18:00:38 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r205-20020acadad6000000b002ef824213c9sm8044301oig.55.2022.03.28.18.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 18:00:37 -0700 (PDT)
Received: (nullmailer pid 3398741 invoked by uid 1000);
        Tue, 29 Mar 2022 01:00:36 -0000
Date:   Mon, 28 Mar 2022 20:00:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rohitkr@codeaurora.org,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        alsa-devel@alsa-project.org, krzysztof.kozlowski@canonical.com,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH 3/3] ASoC: dt-bindings: lpass-cpu: Update clocks and
 power domain names for sc7280 platform
Message-ID: <YkJaNJT2yt6UpBZG@robh.at.kernel.org>
References: <1647852981-27895-1-git-send-email-quic_srivasam@quicinc.com>
 <1647852981-27895-4-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1647852981-27895-4-git-send-email-quic_srivasam@quicinc.com>
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

On Mon, Mar 21, 2022 at 02:26:21PM +0530, Srinivasa Rao Mandadapu wrote:
> Update required clock-names used for MI2S primary path, VA macro's
> codec memory path and HDMI path in sc7280 based platforms.
> Update power domain names required for sc7280 platforms.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>  .../devicetree/bindings/sound/qcom,lpass-cpu.yaml       | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
> index 2c81efb..e9a5330 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
> +++ b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
> @@ -38,8 +38,8 @@ properties:
>      maxItems: 7
>  
>    clock-names:
> -    minItems: 3
> -    maxItems: 7
> +    minItems: 1
> +    maxItems: 10
>  
>    interrupts:
>      minItems: 2
> @@ -62,6 +62,9 @@ properties:
>    power-domains:
>      maxItems: 1
>  
> +  power-domain-names:
> +    maxItems: 1
> +
>    '#sound-dai-cells':
>      const: 1
>  
> @@ -192,15 +195,19 @@ allOf:
>            oneOf:
>              - items:   #for I2S
>                  - const: aon_cc_audio_hm_h
> +                - const: audio_cc_ext_mclk0
>                  - const: core_cc_sysnoc_mport_core
> +                - const: core_cc_ext_if0_ibit
>                  - const: core_cc_ext_if1_ibit

You can't add new clocks in the middle. That breaks the ABI.

>              - items:   #for Soundwire
>                  - const: aon_cc_audio_hm_h
> +                - const: audio_cc_codec_mem
>                  - const: audio_cc_codec_mem0
>                  - const: audio_cc_codec_mem1
>                  - const: audio_cc_codec_mem2
> +                - const: aon_cc_va_mem0
>              - items:   #for HDMI
> -                - const: aon_cc_audio_hm_h
> +                - const: core_cc_sysnoc_mport_core
>  
>          reg-names:
>            anyOf:
> @@ -228,6 +235,10 @@ allOf:
>                  - const: lpass-irq-hdmi
>                  - const: lpass-irq-vaif
>                  - const: lpass-irq-rxtxif
> +        power-domain-names:
> +          allOf:
> +            - items:
> +                - const: lcx
>  
>        required:
>          - iommus
> -- 
> 2.7.4
> 
> 
