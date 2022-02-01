Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41874A56A8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 06:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbiBAFXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 00:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbiBAFU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 00:20:59 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30281C0617A9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:52 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id x52-20020a05683040b400b0059ea92202daso15145652ott.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QCCppAscP/KIGwl1JCLJN5liCcMT30u1TqUecRLuuZk=;
        b=ICVa3ObG2poOxz2N8URYem+JfD02Eg4WelUkOiUAbodduvFbvIxPp3WAemXDKMNwJu
         aO0ea+0TBaq4itnPydmKaNU/YmzwjGXZaQq7XowAlX4jvJ2hSLB9QAl/Fk2r2oADjPnU
         5yAQ0uKlaSvxM0JgsYOZIymJn32lrz/5ug2Qtox/NrADlOXLZ94Hb6KDKRgl6q9SJFxR
         EjzLOeWYpSUBdz/voXZUAlMq+l2nTO6gEJ4Spm6Wy3Em/1cDL62Fov0gmhXZcUb4f2gQ
         7HIY7XcOK9RUCVOkIEYNACckDEBuCJNP5NNyWeKat0DoN5D3IwC3DMgjr1KqYM+vkCEa
         dTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QCCppAscP/KIGwl1JCLJN5liCcMT30u1TqUecRLuuZk=;
        b=TLrjJJzpZiMOh7Smbk6VtFdZWF9W+MZFgKctipqR0kZdK3eOrAYfH3QhAdDoQlhdU8
         DbkvMvGIdQoKx3Oxie76XFMT12SQLaTuqHnD/AhqMPUFtdt46tIE+1pzyRGEpx4Gb0sv
         SGwJVpn3SNHTQtSViDed/FifAE0mN0HqOGIsHmhDN8KbT2EbvGFlaqjMrB/EWISGpdCQ
         fUY4MZCIWVwoEPPEsX43Lt6cDbrIsvhCCivryvC1hJ7DLREgNX2WMLRHNEyb+drpflvX
         T5H7S2FUWijJS9Rq4vHYN8s6EjSOeTNJkp8xF9MlaWQnoRDnAy7DQf9fl2AcUpc85BVV
         o3og==
X-Gm-Message-State: AOAM530hzcfMPy4ZDY0NnzkBVa1eMkK57SUj83uJSiKV72/Ak2hVuzfw
        JakRf3c2CIfdQ/i4HCBRmy2kMQ==
X-Google-Smtp-Source: ABdhPJx+TBtU7wXSTDxavLIS3+39W1LCovnJUUwk64VK0Zthdm4jh6mS5bTZwW6JIiQDUCvfhDDX7Q==
X-Received: by 2002:a9d:6f11:: with SMTP id n17mr5920242otq.228.1643692851587;
        Mon, 31 Jan 2022 21:20:51 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id u3sm8193107ooh.19.2022.01.31.21.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 21:20:51 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH] arm64: dts: qcom: Fix msm8998 cache nodes
Date:   Mon, 31 Jan 2022 23:20:01 -0600
Message-Id: <164369277343.3095904.13862409515453016955.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211217211136.3536443-1-robh@kernel.org>
References: <20211217211136.3536443-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2021 15:11:36 -0600, Rob Herring wrote:
> The msm8998 cache nodes have some issues. First, L1 caches are described
> within cpu nodes, not as separate nodes. The 'next-level-cache' property
> is of course in the correct location, otherwise the cache hierarchy
> walking would not work. Remove all the L1 cache nodes.
> 
> Second, 'arm,arch-cache' is not a documented compatible string. "cache"
> is a sufficient compatible string for the Arm architected caches.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: Fix msm8998 cache nodes
      commit: fad35efa75a22050bb4b7cace8c1c9dd4fc70d16

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
