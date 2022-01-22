Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D954968D1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 01:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbiAVAiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 19:38:54 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:33344 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiAVAix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 19:38:53 -0500
Received: by mail-ot1-f48.google.com with SMTP id y11-20020a0568302a0b00b0059a54d66106so13912633otu.0;
        Fri, 21 Jan 2022 16:38:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S+3p2SJcrYn8xFmvYiSl/F4mMZLK5YnF3daHv/z1kxU=;
        b=10hyHK7AVKTw3UjoRf7MMqL+x9I2y8mBolIhujWPB4y9UzD4foqEMbi559nsTxGPT7
         hyQaxm8UcC3tLH92hzAUv5RwB9+3H5bTwWn7dxIvbOUbs/SUeLQdNIS3/9XXitwyUN8s
         b/Z8IPbpoEILluCCgYKFMXgVmLjI6VXa0h0KalLpcpIsLWtRSbv/C6HtwrqpZ1bi9U4S
         OPre7I+B+eGBlSCSVkEqTjNvvtApk7GlJlvH5lUU0YODfKtkYilosy6FLqS0UFY/LLRH
         TCCrlTj98QvRaorL7jvyGajDSTbi5n6nW2r/WdKQi6qTKWmaJNpGK68t5mSRrz5Z6Tgy
         D+GA==
X-Gm-Message-State: AOAM533Rlileb43eJy4UwfJ4HHjVxVLk95xaqpsK/F2wEfFeHaCuMBlw
        GTz4elu/aFLKT8JT5tmOG0r3+91h6w==
X-Google-Smtp-Source: ABdhPJzK+wd0MzbZ5Z+M5ZSJ9jYz0Y8qeBMJVaPqjkyqFw7wXCi772Nh2NpnzOHh20oIyEoyK3foQw==
X-Received: by 2002:a9d:4047:: with SMTP id o7mr4857367oti.190.1642811932574;
        Fri, 21 Jan 2022 16:38:52 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u12sm1669893otq.68.2022.01.21.16.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 16:38:52 -0800 (PST)
Received: (nullmailer pid 1925979 invoked by uid 1000);
        Sat, 22 Jan 2022 00:38:50 -0000
Date:   Fri, 21 Jan 2022 18:38:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     devicetree@vger.kernel.org, sakari.ailus@linux.intel.com,
        geert@linux-m68k.org, mchehab@kernel.org,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-binding: media: hynix,hi846: use
 $defs/port-base port description
Message-ID: <YetSGqLmPH1HBQMP@robh.at.kernel.org>
References: <20220111133937.1099917-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111133937.1099917-1-martin.kepplinger@puri.sm>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 14:39:36 +0100, Martin Kepplinger wrote:
> This is supposed to fix "make dt_binding_check":
> 
>     Documentation/devicetree/bindings/media/i2c/hynix,hi846.example.dt.yaml:
> camera@20: port:endpoint: Unevaluated properties are not allowed
> ('link-frequencies', 'data-lanes' were unexpected)
>     From schema: Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml
> 
> Fixes: f3ce7200ca18 ("media: dt-bindings: media: document SK Hynix Hi-846 MIPI CSI-2 8M pixel sensor")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
> 
> 
> revision history
> ----------------
> v2: thank you, Laurent
>  * add unevaluatedProperties: false
> v1:
> https://lore.kernel.org/linux-media/20220110123804.377944-1-martin.kepplinger@puri.sm/
> 
> 
>  Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
