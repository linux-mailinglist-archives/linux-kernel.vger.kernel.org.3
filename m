Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E5853DE5F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 23:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347736AbiFEVYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 17:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347602AbiFEVYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 17:24:38 -0400
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9BB4D24D;
        Sun,  5 Jun 2022 14:24:37 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id el14so9178634qvb.7;
        Sun, 05 Jun 2022 14:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z+GuGqR7SMRgL3FIxjUfCzVDzSWnTfmfRcjXNbcQEf8=;
        b=3VW9aAo/aMufg00wYea5nNQ3OGjHpfriTJ/UhRJiiaCDPprD/U6lFHwr4wlxS4mII+
         SZ880UWTGUbAVpt6wS4N1yf7YEZz87xNrFeXJVvxBDviMNmNit8KA36npxfZhh2aHg2K
         mEUXWqzr/mgngHeczTD91AMdfW1G2/etD/+CsVtbqhKsls+jboOZIxgd8Mcnv3kEQ4k/
         Ce4YjoFKR2IZfXpu8XgbzDp9djULXeQOqtZeR8MzwwNhr/DvMGFLPgbM2KBosCPrFog0
         0q8sCZJ0xeY3cOXPsT0TSR7Yg7MMGP/QILCP+zftoBfB7x2Whyw2VZNJLsPHHeDN7nI6
         Av8A==
X-Gm-Message-State: AOAM532pJAfCHNYEmKFxY/t01qz1gQQeveBPzgKcSoVirdTyubSt0Ihs
        d7BAAoJPFp01roooeqy6DQ==
X-Google-Smtp-Source: ABdhPJyEy06cBlR2LsLnQZtKuMJ5OiE7JRsVL87WfZ++QriKYhdev4cJdD//wiafYRRTGnQsE1QRAw==
X-Received: by 2002:a05:6214:2b9e:b0:464:62bb:c3c1 with SMTP id kr30-20020a0562142b9e00b0046462bbc3c1mr15660790qvb.27.1654464276166;
        Sun, 05 Jun 2022 14:24:36 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:ac97:ac63:b5fd:aa9:8d74:9989])
        by smtp.gmail.com with ESMTPSA id o18-20020a05620a2a1200b006a6ad90a117sm453749qkp.105.2022.06.05.14.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 14:24:35 -0700 (PDT)
Received: (nullmailer pid 3543478 invoked by uid 1000);
        Sun, 05 Jun 2022 21:24:33 -0000
Date:   Sun, 5 Jun 2022 16:24:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-clk@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: clock: fixed-factor: Drop Allwinner A10
 compatible
Message-ID: <20220605212433.GA3543396-robh@kernel.org>
References: <20220531051742.43273-1-samuel@sholland.org>
 <20220531051742.43273-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531051742.43273-2-samuel@sholland.org>
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

On Tue, 31 May 2022 00:17:42 -0500, Samuel Holland wrote:
> This compatible is part of the legacy sunxi clock support, and has not
> been used since commit 6b48644b1d29 ("ARM: gr8: Convert to CCU") in
> October 2016. Now that the code for this compatible has been removed,
> let's drop the compatible.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
