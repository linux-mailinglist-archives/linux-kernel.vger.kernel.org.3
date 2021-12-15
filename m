Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799E54765A0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 23:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhLOW1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 17:27:35 -0500
Received: from mail-oo1-f44.google.com ([209.85.161.44]:46771 "EHLO
        mail-oo1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhLOW1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 17:27:33 -0500
Received: by mail-oo1-f44.google.com with SMTP id p2-20020a4adfc2000000b002c2676904fdso6341743ood.13;
        Wed, 15 Dec 2021 14:27:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=khz6XuxeDKafAUA9AHe6/aR/dP/aRvnjdJRNkKlCqTo=;
        b=ju6DcpU17RC2wsp5NVFWduvbpKcZV4MpkWs7Z/8qSmJothRxu24vzFzFs+vKTYSbHY
         BW528HaU77jwi60LqNY7S+OAWdaNWlvH20z+vcGz/FbJf9IxN22z81e2tfhu/njvUqf/
         pJlQ3qH9P4cTk1tonMcnmWuyetXVYZM7pJ6IfsX6vyQDPPR0Dh/F7rFkEvh3xseproAt
         s4/xZFuvCjItcz9/GjlaXDZN96CUrTT2gPBlxXLa6lQL0XYvUdRLcaReRhwduE/6TcHq
         HIaCOecfGkQtPlAq/f2BBmTWihhBMmWl84CtYoavXLmQmsVc6KYVmnMt84e5FkG4/5ek
         IwtQ==
X-Gm-Message-State: AOAM532Hx+Z1YxtVdux6MuR8UWroUzMoPtLWE8jVj4ZLGXd+xJbSzleo
        Jj2DvYAAikHd/nbHNiu2eg==
X-Google-Smtp-Source: ABdhPJzNVqqhvP0NPVYe+ULeBlpmR/5grGdaEFpeSYXa09aXA387KoadkmV5AG04I5FgiwIo+QcSUA==
X-Received: by 2002:a4a:ab05:: with SMTP id i5mr9069023oon.61.1639607252965;
        Wed, 15 Dec 2021 14:27:32 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bi20sm661315oib.29.2021.12.15.14.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 14:27:32 -0800 (PST)
Received: (nullmailer pid 1954728 invoked by uid 1000);
        Wed, 15 Dec 2021 22:27:28 -0000
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        ~okias/devicetree@lists.sr.ht, devicetree@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        David Airlie <airlied@linux.ie>
In-Reply-To: <20211215152712.72502-1-david@ixit.cz>
References: <20211215152712.72502-1-david@ixit.cz>
Subject: Re: [PATCH] dt-bindings: display: bridge: document Toshiba TC358768 cells and panel node
Date:   Wed, 15 Dec 2021 16:27:28 -0600
Message-Id: <1639607248.090344.1954727.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2021 16:27:12 +0100, David Heidelberg wrote:
> Properties #address-cells and #size-cells are valid.
> The bridge node can also contains panel node.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../bindings/display/bridge/toshiba,tc358768.yaml      | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1568330


tc358778@e: compatible: Additional items are not allowed ('toshiba,tc358768' was unexpected)
	arch/arm/boot/dts/am571x-idk.dt.yaml
	arch/arm/boot/dts/am572x-idk.dt.yaml
	arch/arm/boot/dts/am574x-idk.dt.yaml

tc358778@e: compatible: ['toshiba,tc358778', 'toshiba,tc358768'] is too long
	arch/arm/boot/dts/am571x-idk.dt.yaml
	arch/arm/boot/dts/am572x-idk.dt.yaml
	arch/arm/boot/dts/am574x-idk.dt.yaml

