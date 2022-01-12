Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879DE48BC93
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347913AbiALBon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:44:43 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:40614 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347954AbiALBog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:44:36 -0500
Received: by mail-ot1-f42.google.com with SMTP id t6-20020a9d7746000000b005917e6b96ffso884736otl.7;
        Tue, 11 Jan 2022 17:44:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8FJYBnTRh9rd8jwZmCF0yeW+9K4P/KfA/YEfvfZuWPU=;
        b=3qTVCGibkfF3h6leUmaPSUYcu7aBmobvb4t0yLiM/iAXjpe7yNjltHAr7pH7EcyoGW
         VBCEy7EkbaqH5YT1x6UGcTAB3f5vT6fGrEWOFE68XW+HvUP4fGwG/reHCaLwSCwmV5x3
         Sv7moC8Yxz8T4xrFhHavLTV3XAA+sBuvfNaNi5RYd0N7qMpeZdlCcpdMmF4J7wLeulYS
         40dDvFkLJCaYtZb2Guy/urvacMKUBOtpdR13YvuLicYHE9lCYmC5SRzI0Kok3Oy+kLe8
         fhjE9TU5xK1I9JqrMY5pwZlfVf7MX+AOTZEUWdw6tZVX4T2kT3NUEjnBfxvVceegfI1a
         nuLA==
X-Gm-Message-State: AOAM531n2OY9bCO0/1s5ylnTYJIj0ehKJO2sZxHAEVOK7shjFBy/WJsC
        j400sjVvrPV4R6k+lc2eLw==
X-Google-Smtp-Source: ABdhPJyJdqYCZBTnyRZAAQSUb2Fy0wPfx3w1meJoDKPyViA5DIUnR5fzgQIssWX4qg5Urx6Twwq+Sg==
X-Received: by 2002:a05:6830:2706:: with SMTP id j6mr5193697otu.24.1641951876052;
        Tue, 11 Jan 2022 17:44:36 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bn17sm665232oib.7.2022.01.11.17.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 17:44:35 -0800 (PST)
Received: (nullmailer pid 3889527 invoked by uid 1000);
        Wed, 12 Jan 2022 01:44:34 -0000
Date:   Tue, 11 Jan 2022 19:44:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johnson Wang <johnson.wang@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org, lee.jones@linaro.org,
        broonie@kernel.org, robh+dt@kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] dt-bindings: mfd: Add compatible for the MediaTek
 MT6366 PMIC
Message-ID: <Yd4ygpoi7KrzU012@robh.at.kernel.org>
References: <20220106065407.16036-1-johnson.wang@mediatek.com>
 <20220106065407.16036-4-johnson.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106065407.16036-4-johnson.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jan 2022 14:54:06 +0800, Johnson Wang wrote:
> This adds compatible for the MediaTek MT6366 PMIC.
> 
> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mfd/mt6397.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
