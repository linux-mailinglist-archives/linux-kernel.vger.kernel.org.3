Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCB3546C3A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 20:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348219AbiFJST0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 14:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235665AbiFJSTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:19:23 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4F41D30D9;
        Fri, 10 Jun 2022 11:19:20 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id i16so6391175ioa.6;
        Fri, 10 Jun 2022 11:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dUVF+4savVVo3Zk/eVEnxhnMTrHMPg1cr6NzLhj4vPE=;
        b=oIP4x508sDuQpQW6rJrllz0KO6ahsC+mnye/c6DrG1FIF7L4Ko/MgSlnRWyjNi2xZE
         xR6fXyKa2KCy6n+Gin5Ith99KwZYaQBlfynvPnZ4Gbmkq3YVJ7d4ewGfgxVeVbhQhO8s
         d2bbW6Xs3fIWMRnBx88vJ1rPjpUtccjKOuafbuA5TerwrdroYHUZ74r7HQ5OgEwxhRHf
         PVbEyLZ4urdB4qr1QZae2fKg8JBQvb1ZXeKJtxwbs0CYZQ9iPuQZ7tB22omu5o/eOzlR
         e+60X523J+mdOkYeChtP9ZfUUG+5DGGFspODt2sVYOc2d80BpkFwe1Rgp3wqzGo463WA
         kmEQ==
X-Gm-Message-State: AOAM533XIpqwUjHcVnyUMb4Q1V+tvSaeH36Q5oS0JYqyP2SvEVO/Dl+W
        3FsA/+NX4O7sDOtGVCXaOg==
X-Google-Smtp-Source: ABdhPJxNF8rT+2V+EVqFx6lCZs1qfmv2YXD719wGMasOLQ6Bqd8aEkKG60Ov+gx5p10DfI9FIfzDnQ==
X-Received: by 2002:a05:6602:168d:b0:669:8613:abd0 with SMTP id s13-20020a056602168d00b006698613abd0mr8616182iow.48.1654885159997;
        Fri, 10 Jun 2022 11:19:19 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id g23-20020a02bb97000000b0032e1e0ac289sm11301883jan.8.2022.06.10.11.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 11:19:19 -0700 (PDT)
Received: (nullmailer pid 1935336 invoked by uid 1000);
        Fri, 10 Jun 2022 18:19:17 -0000
Date:   Fri, 10 Jun 2022 12:19:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: pinctrl: ralink: Fix 'enum' lists with
 duplicate entries
Message-ID: <20220610181917.GA1935073-robh@kernel.org>
References: <20220606212239.1360877-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606212239.1360877-1-robh@kernel.org>
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

On Mon, 06 Jun 2022 16:22:39 -0500, Rob Herring wrote:
> There's no reason to list the same value twice in an 'enum'. This was fixed
> treewide in commit c3b006819426 ("dt-bindings: Fix 'enum' lists with
> duplicate entries"), but this one got added in the merge window.
> 
> A meta-schema change will catch future cases.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../pinctrl/ralink,mt7620-pinctrl.yaml        | 26 +++++++++++-------
>  .../pinctrl/ralink,rt305x-pinctrl.yaml        | 27 +++++++++----------
>  2 files changed, 28 insertions(+), 25 deletions(-)
> 

Applied, thanks!
