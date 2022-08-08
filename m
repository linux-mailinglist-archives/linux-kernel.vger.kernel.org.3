Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3764E58CBE2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243933AbiHHQKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243901AbiHHQKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:10:15 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A19CEC
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 09:10:14 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q30so11398528wra.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 09:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=NG+r9AjGL139a34yJmXvgbFxyH32eTYxP//6rqaoDOY=;
        b=htyt6ts7nCnklVexoA5lDY36NmDcxk/eePySQAVgOtL0p5hRnpunAf05OIlaUt3nVn
         4vQgjbONmqJyEFQ/fMWTMEVvyrCmOsEr6SnXqYjuwXvIHtRD8uaJhU7oiltoGzs7wGNl
         Q33yuKMPs98NA19cIqMBgPlCMOppnHiND/H9hvYwIxqGSlkQ//Tb3mf0UBM/9FetD1yB
         jn084q4yK4pTnrK8igtPuK3VcwrwycvI1UOWg8z8ty773ni9lDhESnZCxGPKS82xRSMV
         /mEcVIX4F0IYGXrchLWAGGD2uJXwnhQTgbhe8jzD5NhkMsFigo8HyCO2MHjnO3rWAr+M
         Z+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=NG+r9AjGL139a34yJmXvgbFxyH32eTYxP//6rqaoDOY=;
        b=JBo5/MLzzIfQ9v/7JQ3B1vF1PL3SvuTH5ZXUXlHv2D2vBSinAx7AB+p/v4+9mL+BEJ
         7g74yplXHYX9+PAVayjhuGNfCF5pg4o1//ZO59QQZtaP02VX3oOdriwOGjBsKtFEI5XV
         zq4FTGZtIiLtAp1NWY58HDo7TKPm84/Fx5NWsO1E1VaJRvLcjUi6wX4GmfMTDuq5xMkl
         hlwFJAjqlTSU7pm2U3H1PMWgI88z5HjDT3t86DqxXSus6ituZkP57NVu7/WrzYFlxqQ/
         s83EWl+WGrRm5vl4bZysGv9nQ4zLx8doxrAblG5JzZOSUfBIuSt6KFwJstl9c5WJrRpu
         Asow==
X-Gm-Message-State: ACgBeo1gvJQLfaApQjZXI8anMRLk7BuXGWHJohWwVPz9+U94uRPzkJef
        gms2pfGkRCiVMhRSk+XwN5MQdiH0KEoeYg==
X-Google-Smtp-Source: AA6agR5pyyi+7oUtV2sxBIV+mAVXJiyka2gUlqUEiOOJiqeOac1BhROX79JxAYxxsJIp3qhkhNYPhg==
X-Received: by 2002:a5d:598f:0:b0:220:8005:7def with SMTP id n15-20020a5d598f000000b0022080057defmr12262580wri.435.1659975012916;
        Mon, 08 Aug 2022 09:10:12 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id z11-20020a5d44cb000000b00220688d445esm13782586wrr.117.2022.08.08.09.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 09:10:11 -0700 (PDT)
Date:   Mon, 8 Aug 2022 17:10:09 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v3 02/10] mfd: intel_soc_pmic_crc: Merge Intel PMIC core
 to crc
Message-ID: <YvE1YWuNwOqLtOdH@google.com>
References: <20220801114211.36267-1-andriy.shevchenko@linux.intel.com>
 <20220801114211.36267-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801114211.36267-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Aug 2022, Andy Shevchenko wrote:

> The core part is misleading since its only purpose to serve Crystal Cove PMIC,
> although for couple of different platforms. Merge core part into crc one.
> 
> Advantages among others are:
> - speed up a compilation and build
> - decreasing the code base
> - reducing noise in the namespace by making some data static and const
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> ---
> 
> v3: removed not used file (Christophe)
> v2: added tags and rebased on top of new patch 1
> 
>  drivers/mfd/Makefile              |   3 +-
>  drivers/mfd/intel_soc_pmic_core.c | 161 -----------------------------
>  drivers/mfd/intel_soc_pmic_core.h |  25 -----
>  drivers/mfd/intel_soc_pmic_crc.c  | 163 ++++++++++++++++++++++++++++--
>  4 files changed, 158 insertions(+), 194 deletions(-)
>  delete mode 100644 drivers/mfd/intel_soc_pmic_core.c
>  delete mode 100644 drivers/mfd/intel_soc_pmic_core.h

Applied, thanks.

-- 
DEPRECATED: Please use lee@kernel.org
