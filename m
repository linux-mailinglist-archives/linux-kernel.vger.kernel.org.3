Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A997E5828FF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 16:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbiG0OvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 10:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234280AbiG0OvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 10:51:15 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD703ED4B;
        Wed, 27 Jul 2022 07:51:14 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id p5so1754435ilg.9;
        Wed, 27 Jul 2022 07:51:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5y7PFmcjHVgT/qs/LxH1VBCcidqbiuh6OAS20LCFKqI=;
        b=61MSNy5v5tRhKPL32//rRnf1LuflroSTM6e+A4Cs8lAq/KINSEMqC9+IxUzaNjWds4
         0USY2wt+ahDm1f1Qv05SFa7GJB47wdwJ0u9wTb1rTAzrvzEDp9TxFcFP520qXs5VrrQD
         JDxO7z6doRqeP0LM+7rzCDK6VR5Ra/51T9MRB3PZXj220T0UvSbb0WRO0KHhiDs3NS0k
         TdsZ6w47050LvjVqBs62kc7wc79F2hQkhv9Yt8TNZ9F6lWzqWh8MuJCEE32XMlUNczNU
         +fRaefvNNemHFwpVsHLC6TfU2xU1vVApOO1B7v5mgrKWdILQyu8DUhCs8TiI8nYQrLBr
         ruUg==
X-Gm-Message-State: AJIora9GpVXJiTCuTch3HjoZ++A+/UQaA9TdJ/6iIfkHfj1BJLyOrE+U
        s8xSyHlJW8HzUUmBI7Gmc7mENVge8Q==
X-Google-Smtp-Source: AGRyM1uMNY3xVs834cDXl2d5qqsiLYPY8gWspaJBg8N+CLm7LfyyhmcoIxu4cNLtSIwjHVEQLefXhQ==
X-Received: by 2002:a05:6e02:1e0d:b0:2dd:63ac:880d with SMTP id g13-20020a056e021e0d00b002dd63ac880dmr5214909ila.129.1658933473846;
        Wed, 27 Jul 2022 07:51:13 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id v9-20020a92ab09000000b002dab4765893sm6688701ilh.66.2022.07.27.07.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 07:51:13 -0700 (PDT)
Received: (nullmailer pid 2643014 invoked by uid 1000);
        Wed, 27 Jul 2022 14:51:12 -0000
Date:   Wed, 27 Jul 2022 08:51:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: power: supply: charger-manager: Add missing
 type for 'cm-battery-stat'
Message-ID: <20220727145112.GA2642918-robh@kernel.org>
References: <20220719215017.1875530-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719215017.1875530-1-robh@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jul 2022 15:50:16 -0600, Rob Herring wrote:
> 'cm-battery-stat' is missing a type definition and is not a common
> property. The type is boolean.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/power/supply/charger-manager.yaml        | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!
