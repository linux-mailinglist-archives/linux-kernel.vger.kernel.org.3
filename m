Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA7C48BCCB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348101AbiALB7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:59:31 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:42933 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244071AbiALB73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:59:29 -0500
Received: by mail-oi1-f178.google.com with SMTP id y14so1526879oia.9;
        Tue, 11 Jan 2022 17:59:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SY7Nt3LIYS+ee95IOS2lYNehaYFihAIPxIiHoAlBkr0=;
        b=GMheOFW2O67tS0IVR9zAlAeST4u5gr5Sw/EXCDAM8bEGPnugQNnPiCuqiFEYbAKfBC
         rZfw9sB1jDocGjmlY3NhRkdmxjVpQlvMbo465Ki5nKp/ObwFG1F1go6n+I11KGprWUOI
         wBfJ/jGdO+AWXR5l4+AcHzwgztYtTAbGdcHxTcGsiPqLSleXhJiwENzTPw9lcYQMPF/Z
         PCf5eRaanli4iKURkditrMKErM7YsFU+JK3Muba1nREV78V7LpDVB5ocTkfRiVaxkukl
         uD8+iaLivIqCc78bsa0ZtrX0PMocg66iSAU02MQn/qIlPbJ1krHr7VfOEKafoBi4/jBW
         Lgog==
X-Gm-Message-State: AOAM532OsRRgXCmTIOAvfTfqocFj2+dHZh6jzHCkjAjQwoUgxjiFR592
        /HRNTjbTfSbcO7OxpJykbCLwKs/7qA==
X-Google-Smtp-Source: ABdhPJyhji8EPb5FuVMZbGyJHgSzUgoThoUKc/7Ld8ukWHPII1dRpzHjuB3StkNE/TYAj81PwYIOnQ==
X-Received: by 2002:aca:3014:: with SMTP id w20mr2685105oiw.69.1641952768993;
        Tue, 11 Jan 2022 17:59:28 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w19sm406835oiw.29.2022.01.11.17.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 17:59:28 -0800 (PST)
Received: (nullmailer pid 3912227 invoked by uid 1000);
        Wed, 12 Jan 2022 01:59:27 -0000
Date:   Tue, 11 Jan 2022 19:59:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lin Huang <hl@rock-chips.com>,
        Derek Basehore <dbasehore@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH 02/10] dt-bindings: devfreq: rk3399_dmc: Deprecate
 unused/redundant properties
Message-ID: <Yd41/06PvO7DDGlO@robh.at.kernel.org>
References: <20220107235320.965497-1-briannorris@chromium.org>
 <20220107155215.2.I5ba582cd678d34c03d647e5500db8e33b7524d66@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107155215.2.I5ba582cd678d34c03d647e5500db8e33b7524d66@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Jan 2022 15:53:12 -0800, Brian Norris wrote:
> These DRAM configuration properties are all handled in ARM Trusted
> Firmware (and have been since the early days of this SoC), and there are
> no in-tree users of the DMC binding yet. It's better to just defer to
> firmware instead of maintaining this large list of properties.
> 
> There's also some confusion about units: many of these are specified in
> MHz, but the downstream users and driver code are treating them as Hz, I
> believe. Rather than straighten all that out, I just drop them.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> 
>  .../bindings/devfreq/rk3399_dmc.yaml          | 42 +++++++++----------
>  1 file changed, 21 insertions(+), 21 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
