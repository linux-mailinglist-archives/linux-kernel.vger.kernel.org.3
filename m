Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1275246A8A8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 21:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349761AbhLFUnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 15:43:53 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:39802 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344890AbhLFUnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 15:43:52 -0500
Received: by mail-ot1-f46.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso15185013ots.6;
        Mon, 06 Dec 2021 12:40:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G9TDOALasqiFSszInJV6KzrsLKJJEMpQxRMDfbAXH48=;
        b=mFA0URKjRPDmmibSHPRu+2kbtGC7e9afHnUST8Lg9N6YwKk3wtcPJOYP/dV1hEoImA
         UT6sK2+Z6ZZP83jkTJP8d6Mdgc/9Fzf3PFY6rMTZPpInGI6vrkTxcGIQdwV5e5GQIGk5
         ziUCO3Ti0rhHtv62aXqtu1gk/BNZOjMD5nDzCowNWCyQ6r5aBezMKa94hvdimplzdBBe
         u4R92099GQnD2UhzKHoWfrguNh9u2WKI3QJ5wie9YefUZxUZY3AynkHDgpPiQlWDcy+e
         injQBEa67HnBSKOdmZTVmaMQgy2TkimjVf4MRj2vZGZbVeIufDxTpUW4EmlqMN+gmlqg
         PPMQ==
X-Gm-Message-State: AOAM5313dGE2RJVM7SaD0lDxZ9EBYD4glG2tOHAOBlbmuWPAIHMnGook
        RYxnxrfUNYLVXKunIxaHKkZpVRBbkQ==
X-Google-Smtp-Source: ABdhPJxCL9cAErW+hVEsmv1fgbiitQWpYvUCUxe+OHBgCAgPMcjVm7hvwJev23IYD7Asr4EfPFYbPQ==
X-Received: by 2002:a9d:2002:: with SMTP id n2mr31418152ota.95.1638823222894;
        Mon, 06 Dec 2021 12:40:22 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bj8sm3100955oib.51.2021.12.06.12.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 12:40:22 -0800 (PST)
Received: (nullmailer pid 2546639 invoked by uid 1000);
        Mon, 06 Dec 2021 20:40:21 -0000
Date:   Mon, 6 Dec 2021 14:40:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: regulators: Document Tegra regulator
 coupling in json-schema
Message-ID: <Ya51Ndf+VdRRdM9h@robh.at.kernel.org>
References: <20211206154032.227938-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206154032.227938-1-thierry.reding@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 04:40:32PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Move the NVIDIA Tegra regulator coupling bindings from the free-form
> text format into the existing json-schema file for regulators.

Do we need these properties for every single regulator? This should be 
its own schema file and then referenced where it is needed.

> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../nvidia,tegra-regulators-coupling.txt      | 65 -------------------
>  .../bindings/regulator/regulator.yaml         | 22 +++++++
>  2 files changed, 22 insertions(+), 65 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/regulator/nvidia,tegra-regulators-coupling.txt
