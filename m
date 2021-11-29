Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D64462356
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 22:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhK2VcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 16:32:08 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:46672 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbhK2VaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 16:30:08 -0500
Received: by mail-oi1-f177.google.com with SMTP id s139so37076040oie.13;
        Mon, 29 Nov 2021 13:26:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KAU7+bZHiWEp2yIBieWGgyI8VLCnh42RRI0vBGHa9/4=;
        b=q662PeQkNJD//NGtk6K7VmrnR1ngtFDCnb05wg0VsfUScBfNRzfgM1QLkkUQmkpyPG
         4yGc7a/u3SOq0kRDkI8mCHgfczXport6PMV3mFaYGFV3kxdDJ5RHH7T2b/8bZAHfFQmf
         wA7EUiQw8U7MD1S+6gUdz20MgvHzq3HbLiVPtSEmRAwWlsV4c3s5em3ffDxE1Vq0mOet
         v4I9bkEl6u7yUdGaRRRuTWvY3afGVonBWD6o3m4rL/nVppwrg0tBYIKhS/DYYGFtUp1w
         TDYJ5hlxHEHY+E97deaBEKwLMRfWDI9R57bvTAPhabvew/2Edk10mYOtn6LqNkhthibX
         zXcA==
X-Gm-Message-State: AOAM53145TD24oBmtrRtRH2Ap4KI82YXZqpqT/SavS5jKljxbblgFx3j
        r19wfWq+rPjqveWmGrPQIw==
X-Google-Smtp-Source: ABdhPJzQJ8YAzrRP8aRWzJTSjXg0Uz87YRg+E6Vk7gRhNjh6UYwPLj19H9agfaotDJ+Ni7iW3SCk2g==
X-Received: by 2002:a05:6808:b0d:: with SMTP id s13mr548263oij.53.1638221209579;
        Mon, 29 Nov 2021 13:26:49 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q9sm2829077oti.32.2021.11.29.13.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 13:26:49 -0800 (PST)
Received: (nullmailer pid 638684 invoked by uid 1000);
        Mon, 29 Nov 2021 21:26:48 -0000
Date:   Mon, 29 Nov 2021 15:26:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Sam Ravnborg <sam@ravnborg.org>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: display: simple: Add HannStar
 HSD101PWW2
Message-ID: <YaVFmNji2CR5klCS@robh.at.kernel.org>
References: <20211114200431.28484-1-digetx@gmail.com>
 <20211114200431.28484-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211114200431.28484-2-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Nov 2021 23:04:30 +0300, Dmitry Osipenko wrote:
> From: Svyatoslav Ryhel <clamor95@gmail.com>
> 
> Add HannStar HSD101PWW2 10.1" WXGA (1280x800) TFT-LCD LVDS panel
> to the list of compatibles.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
