Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6978D4AA5B9
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 03:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378974AbiBEC1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 21:27:20 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:38444 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236832AbiBEC1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 21:27:19 -0500
Received: by mail-oi1-f176.google.com with SMTP id u13so10669412oie.5;
        Fri, 04 Feb 2022 18:27:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WNwkkIEk6nRKmulDkMvX+n5bN8drj3YdUVmvLLda57E=;
        b=wqQ66cCrpHX1+wyzAr4xNwIL4otXiCpinjhNKTTlU46KW6ERDZ9pr8x8rdJSdLTkpC
         RMATWx/yeVsSk2UA4ciFTiu+EnAjMKiqG24xcQRl3oxOVuvQhj1rdEH2JUU1BX105a9U
         2TtXPKJugBhi+hSHW1OI6o7V3TnuDodadSPdJ+pN/8LhFoO3vf7gatUTynx/LLoXNYFQ
         o6mClm591o8XdELmbmq0CPZGx3kwBE3sm1J2H8TWfoUfWg0AiYRPTowCpW/7dVnVIzTb
         q15MNmSik54Ql8nPOcgYafPiSSI8rpMEUiVJdV+9xplJ8OYlJASuqMmG40Kx0PnY9Q7H
         XRQw==
X-Gm-Message-State: AOAM533FvzWn6BwtCPtsI9W+7ey+LnDOYyxLn2BZKl0DUaOXgtK4tHz1
        ht+4oEtOULByOpkqwJc5jz6EEXK4rQ==
X-Google-Smtp-Source: ABdhPJy16m5SteHRuJQ3WB7ERG1gtj3NB/98hs8UODPsf0AwmR0N+op2pmHZdgA0H1jo4Ijf6X2org==
X-Received: by 2002:a05:6808:e87:: with SMTP id k7mr2729190oil.34.1644028038744;
        Fri, 04 Feb 2022 18:27:18 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x22sm1377230ooq.27.2022.02.04.18.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 18:27:18 -0800 (PST)
Received: (nullmailer pid 3637443 invoked by uid 1000);
        Sat, 05 Feb 2022 02:27:17 -0000
Date:   Fri, 4 Feb 2022 20:27:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        qwen@analogixsemi.com, linux-usb@vger.kernel.org,
        bliang@analogixsemi.com, jli@analogixsemi.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: usb: Add analogix anx7411 PD binding
Message-ID: <Yf3ghczy+I2ZMcvt@robh.at.kernel.org>
References: <20220121061856.2038958-1-xji@analogixsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121061856.2038958-1-xji@analogixsemi.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jan 2022 14:18:55 +0800, Xin Ji wrote:
> Add analogix PD chip anx7411 device binding
> 
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  .../bindings/usb/analogix,anx7411.yaml        | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
