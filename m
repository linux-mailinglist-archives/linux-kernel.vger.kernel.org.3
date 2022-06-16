Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEC154E5B0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 17:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377828AbiFPPHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376920AbiFPPHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:07:33 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E23FB83
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:07:31 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25GDRoLd014942;
        Thu, 16 Jun 2022 15:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pps0720; bh=FH/qWrHodiCPFFHABKOqH9Wfw+qrG5qMuHR4hFqvijc=;
 b=bBlidcqBnf0MGXq3UAaZO0RLmc62ED7FSs2pHF53i4Rds7lelkcO36Ugs4k9G4IpgGrq
 NoiEKwbAkeG3inYWa18yVQqL7KPUtL0EGKeqctUfm5Fxh6e4AgWkVjFyAYGShuaRXbCu
 SH/zlGWyAxTDR6+rM40ra35e3i7xdC1ttKiPrSdK6nXHFbPUIakhKGeXyoFXyhBsSSyz
 feSGrrvzTdNLZKFMuEmdycbCBGfx5hS/ZAMQLi7Op7CBAYrN3mRpxbSOaeSyVn0EgacH
 1ktoit4f/4XzR171RRPFjdlKeuCA3guJPN5GC/AkkCDenrbgd/SoZ8WF4Scz0srvDwlK MQ== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3gr5e40ygw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jun 2022 15:07:16 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id A37E714796;
        Thu, 16 Jun 2022 15:06:22 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id DE71A8080F8;
        Thu, 16 Jun 2022 15:06:21 +0000 (UTC)
Date:   Thu, 16 Jun 2022 10:06:20 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Steve Wahl <steve.wahl@hpe.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kevin Tian <kevin.tian@intel.com>
Subject: Re: include/linux/intel-iommu.h:531:28: error: use of undeclared
 identifier 'CONFIG_DMAR_UNITS_SUPPORTED'
Message-ID: <YqtG7C9lGk6Bq5mA@swahl-home.5wahls.com>
References: <202206162251.cVdwcud4-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202206162251.cVdwcud4-lkp@intel.com>
X-Proofpoint-ORIG-GUID: gp6d-e9WcNCxVdIBoO6nlxr4NIpeiVHi
X-Proofpoint-GUID: gp6d-e9WcNCxVdIBoO6nlxr4NIpeiVHi
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-16_11,2022-06-16_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 adultscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206160062
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should no longer be a problem after Baolu's patches to make
intel-iommu.h private.  At least it hasn't been for me, and I did
experiment with enabling / disabling relevant config options.

--> Steve Wahl

