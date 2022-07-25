Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA4458076A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 00:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237159AbiGYWdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 18:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236517AbiGYWdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 18:33:40 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC3C25C57;
        Mon, 25 Jul 2022 15:33:39 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-10d6e8990b9so16571701fac.7;
        Mon, 25 Jul 2022 15:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gvdTkDTD4sj8bWVGQetV76cBFWfCOzJwfH1ITvigwvA=;
        b=j89+HqiEy67DbfkrcHvX3Xj/zvP/pJXCIQsEaGX1Du/kmDVkoKbduDhypIHzVJDWCG
         OuvaQT6k5Dyp3NBZiNaQbG92q+bVZ+v5Wfwf5GN7AuZsoy3UN2wPbqRdJphbiqlJMCFW
         9XM5eVw1RFMNlPeWu0mEBEkaCyCo1lk++JO2NHSvVGvfTmMbs7GmcuOe8zsxCkRAEyHk
         Or+QkY11wspKrevzz32+G1LGxbYoE1yUSc17VqNBTeny2/M9qxaBbSV9bbzJIrUxZyjI
         XWuFw2cRhQ54K8Qunv+Vv+j95/K5Bh9LmRuxCRpditFolpJQw7rrYi91XQFFJ7xrqBxI
         OI3w==
X-Gm-Message-State: AJIora/lgJUUHs64//vu9d0Jixz5lR60BIjYVWlH9RaT4IAE9zNnfGSN
        Mz+EsGa185RddSukY53v1w==
X-Google-Smtp-Source: AGRyM1tbsj9fm4f4/WGyJF9cPn1HRWe2ZRYNwHIHsRQgWeBpDUjhfCL2Lghhl6Ya6tUPbsw0GxZWVg==
X-Received: by 2002:a05:6870:e30e:b0:10d:c6b4:6396 with SMTP id z14-20020a056870e30e00b0010dc6b46396mr7738252oad.128.1658788418892;
        Mon, 25 Jul 2022 15:33:38 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id c17-20020a9d67d1000000b00618fa37308csm5438157otn.35.2022.07.25.15.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 15:33:38 -0700 (PDT)
Received: (nullmailer pid 2867756 invoked by uid 1000);
        Mon, 25 Jul 2022 22:33:36 -0000
Date:   Mon, 25 Jul 2022 16:33:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        nfraprado@collabora.com, angelogioacchino.delregno@collabora.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: mediatek: watchdog: Fix compatible
 fallbacks and example
Message-ID: <20220725223336.GA2867714-robh@kernel.org>
References: <20220721014845.19044-1-allen-kh.cheng@mediatek.com>
 <20220721014845.19044-2-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721014845.19044-2-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jul 2022 09:48:42 +0800, Allen-KH Cheng wrote:
> The watchdog timer of mt8186. mt8195 and mt7986 have their DT data.
> We should not use 'mediatek,mt6589-wdt' as fallback.
> 
> For mediatek,wdt example of mt8183, We remove mediatek,mt6589-wdt fallback.
> 
> Fixes:a45b408a020b("dt-bindings: watchdog: Add compatible for MediaTek MT8186")
> Fixes:b326f2c85f3d("dt-bindings: watchdog: Add compatible for Mediatek MT8195")
> Fixes:41e73feb1024("dt-bindings: watchdog: Add compatible for Mediatek MT7986")
> Fixes:f43f97a0fc0e("dt-bindings: mediatek: mt8183: Add #reset-cells")
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
