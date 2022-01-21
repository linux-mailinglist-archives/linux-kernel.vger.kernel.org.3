Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C6D496846
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 00:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiAUXfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 18:35:20 -0500
Received: from mail-oo1-f41.google.com ([209.85.161.41]:44700 "EHLO
        mail-oo1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiAUXfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 18:35:18 -0500
Received: by mail-oo1-f41.google.com with SMTP id b15-20020a4a878f000000b002dccc412166so3770130ooi.11;
        Fri, 21 Jan 2022 15:35:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lKHiq2AsZWPinKuXt6G3c62yHGQDekscNMsLmGJgK2k=;
        b=AtqxYWVANnIHZb4p3i9+vjBNz5bY0bQ/5I8g4W4FO/oazBnjb49bD1sg0ESo10Cznl
         q2DnT0Amy8I1XC2nbY+cf1CJKOKHlwdRpqbzgE82NYV/EDZb9BOPyXrKOj3lUIiDA/Xh
         FR5P8/piXxBa+Qn+GIljcTvk4FUv8LWVwpEOo2gznJ0MUUh0OvJ7kHxCaiCddjRDfsQp
         dGNSVQLuwNTG2D6NSQBWX5snF5qtMuC0xRBB/qUSs30mjAkWPt328rtAbMcKTv5ZMCCu
         3iJlg8tXpAnZdWMq2i5lbp8Jw8UpwhPhmeSV4KOxiBoKLE55z9rSMSpkdxGgIbLTWIqq
         s4Zg==
X-Gm-Message-State: AOAM532pJCob/Qi7+w7CeKBNi+D85vdDl4D6lz7797ow6+dARJFJJvCk
        ns4vidIq1nej+ADkEX5bAA==
X-Google-Smtp-Source: ABdhPJyV292K3EFqdUiuUDNzx8/jE1xrtTcg1jtIEpo3bwTOmFomBtGk7ogEx3SZ6y8XVzqgHm9JTA==
X-Received: by 2002:a05:6820:151b:: with SMTP id ay27mr4069888oob.47.1642808118263;
        Fri, 21 Jan 2022 15:35:18 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w13sm2213974oik.52.2022.01.21.15.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 15:35:17 -0800 (PST)
Received: (nullmailer pid 1823399 invoked by uid 1000);
        Fri, 21 Jan 2022 23:35:16 -0000
Date:   Fri, 21 Jan 2022 17:35:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [v2 2/3] dt-bindings: ARM: Mediatek: Remove vppsys in MT8195
 clock document
Message-ID: <YetDNPs8Xo/Alndj@robh.at.kernel.org>
References: <20220110005902.27148-1-chun-jie.chen@mediatek.com>
 <20220110005902.27148-3-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110005902.27148-3-chun-jie.chen@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 08:59:01AM +0800, Chun-Jie Chen wrote:
> vppsys0 and vppsys1 sub-system are both integrated with mmsys driver,
> should be describe in mediatek,mmsys.yaml

Driver partitioning is not a reason to change the DT. This needs a 
better description answering why you are doing this and what are the 
implications (is this breaking the ABI?).

> 
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  .../arm/mediatek/mediatek,mt8195-clock.yaml      | 16 ----------------
>  1 file changed, 16 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
> index 17fcbb45d121..d62d60181147 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
> @@ -28,11 +28,9 @@ properties:
>            - mediatek,mt8195-imp_iic_wrap_s
>            - mediatek,mt8195-imp_iic_wrap_w
>            - mediatek,mt8195-mfgcfg
> -          - mediatek,mt8195-vppsys0
>            - mediatek,mt8195-wpesys
>            - mediatek,mt8195-wpesys_vpp0
>            - mediatek,mt8195-wpesys_vpp1
> -          - mediatek,mt8195-vppsys1
>            - mediatek,mt8195-imgsys
>            - mediatek,mt8195-imgsys1_dip_top
>            - mediatek,mt8195-imgsys1_dip_nr
> @@ -92,13 +90,6 @@ examples:
>          #clock-cells = <1>;
>      };
>  
> -  - |
> -    vppsys0: clock-controller@14000000 {
> -        compatible = "mediatek,mt8195-vppsys0";
> -        reg = <0x14000000 0x1000>;
> -        #clock-cells = <1>;
> -    };
> -
>    - |
>      wpesys: clock-controller@14e00000 {
>          compatible = "mediatek,mt8195-wpesys";
> @@ -120,13 +111,6 @@ examples:
>          #clock-cells = <1>;
>      };
>  
> -  - |
> -    vppsys1: clock-controller@14f00000 {
> -        compatible = "mediatek,mt8195-vppsys1";
> -        reg = <0x14f00000 0x1000>;
> -        #clock-cells = <1>;
> -    };
> -
>    - |
>      imgsys: clock-controller@15000000 {
>          compatible = "mediatek,mt8195-imgsys";
> -- 
> 2.18.0
> 
> 
