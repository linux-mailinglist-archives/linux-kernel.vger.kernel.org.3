Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA604765D3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 23:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbhLOW2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 17:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbhLOW2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 17:28:09 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F9DC06139A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 14:28:03 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id n66so33684953oia.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 14:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wUPJKmy81yQvcPdPMwPhcK8vyFjv8cPbqM4Z+X9Jb4Y=;
        b=CRWe5iwEz/otUI/4+gGO9IOXenp6+H2APJRElPu0eis4RcG8/0oWslZTJrWhKMmYKg
         xghoa0MD03nrQxd8BUhwFIdJJfN1dQm8YejnXepp6jrRtW2UkwdFczTU9SDIYOIlejBd
         Z1jWw9OEEyheT0EtJNK2xEcRPzdyEE0WPa3xIvZNdL+tAZ42GVMx7zwx6ZsFz5YGV+b4
         z1FbIymR/Momew5/Tx7m+Mep0NTIObVFJVJuqMwmDDJs1iV/Bri0pXdv6M7KvVnN5O2l
         Vqr5aptv+WPADwIffuifRi09alhFzAtNrZ997SgojtJV9SeVybKYY+X1czV1GIigEB9l
         p1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wUPJKmy81yQvcPdPMwPhcK8vyFjv8cPbqM4Z+X9Jb4Y=;
        b=wLuHh+xm0BrkagEDWCVvHa5fQ1y3f5toyng1YNf/wVyNbfqyTTogrewvcbOGh0v+9Z
         8qf0dPmnk3XZ+PIG96wwiPJ5CcQIz71BVeKznbyvTYvbrA3zVMlyCuv1UV3nXhDjhSwT
         SNBFFfzHZ/4ZvluOXQumPU1ma9jv+Cj472wedBbNPB9CEZzmQ8wFuA3NIZA3H0r+y443
         fkOYTgOn0eb32L5njemFbuz8R/L0xlD5QWcuf3I8S0xdI8a4MP1y3zz3WD1xgM+3Yxhy
         T46HpyAsZpzjmeiZq49ux/KwuiHGsJyOydZSonkZXaMlVSzCej1MGhJsXkoH7AWBH8ok
         jE/w==
X-Gm-Message-State: AOAM53203O2ehpw39MC6OZxUmlXHuVi3KfPJLoJFL9OcyDFLuEsEbwJ+
        XX8E/cy1NC8NShRx7mF2rrVZxQ==
X-Google-Smtp-Source: ABdhPJxBgcx4/Eoae7qJFbo0zwLIS38dnbvGq7uqD2ZibSnf84ecEJzI0PLu/i7hQJGVuNx2Sh8aSw==
X-Received: by 2002:a05:6808:238e:: with SMTP id bp14mr1855491oib.130.1639607283220;
        Wed, 15 Dec 2021 14:28:03 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t14sm700500oth.81.2021.12.15.14.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 14:28:02 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     agross@kernel.org, Rajendra Nayak <rnayak@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org
Subject: Re: [PATCH 1/2] soc: qcom: rpmhpd: Rename rpmhpd struct names
Date:   Wed, 15 Dec 2021 16:27:35 -0600
Message-Id: <163960723732.3062250.14291704272759629607.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1637040382-22987-1-git-send-email-rnayak@codeaurora.org>
References: <1637040382-22987-1-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2021 10:56:21 +0530, Rajendra Nayak wrote:
> The rpmhpd structs were named with a SoC-name prefix, but then
> they got reused across multiple SoC families making things confusing.
> Rename all the struct names to remove SoC-name prefixes.
> No other functional change as part of this patch.
> 
> 

Applied, thanks!

[1/2] soc: qcom: rpmhpd: Rename rpmhpd struct names
      commit: 8f3d4dd65abd03a5edcf7b5d5a7a3e2a4866db15
[2/2] soc: qcom: rpmhpd: Make mx as a parent of cx only for sdm845
      (no commit info)

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
