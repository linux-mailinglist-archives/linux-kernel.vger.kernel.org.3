Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620B24C039B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 22:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbiBVVOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 16:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbiBVVOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 16:14:00 -0500
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA6DE6D8C;
        Tue, 22 Feb 2022 13:13:34 -0800 (PST)
Received: by mail-oo1-f53.google.com with SMTP id 189-20020a4a03c6000000b003179d7b30d8so19491141ooi.2;
        Tue, 22 Feb 2022 13:13:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cgkndvT1T4jmwO27r780XgLtHhcjKRbYMWE4rDOy7BI=;
        b=za/3gQSc2qWh6qTbsFpfPMkck1JFq70xaAoRjJ7f4x++CkaF0i6iIYRPieUQcclf6C
         B/cS/+1KRSKZ1gO7X1RQYUKUl1SgyLIekvFlEVeJFNEdE2mPbw6KBjceb+LLNUPVZ5mq
         xzilYXaWlYs7lRBErgwN7P5rb2Uxd/ehjqRpfU5kHcYGK8i9jSSA1TRdHnXf7e31WeTX
         Dc07VkhxIjPyEjnaixtq7L5e54cbBQ0OmXSXu9bWiXS6yfIh3Fqdoo4BjIm4HWMGyWFG
         sZO0XRb96PRXB+Zqst6nAYD35c2/9iHemlsAtEM3bhNZOpZIm9OgzsRx0IANGgHc4uSM
         U8rA==
X-Gm-Message-State: AOAM532jMG42IHoD4DYTI8PzvYfL7kC0wC3wTHhBjAd+DYAXNcKOm98J
        c1iTSEe5xcem20yzd7aH6g==
X-Google-Smtp-Source: ABdhPJy2NX8pMjrtMgNUu4fjsnzN/bbxQgfvS1zRIpcdc0Lc8SuOVgeKX9OsMW7ynJcbMh2oqPNIZw==
X-Received: by 2002:a05:6870:e38e:b0:d5:20e6:2b63 with SMTP id x14-20020a056870e38e00b000d520e62b63mr1599153oad.141.1645564413901;
        Tue, 22 Feb 2022 13:13:33 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bj38sm6235745oib.20.2022.02.22.13.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 13:13:33 -0800 (PST)
Received: (nullmailer pid 3597239 invoked by uid 1000);
        Tue, 22 Feb 2022 21:13:31 -0000
Date:   Tue, 22 Feb 2022 15:13:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, chrome-platform@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>, linux-pwm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/4] dt-bindings: pwm: google,cros-ec: include generic
 pwm schema
Message-ID: <YhVR+66zwVrqs1QQ@robh.at.kernel.org>
References: <20220214081916.162014-1-krzysztof.kozlowski@canonical.com>
 <20220214081916.162014-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214081916.162014-2-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Feb 2022 09:19:13 +0100, Krzysztof Kozlowski wrote:
> Include generic pwm.yaml schema, which enforces PWM node naming.  Keep
> the old name in bindings as deprecated.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  Documentation/devicetree/bindings/mfd/google,cros-ec.yaml    | 4 ++++
>  .../devicetree/bindings/pwm/google,cros-ec-pwm.yaml          | 5 ++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
