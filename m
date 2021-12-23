Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0CBF47E933
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 22:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350357AbhLWVwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 16:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbhLWVwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 16:52:07 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B70DC061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 13:52:07 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id w16so26226996edc.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 13:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=prwaM6mYrGIwUEQUdwxVqfoXUWUvgyYN9XM4sUL4t7I=;
        b=GE14HRQo4fAeKredrKTDr0sQVdzRx75sLOhFAusKTAwO3/ILlFrztbge24wVltNwTL
         LPG/4o+Ng/ZyWz8tQDqSjwpTclkX1dZd1ivrYIENm56tBkVpZRr7eUvKtbPf0QLwj40R
         MQE9Lrw0EPVx6bLcoZYGNZuuTDDV9FGQfupWeJBi3bYB90ccAApUXJUccW7nSTS2bJwB
         EeAcqwhPZIuuAnkQFvOlus69LfVj6dZ5TlpogPUW7wxNU8CJUdGgo7BPnQU+/lNeEvPp
         EmD+RHB1sZWa40UNv3SyZdnAQVtle/GPJcTZlVbdGUBZw8L6eh4I1Xsnnb/yoixGSgEq
         2hwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=prwaM6mYrGIwUEQUdwxVqfoXUWUvgyYN9XM4sUL4t7I=;
        b=ZJxpEqGXmyibBoxnzwMl3FLThBEfsYkoARk49tUVDZcGqf6LsjgUBfwEoP0KosuV+t
         y43OMNPz8nv2QVrUNGHj8eUvj0sbUf2/Md2jiOB4+8eJsDOnMGIkyWjnPgYiKPmigeAy
         BPFxoeHh4sw5KLczBumzAcdKcg120BRyNfWrb0uFGQirAbYl91TMR8Th3b5wfn/gy8F7
         5VPeZhoXEWWc6TygLPC9AWFXDY2rPHWBBHUBbWNzoRwTNu33pY77fmNuvwE+CMqKy5jw
         bRAZDhDrApYfgt8S5yvWNDmLn2XfFWfM7bokD1eBSLKOKQbNzxPC6e5z449sLWnXJcaT
         R6fQ==
X-Gm-Message-State: AOAM53355BtG9U44xIvBL4ADaJctVv+6bkAG+KHvI1XkMvOTCRIKRLgY
        GuDvERKXZ11jcZLi6xT7RFU=
X-Google-Smtp-Source: ABdhPJyPZ/ftgPar6FQniTBdw2Rtzdi9UH09YTD64KW+Is4jVEFnRl6r/QFIdPb9zOlOVdwzs3fgWQ==
X-Received: by 2002:a17:906:c788:: with SMTP id cw8mr3378744ejb.528.1640296325673;
        Thu, 23 Dec 2021 13:52:05 -0800 (PST)
Received: from tom-desktop (net-93-71-218-227.cust.vodafonedsl.it. [93.71.218.227])
        by smtp.gmail.com with ESMTPSA id q14sm2439565edd.40.2021.12.23.13.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 13:52:05 -0800 (PST)
Date:   Thu, 23 Dec 2021 22:52:03 +0100
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxfancy@googlegroups.com,
        Forest Bond <forest@alittletooquiet.net>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Aldas =?utf-8?B?VGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: vt6655: drop off byRxMode var in device.h
Message-ID: <20211223215203.GB7322@tom-desktop>
References: <20211220202523.21805-1-tomm.merciai@gmail.com>
 <YcF1baxVvP3j8Q/8@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcF1baxVvP3j8Q/8@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 07:34:21AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Dec 20, 2021 at 09:25:20PM +0100, Tommaso Merciai wrote:
> > Drop off unused variable byRxMode in device.h, this fix following
> > checkpatch.pl check:
> > CHECK: Avoid CamelCase: <byRxMode>
> > 131: FILE: drivers/staging/vt6655/device.h:131:
> > unsigned char byRxMode
> 
> No need to line-wrap this.
> 
> But this "problem" is not the real thing you are fixing.  The real thing
> is the issue that this variable is not needed at all.  Just say that, no
> need to justify it with a checkpatch warning, right?

Hi Greg,
Thanks for review. I'll fix commit body and resend in v3.

thanks,
tommaso

> 
> thanks,
> 
> greg k-h
