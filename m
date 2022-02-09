Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDD64AE73D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 03:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242188AbiBICqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 21:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244675AbiBICOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 21:14:16 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8743C06157B;
        Tue,  8 Feb 2022 18:14:15 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id v67so1053489oie.9;
        Tue, 08 Feb 2022 18:14:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QlY7z6ucIH6IDIDbySWxzA4mcb/KENstANpgmuDi7Sw=;
        b=kdLCwSEF84+UfA1rQuA29sbYcoJQDTHFDMm5c6TJBO0743PABa1gInSxPZx7EU6X6Q
         aZUMrFc6BLdfJmL3M9knFo4GBPO2EoJaBURGGiKXD4SjFZJwqxEUs7G/+ijJhCMLeUoH
         DUS6ERQLFggbCYztuM/Uxb2kJLut3pG3d0IEoZRLCrWxrMCQTPAHILROkvl1bwVQoJbE
         Fy2z+4mrm45KZBKFwoYm2cgSmlbbSPRFM3aOIVm0KW9ZgcLRRMLRdCSmus0gCV798puQ
         W9nM72QmQi+xOCXyQGLwjQhtHDlibPEkwHfqViD0ILcDZPvZWvm7Oxx78fyfUhVISyC4
         YaWw==
X-Gm-Message-State: AOAM533/Oe8uvPzXPFIgjx1g9KkQ1hZf17Q2uJYqopgoAissu+pjBoOc
        5eYDlv1v9+Ky3Lmsd47Nyw==
X-Google-Smtp-Source: ABdhPJx8VIWqIwXOvN/NC7/dT9hgNU1e17bYi6UbsWxi/VPrkW8Osj2X47/792oC6Qn0vHev4h1Czg==
X-Received: by 2002:a05:6808:1188:: with SMTP id j8mr373617oil.195.1644372855013;
        Tue, 08 Feb 2022 18:14:15 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x16sm6203662ooa.6.2022.02.08.18.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 18:14:14 -0800 (PST)
Received: (nullmailer pid 3467846 invoked by uid 1000);
        Wed, 09 Feb 2022 02:14:13 -0000
Date:   Tue, 8 Feb 2022 20:14:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 08/15] dt-bindings: pinctrl: qcom: msm8953: allow
 gpio-reserved-ranges
Message-ID: <YgMjdZ2hH2t5JE93@robh.at.kernel.org>
References: <20220112194118.178026-1-luca@z3ntu.xyz>
 <20220112194118.178026-9-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112194118.178026-9-luca@z3ntu.xyz>
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

On Wed, 12 Jan 2022 20:40:57 +0100, Luca Weiss wrote:
> Allow the gpio-reserved-ranges property to be used in dts.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> Acked-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  .../devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml       | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
