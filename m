Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A630A4C3578
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbiBXTNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 14:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbiBXTNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:13:42 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E405B1B45E0;
        Thu, 24 Feb 2022 11:13:09 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id j2so4324349oie.7;
        Thu, 24 Feb 2022 11:13:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gO8mKD6oJQ6SsGZ1I3LRYKRxuk0QWc4mtMbDlxXHmEM=;
        b=pOutkRGX+/pdJLCYtne1o8lIgMRc97Ah3bm5Nd+IgYYrGB5QQfcMWCA49Zy5dF25pG
         uZzdb9/m5Ee2lq6x44+45J12TC6LiG7EyCGcNFZW1Ctnll+kgHV75Eb4/Xq8jfDCMuXu
         TF4ZanIZZUjVwYrStQdgnOEyhiFH5f89bzGZJ0R3Sio5LFWJXt2JZ7HdKJDbz9HuPi0t
         1Gp257ecbZQ1OiIadeOpRDuK8zGOBaQzKQbn5GJ/sI6Odq3/YcybaGfQ24VI8vWnRbsm
         zCftI8MxhA337ghZD3bWebQLPWBpwpAiIRF6DL8jyHYIp+wshihWM9qnwH85Qr6a5qEb
         OoHw==
X-Gm-Message-State: AOAM530bUFrufUBEv2aBI7O+LpC+OolmdwyUIh54nATanNFTKlgzMFM/
        59xLDV7d7IBZIh/IHnFF0g==
X-Google-Smtp-Source: ABdhPJxSE2V4KzoGxO8uB42dcagdW3rigyxskipbEsYfE+yS/5sBDwcT03JhXoRbpihZKx8vJtrYDg==
X-Received: by 2002:a05:6870:1114:b0:d6:d4df:ce9c with SMTP id 20-20020a056870111400b000d6d4dfce9cmr1396319oaf.19.1645729989268;
        Thu, 24 Feb 2022 11:13:09 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 9-20020a9d0c09000000b005afabd759cfsm76526otr.65.2022.02.24.11.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 11:13:08 -0800 (PST)
Received: (nullmailer pid 3424377 invoked by uid 1000);
        Thu, 24 Feb 2022 19:13:07 -0000
Date:   Thu, 24 Feb 2022 13:13:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marcello Sylvester Bauer <sylv@sylv.io>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: vendor-prefixes: add Vicor
 Corporation
Message-ID: <YhfYw/Q6v3K1uCvV@robh.at.kernel.org>
References: <cover.1645435888.git.sylv@sylv.io>
 <5b487a0b68d58b64022662f1e527ac80a6ad81ef.1645435888.git.sylv@sylv.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b487a0b68d58b64022662f1e527ac80a6ad81ef.1645435888.git.sylv@sylv.io>
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

On Mon, 21 Feb 2022 10:42:04 +0100, Marcello Sylvester Bauer wrote:
> Add vendor prefix for Vicor Corporation.
> 
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
