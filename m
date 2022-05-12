Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1DA524174
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 02:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349613AbiELARN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 20:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345344AbiELARJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 20:17:09 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0048814913E;
        Wed, 11 May 2022 17:17:06 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id g16so4574883lja.3;
        Wed, 11 May 2022 17:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6ewN4iebyG9uMgew1c//0eeNZDOPRJNH8c+AIOoPtww=;
        b=I/D3IQssuH9XhW4LG1S8Ij/AirFKHPjUHHDdVkyRnf+QiaZCVa6ciRWZAD7Bi2Pyxt
         cqujdsSbRBf5BppjlGnqydo7noSBRZ9kAsYd8p+9zHh2ZnJZ8Tr6U2LPo96gHcdX/Ycj
         fvwu4KYwTT2GbaYgMOurp8elrvkG3yf7eNiyANvgE4VEU8WM4RqRfTGdKGRdBLz0pBdA
         HK4mA6DueIjj0ZR6neU05sZclXW2NxgWOaZ7lzUW2Q7OjvSk5Ne9SOSs3yl5hq/Xvc9o
         FOv0OqZMU9P5XEOjYyaNn/INcz2bxCRW7ZwD3lvk0e+OOWHpcH2txGxRhal2ToH6ZPUW
         fqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6ewN4iebyG9uMgew1c//0eeNZDOPRJNH8c+AIOoPtww=;
        b=2P2QRiIbTx3h0X8jW9eYPlstYSlYTF9ODWBuDjj8ePGjhkKderAVqMGtqZH3eS+uL3
         dPbFj/mGZz5BmVJPZOgSLVBcvjf/DBvVs1WtfvIjEWsTAHxqXgw9/qGWUHhwbcniPOAY
         1kFWIpjv9ANEZf814dhf1kUAhPg+q6fsDnLHU/SMJpo8njqVmerkFwg+wUEzUL96pOs4
         UpNNOCPL5YswKZW1KieH957KfOjhM2CL6SP48exL/8SAILBI/tyM+2dMVNXJJ84vXjFo
         QYa62oBzVJsuIs8zIHrMH3r3Hc97RZIjU32tTxHmYfy0kUKWuvStfuBZ7RXP0JiE6DtD
         4nsQ==
X-Gm-Message-State: AOAM533UEKi3a9t5q8xIjECYRZrEajBPvseCLxkQukQLgX3/yDXdpNi1
        UNtbMlG9JKueH3RR9EbN1L0=
X-Google-Smtp-Source: ABdhPJytZO4CvmhspGSwFD2e5Vgp3ZwOtKrciZj9kXfeEmlIwA/B6ZuKw8AWR3CBePT65bMn9m6A7g==
X-Received: by 2002:a2e:9993:0:b0:250:b5a9:18dc with SMTP id w19-20020a2e9993000000b00250b5a918dcmr14870158lji.364.1652314625399;
        Wed, 11 May 2022 17:17:05 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id o18-20020ac24c52000000b0047255d211bbsm507362lfk.234.2022.05.11.17.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 17:17:04 -0700 (PDT)
Date:   Thu, 12 May 2022 03:17:02 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-spdx@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-mips@vger.kernel.org
Subject: Re: [patch 03/10] clocksource/drivers/mips-gic-timer: Convert to
 SPDX identifier
Message-ID: <20220512001702.japqljr6ayxyzwn6@mobilestation>
References: <20220510171003.952873904@linutronix.de>
 <20220510171254.529249404@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510171254.529249404@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 07:24:40PM +0200, Thomas Gleixner wrote:
> The licensing text references explicitely the COPYING file in the kernel
> base directory, which is clearly GPL version 2 only.

Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Serge

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Serge Semin <fancer.lancer@gmail.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-mips@vger.kernel.org
> ---
>  drivers/clocksource/mips-gic-timer.c |    9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> --- a/drivers/clocksource/mips-gic-timer.c
> +++ b/drivers/clocksource/mips-gic-timer.c
> @@ -1,10 +1,5 @@
> -/*
> - * This file is subject to the terms and conditions of the GNU General Public
> - * License.  See the file "COPYING" in the main directory of this archive
> - * for more details.
> - *
> - * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
>  
>  #define pr_fmt(fmt) "mips-gic-timer: " fmt
>  
> 
