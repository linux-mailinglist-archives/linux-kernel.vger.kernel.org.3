Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96935076A7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240042AbiDSRiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355818AbiDSRiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:38:07 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3881E27166;
        Tue, 19 Apr 2022 10:35:25 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-e5e8523fcbso6725108fac.10;
        Tue, 19 Apr 2022 10:35:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=agHIs+VZdJS46Y3XqFiZ3UMC8Gt+kedIPWtIqR6xPgU=;
        b=Vi8SOeHTiVgdtlic1YYQqPF4jn1MIdyaWsu8cMswqlDfGu4W6BDavzk5ajcLNm9vHS
         6UBo2CDd5HqB8HjNZf2nrameKl9yz2F4d4hv4X6dnVg84FO9B3/XnAnTIhvA5lEM7aPf
         31V5YjYE67gzKWsGX+8Q5IDosoOQpjs28ZKukW/FMaq0wb+hu4qp8L45apYtV8uDxTYG
         MsHUQrRC/9uW88O2+mhOu0+CLOxaZGMXqxCmlJXyRCi3nrfojuhG5tCpyk+9Ggo6tY0T
         KRaPnNi2oXw0c76iLoN48MhuTEpBL9Xsj0ijVMfUyPcZxMFBiOSzxCzHjSSFDBqFwmvf
         t7TQ==
X-Gm-Message-State: AOAM530OvoQB3SM6pxVq2c4yC6GVYsuEFoSEzlFKDhDRz5ELlfe8uA3q
        pJjsZKbrvDWiDskcNJnjdQ==
X-Google-Smtp-Source: ABdhPJx32JE7TB2oA/u+IPAoml9rgBJIqcRsZxb9C1XqGhMlj/ji7s0MeOgBFLzylMO1ZhiiEzpLOg==
X-Received: by 2002:a05:6870:14c3:b0:da:3703:329b with SMTP id l3-20020a05687014c300b000da3703329bmr8561030oab.54.1650389724553;
        Tue, 19 Apr 2022 10:35:24 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q11-20020a056830018b00b0060470f9f5e3sm4741752ota.51.2022.04.19.10.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 10:35:24 -0700 (PDT)
Received: (nullmailer pid 3018580 invoked by uid 1000);
        Tue, 19 Apr 2022 17:35:23 -0000
Date:   Tue, 19 Apr 2022 12:35:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabio Baltieri <fabiobaltieri@chromium.org>
Cc:     chrome-platform@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v4 1/4] dt-bindings: add mfd/cros_ec definitions
Message-ID: <Yl7y29jgoB7GWWLf@robh.at.kernel.org>
References: <20220414092831.3717684-1-fabiobaltieri@chromium.org>
 <20220414092831.3717684-2-fabiobaltieri@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414092831.3717684-2-fabiobaltieri@chromium.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Apr 2022 09:28:28 +0000, Fabio Baltieri wrote:
> Add a dt-bindings include file for cros_ec devicetree definition, define
> a pair of special purpose PWM channels in it.
> 
> Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
> ---
>  include/dt-bindings/mfd/cros_ec.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 include/dt-bindings/mfd/cros_ec.h
> 

Acked-by: Rob Herring <robh@kernel.org>
