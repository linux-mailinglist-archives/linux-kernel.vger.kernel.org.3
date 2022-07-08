Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71EF56C1C5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239854AbiGHWKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 18:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiGHWKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 18:10:34 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900899FE06;
        Fri,  8 Jul 2022 15:10:32 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id u6so54327iop.5;
        Fri, 08 Jul 2022 15:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oN8Bupin0hE35LPgYOevBJqhqJt/5KoteoM0acQHYOI=;
        b=ouxvrYtNy128Cq/HU+Yk6pxMDlRkBIcfzN+meSU03e98GKJREdLA+Cb+fO4pmaBTsA
         GjuOhxpBp9zlJSdpdmE66rJszpMa6rXo51b6WlMjO+hMcdvVFSeRaTmSSkXc3SEY7dOS
         THMKCamGjGLMs7x+Oi8l29n/H9W2BuWYFtOxuILLR8jGPL4wscPBSJndAvKUAs5f6mGA
         sh/F979dqCipM5dCqDhDnb/vdRaO5wiromGyXEiqJczmhidYvnbi8atgyeZhF4jwV3WD
         Jokpno7JsC4K1ueWTUG360xm8JvwEb7FVvd669B39EHQHpxKCAfMF13rD+dIZ02CQdBP
         GrSg==
X-Gm-Message-State: AJIora/d9GLObBqpIIJ6G9OHvESnrQYxT8Rm1cdKoGDAHXWt6bkf9zCb
        HGuIuMeNl7jzU2rZqHnzAQ==
X-Google-Smtp-Source: AGRyM1vgvzoqD/VrjwnV1hgMdhHsLV/WW3CpbxY6wr8BZDe4k4zakYv2tFXWrRfkjJtuZF95e+K6UA==
X-Received: by 2002:a05:6638:3d83:b0:33c:805a:77eb with SMTP id ci3-20020a0566383d8300b0033c805a77ebmr3525050jab.237.1657318231891;
        Fri, 08 Jul 2022 15:10:31 -0700 (PDT)
Received: from robh.at.kernel.org ([98.38.210.73])
        by smtp.gmail.com with ESMTPSA id n28-20020a056602341c00b0067b7841c09asm14656ioz.15.2022.07.08.15.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 15:10:31 -0700 (PDT)
Received: (nullmailer pid 1567732 invoked by uid 1000);
        Fri, 08 Jul 2022 22:10:30 -0000
Date:   Fri, 8 Jul 2022 16:10:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] dt-bindings: usb: mtk-xhci: add compatible for mt8188
Message-ID: <20220708221030.GA1567681-robh@kernel.org>
References: <20220707015041.12264-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707015041.12264-1-chunfeng.yun@mediatek.com>
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

On Thu, 07 Jul 2022 09:50:41 +0800, Chunfeng Yun wrote:
> Add compatible for mt8188
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
