Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA744A68B3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 00:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242871AbiBAXok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 18:44:40 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:33642 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiBAXoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 18:44:39 -0500
Received: by mail-oi1-f179.google.com with SMTP id x193so36704723oix.0;
        Tue, 01 Feb 2022 15:44:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xJ5ww5IowYah3vuOkTM8CuTagH4Jd5vAIL+T4NILP4U=;
        b=g380H+4YQ8sp3j/fYvePpI99GGgxYYvSyaG1Gp+pZlakKuyT0Rb0NNKbSVae7wkAwv
         9O3suv/feGBIVSRZHwh8ritwlRu59ZoFaW5uBI4kviFQ9W11pLwopYZgw5vSQQwjX2OS
         WOA28j5/EXd5TY4Eo+Eddw/weOb5vJdZOuujsybSmMg8AeP6Wm0Kv+w0RLsIFaJTmBhe
         4U42N6RMBx/TjSaYQeedgVs9EJ/N/ZxuRlUMBTdbjXc5te2Tf87e4dkJ4x/r8PVRIvl/
         uYExYgpBw7bUVrM/rLbKz39bFhJQTrOdZ4VeR74j5SeRqJxyWFWKGxo5kiPXmznhOdzJ
         mjig==
X-Gm-Message-State: AOAM531A5Mpkf5wJjEtlFnZCh7iIAXSqmjqaO6ZO099xjctyk6CObN/j
        UkyTpohszAiiTJT7q6AWYw==
X-Google-Smtp-Source: ABdhPJze9s7mNLSyDWw1RyySuLSwpCDHLYGjvVviYTYm+PB29dALZWT1UEjiI37xaHSSpMrSmOPzsQ==
X-Received: by 2002:a05:6808:23cc:: with SMTP id bq12mr2761135oib.230.1643759079139;
        Tue, 01 Feb 2022 15:44:39 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g34sm11925438ooi.48.2022.02.01.15.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 15:44:38 -0800 (PST)
Received: (nullmailer pid 989022 invoked by uid 1000);
        Tue, 01 Feb 2022 23:44:37 -0000
Date:   Tue, 1 Feb 2022 17:44:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>, linux-tegra@vger.kernel.org,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Anton Bambura <jenneron@protonmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: sharp,lq101r1sx01: Add compatible
 for LQ101R1SX03
Message-ID: <YfnF5XqvdQ8RpB/O@robh.at.kernel.org>
References: <20220130235945.22746-1-digetx@gmail.com>
 <20220130235945.22746-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220130235945.22746-2-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2022 02:59:43 +0300, Dmitry Osipenko wrote:
> From: Anton Bambura <jenneron@protonmail.com>
> 
> LQ101R1SX03 is compatible with LQ101R1SX01 from software perspective,
> document it. The LQ101R1SX03 is a newer revision of LQ101R1SX01, it has
> minor differences in hardware pins in comparison to the older version.
> The newer version of the panel can be found on Android tablets, like
> ASUS TF701T.
> 
> Signed-off-by: Anton Bambura <jenneron@protonmail.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/display/panel/sharp,lq101r1sx01.yaml          | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
