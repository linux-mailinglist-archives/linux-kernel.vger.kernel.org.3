Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6556B48BCA7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347962AbiALBsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:48:14 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:36627 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347952AbiALBsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:48:13 -0500
Received: by mail-ot1-f51.google.com with SMTP id s21-20020a05683004d500b0058f585672efso913421otd.3;
        Tue, 11 Jan 2022 17:48:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ik98dbcozYmPN6lZff3Ua7PUGw9hdVOCzctxvy/Tu10=;
        b=s6wZsGCLWeNWyKRZWY2W4RS0g9HeB8jfDj3BLEycQ7CDKl2rQjr2lJnT1oGtYfILjZ
         cU/IL9Fz34PaNFl42i7vQ5eU9rujhZgap8AcNJqhAYfaEN3BVa3PIvaQ7yYsVbbyf92v
         804jvEFXwFtqnloXUaCIAj1y8+RBbbXDgwTfLH7ldkjgH73N9CFlLBYYb4nYIxOZ6FOw
         sPP/7LupQTeD4I+qns7yPj8rtU3XtJ7Q/YQ6P+qIJcigDO8EhUhfZxs1wA6Sg3J0cJdU
         p3mkERzZKjjutAu3jLEiHGMrmODugx0kKYx2O7DJ6oFElGKmXa8UC0XhexwQzU9eNnuf
         zkKw==
X-Gm-Message-State: AOAM531UCThG1zgpcCnHdOB0J0M0cVojrvx+386qWXiYbLf5c6lo9xwL
        /Qb78LGEMzUeGy7JVRZYOg==
X-Google-Smtp-Source: ABdhPJz42u2no1OUu7eszZ7PMR3hrkXlHdBWiL2Rf3E54ziC8XPMBGWquYR+2+gzMoyGthdl9nYGGw==
X-Received: by 2002:a05:6830:4393:: with SMTP id s19mr5148173otv.272.1641952092777;
        Tue, 11 Jan 2022 17:48:12 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t26sm1991074oic.51.2022.01.11.17.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 17:48:11 -0800 (PST)
Received: (nullmailer pid 3894790 invoked by uid 1000);
        Wed, 12 Jan 2022 01:48:10 -0000
Date:   Tue, 11 Jan 2022 19:48:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zelong Dong <zelong.dong@amlogic.com>
Cc:     devicetree@vger.kernel.org, jbrunet@baylibre.com,
        khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, narmstrong@baylibre.com,
        linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de,
        robh+dt@kernel.org, martin.blumenstingl@googlemail.com
Subject: Re: [PATCH 1/3] dt-bindings: reset: Add compatible for Meson-S4
 Reset Controller
Message-ID: <Yd4zWnQxB1ZK8IPo@robh.at.kernel.org>
References: <20220107023931.13251-1-zelong.dong@amlogic.com>
 <20220107023931.13251-2-zelong.dong@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107023931.13251-2-zelong.dong@amlogic.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Jan 2022 10:39:29 +0800, Zelong Dong wrote:
> Add new compatible for Amlogic's Meson-S4 Reset Controller
> 
> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
> ---
>  Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
