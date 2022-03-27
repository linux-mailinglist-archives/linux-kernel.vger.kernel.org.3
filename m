Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC044E87F4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 16:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbiC0ODz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 10:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbiC0ODx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 10:03:53 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40724BBAF;
        Sun, 27 Mar 2022 07:02:14 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id e4so13108411oif.2;
        Sun, 27 Mar 2022 07:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=ESfFqUyi5DO4us9FBeXvh3yFju448DlfeiezEoyiJ+o=;
        b=zRavEkAQC7+tAFvAOIu28Nf3SK/FN9v/8RNnMCTbWahTuqEprUC8VY4jFr5CMpRL5M
         HrrUmfnzvADBbOSOAsNpe7Xonq4G+qCLk41T7GBR20eJkNiDJ689v8tznZvcfYXrhCQR
         nzCPQ9u7IyRVjz+RTNgs/Awde1FgR4ShItXyHoR9kXAW0txy6XjVz09gj4ivh4EhZpMI
         6iKUl/jGJCW6F6gT/HfxssX6VTfco7zpWcU7O68MQhvMhOM/hlY0duW5GeKwpST0Yq3S
         M+Eu/fL2QjsDX+KjMksiiRS/sBwaedJz7vqh8mq+YB+IEAEYy31KDLF1D6BWYtObnHlW
         D79g==
X-Gm-Message-State: AOAM533Jkr59Yyq4x1hHVjAz4kjOG+1q8hyuNYVTfp9GrbnWSKSITMD+
        JkvqmglGgCKcyKd+C8RuEQ==
X-Google-Smtp-Source: ABdhPJxdXmCXwfJxnUC4f+8NgXNJS8r1JCu8KDUQA7dtspjSpD7unbMjCem5Kdi/CNB+OZol7qMxhA==
X-Received: by 2002:a54:4516:0:b0:2ec:8ee8:90c3 with SMTP id l22-20020a544516000000b002ec8ee890c3mr13594539oil.81.1648389733902;
        Sun, 27 Mar 2022 07:02:13 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 15-20020a056870004f00b000def9984dc9sm445438oaz.7.2022.03.27.07.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 07:02:13 -0700 (PDT)
Received: (nullmailer pid 4042147 invoked by uid 1000);
        Sun, 27 Mar 2022 14:02:11 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sui Jingfeng <15330273260@189.cn>
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Roland Scheidegger <sroland@vmware.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Lucas Stach <l.stach@pengutronix.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, Qing Zhang <zhangqing@loongson.cn>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        suijingfeng <suijingfeng@loongson.cn>,
        David Airlie <airlied@linux.ie>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Zack Rusin <zackr@vmware.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
In-Reply-To: <20220327113846.2498146-4-15330273260@189.cn>
References: <20220327113846.2498146-1-15330273260@189.cn> <20220327113846.2498146-4-15330273260@189.cn>
Subject: Re: [PATCH v12 3/6] dt-bindings: display: Add Loongson display controller
Date:   Sun, 27 Mar 2022 09:02:11 -0500
Message-Id: <1648389731.700898.4042146.nullmailer@robh.at.kernel.org>
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

On Sun, 27 Mar 2022 19:38:43 +0800, Sui Jingfeng wrote:
> Add DT bindings and simple usages for Loongson display controller
> found in LS7A1000 bridges chip and LS2k1000 SoC.
> 
> Signed-off-by: Sui Jingfeng <15330273260@189.cn>
> ---
>  .../loongson/loongson,display-controller.yaml | 322 ++++++++++++++++++
>  1 file changed, 322 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/loongson/loongson,display-controller.example.dt.yaml: display-controller@6,1: 'ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1609879

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

