Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731214627E5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 00:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbhK2XOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 18:14:31 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:41485 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbhK2XOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:14:20 -0500
Received: by mail-ot1-f52.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so27680618otl.8;
        Mon, 29 Nov 2021 15:11:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CMaGKX/h46j8VfqR9A4axIYozojVdsex0bKjA1RLIq4=;
        b=Qwd9jUBWEZnY9SChf79J5MvL9MjDAFABLj0Ih3DGcDUQTkiyI0WBzPAhNcUxE7WDOU
         MHspEnxZ0mmJD4J4ozeXgNI79DbuGC7LPuMOi2iPpLfdsmJiI8YdoQl4MAaZeBcfPgoZ
         f5opg0h0ap8pznldr6SAdpxb5/VkFnUNuMGH/Fv4ZzYGYNqFrmySv/y2d+r0UfOcI5FJ
         aFIolmcUBXs5SZJwcf5Y8ElIE4PZ4ZV7PrSLc0DJLKB/CNGoAd35Hs9vLDkxdJiDGmo7
         SN/PPJZc26SGbPQ4LpLMDGyJwNA9VCHzPu/DTo4a2FQMsHPT+u2Kk+fMrAaoGz/Td7kA
         OdkQ==
X-Gm-Message-State: AOAM532dRdUwWnNv2rqgBKOIwt7JxogaW/oorlvDR17OV/ELd1YlR0Uw
        P8gz51vhdbQhm4mCwAlOqw==
X-Google-Smtp-Source: ABdhPJyoXRwEeKNOGspvfHRwIpiq2w/sTFqnwrOAxbflEAbIkmIObIXtRbHes8+29dol+NSw2R1dfQ==
X-Received: by 2002:a9d:12a6:: with SMTP id g35mr47847606otg.61.1638227461716;
        Mon, 29 Nov 2021 15:11:01 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bi20sm3386826oib.29.2021.11.29.15.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 15:11:00 -0800 (PST)
Received: (nullmailer pid 785807 invoked by uid 1000);
        Mon, 29 Nov 2021 23:11:00 -0000
Date:   Mon, 29 Nov 2021 17:11:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: power: supply: pm8941-charger: add
 pm8226
Message-ID: <YaVeBGAnU2CY9SLr@robh.at.kernel.org>
References: <20211118210210.160895-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118210210.160895-1-luca@z3ntu.xyz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2021 22:02:04 +0100, Luca Weiss wrote:
> The charger in PM8226 (used in MSM8226) is similar to the charger in
> PM8941.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  .../devicetree/bindings/power/supply/qcom,pm8941-charger.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
