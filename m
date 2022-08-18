Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07F3598A33
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 19:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344303AbiHRRRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 13:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344995AbiHRRQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 13:16:46 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2E810FFE;
        Thu, 18 Aug 2022 10:11:15 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id m2so2038853pls.4;
        Thu, 18 Aug 2022 10:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=UkBra3gVOO8ib+l1PZXu0p1ulXBzkwr8s3bUgaBZ/K8=;
        b=E6OC5YabVe0YV4FZEz1aEuJMfJyzp294Qzv581wUl5pLLor045eeP7XolWqITLIe3U
         WsmEahN5NWUH7ClUd6cEBLMaBEUnIM9rFXJ75eF63bmWlJSke6ne4ieElda1HTmYuiHk
         nRn3R2lx8EPCex3Zd/G/jtfsDOftz4OVBwKJPvrGT2S5/Vce3vMqZ1A32oPfDJoHDZH1
         WmOwgCqOOhcXIUnVMiKAnZkjWmSFJa7+AweOf17FICCmY7cvIAwc02L6ADzXnxOPK/MR
         KfvlqJu2fCUTYgbDkuzwReDBYUndRucT9hzKnwt24XRGtF/WrCPSeVipIySJeha7Kpla
         3Onw==
X-Gm-Message-State: ACgBeo0YAxbWiZRFZyOjyoD0PfyJowpm/xHsePRxPdU/+2lRx5hqaVlX
        eMRH9N8bVj1otl0Cp1ca/w==
X-Google-Smtp-Source: AA6agR7B6dYCsFfF4wBcu8MtvLiFnN/aVGCtQghP/Tl/gPgbvyxd+EHMIWOZik0LVYNMxuQPMADzrw==
X-Received: by 2002:a17:90b:48d0:b0:1fa:b438:1b20 with SMTP id li16-20020a17090b48d000b001fab4381b20mr9048996pjb.239.1660842674884;
        Thu, 18 Aug 2022 10:11:14 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:647:4ff2:3529:f8cd:d6cd:ac54])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902eb8400b0016c9e5f291bsm1592907plg.111.2022.08.18.10.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 10:11:14 -0700 (PDT)
Received: (nullmailer pid 2044597 invoked by uid 1000);
        Thu, 18 Aug 2022 17:11:11 -0000
Date:   Thu, 18 Aug 2022 11:11:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] ASoC: qcom: dt-bindings: add sm8450 and sc8280xp
 compatibles
Message-ID: <20220818171111.GF1978870-robh@kernel.org>
References: <20220818134619.3432-1-srinivas.kandagatla@linaro.org>
 <20220818134619.3432-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818134619.3432-2-srinivas.kandagatla@linaro.org>
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

On Thu, Aug 18, 2022 at 02:46:14PM +0100, Srinivas Kandagatla wrote:
> This patch adds SM8450 and SC8280XP compatible entry for LPASS TX, RX, WSA
> and VA codec macros.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/sound/qcom,lpass-rx-macro.yaml          | 2 ++
>  .../devicetree/bindings/sound/qcom,lpass-tx-macro.yaml          | 2 ++
>  .../devicetree/bindings/sound/qcom,lpass-va-macro.yaml          | 2 ++
>  .../devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml         | 2 ++
>  4 files changed, 8 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>

