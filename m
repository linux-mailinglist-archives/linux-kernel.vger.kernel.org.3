Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C270B4B2A2C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351456AbiBKQY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:24:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351414AbiBKQY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:24:28 -0500
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568623AD;
        Fri, 11 Feb 2022 08:24:26 -0800 (PST)
Received: by mail-oo1-f44.google.com with SMTP id o128-20020a4a4486000000b003181707ed40so10851303ooa.11;
        Fri, 11 Feb 2022 08:24:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kk86tqsUEpDxDSxl+QDVY+d5jMkdIEVlk+S99jE+nwY=;
        b=orAsap5i7t6qb+bOf+RnTyV+xxH9aJ07p53Ajrs9AU0bfKpqLcO1KUN938Nx3px1XP
         9BQ+tjQUVZRR0KVY5If5pyCO80LEH9fG2ZB5EViAW1f9PaV2vTtEPaHa63qwMYLK8bzI
         rDThbz8knfIv+h2U1m/kocjAiDgVSNbAkadjK+023IlX7MAt20vGS+4mEaBsF6T5LRJf
         W/fbEtZ/j4IhVHqGsbRdekpwyl1DPMDjmEiXTLmsStZ8XX4kNPoW8KbXIZr0en5za6Yd
         AtTlZwjO4FyTFzubK68ItjD+DerMGX4vPFIeLFtwsFREhWmSgZCdKZw9w0t5wfYpJPZ/
         hiPw==
X-Gm-Message-State: AOAM533zxnv6RnSeU/wBUcuPmHbI7euNIunf/ury3izbZ+1sTc5SuVPO
        yYApxEhdLyru3B5DLs0VdQ==
X-Google-Smtp-Source: ABdhPJwKruKy6RoVrRIbIioHuouwXc6h8IL6hYm+OIbFE+u/d+PwHhNYbAkPHqMG6SHemeIcPu1jZQ==
X-Received: by 2002:a05:6870:5795:: with SMTP id i21mr405221oap.284.1644596665526;
        Fri, 11 Feb 2022 08:24:25 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:5fee:dfce:b6df:c3e1:b1e5:d6d8])
        by smtp.gmail.com with ESMTPSA id 4sm9809239oon.21.2022.02.11.08.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 08:24:24 -0800 (PST)
Received: (nullmailer pid 465268 invoked by uid 1000);
        Fri, 11 Feb 2022 16:24:20 -0000
Date:   Fri, 11 Feb 2022 10:24:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-pwm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
Subject: Re: [PATCH] dt-bindings: pwm: mtk-disp: add compatible string for
 MT8183 SoC
Message-ID: <YgaNtPOGlX0hZpWw@robh.at.kernel.org>
References: <20220207112657.18246-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207112657.18246-1-allen-kh.cheng@mediatek.com>
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

On Mon, 07 Feb 2022 19:26:57 +0800, Allen-KH Cheng wrote:
> From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> 
> Add compatible string for MT8183 SoC in device tree binding.
> 
> Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
