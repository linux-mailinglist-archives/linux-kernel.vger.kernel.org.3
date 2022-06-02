Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A2A53B9EF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 15:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235431AbiFBNhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 09:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbiFBNfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 09:35:05 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2749947068;
        Thu,  2 Jun 2022 06:35:04 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-f2e0a41009so6743830fac.6;
        Thu, 02 Jun 2022 06:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tgfreAiExWVjh0PELNOgid7tEm3i3yoN+t28LQQbOv8=;
        b=YEqn23BaaEPKkTfa2UILJWlFXlIPlGU5nxB3XVWA3451/MaIttP59UENDrWI1lEHJR
         Qf8x6BJDhO9u2jIzR4KfIf3qyhzSy7URQ7eC/asT/uZnq2hiaHiCzrHKFugV0jDgsqQP
         cvAJ8X/sQs5f3IZ5u6A4NU/FjwfRicWIOE09IBtid3ckHlmTd3nq6hHTPw12wbiHWHz+
         TTiAgyjcpCBskRDqVKJXt+fWRJCE9K5e7+t5RDuOGQdsTqtHEGCOQIRQuALDhS4Yw6AK
         gKxvPI2YKrlXyc5jGieOVerDePLNsxHJxPOeyIJCUff1To5P/s5BBF166e51QZy5eaH6
         1iNQ==
X-Gm-Message-State: AOAM532s+nWiLValBFAVtc7+DRoH7WnpmxHhRxl7kvc87HHmmRseAlPk
        ksHVuXI9mdFDbkbeieGeGg==
X-Google-Smtp-Source: ABdhPJwWILYV+CaH9AQ9LI9AUkPXoe8U3uEh9QSpzW+3Pmotl16aphMbVSG0O8No11RVjqhlcb7ghg==
X-Received: by 2002:a05:6870:630a:b0:e2:f8bb:5ec with SMTP id s10-20020a056870630a00b000e2f8bb05ecmr2572853oao.171.1654176903469;
        Thu, 02 Jun 2022 06:35:03 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o3-20020a0568080bc300b0032e41b45ea7sm368959oik.18.2022.06.02.06.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 06:35:03 -0700 (PDT)
Received: (nullmailer pid 2160289 invoked by uid 1000);
        Thu, 02 Jun 2022 13:35:02 -0000
Date:   Thu, 2 Jun 2022 08:35:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        alsa-devel@alsa-project.org, broonie@kernel.org,
        aaronyu@google.com, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        angelogioacchino.delregno@collabora.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, julianbraha@gmail.com,
        trevor.wu@mediatek.com, tzungbi@google.com, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 18/20] dt-bindings: mediatek: mt8186: add
 mt8186-mt6366-da7219-max98357 document
Message-ID: <20220602133502.GA2160227-robh@kernel.org>
References: <20220523132858.22166-1-jiaxin.yu@mediatek.com>
 <20220523132858.22166-19-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523132858.22166-19-jiaxin.yu@mediatek.com>
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

On Mon, 23 May 2022 21:28:56 +0800, Jiaxin Yu wrote:
> Add document for mt8186 board with mt6366, da7219 and max98357.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> ---
>  .../sound/mt8186-mt6366-da7219-max98357.yaml  | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mt8186-mt6366-da7219-max98357.yaml
> 

Acked-by: Rob Herring <robh@kernel.org>
