Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E454C275D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbiBXJB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbiBXJBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:01:52 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBCC166E12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 01:01:23 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id em10-20020a17090b014a00b001bc3071f921so5113091pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 01:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5Kq93s+crgPmi5HFKoDt6O2SRLg0Bv4SYhTGG/8f70Q=;
        b=jQpiBmXHb65yJkFfhy+Uv828XJpt/ddjUiCQKP8tQwKxLfjFv3cJ3YH6ctRVCFYMcQ
         zTQCA76puhqUgXhZWMdR78cnHzYoZV/pgKC3T5k87Vwr3fzuC3XFzNx3JpKMygHXtqEk
         kWgcSFcdSnJnErQHtcjbTWifNyG+aaSmItNBTmViGXVRLV9V7OhXA8g06jH5e3iA3CPd
         IOI1ginB89pYJKI41uyKNLOR07KH44Deb7ip7s0ViBx0b1UsbcMZIgoMAhRT4xSiiCRt
         yPOSzEUt98l2aEfJCBLgLO8FJVdR4/FzapNaeC1rLGBuRpKGvznkX1cNk6712W8mFZHj
         n75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5Kq93s+crgPmi5HFKoDt6O2SRLg0Bv4SYhTGG/8f70Q=;
        b=bF3Je3ZSQp2Ytm1NrgII65C3TILjVGu3zHusfFZ3gG8yAwSeEXuUZFxidDUYkmQR3Q
         bKieg8lBR1C8McqxHXq8T45mPuE9UkrZtmp1ec0Jq1qjM4Ui2EQ3c1F3r0BbZ54F1mKx
         CqhLw4arO5ysCthOCfGi3XcxCWIEKIv+RkK4k1FJ19F/+wpQEG+Azqr3Se3o8aDOSKar
         GSyKIFDMiz+Hywp96v+MAFNV1TyNccdgwb08ZRwQySHazAKFiCzVYJNbD2V5aubRyGYN
         DAzmS1VhkrErCmuseel0wVX922L/AV6D5LK/Jzt5IQEAGo4Y9eUK2bMmTbFt3qBnsefF
         CI1g==
X-Gm-Message-State: AOAM533sDDnB7AuCL6qNjxx4ajpHLCXGxWDnnUjIB4F46ALUEEWxQk41
        8duGHZJDUH0fq0K7MM8T5faq1g==
X-Google-Smtp-Source: ABdhPJzX1tY94b0sAG2sX2RGAzRFfSeylY1Gk2jypLzwQfDetLBeL47um2gOgg+XifX6naoVdPdpMQ==
X-Received: by 2002:a17:902:f64e:b0:14d:20db:8478 with SMTP id m14-20020a170902f64e00b0014d20db8478mr1687926plg.158.1645693282736;
        Thu, 24 Feb 2022 01:01:22 -0800 (PST)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id me14sm2221672pjb.41.2022.02.24.01.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:01:22 -0800 (PST)
Date:   Thu, 24 Feb 2022 14:31:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, dianders@chromium.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: opp: Add "opp-microwatt" entry in
 the OPP
Message-ID: <20220224090120.3f7sp23hism3wd36@vireshk-i7>
References: <20220224081131.27282-1-lukasz.luba@arm.com>
 <20220224081131.27282-2-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224081131.27282-2-lukasz.luba@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-02-22, 08:11, Lukasz Luba wrote:
> Add new entry for the OPP which provides information about power
> expressed in micro-Watts. It is useful for the Energy Model framework.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  .../devicetree/bindings/opp/opp-v2-base.yaml      | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Also need to update patternProperties section I think.

-- 
viresh
