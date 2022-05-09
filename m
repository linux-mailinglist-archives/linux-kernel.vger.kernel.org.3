Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3B75207E0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 00:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbiEIWkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 18:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiEIWkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 18:40:12 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84781F2D4F;
        Mon,  9 May 2022 15:36:17 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id v65so16757295oig.10;
        Mon, 09 May 2022 15:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c1M6wqhWWv3BpYBqrk6no0d2EvsycYmqX1VGhpzRGEI=;
        b=tqDFTe1O9Ipx9pNZMMfm86YT87caCTcNfyt6zeoVAYmHFp0EMeLBRdEjacoHQLUJN1
         +HxNkdP0K137pXAse6EyH8XXL7PCiF+qhep6eoeGSKqMHfmqj+FoWQ7sCoxfMz9zzhQ4
         bsIj2QmFyurMaazleqY+eNYk6Uu7+BFMGQmgZc9slRbQgQzpmAu9EU0229lQk+XmoTvn
         T3BmWQNY4oggXk6hkCi1zxeNsTeHH+3GFW6rjiVMlAiB2DrLEmeznH7mLxbi0s+vTlhq
         zXQGaJYNIBLdfsoj+IYSfd2Qy83IWxy8kKhWhRvUxHnTBGtFo/DHtGow/t3g08lTUVYv
         whAw==
X-Gm-Message-State: AOAM533+p/U9lCHNtPeL+diDmG277dx6wVrBZrGABcS6n0qW92Q3izbT
        4itqtKfTqekF+IYuZJ4zAg==
X-Google-Smtp-Source: ABdhPJwSvKg6NdOMWBJFDdtLoIBBQirxE56XmsbpySMSeXjq7HMZUZDlUFltYh7Kr/XklHJvznIbgg==
X-Received: by 2002:a05:6808:11c4:b0:2d9:c395:f15e with SMTP id p4-20020a05680811c400b002d9c395f15emr11975287oiv.47.1652135776986;
        Mon, 09 May 2022 15:36:16 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g4-20020a9d6184000000b0060603221250sm5139319otk.32.2022.05.09.15.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 15:36:16 -0700 (PDT)
Received: (nullmailer pid 335215 invoked by uid 1000);
        Mon, 09 May 2022 22:36:15 -0000
Date:   Mon, 9 May 2022 17:36:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     allen-kh.cheng@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        chun-jie.chen@mediatek.com, devicetree@vger.kernel.org,
        ikjn@chromium.org, krzk+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, matthias.bgg@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: ARM: Mediatek: Remove msdc binding
 of mt8192 clock
Message-ID: <YnmXX0DldjhmbjY3@robh.at.kernel.org>
References: <YnGjScfQA9axBYBO@robh.at.kernel.org>
 <20220505053111.13924-1-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505053111.13924-1-miles.chen@mediatek.com>
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

On Thu, May 05, 2022 at 01:31:11PM +0800, Miles Chen wrote:
> Hi Rob,
> 
> >> From: Matthias Brugger <matthias.bgg@gmail.com>
> >> 
> >> The msdc gate is part of the MMC driver. Delete the binding description
> >> of this node.
> > 
> >An ABI break is okay because ...?
> 
> Sorry for that, 
> 
> If the mediatek,mt8192-msdc part is removed from the driver, 

That's an ABI break too. You just need to explain why as Matthias did in 
the commit message if the ABI break is okay.

> Is it ok to keep "mediatek,mt8192-msdc" in the binding document? or 
> we should add '# deprecated' to "mediatek,mt8192-msdc" and keep the example.

We do that sometimes, but depends on the situation.

Rob
