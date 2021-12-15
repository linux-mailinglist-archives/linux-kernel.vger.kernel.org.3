Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224CD47631D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbhLOUWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:22:06 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:37463 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235756AbhLOUWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:22:00 -0500
Received: by mail-ot1-f42.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so26285059otg.4;
        Wed, 15 Dec 2021 12:22:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yl4rL89vkkQfkiSLnPZW1gZdBwzv6ThVDS0MODexfww=;
        b=Ku8h4c5/nNCmtRx2MybrgtJpKy+gR/fh2dZS10fn241zP+HI59BKu7QQVobhWaR4zO
         oM9klxpqLkfLlmauv8dvBiRF0fDXdXPJiZfHGh7chWReDNHEyx870XPwcQplDnEoV+oM
         CBPoVlHpJo6dB55q9/2MVlHdyJM5fy3YLLy/2+yaha9lMVnFJvSFfGDPtJtbiTCThkoP
         Ayr8Hljo4Qh1pR1mkhq9ffkRhipwUz9o7JewjWD7El6MdaxRED3XnGkLgLJGm3o77KIp
         8oZxG89wDJr5jnHG5sJN7q/8hmbA6e+gYrDhchykQJ1BMc6KxxXAJGXtKKNLIiGhqIcQ
         UnAg==
X-Gm-Message-State: AOAM5305gYlIXLBnrEOnSbgr6M4jH15ufcLGwY0iIBXF+xUf7BZlSOxS
        Qn58rpzsamBoz0i4qWLbNw==
X-Google-Smtp-Source: ABdhPJxAD+MvRMJzz4Zo3q6S/s9MgZeKC/OTMbJZzQDfyQvMEgsyy2f69GVp1ZXlVMqgAmN9g9agmw==
X-Received: by 2002:a9d:51c3:: with SMTP id d3mr10225774oth.152.1639599719660;
        Wed, 15 Dec 2021 12:21:59 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t3sm623898otk.44.2021.12.15.12.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:21:59 -0800 (PST)
Received: (nullmailer pid 1773069 invoked by uid 1000);
        Wed, 15 Dec 2021 20:21:58 -0000
Date:   Wed, 15 Dec 2021 14:21:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/4] dt-bindings: arm64: dts: mediatek: Add
 mt8183-kukui-jacuzzi-makomo
Message-ID: <YbpOZi7oroStzT3M@robh.at.kernel.org>
References: <20211213162856.235130-1-hsinyi@chromium.org>
 <20211213162856.235130-4-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213162856.235130-4-hsinyi@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Dec 2021 00:28:56 +0800, Hsin-Yi Wang wrote:
> Makomo is known as Lenovo 100e Gen 2 Chromebook.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> v2: Fix enum typo
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
