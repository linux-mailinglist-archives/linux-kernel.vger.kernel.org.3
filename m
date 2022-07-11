Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7725E56D855
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiGKIj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiGKIje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:39:34 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A569560ED
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:38:38 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l42so2547051wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rki+odzsv9YlhhSWAtjhmQziUygm1LhrWA0FgJOf8yo=;
        b=jZI5ApmoqAHHiqCe+byipnEy1pj+p5tVcUrkCrvTBZxdCxTp7maFlK2nu0cyMK+tUJ
         VN6Oic2vDgLVkdAx8kd/4kkKPlIc0T1gvBQ3D/YDn6b9f0F90kZjEFmpleI2SoAJw1tI
         r0DmHq9G3P1KVFpZyBFaT670cZD7eBbnBLewgR8T5BP/VI/fRvJcsp2uCncqVl8kQA4J
         BjHLcoboUTcXjeYf5kY7lY14/+ie6rdP/2EPo5HBfX6LSDH44V9f505LHipJtRhsItQz
         HkX7807XOggRqljikcT0LpH1Pft43LWSecjErsk49/7rX1IX+h1leTsIGmw/EWG1KVu2
         mlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rki+odzsv9YlhhSWAtjhmQziUygm1LhrWA0FgJOf8yo=;
        b=c9Q7Ky6rS7KC8FlDP7o4WLUF+/0U0FGoU6lvcLQR9aQct1yaZnHn3CSWw+Ygijktjq
         qtpBsePhjdsi4i3CuuPJSnWmshqXHS8HrTSc1sh31Stv04ADlRLdDBqe4rpBmNX+YSOP
         SzdeDktJmynX+fNvzxDxpgfnkrkerkVddWcASvFsDDPeosda321LScE17QC4blnamsVs
         WIIn7dCTo/MCDBiqinkt6QEBtIrJV82wKOn1UyaglKCzFT79qfvzK/KsuA0F9YPYq3kw
         zGTKQ5HUXAJL8xp/I3IOE4FlUY6u/ACnXozbL2soUTRSDalBzOvnKbHqXAsgkADDgu/j
         N7WQ==
X-Gm-Message-State: AJIora/l2xVP78nTr9TA3ki3TgI8FOj6bJIU2fswczteGzhfZsNAj5LB
        eRbWd0bAZB4PTnhHZcEw1/uoIw==
X-Google-Smtp-Source: AGRyM1uSEKvweGQshJKphLOkadNXWfUWbyxoC2MQD1C/gn02OgQirvWrJq3tmsqN5vk95EhoS1kgqA==
X-Received: by 2002:a05:600c:4f54:b0:3a0:4a5b:2692 with SMTP id m20-20020a05600c4f5400b003a04a5b2692mr14954539wmq.109.1657528717049;
        Mon, 11 Jul 2022 01:38:37 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id a6-20020a5d4566000000b0021d6f03b524sm5213788wrc.48.2022.07.11.01.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 01:38:36 -0700 (PDT)
Date:   Mon, 11 Jul 2022 09:38:34 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 11/11] mfd: intel_soc_pmic_bxtwc: Fix spelling in the
 comment
Message-ID: <YsvhioGMiyylKD3j@google.com>
References: <20220628221747.33956-1-andriy.shevchenko@linux.intel.com>
 <20220628221747.33956-11-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220628221747.33956-11-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2022, Andy Shevchenko wrote:

> There are a few of spelling issues in the comment, fix them.
> While at it, fix indentation in the MODULE_AUTHOR() parameter
> and update copyright years.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: more spelling and grammar fixes (Lee)
>  drivers/mfd/intel_soc_pmic_bxtwc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
