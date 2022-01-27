Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACDD549DB12
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 07:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236988AbiA0G6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 01:58:36 -0500
Received: from mga03.intel.com ([134.134.136.65]:23538 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229565AbiA0G6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 01:58:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643266715; x=1674802715;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Vik+Q4W/HDworZDWCoAXr1vfqBAKk65kvkEQiCzby04=;
  b=gsPuQPkcbRqWWjvcztpAF0OmsB0gLzK/Sws8oSbdxiNscloXrW66Xuvq
   dbwyn6611KcxaSCARebjTFbF8SW9M0nmtqi6A4V0sei7Q5gan/f0SymQk
   PHvHpFBa4ou3YxGEM0IV1TbVug83tmQPRzQe2cptt04JaLB08PJ6rOoDP
   6W0grizyQSOaTkMnU79RwKfEAwMNvQYNaL6CuLSLh1gFOHDucuQgDg0cu
   sJoOtJx/lIpCyBgxNIYO2O3bbm3mnJYKorjGM7LKKgBqm4F41zr73DAhj
   ul1Gp1AZN3vPePHLfSaSUNcy2JFGsZNMJorxnz/VHt626SYl17WGp97qK
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="246714898"
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="246714898"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 22:58:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="628581820"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga004.jf.intel.com with ESMTP; 26 Jan 2022 22:58:34 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 26 Jan 2022 22:58:33 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 26 Jan 2022 22:58:33 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 26 Jan 2022 22:58:33 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 26 Jan 2022 22:58:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVT6hmbqNAwKq8nvmF0cg802x9c3OLqYqJghHU+2b79+RXi9aJzp4FIIG2WQ6nxXlGDvstuAV00hrL3qs74J2rk2UQKMGONEIU/eoFmKYNc9ZDQa8sn6Wh2oLNrhvJo0db8VhwA2BqPnuHN53fgL4RH7VzhmJgAoclT9UEJuDr8eXhXuHB7K6wdufNHapqlwCKFJE91tn8Oj5v/Ocj3jqnFvKB2fyS1IzHZhV0tWioO8MkvgO5GflxpkGRuBdV7/chPSBsEs7m7tWSC2HTTN73NHmccorj6rBlvnHlhPKFC5gEjSmMO5+3z7k94qlVutrnlVvux4QNO9ckYASVHzNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdkDyeZPHlnd6WT4ugozNApMta1rBjIpDx53zIoSAzY=;
 b=X+3C4lsmKhNeubyMH/Pmc94qrRYtveO82jOY/6nQrkC23K44Oual+OaZt4v6wtS79JZdDhl95hExXInBu9ZplO+a9hR8ZlX+9u7upsjRdYclfXWbuE4EnLVE+QCLXBpQwjuFzFAZFjpa+wCJZwfk0hJBenJdyDWx4Esgln9gsH0ROfombDUiaNBw3JHR3DbGsqprBiEMvFPMe2zdLOyfG1EdwcvMihZikO9Vz8KJigEUBB+soqwyN3MaJ0Ny4Ualmr1MV2FOIHrxR/PjGk/ygi6vSgJI0R85bofD/Ea8/9VOmDmsIo1pnAHUesz0rW+v/5htlOKUGCAhEfsLik//8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by MWHPR1101MB2285.namprd11.prod.outlook.com (2603:10b6:301:57::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 27 Jan
 2022 06:58:26 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d%6]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 06:58:26 +0000
Message-ID: <6ee9419e-036d-586e-78e0-d3fc879642ab@intel.com>
Date:   Thu, 27 Jan 2022 14:58:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.1
Subject: [agd5f:drm-next 124/190]
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:877:51: warning: Uninitialized
 variable: reg_access_ctrl [uninitvar]
