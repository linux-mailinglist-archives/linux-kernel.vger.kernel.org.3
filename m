Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D5A4C3565
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbiBXTKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 14:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiBXTKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:10:42 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B72E20DB11;
        Thu, 24 Feb 2022 11:10:12 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id j2so4306251oie.7;
        Thu, 24 Feb 2022 11:10:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=duL8gxj7mjzdSr0BZgfdXTtPTw+UGSNJxcPkThnIqyI=;
        b=CIN8M7ttfpp7HQ5jrOudk9uYTwkc1DZvIpLfXtlOHQi7jJb+lrxJtzFeobARYVny8N
         6XhIY2E/N9tJxulXs9J0pyOILFiSvHI5uRrOQ0HyGP+QywdOJSF+5Syuc5FEmPe3wxbQ
         jtzh1cdOyDUY6//94X3QF8ccEBkzjU4CO3iVXlMX048R5kNguu0GrdkiWaIPlljt9qLQ
         t4zO98vBj31Idb/bL/AV2JNCCFo4q/SyvM3Ouky/236tur6Uox+IU54AiMotRvmFb1jF
         KJ7clYnHBMxtY0QBVG/1uK0/9oNJICPuh98Y2mg7Fle/u/rcUI61eauouu4wnzdjXEin
         ZbOw==
X-Gm-Message-State: AOAM530axl1dx5wg25gJv/yEz3+0TaODn7jD8YOWf8UEIXIlaan1cbXH
        rAP4y1XDUsPhWi5F1riAqQ==
X-Google-Smtp-Source: ABdhPJxQcBcNfbdqZ5dsYe+1RJz6Hj5TARwznmPJyVlVCNfFgcPx+xXKQMNe4L2dp0sluzS+CW4ZJg==
X-Received: by 2002:a05:6870:890f:b0:d4:2a36:c2c5 with SMTP id i15-20020a056870890f00b000d42a36c2c5mr7324237oao.326.1645729811896;
        Thu, 24 Feb 2022 11:10:11 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k13-20020a056830150d00b005af8c9f399esm84106otp.50.2022.02.24.11.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 11:10:10 -0800 (PST)
Received: (nullmailer pid 3419479 invoked by uid 1000);
        Thu, 24 Feb 2022 19:10:09 -0000
Date:   Thu, 24 Feb 2022 13:10:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Taniya Das <tdas@codeaurora.org>, devicetree@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v5 13/15] dt-bindings: reset: add ipq8064 ce5 resets
Message-ID: <YhfYEcdldjZa6sRr@robh.at.kernel.org>
References: <20220224164831.21475-1-ansuelsmth@gmail.com>
 <20220224164831.21475-14-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224164831.21475-14-ansuelsmth@gmail.com>
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

On Thu, 24 Feb 2022 17:48:29 +0100, Ansuel Smith wrote:
> Add ipq8064 ce5 resets needed for CryptoEngine gcc driver.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  include/dt-bindings/reset/qcom,gcc-ipq806x.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
