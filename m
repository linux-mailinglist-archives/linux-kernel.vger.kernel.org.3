Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803784FFEEB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238215AbiDMTP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238265AbiDMTMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:12:51 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B0171EE6;
        Wed, 13 Apr 2022 12:08:00 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id q189so3059444oia.9;
        Wed, 13 Apr 2022 12:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BMvV+njzv5IIGRzQibg39Ca8o5Ia+tbgauTzATf8OPg=;
        b=toT3xeUK+TleH2o2iTa3DpLDxGkF7OqAKF8GbKklF/UcbSM9AKzqt2FlTjXTLB82gn
         GlE6xitPJOo/myoVh0jGMwDtHJsa2ruZOKvZr1hAuvyNJXaAs+OCoiV7e/ux4t3V/hFQ
         bwh/ZPOptzCI2LV7gDzjsRrhMHFpZYOA2r63jCk+A1rFhESwZ3IOXsuE0g3NxISrY15f
         M9avaEuDJYtrZDzKzheO/bwxuyeAKFTwyft8P2kv7cbpLJ2/hZkyPm82Ve9dZqG/lseu
         aqYXhfsclaaK3+XOOuo7JnVum/MHroL5u+iymPF/tmcfh5fAMwT0HRjqwuv1f7D18KKE
         nqig==
X-Gm-Message-State: AOAM530m5TxZ71ITQQyWtxPprjowahitCiIoH37KGh02r+JE1JHmlSHz
        6VEDbchdWZxo53oHbFCtQw==
X-Google-Smtp-Source: ABdhPJzmBWZ92RN2FbYEVaUZjgdqHQhlsDmicm6TMWCO56EMdZkbqHPoLczpZIw6TyKe//VJHFU6Tw==
X-Received: by 2002:a05:6808:2227:b0:2da:5a4f:95db with SMTP id bd39-20020a056808222700b002da5a4f95dbmr122850oib.129.1649876879393;
        Wed, 13 Apr 2022 12:07:59 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c5-20020a9d4805000000b005e6ed41066fsm3726416otf.9.2022.04.13.12.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:07:59 -0700 (PDT)
Received: (nullmailer pid 3658295 invoked by uid 1000);
        Wed, 13 Apr 2022 19:07:58 -0000
Date:   Wed, 13 Apr 2022 14:07:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: uniphier: Use
 unevaluatedProperties
Message-ID: <YlcfjihpTpMBlewV@robh.at.kernel.org>
References: <1649317606-21267-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649317606-21267-1-git-send-email-hayashi.kunihiko@socionext.com>
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

On Thu, 07 Apr 2022 16:46:46 +0900, Kunihiko Hayashi wrote:
> This refers common bindings, so this is preferred for
> unevaluatedProperties instead of additionalProperties.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../devicetree/bindings/watchdog/socionext,uniphier-wdt.yaml    | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
