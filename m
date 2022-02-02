Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58D84A6969
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 01:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbiBBAyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 19:54:07 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:41477 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiBBAyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 19:54:06 -0500
Received: by mail-oi1-f180.google.com with SMTP id q186so36812488oih.8;
        Tue, 01 Feb 2022 16:54:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jr3OiPevkuWKw1kfTnZXrjitNLfSQpL7aNzeoMhYRLM=;
        b=WwA0KxbOXKbUdKT8oMy/vdJPdvgaPXdDLyERCS4jb6MqaImh18S5vgbUHM3dM7/Zxi
         Y/OY9mJZSk/OWRlR3SxeijElf2oGmeGhv7pw7kbN/UkNJE1dL+WqG2UmMOW/5GtjN0C9
         xEcqbnozYfqSjxUMoWhwnkbN3tIJklKWZD34S7jWfVRGe1xE+onza3wVdORyPEHlYUpL
         48no8qfrw0+PA9S4SuS/8mAKqoerHNwbEcd8MHrvofwcZcU6KhpiZiqUB1gv7INGmP8F
         UnxCZ2usknc/NCUWcdZ9Jk6/PycTPRILgIHF1S4pZ4BQJ4kUaNsvj9NpuUXVvgt7/Ei/
         tP8g==
X-Gm-Message-State: AOAM531XRaERfj/K5vRlmBf2Q1SCExVKhjk0Akr/PtsovkoVu5R4C8Nz
        m3BQ3iJgjjIMPfPAZSSXOQ==
X-Google-Smtp-Source: ABdhPJxs33mORGQ/nk9kC8PxG13SiBpfZLnh91us3e4V8rtbdnjB8OH17W6d3OSkLbIIpOz/7nFORg==
X-Received: by 2002:a05:6808:e83:: with SMTP id k3mr3129454oil.215.1643763245921;
        Tue, 01 Feb 2022 16:54:05 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v78sm8788349oie.18.2022.02.01.16.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 16:54:04 -0800 (PST)
Received: (nullmailer pid 1093132 invoked by uid 1000);
        Wed, 02 Feb 2022 00:54:03 -0000
Date:   Tue, 1 Feb 2022 18:54:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     devicetree@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        dri-devel@lists.freedesktop.org, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v10 1/6] dt-bindings: mfd: logicvc: Add a compatible with
 the major version only
Message-ID: <YfnWK+rmHCwcJLL/@robh.at.kernel.org>
References: <20220120150024.646714-1-paul.kocialkowski@bootlin.com>
 <20220120150024.646714-2-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120150024.646714-2-paul.kocialkowski@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2022 16:00:19 +0100, Paul Kocialkowski wrote:
> There are lots of different versions of the logicvc block and it
> makes little sense to list them all in compatibles since all versions
> with the same major are found to be register-compatible.
> 
> Introduce a new compatible with the major version only.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  Documentation/devicetree/bindings/mfd/xylon,logicvc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
