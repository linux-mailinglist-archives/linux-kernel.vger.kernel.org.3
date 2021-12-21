Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B73947B8BF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 03:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbhLUC5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 21:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbhLUC5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 21:57:40 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98675C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 18:57:39 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id d198-20020a1c1dcf000000b0034569cdd2a2so1143504wmd.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 18:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=W8JMZ3O6Y1Nv4mdaK4T7/Adbb2+07hxa7CLccEzPQP4=;
        b=gsddEaPw/0t+yBLvu9qR5UljsERFQisY7VWMnFEvUaRY1AkEcUTfo0rn0g9VHdkDEm
         Ff+1L1YqAvWfJRsd8xgm3xuS3H37jRy8/EY5bjduRuWK4ksUvVGyUlcJd4JKf5stAqfr
         hqmMDwqMukNa+K20F5l6OeY46shO9+3xlszB/RxDLsInWwj1J/ELKCruwz0esLTvbneZ
         /ktr2qaxBqTUJJzB3nHXoEIjqt2ZX+XoR0LBDllW/Q5+cXI0clY720HX9zhDKT4y6iH4
         r37CzbU7LaQwKRh9TUgqsgpTvQUVaQG7n7NoPLTFu+G97VAdyG0cGxWRSouOWHJvec+e
         ZUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=W8JMZ3O6Y1Nv4mdaK4T7/Adbb2+07hxa7CLccEzPQP4=;
        b=Y7fV+jZZnf2jr3hjg9O4XJI9RDbCF/3I8gnVknVrCkxsSlmGKvW7EXFa2mjKrTQkNa
         aJbmQu+G9PVe3c0XFQWeT67ucZ38QQT3YHrrklQi2hPdDcy9oPZg3F1e1YGy+99mCkJH
         nbfGDrkv+jAQoDN0yvO11wBp40HFQoEB53ANMAOvyp9KK4S7QYjfMAVdhCFSJ7IrtIBI
         e4UmvvmuGVePS2TnNJPsuEEyRC4WPwX54Pn7+tbrjYITsUH53F2s0E5kFLo4ZWxk/Ihw
         soiaEmqSnCFBegnMQlLa11Zur37QYtQqUY5CMvVvJqrgVLNrW7035Vh/HdahREvwbC5w
         YB4w==
X-Gm-Message-State: AOAM532MlWI/uk6L+OSB6UR+KyeILRVodCRWbYgsgyoumcUyZ9Ji0ZwF
        rZZRQcICGjNMSz+FdLrnQ1B7x5vG17EThA==
X-Google-Smtp-Source: ABdhPJwceKNs1a9+3M0/7aRYkTqjST7Nh3GnkzX0Ikjj1XjMNWM0M2HETWeaCFFBHTQPLZXA7vKwZQ==
X-Received: by 2002:a1c:7305:: with SMTP id d5mr728145wmb.80.1640055458209;
        Mon, 20 Dec 2021 18:57:38 -0800 (PST)
Received: from [10.0.0.4] ([37.165.23.95])
        by smtp.gmail.com with ESMTPSA id d143sm951297wmd.6.2021.12.20.18.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 18:57:37 -0800 (PST)
Subject: Re: [axboe-block:for-5.17/block 106/108] block/blk-ioc.c:307
 set_task_ioprio() error: we previously assumed 'task->io_context' could be
 null (see line 300)
To:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org,
        Christoph Hellwig <hch@lst.de>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>
