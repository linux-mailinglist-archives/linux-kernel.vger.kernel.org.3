Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E625796CD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237372AbiGSJzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237362AbiGSJzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:55:33 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1BE17586
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:55:32 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id n12so7935669wrc.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5yDkOtlAe9vL/L2al5l5LMl+NNmwVqD573vsdM9I5QA=;
        b=YHJ5iM1G9OhuRCD6TCVIf5Bdn3cxiw7FtAOJbP1qcEcZFvmWXQ+WPhU8LZx8CwTmsf
         j2tOdxVYDfEseSPOr0Y0YU3r2ObNF2GoFy49pE8AL9pbqAVxu+5G7WzMTqDbW7yO+0Lc
         rEYuGbEcaEbFbFLuxmkaBkT5tRyzDdr3+OxDQc1z6hCTodNmbgOxp6tdBF6dtzGsT8Mh
         rHoV+Gn5U2PJ63g7Ohl1mtBR5u8jiUW2ioeYtiqgfySpGn9ohnp60s3oHTP5ISOP3teL
         WQkq4prnbyVbTdsFSOF8lYn0/pY8e2d6GK2uRGQmTGCDotk2AEO7ncVNXACPJ4Lf8oer
         RLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5yDkOtlAe9vL/L2al5l5LMl+NNmwVqD573vsdM9I5QA=;
        b=QS+Z6g3q6NRdvdohTNkDL6m/ZkTxk/W3OzwhWgD6eukRK1ltrnMx1K/1ma3+kjh3tv
         +wlS6uXEuV95linhABEYks5tTrw0VVanQ8Iw681WG+XbEMzAs6eepiTDrKEYKSaqfFw5
         wGtfoPSYVg8GXjyxVprKLgx+VwpHEwqWlDEEPUZA9R++rkIPR0rV1xq1XiCYryU6V+29
         mQLqkxlFl7jaz7UvgyQbP8zgudL1/Yuq2ozPeNKR86scW72FCunFsCAtFWMqz1UtvewO
         PzQaQAZD2O68AJYAvbyj3CQ63RDVKC9n0AevfTC7I2cN2Jb2XOIuqHTxEmCS+V5ECp7h
         LZRw==
X-Gm-Message-State: AJIora/kGLVeeb/ePPGBl85iwwSHzZjjNKbO2enOirAMPSTxuDmOg8vo
        /TH/wVQvV7c/hSNVB7CIRno0nQ==
X-Google-Smtp-Source: AGRyM1tULiAhtM3cy8u8SzKb14DAaziffDMi8/b7AdNp7aK48mmM3DNI51+m4VdGnLYgGDK5FRml5w==
X-Received: by 2002:a5d:414b:0:b0:21d:6e93:59c8 with SMTP id c11-20020a5d414b000000b0021d6e9359c8mr26516676wrq.290.1658224531174;
        Tue, 19 Jul 2022 02:55:31 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id f2-20020a1c6a02000000b003a2e89d1fb5sm20764362wmc.42.2022.07.19.02.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 02:55:30 -0700 (PDT)
Date:   Tue, 19 Jul 2022 10:55:28 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/8] MAINTAINERS: Use Lee Jones' kernel.org address for
 Syscon submissions
Message-ID: <YtZ/kA0uwLvdSirf@google.com>
References: <20220714112533.539910-1-lee@kernel.org>
 <20220714112533.539910-3-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220714112533.539910-3-lee@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jul 2022, Lee Jones wrote:

> Going forward, I'll be using my kernel.org for upstream work.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
