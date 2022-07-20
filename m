Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5771B57B90C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 16:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241093AbiGTO7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 10:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241075AbiGTO7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 10:59:40 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB60452DD0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 07:59:38 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id p132so11149109oif.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 07:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TvmCMcvB/AQLSDyyk2y4pjMIoqRBDrfZeqPEyK/hmJ0=;
        b=QVxsFy3kJlbhszY4TNk1sZzCHzD034fBJdifXc7DLEiok9mVC1Nmavyc6BHrVmP+wp
         hLHbXgcspKEeSAkOg9sD6CO4cCENplrMyWUXu5yPQJELztbO4n6XNolW6B/oga68oC1x
         8PONDs6/GYEzhzSE+926BVcLIY2G1CK7lYd4jWjEmzwhSgqCeRo5vf0uqUf/RfiqJegS
         dFULnr+5PFtrmoSRcUjQ3XcqmTltq217hY1QxLFgNRvF1L8llivVEeHGshfhs0sqHt6y
         S6qDBfi76RBSkIXnyfGdIs/QphPTWfa0lu/gEoe1zQkj1ADIV/pYqFx38jXW//W/TkRd
         oa0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TvmCMcvB/AQLSDyyk2y4pjMIoqRBDrfZeqPEyK/hmJ0=;
        b=29b5z0d8ca2t3DZHExNAcrhG5hpZG5GWTwa4uR/Qb7iBH7Qg/ifqVn7j+klVEav0Bs
         d4nqbMpBOitl4U6EB7tCdHmhYjiOIQ169qmT8TFJe7w669OWhg9ECWiPhr/hMQylhCx5
         XX9loO9jejjcyn0BF23ygGWh6Moy+nt8IutRWAi8gBYp8KmDB6n7/1Rz7AQq0LpG1FqS
         MiAM6fAxhtJBNgxDpgkT/tV07Nh3g+kB+jeP2NWI9jLs5zJDqa/oMKfoyn/6+HEMJg39
         m+ix76nJ2K45b+NhCMXiI/wpejmc+QYaKvR6fUdxtYZYcvODlfzvIfpgLM2xsV8cJq3E
         TqTw==
X-Gm-Message-State: AJIora/ZvIUFudN/PXD47EbmfWgbUuNclNHosz15uWjKBGJ7BfXi1fKL
        p1DnO9E1Eq4JzXYQQziqXi42dw==
X-Google-Smtp-Source: AGRyM1uTA6q9Pb8g7Ft79aTK48JPXo1IE67FiP/bUIX4qNug68HwmPUpe1AGHDfMv+ZFlzqqTuBROg==
X-Received: by 2002:a05:6808:1313:b0:335:cad6:715c with SMTP id y19-20020a056808131300b00335cad6715cmr2593756oiv.130.1658329178091;
        Wed, 20 Jul 2022 07:59:38 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id x18-20020a056870331200b0010c7487aa73sm9262100oae.50.2022.07.20.07.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 07:59:37 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     linux-arm-msm@vger.kernel.org, bhupesh.sharma@linaro.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        pavel@ucw.cz, bhupesh.linux@gmail.com, robh@kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: (subset) [PATCH 1/3] arm64: dts: qcom: Fix 'dtbs_check' errors for pm8350c & sc8280xp pwm nodes
Date:   Wed, 20 Jul 2022 09:59:36 -0500
Message-Id: <165832916913.2078047.694864679825238718.b4-ty@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220719205058.1004942-1-bhupesh.sharma@linaro.org>
References: <20220719205058.1004942-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jul 2022 02:20:56 +0530, Bhupesh Sharma wrote:
> make dtbs_check currently reports the following errors
> with pm8350c & sc8280xp pwm nodes:
> 
> arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb:
>  pwm@e800: 'reg' does not match any of the regexes:
>  '^led@[0-9a-f]$', 'pinctrl-[0-9]+'
> 
> [...]

Applied, thanks!

[2/3] arm64: dts: qcom: qrb5165-rb5: Fix 'dtbs_check' error for lpg nodes
      commit: 1282fa32d71633bce5330a592db6e53cf73d2c28
[3/3] arm64: dts: qcom: qrb5165-rb5: Fix 'dtbs_check' error for led nodes
      commit: 360d9526761270f2497893946bb48de468a229cc

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
