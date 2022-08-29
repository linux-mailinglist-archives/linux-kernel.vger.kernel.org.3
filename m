Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47035A51AB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiH2Q0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiH2Q0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:26:17 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C1D7DF5A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:26:16 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 72so8679813pfx.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=GZn8dsR0SbA0LLgWvk778Eamu3Zg1IxsU3hRYJ60c7M=;
        b=aS17D91EapqzI7ABckllr6kGJmh53zKm8Ab/RLyCrQ2T6m60LjWajmatv2MqT+ogbm
         nDctr/DZ5AzdO6GGwIRsA5FqrLIFE546oMGi+hW69AiT8RmFQuqczTEZxYvQjIxvXTGy
         ajPhqS0GiGY82FoBGb8Nyk6ryTN9eb36x3Bpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=GZn8dsR0SbA0LLgWvk778Eamu3Zg1IxsU3hRYJ60c7M=;
        b=rSkDhJPYHGZEnQ3mBOo6wLMB/f0OWb+HdT5OVKLcO/9etTsH1Sv9g/y7+J5JpZqrBC
         EZ3fMR7JCtOMWD/53+MUjYoDh0RB3UoDcSylOKGfNvYJWTdPkU5q2CZe3+ZfrXEZaGCE
         iQ0tyanvd0G9F2YPUeT0wIbKnE6wmNo047UC+c2x3Bua+vfxIV3U6PriZMRcev5e1PYe
         5b8lnVEUafjEYZJnkZ7puryMY0b0+FWoJ7KFRffeUix0VRrQqLVV6bxRKwS4qBUlF91L
         o+ZLUq9quF5MHTET1JrFLLga6A6LY8+hprhomqQddjbmdfkFAIgi2miP5YozHqXb2y2a
         iYSQ==
X-Gm-Message-State: ACgBeo0xNglEpfsRtw3Rj7MfXq4FX86SgeG6SBcg2eN+WhQUXUX3b250
        9/Ba5XZkiPd3woyT4XO5nMBZ7w==
X-Google-Smtp-Source: AA6agR5OfdZX/Iwy3uNY6EY8EZTIaYP6u/ZP6JC8pbO1oWB01yejMfZT11uQYFJhzLe9LSpYsAr7aA==
X-Received: by 2002:a63:8a43:0:b0:42b:347d:4ad7 with SMTP id y64-20020a638a43000000b0042b347d4ad7mr14171354pgd.188.1661790375765;
        Mon, 29 Aug 2022 09:26:15 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:49ac:6e1:90a2:a0e0])
        by smtp.gmail.com with UTF8SMTPSA id m2-20020a170902db0200b0016bf9437766sm7843322plx.261.2022.08.29.09.26.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 09:26:15 -0700 (PDT)
Date:   Mon, 29 Aug 2022 09:26:12 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7180-trogdor: Keep pm6150_adc
 enabled for TZ
Message-ID: <YwzopMkUBfLfFtc8@google.com>
References: <20220827004901.511543-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220827004901.511543-1-swboyd@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 05:49:00PM -0700, Stephen Boyd wrote:
> There's still a thermal zone using pm6150_adc in the pm6150.dtsi file,
> pm6150_thermal. It's not super obvious because it indirectly uses the
> adc through an iio channel in pm6150_temp. Let's keep this enabled on
> lazor and coachz so that reading the temperature of the pm6150_thermal
> zone continues to work. Otherwise we get -EINVAL when reading the zone,
> and I suspect the PMIC temperature trip doesn't work properly so we
> don't shutdown when the PMIC overheats.
> 
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Fixes: b8d1e3d33487 ("arm64: dts: qcom: sc7180-trogdor: Delete ADC config for unused thermistors")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
