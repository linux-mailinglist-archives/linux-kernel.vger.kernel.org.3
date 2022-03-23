Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33E14E5535
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 16:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245155AbiCWP3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 11:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238427AbiCWP3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 11:29:04 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB436E57C;
        Wed, 23 Mar 2022 08:27:32 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id e4so1986180oif.2;
        Wed, 23 Mar 2022 08:27:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OiYCf95OWnPHrVVcTil3o0lRfEOuLqIN4kvzsdZ2vik=;
        b=TnJeNwpLWNzEJeN4I9gJGnkiQQe7d6xrKAtG9CCTK8ArlTY5Rosou4jVSS9XQ5wEl8
         2skd+VK1l++zZ+y5emIzxi6UdXCejIY07uOtIzMYyFHuJnJJ/HpGx2rqRHr2uEzOrNiU
         eD5TUpnLTpLGzt/S4iAMtfbhBcJFCrOtltm8UUywp26i/wB67N+hcDB6E7GdlgTQIFji
         9MIzXyTUUvZlEnRjc47jdgE+YNooUlkdBp6V72w4kYmWpt/pTSHIp18SuVJar/xbHJ40
         xr9r1Z+scrV7ahwBQVHFp0oa3IecOfYX/Q1W1GbrcYuJA0NtqULyo/dafr5YXtl4p0ec
         KYlg==
X-Gm-Message-State: AOAM5304G8XD5BvCTEFkUpPLw8maWIx9iFWRcwNhF840KY10xbw/AIOM
        4ZqZ4YAp3IEgWceEQFblsSERl1XYSA==
X-Google-Smtp-Source: ABdhPJybrZv5UTpvpd5w0OCO/sjEIBA8GtcwyYtDEnIypXsi04z3xMY5BwbDKYJSvJpxjrYZ7eJPzQ==
X-Received: by 2002:a05:6808:2189:b0:2da:b59:3acb with SMTP id be9-20020a056808218900b002da0b593acbmr4953810oib.112.1648049252195;
        Wed, 23 Mar 2022 08:27:32 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b188-20020aca34c5000000b002da579c994dsm60536oia.31.2022.03.23.08.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 08:27:30 -0700 (PDT)
Received: (nullmailer pid 4133173 invoked by uid 1000);
        Wed, 23 Mar 2022 15:27:29 -0000
Date:   Wed, 23 Mar 2022 10:27:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v6 15/18] dt-bindings: clock: Add L2 clocks to
 qcom,krait-cc Documentation
Message-ID: <Yjs8YdAbytYhhnb4@robh.at.kernel.org>
References: <20220321231548.14276-1-ansuelsmth@gmail.com>
 <20220321231548.14276-16-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321231548.14276-16-ansuelsmth@gmail.com>
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

On Tue, 22 Mar 2022 00:15:45 +0100, Ansuel Smith wrote:
> Krait-cc qcom driver provide also L2 clocks and require the acpu_l2_aux
> and the hfpll_l2 clock to be provided. Add these missing clocks to the
> Documentation. The driver keep support for both old (it did already used
> these clocks and we keep the same naming scheme) and this new
> implementation and should prevent any regression by this fixup.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/clock/qcom,krait-cc.yaml       | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
