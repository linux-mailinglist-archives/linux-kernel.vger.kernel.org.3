Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6021F4EA4C1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 03:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiC2Btt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 21:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiC2Btr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 21:49:47 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7361F378E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 18:48:05 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id r127so12990354qke.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 18:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=AawDJ9kX/dAfzHx8j8PvkYqiVyZFKLPmskAntPro/To=;
        b=a5A8uLsByHU7JvaEt9P7XTkP1mWUj4kIq9Yk/hz+ELfy8pECsQa5KhUSoO/NpolSOr
         VQQVWPqXXc4YezEz1VbD5Z61yfpd+7dXlhG74VyznreIhFV8uFKG6DxZ1s1dQFkIa0qS
         antmHlMyBpbnpoGBdiSCEkMCfIMPJVlYXs6mSxiiF/W3O+DaFmB6XHf87+DkhCHZXbfW
         bgiH/j0JWtql9Pnd6EXiW9+ZalmN6/MdHeyOaFdO0uDoR68WMvDj/cxak3oAJioQ/q6C
         O4v7byJIJvi54li671HSwRLccwgd95afj/3BbdwNdGQ/ouWstbsD9EZVaX+JYpulnG3P
         V97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=AawDJ9kX/dAfzHx8j8PvkYqiVyZFKLPmskAntPro/To=;
        b=B+i3s6NlEglCXs3upJ9Gscaz/7K1rdtSXg1iQPzkFQ9w84McebqaE9+9ysAN4O0cU4
         ekJyNq84HE2xGzXU9T5LxGvNLN9u/RLz4GAggz9SsbDlxwPYWKzGwcrbD20kGX0zXfTB
         MXGwC6PFIlyvk2pAivAo9GsiPAkO7braGlLkItn577650zytvcc0uMUhwzwskTnFfutV
         vpsSdQsLej/F9u4wNX/alIj9HKmpBj5huUtSm4CSwpEHisYDJJV9X/g/KH7m2so3hkw+
         EdglF/GR/1qTIsUSGrxZbP+LBygnJy4FEwje0FhIq0OYYHgI3YvL1MxgZEgePe4ysHJM
         MCiw==
X-Gm-Message-State: AOAM533OVKDQN1fxASNs0F8JvSrKsDqPXJ4FZXOQUH5Nj8v7pwTUCev/
        f+BhyMItHf5tMVylNNFXzVo=
X-Google-Smtp-Source: ABdhPJygSH5aMysv6jIECEWNSss09AECuOVINBykvHLmuRLTI4v4iiXnecfZGswBNs49QRnrZQj+aQ==
X-Received: by 2002:a05:620a:458a:b0:67d:7140:5a6d with SMTP id bp10-20020a05620a458a00b0067d71405a6dmr18283592qkb.387.1648518484564;
        Mon, 28 Mar 2022 18:48:04 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h22-20020a05620a245600b0067d6dae634csm9946284qkn.9.2022.03.28.18.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 18:48:03 -0700 (PDT)
Message-ID: <62426553.1c69fb81.bb808.345c@mx.google.com>
X-Google-Original-Message-ID: <20220329014801.GA2374506@cgel.zte@gmail.com>
Date:   Tue, 29 Mar 2022 01:48:01 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        paul@paul-moore.com
Cc:     paul@paul-moore.com, eparis@redhat.com, linux-audit@redhat.com,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Yang Yang <yang.yang29@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] audit: do a quick exit when syscall number is invalid
References: <20220326094654.2361956-1-yang.yang29@zte.com.cn>
 <202203270449.WBYQF9X3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202203270449.WBYQF9X3-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2022 at 04:55:01AM +0800, kernel test robot wrote:
> Hi,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on pcmoore-audit/next]
> [also build test ERROR on v5.17 next-20220325]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/cgel-zte-gmail-com/audit-do-a-quick-exit-when-syscall-number-is-invalid/20220326-174904
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git next
> config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220327/202203270449.WBYQF9X3-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/052b1a11a0bec23358ecc22ad9b085590efd3057
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review cgel-zte-gmail-com/audit-do-a-quick-exit-when-syscall-number-is-invalid/20220326-174904
>         git checkout 052b1a11a0bec23358ecc22ad9b085590efd3057
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/init.h:5,
>                     from kernel/auditsc.c:34:
>    kernel/auditsc.c: In function '__audit_syscall_exit':
> >> kernel/auditsc.c:2081:61: error: 'NR_syscalls' undeclared (first use in this function); did you mean 'si_syscall'?
>     2081 |             unlikely(context->major < 0 || context->major > NR_syscalls))
>          |                                                             ^~~~~~~~~~~

Sorry could anybody give a hand to solve this? It works well on x86_64 and arm64.
I have no alpha environment and not familiar to this arch, much thanks!

>    include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
>       78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
>          |                                             ^
>    kernel/auditsc.c:2081:61: note: each undeclared identifier is reported only once for each function it appears in
>     2081 |             unlikely(context->major < 0 || context->major > NR_syscalls))
>          |                                                             ^~~~~~~~~~~
>    include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
>       78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
>          |                                             ^
> 
> 
> vim +2081 kernel/auditsc.c
> 
>   2063	
>   2064	/**
>   2065	 * __audit_syscall_exit - deallocate audit context after a system call
>   2066	 * @success: success value of the syscall
>   2067	 * @return_code: return value of the syscall
>   2068	 *
>   2069	 * Tear down after system call.  If the audit context has been marked as
>   2070	 * auditable (either because of the AUDIT_STATE_RECORD state from
>   2071	 * filtering, or because some other part of the kernel wrote an audit
>   2072	 * message), then write out the syscall information.  In call cases,
>   2073	 * free the names stored from getname().
>   2074	 */
>   2075	void __audit_syscall_exit(int success, long return_code)
>   2076	{
>   2077		struct audit_context *context = audit_context();
>   2078	
>   2079		if (!context || context->dummy ||
>   2080		    context->context != AUDIT_CTX_SYSCALL ||
> > 2081		    unlikely(context->major < 0 || context->major > NR_syscalls))
>   2082			goto out;
>   2083	
>   2084		/* this may generate CONFIG_CHANGE records */
>   2085		if (!list_empty(&context->killed_trees))
>   2086			audit_kill_trees(context);
>   2087	
>   2088		/* run through both filters to ensure we set the filterkey properly */
>   2089		audit_filter_syscall(current, context);
>   2090		audit_filter_inodes(current, context);
>   2091		if (context->current_state < AUDIT_STATE_RECORD)
>   2092			goto out;
>   2093	
>   2094		audit_return_fixup(context, success, return_code);
>   2095		audit_log_exit();
>   2096	
>   2097	out:
>   2098		audit_reset_context(context);
>   2099	}
>   2100	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
