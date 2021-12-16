Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5B5477D78
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 21:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbhLPUYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 15:24:39 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:37710 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbhLPUYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 15:24:38 -0500
Received: by mail-oi1-f180.google.com with SMTP id bj13so568159oib.4;
        Thu, 16 Dec 2021 12:24:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PzvkC0Po42owudoby5TSMRFqE/FS5zLvt8klw/6yACQ=;
        b=S6QvAspGEhuvVhv09vu2C1H5h+Q9WrajpGvwKcuW8DUrqzM29AWI38Jud14N111Ssa
         Hb+zZ4VzwSQbKdOd4FVSsQgAcO+EhceAdqJ3qmz8nljS/4QeUJ0Gh06WNQbFvfb4+7dH
         hgIOyyxzut7sOfuLnsjd5urVfO2sTcsaDXZxRti32L1OYtfjdU5QlhFxmhldre1DyvT7
         loijN/OsmIifYo/GP+U6khqzx/LxnwwtnZrJbZFEpYNSfPKq8/Nw5YgcxxPxccBBngrR
         u7oTlmsAzMySOmfA2wL8sanrHzA6WfI7616eP82wAoW+uKoPGPQ8/1lVr9k1JAi0jW13
         TxfA==
X-Gm-Message-State: AOAM531anR/bJPJtr8gV5fi9L+BgXmbZyYsEDq8pSlttEz1DHsFngUbm
        c3pgWbhVofQkV78CO0vWng==
X-Google-Smtp-Source: ABdhPJxbssctLOvJE0B8DrTAMUs/5zMmle5yxNWZTgjecNeH73K6L15p0WCSIeJGmTIFChqeOFJtvQ==
X-Received: by 2002:a05:6808:10d0:: with SMTP id s16mr5727012ois.0.1639686277768;
        Thu, 16 Dec 2021 12:24:37 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g5sm1290060ooe.15.2021.12.16.12.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 12:24:37 -0800 (PST)
Received: (nullmailer pid 695398 invoked by uid 1000);
        Thu, 16 Dec 2021 20:24:35 -0000
Date:   Thu, 16 Dec 2021 14:24:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        linux-samsung-soc@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>,
        Hao Fang <fanghao11@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 3/7] dt-bindings: Add vendor prefix for WinLink
Message-ID: <Ybugg8DdQGaXYSL/@robh.at.kernel.org>
References: <20211215160906.17451-1-semen.protsenko@linaro.org>
 <20211215160906.17451-4-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215160906.17451-4-semen.protsenko@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2021 18:09:02 +0200, Sam Protsenko wrote:
> WinLink Co., Ltd is a hardware design and manufacturing company based in
> South Korea. Official web-site: [1].
> 
> [1] http://win-link.net/
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
