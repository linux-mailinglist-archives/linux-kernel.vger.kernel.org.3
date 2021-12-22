Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D629947D09E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 12:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244485AbhLVLPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 06:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244487AbhLVLPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 06:15:05 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5339EC061401
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 03:15:05 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id n14so3905460wra.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 03:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FErqBbW53lt1oYTJBI4ZMRwKkKRNvMor2XnjX9IKwDU=;
        b=c2j7wENPJfouxeo0X0JNGqK5MSNayxWWjDKqBkLjkxANAx9QVtWwwNLmS918cfsfih
         h3jImAnqPjf5kMghD/Sme/V9R/rCFPbsnfiZManJs18asjZEnb25PBIOXwXDzfmyrAA2
         6KGH+OHFVm78p0G0c1eE2GWYVfQTwRqqdmT0FGv9g8Ow6GSEcZzpM36TspHc8ikHh6dT
         9i1fycnI+kJR+cSgnLVFFndJ8JxK45n0fiig+dXCo1t1n0qHEBa66JmS7QOhcOyj3sX3
         hu68bDe0i5pclpmjrnyOa7gTu7tJz9Xz0+3anEPTz4tcqYro8wZHRWAM8M9NB7mxQwTj
         PqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FErqBbW53lt1oYTJBI4ZMRwKkKRNvMor2XnjX9IKwDU=;
        b=lm0TkmHWvhekgPfijdLfSfYailYO3ic1km/Wxd4rdldJ31wyQNtmTK2MZHg65O6Wqn
         xQOMS2SI14AaUOhRP5LmMjlPy0wLnleuyqdjZhJEl6AgpMtK9IXu9hlEtDh5F532rN3F
         kgNTgEp2uIf4DCjP3bJazYGxa9g4jn/KDw1jYTVarTqCDDr0gcddzNYfhn1ltat8FUbZ
         mNNhN1F81Umrf2RpaS17eS2hziyOvxFtmda9nqhJQQlk87EExngm/dvH6in+lqvhJJrK
         K4sW/lJLBRvtc+K6Z2bVhsot6J8AcEppNPOlh9oSp/V8ea5BKlz3VAyxLSk6JEhDduPe
         RKAg==
X-Gm-Message-State: AOAM532xoQuKXBNYpFMYNmOmY+9U3JbNqjr8lwKkd/xZUzLDgS3xSo5f
        h6YKt4f+LmBNHtOOh3/iHCraoQ==
X-Google-Smtp-Source: ABdhPJwkdRz0NAGllckMzltDZM3x4h9FXDVnPJctfuKkz0c09O8W+4cxjS2dPDGLW5sgYxbyOUW+oA==
X-Received: by 2002:a5d:53c5:: with SMTP id a5mr1821540wrw.328.1640171703882;
        Wed, 22 Dec 2021 03:15:03 -0800 (PST)
Received: from google.com ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id p23sm1443007wms.3.2021.12.22.03.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 03:15:03 -0800 (PST)
Date:   Wed, 22 Dec 2021 11:15:01 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Kiran Gunda <kgunda@codeaurora.org>,
        Bryan Wu <cooloney@gmail.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 1/9] backlight: qcom-wled: Validate enabled string
 indices in DT
Message-ID: <YcMIteikWuR8S4Vk@google.com>
References: <20211115203459.1634079-1-marijn.suijten@somainline.org>
 <20211115203459.1634079-2-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211115203459.1634079-2-marijn.suijten@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2021, Marijn Suijten wrote:

> The strings passed in DT may possibly cause out-of-bounds register
> accesses and should be validated before use.
> 
> Fixes: 775d2ffb4af6 ("backlight: qcom-wled: Restructure the driver for WLED3")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  drivers/video/backlight/qcom-wled.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
