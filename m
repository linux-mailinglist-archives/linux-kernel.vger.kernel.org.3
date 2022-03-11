Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E8C4D6540
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 16:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349907AbiCKPyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 10:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349899AbiCKPwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 10:52:21 -0500
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FA31CCB08;
        Fri, 11 Mar 2022 07:50:55 -0800 (PST)
Received: by mail-oo1-f43.google.com with SMTP id 6-20020a4a0906000000b0031d7eb98d31so10915194ooa.10;
        Fri, 11 Mar 2022 07:50:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YxoZwXk5JXeLrOiq7bY7pTDwkNHArk5BUIDnHUOp3fI=;
        b=XjHeNiwB/r1gEk87H55x7G8nUSVmS2XYotqcJ+zHrd8i5gLH6/CnuJVRijRG2LphtW
         r3zXGoWF9YDLkCcJWeehuF46+cFnlKpKUra+LMjbuXfl23QvS2FDVNaRHpWQs2+RVkI7
         4hxFuu6Sqg5NslZy4xFS2bKXamYzExjyQZ1rBc10rHdx2Y+inWkRMahD8hOKIIZx/HAJ
         ppApSKyBdV8ejl5joExQHB28jOYZ6BUqzlcCXUWPsHa57/VzXYiwS2wmXRYBbrl8k6Ww
         IFraIgtn44jcAqZayr0oDH3CCfMf/goMaMp76rBcQmBdLJtujhWfvbaY4DTSJCJ3iU+N
         tGKg==
X-Gm-Message-State: AOAM530Fqs23SpZs1oxrTvRd3LafvaGvJK4UVtMuN8SM7TvLaBT8H/N8
        ftaelxF0WMabyCcr7W0zMlrMpG7e9Q==
X-Google-Smtp-Source: ABdhPJwTNhTLkhpo9jtKQvQYWXEtv5T34b0UK/llvnOM7PooDJmEUR4392gY6ZLXZe41uYkJ8Pb+sQ==
X-Received: by 2002:a05:6870:4149:b0:da:5e34:9448 with SMTP id r9-20020a056870414900b000da5e349448mr11505061oad.112.1647013855095;
        Fri, 11 Mar 2022 07:50:55 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n11-20020a9d710b000000b005af4ceeaac1sm3727274otj.37.2022.03.11.07.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 07:50:54 -0800 (PST)
Received: (nullmailer pid 3867362 invoked by uid 1000);
        Fri, 11 Mar 2022 15:50:52 -0000
Date:   Fri, 11 Mar 2022 09:50:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     hsinyi@chromium.org, Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: timer: Add compatible for Mediatek
 MT8186
Message-ID: <Yitv3IUpCzp1/eGX@robh.at.kernel.org>
References: <20220311130732.22706-1-allen-kh.cheng@mediatek.com>
 <20220311130732.22706-2-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311130732.22706-2-allen-kh.cheng@mediatek.com>
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

On Fri, 11 Mar 2022 21:07:29 +0800, Allen-KH Cheng wrote:
> From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> 
> This commit adds dt-binding documentation of timer for Mediatek MT8186 SoC
> Platform.
> 
> Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> ---
>  Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
