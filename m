Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B260F4C307B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbiBXP4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236665AbiBXP4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:56:34 -0500
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF392465D6;
        Thu, 24 Feb 2022 07:56:03 -0800 (PST)
Received: by mail-oi1-f180.google.com with SMTP id j24so2971062oii.11;
        Thu, 24 Feb 2022 07:56:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SMVouXiosKn6ny3HfwSsMDf1jN2E26cY3uzaoXTs+S8=;
        b=CMyPSTEYVPtaFYIQKIvmzPxaO8iAheDtHOjX76SMPRdtRwD0KHcgfZcxLoma7U1i/d
         0mdOVKlwvvMX8CbP6nDHYNzmwePlyKZC6Z/tGEfviNPzX470guif6V/FLFLtvR4IwT/y
         1obFWzAjfiJltDhnxGyNAFGx8/lYf9LsGPyKDe9zawqdCRYwdx1l65wLH7R8ZkaA8Tuo
         0tf5zalCtflirFhAX1jWKz5yiplh8bFJMdoUJi5wRIdCWifwWrc3Ud5FAP2OB7RsPqE7
         L9+JZUl6zd349bFGmWKt96Y+AVSfo+IAE1E6V4i4py8NzvtPIm/ql4QODjBCpcyDoAhj
         T5/w==
X-Gm-Message-State: AOAM532nEPv/uh70MdS50VbIMgyjjYGVgTLE4xbRfXzj0akAP4HQGawW
        SxJXgBLrLS3aBGWldfbfNqYYlg0ICw==
X-Google-Smtp-Source: ABdhPJzGQRqZXE/eFhGCyySrKwOqg3RMp89A7Vhidvx5ghGPBmdHjS+JrRTInXrcvk4Qs4h0bm+ZYQ==
X-Received: by 2002:a05:6808:16a5:b0:2d3:a8e8:bc2c with SMTP id bb37-20020a05680816a500b002d3a8e8bc2cmr1705247oib.59.1645718162577;
        Thu, 24 Feb 2022 07:56:02 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w18sm1355281otm.45.2022.02.24.07.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 07:55:58 -0800 (PST)
Received: (nullmailer pid 3143263 invoked by uid 1000);
        Thu, 24 Feb 2022 15:55:57 -0000
Date:   Thu, 24 Feb 2022 09:55:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: example: Extend with typical case
 (int-array and disallowed prop)
Message-ID: <YheqjZQHq0T/RSIz@robh.at.kernel.org>
References: <20220223073547.8746-1-krzysztof.kozlowski@canonical.com>
 <20220223073547.8746-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223073547.8746-2-krzysztof.kozlowski@canonical.com>
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

On Wed, 23 Feb 2022 08:35:47 +0100, Krzysztof Kozlowski wrote:
> Extend the example with:
>  - an array where each element has constraints (min/max value),
>  - property not allowed in case of different compatible.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../devicetree/bindings/example-schema.yaml        | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Applied, thanks!
