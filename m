Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACEA4B08D1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237944AbiBJIuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:50:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237904AbiBJIuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:50:06 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F8EC35
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 00:50:08 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id l67-20020a1c2546000000b00353951c3f62so3369047wml.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 00:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2HIB1M6jwQ5nWTEfvyIdVxfSERSQYYsQThkMz/GI+18=;
        b=IH56MEnePQNyrWyAv3s1h7/TzNSubqet2B8uOHEHxFy17F6USuEdC9NR48cJTD6OS4
         rxx0qe4d31ECfCWbDsxLb0JOsXR0qlXS6zYF6PSNa4rVsj/eKyhXys8tTiQHkhSpuyJR
         tGwADAfj7HZ8vtTDLosMaNFLAehdWGHBVkYiquWGooGddppA5kpfJuuRBGi9EXj3y5D8
         acwpcprxgdt/MvzSpFDSwt2zClRVHqTEFwZc84OPSYa8gT0RdckBOX3NnQDSEwsBDpMa
         8eoKjmVNCdCxI81lrAXiyobIRfIERTelxePO0YXerL1inVUHAlrITywKGB30uy6hN6QT
         Egnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2HIB1M6jwQ5nWTEfvyIdVxfSERSQYYsQThkMz/GI+18=;
        b=4kOZyQnGi+Abrr8/FR9g8AosSmBJGSowg/Bm8FgmYP3AqKunym3E2vNi37ot+7zMws
         fqiq5VMXtNFo56f0cjvF8yt0MrK6URdIb93kCETiCIPKPAhJWSI85UJrKGyeAXVvLXPz
         9j+Br577MW0RUfjJwUIsALYq/ijIuQG01tK7mmbPJ8MTWLKiVXXOaA27Oaypr8eVMFNK
         +kMMgCRLCritsXXQGI5x+4TGVqyQ0n/Wo/wPhNtav6ZZ4zc2AsbzW3ma1mTItYWbWmJr
         tjMhF75h4qnMSCTX1Q5ev9OMytQz4bgQnWYKY8oc1c6i3wum6irnOvIXmnFLZKWT87Q0
         CG9w==
X-Gm-Message-State: AOAM533LJjd0uEIzQ2vrRRxK5fXioAfnyLi0jLM5y+2j1sJjkLAnPIwX
        SL/CvT/u56WCwLFFFIVT87U0bVQOTXzayUtQ
X-Google-Smtp-Source: ABdhPJwwzb/7D0/gDBMBQu8hIp2d95PYNzftq0RpMbqRA4tyhaG7fB4bs00eVkfRZaC9yEH/rwqreg==
X-Received: by 2002:a05:600c:4f08:: with SMTP id l8mr1237441wmq.112.1644483006565;
        Thu, 10 Feb 2022 00:50:06 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id y17sm857020wma.5.2022.02.10.00.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 00:50:06 -0800 (PST)
Date:   Thu, 10 Feb 2022 08:50:03 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Alistair Francis <alistair@alistair23.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the hwmon-staging tree
Message-ID: <YgTRu7iLgJMymeT5@google.com>
References: <20220210185123.4d39766c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220210185123.4d39766c@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2022, Stephen Rothwell wrote:

> Hi all,
> 
> After merging the hwmon-staging tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> Documentation/hwmon/sy7636a-hwmon.rst:4: WARNING: Title underline too short.
> 
> Kernel driver sy7636a-hwmon
> =========================
> 
> Introduced by commit
> 
>   de34a4053250 ("hwmon: sy7636a: Add temperature driver for sy7636a")

Oh wow, that's new (to me), and a little petty, no?

Would you like me to apply this patch to my branch Guenter?

I can either send out a new PR, or let it wallow.

-------- 8< --------

From: Lee Jones <lee.jones@linaro.org>

 Documentation/hwmon/sy7636a-hwmon.rst:4: WARNING: Title underline too short.

 Kernel driver sy7636a-hwmon
 =========================

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/hwmon/sy7636a-hwmon.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/hwmon/sy7636a-hwmon.rst b/Documentation/hwmon/sy7636a-hwmon.rst
index 5612079397d52..c85db7b329415 100644
--- a/Documentation/hwmon/sy7636a-hwmon.rst
+++ b/Documentation/hwmon/sy7636a-hwmon.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0-or-later
 
 Kernel driver sy7636a-hwmon
-=========================
+===========================
 
 Supported chips:
 
-- 

Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
