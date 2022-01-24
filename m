Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACECC497A51
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbiAXI2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:28:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61724 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229800AbiAXI17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:27:59 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20O6BlsG027015;
        Mon, 24 Jan 2022 08:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=co6v1iJyrw5RoBHR6948PCl2L9ngBnsKZHct6/xFYFM=;
 b=h4vi6ektsrsdIjjFkIppS9v9ox5oIKRzaTPG71FaXxVtASyK+CLqXyNEy+tNQQZUeJNd
 JlojvrQcgRw+l0s9Pr6wc0FHMvIWdnlIL23Yr0b31Rt9BIBAe4wwFxl1k1/TVy7OXHrl
 6hSFg5wwYv28ztkmpgkIX3YgEHIGepJ20FZkwBvtamdojmioXg8G/61j7hZJ6A+4Ak/F
 H5gCru/mEy/mS7xDisV2PoHArtMW5NKezuDhha+fXrDV1Np54xcg4x1VMO0jTbDXd1SO
 SfE8U6EBpzBYmbhu38LQKRsvk+c2VzZkG6KoBlxwS3Do3Pn0uXyMcG5OgkCH95rD4Q1v cg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dspmmjbe2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jan 2022 08:27:57 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20O8RIjY024015;
        Mon, 24 Jan 2022 08:27:55 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3dr9j8sy98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jan 2022 08:27:55 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20O8Ro5t47579636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jan 2022 08:27:50 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46DDDAE055;
        Mon, 24 Jan 2022 08:27:50 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04B53AE045;
        Mon, 24 Jan 2022 08:27:50 +0000 (GMT)
Received: from [9.171.90.142] (unknown [9.171.90.142])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 24 Jan 2022 08:27:49 +0000 (GMT)
Message-ID: <2537ad58-675f-c05d-04e4-07358e92c7c3@linux.ibm.com>
Date:   Mon, 24 Jan 2022 09:27:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: arch/s390/lib/uaccess.c:65:15: error: variable 'spec' has
 initializer but incomplete type
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, Nico Boehr <nrb@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>
References: <202201221613.fgIWUw0F-lkp@intel.com>
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
In-Reply-To: <202201221613.fgIWUw0F-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YM53W-lSdip57FgQqRj0qRq8DWomRxDP
X-Proofpoint-ORIG-GUID: YM53W-lSdip57FgQqRj0qRq8DWomRxDP
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-24_06,2022-01-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 clxscore=1011 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201240049
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/22 09:42, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   9b57f458985742bd1c585f4c7f36d04634ce1143
> commit: 012a224e1fa31fc256aab921f691598e03db6018 s390/uaccess: introduce bit field for OAC specifier
> date:   5 days ago
> config: s390-randconfig-r033-20220120 (https://download.01.org/0day-ci/archive/20220122/202201221613.fgIWUw0F-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=012a224e1fa31fc256aab921f691598e03db6018
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 012a224e1fa31fc256aab921f691598e03db6018
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    arch/s390/lib/uaccess.c: In function 'copy_from_user_mvcos':
>>> arch/s390/lib/uaccess.c:65:15: error: variable 'spec' has initializer but incomplete type
>       65 |         union oac spec = {
>          |               ^~~
>>> arch/s390/lib/uaccess.c:66:18: error: 'union oac' has no member named 'oac2'
>       66 |                 .oac2.as = PSW_BITS_AS_SECONDARY,
>          |                  ^~~~
>    arch/s390/lib/uaccess.c:66:28: warning: excess elements in union initializer
>       66 |                 .oac2.as = PSW_BITS_AS_SECONDARY,
>          |                            ^~~~~~~~~~~~~~~~~~~~~
>    arch/s390/lib/uaccess.c:66:28: note: (near initialization for 'spec')
>    arch/s390/lib/uaccess.c:67:18: error: 'union oac' has no member named 'oac2'
>       67 |                 .oac2.a = 1,
>          |                  ^~~~
>    arch/s390/lib/uaccess.c:67:27: warning: excess elements in union initializer
>       67 |                 .oac2.a = 1,
>          |                           ^
>    arch/s390/lib/uaccess.c:67:27: note: (near initialization for 'spec')
>>> arch/s390/lib/uaccess.c:65:19: error: storage size of 'spec' isn't known
>       65 |         union oac spec = {
>          |                   ^~~~
>    arch/s390/lib/uaccess.c:65:19: warning: unused variable 'spec' [-Wunused-variable]
>    arch/s390/lib/uaccess.c: In function 'copy_to_user_mvcos':
>    arch/s390/lib/uaccess.c:142:15: error: variable 'spec' has initializer but incomplete type
>      142 |         union oac spec = {
>          |               ^~~
>>> arch/s390/lib/uaccess.c:143:18: error: 'union oac' has no member named 'oac1'
>      143 |                 .oac1.as = PSW_BITS_AS_SECONDARY,
>          |                  ^~~~
>    arch/s390/lib/uaccess.c:143:28: warning: excess elements in union initializer
>      143 |                 .oac1.as = PSW_BITS_AS_SECONDARY,
>          |                            ^~~~~~~~~~~~~~~~~~~~~
>    arch/s390/lib/uaccess.c:143:28: note: (near initialization for 'spec')
>    arch/s390/lib/uaccess.c:144:18: error: 'union oac' has no member named 'oac1'
>      144 |                 .oac1.a = 1,
>          |                  ^~~~
>    arch/s390/lib/uaccess.c:144:27: warning: excess elements in union initializer
>      144 |                 .oac1.a = 1,
>          |                           ^
>    arch/s390/lib/uaccess.c:144:27: note: (near initialization for 'spec')
>    arch/s390/lib/uaccess.c:142:19: error: storage size of 'spec' isn't known
>      142 |         union oac spec = {
>          |                   ^~~~
>    arch/s390/lib/uaccess.c:142:19: warning: unused variable 'spec' [-Wunused-variable]
>    arch/s390/lib/uaccess.c: In function 'clear_user_mvcos':
>    arch/s390/lib/uaccess.c:218:15: error: variable 'spec' has initializer but incomplete type
>      218 |         union oac spec = {
>          |               ^~~
>    arch/s390/lib/uaccess.c:219:18: error: 'union oac' has no member named 'oac1'
>      219 |                 .oac1.as = PSW_BITS_AS_SECONDARY,
>          |                  ^~~~
>    arch/s390/lib/uaccess.c:219:28: warning: excess elements in union initializer
>      219 |                 .oac1.as = PSW_BITS_AS_SECONDARY,
>          |                            ^~~~~~~~~~~~~~~~~~~~~
>    arch/s390/lib/uaccess.c:219:28: note: (near initialization for 'spec')
>    arch/s390/lib/uaccess.c:220:18: error: 'union oac' has no member named 'oac1'
>      220 |                 .oac1.a = 1,
>          |                  ^~~~
>    arch/s390/lib/uaccess.c:220:27: warning: excess elements in union initializer
>      220 |                 .oac1.a = 1,
>          |                           ^
>    arch/s390/lib/uaccess.c:220:27: note: (near initialization for 'spec')
>    arch/s390/lib/uaccess.c:218:19: error: storage size of 'spec' isn't known
>      218 |         union oac spec = {
>          |                   ^~~~
>    arch/s390/lib/uaccess.c:218:19: warning: unused variable 'spec' [-Wunused-variable]

This is caused by the union definition being covered by the #ifdef CONFIG_HAVE_MARCH_Z10_FEATURES.
