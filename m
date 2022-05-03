Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280B8518B37
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 19:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240505AbiECRng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 13:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiECRnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 13:43:35 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D3A3E0F1;
        Tue,  3 May 2022 10:40:02 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-ed8a3962f8so7807707fac.4;
        Tue, 03 May 2022 10:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T26t2ndEFIH6S+3HkEK1nLdgLk1SpCDyhR5mC6y7yeQ=;
        b=Zx0X/B6AJz6cZgeBJ0sucKAu2ldV87VzUZ/pUIrA8JMZk9IERbn6vpbS8j7ujbsMQj
         TE3L4cro9Abs39yP+CqQEt0nizS5NY/Pa+KcOsxvXu6kI4DDCRc1Q/NIb/m14SIwMHuq
         wLEQAuWCDaiWgt3oAr8nyYzzxsfMeCdaWOUnkb9jqxYyfRsSyJAlVr/awGRHrXI8I5OI
         cpMqLBZfDjsxVnNZS1ylNYSArT59rFciar9QJLUxBQ9t8vP33XlhcVnMn+8RSx/rN4Ou
         V8hma/XuHm4YIxvsRLjtVuvSykfd+HsoKSgjtJG69oRanWtFkRHkX1axrfOE4GKu52OM
         4xkA==
X-Gm-Message-State: AOAM532uegJSYcHOo3VtDd6el8MKkidTVMLsMwNSmA5u11lURWw+0o/Y
        BQu88pT+lxcJoRHfemcsgg==
X-Google-Smtp-Source: ABdhPJyPpfCiqdOQ40SAw7c9w9h9ymzXJPNLFETwoOT00HWCVhhF8aiQYCYC2X/d4h+Y4ZFiXMYGww==
X-Received: by 2002:a05:6870:959f:b0:ed:754:a261 with SMTP id k31-20020a056870959f00b000ed0754a261mr2384440oao.296.1651599601348;
        Tue, 03 May 2022 10:40:01 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b14-20020a056870160e00b000e915a9121csm7691776oae.52.2022.05.03.10.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 10:40:00 -0700 (PDT)
Received: (nullmailer pid 3931437 invoked by uid 1000);
        Tue, 03 May 2022 17:39:59 -0000
Date:   Tue, 3 May 2022 12:39:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     nick.hawkins@hpe.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>, arnd@arndb.de,
        verdun@hpe.com, nick@hpe.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, joel@jms.id.au,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v6 5/8] dt-bindings: timer: hpe,gxp-timer: Creation
Message-ID: <YnFo77o/DfgarP0t@robh.at.kernel.org>
References: <20220502204050.88316-1-nick.hawkins@hpe.com>
 <20220502204050.88316-5-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502204050.88316-5-nick.hawkins@hpe.com>
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

On Mon, 02 May 2022 15:40:47 -0500, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Add support for the HPE GXP Timer and Watchdog. There are multiple
> timers on the SoC but only one is enabled at this time.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> 
> ---
> v6:
> * Removed simple-mfd compatible, timer will create watchdog without
>   watchdog node.
> * Removed timer0 label
> * Changed title from HPE GXP TIMER to HPE GXP Timer
> * Changed clock name iopclk to iop
> * Set additionalProperties to false
> * Added space after ',' in the compatible list
> * Changed subject to match the log better
> * Altered description to take up 75 characters per line
> * Changed description to better describe the patch
> v5:
> * Fix versioning
> * Fixed typo time -> timer
> v4:
> * Made watchdog a child of timer
> * Added reference clock
> v3:
> * Removed maintainer change from patch
> * Verified there was no compilation errors
> * Added reference code in separate patch of patchset
> v2:
> * Converted from txt to yaml
> ---
>  .../bindings/timer/hpe,gxp-timer.yaml         | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