References: <202201261900.ZLv3AEFH-lkp@intel.com>
Content-Language: en-US
To:     Hawking Zhang <Hawking.Zhang@amd.com>
CC:     <kbuild-all@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Zhou, Peng Ju" <PengJu.Zhou@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202201261900.ZLv3AEFH-lkp@intel.com>
X-Forwarded-Message-Id: <202201261900.ZLv3AEFH-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0573.namprd03.prod.outlook.com
 (2603:10b6:408:10d::8) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1e3726f-49f5-49ae-2229-08d9e1626ad1
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2285:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1101MB22856FF8324B1BDEE6AC3ECBFB219@MWHPR1101MB2285.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:19;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z1qRN+//xj/nj69T9BGLStBWC++QRFIStGc5QoNp8uEAtWkxS4XfFDDIgtuxGE7EjVY01lCMVUp+65EsuOgajUvLM04mwzRGEzfsKrlXXs/LFhSr8gQLxh7yrlHP3pgwUHHzlSblaHgg+x1jdirdNnvqtLWYkOFLE5tNaHZ6p6zv/0MlyK5iFCqt/n+2MEZCHo0u3vbslvh4Aps/JZVTRBK2rXbdofQpQtK7Fm2YCLA9WNbh4A3MO+XqgNsogXtSIp6iCcYP/kRr5w5LPCDYdP3EZ1wGPPq2LxT/C6QJegmSO7AEtZnKugl6r0IQPfSN94t/anX7ID9UptjSyLgTVXJTf/HgoPFWZ73KRYKzHrEIlx606gLsd/6xRMYqgc9s1F8bVaSA6n7b5+1C8m4jIbdJGK4lyHoQD2oFN+JvcUcXP3Y+sIlBqUXbu3dYqjxO7tyoiNVu1Xo1P7uwIwdbkHexclfWQ4lvk+WYGBAPsE9dPOkG5i+u3iefh4tmrRbbUzA26EmreB5felh6liPvTfC5YEjJY6Pw/gE2Kd/v7GLiUMGqkPqARBzT/+WPJx/eoXmxwOo5moJ7UGK7IVqzbIQRXYmH/i3jbpQlnfOSVhYa42vmYsp+mDndJspmf3e72L5sfyQCCIQ7ET/JJlwO6J9aBfVR7jQ9XPJAjICI6XNdWFJAPFbf+9QnNvwPw67z1FOP8pwwW8bu9tWgVl3GSnCl15i7Jbikt9QLFi/D5oALOiYMAYpE4dnvOxMcEj6fyNkPNezwYExTE/qnr5nUlhxelG4opGDZGWapKD8qNJe2Si7KSdzBatGJMFAxkte5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(54906003)(82960400001)(6916009)(38100700002)(5660300002)(66946007)(6512007)(186003)(508600001)(2616005)(66556008)(966005)(6486002)(6506007)(6666004)(66476007)(2906002)(26005)(8936002)(4326008)(8676002)(31696002)(36756003)(31686004)(86362001)(83380400001)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFUra09MU0RRa2ZJVWJBK01qSHU4d09jY2Fqd2lUWE5naWJ3V2NveWx1L2FU?=
 =?utf-8?B?c1pqQ0I1RkxodHgwRUdVM3VOYXIvd0g2V0xpWjBGRmJiWjR2Q01hWHVvUWZo?=
 =?utf-8?B?YXd6VDlXbnd5cktpci9BK2pXZWdySkFraHZ2My9JMEl6YUM0bFJFTDVvNFpU?=
 =?utf-8?B?UlY2VzdBNlJqT3lvbzdsMzNrZ00zejNzMk12bnIya2ZWNklIdnZMUGE4UXBD?=
 =?utf-8?B?QWJDWStjL1FUS09IR2ZWMnhHMllKL3poRzVOanFUWmtRYVJMUkN6R3c4dFFl?=
 =?utf-8?B?REUyOVhJQlJGY3dLU1J4UnBiSEVkMFJJOFBuMkN6aEdlRUUyNHVNSkUyL0dM?=
 =?utf-8?B?eEJnb2RTSHE3L1hlKy9mK0cybENuWEZyMm5SUGVYb3FNUDVLZWpFWHJnWjRK?=
 =?utf-8?B?ZjlvUFgwcVBMcjZqcE5vdW03Y1VPOGdGeGJiZENqbmVrOEZzV2hkVXVWZTYr?=
 =?utf-8?B?T1VhcTd0TlFJSVV3SFhFY08wRDhtamhOQzI1ekZUMjZ4L1lmMDkyNXN2Z2xW?=
 =?utf-8?B?R25jNEREaGQvUXZYelhCZFVpeXhnNE5oU1owSzlSZmVXOXNLaG45MFlyZ3Zs?=
 =?utf-8?B?NGVHNWF0K2JjaGJvUFNaV0xYSkhNOG9hWURFMytVeE9Mdmg3Q3pocWtkZ0xz?=
 =?utf-8?B?d1hZMnVVUVNvYy9HUlY2aHVHUmM0MkNUaThxMVF0TEhLczNJd0ZjbUFnc2NV?=
 =?utf-8?B?RldPMHZ6dmFuZHhOUlpVZFNDNkRleU9TbitrdnNQZHp5b3BpR3E0emRYMXkx?=
 =?utf-8?B?cEh3MHdWbnlCcXNuaVk1T0FDOEVqNnMrZXhrb3Z4MWxuL054SlV2M3B5TGU0?=
 =?utf-8?B?RWFZMnZvK2hJbjdmWlJRZ21TVWRjYXpzQVFaQmI2UGEvNkFPMHYzaTZ1cXRN?=
 =?utf-8?B?aWtWL1BWaUxYUzdRZmhlWTZ6N1FNYlBURmh3ZzQxQXhDTDhWdW1lVUhxU01p?=
 =?utf-8?B?RFdxblhrY25pOFRmSm80cXl1dStJa0tQbmNLOXF4cEVjL3I5UVNYRDVmQmE3?=
 =?utf-8?B?RWxOUHF4KzZrc1ZFeGNjQmRKVzdMbFZSU3l0cWVLYmE1S0UwSlBWMStBbUkz?=
 =?utf-8?B?ZDdNWEdNblNVSVY2bGVRU09PNEI1dmZSM3k0UVM3R2lUdWdhSkh6RHRoenBo?=
 =?utf-8?B?RWhLbE9uUkdaOWMzOVRZbWFJKzdaL21GdTk0ZnQ3T0htMEdjM0dJOXFZTXFK?=
 =?utf-8?B?SUl2VEVEaFZaaXFSdldWYUdGQmJOL1pUWUxJdEFXT3QwQXEwR2JQb0R4YXFM?=
 =?utf-8?B?dTFYTklWZ1IwZ3FTaGNOclU1cHZSN2tsY1Y5anpSOURlVXhHY0wxdEs4N1hy?=
 =?utf-8?B?Z1ZUZ0J4MzFpTG5DVmYxNERWcENPU0h5N1lTUTJxYnBFSjFLeGhGOEJjcmRq?=
 =?utf-8?B?ZDF4QUR5aEFNWnFpUDNhcVhDSlZnMmc0MFE4eElvUVZsaUVDRVBteE5CSEVV?=
 =?utf-8?B?RkU5aUQ5N0RDdGZ2dmRKOXZGQ0JEUHY5d3NjVFZHZXBpcVRnQnFZc0IwTEd3?=
 =?utf-8?B?K2lnSzhEWjVyT2ZpdUxSNmM1d2dSNEJNS09ER0FhR2ZpWVQ1cWU1a0RTcjZ2?=
 =?utf-8?B?bDQydStGc3d5K29ORVgxd3M0LzRtQm44dExZcUFyQWExV2k0OWtCQWZRWDRp?=
 =?utf-8?B?ekFteHFTVU54ZUlsOVFvL3hhRlcxTVlUTzQ5Q0pOUlhLQjlia0Nmb0JISksz?=
 =?utf-8?B?Q2tON0UyeTMrNDFnV05kSDdpeEV3UnFFR0RsNWh3bm02bTdBeGVCWDRjK1FU?=
 =?utf-8?B?NlVJZ1NnZHdYaDI5Ukt2WlduU25pNjRybFVIV21IMmVoVXZkZGgrRW55TGRM?=
 =?utf-8?B?bWtMT2VOVG45QnlOZTg4dTF2cmNVOXowMjFRNlhPVW1Wb2lDSjNJa1ExMHZU?=
 =?utf-8?B?UEVoZWZVYWFnQ0ovNzR2UUdoeUxlbWJwS3o5Z2pwSktaT3V5SW1oOWVrS0lk?=
 =?utf-8?B?enhsMHBiaG95VnVJOVRBTWtESUJNRERubWJCa0pzMTBmWEIzY2FhaklmUmp4?=
 =?utf-8?B?NkV1MHlBQ0duV0hmUjhNMW1iSS9vTEJvVmp5WlhXUkhaVWtZZUpIa1pBS2JS?=
 =?utf-8?B?TStWV0xJVlYxMkJQRWxNSXFFTlZ3aW5oaUVxZVR0enNIWGNsLy9RdGlxb3pQ?=
 =?utf-8?B?T01uZTIyVDBpb0lYMEtZUDFXZGJRaHpVRWgreFhLaERPaEp3ZVIyOE9qZ2ZP?=
 =?utf-8?Q?sCsyaKKTeJmuTDb85Gbsy+M=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e3726f-49f5-49ae-2229-08d9e1626ad1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 06:58:26.6645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hgw8TBB/S6m6l6LG4SUH0+hWa/pCFUEU6Wkt+FQGlFJYlBAJKlWLJ596MR9FXxaLpo3GgObx1lHSjzjrkw8LzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2285
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   63e583c8843f305a3e334a96d5de00435f4d38a2
commit: 5d447e296701484f3df5b31a7a078cbf1e3a9cc9 [124/190] drm/amdgpu: add helper for rlcg indirect reg access
compiler: riscv32-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <yujie.liu@intel.com>


