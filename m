Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51BF74765B2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 23:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbhLOW2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 17:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbhLOW1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 17:27:54 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBB9C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 14:27:52 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so26654489otg.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 14:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gg5dt9Hb0zmVGCxzt79qYDxLV1X8hHdxfhB4BCRqFKI=;
        b=If3qcMg2hmilJ5t/ncMMC4tXSr2qj7UkQZ2BVxT7HA/8s2loDWn6tE54ZmpqoIYG2u
         B7gr7Hio6sRanlvaR514gNKeLkAU3e70T3KZVNlPdcZjZEQywVr9+3uglvJzLWgFP/ls
         0f4v9G7ML17TsiL83P0otWCh0nc7OXiGjz4b78JlrkjWAn1sS/K5RX6ATUpFHtgfgN35
         WbVgBA8nRPudu6/bJ+QZsL7KMmglfH7synT38l/xqGyCf8G/lk9wycKsymHYXiSIcrxX
         SRcx+7j75yw+FMxji3y7hQHAaUEHg82mQaXizjIDpJrMnfPEV+ijc8+hqtNY+hSFChWc
         D4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gg5dt9Hb0zmVGCxzt79qYDxLV1X8hHdxfhB4BCRqFKI=;
        b=ML8bzclNIksmSCtzT9D2J3tJRD9HaWc2tQVt9hnSSN+F9Mpm+wSy0rfFW54L1Y3egM
         D3kL4T/1WcQj4HZa8X6g/TyE1SfKYthG/T2J84E5ob9/4wEnQG6sSNPx70XTwiYwh+QY
         SdLyfg1WcgbTal5ZapPygS6qgY3a2bZUTi02jGM7FVjldjqCEEFoU9hwVjJZNZc/VIJt
         D8kvPvlaBp9Yw0Q1+Qt8YFSbV5aNfi8Q2M6mmfwPhsjFOZ7jz6cjoIRyP173tkS4bz9F
         eTPhq6BvWrmgosTqyvnWqC/UtTqOPVK4QEQRCbMiDHs+f++WB/ixBjvEtZJanXfCVeLP
         lwhw==
X-Gm-Message-State: AOAM530vwLMW61WXmqe/1iWJbxh4rGIZ0J5p4pQVWYDoZhSNA2nQ78pv
        HwJDXmf8R/nJKaPUCCR6d4C8vWGoN3/Cvw==
X-Google-Smtp-Source: ABdhPJzdf2xorUoiM+ivWUNh3hLFV/EliXDjTG8Z2XHINAWg7Gk7HQdPPZQmJczofyVwkP5eWrw1bw==
X-Received: by 2002:a9d:7a45:: with SMTP id z5mr10730084otm.209.1639607272298;
        Wed, 15 Dec 2021 14:27:52 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t14sm700500oth.81.2021.12.15.14.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 14:27:51 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Katherine Perez <kaperez@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        devicetree@vger.kernel.org, Felipe Balbi <balbi@kernel.org>
Subject: Re: (subset) [PATCH v4] arm64: dts: qcom: add minimal DTS for Microsoft Surface Duo 2
Date:   Wed, 15 Dec 2021 16:27:24 -0600
Message-Id: <163960723734.3062250.2855285450516465508.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211209183246.842880-2-kaperez@linux.microsoft.com>
References: <20211209183246.842880-1-kaperez@linux.microsoft.com> <20211209183246.842880-2-kaperez@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Dec 2021 10:32:46 -0800, Katherine Perez wrote:
> This is a minimal devicetree for Microsoft Surface Duo 2 with SM8350
> Chipset
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: add minimal DTS for Microsoft Surface Duo 2
      commit: c16160cfa5651039f886d5cc6a6d9129e1fe789d

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
