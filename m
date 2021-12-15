Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE7E475E1A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 18:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245105AbhLORCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 12:02:15 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:38663 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245087AbhLORCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 12:02:15 -0500
Received: by mail-oi1-f173.google.com with SMTP id r26so32505609oiw.5;
        Wed, 15 Dec 2021 09:02:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V+y9GiCveQwMhud+dvgaSxPYr/w+XUaIP7q5yuTqCnY=;
        b=syZiUq+O/gqBxqq9xs3mT91RFXjR69UA5hoOIyH2PTOmPqnq/hBsxPs0stHa0ySeUd
         +HZXyEbo1epkJznfc+pTrUD8/D2bNLSIEXgGP8r0KNI2CXSQ+xVBYenb1uv5SSP7bOAK
         9j/QGphPEGOT3ffKcK0/gkH+9c+DElc9/xCwNhsUabwPnmizwN1AaqJ0oFpMenZOHmS1
         noLvLte3k3HiJVdcpYxgjEIGy+YfmIi8GlEsNcgPy0X5lDkGVJIXGBA0Q3C/OyHAu6lZ
         SeRKaycr2bNd+Hj09wTQmsRVlK81eaOXpJkBpYniLhHHAsOP6gxt87Qfx6YWpJSWUIKY
         oZlw==
X-Gm-Message-State: AOAM531nxFMM8R/w3FF1rugh/6Qc8X4hLtiGNIHsyLE5DixiPTHnS05C
        E61a7PIFGuZiLBNSJYmi3hBlhXkg5Q==
X-Google-Smtp-Source: ABdhPJyGcio93kNd4pcS090Ougalyjt3Z3KWxFWBdGxRvmuod0jnqic+RtZVUoTdjrLf4mqYfrZ8tA==
X-Received: by 2002:a05:6808:53:: with SMTP id v19mr707999oic.8.1639587734430;
        Wed, 15 Dec 2021 09:02:14 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r22sm442935oij.36.2021.12.15.09.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 09:02:13 -0800 (PST)
Received: (nullmailer pid 1475047 invoked by uid 1000);
        Wed, 15 Dec 2021 17:02:12 -0000
Date:   Wed, 15 Dec 2021 11:02:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     reinhold.mueller@emtrion.com
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexandre.torgue@foss.st.com
Subject: Re: [PATCH v2 1/2] dt-binding: arm/stm32: Add emtrion hardware
 emSBC-Argon
Message-ID: <YboflK9CaiAwnJxE@robh.at.kernel.org>
References: <20211209104947.4647-1-reinhold.mueller@emtrion.com>
 <20211209104947.4647-2-reinhold.mueller@emtrion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209104947.4647-2-reinhold.mueller@emtrion.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Dec 2021 11:49:46 +0100, reinhold.mueller@emtrion.com wrote:
> From: Reinhold Mueller <reinhold.mueller@emtrion.com>
> 
> This patch presents the yaml patch for the emtrion GmbH
> Argon board series.
> 
> Signed-off-by: Reinhold Mueller <reinhold.mueller@emtrion.com>
> ---
>  Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
