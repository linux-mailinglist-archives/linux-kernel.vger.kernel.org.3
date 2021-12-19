Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBF1C47A131
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 16:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235997AbhLSPpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 10:45:51 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:62928 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhLSPpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 10:45:50 -0500
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1BJFjmpr061440;
        Mon, 20 Dec 2021 00:45:48 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Mon, 20 Dec 2021 00:45:48 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1BJFjm28061437
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 20 Dec 2021 00:45:48 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <dd707dfd-6421-b1df-4820-e30787b84181@i-love.sakura.ne.jp>
Date:   Mon, 20 Dec 2021 00:45:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [loop] 322c4293ec: xfstests.xfs.049.fail
Content-Language: en-US
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        syzbot <syzbot+643e4ce4b6ad1347d372@syzkaller.appspotmail.com>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com
References: <20211219150933.GJ14057@xsang-OptiPlex-9020>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
In-Reply-To: <20211219150933.GJ14057@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/20 0:09, kernel test robot wrote:
>     @@ -13,3 +13,5 @@
>      --- clean
>      --- umount ext2 on xfs
>      --- umount xfs
>     +!!! umount xfs failed
>     +(see /lkp/benchmarks/xfstests/results//xfs/049.full for details)
>     ...
>     (Run 'diff -u /lkp/benchmarks/xfstests/tests/xfs/049.out /lkp/benchmarks/xfstests/results//xfs/049.out.bad'  to see the entire diff)

Yes, we know this race condition can happen.

https://lkml.kernel.org/r/16c7d304-60ef-103f-1b2c-8592b48f47c6@i-love.sakura.ne.jp
https://lkml.kernel.org/r/YaYfu0H2k0PSQL6W@infradead.org

Should we try to wait for autoclear operation to complete?

