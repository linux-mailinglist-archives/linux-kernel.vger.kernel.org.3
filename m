Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B389D58CC03
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiHHQSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244001AbiHHQSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:18:41 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACD316589
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 09:18:35 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q30so11423505wra.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 09:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Z19dFDbfMfqUQi0JU5AuVbO4SbHGSlL3KFoxAsrT74M=;
        b=ph6FVxG/RQCvhcwXXTu+2zerIFOdFV5cimmJm7WcOGuZJT9M7FMjeu3gh3J2Y+h7UN
         dnnCEVUad0fxBckX87SZ8XyZyWr9Jcr5MDdOLUBVG60xezsEExVievOad2uCwtJ8fID6
         G/mSVMH/b2EI5nGiPMSmEoDyk70N331w8W/P5Tpk6hReT9XTv4ttaYrtzwoL0NTP8Y0r
         03bT7ZMXPZQl18hGNIfT/1g0c30tgHPFqofv6Ch29NuawEtRh5vObzqeGNkFOM0dhat1
         FMBlg6Qocg5biyVGbX/LPXWwVp+QbVHVt8UypO/F7A7ac57phE4m+6qjzSPXV//chPF1
         F3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Z19dFDbfMfqUQi0JU5AuVbO4SbHGSlL3KFoxAsrT74M=;
        b=r0T0elsEPzm0zYzlUkJqy/PEeKG2Pt8SWuZEAjMCyRkPW1Yq2JKgM+s2gQ5LzHWVOx
         f0ZdfB4DVhIQfqbc+Ra56kNvkF0mhAy9AltCNLnWR/ZKVYjl9H3O8h4D10vffaAJ9yA1
         L1b13cj7HWW+uojAGzCuqvbTUpxonTVSTjDSzQci6BCW8IiRgpQSQhrVrfeq48ZAH6rH
         uEMot5oBBkeH2ByUOtUkUvPcXlt7UMYLv2L5N+tS7oYJg9FOclONbI5HylaoBlleDcng
         LfmQfyKP30oewg9xj9/lyLYM0YHZWBhhq9OjAvjrohprJtv96CyxnVuMaCb+ucr8vKUw
         jUJg==
X-Gm-Message-State: ACgBeo00BXyp3qFs/B1azyJfzybjzDMtV/7Q872XBKtFCTVPyLXhzqpO
        F4x7rlP7q1LUWGLpH4RGMBzWqw==
X-Google-Smtp-Source: AA6agR4+FdpLD8IgS8BClpbgq1I26luWkEpwOb7enam7gc/AUfjhQ63uZnLwciMMg53oVS5bRcr2dw==
X-Received: by 2002:a5d:5a1a:0:b0:21f:a9b:62c6 with SMTP id bq26-20020a5d5a1a000000b0021f0a9b62c6mr11612073wrb.20.1659975514157;
        Mon, 08 Aug 2022 09:18:34 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c1d8c00b003a54d610e5fsm1922931wms.26.2022.08.08.09.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 09:18:33 -0700 (PDT)
Date:   Mon, 8 Aug 2022 17:18:31 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v3 10/10] mfd: intel_soc_pmic_crc: Update the copyright
 year
Message-ID: <YvE3VwndursUy+i9@google.com>
References: <20220801114211.36267-1-andriy.shevchenko@linux.intel.com>
 <20220801114211.36267-10-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801114211.36267-10-andriy.shevchenko@linux.intel.com>
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

> Update the copyright year to be 2012-2014, 2022.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Hans de Goede <hdegoede@redhat.com>
> ---
> 
> v3: no changes
> v2: added tags and rebased on top of new patch 1
> 
>  drivers/mfd/intel_soc_pmic_crc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
DEPRECATED: Please use lee@kernel.org
