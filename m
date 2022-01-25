Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30AFF49AD08
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 08:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442164AbiAYHGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 02:06:10 -0500
Received: from ip59.38.31.103.in-addr.arpa.unknwn.cloudhost.asia ([103.31.38.59]:48360
        "EHLO gnuweeb.org" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1376648AbiAYHEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 02:04:16 -0500
Received: from [10.5.5.3] (unknown [68.183.184.174])
        by gnuweeb.org (Postfix) with ESMTPSA id 81C96C317D;
        Tue, 25 Jan 2022 07:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=gnuweeb.org;
        s=default; t=1643094247;
        bh=3i058DVKQlYsfwYKEaGSqiqciIFIbPRYmTn0V/pN72I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oHdJZrgTp28F9DTYtcxBCOSNatT991wTstu8B4DElfZLkHNSM29Vf0oEKOVV4pvC6
         Bf8auM+KG/QV2Gy4TNW7mIYVLE3/hysuL8vH+RpQZrYgF0lZF0H+2qifj8YUrFxaxn
         cMGiMEKgsoJD7SQ8rMmAhHIu1Vovx04kBhkr40vtXFEJj/dfDPkSZyppoATHhQ11Ao
         +BIludh26UDI2TgZI6VjvVhFMuWefAUDmdatVzeVFAH0ncIUuqzKTrUijTHLm09tt/
         UnBvK+Oy7ecPa3xPraqQp7eUHoOtSkMm/svxsNSkML/DpOVBQpFbcg8nzGUUjB1RaX
         veTidWJ1nDd2w==
Message-ID: <df2d15fe-bc81-bdb1-1c31-2d717f274ab0@gnuweeb.org>
Date:   Tue, 25 Jan 2022 14:04:04 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] rcu: Add per-CPU rcuc task info to RCU CPU stall
 warnings
Content-Language: en-US
To:     Zqiang <qiang1.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <20220125024744.4186726-1-qiang1.zhang@intel.com>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
In-Reply-To: <20220125024744.4186726-1-qiang1.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/22 9:47 AM, Zqiang wrote:
> When the 'use_softirq' be set zero, all RCU_SOFTIRQ processing
> be moved to per-CPU rcuc kthreads, if the rcuc kthreads is
> being starved, quiescent state can not report in time. the
> RCU stall may be triggered. this commit adds a stack trace of
> this CPU and dump rcuc kthreads stack to help analyze what
> prevents rcuc kthreads from running.
> 
> Suggested-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---

For https://lore.kernel.org/lkml/20220125024744.4186726-1-qiang1.zhang@intel.com/T/

```

Reviewed-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>

```
Thank you!
-- 
Ammar Faizi

