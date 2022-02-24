Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C0C4C372F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 21:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbiBXUzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 15:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbiBXUy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 15:54:59 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588251D0366
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 12:54:19 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id j8-20020a056830014800b005ad00ef6d5dso2240044otp.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 12:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aZm/CcYlj2yV7sRQufnHuEUnKt/uTeWX102wYjqfB4A=;
        b=E0xcAcjVl0QTIohB4YNUD1i7MbmV3Cu+pA5zUSCcJgQM2nAfXabn0yoBBgRT0ptgk5
         7alboRMgAkodsf8tW3Q/A8SegJTAeUsKUHVbXcotxDaFDL56b9YiDkc0uSYQMIQuaI8z
         gx2RPx3rs2qbu/Ge/7EQWQJvBGR5LuQRiveuNayaWMwtJpV808dIiQGOQFuD3xFBXIeb
         aRFMYSVOe7g4EZmY9XMw/bXQMVuTp8JRMyN3B9NTFHpPUE/97qAkH5nf/0iWAev+zjfC
         OeFf+UeikCiypZ0O18cb54nG0IV2QvK13d4A8tO+t0rFc/yeuL7JGSdmv9izxqmssaHJ
         YypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aZm/CcYlj2yV7sRQufnHuEUnKt/uTeWX102wYjqfB4A=;
        b=I1RqzBTpHinjokFehnevjlxtBWOH+FX06ka1zOHf13sGSyO0KZf6tisb2L37gb2X0B
         2zOVjfbEuUChsvl9JW9BpWxFeZlzvQEDiK3La3oj/GC2FyaahpfEx2jFkS1zKNBWQiLX
         b+2VhskEVWo8dA4ebkNo1W7dOgehQpePmBEVSrrMwiCaj6VCXaCc7vWOSp/psIGr1y/R
         o3h0HN8bsAFX7IlshdRB+RTYXYl5ICYg97ImmXK5nOiz/yZ62pqpLYi2PvD9RaBz2XiX
         4lN2ddgrscZDBRj+AeG1zkroI1E8dDNP9KKToGAYMyJkTpb3PC10H1A+xWXl8daMgbFW
         ffqA==
X-Gm-Message-State: AOAM532KILQosHYA7bg081X0/PMXldJpHwIBQxSSZz6K/OsNwhDlsYqn
        ZvqwgeNUel34aUspKEai0bJhTw==
X-Google-Smtp-Source: ABdhPJxf0IRtIYi2GQC5Vhnyla9E7hbpCXArddUQ8uTyxFyo1osPooTCbMli4zMX/YxjXjDBlRk6/A==
X-Received: by 2002:a05:6830:13c8:b0:5af:440b:429d with SMTP id e8-20020a05683013c800b005af440b429dmr1647337otq.25.1645736058743;
        Thu, 24 Feb 2022 12:54:18 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id c8-20020a4ad788000000b0031ce69b1640sm191259oou.10.2022.02.24.12.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 12:54:18 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Nikita Travkin <nikita@trvn.ru>, agross@kernel.org
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski@canonical.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: msm8916-longcheer-l8150: Add light and proximity sensor
Date:   Thu, 24 Feb 2022 14:54:04 -0600
Message-Id: <164573604162.1471031.4512511149186289960.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220219145140.84712-1-nikita@trvn.ru>
References: <20220219145140.84712-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Feb 2022 19:51:40 +0500, Nikita Travkin wrote:
> L8150 uses LTR559 as a light and proximity sensor. Add it to the
> devicetree.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: msm8916-longcheer-l8150: Add light and proximity sensor
      commit: 3016af34ef8d3e3b802693c8d3878906c886621c

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
