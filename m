Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E1346536A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 17:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350943AbhLAQ7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 11:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbhLAQ7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 11:59:01 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9A9C061748
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 08:55:40 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so198841pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 08:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/GEph3CsAnqkBmuszOY71LQEgCEpXd5UoZsLjaKm3Ks=;
        b=SmHa3I5Fj8apyYpqNqZLP9qXj+V+9UyWOsx09t0MWFM3v0NmYuq2RXDHsW7yLUFKQZ
         WL5vH0YTWfXcnHC6QqrLJd5w840dTvYnb+zXBHxLobtoZwRd2wcqkDq610L4pouCV2ey
         ADQwiWzXwknALzIHKNRME5/u1tkTs1rppnx6y0gmxq0TCRG6lLXOGt5MP9Sg3Yn+eSW9
         +dgk9Fj1dX3PZGMFQOIxObSoeplyHvlhDT7PbocrqKsDSOBzxNDIxcQwp7S1Bx1Lkce1
         QBldqPIyJX7fkPQAqXPt+WKVRA7gG8G0BYFmWo3qpDjHKLxK94QKK0cN86DDX49lFjve
         Hy0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/GEph3CsAnqkBmuszOY71LQEgCEpXd5UoZsLjaKm3Ks=;
        b=drbEOm7ba1ZZJEErc9ZBzGjhuRgUadr32E5wVsnBtsqi0LWm1OIPZJhnWCWnaswP2D
         6Trosb69luU4y7ygC/LXkom6Ootl8ozVArrXf8NXQJrEObqNHi6Dy37xBP0KGAoLpBzY
         30QabjlqAjLXxtdoRmegFBoznodFdShnq9FWnY6sibdTsQ3XfJAzLlChcMwlNV+KeFzQ
         ylJ5R9cZZTlXj+AobB7lhNf1yMlZq1fN6hfza7IQPIZyNSFPFef1s3ZTvf27CmHbuiNT
         o6r1wvE9+S02YNE+1s1Cpdn2U4qWANT+AKqJaiLY/r+XE4HeA5gbVisnfgUTSHd0247j
         gT+w==
X-Gm-Message-State: AOAM533s+GYoX1iQJgCjL4B8Re894CK0JRfWtAhU85WqF5a7rfLnHarD
        wRlsfYl3OGmo1/8e+SOQdpEu6g==
X-Google-Smtp-Source: ABdhPJwNmrHtXyiauPc74AkBweAHVvl4gi9KlnzVNKf/U4DRqOx7KtAxJkein27Ecb6gfx6SXhHh3Q==
X-Received: by 2002:a17:90b:4f42:: with SMTP id pj2mr9072875pjb.7.1638377740373;
        Wed, 01 Dec 2021 08:55:40 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id k16sm389735pfu.183.2021.12.01.08.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 08:55:39 -0800 (PST)
Date:   Wed, 1 Dec 2021 09:55:36 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Hari Nagalla <hnagalla@ti.com>
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        a-govindraju@ti.com
Subject: Re: [PATCH 0/4] TI K3 R5F and C71x support on J721S2
Message-ID: <20211201165536.GC834591@p14s>
References: <20211122122726.8532-1-hnagalla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211122122726.8532-1-hnagalla@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 06:27:22AM -0600, Hari Nagalla wrote:
> Hi All,
> 
> The following series enhances the K3 R5F and DSP remoteproc drivers to
> add support for the R5F clusters and C71x DSP on the newer TI K3 J721S2
> SoC family. The J721S2 SoCs have 3 R5FSS clusters, one in MCU voltage
> domain and the other two in MAIN voltage domain. There are also 2 C71x
> DSP subsystems in MAIN voltage domain. The R5FSS is similar to the R5FSS
> in J7200 SoCs, while the C71x DSPs are similar to the C71x DSP on J721e
> SoCs.
> 
> See J721S2 Technical Reference Manual (SPRUJ28 – NOVEMBER 2021)
> for further details: http://www.ti.com/lit/pdf/spruj28
> 
> Regards
> Hari
> 
> Hari Nagalla (4):
>   dt-bindings: remoteproc: k3-r5f: Update bindings for J721S2 SoCs
>   dt-bindings: remoteproc: k3-dsp: Update bindings for J721S2 SoCs
>   remoteproc: k3-dsp: Extend support for C71x DSPs on J721S2 SoCs
>   remoteproc: k3-r5: Extend support for R5F clusters on J721S2 SoCs
> 
>  .../devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml   | 3 +++
>  .../devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml   | 8 +++++---
>  drivers/remoteproc/ti_k3_dsp_remoteproc.c                 | 1 +
>  drivers/remoteproc/ti_k3_r5_remoteproc.c                  | 5 +++--
>  4 files changed, 12 insertions(+), 5 deletions(-)

I have applied this set.

Thanks,
Mathieu

> 
> -- 
> 2.17.1
> 
