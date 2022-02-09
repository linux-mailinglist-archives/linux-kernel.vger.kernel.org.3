Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB314AFEAA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 21:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbiBIUpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 15:45:09 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbiBIUpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:45:08 -0500
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A6AC03FEEE;
        Wed,  9 Feb 2022 12:45:11 -0800 (PST)
Received: by mail-oo1-f41.google.com with SMTP id 189-20020a4a03c6000000b003179d7b30d8so3908884ooi.2;
        Wed, 09 Feb 2022 12:45:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E6SXQI7BZ89wLWfBrUoQLVzH2X91u9h16GeWEE3Mi8M=;
        b=n+lRk1DOO+dZ/rkjsXsj4DrwmC8xxehuDLcSnBvViXChpDnVLxYiMPBpOFinmpHn+6
         AXKzQKJlEg/8JzuXnl17k5ZvZLB0+TGues0wPFSGbHbZNUo6V6V/yg6SaPS9iBiFfdBh
         R/KNU/pJnrmgqdCmm7qNtSAZ/oycg6DP0pbjXSw6ym+5CxmUCmnb/gFLhO3v2aiQFv7y
         A+Njwjnu0Gw+NP/PekT6Fv+i+xoWdglvfws9Um9XM5v4rJ0SrK7wAJYfZkW/D1JC9Nko
         ocUzxT2/J1+xYupW0yy8z4X/iUUSxpTD+G5OXbI2sSJOcF7hVLXAaI/l8f5FMgRWls0R
         sBig==
X-Gm-Message-State: AOAM531/0IXPl+KgEVEb2SMjadYsGvWi9PSB+iejsmCb8nCHob5LS2sS
        GmvcXtAifkjp/gpdF9OKww==
X-Google-Smtp-Source: ABdhPJy4AH9g61BJTuGzr3+4csdYvHWDckGJ/vzpMmnXYpOaTzvQOyhxZiJysr/kfvlf541SyS4xjA==
X-Received: by 2002:a05:6870:a583:: with SMTP id c3mr1477653oam.197.1644439510352;
        Wed, 09 Feb 2022 12:45:10 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n47sm6957783ota.74.2022.02.09.12.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 12:45:09 -0800 (PST)
Received: (nullmailer pid 875372 invoked by uid 1000);
        Wed, 09 Feb 2022 20:45:08 -0000
Date:   Wed, 9 Feb 2022 14:45:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Eddie Hung <eddie.hung@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        Tianping Fang <tianping.fang@mediatek.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: usb: mtk-xhci: add support ip-sleep
 for mt8195
Message-ID: <YgQn1IXiHdTw0r19@robh.at.kernel.org>
References: <20220128062902.26273-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128062902.26273-1-chunfeng.yun@mediatek.com>
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

On Fri, 28 Jan 2022 14:28:59 +0800, Chunfeng Yun wrote:
> There are 4 USB controllers on MT8195, each controller's wakeup control is
> different, add some specific versions for them.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
> v2:
>   1. fix typo 'specific' suggested by Rob
>   2. add acked-by AngeloGioacchino
> ---
>  .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml          | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
