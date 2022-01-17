Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36ED74911E7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 23:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243687AbiAQWrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 17:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243669AbiAQWrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 17:47:07 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EB3C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 14:47:06 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id b20-20020a4a3414000000b002dda566aba7so5391915ooa.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 14:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZXSP3g+r1wHGcWmxffdPC7RC8ZW7ixKjMSdmtnSrfX8=;
        b=xbXdoYuXbxbS1m8JgCSlcENtTnT3hCxqrF9t5YYN87C8gbWRqCyqp90TQOvPsWoK8A
         GaeB3vlnGrAdPnjUDjeH2qvMccoAhKhNCBHzXvv5/M8OONK7JE/H0OZgymC6yQHtS6S4
         MGt2SiGbFPHYG1tBppdWqhUFOoGaIH/osmoVGufTGzO96Xs2pjD0nuan2mLleZSib9vS
         8331veTU+mauI3nk7vqbAlTIXiqpHcSGnqb4ApF2VSdtTTtvIcbSiZQmVBmg0kiFBFUg
         zVV+rjFtGDWku6t/Gn1y3rvcFd8JuVlkKmc+fh8+K86/KZiwirkdvBFuRo08VY3iy26o
         McbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZXSP3g+r1wHGcWmxffdPC7RC8ZW7ixKjMSdmtnSrfX8=;
        b=2yAhv8Ti0Bp1fLiyn09XCnWb3eCI6gyI72u+IuNhTtUXeQSCo03v6xYcRyqy8lfrIY
         jGq4cAF7elBQtGij6Mw3iZzxvhm0hpwKGPLB2qW/OmzLXqgyxOnevB8/v+2fC4N4sb6o
         K6+mYNzzUsVBvsB+7OSt6+3+mXgIv21uIpw/ujBoLnLFmnG2CVSXbp+2dE81QUuMQl3X
         sITMrhpEEfFd8XkM77H7QettaxcPQuAtfPsWNm272KgZJvbIFRHFT0guSE+roKrzfYlC
         b/UenPg2zUAbTtOqWQrzJ4ByrpTsfwaXMNMKtV45xfMTOxgHctJCyRtPPChJWaOGMRu7
         GB8g==
X-Gm-Message-State: AOAM530PWWcmcCbtMg7zVt7QOjpTd351UZrRW/y1hsaLf8DZcg61yskX
        Z7ZIJg7Ji0QYvTzAd+x8gLuhmA==
X-Google-Smtp-Source: ABdhPJzhVccm2wpKhLVVfD2MuwrucxaDcaZ5Y4rFhJH6kE0C41JXV7AiNEtt5blfCVKmxV0qnjHXLA==
X-Received: by 2002:a4a:8d46:: with SMTP id x6mr16463771ook.95.1642459626134;
        Mon, 17 Jan 2022 14:47:06 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id f9sm3853490otq.26.2022.01.17.14.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 14:47:05 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Stephen Boyd <swboyd@chromium.org>,
        linux-remoteproc@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: (subset) [PATCH] remoteproc: qcom: q6v5: fix service routines build errors
Date:   Mon, 17 Jan 2022 16:47:00 -0600
Message-Id: <164245960510.1698571.15538917019430460819.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220115011338.2973-1-rdunlap@infradead.org>
References: <20220115011338.2973-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jan 2022 17:13:38 -0800, Randy Dunlap wrote:
> When CONFIG_QCOM_AOSS_QMP=m and CONFIG_QCOM_Q6V5_MSS=y, the builtin
> driver cannot call into the loadable module's low-level service
> functions. Trying to build with that config combo causes linker errors.
> 
> There are two problems here. First, drivers/remoteproc/qcom_q6v5.c
> should #include <linux/soc/qcom/qcom_aoss.h> for the definitions of
> the service functions, depending on whether CONFIG_QCOM_AOSS_QMP is
> set/enabled or not. Second, the qcom remoteproc drivers should depend
> on QCOM_AOSS_QMP iff it is enabled (=y or =m) so that the qcom
> remoteproc drivers can be built properly.
> 
> [...]

Applied, thanks!

[1/1] remoteproc: qcom: q6v5: fix service routines build errors
      commit: eee412e968f7b950564880bc6a7a9f00f49034da

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
