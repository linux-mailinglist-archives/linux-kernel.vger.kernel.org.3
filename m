Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE684C3562
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbiBXTKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 14:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiBXTK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:10:29 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8079520D826;
        Thu, 24 Feb 2022 11:09:59 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id 12so4271313oix.12;
        Thu, 24 Feb 2022 11:09:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RCxx/6TF/Gt7uRpWxDFzB7QDuc95IdBPBpZRcob4Osg=;
        b=eYj66Ac6wk4ABMVOSFUfi2eSKvQ7kLuKI61A0TS0qr/cGOANia7dSlqjuNOZzySHPD
         nbH2G0/1QKzMohVhL15tqKvtNjZwZN/2dhZVExMvksJ5+nAbAAaayn0C5JjkbNuJGAb3
         1vVoihl3szSGsfIuTzKarRADsBNr7X/q2jfpWtOs8AXHD0B2RwvXVYWKwNcYkkNFG/i6
         kv9lxKcq67x0lQFcAAOYCJwC3pwHpD9VZ1TzSnjlyZgG/0W3GjpNS6JYVEUuoV3tgYu9
         l6eM4WPu89PX3rVJWOlCMCc+zR9JsCRKK+WiLIHvtyGR2KS1xNPIzjuxGCSDw1GqCBcf
         IEuQ==
X-Gm-Message-State: AOAM531C44jmQ65FwSl5MfO3io/fxFyCCJDd21C5/m98UwEvJCqQU/+F
        X02vtZbkc3W4CqaNJNQ5Yg==
X-Google-Smtp-Source: ABdhPJxEztEVvVfSJRtf/qZ456AlT9rvlvQEZnCX3Nh7NF8kkJg+SSoYuBtfU64uozfNYvfLBk7nXw==
X-Received: by 2002:aca:3d8b:0:b0:2d0:3c63:ef6a with SMTP id k133-20020aca3d8b000000b002d03c63ef6amr7864096oia.144.1645729798844;
        Thu, 24 Feb 2022 11:09:58 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l19-20020a056830239300b005adc1d88a0fsm69693ots.79.2022.02.24.11.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 11:09:58 -0800 (PST)
Received: (nullmailer pid 3419121 invoked by uid 1000);
        Thu, 24 Feb 2022 19:09:57 -0000
Date:   Thu, 24 Feb 2022 13:09:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-clk@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Taniya Das <tdas@codeaurora.org>, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH v5 11/15] dt-bindings: clock: add ipq8064 ce5 clk define
Message-ID: <YhfYBEARI/jrrYTI@robh.at.kernel.org>
References: <20220224164831.21475-1-ansuelsmth@gmail.com>
 <20220224164831.21475-12-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224164831.21475-12-ansuelsmth@gmail.com>
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

On Thu, 24 Feb 2022 17:48:27 +0100, Ansuel Smith wrote:
> Add ipq8064 ce5 clk define needed for CryptoEngine in gcc driver.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  include/dt-bindings/clock/qcom,gcc-ipq806x.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
