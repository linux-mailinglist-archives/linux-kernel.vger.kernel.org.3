Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060DC4AF55E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbiBIPfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbiBIPfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:35:07 -0500
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0175AC0613CA;
        Wed,  9 Feb 2022 07:35:11 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id u13so2836989oie.5;
        Wed, 09 Feb 2022 07:35:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=rue2p+rxxRzTcpzXBjAx6Nrna1JsJ4CzugHpoyHjtrM=;
        b=jWgL9d+b3mrrkbTSySQMVGizVkmdR3j62y1hkms5xbNTU0lK4/4r5j1IvaUbM+6lKj
         435X0rgDRY6rfW9UzTMDQBtKftoCM7EbDit2F1L1BzP3Lybj1rkkbUnbxtqPgkbXJYTe
         aphIedqoG2htmHDLdPP7k3h/s2qRyQpVuhki2pf+xycfZlWtuN16R74bCn4ezG3jsZJX
         cARayLLhbtO4Sv6xysVnz2b1zAoU8lEHYMxwhnbb+u9bLHulZ7zhYqrasC30uiKDJHzg
         DetqqKUgQp39WcCJ8Cc5I7UWHGf1wtV5qgrVbiznDkFCpUci3BQYCfCwe4S/bF27T0rM
         w3Ww==
X-Gm-Message-State: AOAM530SfkJns6Qz1H1VJZqU8QPcQYFSWeO9cAEsnBHpw3Tf9xUUxGkN
        sMWD32bhFSaa+UBFNwYkcQ==
X-Google-Smtp-Source: ABdhPJxWKdE43poQgnWFP4/5cT7wgQczeGULboq8vh/fIH2TWeERikdANfIAYgAS4jESe/UbnkGqnw==
X-Received: by 2002:aca:1a0f:: with SMTP id a15mr1226523oia.61.1644420910248;
        Wed, 09 Feb 2022 07:35:10 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m26sm6845473ooa.36.2022.02.09.07.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 07:35:09 -0800 (PST)
Received: (nullmailer pid 391812 invoked by uid 1000);
        Wed, 09 Feb 2022 15:35:08 -0000
From:   Rob Herring <robh@kernel.org>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Peter Geis <pgwipeout@gmail.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-kernel@vger.kernel.org, Liang Chen <cl@rock-chips.com>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Alex Bee <knaerzche@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20220209085110.3588035-2-michael.riesch@wolfvision.net>
References: <20220209085110.3588035-1-michael.riesch@wolfvision.net> <20220209085110.3588035-2-michael.riesch@wolfvision.net>
Subject: Re: [PATCH v5 1/5] dt-bindings: gpu: mali-bifrost: describe clocks for the rk356x gpu
Date:   Wed, 09 Feb 2022 09:35:08 -0600
Message-Id: <1644420908.380944.391811.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Feb 2022 09:51:06 +0100, Michael Riesch wrote:
> From: Alex Bee <knaerzche@gmail.com>
> 
> The Bifrost GPU in Rockchip RK356x SoCs has a core and a bus clock.
> Reflect this in the SoC specific part of the binding.
> 
> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> [move the changes to the SoC section]
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
>  .../devicetree/bindings/gpu/arm,mali-bifrost.yaml | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml:173:12: [warning] wrong indentation: expected 12 but found 11 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1590238

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

