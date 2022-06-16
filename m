Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3071754E76C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbiFPQio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiFPQin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:38:43 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7245F78
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:38:41 -0700 (PDT)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25GGTJUF002050;
        Thu, 16 Jun 2022 16:38:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pps0720; bh=qU7x0Sr1f6xDT8ap/JifFyAc8mtbe0McXQjK8Nk1ZmI=;
 b=el3VI22T12XTR2RC8kSx7tREZebvkss9zz9TeaeEY4pdleWn88MRZac58VmbM5WGBryk
 GxInHY6e56ns2fX6L000GyUBOqJKZzVFKHZNByGf3WU3RfHDw8ZXx59bLxMBsHzeDv7s
 Eb3NtxCLKdnt/lPDDGG7xh/78ULN3GQzmPxLewyhbWsMh0h05lF48n+jiU9tJbBSbtka
 RPkNlg4QvT5TvYaYFumLdKPzYugregi9FHymF6C5u8jr2TvUH9sAbPUL0Fyr+NQMHhn6
 LD0sk0HrwKuJpK56dEeMp6q4tOX1lrU97AncaVJf+V9Tt3hcCE3XgaizOHQDXZF9wMuO 1Q== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3gr82wg2jk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jun 2022 16:38:38 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 06593800260;
        Thu, 16 Jun 2022 16:38:37 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 75220809102;
        Thu, 16 Jun 2022 16:38:36 +0000 (UTC)
Date:   Thu, 16 Jun 2022 11:38:34 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Steve Wahl <steve.wahl@hpe.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>
Subject: Re: include/linux/dmar.h:21:33: error: 'CONFIG_DMAR_UNITS_SUPPORTED'
 undeclared here (not in a function); did you mean 'DMAR_UNITS_SUPPORTED'?
Message-ID: <YqtcijngpsVCrNOw@swahl-home.5wahls.com>
References: <202206162309.0IdGIck1-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202206162309.0IdGIck1-lkp@intel.com>
X-Proofpoint-GUID: Z8EvBHg1sp7Y3gLS6irSWhHE8JG9RcuB
X-Proofpoint-ORIG-GUID: Z8EvBHg1sp7Y3gLS6irSWhHE8JG9RcuB
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-16_13,2022-06-16_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206160068
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is another instance that should no longer be a problem after
Baolu's patches to make intel-iommu.h private.

--> Steve Wahl


On Thu, Jun 16, 2022 at 11:40:45PM +0800, kernel test robot wrote:
> tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220616-024802/Steve-Wahl/iommu-vt-d-Increase-DMAR_UNITS_SUPPORTED/20220506-035321
> head:   3e005e10e4d8627a55a987d047c19dba233ba66b
> commit: 3e005e10e4d8627a55a987d047c19dba233ba66b iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
> date:   21 hours ago
> config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20220616/202206162309.0IdGIck1-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/intel-lab-lkp/linux/commit/3e005e10e4d8627a55a987d047c19dba233ba66b
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review UPDATE-20220616-024802/Steve-Wahl/iommu-vt-d-Increase-DMAR_UNITS_SUPPORTED/20220506-035321
>         git checkout 3e005e10e4d8627a55a987d047c19dba233ba66b
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/intel-iommu.h:21,
>                     from drivers/char/agp/intel-gtt.c:23:
> >> include/linux/dmar.h:21:33: error: 'CONFIG_DMAR_UNITS_SUPPORTED' undeclared here (not in a function); did you mean 'DMAR_UNITS_SUPPORTED'?
>       21 | #define DMAR_UNITS_SUPPORTED    CONFIG_DMAR_UNITS_SUPPORTED
>          |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/intel-iommu.h:531:35: note: in expansion of macro 'DMAR_UNITS_SUPPORTED'
>      531 |         unsigned int iommu_refcnt[DMAR_UNITS_SUPPORTED];
>          |                                   ^~~~~~~~~~~~~~~~~~~~
> 
> 
> vim +21 include/linux/dmar.h
> 
>     20	
>   > 21	#define	DMAR_UNITS_SUPPORTED	CONFIG_DMAR_UNITS_SUPPORTED
>     22	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp

-- 
Steve Wahl, Hewlett Packard Enterprise
