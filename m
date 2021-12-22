Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE0947D717
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 19:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344871AbhLVSo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 13:44:26 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]:39668 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344858AbhLVSo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 13:44:26 -0500
Received: by mail-qk1-f172.google.com with SMTP id 69so3207009qkd.6;
        Wed, 22 Dec 2021 10:44:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bPspzDuKNB8kofhblEkihV/6ql1mbXnTcOAH4jQ9jqI=;
        b=FIaCc253WwVsTede94TDF0o24xDW2xtq0ObdfZqkyI+y5QKPlmUgRLHOF31GebHDy5
         RyyYXPZKVSlNNbSEnkOk0LDwZXNGcYa0/HBLh3Ty/3OEG58GL6m7llJW8isUIveyrhzC
         LhwETay2GoNXLP0Fk7K8wLD1ZPQsNNnH7hPHKLqGRdTE7aeo19dDW7mEs1QUfzfR3NFG
         EGTfDRkdA2ft3kEdl9itbEVMb0HbN7F+YD7g42XyIitIq2y+1bG4ys5YoLD8uv0eiSbI
         QwJBk8dsDXkjqx25DuOyRAOAn71cAsh1bZKsbcK2LgwHSwfdiMyBqXsN7gnF3nFkJloP
         AQJQ==
X-Gm-Message-State: AOAM530Vx36dgeQOHPzOFrYMijdP8u/i7nDTke9aOAQvIxuqGWt+MD14
        B/p5J97mIJLjeGv46HWW5A==
X-Google-Smtp-Source: ABdhPJzCgS2+9IVk5Tx2uZxt53icJClclYr41+KWs+1MFAWFGah5SuHKlzKkJ0a41MUO3c67G6RZaA==
X-Received: by 2002:ae9:e649:: with SMTP id x9mr2922653qkl.204.1640198665215;
        Wed, 22 Dec 2021 10:44:25 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id j13sm2217950qtr.21.2021.12.22.10.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 10:44:24 -0800 (PST)
Received: (nullmailer pid 2490160 invoked by uid 1000);
        Wed, 22 Dec 2021 18:44:23 -0000
Date:   Wed, 22 Dec 2021 14:44:23 -0400
From:   Rob Herring <robh@kernel.org>
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     Eckert.Florian@googlemail.com, pavel@ucw.cz, robh+dt@kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt: bindings: KTD20xx: Introduce the ktd20xx
 family of RGB drivers
Message-ID: <YcNyBxamNnPqSAt2@robh.at.kernel.org>
References: <20211221134052.22387-1-fe@dev.tdt.de>
 <20211221134052.22387-3-fe@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221134052.22387-3-fe@dev.tdt.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2021 14:40:52 +0100, Florian Eckert wrote:
> Introduce the bindings for the Kinetic KTD2061/58/59/60RGB LED device
> driver. The KTD20xx can control RGB LEDs individually. Because of the
> hardware limitations, only 7 colors and the color black (off) can be set.
> 
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> ---
>  .../bindings/leds/leds-ktd20xx.yaml           | 130 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 131 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-ktd20xx.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
