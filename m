Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7F7475C97
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244367AbhLOQCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:02:23 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:58866 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243988AbhLOQCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:02:20 -0500
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1BFG2JCI098165;
        Thu, 16 Dec 2021 01:02:19 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Thu, 16 Dec 2021 01:02:19 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1BFG2EZM098146
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 16 Dec 2021 01:02:19 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <8b080deb-adcc-4490-8e1d-5be789b1fcff@i-love.sakura.ne.jp>
Date:   Thu, 16 Dec 2021 01:02:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [loop] e3f9387aea: stress-ng.loop.ops_per_sec 78.9% improvement
Content-Language: en-US
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com
References: <20211215135803.GA34913@xsang-OptiPlex-9020>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
In-Reply-To: <20211215135803.GA34913@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/15 22:58, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed a 78.9% improvement of stress-ng.loop.ops_per_sec due to commit:
> 
> 
> commit: e3f9387aea67742b9d1f4de8e5bb2fd08a8a4584 ("loop: Use pr_warn_once() for loop_control_remove() warning")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 

Avoiding printk() flooding will reduce latency, but I'm curious
why the testing program is trying ioctl(fd, LOOP_CTL_REMOVE, -1) ?
Since such ioctl() is pointless, measuring ops_per_sec is also pointless...
