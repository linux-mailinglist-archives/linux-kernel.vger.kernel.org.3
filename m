Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB83246C6B0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241850AbhLGV26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:28:58 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:46855 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbhLGV25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:28:57 -0500
Received: by mail-ot1-f42.google.com with SMTP id x3-20020a05683000c300b0057a5318c517so525797oto.13;
        Tue, 07 Dec 2021 13:25:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lYGb/0Umx7vlgzgCMR19+gfp3X/V8dsI0FA1sevnxo4=;
        b=JTjIzB1HP3JJ+wQoHxdb8dSH9lsurHelZXu2/n3Xcg8Eb6J7+asVl78YmdcCEjUoWZ
         hLhbz88M20XuoAsEjQ6yiCcHfbv8cButiHf2z8223aZGCPs/d+meaCbQaUm8W3DH/py7
         dCsqH+KbnElhzxEtIavdGeVY4ht4e4UOLkDpBS0gBt2DfQEzSuzULFue69aUcg+jc8bD
         lx+0j8sPboyqCmEsSUbQI4DoC/+bG94/OmVxsFmLVtY6LXkC5mW+BQKsAKYh2avclfgY
         HFd3HGlpVPGsx8OgsIle1JD+/5lY3sBk5onm4OCC2r9rIQt1ARVjRJbtUdaWhbtlAPlh
         btNw==
X-Gm-Message-State: AOAM533xoi9ThFwiGYq70EOcP17/o3usff2SOHSufnOhvAukCXua2zmy
        Tls/P8Qb8Zmst5GNTX99nDfRqkwrJg==
X-Google-Smtp-Source: ABdhPJzeKG8WH1yZ25noRLZK2kMjvuFPcDWffuT2TjGzr2SWDhQgJT6pD+DWJYou5tFl+W08wF9BPQ==
X-Received: by 2002:a05:6830:310f:: with SMTP id b15mr37384321ots.31.1638912326238;
        Tue, 07 Dec 2021 13:25:26 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id h6sm136583otb.60.2021.12.07.13.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 13:25:25 -0800 (PST)
Received: (nullmailer pid 859562 invoked by uid 1000);
        Tue, 07 Dec 2021 21:25:24 -0000
Date:   Tue, 7 Dec 2021 15:25:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     reinhold.mueller@emtrion.com
Cc:     alexandre.torgue@foss.st.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm/stm32: Add emtrion hardware
 emSBC-Argon
Message-ID: <Ya/RRFKQ35shFCzg@robh.at.kernel.org>
References: <20211130081654.119028-1-reinhold.mueller@emtrion.com>
 <20211130081654.119028-2-reinhold.mueller@emtrion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130081654.119028-2-reinhold.mueller@emtrion.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 09:16:53AM +0100, reinhold.mueller@emtrion.com wrote:
> From: Reinhold Mueller <reinhold.mueller@emtrion.com>
> 
> This patch presents the yaml patch for the emtrion GmbH
> Argon board series.
> 
> Signed-off-by: Reinhold Mueller <reinhold.mueller@emtrion.com>
> ---
>  Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> index bcaf7be3ab37..710230847dcd 100644
> --- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> +++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> @@ -28,6 +28,14 @@ properties:
>            - enum:
>                - st,stm32mp153
>                - st,stm32mp157
> +
> +      - description: emtrion STM32MP1 Argon based Boards
> +        items:
> +          - enum:
> +              - emtrion,stm32mp157c-emsbc-argon
> +          - enum:
> +              - emtrion,stm32mp157c-emstamp-argon

Is there going to be multiple entries here? If not, use 'const' instead 
of 'enum'.

> +          - const: st,stm32mp157
>        - items:
>            - enum:
>                - st,stm32f429i-disco
> -- 
> 2.20.1
> 
> 
