Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BECF46512A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 16:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243295AbhLAPRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 10:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243317AbhLAPQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 10:16:30 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA4FC06174A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 07:13:10 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id r26so49087170oiw.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 07:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o19mkFUL/fpzys08KqquFifEdc4bKOUGZEGdzog9Xmw=;
        b=Rs0LjHE31xOzHk+GePe2i2iqL18pcJ2q3io4SD3JrGPvoBRQqv7zgT/a9hsOszMLUk
         bE5DrL7VDvEha/eselKwEzwVmvvU6s3/xVd6x+XgSjkzveCWOII2uuRzBWvlBb1YlmLF
         JWU7KkwGJc4rgcAWJ3VfjVElm6YQbFmP+Eu63tVevOKgXoDSQdGpyabaMy/uRdUwoPvM
         uGfjXjhGqRx4aUaBoD7QXFlXmep3iPKguIGRk2CcUrFg4RGrEaitNhyNXRFr9NLaDM17
         i3kdq+bbf4644APRQ8P7tzebS56c7/JJFn/LQPna0MAFTzfRkkGqlt5q4r+M91cl6AeE
         M6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o19mkFUL/fpzys08KqquFifEdc4bKOUGZEGdzog9Xmw=;
        b=VBYQReunEXINzx5Ai6yNh+qJNGPIJNOn4og3IbnHNDTlLzJXhUyE/QwZPvKPA/hwwg
         Kswo9VtUsGRvCwcjz538jRDaPWkng8NFNNbQWvK4Q+zQp7UaHUz0QdzZTuIQZa0gZNWc
         FqY7ct+XzXphjiVeDcCbtArM2b26WU0IHbC0PqF70GHox6jha6JdKgnDS8E8XVR6D5ta
         CefRrRbuS93ogtJNezVs9ay7Urw9UUPqU3dHSDuogMjc9YY590LRXR9r0MOQliQ9Lq5/
         arKsDusqtp86vWFkc2uJ2OnSxCQXAbBokCiGuRwYMfYxH4yBFiylNnLKSluRuP/ZNjyi
         5nnQ==
X-Gm-Message-State: AOAM530hdDWT0FnvzNRaHqfa2Q3AqmpX9mXEGwEPjJFmmL24lPZdGp4f
        gLizicZBva0Cp2jM4z5kSTfdASU64UR3FQ==
X-Google-Smtp-Source: ABdhPJxs4wtgn/gpbNSiPGQvqiVlBne0Q/kAhMRX9jhjlTihO0qs7JdnHuMhm2PQupVJeH38TBMM6w==
X-Received: by 2002:a05:6808:3012:: with SMTP id ay18mr6932933oib.88.1638371589405;
        Wed, 01 Dec 2021 07:13:09 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id be12sm33933oib.50.2021.12.01.07.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 07:13:08 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dang Huynh <danct12@riseup.net>
Cc:     linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Caleb Connolly <caleb@connolly.tech>
Subject: Re: (subset) [PATCH] arm64: dts: qcom: sdm660-xiaomi-lavender: Add volume up button
Date:   Wed,  1 Dec 2021 09:12:56 -0600
Message-Id: <163837153033.1905338.5076166064291659682.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211121170449.1124048-1-danct12@riseup.net>
References: <20211121170449.1124048-1-danct12@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2021 00:04:49 +0700, Dang Huynh wrote:
> This enables the volume up key.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sdm660-xiaomi-lavender: Add volume up button
      commit: 6867430332655cfb0880e0e7576ea4eb786d50fc

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
