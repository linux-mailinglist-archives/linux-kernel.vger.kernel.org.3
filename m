Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096D64762A5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbhLOUId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:08:33 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:36566 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234378AbhLOUIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:08:31 -0500
Received: by mail-ot1-f49.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so26309508otl.3;
        Wed, 15 Dec 2021 12:08:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8fYA1Lh38/WtqP2VbO7QAawqRgbA2M/ZaUNoa7bm4S8=;
        b=JSOgeWTbZNwxf35H6yC+ukb9zs/tmEsETdacLdgXz9w23f4H8OWSBcxIcyDIQozlsH
         GIwuA3KgxlpPQl+HSMtEhwvMPwNdDArtSv9Q1sOVo52ZpIpkqV56a4Dt9/ozS/k1Uqv4
         T61FekXKaYiAhp+L+LhWIYu6dH71cZ4CxGNmmQ9OR/jw/rXCLrSE8ft8wd3s3ZmReYpa
         yjY2jcZBkaD+FNb9dYXG+eilQJbLeNVHpFgeJKO1WS+m9A2EimEXl8gCNrPiTSLcKS/D
         450rlqqTLrGCNwTG227K1tLaVZF/a8uKKlk+iZ+Gqr/hUyipJalbRYYsNA/bcXlPUQJJ
         yyow==
X-Gm-Message-State: AOAM531eBf5F/40UnFpQbTEi9lptPsGOl+G8lVH84iCU6kezAI81/sGT
        faMF+yZGOnakLZLaDiwEEw==
X-Google-Smtp-Source: ABdhPJxu2+JZYL10Nng91GC/KkeqIeZYh6QkukuE9k+tvIFOEQ0EQb15j4uGRfHz78Zbk1XpAG0+JQ==
X-Received: by 2002:a05:6830:2681:: with SMTP id l1mr10022636otu.378.1639598911231;
        Wed, 15 Dec 2021 12:08:31 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x13sm618790oof.19.2021.12.15.12.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:08:30 -0800 (PST)
Received: (nullmailer pid 1751820 invoked by uid 1000);
        Wed, 15 Dec 2021 20:08:29 -0000
Date:   Wed, 15 Dec 2021 14:08:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     frowand.list@gmail.com
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/1] of: unittest: 64 bit dma address test requires arch
 support
Message-ID: <YbpLPfn0VuL3fiRL@robh.at.kernel.org>
References: <20211212221852.233295-1-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211212221852.233295-1-frowand.list@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Dec 2021 16:18:52 -0600, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> If an architecture does not support 64 bit dma addresses then testing
> for an expected dma address >= 0x100000000 will fail.
> 
> Fixes: e0d072782c73 ("dma-mapping: introduce DMA range map, supplanting dma_pfn_offset")
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>  drivers/of/unittest.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Applied, thanks!
