Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84ED4EFF0A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 07:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353926AbiDBF0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 01:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353885AbiDBFZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 01:25:44 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6909B21800
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 22:23:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V8yNhsR_1648877029;
Received: from 30.225.24.59(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V8yNhsR_1648877029)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 02 Apr 2022 13:23:49 +0800
Message-ID: <75ca360f-48a6-38dc-c0cc-d9b0e0d003ce@linux.alibaba.com>
Date:   Sat, 2 Apr 2022 13:23:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [xiang:jeffle/fscache 2/19] fs/cachefiles/namei.c:478:17: error:
 label 'out_unuse' used but not defined
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, Xiang Gao <xiang@kernel.org>,
        linux-kernel@vger.kernel.org,
        Gao Xiang <hsiangkao@linux.alibaba.com>
References: <202204021359.3SIrp1y5-lkp@intel.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <202204021359.3SIrp1y5-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/2/22 1:18 PM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git jeffle/fscache
> head:   c536a60b958806d427fb66e3f53a1201826fdcf4
> commit: 6e3731398f863eec9b10f9e0cead9f2ec09d8b4d [2/19] cachefiles: notify user daemon with anon_fd when looking up cookie
> config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220402/202204021359.3SIrp1y5-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git/commit/?id=6e3731398f863eec9b10f9e0cead9f2ec09d8b4d
>         git remote add xiang https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git
>         git fetch --no-tags xiang jeffle/fscache
>         git checkout 6e3731398f863eec9b10f9e0cead9f2ec09d8b4d
>         # save the config file to linux build tree
>         mkdir build_dir
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    fs/cachefiles/namei.c: In function 'cachefiles_create_tmpfile':
>>> fs/cachefiles/namei.c:478:17: error: label 'out_unuse' used but not defined
>      478 |                 goto out_unuse;
>          |                 ^~~~
> 
> 

This patchset depends on "cachefiles: unmark inode in use in error path"
[1].

[1]
https://github.com/lostjeffle/linux/commit/3c71705e777fa75d37f784640a232db14ce62c31


-- 
Thanks,
Jeffle
