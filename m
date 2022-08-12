Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89E159149B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 19:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239468AbiHLREh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 13:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239385AbiHLREd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 13:04:33 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F074FB14E1;
        Fri, 12 Aug 2022 10:04:31 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id z145so1270481iof.9;
        Fri, 12 Aug 2022 10:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=9EVAY3341uRLDeQR3qbIaskvaBL1Vga+F7BkTtexRf0=;
        b=1Cup51pWqdAnzuD9uoCmwq6WUJqayn4R+94p1q7XLw5uLYqWLYl53oQKfdzOgP6qUB
         n/638Es5U/WiK1apxhysx7RDznyhKQn7MSmoDbachBFW1xv7XFuGjeOOlRx6YJ2kL5lK
         0/f88H4l+gO32ffLISsXGRJGiNqrfuLyWwlKsoxuW1vYLKfdtVaxR+kQ8ix7YYlpf20z
         Vt2OT6tuCt4vS/6LvPitOFXSJLPLaHUN/JRRaiXW6Kctau2g66pMSfsNgfjTJDeHJuFE
         RZnrU2kXCCQIK6LkAf8i6JaO0Ne2X2jVdZGEgG93FTEz/Y+OIKunMYpvTwQ7ZqwpoGly
         1naA==
X-Gm-Message-State: ACgBeo2OocGITP5u3V4QduT7YQ/uLieeXenUxGNQ6ASl3UHuS7ERwHnX
        0rdtjvxH/zcVjWJobt3rvqenp3y1Vg==
X-Google-Smtp-Source: AA6agR5v+3t0CqUnOx6AXsLMKMAa3BpiCFpKQyZHTgEWg9cMTJhmIuX1LrV/APLXcVPbjp0A9Vsnxg==
X-Received: by 2002:a02:a141:0:b0:343:58ce:4d7f with SMTP id m1-20020a02a141000000b0034358ce4d7fmr2341486jah.223.1660323871161;
        Fri, 12 Aug 2022 10:04:31 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id e47-20020a026d6f000000b003434de98f1asm99893jaf.28.2022.08.12.10.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 10:04:30 -0700 (PDT)
Received: (nullmailer pid 329197 invoked by uid 1000);
        Fri, 12 Aug 2022 17:04:28 -0000
Date:   Fri, 12 Aug 2022 11:04:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, Vaishnav Achath <vaishnav.a@ti.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dt-bindings: Drop Pratyush Yadav
Message-ID: <20220812170428.GA328905-robh@kernel.org>
References: <20220811063826.7620-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811063826.7620-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 11 Aug 2022 09:38:26 +0300, Krzysztof Kozlowski wrote:
> Emails to Pratyush Yadav bounce ("550 Invalid recipient").  Generic SPI
> properties should be maintained by subsystem maintainer (Mark).  Add
> recent contributor Vaishnav Achath to the Cadence SPI bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Vaishnav Achath, are you ok with that?
> ---
>  .../devicetree/bindings/spi/cdns,qspi-nor-peripheral-props.yaml | 2 +-
>  Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml        | 2 +-
>  Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
