Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41FFA47D5DF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 18:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344366AbhLVRch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 12:32:37 -0500
Received: from mail-qt1-f181.google.com ([209.85.160.181]:38546 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhLVRcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 12:32:36 -0500
Received: by mail-qt1-f181.google.com with SMTP id 8so2585712qtx.5;
        Wed, 22 Dec 2021 09:32:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rnVSRUWvGi3hc/dun7RSLrJGOUbv/6Fcvs2Ge1f+9VI=;
        b=zlZPCUCSQMPDMOBc9iLAXa2qUZHX4FVXQEcipfm8FbzmQoOp18XQTQzhPVfSEKunU7
         LeCPBAVSf2c2dxybNxi/flYVWJs0xuwofZ7NbCUW/Za4b4YVxsP5oWS+uGB1fEXCk38o
         h0Zklz60c6tWCuJKRw9W1HJW/VNw8EaUGj1FhAljHRoS2HKY/4khsj9bbXlUypURDaul
         XUgGMGPnTDIbUlMdQ11oY7wm5iJSzmMlJ1lkuQQzTUQFB0XO5wl8SgYjeOlxMx9pjaR7
         LdkMBobxnNtFJmqR+P4ARaqKBeuouKn8vZo1V3uY17QQf16z9rVZ94G3dhPA9PQFrfmd
         ACEg==
X-Gm-Message-State: AOAM5326/s95G/xizAkH0jZdPbfbAMEje8dzPOC5grKcRBANZOqZIpxr
        bQqMT2SqvaEmOtatDiFxuA==
X-Google-Smtp-Source: ABdhPJwWKZzfhNl0pedugmMBWdSFfwQ5oN+9pK3tDg+VA+OSbTZIeuMNMms1VONr7sG3iC9fD4X/wQ==
X-Received: by 2002:ac8:7009:: with SMTP id x9mr2966783qtm.420.1640194356037;
        Wed, 22 Dec 2021 09:32:36 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id ay32sm2271901qkb.63.2021.12.22.09.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 09:32:35 -0800 (PST)
Received: (nullmailer pid 2371335 invoked by uid 1000);
        Wed, 22 Dec 2021 17:32:33 -0000
Date:   Wed, 22 Dec 2021 13:32:33 -0400
From:   Rob Herring <robh@kernel.org>
To:     Maxim Kutnij <gtk3@inbox.ru>
Cc:     linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] This adds a DT binding documentation for the MT6582
 SoC
Message-ID: <YcNhMdN6rzh9yRG1@robh.at.kernel.org>
References: <20211219183134.3849-1-gtk3@inbox.ru>
 <20211219183134.3849-3-gtk3@inbox.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211219183134.3849-3-gtk3@inbox.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 19, 2021 at 11:31:34PM +0500, Maxim Kutnij wrote:
> This adds a DT binding documentation for the MT6582 SoC.

Please follow the convention used for other commits of these files in 
the subject:

dt-bindings: mediatek: ...

(That's true for all commits in the kernel)

> 
> Signed-off-by: Maxim Kutnij <gtk3@inbox.ru>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml           | 4 ++++
>  .../devicetree/bindings/timer/mediatek,mtk-timer.txt          | 1 +
>  Documentation/devicetree/bindings/watchdog/mtk-wdt.txt        | 1 +
>  3 files changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> index 0fa55497b96..fedce0d0f3f 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -26,6 +26,10 @@ properties:
>            - enum:
>                - mediatek,mt2712-evb
>            - const: mediatek,mt2712
> +      - items:
> +          - enum:
> +              - prestigio,pmt5008-3g
> +          - const: mediatek,mt6582
>        - items:
>            - enum:
>                - mediatek,mt6580-evbp1
> diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> index e5c57d6e018..62acdb11aff 100644
> --- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> +++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> @@ -11,6 +11,7 @@ Required properties:
>  - compatible should contain:
>  	For those SoCs that use GPT
>  	* "mediatek,mt2701-timer" for MT2701 compatible timers (GPT)
> +	* "mediatek,mt6582-timer" for MT6582 compatible timers (GPT)
>  	* "mediatek,mt6580-timer" for MT6580 compatible timers (GPT)
>  	* "mediatek,mt6589-timer" for MT6589 compatible timers (GPT)
>  	* "mediatek,mt7623-timer" for MT7623 compatible timers (GPT)
> diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> index 0114871f887..a97418c74f6 100644
> --- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> @@ -8,6 +8,7 @@ Required properties:
>  - compatible should contain:
>  	"mediatek,mt2701-wdt", "mediatek,mt6589-wdt": for MT2701
>  	"mediatek,mt2712-wdt": for MT2712
> +	"mediatek,mt6582-wdt", "mediatek,mt6589-wdt": for MT6582
>  	"mediatek,mt6589-wdt": for MT6589
>  	"mediatek,mt6797-wdt", "mediatek,mt6589-wdt": for MT6797
>  	"mediatek,mt7622-wdt", "mediatek,mt6589-wdt": for MT7622
> -- 
> 2.34.1
> 
> 
