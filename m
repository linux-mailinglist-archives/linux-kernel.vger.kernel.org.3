Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E38D52224C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347956AbiEJRZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347920AbiEJRZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:25:17 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6E24616F;
        Tue, 10 May 2022 10:21:16 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id r1so19237888oie.4;
        Tue, 10 May 2022 10:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h4ryxJ2jrSNExLhhmYzyKGyiel0OoRkU5ralwjePwSY=;
        b=xVSVdVkxNr+oW1V2xykyF61gjomYNyUsxn8mOG6ISz/BGzqVrnZsE2kKEQfpze27nY
         z9owEM+iZj8GaQr76an8qwnn2Q9dwdNeQ2IC4SwEpdSmchhcw3gKRnofRG6VAsbPvqkq
         sml+y/Bh/mQiaBXVXR8OfbiADlDK9zfGYEcpH7JqeZzxjHGYLoy6Rn3u9STpdyZfGVZE
         7tR59wxevEWuHvUCUsSfWrk4viHWT9QbebaLr21YP3hhKZQStogT6R1QsWiFCoBV5+UD
         pXrXLdNCS2Up7j83gas0HpNk+Ar16wymaiBy04E4xQqLUDdrQZoiHHQuypE5qZML+DSP
         J+sg==
X-Gm-Message-State: AOAM532N0N5QD4a7BqqqRdCsQcrRCo0tjeq1ThCmfWk3zHWyZeLdQHMB
        FYXCFhC3hDTy2OP+Q1gYvg==
X-Google-Smtp-Source: ABdhPJxSViFtXleX6ACNx+piFFh2WquKpHvKnusM+eQztCmHieA6RVfY/Tq4ItgXWYejlF4c1oqxQg==
X-Received: by 2002:a05:6808:150e:b0:328:ab8e:fcfe with SMTP id u14-20020a056808150e00b00328ab8efcfemr314666oiw.120.1652203275435;
        Tue, 10 May 2022 10:21:15 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s7-20020a0568301c6700b006060322123bsm5886462otg.11.2022.05.10.10.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 10:21:14 -0700 (PDT)
Received: (nullmailer pid 2232154 invoked by uid 1000);
        Tue, 10 May 2022 17:21:14 -0000
Date:   Tue, 10 May 2022 12:21:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Ryder Lee <ryder.lee@kernel.org>, hsinyi@chromium.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 3/4] dt-bindings: arm: Add compatible for MediaTek
 MT8186
Message-ID: <YnqfCkaBJyFnDMil@robh.at.kernel.org>
References: <20220510075233.5426-1-allen-kh.cheng@mediatek.com>
 <20220510075233.5426-4-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510075233.5426-4-allen-kh.cheng@mediatek.com>
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

On Tue, 10 May 2022 15:52:32 +0800, Allen-KH Cheng wrote:
> This commit adds dt-binding documentation for the MediaTek MT8186
> reference board.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
