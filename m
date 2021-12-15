Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3B847630F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbhLOUUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:20:22 -0500
Received: from mail-oo1-f48.google.com ([209.85.161.48]:35385 "EHLO
        mail-oo1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbhLOUUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:20:21 -0500
Received: by mail-oo1-f48.google.com with SMTP id e17-20020a4a8291000000b002c5ee0645e7so6261031oog.2;
        Wed, 15 Dec 2021 12:20:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m/MkamMJ2gnp9jj0ba2joAFe3nG5g9Koxv3aRFuFEjQ=;
        b=ol4bEbLBKwkHkUAOczEfyPYPXpIz+ZbOE2y3fgrGQXg7ybbqoMqmfzR7CBxGADNq1C
         EYZQvAXHww56/ImHqbRjJ7KcsDF0ZtDU0JiVoBsDXVox5Q2qxETqrXFzKoZLJLX4QyCY
         qNORivWrz8nFJ8WCYVqaw5fVFOx24/gra6w3iIq75t1dwRViTyPopd3NKK/gjnwkEafc
         BnuGSDTz20MGz0HZjM7jzyZ6BpXeyMxHpderFVI0IlURxDZjGeCyh87iDvtwJDdv3XB7
         1VW/2xSJXYtCbyriLnLMRltO8HjhI7EwpzEQmonKRBuxdg3BEflXK1g2ayU0bqWjQYU0
         0iBw==
X-Gm-Message-State: AOAM531yan6/9UKv9bcV47hC5kFK4URLjV1cCSrClyDXl3knUehwETQ4
        g6VdBblwrswGOLg+u4hZww==
X-Google-Smtp-Source: ABdhPJwEAvzXsXtw8f6DVigz6LL33eng2DJNCj7/ufeI5f5gYGpPYXHdH5ttSoHheEIv1aVgILb6bA==
X-Received: by 2002:a4a:e288:: with SMTP id k8mr8644935oot.23.1639599621165;
        Wed, 15 Dec 2021 12:20:21 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r3sm601243oti.51.2021.12.15.12.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:20:20 -0800 (PST)
Received: (nullmailer pid 1770384 invoked by uid 1000);
        Wed, 15 Dec 2021 20:20:19 -0000
Date:   Wed, 15 Dec 2021 14:20:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, obayerd@eurocomposant.fr,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        ~postmarketos/upstreaming@lists.sr.ht, tiwai@suse.com,
        broonie@kernel.org, stephan@gerhold.net, robh+dt@kernel.org
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: codecs: Add bindings for ak4375
Message-ID: <YbpOA4Y18lCiIAn9@robh.at.kernel.org>
References: <20211213155914.2558902-1-vincent.knecht@mailoo.org>
 <20211213155914.2558902-3-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213155914.2558902-3-vincent.knecht@mailoo.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 16:59:13 +0100, Vincent Knecht wrote:
> AK4375 is an audio DAC with headphones amplifier controlled via I2C.
> Add simple device tree bindings that describe how to set it up.
> 
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> ---
>  .../devicetree/bindings/sound/ak4375.yaml     | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/ak4375.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
