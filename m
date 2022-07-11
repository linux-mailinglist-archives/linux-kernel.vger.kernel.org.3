Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C03570A5B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 21:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbiGKTIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 15:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbiGKTIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 15:08:15 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B284F6A3;
        Mon, 11 Jul 2022 12:08:13 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id p128so5849354iof.1;
        Mon, 11 Jul 2022 12:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EWM6B/BN24k6N+dVD2SEewWXN0WwozRf9TaRIyakfsQ=;
        b=zf2LcyvglxjGBhMKlwYa6YU8ELdQdlj9xHcBybKp2k90ifUSzDddXEgC9ds9HuwIdC
         WA7n2S/CpCP2QAWssuPltWjQUDr1teVhMVB5CWC7sARio2CjemosrnTGUuf1VEPk+Znl
         cGLNrAmtUirApHrVUJQujJ/0HW0sRP5S+z3AL+gxD2ZNYbAQqW2/Ypo1X60wxGtjZ1UO
         UW0GEL2ZgxxfYVRf08jmCn/h2NaBuJZwLGMgLjuHHV8Qd1WUV6tR9gpDUZNehUr87mCy
         W62GaB0wKGtg+Qx01zRR9sMPVqAV0Cl8RhKlYZQaGTRqrlWVuvaGMmaKMUWvD1Wv3LZ5
         KROQ==
X-Gm-Message-State: AJIora9+xBlxFXsZ6IwxXM6BdFgaOKEEprdUgkIh/BDKGpFg6AoihUG0
        gOqmNDboM1Bg1tYoadFpxA==
X-Google-Smtp-Source: AGRyM1tIkZsbZHicAYL56wC+XkcZQD9BsIxHHrfnD2isdQIwSFhNCyZdhgdL5ZRik/sLEF1QCo40Lg==
X-Received: by 2002:a6b:3fc3:0:b0:678:ea4a:a353 with SMTP id m186-20020a6b3fc3000000b00678ea4aa353mr10555790ioa.59.1657566493112;
        Mon, 11 Jul 2022 12:08:13 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id cb15-20020a0566381b0f00b0032e49fcc241sm3206065jab.176.2022.07.11.12.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 12:08:12 -0700 (PDT)
Received: (nullmailer pid 106719 invoked by uid 1000);
        Mon, 11 Jul 2022 19:08:11 -0000
Date:   Mon, 11 Jul 2022 13:08:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: clock: fix wrong clock documentation
 for qcom,rpmcc
Message-ID: <20220711190810.GA106686-robh@kernel.org>
References: <20220706225321.26215-1-ansuelsmth@gmail.com>
 <20220706225321.26215-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706225321.26215-2-ansuelsmth@gmail.com>
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

On Thu, 07 Jul 2022 00:53:18 +0200, Christian Marangi wrote:
> qcom,rpmcc describe 2 different kind of device.
> Currently we have definition for rpm-smd based device but we lack
> Documentation for simple rpm based device.
> 
> Add the missing clk for ipq806x, apq8060, msm8660 and apq8064 and
> provide additional example to describe these new simple rpm based
> devices.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../devicetree/bindings/clock/qcom,rpmcc.yaml | 85 ++++++++++++++++++-
>  1 file changed, 83 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
