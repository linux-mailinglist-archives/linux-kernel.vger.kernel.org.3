Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4B653AF33
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiFAVVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 17:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiFAVV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 17:21:29 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E7DB2262;
        Wed,  1 Jun 2022 14:21:28 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-f16a3e0529so4429304fac.2;
        Wed, 01 Jun 2022 14:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/6oW80QhCXjbAr5bxlOoJ7/dv7sc0dGdxBSJIeKExWo=;
        b=mhWzM3fuJuJYIUA5og2IP7mpus699bwmkjfSONYtcjVsFX6P/sRqpW89VugoIx++SF
         Dgty67OzqAMjxLvIRMTSrxcOofswB4whNalLlbnTh/ZXJIrSCoNB+R8lgKWwaTiuiv1Z
         a/w8KJQ/oGx6XmcFkpQYMdapJ2PBBhFFVHgUaseOlWsd+alU3vefdjw5r8t2veIWUbx3
         CujlcZyy2Sqd0+pEwxvBSo6sahHMkuzhlh/oOShl6mVUJ5bhmWvK9bTEF0tE4bdLFodB
         uwV3Vf+NetZhivOzMju1L2ZGkTuegW+4768MENtayJOBjQuFET314g+tXkpIUr5m0e2n
         BQBQ==
X-Gm-Message-State: AOAM531Bk/PSLQU7tbzvQsjorYApR4OMpbAIat6+K9SZH2G+W8fV+HTw
        UusT3RslHW3qJeEGChbZOQ==
X-Google-Smtp-Source: ABdhPJyc4qId+hrK3KeE4gabGhq0ngAeE/HQ4HLixDztb207ktrOgTlTDf0YaoiGHWQFDZ9/OXgLSA==
X-Received: by 2002:a05:6870:2483:b0:ed:f721:2734 with SMTP id s3-20020a056870248300b000edf7212734mr932553oaq.242.1654118487846;
        Wed, 01 Jun 2022 14:21:27 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j25-20020a4ad6d9000000b0035eb4e5a6bcsm1465578oot.18.2022.06.01.14.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 14:21:27 -0700 (PDT)
Received: (nullmailer pid 478219 invoked by uid 1000);
        Wed, 01 Jun 2022 21:21:26 -0000
Date:   Wed, 1 Jun 2022 16:21:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-mediatek@lists.infradead.org, robh+dt@kernel.org,
        henryc.chen@mediatek.com, johnson.wang@mediatek.com,
        devicetree@vger.kernel.org, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        lee.jones@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        zhiyong.tao@mediatek.com
Subject: Re: [PATCH 4/7] dt-bindings: mfd: Add compatible for MT6331 PMIC
Message-ID: <20220601212126.GA478182-robh@kernel.org>
References: <20220520124039.228314-1-angelogioacchino.delregno@collabora.com>
 <20220520124039.228314-5-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520124039.228314-5-angelogioacchino.delregno@collabora.com>
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

On Fri, 20 May 2022 14:40:36 +0200, AngeloGioacchino Del Regno wrote:
> Add a compatible for the MT6331 PMIC MFD device.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/mfd/mt6397.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
