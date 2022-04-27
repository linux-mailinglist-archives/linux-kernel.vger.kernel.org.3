Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3785121FE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbiD0TEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbiD0TEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:04:02 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B983EA81;
        Wed, 27 Apr 2022 11:51:20 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id z8so2982337oix.3;
        Wed, 27 Apr 2022 11:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AGqch3bATlGRMhd+ZKwzHi93QGO4MV6rf3Gggs9S8RU=;
        b=WFK5xwiifYhiPtOEIVYIxjbEamEJG99ISVvocFU+r9hlb3sGyq+q+QyGAmJiKrjZmH
         jSWIRhQ7xjxBhXMvnzEg56Ik6VBMFmvZ9HM8ysoVxCwZIoKyB1s/nrBTEdkquvAJK7js
         1md9kAgi8cmkwDwm0x8e9mooyQEEWW9V/htMjyha5nF5qiAptj84cBkML2twSuxQHenj
         V8WQ5oZSlduSsONR+AxUSQTae5Tb3j+qiOJ6r3TwsKepxh4uz1oxm8UQK0rCWe+eckrI
         yoDe+QHbrg96ILJ1M767dPDvKZNVI/nIPJF4kC+CJr9KQpg9HPU5tcgKhX5V2KsPz6g+
         Ed2w==
X-Gm-Message-State: AOAM532+PIW5/PLmpnjYxizYj/YhEjpfbuMsDKnLAxjpqeKwnQctMDvu
        cDeK16Mf+aiwvIK3r2t5K5aAtGGaUA==
X-Google-Smtp-Source: ABdhPJzzy7JvgYRMGnamDwMItt3zlMQk/ii3fBauzE+PpVYc6O+WSGeQ6iaBSdKNZRgfSiaKBYadIQ==
X-Received: by 2002:aca:4246:0:b0:322:8eea:1049 with SMTP id p67-20020aca4246000000b003228eea1049mr13729426oia.73.1651085479761;
        Wed, 27 Apr 2022 11:51:19 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q34-20020a056808202200b0032545864b89sm2911778oiw.14.2022.04.27.11.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:51:18 -0700 (PDT)
Received: (nullmailer pid 446568 invoked by uid 1000);
        Wed, 27 Apr 2022 18:51:18 -0000
Date:   Wed, 27 Apr 2022 13:51:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     lee.jones@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, pavel@ucw.cz, devicetree@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH 2/2] dt-bindings: mfd: Add bindings for the Mediatek
 MT6360
Message-ID: <YmmQpg/Hh6qTNhj2@robh.at.kernel.org>
References: <20220427080330.40136-1-gene.chen.richtek@gmail.com>
 <20220427080330.40136-3-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427080330.40136-3-gene.chen.richtek@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 04:03:30PM +0800, Gene Chen wrote:
> From: Gene Chen <gene_chen@richtek.com>
> 
> Add bindings for the Mediatek MT6360
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  .../devicetree/bindings/mfd/mt6360.yaml       | 258 ++++++++++++++++++
>  1 file changed, 258 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mt6360.yaml

As I mentioned, I applied your previous version. Please send a patch on 
top of it adding the child nodes.

Rob
