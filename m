Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E7D47D607
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 18:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344417AbhLVRuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 12:50:21 -0500
Received: from mail-qk1-f173.google.com ([209.85.222.173]:36841 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbhLVRuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 12:50:18 -0500
Received: by mail-qk1-f173.google.com with SMTP id i130so2055397qke.3;
        Wed, 22 Dec 2021 09:50:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G0Bo2xi487zsjbvsxUHGM60Jt3WTXGtaD5AP/5FQrYU=;
        b=U1DRQ1kyz3tC1gqyuCFbkXgWUH0kb8lnL9SZw0Aon7ymbzCDayP+dytcedCCW5enb1
         93g2QNKvKmuNw7KKDqCaINW9/JRBwQma/W+r4i1q36TKmVMO51JpUGiaDLMs9hQdPv61
         P2o1pTTCKEfkixWwQPh1hmxgxZ4MxhG1oiYxSNFXZnrF8gKaOypgLj5v7ZdvVLHpW7Xq
         7us32IGd9iI5c0szbp5+welX1sWvshnRE/bS+XWyC3J9ScUIIY0WWekjB6QOr/QckjtY
         5JJtrgHqO7kyUd81kGmp85Lju8P6tFE6zP1QuVIwCDdGFCKPGtzWj68+vvmhMIbKceIo
         qWQg==
X-Gm-Message-State: AOAM530s36eZFWgKXPkaszVP98soKAQQRrz6EqeN53Z2kReLSyy0ZKo8
        xdfoaGa1JLXq260QgyIg9A==
X-Google-Smtp-Source: ABdhPJyvAAEpmHO21h+BgfeOi40PfsFEpHcNduiO7Js5mzx8z/J1daeSExKuDA/ssJQ+ZFmLU9Ujqg==
X-Received: by 2002:a05:620a:15cb:: with SMTP id o11mr2820061qkm.371.1640195417674;
        Wed, 22 Dec 2021 09:50:17 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id f18sm2518981qko.34.2021.12.22.09.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 09:50:16 -0800 (PST)
Received: (nullmailer pid 2400088 invoked by uid 1000);
        Wed, 22 Dec 2021 17:50:15 -0000
Date:   Wed, 22 Dec 2021 13:50:15 -0400
From:   Rob Herring <robh@kernel.org>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     broonie@kernel.org, sean.wang@mediatek.com,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        bgolaszewski@baylibre.com, linux-mediatek@lists.infradead.org,
        bayi.cheng@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linus.walleij@linaro.org, gch981213@gmail.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/4] dt-bindings: pinctrl: mt8195: add wrapping node
 of pin configurations
Message-ID: <YcNlVzSZAWCM9eKO@robh.at.kernel.org>
References: <20211220121825.6446-1-tinghan.shen@mediatek.com>
 <20211220121825.6446-4-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220121825.6446-4-tinghan.shen@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2021 20:18:24 +0800, Tinghan Shen wrote:
> On mt8195, the pinctrl node has pinctrl groups to group pin
> configurations by users' need. In each pinctrl group, it has
> subnode(s) to list pins needed and pin configurations. By supporting
> multiple subnodes, we can configure different pin characteristics
> (driving/pull-up/pull-down/etc.) in a pinctrl group.
> 
> Update pinctrl-mt8195.yaml to add subnode in pinctrl groups and an
> example to illustrate the usage.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  .../bindings/pinctrl/pinctrl-mt8195.yaml      | 338 ++++++++++--------
>  1 file changed, 188 insertions(+), 150 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
