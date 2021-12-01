Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677F9465A08
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 00:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353892AbhLAXyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 18:54:24 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:42649 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353910AbhLAXyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 18:54:20 -0500
Received: by mail-ot1-f45.google.com with SMTP id 47-20020a9d0332000000b005798ac20d72so37535749otv.9;
        Wed, 01 Dec 2021 15:50:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=janDAtSPhWlePGFNQ++EVF7JDjqdKemONodqemusei8=;
        b=gzz3QZnAZ4YCGaLdJZIpZfpD2muanEz5DsbMltVuohKv9U8PHO9MDa1XlITAkN2oC0
         qApf0sbjIitK40xz26R9FdkDlEufV6U6TErwDVej/aQHcVtBbEH8vNUogLrf9FuF+u/S
         6GxJBBDB4ruVmYhOWHiyeLBcIqSkl/CGgDLyBLuNCwNMPt5zFU0AOsLOSnEm0TxRsutY
         Kr/UViC+s40KY2mpk7M5JA5p/NAP3rYvOnCLZ6v5dIAGtNvC1F/fmp5kIFKnjqX+yKyU
         1eGJE+3dZCFM5Zd4DOojWy4nyk8o5zfQ5vqTcCDx+iRS6gDL+7zJ1Y/mSCk/QDNcbvUH
         oHmA==
X-Gm-Message-State: AOAM532/Jcb5E66UxzJ4S0s/iHP7Dby/MliLK7FMkKF1XhiGRxkMMxSB
        TQFJ9daj/MzKCoNY4hD0ag==
X-Google-Smtp-Source: ABdhPJx5TFH68EuJ9T0gpn/g1grXRTeXYFnflCit2PV7CCMx8U7wAVQns9O50JdQkJLNhGx8FpK1Rg==
X-Received: by 2002:a9d:868:: with SMTP id 95mr8732322oty.211.1638402658107;
        Wed, 01 Dec 2021 15:50:58 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e28sm624819oiy.10.2021.12.01.15.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 15:50:57 -0800 (PST)
Received: (nullmailer pid 3243259 invoked by uid 1000);
        Wed, 01 Dec 2021 23:50:56 -0000
Date:   Wed, 1 Dec 2021 17:50:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Agneli <poczt@protonmail.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, dri-devel@lists.freedesktop.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 04/20] dt-bindings: host1x: Document optional HDMI
 sound-dai-cells
Message-ID: <YagKYCbHw5BHAcdI@robh.at.kernel.org>
References: <20211126161807.15776-1-digetx@gmail.com>
 <20211126161807.15776-5-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126161807.15776-5-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Nov 2021 19:17:51 +0300, Dmitry Osipenko wrote:
> Document new optional sound-dai-cells property of HDMI node. This node will
> be used as endpoint of HDMI sound DAI graph.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt  | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
