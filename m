Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E2F4A68C6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 00:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242980AbiBAXtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 18:49:06 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:43606 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiBAXtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 18:49:04 -0500
Received: by mail-oi1-f178.google.com with SMTP id t199so19938570oie.10;
        Tue, 01 Feb 2022 15:49:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jo2m2mDixIShQQUxCkK1P+1sHxGPYJ+EgazaMUeqSAM=;
        b=poUH0+E9tEaWE6aUrty+8jYPdaXCn/AQ3b/EEkn5rIigepw/nOmB56OtZ1sGfk1PTU
         PEjsjekEGM66UR8Osuyy1oc5tQ/knXRDU2AEVbBdfiBznFJzngGogXPFk1Z0NLzly1vf
         +8wzhNwVaeDbsk1IVTmsiMH9H3pyybxa0mqpeA+5bXFbNJXjr1DfIX/ueWspMcnPkX8P
         jqAZO6q43VUblXd5sEq8HyPLV/baeYBIg7pKGxnTAcvT1EbanLOOFTyQRHadfJTMjYGD
         FTOHK+ti2QslxSgOidIITf2aRPswkmvoa4lY+QtyN/51vXxvnB4SdBtj8W0HXdIu9bp9
         ECSA==
X-Gm-Message-State: AOAM530QxLnF6Zx2jrC6Yb+xwdk7Dr5ueJzPRFhI/R0iRA89DbKRRn5y
        Xt216YJmTgbEZooZEtp6eQ==
X-Google-Smtp-Source: ABdhPJz7iZxzXNX7wyNhOMdRzRTkrf4cKGMZQJfj7fb0fteyV/W1kMAx9bEDfj3D6o//zA58hAxZ2A==
X-Received: by 2002:a05:6808:180f:: with SMTP id bh15mr3030078oib.233.1643759344332;
        Tue, 01 Feb 2022 15:49:04 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j3sm13191444oig.37.2022.02.01.15.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 15:49:03 -0800 (PST)
Received: (nullmailer pid 996340 invoked by uid 1000);
        Tue, 01 Feb 2022 23:49:01 -0000
Date:   Tue, 1 Feb 2022 17:49:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        letux-kernel@openphoenux.org, dri-devel@lists.freedesktop.org,
        Maxime Ripard <maxime@cerno.tech>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sam Ravnborg <sam@ravnborg.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mips@vger.kernel.org, Robert Foss <robert.foss@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Boddie <paul@boddie.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonas Karlman <jonas@kwiboo.se>, devicetree@vger.kernel.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v12 3/9] dt-bindings: display: Add ingenic,jz4780-dw-hdmi
 DT Schema
Message-ID: <YfnG7SnlQyzU3H5l@robh.at.kernel.org>
References: <cover.1643632014.git.hns@goldelico.com>
 <2386420a975e0a6c17393828af776991f3d17c01.1643632014.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2386420a975e0a6c17393828af776991f3d17c01.1643632014.git.hns@goldelico.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2022 13:26:49 +0100, H. Nikolaus Schaller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> 
> Add DT bindings for the hdmi driver for the Ingenic JZ4780 SoC.
> Based on .txt binding from Zubair Lutfullah Kakakhel
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> ---
>  .../display/bridge/ingenic,jz4780-hdmi.yaml   | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
