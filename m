Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69426476610
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 23:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhLOWnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 17:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbhLOWni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 17:43:38 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68330C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 14:43:38 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so26733005otu.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 14:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dbeqSg8b0J6PlMNi+JGgxriBEmTuIA/mbzEPAcAogDM=;
        b=bbSjHiO+Y6J+b/TV/KJxmkqH6llthHQegASBeHHcO8ZIbmbzsKq+/xfB917pAMuBQY
         T6h6wmZSM3BvpTTjahsdDtrj1/oPZm7+5eHuuGqmTTr+b7cmXR+nljorPxKa1mtKPt7A
         P9FKWBxmGbLZ7TSClExk+EUfgT9lKVFo+i7WozByaaZHUdpyXrblBC4fbdLKkPigHiQT
         7LBvapT6VKDzhdSKkHlzxEX3BTpS7lcP/4zzKOp2SrSwkK/8IYO+YPLzb10d+F4Uuohf
         2Xyjr7D9TlsTJ2YhbKyLUeo7xDt4BUaQFeBLTJc12tq+5Kwa4IUB1WI9vMM7itb18OYb
         vTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dbeqSg8b0J6PlMNi+JGgxriBEmTuIA/mbzEPAcAogDM=;
        b=FmN4UpwA1S4M6C4Cbcvw39g5o99R8je1d50KRbweepn+vTp/Rq5kpoxYbuwqmk57aW
         hVHC/MSPPSrJ0c86S+v+5a+SkYEtlJE0Zx5DMJa6gh/x0E2tvvLjF3mnQviVsaRuX39p
         EKjK0T6k73CFkGjSehjUzFfae1v9+i1WzPlDnNrBmU9ktzwsCU3lWWycECpBh0qztCV+
         W3Zy/6zxux100hX68Gz4fuUe/tCjZ/nq3+C4X9KmhxWapIEzcJFuXGf1VPSn1i76ii5l
         u5j34bAssIJVwg+yAprZBaNoXQ4wypxCABCiODNZjnlVMOpqEEcR0wmfbT3v06aS4FJY
         n36w==
X-Gm-Message-State: AOAM531lG2a5a0o6jUPCJ6vs93SEHrGM2v5ZfVDhRq4RCwVc75lXbf3j
        HsG2wkMD9i8Z8R5WNgSXmBY8Fw==
X-Google-Smtp-Source: ABdhPJxjdWi6Bm6ZJQYnM/svKcMIvskVW7fyteLVAMJAQMgWaMfkvQwLSYaIBJYDwxbkF9iRmChdZg==
X-Received: by 2002:a05:6830:33ce:: with SMTP id q14mr10791065ott.346.1639608217773;
        Wed, 15 Dec 2021 14:43:37 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id r3sm664716oti.51.2021.12.15.14.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 14:43:37 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 00/11] arm64: dts: qcom: Add support for SM8450 SoC and
Date:   Wed, 15 Dec 2021 16:43:35 -0600
Message-Id: <163960817927.3071270.14750347798337748671.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211215043440.605624-1-vkoul@kernel.org>
References: <20211215043440.605624-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2021 10:04:29 +0530, Vinod Koul wrote:
> Snapdragon 8 Gen 1 Mobile Platform [1] (SM8450) is the latest Qualcomm SoC
> announced today.
> 
> This series adds the DTS support including clocks, tlmm, smmu, regulators,
> ufs, interconnects, pmics and cpufreq found in the SM8450 QRD board.
> 
> [1]: https://www.qualcomm.com/products/snapdragon-8-gen-1-mobile-platform
> 
> [...]

Applied, thanks!

[01/11] arm64: dts: qcom: Add base SM8450 DTSI
        commit: 5188049c9b36d718124e2cce91803a26a34a0ad6
[02/11] arm64: dts: qcom: sm8450: Add tlmm nodes
        commit: ec950d55728459248e78f5c70ab3e3c2f7c22e38
[03/11] arm64: dts: qcom: sm8450: Add reserved memory nodes
        commit: 285f97bc4b017b013d273a69ba3ee12252990812
[04/11] arm64: dts: qcom: sm8450: add smmu nodes
        commit: 892d5395396d5515c42e502810884225776b3b10
[05/11] arm64: dts: qcom: Add base SM8450 QRD DTS
        commit: 24de05c38e6bfe80fccc3b632c142accfaa7232d
[06/11] arm64: dts: qcom: sm8450-qrd: Add rpmh regulator nodes
        commit: 128914ad230354ab4af9c3b86fdce2147f467553
[07/11] arm64: dts: qcom: sm8450: add ufs nodes
        commit: 07fa917a335e139a108e94085c6beac3098e3874
[08/11] arm64: dts: qcom: sm8450-qrd: enable ufs nodes
        commit: 8f8f98c881686d21fc937f469d3a198f2f9bb9ba
[09/11] arm64: dts: qcom: sm8450: Add rpmhpd node
        commit: 61eba74e473ed4cd64ec17440092f4a98913cda3
[10/11] arm64: dts: qcom: sm8450: add cpufreq support
        commit: 015a89f0d317dce4d2174059155c2fc39db7cbc8
[11/11] arm64: dts: qcom: sm8450: add i2c13 and i2c14 device nodes
        commit: bf0a257a9418ebcbe6ab2a73728f76969942e52a

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
