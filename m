Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3C34D6539
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 16:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349984AbiCKPww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 10:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349942AbiCKPwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 10:52:35 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373B11CD9F4;
        Fri, 11 Mar 2022 07:51:01 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id 12so9716630oix.12;
        Fri, 11 Mar 2022 07:51:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6NEUsk0pZcf1ZvCBxSl99gFtqxiz2JOvHrLo+iX2PNw=;
        b=1xwcpeLJBYpWoPIuMMp+GDaDU7lKU/aE6f0/24yv3sKhqU3fhSFPqBpPnJyavyIWwl
         7Zp3dNsbyhWpcz3IcXa1KKrbVhWy7PezrZ3doBABMNnQzhku7Pqf6MDtjhX/3+2o0nFd
         YRN97l02ULIvctbXGHKD08NcBwTxi0JeZOJsQXqU7ecORRjafUCiYqquSgTAC4mAmxh/
         v//d8xPE1D44iAHRuPZQHhp4hZH5pCPOI/P78MkCabufG1SBNgOlOo0xSU9L3wOUPpTh
         aXuLYrSMje1poMVHWAVraJ2YomI2551nwZUUs0SZpsCkdVbLnZZa1kIoBwpiISpqSmG6
         Th+g==
X-Gm-Message-State: AOAM532LH+k5HtO5n6VYmFxTQ7iP8yO99813k44cil5Rf4BuWQ/IXnqp
        GW9ph6W7CIjZWsFKD3toNg==
X-Google-Smtp-Source: ABdhPJz2tFjP0i1YZqYFU0hfa5NCSKGTYu5YnNfXEZ09NUTvDUZh3jhw1aVDauubxBUJCcGUqbsMog==
X-Received: by 2002:a05:6808:2c4:b0:2d7:968c:dd37 with SMTP id a4-20020a05680802c400b002d7968cdd37mr13361942oid.146.1647013860505;
        Fri, 11 Mar 2022 07:51:00 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p67-20020acabf46000000b002d97bda3868sm3886508oif.45.2022.03.11.07.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 07:50:59 -0800 (PST)
Received: (nullmailer pid 3867630 invoked by uid 1000);
        Fri, 11 Mar 2022 15:50:58 -0000
Date:   Fri, 11 Mar 2022 09:50:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mediatek@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        hsinyi@chromium.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v4 2/4] dt-bindings: watchdog: Add compatible for
 Mediatek MT8186
Message-ID: <Yitv4sRQMuewLcfT@robh.at.kernel.org>
References: <20220311130732.22706-1-allen-kh.cheng@mediatek.com>
 <20220311130732.22706-3-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311130732.22706-3-allen-kh.cheng@mediatek.com>
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

On Fri, 11 Mar 2022 21:07:30 +0800, Allen-KH Cheng wrote:
> From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> 
> This commit adds dt-binding documentation of watchdog for Mediatek
> MT8186 SoC Platform.
> 
> Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> ---
>  Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
