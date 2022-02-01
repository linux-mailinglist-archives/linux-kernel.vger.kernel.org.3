Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E4B4A567E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 06:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbiBAFVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 00:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbiBAFUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 00:20:40 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099EAC06173E
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:40 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id e21-20020a9d0195000000b005a3cd7c1e09so8465672ote.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tJfR7uYWrWNTN271gKyG8+fFB4fvjE1IFu7WrHFi2Os=;
        b=Eu5gKoXb01U8L01oBo8kDk0ntF6tDYjLNRPSKDIbz+H3/2HbhkKlJXN/76mSasA59x
         ufHiX9eKKquaysLOlSmr1qj65cmV/HnkOPvLarBvWiLoO/M8yYR57VNplRg7XfTq7wiL
         3LCTUjhhzTU50AmikL3FEqIJr+eqTlXQXAAXqq/RF5Fx6EhVjVroC6JK47xycqP16HL+
         T1p76O0DJ7FNzXtdDXpxn9UukinV7880qbFdA/ouTwOe1cIQ2cKB9vCHivj2e9dz6a9+
         lf2Vc2sed/hTunO/FdXJVJA4iraIdHTY6VpUQRy3a0fnpW0Nph3CRXuGsHcdjwLkdQOt
         r1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tJfR7uYWrWNTN271gKyG8+fFB4fvjE1IFu7WrHFi2Os=;
        b=LGnLtBa/Btw+j7I9+FNbk/H9SEOs/7B4/ABiASzzAgPPASJ1nhnOlqGDkKCGVfaKyE
         0l7wYYMpoNZmItnzlU5GNUzd2FPKOnrSgvmpKuFH+W8LmmccyuS7sGKYaZE71uvvKI5i
         oifJJa1pO4rAUr4quxWVYxVmTxRMZzuBVS57zV2QTDp7eEH1j5mc7tcMR5+G1fsFLs3h
         hp81qunSsgZjl3BroK0etZvctxOiYRZyO8FXMCqXZoIirOOY7TIXvCIQKmkk+tDeW8aA
         TUm1+hbQHm85rp1y+Kne99Ugg0KAjfEeI53diw4Fu8HN56lBsYMTPgsz820PzXbnTj1+
         29Gw==
X-Gm-Message-State: AOAM533659KAvBUVzr15JCTDYOxGH6ivLGN4GHuoxNr3h/6sRuLT8srz
        Fqy8mmNfDGBFKPX0i2S2or+4HA==
X-Google-Smtp-Source: ABdhPJyhMewoOZ3ZNMsRqWqzAIUXA971YfAslyDlAiGLXuAQ3kwtYEnsAM18OxmtCuTxu6zo8lS5TQ==
X-Received: by 2002:a9d:469:: with SMTP id 96mr13814243otc.342.1643692839432;
        Mon, 31 Jan 2022 21:20:39 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id u3sm8193107ooh.19.2022.01.31.21.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 21:20:39 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dominik Kobinski <dominikkobinski314@gmail.com>
Cc:     devicetree@vger.kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Subject: Re: (subset) [PATCH v2,5/5] arm: dts: qcom: pm8226: Support SPMI regulators on PMIC sid 1
Date:   Mon, 31 Jan 2022 23:19:48 -0600
Message-Id: <164369277342.3095904.11781434686393945252.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211125220244.62586-1-dominikkobinski314@gmail.com>
References: <20211125213451.62010-1-dominikkobinski314@gmail.com> <20211125220244.62586-1-dominikkobinski314@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Nov 2021 23:02:44 +0100, Dominik Kobinski wrote:
> The PM8226 PMIC has SPMI regulators on the PMIC SID 1:
> add the spmi vregs compatible to probe them.
> 
> 

Applied, thanks!

[1/1] arm: dts: qcom: pm8226: Support SPMI regulators on PMIC sid 1
      commit: 02964a7244bae61a60e0ab15526a51f9e974bb4e

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
