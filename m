Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49EAC47491D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236386AbhLNRSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:18:03 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:42834 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbhLNRSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:18:02 -0500
Received: by mail-oi1-f179.google.com with SMTP id n66so28009626oia.9;
        Tue, 14 Dec 2021 09:18:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ayct9matewlj31hKw/1fwRKjPgxYNxdy2wsYaxbrBMo=;
        b=Xgq+VzPJ2Qi4x2uAwAkAK+gHOcWiMFUm37+rgO8N+I65yjCAuMn302ScIWWYlpPBBn
         SudZpv50y7ToYlFSDlMV26Rj3kkIPAYL0+VnEDAKNA7iOjJP7wcq/D+Y4b5wKZ8Rocza
         mlqXoigTVXa4D3HudWt3LhQz093G9PXijB8E9EJrG0ZYUYFbESnD4IedEEb0RO2y8d46
         jSHEFl2YHnwrnowQlS0oQ7fX5f+eVqZWa2HEyOFY8jpsciX4Ot8FyIPLJL/pmUZciV8S
         56sWcPWboZMLDimLOiiL4litkBMm02FTsY7BfyQOPJq0UWrXmwNjHvVLuSy53/FZxC2E
         Tw6g==
X-Gm-Message-State: AOAM532IIxUxO9o/cDASS74mwlAEmMiH07CF2TTWXwe3aOmY2zlzC0Z/
        F4DDwtEy6k8cxsrScdcL2g==
X-Google-Smtp-Source: ABdhPJyELjMM8nn9CLH3h2yYaaTmWnizc9zstZaQdiOpX2udJqTEdqK/NosESkD+PWdS+3k7gqG9+Q==
X-Received: by 2002:aca:eb53:: with SMTP id j80mr5179412oih.85.1639502280368;
        Tue, 14 Dec 2021 09:18:00 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 111sm72937otu.55.2021.12.14.09.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 09:17:59 -0800 (PST)
Received: (nullmailer pid 3574607 invoked by uid 1000);
        Tue, 14 Dec 2021 17:17:58 -0000
Date:   Tue, 14 Dec 2021 11:17:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Gabriel Somlo <gsomlo@gmail.com>
Cc:     geert@linux-m68k.org, linux-mmc@vger.kernel.org, paulus@ozlabs.org,
        shorne@gmail.com, florent@enjoy-digital.fr,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, kgugala@antmicro.com, krakoczy@antmicro.com,
        mholenko@antmicro.com, david.abdurachmanov@sifive.com,
        robh+dt@kernel.org, ulf.hansson@linaro.org,
        mdudek@internships.antmicro.com, joel@jms.id.au
Subject: Re: [PATCH v4 2/3] dt-bindings: mmc: Add bindings for LiteSDCard
Message-ID: <YbjRxsBI+uH+qKvb@robh.at.kernel.org>
References: <20211210145430.3707463-1-gsomlo@gmail.com>
 <20211210145430.3707463-3-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210145430.3707463-3-gsomlo@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2021 09:54:29 -0500, Gabriel Somlo wrote:
> LiteSDCard is a small footprint, configurable SDCard core for FPGA
> based system on chips.
> 
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> 
> New in v4:
>   - fixed `dt_binding_check` errors uncovered by Rob's script
> 
> > New in v3:
> >   - picked up r/b Geert Uytterhoeven <geert@linux-m68k.org> in DT
> >     bindings document (please let me know if that was premature, and
> >     happy to take further review if needed :)
> >   - add dedicated DT property for source clock frequency
> 
>  .../devicetree/bindings/mmc/litex,mmc.yaml    | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/litex,mmc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
