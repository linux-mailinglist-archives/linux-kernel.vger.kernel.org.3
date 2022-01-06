Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7344867C9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 17:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241355AbiAFQk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 11:40:58 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:57641 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241308AbiAFQk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 11:40:57 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0V174cBl_1641487253;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V174cBl_1641487253)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 07 Jan 2022 00:40:55 +0800
Date:   Fri, 7 Jan 2022 00:40:52 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>,
        Liu Bo <bo.liu@linux.alibaba.com>, lkp@intel.com,
        kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] erofs: use meta buffers for super operations
Message-ID: <YdcblD+C9DE0K/Tm@B-P7TQMD6M-0146.local>
References: <20211229041405.45921-4-hsiangkao@linux.alibaba.com>
 <202112310650.TDDinvVT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202112310650.TDDinvVT-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Thu, Jan 06, 2022 at 06:08:48PM +0300, Dan Carpenter wrote:
> Hi Gao,
> 
> url:    https://github.com/0day-ci/linux/commits/Gao-Xiang/erofs-get-rid-of-erofs_get_meta_page/20211229-121538
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
> config: x86_64-randconfig-m001-20211230 (https://download.01.org/0day-ci/archive/20211231/202112310650.TDDinvVT-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> fs/erofs/super.c:153 erofs_read_metadata() warn: possible memory leak of 'buffer'

Many thanks for the report.

It has already been fixed in the latest version:
https://lore.kernel.org/all/20220102081317.109797-1-hsiangkao@linux.alibaba.com/

(I've pushed out to the linux-next...)

Thanks,
Gao Xiang
