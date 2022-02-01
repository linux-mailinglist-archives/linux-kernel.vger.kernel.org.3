Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966324A5621
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 06:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbiBAFUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 00:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbiBAFUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 00:20:08 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860D6C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:08 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id x193so31332686oix.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6CQJAF3aH8lfYp0bzeYY2RdYRUlGfNg+KYmMYRTkV0k=;
        b=rFVwUYojxyqvXvc5rNwUP/lfl9p/kHDEVH/cvgJgyFk1aC4SRuyeV4EdeJtuvd6ZP+
         yUAHSe4TzfylK9fWLCOVoy/AdREuTD/CdmZQAeNCldFw+WCYqgLrORlLAqSXhx8KW7X6
         kvuFXnBVsFIAoHaK2kf98Ibmen+fKWOrhPCb/6+iceJZuIo5rPsMhnzoEekobpheW+f7
         vYw3C5tu/JJy0tysMj/YrEbG+kpWTU2yP/kOuKUd7omUAyRJUhMf3c5hLa7yov2xbT1L
         unRPH9+0IvnO+SXfMPayFHlBijib5HLF84gJ9Y2yHAjGsAvGoTenM7cGEe0aE7cizSH3
         92jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6CQJAF3aH8lfYp0bzeYY2RdYRUlGfNg+KYmMYRTkV0k=;
        b=FOLmBiotMZqtQwz1t2X6fYT/fAIRnRfRXvl1k3UOoCiPXc0fKe/p+EfDy6v8m9JkU5
         +cvqsivkHjScBsnc1nNiJoihiyWd7N8rb8OHiWtrh4FXLM1zWwaHejMDDia6+RnUNnqU
         NUnuKm5aSAt4BcGf9tcNHwZp/50VrNjVdlIvHD3L9hKTUF/YACNxdxaC7c4IWhR5fvt9
         LrK81KF4PqMYzTCxYZfWlaBXPpbfhuNM1ds47oYFf7BQz8hEzEqm0nR6bm2vQr7g81cZ
         J/iSavSoIPuBPgX8VDe334EwWu0+JuvFtHIPKlEP1fi7CjNiLXUsMyH1BQrrwfDXBLqT
         Et9g==
X-Gm-Message-State: AOAM533JrNQirj3ZGTV8A/qfY/3Tt3aWygWAs+Nh59TVfd3Svko93dr1
        c0qJ+pBOQwM9vslanf9lTzS806seyBw0mA==
X-Google-Smtp-Source: ABdhPJyC9U0WiH8CSSZ1X2nXwzcRTvjRdIQZkk+hMsplJkvyZfcMtIktmhvB/7/YqzLSH3QBcKkuog==
X-Received: by 2002:aca:398a:: with SMTP id g132mr203059oia.207.1643692807848;
        Mon, 31 Jan 2022 21:20:07 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id u3sm8193107ooh.19.2022.01.31.21.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 21:20:07 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Felipe Balbi <balbi@kernel.org>, Andy Gross <agross@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <felipe.balbi@microsoft.com>
Subject: Re: (subset) [PATCH] arm64: boot: dts: qcom: sm8150: add i2c and spi dma channels
Date:   Mon, 31 Jan 2022 23:19:17 -0600
Message-Id: <164369277343.3095904.415765092006433725.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211216124348.370059-1-balbi@kernel.org>
References: <20211216124348.370059-1-balbi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021 14:43:48 +0200, Felipe Balbi wrote:
> From: Felipe Balbi <felipe.balbi@microsoft.com>
> 
> By listing relevant DMA channels for the various QUPv3 instances, we
> can work on adding support for DMA to the respective drivers.
> 
> 

Applied, thanks!

[1/1] arm64: boot: dts: qcom: sm8150: add i2c and spi dma channels
      commit: abdd4b7a7a70b861c77151afab23880b5f80e9bc

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
