Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1663953B921
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 14:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbiFBMtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 08:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbiFBMtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 08:49:40 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044C88CB3D;
        Thu,  2 Jun 2022 05:49:39 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id n2-20020a9d6f02000000b0060b22af84d4so3330316otq.1;
        Thu, 02 Jun 2022 05:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8dHaiY0Rl5CB2hlVFjBwyD0ro7wqlVHrD/ueJdsNs5w=;
        b=6sAo5I2S5fr2pTO8Z+JJjhpBHqH5hqDBbLKmJpQp7eZgOKoueDIc+XDxNh2vMNcp3L
         OuxeP/AyycqK/fKjmG3d6DK+vQnXVS1FAbZjS6zJ2CYrlRDP0MBppA7mfEv7o+LEJheB
         s6qgtHBy3pcFyLH4xXcFZ1HlLuAtG/DxL9tIBSXPz81BhHXKDdlk2T4hkxAI/6m8jP8Z
         1A6Je9uGuGW7UxJgKq0a/dJs7QgIUqzLTR0/gLM+t86HhlDBkkhE7XZ2GUMTjWFNDMAy
         MT/ydVGAHPujKqHeafjIYous9jDbcm0/yG5fuGWFb3LV9faa2L8w2xMeO7GrjediohjX
         p1hg==
X-Gm-Message-State: AOAM533VENV921LXQL0zkOtIsa25e41PdclvdAGoMEqIcje9yOKGGPGY
        R8emjqt2kvoDQKS6X8pKKQ==
X-Google-Smtp-Source: ABdhPJzGQ+0esaEVqZtsiqfxX6F+CFNBtiYt+ADsEwVkoNhGaffdmgNuiBU2eTXBKMCVnt0NNFUk/g==
X-Received: by 2002:a05:6830:2641:b0:606:afb8:8aca with SMTP id f1-20020a056830264100b00606afb88acamr1944888otu.52.1654174178213;
        Thu, 02 Jun 2022 05:49:38 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i23-20020a056808055700b00325cda1ff9fsm2272530oig.30.2022.06.02.05.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 05:49:37 -0700 (PDT)
Received: (nullmailer pid 2079249 invoked by uid 1000);
        Thu, 02 Jun 2022 12:49:36 -0000
Date:   Thu, 2 Jun 2022 07:49:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Junhao Xie <bigfoot@classfun.cn>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        angelogioacchino.delregno@somainline.org,
        konrad.dybcio@somainline.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm: panel: Add samsung fhd-ea8076 panel driver
Message-ID: <20220602124936.GA2077271-robh@kernel.org>
References: <20220521053156.1374185-1-bigfoot@classfun.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521053156.1374185-1-bigfoot@classfun.cn>
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

On Sat, May 21, 2022 at 01:31:55PM +0800, Junhao Xie wrote:
> Add Samsung Full HD EA8076 panel with a resolution of 2340x1080@60Hz
> 
> Xiaomi MIX 3 smartphone uses this panel
> 
> Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
> ---
>  .../display/panel/panel-simple-dsi.yaml       |   2 +

Acked-by: Rob Herring <robh@kernel.org>

In the future, bindings should be a separate patch.

>  drivers/gpu/drm/panel/Kconfig                 |  10 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  .../gpu/drm/panel/panel-samsung-fhd-ea8076.c  | 339 ++++++++++++++++++
>  4 files changed, 352 insertions(+)
>  create mode 100644 drivers/gpu/drm/panel/panel-samsung-fhd-ea8076.c
