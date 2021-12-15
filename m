Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A6C4762D3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbhLOULo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:11:44 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:41495 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbhLOULm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:11:42 -0500
Received: by mail-oi1-f172.google.com with SMTP id u74so33202683oie.8;
        Wed, 15 Dec 2021 12:11:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cmkh2Es9i+8G9hTWcV5pi5vTt+BeIBoGLAmd/MNJvhA=;
        b=rHlH7992kDmAW+WsyErx+09JpmdGdhepl53qn+WtU4mA1yb4dpdSl0S4dE9ZWAUsvX
         vP6kM7YCwKed/OM7fpo44/YtFTOcxbctopFuGAu2xx/5d9b+IbFbPpQW1T6uzHUkjKKE
         dGLjticDX0O1Ce9ph0qLB42j3v6LAxoR6OHV/NU8AUze1C8wYPPW2ZFuNWkCBx4SEn5l
         /OTdpCFTrosuNUfPDZ5jWh9+d9+mWc0hOYpN22ZPFNtjVvTp8aAH27WGvdkD4K0JZHZK
         hxk/jCCpXMl3dFxgIkNxy1qwl6L8w1QEpJb/rRPOuxpAZpkB4wMkrVw2b8+LipaWxpvM
         8A6Q==
X-Gm-Message-State: AOAM531fJz+/aIP1V43B/Fu8PNFbDEjHY/Qy6cYcbmVF2bgcIGZr0iFP
        WBugT9Z6TocRsfji9lpnPQ==
X-Google-Smtp-Source: ABdhPJyM1ZMlrf4TO+CVAER9wA5DaXo2npuenGcEbYZYr9u3fHtpFP4yfaVSSVT0qgkXzTvNNTxF8g==
X-Received: by 2002:aca:1c02:: with SMTP id c2mr1417576oic.53.1639599102086;
        Wed, 15 Dec 2021 12:11:42 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id b22sm514322oib.41.2021.12.15.12.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:11:41 -0800 (PST)
Received: (nullmailer pid 1756808 invoked by uid 1000);
        Wed, 15 Dec 2021 20:11:40 -0000
Date:   Wed, 15 Dec 2021 14:11:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        phone-devel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] dt-bindings: simple-framebuffer: allow standalone
 compatible
Message-ID: <YbpL/MG0xZyVD01B@robh.at.kernel.org>
References: <20211213082614.22651-1-luca.weiss@fairphone.com>
 <20211213082614.22651-10-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213082614.22651-10-luca.weiss@fairphone.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 09:26:10 +0100, Luca Weiss wrote:
> Qualcomm platforms use "simple-framebuffer" without a more specific
> compatible. Allow that in the binding doc.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  .../bindings/display/simple-framebuffer.yaml         | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
