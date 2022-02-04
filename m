Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E514A9F27
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 19:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377590AbiBDSfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 13:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377574AbiBDSfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 13:35:31 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72BFC061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 10:35:30 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id s185so9526588oie.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 10:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u9J7y6965BpdBC5BNwHmGqIrSjHGGu5DfoCAOlxolgc=;
        b=NdGIIHJVD+R8dDkb2sSUZomse7kx0TBQ2hmMYUHRJJJ5so5E1BvcHWTYT+l7bb+/FT
         PZXR7l9aoS5I5X8s9+dr5kPp/VehcNI7B+UFRDX+hFsZwX/HEFP6Acw78Yp6JRTEG+P2
         OyAzaMqBPwbuKLmf7BWtk0MkPcQySKYnefhO4WCvE6rEGk7AcVZqeKPXlJ5uuwRPsps4
         iQmxiVTDfJ+7wec8om50hBnPd70b/iWnNAj7vQEoey2uQL9y6xgfLvx/ZAgnzRzNt0If
         sz66CAOhMqlNxv7JCHA07iwo+DGmaxHUpw1D/bxe8psOoA5ac2gRjiyLO0IVRSiuAqkK
         QmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u9J7y6965BpdBC5BNwHmGqIrSjHGGu5DfoCAOlxolgc=;
        b=R1Jjp5GBqEvhIpQW4T1L0rj5PRyEAaBJoYf78id/sJoBHEwc7rcptH1BbMJHxmhld1
         a4lOHDtOnG7BHB+HrkN68pSLNe6SxN4k5t1n2lMxxGVOaomIH54x624LF2ZINi9LOBHq
         ikcIUi+vzsDf8UZZ318Ca/jWXvc0b7Wy9vJ6kJQJWHCPeLZtjA3/N2s5KFxkJBEUFIH4
         Ywrb2mdq+ePKqacSw8egK9bQzO8XPIzoaS+qv3X1+1xBvGs3rqfiK0mOrdkgquEfCSj9
         TfiZUBDmGuSlPA4iQ7UNI75poWkRyrc76kT7plHPKtbVq9/ZQZWOtK3Yj2jRDuoB0NV8
         RfwQ==
X-Gm-Message-State: AOAM530W9e+DxvW1APeStioXninp6sYqBLk96PNcQIVdJ5X5KPg98PX3
        SCESd9o5SG0I+xSyl+tvAdwxAA==
X-Google-Smtp-Source: ABdhPJxuSs3D/fxlNG8InRw7QgLVBBV0s2GTBjpn+4oWxs/Z/67KP7iNIo37tw0HzaNKv8EXzrqAiA==
X-Received: by 2002:a05:6808:1186:: with SMTP id j6mr149067oil.83.1643999730087;
        Fri, 04 Feb 2022 10:35:30 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id 100sm1044182oth.75.2022.02.04.10.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 10:35:29 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH] soc: qcom: aoss: remove spurious IRQF_ONESHOT flags
Date:   Fri,  4 Feb 2022 12:35:18 -0600
Message-Id: <164399969245.3386915.10497523755309150781.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220127173554.158111-1-daniel.thompson@linaro.org>
References: <20220127173554.158111-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022 17:35:54 +0000, Daniel Thompson wrote:
> Quoting the header comments, IRQF_ONESHOT is "Used by threaded interrupts
> which need to keep the irq line disabled until the threaded handler has
> been run.". When applied to an interrupt that doesn't request a threaded
> irq then IRQF_ONESHOT has a lesser known (undocumented?) side effect,
> which it to disable the forced threading of the irq. For "normal" kernels
> (without forced threading) then, if there is no thread_fn, then
> IRQF_ONESHOT is a nop.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: aoss: remove spurious IRQF_ONESHOT flags
      commit: 8030cb9a55688c1339edd284d9d6ce5f9fc75160

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
