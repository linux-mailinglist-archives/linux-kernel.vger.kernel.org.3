Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF2E47623C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 20:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbhLOTyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 14:54:18 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:37780 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbhLOTyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 14:54:17 -0500
Received: by mail-oi1-f171.google.com with SMTP id bj13so33202007oib.4;
        Wed, 15 Dec 2021 11:54:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2plnJOcym4cTuu7gThRmo+f5RSKQS/4GGXbtRresTN4=;
        b=1NwX/n+gaTRZ31AAMfjDZxkVacfgVIUyljv9FsvNx6rfRvIQfvqfWfR0moZGkh+5D2
         hcqR0AVmWeSXehlLAhP+FHd0McY41oRCKNHQ2YtljPkGNg8OeWMKihjUiVAHEXvXZcPQ
         V4gx1yGtZr18mk3bw+V25RBoPSo3139h8Wz7QpK1uFbt1zYRSGr9Ev3lUGuSIHAMbk2g
         Rkh/1ZhO26uzYbykmxov5MfqUa6Vj0BfcP7xvmpMWZOl3n+vph5L5dYVhQS+n+ERWOfZ
         6mvo5+nDAMON8+IgGXZLA9yjAK4b7KG+zErP5NlRujOUXS0LkjvEytmWhhCG3kM9TQmh
         QTLA==
X-Gm-Message-State: AOAM532GTDbadNevSRvmL09xdSO0e9cT4fPE0CSPG9CSFr6jFDXmMTId
        zEU/KI4PWeikqZQUnx2DyQ==
X-Google-Smtp-Source: ABdhPJy7/+wyMjgiqWGLDBzXdCJizWBjaEArT/aUu4SEpHUWmxCBuBgP6l+xZaAbui68VjoxM54Gew==
X-Received: by 2002:a05:6808:2016:: with SMTP id q22mr1298112oiw.81.1639598056783;
        Wed, 15 Dec 2021 11:54:16 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t18sm627067ott.2.2021.12.15.11.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 11:54:16 -0800 (PST)
Received: (nullmailer pid 1729945 invoked by uid 1000);
        Wed, 15 Dec 2021 19:54:15 -0000
Date:   Wed, 15 Dec 2021 13:54:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Rob Herring <robh+dt@kernel.org>, james.quinlan@broadcom.com,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] of: unittest: fix warning on PowerPC frame size
 warning
Message-ID: <YbpH51gHmLVeqkez@robh.at.kernel.org>
References: <20211210184636.7273-1-jim2101024@gmail.com>
 <20211210184636.7273-2-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210184636.7273-2-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2021 13:46:35 -0500, Jim Quinlan wrote:
> The struct device variable "dev_bogus" was triggering this warning
> on a PowerPC build:
> 
>     drivers/of/unittest.c: In function 'of_unittest_dma_ranges_one.constprop':
>     [...] >> The frame size of 1424 bytes is larger than 1024 bytes
>              [-Wframe-larger-than=]
> 
> This variable is now dynamically allocated.
> 
> Fixes: e0d072782c734 ("dma-mapping: introduce DMA range map, supplanting dma_pfn_offset")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  drivers/of/unittest.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 

Applied, thanks!
