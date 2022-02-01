Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9304A5675
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 06:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbiBAFVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 00:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbiBAFUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 00:20:38 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3E3C0613E6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:35 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id f11-20020a4abb0b000000b002e9abf6bcbcso3882703oop.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q24W6CEQ1tNzky1Gmov73Psa8COhkR37xMurQcqHjZ4=;
        b=EmsOV9SXQydD4yYtWOPflEg+MiW5iREIgiBGR6m3qIdlaOW/x330S4fPZsWQDunNHu
         kiA+Rx+W6SJVRf8lK2xrW/SQiw322guG/nU+MCzOXIgB+Hk5ljE43emqdSdOtlhzn/qw
         mS+1LTc3ZfxZOM347WOQ6Jhj75xThZp+TUVGQDpadlUlnokl5Erweu+NzoJAP/2YIOEN
         RDYEin/qxeoRHy5LjksGYwTFc8VIVObCAc7Mi/MTvXcK2Bafv2wTy0sBq3RukJHexnaV
         +ngRyv8rBV33tjoDMzroaSC0QR5M3YkIcs3TI7h5mawXxOP+wJRfBFU6GpJ/Qm0WPwfV
         Jfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q24W6CEQ1tNzky1Gmov73Psa8COhkR37xMurQcqHjZ4=;
        b=uijebm8YHrDRitkHdFJe5sNPr2lbsKzRYk7tS8fvWJytCWa4z+p2KDi288gb41VGsQ
         Zg2cdRvd9HVJLS0IvqXJXKjtCaIGb4J4YqRMBmKZ2SITMvFBkm02T3fvMkWLlOizXecj
         o6p6bmKEgRgQY5rtq3OkouBWNWZ2ZVRtvIiOto8y0rWO98G+4ds0dEmd4uhVzXc7pcrr
         fpJX0Xbe4s6LcmNYLp0qGqdKLtAtbg7l9AbN829CPu2J36bv0yzCGiqXZyEEjC6Ogs2n
         xGbWpO0AbHDtLe7v1LLZldWKRVQ1Sx33Y2MEuKBkpeX6CFyXphJ6OCkI8jjNYiywbpPP
         HJHw==
X-Gm-Message-State: AOAM531CsntX5XLwk+/YGtrPASLVjvMKw3OgtXDug1l+T4OGVQolKB5K
        /UndrU5MAK+VShwzdcdHw2ztdQ==
X-Google-Smtp-Source: ABdhPJxaf56yCDcxNRwOv3Bj6Yq/vOW5NHRCMVgV8AQhrXUrT8hnPKTPeLYU/cc51HZPBUCMvCCl4A==
X-Received: by 2002:a05:6820:16b:: with SMTP id k11mr11842194ood.7.1643692834899;
        Mon, 31 Jan 2022 21:20:34 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id u3sm8193107ooh.19.2022.01.31.21.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 21:20:34 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, ~okias/devicetree@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH] ARM: dts: qcom: rename eth node to ethernet
Date:   Mon, 31 Jan 2022 23:19:43 -0600
Message-Id: <164369277344.3095904.10512751977671950567.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220108171535.55536-1-david@ixit.cz>
References: <20220108171535.55536-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jan 2022 18:15:35 +0100, David Heidelberg wrote:
> Comply with dt-schema requirements.
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom: rename eth node to ethernet
      commit: c9a186338f3f7dff48df3da0e900f4be0a7c11e6

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
