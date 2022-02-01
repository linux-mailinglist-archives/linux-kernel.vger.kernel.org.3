Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991A44A5672
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 06:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbiBAFVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 00:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbiBAFUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 00:20:37 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A88C06177C
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:33 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id b186so25026630oif.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hVGYmXArXG8GIfrXzf15WvJ5KpD7Ng0lKVLODJ1EcMg=;
        b=VNuFtQzu2pwPOug3u4uIiEihzfC8Ll6+3SX0rNG8rXpG9yPWPqnCfFd1uhVZOHu11C
         39HTeFJkAyMXND2wx0RzSGaDgNvNb8ohh/f3fbB7rQWyQUPzsKdAm9Lpd/Y3nML9qVLZ
         eWqfEIz373nLaAnpI0bXhf+sPaDYUWVfvKLuHepo47w2rwbmOzAeaqpRtPeamQmA2zVC
         FOAjMAnou/QCqFZI/2Wq7mI/6BV7/EZ9too6gPOk6FNjp7Yp9aiByoLXJS4NKbmoYTGg
         bJ5/rL1B9kHGKmluH5Z6mvrHFqKhpGLF45qqVS04nVMz6UTZo5m66YhPpDbQXb4FKJEw
         krew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hVGYmXArXG8GIfrXzf15WvJ5KpD7Ng0lKVLODJ1EcMg=;
        b=xLYQyi027pHgll/ut37TdCgjdWGoCg5TjTBRGxnQSaOqb2s+5g40pUyypWwOf4hKsa
         NnpKAWadNVVblciWcvyouE1+xhX/11mCA/LULSRygU6uFbVczkz62KbMFNdCQSwJhotb
         FgoSMv/MObLCevC/szeE3tSa+LdAMef6Ju5RCHj82eOXQmCpqi0tgMm/l/0ljrihyTly
         5eBAjgLWWWQk5ugiTy5Jt87lqF8tHAw0bNZSd+wkCMOghEhHvpQyXJVKrh5woL3uWWyO
         /+DPnhAARjd2zqPgVx15nMzb7PbQDEGMr6RD4hGIehybgpgRHMXd42zc4mBP/8YmpDOi
         vjnA==
X-Gm-Message-State: AOAM532gGBEA4kKqSCnTip3fr6UVycluGBBqI2G9OdQHe//XqyApaYDu
        LZya5nDT+gCKR+eQPzDUw1exEw==
X-Google-Smtp-Source: ABdhPJw0rxP0aaD7SBSgIboiruNmEfyN88p/y60iO7CYjNuN2WP4yup7/68qbil1igVnoBMb+89TyQ==
X-Received: by 2002:a05:6808:1248:: with SMTP id o8mr224207oiv.205.1643692833142;
        Mon, 31 Jan 2022 21:20:33 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id u3sm8193107ooh.19.2022.01.31.21.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 21:20:32 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, ~okias/devicetree@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        LogicalErzor <logicalerzor@gmail.com>
Subject: Re: (subset) [PATCH] ARM: dts: qcom: fix gic_irq_domain_translate warnings for msm8960
Date:   Mon, 31 Jan 2022 23:19:41 -0600
Message-Id: <164369277344.3095904.15509491723672452794.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220108174229.60384-1-david@ixit.cz>
References: <20220108174229.60384-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jan 2022 18:42:28 +0100, David Heidelberg wrote:
> IRQ types blindly copied from very similar APQ8064.
> 
> Fixes warnings as:
> WARNING: CPU: 0 PID: 1 at drivers/irqchip/irq-gic.c:1080 gic_irq_domain_translate+0x118/0x120
> ...
> 
> 
> [...]

Applied, thanks!

[1/1] ARM: dts: qcom: fix gic_irq_domain_translate warnings for msm8960
      commit: 6f7e221e7a5cfc3299616543fce42b36e631497b

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
