Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A4E4968D4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 01:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiAVAjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 19:39:22 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:37853 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiAVAjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 19:39:15 -0500
Received: by mail-oi1-f172.google.com with SMTP id bf5so15974383oib.4;
        Fri, 21 Jan 2022 16:39:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MYFfRxyC4/E24cPaOBbxiA9I+dxbpUwW+WISu/4l9BY=;
        b=i0qYNupwn5TrHzQjdIgDNkFmQb5tCoKojFwQ+eUOnXEIrwTAhBS3AyWkGilsZ4Up1R
         Wz5GpC9fiFen5/K93/EEBAfAIp6KRtrq4mBRJmrFui2xRlaQkN6nDO7dhQbSiF0Zb99/
         B2aIOt9o/lUDSUZuFJfMXfBSGuYnPgXpZek/lDWvtQE3f4pEQDv9hRdaH+oD/mXUCmsv
         k2d4SBdJw1u1G67bf9gBqTOEGho4k93sGHiaFFWRMoCaJJA0HbSWx2uIH8FRuReQh4GC
         V3enoYLxJhpjMeJAQSiG276EJmiQPoF7QUXnlUIdr6+TwrCPY6h8lkzpl3O02zKo2WKG
         kQVw==
X-Gm-Message-State: AOAM533ZBoDQrmzFP8acC3b+zCiAmZS6YDZaS8yznUkd/l00dHFVcZ9o
        tkFLWZgTOrXWKzLjhQNjTA==
X-Google-Smtp-Source: ABdhPJyITZIGAwa7fWMYPph1L8G2l6rJPXFKTQA03WvWmJwPA1lfLra+7k6DRH04YzXilPiNzgMMRg==
X-Received: by 2002:aca:f241:: with SMTP id q62mr2632353oih.64.1642811954964;
        Fri, 21 Jan 2022 16:39:14 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id y64sm1969847oig.54.2022.01.21.16.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 16:39:14 -0800 (PST)
Received: (nullmailer pid 1926684 invoked by uid 1000);
        Sat, 22 Jan 2022 00:39:13 -0000
Date:   Fri, 21 Jan 2022 18:39:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, mchehab@kernel.org,
        linux-media@vger.kernel.org, laurent.pinchart@ideasonboard.com,
        sakari.ailus@linux.intel.com
Subject: Re: [PATCH v2 2/2] dt-bindings: media: hynix,hi846: add
 link-frequencies description
Message-ID: <YetSMV9CIcIo8yLp@robh.at.kernel.org>
References: <20220111133937.1099917-1-martin.kepplinger@puri.sm>
 <20220111133937.1099917-2-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111133937.1099917-2-martin.kepplinger@puri.sm>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 14:39:37 +0100, Martin Kepplinger wrote:
> link-frequencies is required but only mentioned in the example. Add
> it to the description.
> 
> Fixes: f3ce7200ca18 ("media: dt-bindings: media: document SK Hynix Hi-846 MIPI CSI-2 8M pixel sensor")
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
