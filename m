Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18BD4C373B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 21:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbiBXUzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 15:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbiBXUzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 15:55:04 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E867B279933
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 12:54:25 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id z7so4935827oid.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 12:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=43I6ekRHqWVR7CwecW8a7/gZV+2lK7QSWt8bdxdFb4s=;
        b=I/vGATIdJ46oKJYMhk/5aiavatZkPHJ3gxssGhAFeSWqoaIddpGiaEHeoWk6Quddtk
         LiNw4cRciTcXeppZq9iGLZoUTpibvT3ri733KD8Pc1TLrb3IJNxuuQj4TXZ7wP+uNhi0
         YG7PUt/OUrUMJSGxnkru5qoF0zgjXwEo+ea8Dqif/gb7tkOfjHph0w6Ks27XY4nrvVj7
         KsAJVvucCWXWWQIqno7z6aSERNjnZcdsdFW4IHcpbC1OdCSoNO3a5OcC3lmWg7tY8Z3X
         cYibSv2QetiF3uUvbOwhRYDUsmwWI+vV0dIGDTElD1Mnybms+O3/VAn7LElQdzkgmn+v
         +ACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=43I6ekRHqWVR7CwecW8a7/gZV+2lK7QSWt8bdxdFb4s=;
        b=5Oh91WqB9OG9ox4CxseWDQEBPrFrlo7EUitt4VtnNWNikLTZBT30n0oBa5ZcpKbELG
         Oz3UKTugVMRQ4a6MW2VtVsvN0W9NTcNFjEM37G3y6d7Xlqodhwp/5NuNYLiE2bcR93C/
         2hG6v9fMluD3EGwfg6n5+NR91OKH/j0EIo2G9c+08BWzi5rQtT5jnNTBkdq/ESKlZ6gd
         xPW3ZNnDvpzt0qHVB5c4wf8uNC5rvrx3jgAy5ucZaIa+HqTi1sKL1TR3S/xyV16I/rJV
         dQe/sCEZ1ePIeudSkiX8TUfhc7bg+f4xUcFPERjvaU4CpXtB1/6a7Q0LeyKgDLINDohX
         pGhA==
X-Gm-Message-State: AOAM530rWERDD/1NjzPp3NYNsRcy5qxq6iIQlgVtkNN/MMaaNXkEO2EY
        yLFuiLQCe3vzapE+Xo+j6iGpyQ==
X-Google-Smtp-Source: ABdhPJxhSGlAr02MlhlC3RF+7ctSR88VMt+jwGSmBA1qNiZ/MDJUpmd5T0Z59y+NHaxn93GZ1WeUpA==
X-Received: by 2002:a05:6808:21a2:b0:2d4:c3e6:6873 with SMTP id be34-20020a05680821a200b002d4c3e66873mr8503732oib.253.1645736065301;
        Thu, 24 Feb 2022 12:54:25 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id c8-20020a4ad788000000b0031ce69b1640sm191259oou.10.2022.02.24.12.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 12:54:24 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     linux-arm-msm@vger.kernel.org, Xilin Wu <wuxilin123@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, agross@kernel.org, tony.luck@intel.com,
        ccross@android.com, keescook@chromium.org,
        angelogioacchino.delregno@somainline.org,
        konrad.dybcio@somainline.org, anton@enomsg.org
Subject: Re: [PATCH/RESEND] arm64: dts: qcom: Add support for Samsung Galaxy Book2
Date:   Thu, 24 Feb 2022 14:54:09 -0600
Message-Id: <164573604161.1471031.2966879245937890309.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220223145130.544586-1-wuxilin123@gmail.com>
References: <20220223145130.544586-1-wuxilin123@gmail.com>
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

On Wed, 23 Feb 2022 22:51:32 +0800, Xilin Wu wrote:
> Add support for Samsung Galaxy Book2 (W737) tablets.
> 
> Currently working features:
> - Bootloader preconfigured display at 1280p
> - UFS
> - Wacom Digitizer
> - Two USB 3 ports
> - Sound
> - Bluetooth
> - Wi-Fi
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: Add support for Samsung Galaxy Book2
      commit: d4b341269efb3c7fb37747064f7381c21dd7b983

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
