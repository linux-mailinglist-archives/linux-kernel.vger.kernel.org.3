Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D73477DEF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 21:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbhLPUyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 15:54:49 -0500
Received: from mail-oo1-f54.google.com ([209.85.161.54]:39788 "EHLO
        mail-oo1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbhLPUys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 15:54:48 -0500
Received: by mail-oo1-f54.google.com with SMTP id d1-20020a4a3c01000000b002c2612c8e1eso101987ooa.6;
        Thu, 16 Dec 2021 12:54:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VWduBd8yA7MLyN55DR2no8XAq3/YF5372wZf2EIcheY=;
        b=dDRqHQjVXluGlTymwYuS9bAZuoYdiSv0hn6QtMUcgt0cyHujdvHNe1EpnXCld7kobm
         500Km0EcbgRFryCeptz4pVoSk5i5gy8j7F88ozZfWKNJgFAQD27zt14uAocbpuTx0CEv
         bIPsKXUFGpueMVIZHC5Wwyvd68a4AuRa8YFFuldGBdsKGDwNRM8U8+zQ7NHYAKjMaa7X
         Y/gx/WHh6AMy9tQp3Rmezl89f6B8P5lTfWAiWKRLM/PMnE9l65L61mc5zdmpTNMfr73e
         ATrn2nsXDSYs+4sxM4Gzi+l585V9jF3Yr0QS67ar9Tfgb28roQ+LCVyQfBYQp2veRzrz
         h2/Q==
X-Gm-Message-State: AOAM532CZDj0MffXWRjpWFMHwIzQGLmGv7P8XeIiEezwKrD033QUcjYE
        VYeo69YUAED4Jl67ux3ghA==
X-Google-Smtp-Source: ABdhPJz6fVKw+I2jh8d/EGJsE4fSw1oN8qgYxuQWF1q7N6WqH3BbPHcxPnoj4qD8rq/124BLkx90cw==
X-Received: by 2002:a4a:cb83:: with SMTP id y3mr12487646ooq.56.1639688087516;
        Thu, 16 Dec 2021 12:54:47 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k12sm1216115ots.77.2021.12.16.12.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 12:54:46 -0800 (PST)
Received: (nullmailer pid 738874 invoked by uid 1000);
        Thu, 16 Dec 2021 20:54:46 -0000
Date:   Thu, 16 Dec 2021 14:54:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        romain.perier@gmail.com
Subject: Re: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add prefix for Miyoo
Message-ID: <YbunloPXw7qoxArZ@robh.at.kernel.org>
References: <20211216105246.3548133-1-daniel@0x0f.com>
 <20211216105246.3548133-2-daniel@0x0f.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216105246.3548133-2-daniel@0x0f.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021 19:52:44 +0900, Daniel Palmer wrote:
> Add a prefix for "miyoo". The only details I can find about
> the company is their aliexpress store "miyoo global store":
> https://www.aliexpress.com/store/912663639
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
