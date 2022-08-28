Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531285A4024
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 01:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiH1XSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 19:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH1XSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 19:18:13 -0400
Received: from p3plwbeout26-03.prod.phx3.secureserver.net (p3plsmtp26-03-2.prod.phx3.secureserver.net [216.69.139.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBB82E6AA
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 16:18:10 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.144])
        by :WBEOUT: with ESMTP
        id SRXZonZDRUn6tSRXaoVKNZ; Sun, 28 Aug 2022 16:18:06 -0700
X-CMAE-Analysis: v=2.4 cv=b9V3XvKx c=1 sm=1 tr=0 ts=630bf7b0
 a=wXHyRMViKMYRd//SnbHIqA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=biHskzXt2R4A:10 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=NcH5_zB1n7suFJPFuxYA:9
 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  SRXZonZDRUn6t
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.33])
        by smtp11.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1oSRXY-0002NZ-UY; Mon, 29 Aug 2022 00:18:05 +0100
Message-ID: <60b24133-234f-858b-8e71-e183fe72d2bb@squashfs.org.uk>
Date:   Mon, 29 Aug 2022 00:18:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: ping //Re: [PATCH v2 0/2] squashfs: Add the mount parameter
 "threads="
To:     Xiaoming Ni <nixiaoming@huawei.com>, linux-kernel@vger.kernel.org
Cc:     wangle6@huawei.com, yi.zhang@huawei.com, wangbing6@huawei.com,
        zhongjubin@huawei.com, chenjianguo3@huawei.com
References: <20220815031100.75243-1-nixiaoming@huawei.com>
 <20220816010052.15764-1-nixiaoming@huawei.com>
 <8d139f03-7845-9c96-fffc-74fdf8b5d78d@huawei.com>
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <8d139f03-7845-9c96-fffc-74fdf8b5d78d@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfN+Bg2vsqHmsPi0m52CmZ2jpPsC+gyV5v0Lfp9a3tMOM+eL72b0YNQHoX3jDCcgQoHH/SjbDS/4wpaMemRMavUwwEUSrNouYrM+LfA2RQq5ibT95T2Qw
 DIN5Q21CkHC0e3F4Co+cu0DQK5gu09e0xBBrN4smLMyCGRu+wqAyxSVQ5FMGi25lS1KhJOG/HmZy7eFVp7b2a9UNrRJjtQD1w2k=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/2022 07:19, Xiaoming Ni wrote:
> ping
> 
> 
> On 2022/8/16 9:00, Xiaoming Ni wrote:
>> Currently, Squashfs supports multiple decompressor parallel modes. 
>> However, this
>> mode can be configured only during kernel building and does not 
>> support flexible
>> selection during runtime.
>>
>> In the current patch set, the mount parameter "threads=" is added to 
>> allow users
>> to select the parallel decompressor mode and configure the number of 
>> decompressors
>> when mounting a file system.
>>
>> v2: fix warning: sparse: incorrect type in initializer (different 
>> address spaces)
>>    Reported-by: kernel test robot <lkp@intel.com>

I have made an initial review of the patches, and I have the following
comments.

Good things about the patch-series.

1. In principle I have no objections to making this configurable at
    mount time.  But, a use-case for why this has become necessary
    would help in the evaluation.

2. In general the code changes are good.  They are predominantly
    exposing the existing different decompressor functionality into
    structures which can be selected at mount time.  They do not
    change existing functionality, and so there are no issues
    about unexpected regressions.

Things which I don't like about the patch-series.

1. There is no default kernel configuration option to keep the existing
    behaviour, that is build time selectable only.  There may be many
    companies/people where for "security" reasons the ability to
    switch to a more CPU/memory intensive decompressor or more threads
    is a risk.

    Yes, I know the new kernel configuration options allow only the
    selected default decompressor mode to be built.  In theory that
    will restrict the available decompressors to the single decompressor
    selected at build time.  So not much different to the current
    position?  But, if the CONFIG_SQUASHFS_DECOMP_MULTI decompressor
    is selected, that will now allow more threads to be used than is
    current, where it is currently restricted to num_online_cpus() * 2.

2. You have decided to allow the mutiple decompressor implementations
    to be selected at mount time - but you have also allowed only one
    decompressor to be built at kernel build time.  This means you
    end up in the fairly silly situation of having a mount time
    option which allows the user to select between one decompressor.
    There doesn't seem much point in having an option which allows
    nothing to be changed.

3. Using thread=<number>, where thread=1 you use SQUASHFS_DECOMP_SINGLE
    if it has been built, otherwise you fall back to
    SQUASHFS_DECOMP_MULTI.  This meants the effect of thread=1 is
    indeterminate and depends on the build options.  I would suggest
    thread=1 should always mean use SQUASHFS_DECOMP_SINGLE.

4. If SQUASHFS_DECOMP_MULTI is selected, there isn't a limit on the
    maximum amount of threads allowed, and there is no ability to
    set the maximum number of threads allowed at kernel build time
    either.

All of the above seems to be a bit of a mess.

As regards points 1 - 3, personally I would add a default kernel
configuration option that keeps the existing behaviour, build time
selectable only, no additional mount time options.  Then a
kernel configuration option that allows the different decompressors
to be selected at mount time, but which always builds all the
decompressors.  This will avoid the silliness of point 2, and
the indeterminate behaviour of point 3.

As regards point 4, I think you should require the maximum number
of threads allowable to be determined at build time, this is
good for security and avoids attempts to use too much CPU
and memory.  The default at kernel build time should be minimal,
to avoid cases where an unchanged value can cause a potential
security hazard on a low end system.  In otherwords it is
up to the user at build time to set the value to an appropriate
value for their system.

Phillip

---
Phillip Lougher, Squashfs author and maintainer.

>>
>> v1: 
>> https://lore.kernel.org/lkml/20220815031100.75243-1-nixiaoming@huawei.com/ 
>>
>> ----
>>
>> Xiaoming Ni (2):
>>    squashfs: add the mount parameter theads=<single|multi|percpu>
>>    squashfs: Allows users to configure the number of decompression
>>      threads.
>>
>>   fs/squashfs/Kconfig                     | 24 ++++++++--
>>   fs/squashfs/decompressor_multi.c        | 32 ++++++++------
>>   fs/squashfs/decompressor_multi_percpu.c | 39 ++++++++++-------
>>   fs/squashfs/decompressor_single.c       | 23 ++++++----
>>   fs/squashfs/squashfs.h                  | 39 ++++++++++++++---
>>   fs/squashfs/squashfs_fs_sb.h            |  4 +-
>>   fs/squashfs/super.c                     | 77 
>> ++++++++++++++++++++++++++++++++-
>>   7 files changed, 192 insertions(+), 46 deletions(-)
>>
> 