On Thu, Jun 16, 2022 at 10:59:19PM +0800, kernel test robot wrote:
> tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220616-024802/Steve-Wahl/iommu-vt-d-Increase-DMAR_UNITS_SUPPORTED/20220506-035321
> head:   3e005e10e4d8627a55a987d047c19dba233ba66b
> commit: 3e005e10e4d8627a55a987d047c19dba233ba66b iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
> date:   20 hours ago
> config: i386-randconfig-a011 (https://download.01.org/0day-ci/archive/20220616/202206162251.cVdwcud4-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f0e608de27b3d568000046eebf3712ab542979d6)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross  -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/3e005e10e4d8627a55a987d047c19dba233ba66b
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review UPDATE-20220616-024802/Steve-Wahl/iommu-vt-d-Increase-DMAR_UNITS_SUPPORTED/20220506-035321
>         git checkout 3e005e10e4d8627a55a987d047c19dba233ba66b
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kvm/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from arch/x86/kvm/x86.c:44:
> >> include/linux/intel-iommu.h:531:28: error: use of undeclared identifier 'CONFIG_DMAR_UNITS_SUPPORTED'
>            unsigned int iommu_refcnt[DMAR_UNITS_SUPPORTED];
>                                      ^
>    include/linux/dmar.h:21:30: note: expanded from macro 'DMAR_UNITS_SUPPORTED'
>    #define DMAR_UNITS_SUPPORTED    CONFIG_DMAR_UNITS_SUPPORTED
>                                    ^
>    In file included from arch/x86/kvm/x86.c:44:
>    include/linux/intel-iommu.h:535:17: error: use of undeclared identifier 'CONFIG_DMAR_UNITS_SUPPORTED'
>            u16             iommu_did[DMAR_UNITS_SUPPORTED];
>                                      ^
>    include/linux/dmar.h:21:30: note: expanded from macro 'DMAR_UNITS_SUPPORTED'
>    #define DMAR_UNITS_SUPPORTED    CONFIG_DMAR_UNITS_SUPPORTED
>                                    ^
>    2 errors generated.
> 
> 
> vim +/CONFIG_DMAR_UNITS_SUPPORTED +531 include/linux/intel-iommu.h
> 
> b0d1f8741b8123 Jacob Pan       2020-05-16  527  
> 9ddbfb42138d84 Lu Baolu        2018-07-14  528  struct dmar_domain {
> 9ddbfb42138d84 Lu Baolu        2018-07-14  529  	int	nid;			/* node id */
> 9ddbfb42138d84 Lu Baolu        2018-07-14  530  
> 9739ba327c01e2 Parav Pandit    2021-06-10 @531  	unsigned int iommu_refcnt[DMAR_UNITS_SUPPORTED];
> 9ddbfb42138d84 Lu Baolu        2018-07-14  532  					/* Refcount of devices per iommu */
> 9ddbfb42138d84 Lu Baolu        2018-07-14  533  
> 9ddbfb42138d84 Lu Baolu        2018-07-14  534  
> 9ddbfb42138d84 Lu Baolu        2018-07-14  535  	u16		iommu_did[DMAR_UNITS_SUPPORTED];
> 9ddbfb42138d84 Lu Baolu        2018-07-14  536  					/* Domain ids per IOMMU. Use u16 since
> 9ddbfb42138d84 Lu Baolu        2018-07-14  537  					 * domain ids are 16 bit wide according
> 9ddbfb42138d84 Lu Baolu        2018-07-14  538  					 * to VT-d spec, section 9.3 */
> 9ddbfb42138d84 Lu Baolu        2018-07-14  539  
> 1f106ff0ea2782 Parav Pandit    2021-06-10  540  	u8 has_iotlb_device: 1;
> 1f106ff0ea2782 Parav Pandit    2021-06-10  541  	u8 iommu_coherency: 1;		/* indicate coherency of iommu access */
> 6043257b1de069 Jason Gunthorpe 2022-04-11  542  	u8 force_snooping : 1;		/* Create IOPTEs with snoop control */
> 1f106ff0ea2782 Parav Pandit    2021-06-10  543  
> 9ddbfb42138d84 Lu Baolu        2018-07-14  544  	struct list_head devices;	/* all devices' list */
> 9ddbfb42138d84 Lu Baolu        2018-07-14  545  	struct iova_domain iovad;	/* iova's that belong to this domain */
> 9ddbfb42138d84 Lu Baolu        2018-07-14  546  
> 9ddbfb42138d84 Lu Baolu        2018-07-14  547  	struct dma_pte	*pgd;		/* virtual address */
> 9ddbfb42138d84 Lu Baolu        2018-07-14  548  	int		gaw;		/* max guest address width */
> 9ddbfb42138d84 Lu Baolu        2018-07-14  549  
> 9ddbfb42138d84 Lu Baolu        2018-07-14  550  	/* adjusted guest address width, 0 is level 2 30-bit */
> 9ddbfb42138d84 Lu Baolu        2018-07-14  551  	int		agaw;
> 9ddbfb42138d84 Lu Baolu        2018-07-14  552  
> 9ddbfb42138d84 Lu Baolu        2018-07-14  553  	int		flags;		/* flags to find out type of domain */
> 9ddbfb42138d84 Lu Baolu        2018-07-14  554  	int		iommu_superpage;/* Level of superpages supported:
> 9ddbfb42138d84 Lu Baolu        2018-07-14  555  					   0 == 4KiB (no superpages), 1 == 2MiB,
> 9ddbfb42138d84 Lu Baolu        2018-07-14  556  					   2 == 1GiB, 3 == 512GiB, 4 == 1TiB */
> 9ddbfb42138d84 Lu Baolu        2018-07-14  557  	u64		max_addr;	/* maximum mapped address */
> 9ddbfb42138d84 Lu Baolu        2018-07-14  558  
> 9ddbfb42138d84 Lu Baolu        2018-07-14  559  	struct iommu_domain domain;	/* generic domain data structure for
> 9ddbfb42138d84 Lu Baolu        2018-07-14  560  					   iommu core */
> 9ddbfb42138d84 Lu Baolu        2018-07-14  561  };
> 9ddbfb42138d84 Lu Baolu        2018-07-14  562  
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp

-- 
Steve Wahl, Hewlett Packard Enterprise
