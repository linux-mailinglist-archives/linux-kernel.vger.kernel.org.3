Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF3547D64F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 19:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344518AbhLVSLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 13:11:11 -0500
Received: from mail-qt1-f181.google.com ([209.85.160.181]:40746 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344507AbhLVSLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 13:11:10 -0500
Received: by mail-qt1-f181.google.com with SMTP id l17so2675799qtk.7;
        Wed, 22 Dec 2021 10:11:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Il/qIXEpM0k/r83Hkz4DiWBovhWj2kmv+y71DSrCm8c=;
        b=OwrAUZb5StnHhcO28cBmna5iii7ghZZG+ogdQcsCILcswmI13LLALDrRpWEiFshe7Y
         tYCsPe+Y/KrQxXeFnOe5jV8sEbIghTOA4wQtuxPsn7F+/Mos/ORxqksALw029It3ZFCI
         oNzCYUqBXbLY3Ybg/UFxKw06RUMLTusVRm3wcCDaLuMZAsnrODjiKkOLbBfHZUW2V2En
         QzGA+aagftw+IZxrYvhgVhoAWOeny3xb74rcsUbIDHIVSj9GuZS+I9pgw6d88Ifs7UmZ
         mhB3b7RJj2EBwv2xzzc81vBJVJEmhzLvQ/f1cc+YGiKRFiuNORjmk9HN0Sy/MWzHRX56
         IUEg==
X-Gm-Message-State: AOAM531D8QGLcB5x7UEVS8K/neW5LEntHdmReZyFcTTEapJ5PTwFSeiM
        5Az9QFV2rRbwGulBT7kO/g==
X-Google-Smtp-Source: ABdhPJw47NUTqeOoKpNDgF7NJg6QIbxE7QNiZXBbjqvRNsib5jawU+pweuawJYm1Hu7bbr9h2qzQFA==
X-Received: by 2002:a05:622a:1813:: with SMTP id t19mr2115869qtc.256.1640196669405;
        Wed, 22 Dec 2021 10:11:09 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id g12sm2279193qtk.69.2021.12.22.10.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 10:11:08 -0800 (PST)
Received: (nullmailer pid 2435332 invoked by uid 1000);
        Wed, 22 Dec 2021 18:11:07 -0000
Date:   Wed, 22 Dec 2021 14:11:07 -0400
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        list@opendingux.net, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: clk/ingenic: Add MDMA and BDMA clocks
Message-ID: <YcNqOwjYQT8GTwqD@robh.at.kernel.org>
References: <20211220193319.114974-1-paul@crapouillou.net>
 <20211220193319.114974-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220193319.114974-2-paul@crapouillou.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2021 19:33:18 +0000, Paul Cercueil wrote:
> The Ingenic JZ4760 and JZ4770 both have an extra DMA core named BDMA
> dedicated to the NAND and BCH controller, but which can also do
> memory-to-memory transfers. The JZ4760 additionally has a DMA core named
> MDMA dedicated to memory-to-memory transfers. The programming manual for
> the JZ4770 does have a bit for a MDMA clock, but does not seem to have
> the hardware wired in.
> 
> Add macros for the MDMA and BDMA clocks to the dt-bindings include
> files, so that they can be used within Device Tree files.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     v3: New patch
> 
>  include/dt-bindings/clock/ingenic,jz4760-cgu.h | 2 ++
>  include/dt-bindings/clock/ingenic,jz4770-cgu.h | 1 +
>  2 files changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
