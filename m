Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE98F59C611
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 20:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbiHVSZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 14:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbiHVSZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 14:25:04 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08A61837F;
        Mon, 22 Aug 2022 11:25:03 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id h20-20020a056830165400b00638ac7ddba5so8268506otr.4;
        Mon, 22 Aug 2022 11:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=KgI6tvcF5ekm6PkD5j91BZaJAeBSFOE8AYovOrfGK1o=;
        b=wLyZIxjOqXeEvdrue5CYYnPGxWGSQfA094SHLyMW/eP/0dYjsKllcDxvdzUb/UmwXT
         qtO5nisY4RgfgqtzjbZodkkTGy+FTeSaBjafOhV5IyfbD54t6PowJx+rm97mWA/1+r6H
         jmEe0qaFjQBfkJrmLh+viFdo7DbBeI1p3req+2XTUdDj4E/smSYR8N7SvMlaEMxvO2pE
         DoRzvV1Z5mKNvePQgxN6YoEW4jvEPRlxKy6kB2GFt3Qnht+xhMPBWXf9zCgwxHsRo51M
         SlqNsNuQncQefVqtVgThCbR7ZxRj3hsFG/IuXYRleTxJCFmxNccZbeQ+V4EWOu6Q79Fa
         FIQw==
X-Gm-Message-State: ACgBeo0JixTAHg4Lv3LOC/HNF8mmNP1lGnLlr2VnVAKNoJ2NcxqOL3PL
        3/wYCx5I36te2hONrEc4oA==
X-Google-Smtp-Source: AA6agR5txWZKQZG3RQw2mRr0rNhMvBqip6eol4eL2ljd2cDvICfAIwhZ+UURdLKdP33prwbEegj2DQ==
X-Received: by 2002:a9d:6a4d:0:b0:638:9c7b:40fe with SMTP id h13-20020a9d6a4d000000b006389c7b40femr8140146otn.37.1661192703024;
        Mon, 22 Aug 2022 11:25:03 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s63-20020aca4542000000b00342df642fd3sm2706471oia.48.2022.08.22.11.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 11:25:02 -0700 (PDT)
Received: (nullmailer pid 111155 invoked by uid 1000);
        Mon, 22 Aug 2022 18:25:00 -0000
Date:   Mon, 22 Aug 2022 13:25:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 1/7] dt-bindings: phy: mediatek,tphy: add support type of
 SGMII
Message-ID: <20220822182500.GA111114-robh@kernel.org>
References: <20220819091344.2274-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819091344.2274-1-chunfeng.yun@mediatek.com>
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

On Fri, 19 Aug 2022 17:13:38 +0800, Chunfeng Yun wrote:
> Add support ethernet SGMII, forgot to update type supported.
> 
> Fixes: c01608b3b46b ("dt-bindings: phy: mediatek: tphy: support type switch by pericfg")
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  Documentation/devicetree/bindings/phy/mediatek,tphy.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