cppcheck possible warnings: (new ones prefixed by >>, may not be real problems)

 >> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:877:51: warning: Uninitialized variable: reg_access_ctrl [uninitvar]
     scratch_reg0 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg0;
                                                      ^
 >> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:878:51: warning: Uninitialized variable: reg_access_ctrl [uninitvar]
     scratch_reg1 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg1;
                                                      ^
 >> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:879:51: warning: Uninitialized variable: reg_access_ctrl [uninitvar]
     scratch_reg2 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg2;
                                                      ^
 >> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:880:51: warning: Uninitialized variable: reg_access_ctrl [uninitvar]
     scratch_reg3 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg3;
                                                      ^
 >> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:884:16: warning: Uninitialized struct member: reg_access_ctrl.grbm_cntl [uninitStructMember]
     if (offset == reg_access_ctrl->grbm_cntl) {
                   ^
 >> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:888:23: warning: Uninitialized struct member: reg_access_ctrl.grbm_idx [uninitStructMember]
     } else if (offset == reg_access_ctrl->grbm_idx) {
                          ^
 >> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:881:6: warning: Uninitialized struct member: reg_access_ctrl.spare_int [uninitStructMember]
     if (reg_access_ctrl->spare_int)
         ^
 >> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:882:49: warning: Uninitialized struct member: reg_access_ctrl.spare_int [uninitStructMember]
      spare_int = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->spare_int;
                                                    ^
 >> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:901:7: warning: Uninitialized struct member: reg_access_ctrl.spare_int [uninitStructMember]
      if (reg_access_ctrl->spare_int)
          ^
 >> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:881:6: warning: Uninitialized variable: reg_access_ctrl [uninitvar]
     if (reg_access_ctrl->spare_int)
         ^
 >> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:882:49: warning: Uninitialized variable: reg_access_ctrl [uninitvar]
      spare_int = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->spare_int;
                                                    ^
 >> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:884:16: warning: Uninitialized variable: reg_access_ctrl [uninitvar]
     if (offset == reg_access_ctrl->grbm_cntl) {
                   ^
 >> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:888:23: warning: Uninitialized variable: reg_access_ctrl [uninitvar]
     } else if (offset == reg_access_ctrl->grbm_idx) {
                          ^
 >> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:901:7: warning: Uninitialized variable: reg_access_ctrl [uninitvar]
      if (reg_access_ctrl->spare_int)
          ^

vim +877 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c

5d447e29670148 Hawking Zhang 2022-01-18  858
5d447e29670148 Hawking Zhang 2022-01-18  859  static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag)
5d447e29670148 Hawking Zhang 2022-01-18  860  {
5d447e29670148 Hawking Zhang 2022-01-18 @861  	struct amdgpu_rlcg_reg_access_ctrl *reg_access_ctrl;
5d447e29670148 Hawking Zhang 2022-01-18  862  	uint32_t timeout = 50000;
5d447e29670148 Hawking Zhang 2022-01-18  863  	uint32_t i, tmp;
5d447e29670148 Hawking Zhang 2022-01-18  864  	uint32_t ret = 0;
5d447e29670148 Hawking Zhang 2022-01-18  865  	static void *scratch_reg0;
5d447e29670148 Hawking Zhang 2022-01-18  866  	static void *scratch_reg1;
5d447e29670148 Hawking Zhang 2022-01-18  867  	static void *scratch_reg2;
5d447e29670148 Hawking Zhang 2022-01-18  868  	static void *scratch_reg3;
5d447e29670148 Hawking Zhang 2022-01-18  869  	static void *spare_int;
5d447e29670148 Hawking Zhang 2022-01-18  870
5d447e29670148 Hawking Zhang 2022-01-18  871  	if (!adev->gfx.rlc.rlcg_reg_access_supported) {
5d447e29670148 Hawking Zhang 2022-01-18  872  		dev_err(adev->dev,
5d447e29670148 Hawking Zhang 2022-01-18  873  			"indirect registers access through rlcg is not available\n");
5d447e29670148 Hawking Zhang 2022-01-18  874  		return 0;
5d447e29670148 Hawking Zhang 2022-01-18  875  	}
5d447e29670148 Hawking Zhang 2022-01-18  876
5d447e29670148 Hawking Zhang 2022-01-18 @877  	scratch_reg0 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg0;
5d447e29670148 Hawking Zhang 2022-01-18 @878  	scratch_reg1 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg1;
5d447e29670148 Hawking Zhang 2022-01-18 @879  	scratch_reg2 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg2;
5d447e29670148 Hawking Zhang 2022-01-18 @880  	scratch_reg3 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg3;
5d447e29670148 Hawking Zhang 2022-01-18 @881  	if (reg_access_ctrl->spare_int)
5d447e29670148 Hawking Zhang 2022-01-18  882  		spare_int = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->spare_int;
5d447e29670148 Hawking Zhang 2022-01-18  883
5d447e29670148 Hawking Zhang 2022-01-18 @884  	if (offset == reg_access_ctrl->grbm_cntl) {
5d447e29670148 Hawking Zhang 2022-01-18  885  		/* if the target reg offset is grbm_cntl, write to scratch_reg2 */
5d447e29670148 Hawking Zhang 2022-01-18  886  		writel(v, scratch_reg2);
5d447e29670148 Hawking Zhang 2022-01-18  887  		writel(v, ((void __iomem *)adev->rmmio) + (offset * 4));
5d447e29670148 Hawking Zhang 2022-01-18 @888  	} else if (offset == reg_access_ctrl->grbm_idx) {
5d447e29670148 Hawking Zhang 2022-01-18  889  		/* if the target reg offset is grbm_idx, write to scratch_reg3 */
5d447e29670148 Hawking Zhang 2022-01-18  890  		writel(v, scratch_reg3);
5d447e29670148 Hawking Zhang 2022-01-18  891  		writel(v, ((void __iomem *)adev->rmmio) + (offset * 4));
5d447e29670148 Hawking Zhang 2022-01-18  892  	} else {
5d447e29670148 Hawking Zhang 2022-01-18  893  		/*
5d447e29670148 Hawking Zhang 2022-01-18  894  		 * SCRATCH_REG0 	= read/write value
5d447e29670148 Hawking Zhang 2022-01-18  895  		 * SCRATCH_REG1[30:28]	= command
5d447e29670148 Hawking Zhang 2022-01-18  896  		 * SCRATCH_REG1[19:0]	= address in dword
5d447e29670148 Hawking Zhang 2022-01-18  897  		 * SCRATCH_REG1[26:24]	= Error reporting
5d447e29670148 Hawking Zhang 2022-01-18  898  		 */
5d447e29670148 Hawking Zhang 2022-01-18  899  		writel(v, scratch_reg0);
5d447e29670148 Hawking Zhang 2022-01-18  900  		writel((offset | flag), scratch_reg1);
5d447e29670148 Hawking Zhang 2022-01-18  901  		if (reg_access_ctrl->spare_int)
5d447e29670148 Hawking Zhang 2022-01-18  902  			writel(1, spare_int);
5d447e29670148 Hawking Zhang 2022-01-18  903
5d447e29670148 Hawking Zhang 2022-01-18  904  		for (i = 0; i < timeout; i++) {
5d447e29670148 Hawking Zhang 2022-01-18  905  			tmp = readl(scratch_reg1);
5d447e29670148 Hawking Zhang 2022-01-18  906  			if (!(tmp & flag))
5d447e29670148 Hawking Zhang 2022-01-18  907  				break;
5d447e29670148 Hawking Zhang 2022-01-18  908  			udelay(10);
5d447e29670148 Hawking Zhang 2022-01-18  909  		}
5d447e29670148 Hawking Zhang 2022-01-18  910
5d447e29670148 Hawking Zhang 2022-01-18  911  		if (i >= timeout) {
5d447e29670148 Hawking Zhang 2022-01-18  912  			if (amdgpu_sriov_rlcg_error_report_enabled(adev)) {
5d447e29670148 Hawking Zhang 2022-01-18  913  				if (tmp & AMDGPU_RLCG_VFGATE_DISABLED) {
5d447e29670148 Hawking Zhang 2022-01-18  914  					dev_err(adev->dev,
5d447e29670148 Hawking Zhang 2022-01-18  915  						"vfgate is disabled, rlcg failed to program reg: 0x%05x\n", offset);
5d447e29670148 Hawking Zhang 2022-01-18  916  				} else if (tmp & AMDGPU_RLCG_WRONG_OPERATION_TYPE) {
5d447e29670148 Hawking Zhang 2022-01-18  917  					dev_err(adev->dev,
5d447e29670148 Hawking Zhang 2022-01-18  918  						"wrong operation type, rlcg failed to program reg: 0x%05x\n", offset);
5d447e29670148 Hawking Zhang 2022-01-18  919  				} else if (tmp & AMDGPU_RLCG_REG_NOT_IN_RANGE) {
5d447e29670148 Hawking Zhang 2022-01-18  920  					dev_err(adev->dev,
5d447e29670148 Hawking Zhang 2022-01-18  921  						"regiser is not in range, rlcg failed to program reg: 0x%05x\n", offset);
5d447e29670148 Hawking Zhang 2022-01-18  922  				} else {
5d447e29670148 Hawking Zhang 2022-01-18  923  					dev_err(adev->dev,
5d447e29670148 Hawking Zhang 2022-01-18  924  						"unknown error type, rlcg failed to program reg: 0x%05x\n", offset);
5d447e29670148 Hawking Zhang 2022-01-18  925  				}
5d447e29670148 Hawking Zhang 2022-01-18  926  			} else {
5d447e29670148 Hawking Zhang 2022-01-18  927  				dev_err(adev->dev,
5d447e29670148 Hawking Zhang 2022-01-18  928  					"timeout: rlcg faled to program reg: 0x%05x\n", offset);
5d447e29670148 Hawking Zhang 2022-01-18  929  			}
5d447e29670148 Hawking Zhang 2022-01-18  930  		}
5d447e29670148 Hawking Zhang 2022-01-18  931  	}
5d447e29670148 Hawking Zhang 2022-01-18  932
5d447e29670148 Hawking Zhang 2022-01-18  933  	ret = readl(scratch_reg0);
5d447e29670148 Hawking Zhang 2022-01-18  934  	return ret;
5d447e29670148 Hawking Zhang 2022-01-18  935  }
5d447e29670148 Hawking Zhang 2022-01-18  936

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
