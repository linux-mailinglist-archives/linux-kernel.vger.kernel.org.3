Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6799257C048
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 00:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiGTWtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 18:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiGTWtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 18:49:42 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D9049B68;
        Wed, 20 Jul 2022 15:49:41 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id l24so37593ion.13;
        Wed, 20 Jul 2022 15:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uudCfMoYFHaWIp2NdRpHUhHzsRCrz4L8cMx9XDQIpNg=;
        b=n8mvcAmOilA2ICE29iTYTMrU02T4lWksKCRNdYQ3g19zyXHWi8D+QVRj9ohB+R5s9H
         D78M5hMNWd7T9vPef+YTcSyPql6xOMKMly/0WH7nw6PTXUDBfopxvT+7KA2sQnduQhNo
         IDgcaXYCv0Nq1BlgRB+Vi+2rfKUjbV4KdFxNxLWUsnzNphLOjFhCpvFdl5jjF91Dy1Wb
         sFhMteJl+lvKS0Q1Cr/n+rBbXypPCnOG8yoBomHiiFGTEyy4lUFF5XPGSFkxcZwcR/++
         k2GZ30yTJx9ttt54GVRKOOAfrUtX365fkwW/5INmZ5RKC8yiTRcRN8opjoPDD5hVftAp
         U+dQ==
X-Gm-Message-State: AJIora+W65epTX+1dsRQp0NUz6yIqxXzSRYkLnRGoAPMMGUBsUuJLhGr
        RaTxarBXFCaLLtmHCiWhhw==
X-Google-Smtp-Source: AGRyM1ucXvmUfKZSjkYIDpngUX5sujdw4QIMe7LofXXXuxjWnLitU/7340g3Wumifxlei+fOqJ2uLg==
X-Received: by 2002:a02:84e2:0:b0:33f:7ec1:b430 with SMTP id f89-20020a0284e2000000b0033f7ec1b430mr21553218jai.63.1658357381015;
        Wed, 20 Jul 2022 15:49:41 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id j6-20020a026306000000b0033ec45fb044sm79055jac.47.2022.07.20.15.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 15:49:40 -0700 (PDT)
Received: (nullmailer pid 4125435 invoked by uid 1000);
        Wed, 20 Jul 2022 22:49:38 -0000
Date:   Wed, 20 Jul 2022 16:49:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     pierre-louis.bossart@linux.intel.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, kai.vehmanen@linux.intel.com,
        festevam@gmail.com, linux-arm-kernel@lists.infradead.org,
        tiwai@suse.com, ranjani.sridharan@linux.intel.com,
        linux-imx@nxp.com, s.hauer@pengutronix.de,
        sound-open-firmware@alsa-project.org, shawnguo@kernel.org,
        yung-chuan.liao@linux.intel.com, lgirdwood@gmail.com,
        peter.ujfalusi@linux.intel.com, daniel.baluta@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, kernel@pengutronix.de,
        alsa-devel@alsa-project.org, perex@perex.cz, broonie@kernel.org,
        devicetree@vger.kernel.org, shengjiu.wang@gmail.com
Subject: Re: [PATCH 2/2] dt-bindings: dsp: fsl: Add SOF compatile string for
 i.MX8ULP
Message-ID: <20220720224938.GA4125402-robh@kernel.org>
References: <1658208367-24376-1-git-send-email-shengjiu.wang@nxp.com>
 <1658208367-24376-2-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658208367-24376-2-git-send-email-shengjiu.wang@nxp.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jul 2022 13:26:07 +0800, Shengjiu Wang wrote:
> Add SOF compatile string "fsl,imx8ulp-dsp" for supporting DSP
> device on i.MX8ULP platform.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  Documentation/devicetree/bindings/dsp/fsl,dsp.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
