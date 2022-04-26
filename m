Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0086510BF5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 00:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355808AbiDZWYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 18:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiDZWYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 18:24:44 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703E51EC6A;
        Tue, 26 Apr 2022 15:21:36 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id a10so154746oif.9;
        Tue, 26 Apr 2022 15:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=agLHP2TKFs48uHiP3cBZD7bLEy6jYHHEo7LjcKKNXyg=;
        b=piDUYKNHRzRQYV/xXH/XH8/9u0K9HpqLcISWS7DbepP+YJmiLCqmKMhMEjAiTWv5N8
         hT/AkvpxblsZksCimFAc0ClTWSLFFG+fSps0jzMrqirisb5oTzu3y/XcPgzy4YL5K1lB
         H51+T5dWXD4IVcPcYovQgcmAw/0izMzwUMkVT5lWR89YkGkzo5LNgXXq4FfsqLIkBLS0
         PnKp/b5Jo0Sx4HDRcgBL7qXewhqZDtt/u+Kumb3l7EAtM3YpLJSKqWTl/GOLM+NX9W2H
         b/BUkIrRNejPWZkRCbUdwGe4hwDarzqlRxfxVnGuGmhkO6orYqAtCEsrnuJjE5ybQ95E
         BzXg==
X-Gm-Message-State: AOAM533jPzr+e3pll3DyNJOOaZ3v5gs5M/lQ8r7kafTzgWcEFZCFy2cU
        LicE5l48CiLv1FnReJ3Kug==
X-Google-Smtp-Source: ABdhPJwKLJU+VvRGVp0+qY02rJ4fMxZ2WxljQFnXe0s3y0Oh5C9H0dmsoQfKN51lc0Ia08pxwGbPKg==
X-Received: by 2002:a05:6808:118d:b0:2f9:ee54:8d05 with SMTP id j13-20020a056808118d00b002f9ee548d05mr16031561oil.273.1651011695731;
        Tue, 26 Apr 2022 15:21:35 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z1-20020a056830128100b0060542867875sm5412410otp.70.2022.04.26.15.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 15:21:35 -0700 (PDT)
Received: (nullmailer pid 2636304 invoked by uid 1000);
        Tue, 26 Apr 2022 22:21:34 -0000
Date:   Tue, 26 Apr 2022 17:21:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: soc: qcom: convert GLINK binding to yaml
Message-ID: <YmhwbsC2Xi+PFePi@robh.at.kernel.org>
References: <20220424101637.20721-1-david@ixit.cz>
 <184784e4-0a85-c0bb-fdda-b8c41d8abc0f@linaro.org>
 <ee77216c-c319-7a68-7f08-d5f845efa1e2@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee77216c-c319-7a68-7f08-d5f845efa1e2@ixit.cz>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 03:52:37PM +0200, David Heidelberg wrote:
> Yeah, it seems there are several mistakes, I thought it was in better shape
> (4 months passed.. :( ).
> 
> About testing, currently I have limited ability since broken libfdt, which
> dt-schema use, doesn't work on new py3.10.

I'm on 3.10 now and don't see any issues. You need 'pylibfdt' from PyPI.

Rob
