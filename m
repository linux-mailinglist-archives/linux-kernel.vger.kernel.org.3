Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406F64698CC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344194AbhLFO2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:28:54 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:46673 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236352AbhLFO2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:28:53 -0500
Received: by mail-oi1-f176.google.com with SMTP id s139so21661152oie.13;
        Mon, 06 Dec 2021 06:25:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=1UM6mk2YqDOCPpxKmVW4hUay67A5ShMZFccLmrgtyws=;
        b=l1m+dAcvG6tuwyX2hv9sWXpKM9QC6dCJWTxsGuZf/wEe/H1RdrQ4BQ03FxzoEWyOHe
         J5eGPTIhetFLIZUpl+xLlcnIgk7UBpWc9Z51k+diCzBs/ADTm488hqhnEsMK/cEKRW8/
         8BkxxZlVfrqVAz8Dmv92lT82mq2+sI2laEYTiNZoP+sETzrF9DbKN4UUpMq9/S3H+zte
         OQam/nwpFIBqEO8ot0jT4IT9ywd747TiQ4ykpjfYWruyMqD7U1ZbLZ2Hd5i38YjrEgvE
         6zEFjSHtwknKkiIsmUbuvYvygB9wzYzPfz3kxWT6CzYCWsd7B6TMnknbrR6TQivhX/fh
         Bh3g==
X-Gm-Message-State: AOAM5337mmYznMCBu8dpkzTzxweqAFZu81MS0pZf6fowiglJZPlp6Sl4
        w+BDrf8CvU4K/DTcIQCSo0ejeg+utQ==
X-Google-Smtp-Source: ABdhPJwHh7iLhlSQhwyOIjqD6otmwOl55D4ggjQJihayjKesYaNOleTLyfqMib/TY7E6KZA+XSLjEA==
X-Received: by 2002:aca:1c02:: with SMTP id c2mr24930352oic.53.1638800724490;
        Mon, 06 Dec 2021 06:25:24 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x12sm2181654oom.44.2021.12.06.06.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 06:25:23 -0800 (PST)
Received: (nullmailer pid 1976291 invoked by uid 1000);
        Mon, 06 Dec 2021 14:25:22 -0000
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        benjamin.gaignard@collabora.com, cphealy@gmail.com,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-staging@lists.linux.dev, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, nicolas@ndufresne.ca,
        Fabio Estevam <festevam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>
In-Reply-To: <20211205181618.1041699-3-aford173@gmail.com>
References: <20211205181618.1041699-1-aford173@gmail.com> <20211205181618.1041699-3-aford173@gmail.com>
Subject: Re: [RFC 2/5] dt-bindings: soc: add binding for i.MX8MQ VPU blk-ctrl
Date:   Mon, 06 Dec 2021 08:25:22 -0600
Message-Id: <1638800722.475991.1976290.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 Dec 2021 12:16:15 -0600, Adam Ford wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> This adds the DT binding for the i.MX8MQ VPU blk-ctrl.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
>  .../soc/imx/fsl,imx8mq-vpu-blk-ctrl.yaml      | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx8mq-vpu-blk-ctrl.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/imx/fsl,imx8mq-vpu-blk-ctrl.example.dt.yaml: blk-ctrl@38320000: compatible: ['fsl,imx8mq-vpu-blk-ctrl', 'syscon'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/imx/fsl,imx8mq-vpu-blk-ctrl.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/imx/fsl,imx8mq-vpu-blk-ctrl.example.dt.yaml: blk-ctrl@38320000: compatible: Additional items are not allowed ('syscon' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/imx/fsl,imx8mq-vpu-blk-ctrl.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1563759

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