References: <202112171520.5hNnOM0q-lkp@intel.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <9ebee41f-74e6-df29-35aa-d662cdca5c17@gmail.com>
Date:   Mon, 20 Dec 2021 18:57:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <202112171520.5hNnOM0q-lkp@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/16/21 11:49 PM, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-5.17/block
> head:   5ef1630586317e92c9ebd7b4ce48f393b7ff790f
> commit: 5fc11eebb4a98df5324a4de369bb5ab7f0007ff7 [106/108] block: open code create_task_io_context in set_task_ioprio
> config: i386-randconfig-m021-20211216 (https://download.01.org/0day-ci/archive/20211217/202112171520.5hNnOM0q-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> smatch warnings:
> block/blk-ioc.c:307 set_task_ioprio() error: we previously assumed 'task->io_context' could be null (see line 300)
>
> vim +307 block/blk-ioc.c
>
> a411cd3cfdc5bb Christoph Hellwig 2021-12-09  271  int set_task_ioprio(struct task_struct *task, int ioprio)
> a411cd3cfdc5bb Christoph Hellwig 2021-12-09  272  {
> a411cd3cfdc5bb Christoph Hellwig 2021-12-09  273  	int err;
> a411cd3cfdc5bb Christoph Hellwig 2021-12-09  274  	const struct cred *cred = current_cred(), *tcred;
> a411cd3cfdc5bb Christoph Hellwig 2021-12-09  275
> a411cd3cfdc5bb Christoph Hellwig 2021-12-09  276  	rcu_read_lock();
> a411cd3cfdc5bb Christoph Hellwig 2021-12-09  277  	tcred = __task_cred(task);
> a411cd3cfdc5bb Christoph Hellwig 2021-12-09  278  	if (!uid_eq(tcred->uid, cred->euid) &&
> a411cd3cfdc5bb Christoph Hellwig 2021-12-09  279  	    !uid_eq(tcred->uid, cred->uid) && !capable(CAP_SYS_NICE)) {
> a411cd3cfdc5bb Christoph Hellwig 2021-12-09  280  		rcu_read_unlock();
> a411cd3cfdc5bb Christoph Hellwig 2021-12-09  281  		return -EPERM;
> a411cd3cfdc5bb Christoph Hellwig 2021-12-09  282  	}
> a411cd3cfdc5bb Christoph Hellwig 2021-12-09  283  	rcu_read_unlock();
> a411cd3cfdc5bb Christoph Hellwig 2021-12-09  284
> a411cd3cfdc5bb Christoph Hellwig 2021-12-09  285  	err = security_task_setioprio(task, ioprio);
> a411cd3cfdc5bb Christoph Hellwig 2021-12-09  286  	if (err)
> a411cd3cfdc5bb Christoph Hellwig 2021-12-09  287  		return err;
> a411cd3cfdc5bb Christoph Hellwig 2021-12-09  288
> 8472161b77c41d Christoph Hellwig 2021-12-09  289  	task_lock(task);
> 8472161b77c41d Christoph Hellwig 2021-12-09  290  	if (unlikely(!task->io_context)) {
> 8472161b77c41d Christoph Hellwig 2021-12-09  291  		struct io_context *ioc;
> 8472161b77c41d Christoph Hellwig 2021-12-09  292
> 8472161b77c41d Christoph Hellwig 2021-12-09  293  		task_unlock(task);
> 5fc11eebb4a98d Christoph Hellwig 2021-12-09  294
> 5fc11eebb4a98d Christoph Hellwig 2021-12-09  295  		ioc = alloc_io_context(GFP_ATOMIC, NUMA_NO_NODE);
> 5fc11eebb4a98d Christoph Hellwig 2021-12-09  296  		if (!ioc)
> 5fc11eebb4a98d Christoph Hellwig 2021-12-09  297  			return -ENOMEM;
> 5fc11eebb4a98d Christoph Hellwig 2021-12-09  298
> 5fc11eebb4a98d Christoph Hellwig 2021-12-09  299  		task_lock(task);
> 5fc11eebb4a98d Christoph Hellwig 2021-12-09 @300  		if (task->io_context || (task->flags & PF_EXITING)) {
>                                                                                           ^^^^^^^^^^^^^^^^^^^^^^^^
> Assume "task->io_context" is NULL but PF_EXITING is set.
>
> 5fc11eebb4a98d Christoph Hellwig 2021-12-09  301  			kmem_cache_free(iocontext_cachep, ioc);
> 5fc11eebb4a98d Christoph Hellwig 2021-12-09  302  			ioc = task->io_context;
> 5fc11eebb4a98d Christoph Hellwig 2021-12-09  303  		} else {
> 5fc11eebb4a98d Christoph Hellwig 2021-12-09  304  			task->io_context = ioc;
> a411cd3cfdc5bb Christoph Hellwig 2021-12-09  305  		}
> 8472161b77c41d Christoph Hellwig 2021-12-09  306  	}
> 8472161b77c41d Christoph Hellwig 2021-12-09 @307  	task->io_context->ioprio = ioprio;
>                                                          ^^^^^^^^^^^^^^^^^^
> Unchecked dereference.


I will release a syzbot report with a repro like this:

   syscall(__NR_clone, 0x3a3dd4008400af01ul, 0ul, 0x9999999999999999ul, 0ul,
           -1ul);
   syscall(__NR_ioprio_set, 3ul, 0, 0ul);




