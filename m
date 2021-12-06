Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9350646A904
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242901AbhLFVFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:05:55 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:46054 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbhLFVFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:05:54 -0500
Received: by mail-oi1-f182.google.com with SMTP id 7so23722247oip.12;
        Mon, 06 Dec 2021 13:02:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2oyty0xsfvWrj6OhLFZNGZUWW1B8YFU5eRdWHSgy7PU=;
        b=4F5gAx53T53CjEiED9+rus1WqRh8/wbVtz4FnltunhTiKC0fbbSk0xN1XaexLP6IYH
         3HMyT3Cwll1P3x/QImftg6amol/NvaUgWM0fastEB+j6/d3Vx7rJ/5wiid1RMJ/yy8oo
         iWK3BAEutBCF4ghR/ak1e+MSb5JSnOFd3au/axspXKfYW6D0PezeAQt9KB3Ngsgtvdju
         Bnkk6hyJUYkAfC8tYxSH0+TiNEybfIQCzYI1i5S2yuRSIZa93HjtXBZj33gO7kEj+jYI
         orhMOkdNmsE1LcqXGxN97BZyDxyEPaJST3AosGV5TUP/NHqBhF3aNGjOqw05xDvGzH/T
         vY6w==
X-Gm-Message-State: AOAM530NODCEf2yjIsrM9cTNZ8gDxN4VNsjH0BmJPW8qDCgTxoy3R3Tk
        Ibr7hl+fpqsomCQ8YgjK6g==
X-Google-Smtp-Source: ABdhPJyfMRSShzT8CkbeQSkFjn7ORJQDpLrQTHZobuuL2O9psekoj85E7ZUONGsrgCATLaREROS/5A==
X-Received: by 2002:a05:6808:209b:: with SMTP id s27mr1079807oiw.43.1638824544805;
        Mon, 06 Dec 2021 13:02:24 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 3sm2825327oif.12.2021.12.06.13.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 13:02:24 -0800 (PST)
Received: (nullmailer pid 2578233 invoked by uid 1000);
        Mon, 06 Dec 2021 21:02:23 -0000
Date:   Mon, 6 Dec 2021 15:02:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 1/5] dt-bindings: soc: samsung: Add Exynos USI bindings
Message-ID: <Ya56X9CJrXWw8rm3@robh.at.kernel.org>
References: <20211204195757.8600-1-semen.protsenko@linaro.org>
 <20211204195757.8600-2-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211204195757.8600-2-semen.protsenko@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 Dec 2021 21:57:53 +0200, Sam Protsenko wrote:
> Add constants for choosing USIv2 configuration mode in device tree.
> Those are further used in USI driver to figure out which value to write
> into SW_CONF register. Also document USIv2 IP-core bindings.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> Changes in v3:
>   - Removed usi0 "status" property from the example
>   - Made child nodes pattern allow only serial/spi/i2c node names
>   - Moved all USIv2 specific properties under corresponding "if:"
>   - Renamed compatible from samsung,exynos-usi-v2 to samsung,exynos850-usi
>   - Related: submitted separate patch removing warning on
>     "make dt_binding_check" for USI bindings
> 
> Changes in v2:
>   - Combined dt-bindings doc and dt-bindings header patches
>   - Added i2c node to example in bindings doc
>   - Added mentioning of shared internal circuits
>   - Added USI_V2_NONE value to bindings header
> 
>  .../bindings/soc/samsung/exynos-usi.yaml      | 159 ++++++++++++++++++
>  include/dt-bindings/soc/samsung,exynos-usi.h  |  17 ++
>  2 files changed, 176 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
>  create mode 100644 include/dt-bindings/soc/samsung,exynos-usi.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
