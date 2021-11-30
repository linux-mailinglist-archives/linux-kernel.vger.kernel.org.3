Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87391462A5F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 03:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237487AbhK3C1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 21:27:11 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:44731 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237480AbhK3C1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 21:27:10 -0500
Received: by mail-oi1-f181.google.com with SMTP id be32so38307131oib.11;
        Mon, 29 Nov 2021 18:23:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YXUBfQF7hCqvBBiP1j5oBDx8GJzdoyVMRD72cEP8hjo=;
        b=HDfzqCIOOXtNwYDNGXWjVbOl9Q+uwYKEo8GE/koIX0pIn/zb6GHw2/uvPyV7IyoP6s
         vcQ9b7uyB622xshL6yGsG1ez6TPx5WV3Tcg40/rRXHP9vJQOAyj28x7+O8wgd0z7w8oK
         KMzTxDC5yyL3FauEj1gqXfrYvOcFJUUCCf+QbtX15v8+q7yBnLEGpyNChks4Eo7I38NU
         sJA42M41m9D94hY3eS3FIFKZAG2cFMmx3E4Z/NasPTCAj+WqMCUwwnv+nzf5D1OnJomS
         gaSz5/Cqy6MjsjgMg/rSe6sRZWqsgZR6jW9MbijlAL/HsD2dfTqE3gDsK28ciTfeP0S4
         3siQ==
X-Gm-Message-State: AOAM530FWETXWCWSuXFMqK3y9QYcbJHBpafp5ktSgMK6nFSCpICijzZJ
        wqGd0Mp9KfFIYdbhCfnhwr979UtgFA==
X-Google-Smtp-Source: ABdhPJxH9J0O0pwppVCjvcqtVmRgvS9E5RPa4mjZxU0/U70flqLSQJM3I8cbohfZ9aCgkoVJrM440Q==
X-Received: by 2002:aca:5983:: with SMTP id n125mr1666733oib.153.1638239031599;
        Mon, 29 Nov 2021 18:23:51 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n26sm2556614ooq.36.2021.11.29.18.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 18:23:50 -0800 (PST)
Received: (nullmailer pid 1053958 invoked by uid 1000);
        Tue, 30 Nov 2021 02:23:50 -0000
Date:   Mon, 29 Nov 2021 20:23:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] dt-bindings: mfd: Add Freecom system controller
Message-ID: <YaWLNr+PpkuZ0w8b@robh.at.kernel.org>
References: <20211122102210.3137559-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122102210.3137559-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2021 11:22:10 +0100, Linus Walleij wrote:
> This adds a DT binding for the Freecom FSG3 system controller
> found at CS2 in the Freecom FSG3 Intel IXP42x-based router.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
