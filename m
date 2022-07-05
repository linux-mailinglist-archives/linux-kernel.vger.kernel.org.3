Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA55567860
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 22:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiGEU3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 16:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiGEU3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 16:29:44 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B191AD89;
        Tue,  5 Jul 2022 13:29:44 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id h85so12257370iof.4;
        Tue, 05 Jul 2022 13:29:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+OUbKOKgcRiIQoZ8IC81Q0FUvPkjDzo8f60mYmsPN80=;
        b=QnVd3vFU67z/4C9HNHjKw+wYnF82v5hDCgSQesLhsiIav3e3oJML71NfPy//NFl93P
         6dvHxeKFJ25/6M9feL8oL+9mVtRJ1Pjda3cmBwLLWq5Ef4DGtYl6Z8UbEJVDYSNyrGO/
         0+oFRjtBPm1V6o3LtiMvA9t1ny2VqbJOC3kQIH0aFWUKK+tnwnaQ0QB9igMdxd3O1ADH
         L6H/QWx02xTctkHPstnBNfguuG5dvswpvaXI9mZ2KCbmq0BKV/+EX2fbQ1y6vL+cMhJY
         qQqBzQubZIurtAt7fy+tKPveHP6yOxrop2Q5HZBehqRjfkvhehK/uivIol0ZN0GMBLTt
         rd2w==
X-Gm-Message-State: AJIora8sQHW7XWfkcjfMMcB3YIyrNpaLUog9MloIbm4uteWuJspl+0kP
        axPWtpnn915LvrrUkIK4fQ==
X-Google-Smtp-Source: AGRyM1u9597zu/p+HiUCckJAq7fdPv0+gO/EYPUZM8rYPEGth3tu2MAgLvBw06NsgKzFmdKA4urzTw==
X-Received: by 2002:a05:6638:16cb:b0:33e:9db7:9359 with SMTP id g11-20020a05663816cb00b0033e9db79359mr15399804jat.112.1657052983590;
        Tue, 05 Jul 2022 13:29:43 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id w21-20020a029695000000b00339c4e447e2sm14886585jai.151.2022.07.05.13.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 13:29:43 -0700 (PDT)
Received: (nullmailer pid 2571463 invoked by uid 1000);
        Tue, 05 Jul 2022 20:29:41 -0000
Date:   Tue, 5 Jul 2022 14:29:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: sunxi: Default to the full MBUS
 binding
Message-ID: <20220705202941.GA2571429-robh@kernel.org>
References: <20220702042447.26734-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220702042447.26734-1-samuel@sholland.org>
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

On Fri, 01 Jul 2022 23:24:46 -0500, Samuel Holland wrote:
> Some older SoCs use a deprecated MBUS binding with some clocks missing.
> Currently, new SoCs must opt in to the complete binding. This should be
> the default, so new SoCs do not accidentally use the deprecated version.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  .../arm/sunxi/allwinner,sun4i-a10-mbus.yaml        | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
