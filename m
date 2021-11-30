Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55F7463F83
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 21:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343856AbhK3U46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 15:56:58 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:38696 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343841AbhK3U4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 15:56:02 -0500
Received: by mail-oi1-f176.google.com with SMTP id r26so43752287oiw.5;
        Tue, 30 Nov 2021 12:52:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HUcLSElIsAeGXoamfwIJ1+O99xqd8EXTWKheG2PtMsI=;
        b=G5/GgQOp1v3H0NZDQ8ibQdO++Wk+ivHB9uIMJdtG1C71VVjLSC+hsWacc9YoHVttFL
         0gUke/cflHcrKrF5oqPo/XMrnre0TcJE4Ixp4J0cgwIQzcjoWziHAb1DQeFYOsQvky8a
         7KlyRnfDnJwp5r0d4sqWdlG/0hxY6saZ6vi+5PNznyEJQnqg7XnvvGFZc82b+q2frbOT
         HLr+lWdk0CCaFQ9oQlvXelVgn0A8YX8M0G/BtI0F0de1Byd699Nw5oel1SvitX2Sysh3
         szoi1mCpBGGEPDQ4ShosP1jznymU3T3u6Lqx+KBynUZXlLYZ5I0CP9iNq4sH9D2adHjL
         zsTg==
X-Gm-Message-State: AOAM533+UWcLMAnOGzZripxXjuSPbkv8alK4p30wWcP4pTI3q6peFr9Z
        uiq3HyqyKAOCEP0sXxD9D9Zn2r3OrQ==
X-Google-Smtp-Source: ABdhPJxvAFFqVAGIsBInkj4IqrEitMpLpiznMCXhvPCnbDKdUiP0helJColS219E8JOwv29mbrlaqQ==
X-Received: by 2002:a05:6808:1914:: with SMTP id bf20mr1389326oib.149.1638305562114;
        Tue, 30 Nov 2021 12:52:42 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a16sm3305491otj.79.2021.11.30.12.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 12:52:41 -0800 (PST)
Received: (nullmailer pid 2994160 invoked by uid 1000);
        Tue, 30 Nov 2021 20:52:40 -0000
Date:   Tue, 30 Nov 2021 14:52:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hari Nagalla <hnagalla@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org, a-govindraju@ti.com,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        mathieu.poirier@linaro.org, robh+dt@kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: remoteproc: k3-r5f: Update bindings for
 J721S2 SoCs
Message-ID: <YaaPGCfkfBDsWezq@robh.at.kernel.org>
References: <20211122122726.8532-1-hnagalla@ti.com>
 <20211122122726.8532-2-hnagalla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122122726.8532-2-hnagalla@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2021 06:27:23 -0600, Hari Nagalla wrote:
> The TI K3 J721S2 SoCs have three dual-core Arm R5F clusters/subsystems,
> with 2 R5F cores each, one in MCU voltage domain and the other two in
> MAIN voltage domain.
> 
> These clusters are similar to J7200 R5F clusters. Compatible info is
> updated for intuitively matching to the new J721S2 SoCs.
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> ---
>  .../devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml   | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
