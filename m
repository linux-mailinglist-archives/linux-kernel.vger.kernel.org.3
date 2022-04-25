Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1458D50EBA1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 00:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbiDYWYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 18:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343644AbiDYWCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 18:02:02 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B727A3298E;
        Mon, 25 Apr 2022 14:58:57 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id r85so18697902oie.7;
        Mon, 25 Apr 2022 14:58:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=giYEePQGwfyo/twGmZzP8uZHE1niv7Jue0jlfyNBG/w=;
        b=iR9haEPnoDiiq0N/p9KzUVlr2hzsBKtv3XMA6Q3WlAR89IE/49doHEIKCuGo2GGf+d
         207bnxSGrZx/k0YPDeTv/9X/6AdFEt6npbZ05dakhZ/d61sfqNcZbjRr6xuwqj93OghR
         AhnV8lLKse8CyvFPfUZMF185GWAwnfZ/gOgr5I5CNioXiovwzY0pkA7ZRprrThgEdbpg
         ujlPQHCsFkVm3Nq6lwF9nzgliXC68GNtS3GQuCHAQgWpPkOFBnrtyfo22wUfPMCTuhle
         jA1N1AGlL2DHQGHltecG9YHQQMAyDsDcsY34DZe+2AVv+GRF4wkCt+s2/ls2mYmIMhYJ
         nwHw==
X-Gm-Message-State: AOAM5307F4V8fEX7CdIZRJlNB2y2GZxneO9w7HwgR+PAx54cM9Z1hg5o
        xDWvoqwcG8Aqi6+k6ibtLA==
X-Google-Smtp-Source: ABdhPJw07VATwV9Pi6FNS0BWGKvJTnXzmA3vvTfsUF3ThnLFDbsVteQpIwHVnR4kBKSYrwLDl8g+AA==
X-Received: by 2002:aca:6c5:0:b0:325:5bce:bbc1 with SMTP id 188-20020aca06c5000000b003255bcebbc1mr84990oig.221.1650923937051;
        Mon, 25 Apr 2022 14:58:57 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c25-20020a0568301af900b0060579b0abe2sm4225067otd.61.2022.04.25.14.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 14:58:56 -0700 (PDT)
Received: (nullmailer pid 367439 invoked by uid 1000);
        Mon, 25 Apr 2022 21:58:55 -0000
Date:   Mon, 25 Apr 2022 16:58:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabio Baltieri <fabiobaltieri@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        chrome-platform@lists.linux.dev, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] dt-bindings: update google,cros-ec-pwm
 documentation
Message-ID: <YmcZn8mWQveT5HzT@robh.at.kernel.org>
References: <20220420141556.681212-1-fabiobaltieri@chromium.org>
 <20220420141556.681212-4-fabiobaltieri@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420141556.681212-4-fabiobaltieri@chromium.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 02:15:55PM +0000, Fabio Baltieri wrote:
> Update google,cros-ec-pwm node documentation to mention the
> google,cros-ec-pwm-type compatible.

It would be good if the subject provided some clue what the update is. 
Every change is an update. And all bindings are 'documentation' so 
that can be dropped.

> 
> Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
> ---
>  .../devicetree/bindings/pwm/google,cros-ec-pwm.yaml      | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

In any case,

Reviewed-by: Rob Herring <robh@kernel.org>

