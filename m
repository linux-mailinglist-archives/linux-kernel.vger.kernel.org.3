Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A60F4AFECD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 21:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbiBIU67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 15:58:59 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbiBIU6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:58:54 -0500
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519F9C03C189;
        Wed,  9 Feb 2022 12:58:56 -0800 (PST)
Received: by mail-oo1-f48.google.com with SMTP id u47-20020a4a9732000000b00316d0257de0so3927456ooi.7;
        Wed, 09 Feb 2022 12:58:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fu+WPKnKvH/YrQ0Pc+0sueowaG4ZFv+jBBVUspqnCJ0=;
        b=slxnEM5fkPZ1mrUOTlRxs1ppgT4SM3BEYaLzWakcVQuegOR9AjuO9/jpvS8JUGr7Vu
         FCAxRmTOGsQv/0/Os7FzHZIEShYLp8ojhfB6mRvqj0V4MqBjI1sauu3NMLEsqkRb/Ov+
         Q3/Ex9NoISdlEgJUQy9GoKXABlmzZBO7EHuZWnBQpRovW78Jrest4CUc/2NkRnCyJ/0S
         8dPfcUxUjBV6xbxY4hV2I2EOIBh4sVtdxaqeTbNYN6F5Z6TuN0CXGP9i9uxWBMAsqpwd
         9zQo9HZcCLtXgVmvBXiObbmIkswTJr/Y06rA+BfkB+DFRfhui1ENPTndjydrh9jZMyVn
         eS9Q==
X-Gm-Message-State: AOAM531i5j+KhPyw7WxVJn1fvi6ZjJUi99g0OhsJ7gsVTnJbBZzjtioq
        fPf3gTLO3C/B/0B1Mjzwhw==
X-Google-Smtp-Source: ABdhPJyhzLC/Hx1k7zcA8ZuuF1/zA7kovLAhGq/6WJJUVSOUk20OkhdGNpYdCUPuQeWWYyq2vJXejw==
X-Received: by 2002:a05:6820:514:: with SMTP id m20mr1681984ooj.28.1644440335643;
        Wed, 09 Feb 2022 12:58:55 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m5sm7052127otk.78.2022.02.09.12.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 12:58:54 -0800 (PST)
Received: (nullmailer pid 898525 invoked by uid 1000);
        Wed, 09 Feb 2022 20:58:54 -0000
Date:   Wed, 9 Feb 2022 14:58:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: Re: [PATCH v2 3/6] ASoC: dt-bindings: samsung,arndale: document
 ALC5631
Message-ID: <YgQrDi/gwyEYEZZ5@robh.at.kernel.org>
References: <20220129122357.45545-1-krzysztof.kozlowski@canonical.com>
 <20220129122430.45694-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129122430.45694-2-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jan 2022 13:24:27 +0100, Krzysztof Kozlowski wrote:
> The Arndale audio complex might come with ALC5631 which is compatible
> with RT5631.  Document the compatible since it is used in Linux kernel
> sources.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  Documentation/devicetree/bindings/sound/samsung,arndale.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
