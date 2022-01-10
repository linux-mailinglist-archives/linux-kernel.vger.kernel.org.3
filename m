Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3488489E79
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 18:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238417AbiAJRgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 12:36:05 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:35333 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238197AbiAJRgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 12:36:04 -0500
Received: by mail-oi1-f174.google.com with SMTP id s127so19689355oig.2;
        Mon, 10 Jan 2022 09:36:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/Bf2rJ2DJql2aQa2+Vma/SpLlbuseiEOmq8cakFAHq8=;
        b=MuYjgJlOS5k3i7bVAoOYDpE3FUfuTr1eE3uVyLAdH0UznEOAZDAmI48nVDy4I3gGAI
         S1ukvkQuakCTI6U2UDg5eC8t8nlUOq1QPRkT01BXiHCSqE2pTFb4pWIhIu8PkTasf6ME
         QCLMd6QHdIqG3SzIkCwKNKtUIC7tSozIjLexh5S9uVQ1ar/03h8SK0zHNUrEJbWytobk
         ehRyBFuatXO2+OViMB3N6/mHUMbH/+k/AxxZf8eriuUa0IYyWVUpINP/NVnvs3QS2iQG
         MvDi7eEEwzYVptD/Pfqexz5rOOrz3+BqEVYbvYYjQjO2nrvDHAyrXcHPpb2xbbDIXlDI
         GGKg==
X-Gm-Message-State: AOAM5302caVHs5iRq3zL+85LVl/WgBH7WXknEm5bdyrXMNeDfWwJ9rWg
        STjLcl05L/UrL9mw3BvRa/YKEkzdhg==
X-Google-Smtp-Source: ABdhPJzUImWVhQdDrEhCGyspSNZ0EeJ0vMDkP3nWD4h9/ykAYPqH+VuRa1QmFsAVU6opb5zP1jUgrA==
X-Received: by 2002:aca:3046:: with SMTP id w67mr402820oiw.20.1641836163812;
        Mon, 10 Jan 2022 09:36:03 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id f9sm1549006oto.56.2022.01.10.09.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 09:36:03 -0800 (PST)
Received: (nullmailer pid 1150878 invoked by uid 1000);
        Mon, 10 Jan 2022 17:36:02 -0000
Date:   Mon, 10 Jan 2022 11:36:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zelong Dong <zelong.dong@amlogic.com>
Cc:     jbrunet@baylibre.com, linux-arm-kernel@lists.infradead.org,
        narmstrong@baylibre.com, robh+dt@kernel.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        khilman@baylibre.com, martin.blumenstingl@googlemail.com
Subject: Re: [PATCH 2/3] dt-bindings: reset: add bindings for the Meson-S4
 SoC Reset Controller
Message-ID: <YdxugtL5PsrwsT6D@robh.at.kernel.org>
References: <20220107023931.13251-1-zelong.dong@amlogic.com>
 <20220107023931.13251-3-zelong.dong@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107023931.13251-3-zelong.dong@amlogic.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Jan 2022 10:39:30 +0800, Zelong Dong wrote:
> Add DT bindings for the Meson-S4 SoC Reset Controller include file.
> 
> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
> ---
>  .../reset/amlogic,meson-s4-reset.h            | 125 ++++++++++++++++++
>  1 file changed, 125 insertions(+)
>  create mode 100644 include/dt-bindings/reset/amlogic,meson-s4-reset.h
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

