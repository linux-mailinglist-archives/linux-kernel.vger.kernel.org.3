Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BE14DD06D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 22:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiCQVzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 17:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiCQVzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 17:55:32 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BF42DFA41
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 14:54:08 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id o8so3670958pgf.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 14:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U/LvItknh53CxFi5s43m1BITINaV3dzVzB1JmiKhyeU=;
        b=i7quoyj9+8Ga/YvC/ikmfXL7u00TKab01U5O50rRyrsXTFZC1biWumfXT2IiaOtpQq
         EMFtkJn9aRqPFryG93Gu4sOSU6IpN3idVIVpO0Scl78MugbfBfaLYVPhqF9U0bMisbUN
         Vvs9LexurlE1WDe1CqoRj59fZim4N02gXqdOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U/LvItknh53CxFi5s43m1BITINaV3dzVzB1JmiKhyeU=;
        b=TSXDTYtB4teGzoDcaZea6L/vKo5ecqMDQrc7saymp68W6Awx5WAVKVmTNykgHH9HBV
         CpWkKhGn09H981Mva4yfvSlyZc+tlqd08gnOaZ2usa//rxKbztUEdk1fKYbcHaZaPaa+
         fyShJSPJZWUmatVxkg4PtSiEIU9X/7ZVeMJ6dv9Ro0p9IYpo4E2QO8szpa/6xbZun/GD
         JbtWwjkuRro4i8Jus3iZveHmHfK3i7JxYUrez4Hd0ao2J8vEt9V/g3hInWWwUlPgkD26
         liyaIqlH6usr4EC9gapfLWg0G/c75HJs0bZpHRb9ogzuWtaoZa5GiF//IOGj1bWO6MLM
         AR7A==
X-Gm-Message-State: AOAM533ZYDzr7DWrbZXLL+ro0SxB48BH0DQXp6C2mgAHqooFdwb6CEiE
        fgbTPGZewLMZZnkkY/7wZSif8w==
X-Google-Smtp-Source: ABdhPJz7jH7YhJ8QcD4+0ua6BdX673lW4VxJRG0z3n9F+Vy4K5/a5kZkfWIxXXFtDpz0NgA1Z1ah7A==
X-Received: by 2002:a65:678e:0:b0:382:1a7e:3d5c with SMTP id e14-20020a65678e000000b003821a7e3d5cmr2741346pgr.333.1647554047584;
        Thu, 17 Mar 2022 14:54:07 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:ae74:932d:af6a:6079])
        by smtp.gmail.com with UTF8SMTPSA id lp4-20020a17090b4a8400b001bedba2df04sm6835893pjb.30.2022.03.17.14.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 14:54:07 -0700 (PDT)
Date:   Thu, 17 Mar 2022 14:54:05 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sc7280-herobrine: Drop outputs on
 fpmcu pins
Message-ID: <YjOt/aVJTLh4wqGo@google.com>
References: <20220317010640.2498502-1-swboyd@chromium.org>
 <20220317010640.2498502-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220317010640.2498502-2-swboyd@chromium.org>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 06:06:39PM -0700, Stephen Boyd wrote:
> Having these pins with outputs is good on a fresh boot because it puts
> the boot and reset pins in a known "good" state. Unfortunately, that
> conflicts with the fingerprint firmware flashing code. The firmware
> flashing process binds and unbinds the cros-ec and spidev drivers and
> that reapplies the pin output values after the flashing code has
> overridden the gpio values. This causes a problem because we try to put
> the device into bootloader mode, bind the spidev driver and that
> inadvertently puts it right back into normal boot mode, breaking the
> flashing process.
> 
> Fix this by removing the outputs. We'll introduce a binding for
> fingerprint cros-ec specifically to set the gpios properly via gpio APIs
> during cros-ec driver probe instead.
> 
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: Alexandru M Stan <amstan@chromium.org>
> Fixes: 116f7cc43d28 ("arm64: dts: qcom: sc7280: Add herobrine-r1")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
