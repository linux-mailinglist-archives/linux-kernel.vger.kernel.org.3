Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C654628F0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 01:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbhK3AQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 19:16:55 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:46971 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbhK3AQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 19:16:54 -0500
Received: by mail-oi1-f180.google.com with SMTP id s139so37777927oie.13;
        Mon, 29 Nov 2021 16:13:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KlFBaDUQvBC7idYOc9PZNT3a+FeBC6sJuD3iTPCVn3Y=;
        b=NyblGY6IwSKFpIgGgwmD5JB7ULxJahZNqM4sanZiXHP+H7DsTaIu+wYrlieuYsNG8a
         gOOLSJgA72I9cdNBjbN/Jl4scoj9lNufTkvMyDRunehrbQni/geFc2LXfKDqRLYeiz1O
         NV8KWWSF9b/a0iUwpQKpQF72VyZc6PypxQJ0ESiL5afcpDwmjmqF2Bacjpb+0OoacmwW
         Xlz+6nreYPnNkLwB8KIiUDCBkumhY7fSTXEXGktzojg7E6i6MkBQ4Hy4qKOXU6qPUrsT
         wPUKOsbEcvcIMcLlcW5pTBmIoCnmmy5AcwjT8IV74KmvgLLDtk7UJF2FnZrIdY5aWAln
         7frw==
X-Gm-Message-State: AOAM531FXFTqjQahfWKEmhyhJ0nSDf8gDMCd9vwtGS5h1GiI+e++pBom
        cBBjQC6l+sDIDfCbnOTRtYBqHeoHiwta
X-Google-Smtp-Source: ABdhPJzpMYpcMnNVQpuoUdC/IdBumWs09W2pdsWZQivjdkh5CkU2iXrGzi04O3b5mAqOnVozt8qSNw==
X-Received: by 2002:aca:62c1:: with SMTP id w184mr1156938oib.159.1638231215853;
        Mon, 29 Nov 2021 16:13:35 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w29sm2652871ooe.25.2021.11.29.16.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 16:13:35 -0800 (PST)
Received: (nullmailer pid 872529 invoked by uid 1000);
        Tue, 30 Nov 2021 00:13:34 -0000
Date:   Mon, 29 Nov 2021 18:13:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Peter Rosin <peda@axentia.se>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: ti-serdes-mux: Add defines for J721S2 SoC
Message-ID: <YaVsrhzuJfqfkuTL@robh.at.kernel.org>
References: <20211119133437.19304-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119133437.19304-1-a-govindraju@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Nov 2021 19:04:37 +0530, Aswath Govindraju wrote:
> There are 4 lanes in the single instance of J721S2 SERDES. Each SERDES
> lane mux can select upto 4 different IPs. Define all the possible
> functions.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  include/dt-bindings/mux/ti-serdes.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
