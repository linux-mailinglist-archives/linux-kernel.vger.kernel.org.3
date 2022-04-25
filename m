Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E10050E58D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243372AbiDYQ0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243288AbiDYQ0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:26:11 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006A878FE6;
        Mon, 25 Apr 2022 09:23:07 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id 12so17627481oix.12;
        Mon, 25 Apr 2022 09:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lDcl2sN0B3cO0WiThw5+H3UGuxXX8o6v8eDh0eQ4Ajs=;
        b=vKaRgmxxmVAHv3+DyNz16k6rkKz7otfpDM7zQVHdF4L3ziqTFZ/Rrke43Mz5Mmjfmz
         6hSxLy1Zq3S/9qBsspD/U62s0aQzD8qiY1zYTQAhPD6LaAHfMDi9OZwQgYrJ0hqVbrI3
         f7y0GE5jVLU3gjMVGzylubvV/qU3XBJyDquv5HCW6bSB4p8bcIxfYwamu3afpNcuFprm
         OeC0zwPzt0Bz938cU2Z7IN7MeXKnRCCnjqoNTHoyIq7ESLgC9mj68U8NMFdRmwwoiYSr
         Gd5pNcVGc/t2I+hxnGNhkhYAn65ZnSv4f+YylcyLtbm7fFrjlY3sCOJglbnC8wvnWzo6
         Ux3w==
X-Gm-Message-State: AOAM5321vJy2ZVcRAQ05BTj+5SVaTxwuAMdnIXFzTkuBghlyyI4D1tpJ
        FSwIVi7OTiCsjK6YK6R1GgT+dSZtFw==
X-Google-Smtp-Source: ABdhPJwJd2i2Q5DYrFdQU9C1yznqID18RyIZswfIlgeuRnWOJhp70Mxhw7j3awEePV0b/SsVIw8ZRQ==
X-Received: by 2002:a05:6808:1b1f:b0:322:fb7a:8dbf with SMTP id bx31-20020a0568081b1f00b00322fb7a8dbfmr8405493oib.79.1650903787320;
        Mon, 25 Apr 2022 09:23:07 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bn41-20020a056808232900b003222f6e2ae8sm3751142oib.29.2022.04.25.09.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 09:23:06 -0700 (PDT)
Received: (nullmailer pid 4000741 invoked by uid 1000);
        Mon, 25 Apr 2022 16:23:06 -0000
Date:   Mon, 25 Apr 2022 11:23:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: ti-dac5571: Add ti,dac121c081
Message-ID: <YmbK6nxoUuJAGfRE@robh.at.kernel.org>
References: <90204a08-0c88-6c21-1492-6a5330184096@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90204a08-0c88-6c21-1492-6a5330184096@axentia.se>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022 08:02:25 +0200, Peter Rosin wrote:
> It works much the same as ti,dac7571, so it fits in the "family" even
> if the name is a little bit different.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>   Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
