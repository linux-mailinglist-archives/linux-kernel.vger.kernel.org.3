Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFAE547625A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 20:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbhLOT5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 14:57:13 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:38555 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhLOT5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 14:57:11 -0500
Received: by mail-ot1-f42.google.com with SMTP id n104-20020a9d2071000000b005799790cf0bso26274342ota.5;
        Wed, 15 Dec 2021 11:57:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OQHnIq3MbqKOkBWaqzhYEGokXZQ4cO9gcO52HXRgUjM=;
        b=mKpepPtDc+WJGm0k2kIv0T7EV5cAHkezG3mbv0SPUfFnlNd0waNWA5JnIAlbMgmsBD
         0Dy6Vw93RdqOei6OG5jQXNuRKxw9/IfAjQXSa5K9OEC09RLsJ0J+2fldrtLQatNdIWXY
         nIJuPjdZ3fn9cGQ/9Nn8SR+KbM6B8Bf2gXrCJxo7WLL92MXFFJB6KMYjtHnRLuvb5XYw
         KFhHm/wRia+yTOrQJjMV22yKESNSrmGQG+uJy+vyveWStZl9Lk0CLCsOokAlNeh/Kgw0
         +f/kiJPgClbVM3KwGwVmqQFoNWnj3c9AK8MG3xo0yONs650Yjdc94BRYzL7edEHcENGF
         tdlw==
X-Gm-Message-State: AOAM531LcM/1SIpZyHSnTezCtHl0qzmqt90so1LGdUXWKe4LHL0xDtMD
        jj+JgMcEeM+U8rPeWkP68w==
X-Google-Smtp-Source: ABdhPJzxwIsn/cIQGYHuBgMFx+Tg1FD9tkT3hX/+n0dDk8WvLbNnz56ZucAnHQZY6SSnHfzgg0OuTQ==
X-Received: by 2002:a05:6830:1e8f:: with SMTP id n15mr9846388otr.259.1639598231225;
        Wed, 15 Dec 2021 11:57:11 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id ay40sm508165oib.1.2021.12.15.11.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 11:57:10 -0800 (PST)
Received: (nullmailer pid 1734417 invoked by uid 1000);
        Wed, 15 Dec 2021 19:57:09 -0000
Date:   Wed, 15 Dec 2021 13:57:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Anton Bambura <jenneron@protonmail.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 1/3] dt-bindings: sharp,lq101r1sx01: Add compatible
 for LQ101R1SX03
Message-ID: <YbpIldrQUQHh37C9@robh.at.kernel.org>
References: <20211211213653.17700-1-digetx@gmail.com>
 <20211211213653.17700-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211211213653.17700-2-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Dec 2021 00:36:51 +0300, Dmitry Osipenko wrote:
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
