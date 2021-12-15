Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E4A4762A3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbhLOUIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:08:19 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:36694 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234378AbhLOUIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:08:17 -0500
Received: by mail-oi1-f180.google.com with SMTP id t23so33247560oiw.3;
        Wed, 15 Dec 2021 12:08:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u3j11RT/qGMAm049Yr8/rRLOlSfvZaw3G5HVklqorqY=;
        b=XDkNdvYeLV9MDD135oGejPT8eJmJQ5cUsduMeqztkQeKt9PENxehf9F/zAU5F2zyy6
         WBeypSfafsB89PAB6FntoIVDbYXjDui3Dd4Hur2MMubr/Mhs/J/rC80eUCCM0qgKV7j+
         fwgV0BzlkIu5mO9gDVaytnVPFc3o0odOUwPaYgw7P95F5TGwzwTxHCTnVxT1+/iUcO7Y
         WFd9u8xXtg0XMTdNDsCn9ThYALZ2jmJkRKo/04OilNPoxBMU+Z02IzDdhtpIAQBpxLBl
         gsZ5rJAPMglzQwQkx7MnU2z20miLEkfFqE+tACXXj2CYuxCMpTMdCPjPCdD/s90ZNNa5
         VyaA==
X-Gm-Message-State: AOAM531uae/I4WqDJ+ZyA/j+aXi8Jd2ZUt1yls1yQi3YqUyCFrjMsO8W
        yH++f9iJtsAw/0somjAC0w==
X-Google-Smtp-Source: ABdhPJwyoJk7ijpCXFtcKvcRthzQjcVnIbm1Ct+5q421T/Am6phZm16FScx4GqkNzwnuCUFgjJrT+A==
X-Received: by 2002:a54:4111:: with SMTP id l17mr1350653oic.127.1639598897343;
        Wed, 15 Dec 2021 12:08:17 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v20sm620310otj.27.2021.12.15.12.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:08:16 -0800 (PST)
Received: (nullmailer pid 1751381 invoked by uid 1000);
        Wed, 15 Dec 2021 20:08:15 -0000
Date:   Wed, 15 Dec 2021 14:08:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Romain Perier <romain.perier@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Daniel Palmer <daniel@0x0f.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 4/6] dt-bindings: timer: Add Mstar MSC313e timer
 devicetree bindings documentation
Message-ID: <YbpLLxvgmTg2RKUz@robh.at.kernel.org>
References: <20211212181906.94062-1-romain.perier@gmail.com>
 <20211212181906.94062-5-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211212181906.94062-5-romain.perier@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Dec 2021 19:19:04 +0100, Romain Perier wrote:
> This adds the documentation for the devicetree bindings of the Mstar
> MSC313e timer driver, found from MSC313e SoCs and newer.
> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> ---
>  .../bindings/timer/mstar,msc313e-timer.yaml   | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/mstar,msc313e-timer.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
