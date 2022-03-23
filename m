Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881624E57F4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 18:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343859AbiCWR5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 13:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244232AbiCWR5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 13:57:12 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB98B7FC;
        Wed, 23 Mar 2022 10:55:42 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-dda559a410so2477447fac.3;
        Wed, 23 Mar 2022 10:55:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G9nuSpDKEgw7Nx+8QlyFC8zKvObs8NIU6xkxgQTrJ2g=;
        b=XXO/uAKyVHHA7PFX99D/CLVJqJyJGk7Bj7wYMY34evQinv5mBbaxZOqAZUakV3CqQ3
         rojSbGCUhvYUEHr7eyO4wpfRDKxlDOWHARLXLy6MCnWsOcDMIH9nTXjD8H63Y+bGWbc1
         qYzvfJMSHeZ4JImhElaJD9NM+7UPakfbCuIlWgecbCvvSkmob5kN9sxUvjQH+JFgT1Yl
         qDqBFmB588rTgNtNGFD+1TqYMCVLbTgrVOM1So7snlQD7WIc6eq9a2Go86S8r5RECGyu
         BJLdfBncYWlLPc6pVn1m2fZ/sywGwfM4/Y5zT892X6G9sg+j4msocoKi7UAYbGLolvC7
         Nruw==
X-Gm-Message-State: AOAM532TC4uWzrtxZz/UEs6Iy4obEkW5dOM/jgiE37N7vdyfpJnkbr5R
        VYqMsMukCNwEHiEpVaxOPg==
X-Google-Smtp-Source: ABdhPJwaB9MUC7QokIP99uc9L6Wq+ettpIdTaw8OrMyNbqh3zU3dXgYv87+41FqCM7ufTf7BjMESnw==
X-Received: by 2002:a05:6870:95a4:b0:d7:18b5:f927 with SMTP id k36-20020a05687095a400b000d718b5f927mr559577oao.45.1648058141804;
        Wed, 23 Mar 2022 10:55:41 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z82-20020aca3355000000b002ef73b018absm234689oiz.9.2022.03.23.10.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 10:55:41 -0700 (PDT)
Received: (nullmailer pid 163348 invoked by uid 1000);
        Wed, 23 Mar 2022 17:55:40 -0000
Date:   Wed, 23 Mar 2022 12:55:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yannick Brosseau <yannick.brosseau@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] clk: stm32: Fix typo in comment
Message-ID: <YjtfHEh8wUe0FZul@robh.at.kernel.org>
References: <20220314012634.1176231-1-yannick.brosseau@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314012634.1176231-1-yannick.brosseau@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Mar 2022 21:26:33 -0400, Yannick Brosseau wrote:
> s/Documentatoin/Documentation/ in path to the doc file
> 
> Signed-off-by: Yannick Brosseau <yannick.brosseau@gmail.com>
> ---
>  include/dt-bindings/clock/stm32fx-clock.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
