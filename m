Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A0E4A628B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241149AbiBARgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:36:18 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:33565 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbiBARgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:36:16 -0500
Received: by mail-oi1-f175.google.com with SMTP id x193so34848949oix.0;
        Tue, 01 Feb 2022 09:36:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DbjyS1SU0OOrgkQcW0sX0PE+YVKxs+Zqjrqu7xDG60Y=;
        b=epmKWqtekntGwFkBfa442Ly7mf0aX1lh0flwmD/5aBKJZPKWEnLGzLD9+wSM4b2kkb
         MzoSFh8DUKjsXtayjm3bIQ6onL22CuqlUH+zSDfVy5l1B32QAeOzA/VTaoOEcDeqFqYJ
         yNRzvxH1u1SKJ9hXBmtKrQanSx5VdwAnfF1ZFWzW6YvyGkNCELFzuoBwJBVTUzXlX/FK
         AfABrSSl8tviSbmQA81XDGX3KMhMEq1QB8YLSjsCAM2taWKGzyjNWz0eG4EMSuTNexPO
         Qs/p4d+UoUCO/K6v01s7/3hbAsVpgTJa9MejIZMml3H9f3sO0Arww0Am9lnhT86/d8Pl
         udiA==
X-Gm-Message-State: AOAM5320pZMSgS2i24sXZwaw00+WQxsuHnfbzn7fR/WUVLCfhQi63fyR
        J/E8gtPlSONeTYbozCIkuA==
X-Google-Smtp-Source: ABdhPJwceg72bbuf7VG/Ghn6k1y6nUaJQxvEwmZ2eCiNVWBDLHF8YxYua/a027qU1v9nRYXGFVYLfw==
X-Received: by 2002:a54:4812:: with SMTP id j18mr1862557oij.276.1643736976189;
        Tue, 01 Feb 2022 09:36:16 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id h2sm9172995ots.51.2022.02.01.09.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 09:36:15 -0800 (PST)
Received: (nullmailer pid 254693 invoked by uid 1000);
        Tue, 01 Feb 2022 17:36:14 -0000
Date:   Tue, 1 Feb 2022 11:36:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 5/5] dt-bindings: serial: samsung_uart: Document
 Exynos5433 compatible
Message-ID: <Yflvjt9TcuTvIMqA@robh.at.kernel.org>
References: <20220129175332.298666-1-krzysztof.kozlowski@canonical.com>
 <20220129175332.298666-5-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129175332.298666-5-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2022 at 06:53:32PM +0100, Krzysztof Kozlowski wrote:
> Document the Exynos5433 UART compatible, supported since commit
> 31ec77aca72e ("serial: samsung: Add the support for Exynos5433 SoC").
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  Documentation/devicetree/bindings/serial/samsung_uart.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
