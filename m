Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC284A4901
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 15:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377842AbiAaOIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 09:08:31 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49770 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244552AbiAaOIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 09:08:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E937B612E5;
        Mon, 31 Jan 2022 14:08:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1CFC36AE2;
        Mon, 31 Jan 2022 14:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643638109;
        bh=eYNdHLqQouEIEhZH230lPkO0ptNEzAszqaQ0pmPK8Lw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PxXYypcJwsQ2m0t6g9bljx68WvpzIN4zqV9ct0oJJXhCiIFTFKroRRGXMWU4dGnws
         YdwFEQhVrmb0uSyJDmX7sJsrDrcohYg53W/BIasigkTUZp20CzlgO494mS+TAtFAaM
         qP7UhBjbU757pi4yBSDl5i34bEG6lNLLq3HVBUB81K2Y/jS0PbwVxSgTE1RNL4hznr
         XMhUo3dkKfjg9o0oOkqXjiz6SleFNlFMfINocSYu2xfKtsqH/QpV7BMiUuTASn/vQ8
         BnEDsRliveCaKA/FHULHxRk+HI7l/BRCYnDea3zt5vCR+7ml6b2uw2qWd3frKLk5TP
         PgjKVfpdtWLcg==
Received: by mail-ej1-f41.google.com with SMTP id j2so43004971ejk.6;
        Mon, 31 Jan 2022 06:08:29 -0800 (PST)
X-Gm-Message-State: AOAM530cGs958J/ElGDPf0zAojjmzvVWRwlLSfhUAxHXhCigac4Dh8v2
        pBlDGjFv4HWtbyNqfJEAzDEfa/C1sBCKJ1LV7w==
X-Google-Smtp-Source: ABdhPJzXwYNlL2rg8h8DgR2AIEf+6Xiadu7eYPnmrZWIFGRW/jNuygzOHHd2oGX4mt7a+wmRM80ssdnTYzv2Cf4zggo=
X-Received: by 2002:a17:907:2d1e:: with SMTP id gs30mr17061887ejc.14.1643638107612;
 Mon, 31 Jan 2022 06:08:27 -0800 (PST)
MIME-Version: 1.0
References: <1643337290-1376-1-git-send-email-lhjeff911@gmail.com>
In-Reply-To: <1643337290-1376-1-git-send-email-lhjeff911@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 31 Jan 2022 08:08:14 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLZT2+wJO-tLVt9psWSRoCisjM+=iQa9jryvjjP8sxSOA@mail.gmail.com>
Message-ID: <CAL_JsqLZT2+wJO-tLVt9psWSRoCisjM+=iQa9jryvjjP8sxSOA@mail.gmail.com>
Subject: Re: [PATCH -next] dt-bindings:spi: Fix error for test.
To:     Li-hao Kuo <lhjeff911@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        "LH.Kuo" <lh.kuo@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 8:34 PM Li-hao Kuo <lhjeff911@gmail.com> wrote:
>
> Fix error for test remove the include path and modify parameters
> ---
>  Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml b/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
> index 24382cd..3dd164d 100644
> --- a/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
> @@ -20,8 +20,7 @@ properties:
>
>    reg:
>      items:
> -      - the SPI master registers
> -      - the SPI slave registers
> +    minItems: 2

items:
  - description: SPI master registers
  - description: SPI slave registers
