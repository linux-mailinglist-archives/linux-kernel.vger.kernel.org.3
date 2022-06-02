Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBF153BB61
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 17:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236383AbiFBPIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 11:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236374AbiFBPIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 11:08:35 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F607694AF;
        Thu,  2 Jun 2022 08:08:35 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-f2a4c51c45so7066469fac.9;
        Thu, 02 Jun 2022 08:08:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OUwSxoOwcEaIjyrHRa2+WezhILR4wTzd8pNvmgqO9d8=;
        b=ex8jgV23fFKfvXw35xtHOWpWmzoDlKQQsvRffXtuIUSu+IMOj9ksO1OVCPZ9JBBv0U
         Gw/IayJZwcpUALQgd2GuWueVEtwqpMQhnQOlrjG2uZpdRVJfFdWgxD2w/8+ra9MIJ7Gf
         6ZlxYUtymW6IA+pwXpwkgDdJaOCJQ3wxYqFDqFvCzqXcmms4N2uvAWxdeVYDOFS+/sem
         w1iD2UysEmn8qZLjh4fU8Naj3vwpNkZp6eszImWrxVbLAIs2I0bLQcbqKS4+iRX4+wxj
         QYHSwEw5s77jIZwM0ttySfU/bo71PV3xr1ozTMMUvblN7rgFHw/3NFTMWJeEFq2XlFxR
         gjiQ==
X-Gm-Message-State: AOAM533zUKYz9FNxlrKKyAlJuPckzLCFQ9GpyO7zmCQ/tJLm05XnJP6R
        dqAeRB4+MUezf669olBArQ==
X-Google-Smtp-Source: ABdhPJwTdgjdDnA+5v6Y9CtE8w0PKrFsdD9tVYp5ME1xfF2mCS5P8rTTHo6sGULXKENTH0KKZpx/Ew==
X-Received: by 2002:a05:6870:b609:b0:f2:74e7:9bf1 with SMTP id cm9-20020a056870b60900b000f274e79bf1mr20018480oab.141.1654182514305;
        Thu, 02 Jun 2022 08:08:34 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n25-20020a056870241900b000f309d52933sm2146679oap.47.2022.06.02.08.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 08:08:33 -0700 (PDT)
Received: (nullmailer pid 2329687 invoked by uid 1000);
        Thu, 02 Jun 2022 15:08:33 -0000
Date:   Thu, 2 Jun 2022 10:08:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: add MT8365 SoC binding
Message-ID: <20220602150833.GA2329628-robh@kernel.org>
References: <20220530205038.917431-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530205038.917431-1-fparent@baylibre.com>
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

On Mon, 30 May 2022 22:50:37 +0200, Fabien Parent wrote:
> Add binding documentation for the MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
> v2: fix clock description (five -> three)
> 
>  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
