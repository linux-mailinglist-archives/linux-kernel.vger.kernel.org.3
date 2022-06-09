Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692B6545086
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344379AbiFIPSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344427AbiFIPSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:18:36 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CDD49F8D;
        Thu,  9 Jun 2022 08:18:34 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id f12so19004074ilj.1;
        Thu, 09 Jun 2022 08:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1gmOzw7Uedt/uo+o3zQbOPqoyD7maSwLjV34dKxt390=;
        b=DVVyMZtAgFeYA1laaeWqDoUqnDskeZJiVWdJIaXh1BDs3ug37NAaU9tpbmZ5+edhga
         lbHLSjmWDEaJbOjO/XpBgy23bBJ8PG3Lf1n1YxovaZXmDCgInjF+dVrdQutnr6L/JE7m
         0RRkg5poIqsivQakJGbTXHkh0woONf+fa6+HG1cPp81ERCARKc5/kZ2ghHMUJq6OJBff
         tCiWSw5e0qceOBvxJ5XRqmP1sm4KBrCKj/tQA4SSHMD+tB06MIPLE7JQwHrHGYOF37cl
         3OHJlV8PyVzRaGOArJfoQY+RgZIF5AAbfHbuzEvxY8ZS5ZcSUjLXCkn7+xeTE3q+Outb
         4FPQ==
X-Gm-Message-State: AOAM533VW43mXMCV3qe/KTOo9KiTv98DLl6vojGUsGRSPEBfKjr7K0ci
        yKP/f+CXdHEIMWPdaXb7UQ==
X-Google-Smtp-Source: ABdhPJxtMHHVPS+lHxLQJsKydz9fs+sGTPoA7UIGtpxvKHKRyH4605h3UklPDvAcj26MB7xJGqasng==
X-Received: by 2002:a05:6e02:5cd:b0:2d3:ad26:4b53 with SMTP id l13-20020a056e0205cd00b002d3ad264b53mr21562060ils.117.1654787914056;
        Thu, 09 Jun 2022 08:18:34 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id i2-20020a92c942000000b002d4070b07b7sm8151707ilq.59.2022.06.09.08.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 08:18:33 -0700 (PDT)
Received: (nullmailer pid 3813967 invoked by uid 1000);
        Thu, 09 Jun 2022 15:18:31 -0000
Date:   Thu, 9 Jun 2022 09:18:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        arm@kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 02/48] dt-bindings: input: gpio-keys: reference
 input.yaml and document properties
Message-ID: <20220609151831.GA3813893-robh@kernel.org>
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
 <20220609113911.380368-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609113911.380368-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 09 Jun 2022 13:39:04 +0200, Krzysztof Kozlowski wrote:
> The original text bindings documented "autorepeat" and "label"
> properties (in the device node, beside the nodes with keys).  DTS use
> also poll-interval.  Reference the input.yaml to get these top-level
> properties.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/input/gpio-keys.yaml  | 32 +++++++++++--------
>  1 file changed, 19 insertions(+), 13 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
