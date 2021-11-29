Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E836B461A6F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 15:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244980AbhK2O6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 09:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240850AbhK2O43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 09:56:29 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1312CC07E5E3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 05:17:54 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id o13so36621458wrs.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 05:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=TufeQEGFPXdPqZUewAvDpIDz7hRA8J+tU2fgiZwFK3s=;
        b=Rh2nwXPnvA9iuBIYM2mJCjDkGte7jZWqfXb9ApWOfiwSTUSNP4dZhoUcy0FCOmAPaZ
         s6IQvCVpoVJaWJ39WB8qGbG/FjaZ69p9XhFOCS0ht+5ZEQxi+6s7I4ODu7ZK06UJH2QB
         CXVwCr//Ow7inoB7iR4FEcxRs+ivyRHCoygZkEYp2YcTSeIqCXYhs1Gv1reHegc6/nK5
         DuQXq/N4zm+SWqL7eAhzZyOKECQ6uiYgg3rTdQIBiQLfJSFx9Pjsh0Cb9/XHLwxn8f8+
         R95wIhtjdkUCp38WVAZbV7jLAy1OzJBfu6FovdPuvZs/46vT5hLXdzL2ACwX4LLfaCP9
         f8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TufeQEGFPXdPqZUewAvDpIDz7hRA8J+tU2fgiZwFK3s=;
        b=2uPWjl92CDjj2jwLLrkYqm0gQ8M54SXESWQyhB7VDE5mrfhWUZ14/0sg5AEkf5GKJC
         Hejv+keAhoLvR/3FR8QFahvJ8PV9Jr7C5LI9HVTmL77t6lD6H2rEV/dRHZIECP93EWb+
         08R7wKwXkpOumFfRPfAm7sAqWxn8N6y1Cyj7NRP4Jz9DduYUoSVWrJo1WOb+4dColdwe
         zBV+MjdpqfgCXUNqZPcyjE/HaNruAVBlxgqLt/HvMiBLzLzmANV6u3hHZ+Z4kgE0Pxku
         GeX87j248tpOmiVaJTPsAlwBvAdBo+Uyh4ZSsEPw+Q4WCEPowY8R27iCao5K6Ex3WfB/
         yM8g==
X-Gm-Message-State: AOAM532657uutktF2VlOWuEKB3UnIw41Upi6yp77pxzuxVN0S9k9MHDp
        JJTb+3ocTSI5wd/wskNGPxiwNQ==
X-Google-Smtp-Source: ABdhPJxQTo38KGVz5QhFkfSjcXgQk7w89OcRlvyUQzIvM0KWq9+nkcNGUHA3aegfkb82x2rH9FY91A==
X-Received: by 2002:adf:fbc5:: with SMTP id d5mr36439746wrs.291.1638191872656;
        Mon, 29 Nov 2021 05:17:52 -0800 (PST)
Received: from google.com ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id l15sm14438472wme.47.2021.11.29.05.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 05:17:52 -0800 (PST)
Date:   Mon, 29 Nov 2021 13:17:50 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: syscon: Add samsung,exynos850-sysreg
Message-ID: <YaTS/l1wYV892JSn@google.com>
References: <20211126230620.478-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211126230620.478-1-semen.protsenko@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Nov 2021, Sam Protsenko wrote:

> Document Samsung Exynos850 compatible for system registers.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
