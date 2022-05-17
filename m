Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0901529A94
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241371AbiEQHLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240281AbiEQHLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:11:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F95BC02
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 00:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652771463; x=1684307463;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VN6iiUEWy8lD+K7fG/k3CXwRMFZuwSAgLBA8q2GC2AY=;
  b=AUFvABZssIUNhNOA7B3xNIrCVBb8nUMHlxRHjEIXlYB0w+AXXHsxBX7W
   fp2uvQtQ/wYPy6bT17G6lEIMGJIscwnsh7+bEVhnh7ReWOowOfU5JhOdG
   mjqj3hVI0X08XWLm98/aQV72Kqz6W8knxfOKWc5FE4xmnynVL4z5YLuUn
   DhiLiSg6SNkF2blsah9B05vwd+ufSRSyzT4Q1HqTY0XDMxs6qrvP4/FkC
   1dvh60W4srmNuhRa+MZeaLug5TzNQyHNaVWABLo4dfLRbReo+2Ma4mvnb
   RjaX8Fd9kQsW9gT52cJ5SmEMnkn8S1Mh2OHfs53UMUs84VZcSjWlrQec7
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="250985517"
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="250985517"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 00:11:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="660480731"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by FMSMGA003.fm.intel.com with ESMTP; 17 May 2022 00:11:02 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 17 May 2022 00:11:01 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 17 May 2022 00:11:01 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 17 May 2022 00:11:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwQ8ZR+fznjpem1HlwPlYSQz+HIeJdIkalcSxINvxJywCYkIn/fhAKxlOMG4C4IzJ/h77p3apLr33KMmJGc3HVQpcvdXWg1QS2p75esOc+jYNdkeyjxNYgmNcqMPXsExEK5xwO0SVyswg468o9cORlMBUVFHyLTap4DPdXDodCl9hcIC5gwhe0gq7W36s2Ie+x6BRNeV4lEwY2Cex7gfk56Rtn/FW4CJDFOt0xshHve6rZ+rnbnqyX+y0hdp+Ud0v0AuyrAyI2E7XsdQ1PmFpWfdHR9ldg0Wy8pQhIYKG0BB9C4FFm4wtLABMfYfwb3qCA4khtZvuhW+awQ1VRDnRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8Gi2mPPkepMY8jaeEM1hpkv5T4OvWevgAaLV5pUC+I=;
 b=GSuQ16ypMeruTvhsMWBwBgL2iSYtmn8zx46fcCj8SAMQRr3kwuIyeBxD2ZWmVEbiAlmdnYIas1Y0jSbh0FQ4TzGpzDERJapx7NbbX8AnKkXhqrNa0Ik4xpwaMGyeKFuyfXvIjb1qSNDhsPR++cNr2iJw5gKiEZi0/H9HYa/8VBllFy3enrRWV8QJqFyhoX71+IgjKb2neStZoMknqKKlfv1wKrtnzcWy2fzTmTZexyJnsNOpVsU37lGlH8UoADhHuvXKa1hIVFIOKZr0sC4TDa0A0TQd0fNQpZYl+YO8+c8b6O3KlBrept6QOiYIN5kVMyezjwauvZsjw5LYjs3MvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5933.namprd11.prod.outlook.com (2603:10b6:303:16a::15)
 by SN6PR11MB2846.namprd11.prod.outlook.com (2603:10b6:805:5b::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.17; Tue, 17 May
 2022 07:10:59 +0000
Received: from MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::1169:fc9:c1ef:248e]) by MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::1169:fc9:c1ef:248e%7]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 07:10:59 +0000
Message-ID: <3aa2df14-929f-6849-00f3-31d40e9cb33a@intel.com>
Date:   Tue, 17 May 2022 15:09:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.0
Subject: [lunn:v5.18-rc4-stacked-bridges 1/2] kismet: WARNING: unmet direct
 dependencies detected for KEYBOARD_GPIO_POLLED when selected by ZII_RAP
References: <202205171346.hbcZqjB1-lkp@intel.com>
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
CC:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        <kbuild-all@lists.01.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202205171346.hbcZqjB1-lkp@intel.com>
X-Forwarded-Message-Id: <202205171346.hbcZqjB1-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0194.apcprd06.prod.outlook.com (2603:1096:4:1::26)
 To MW4PR11MB5933.namprd11.prod.outlook.com (2603:10b6:303:16a::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce4e46ea-d4c8-4c4e-e062-08da37d46494
X-MS-TrafficTypeDiagnostic: SN6PR11MB2846:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR11MB28464319B1A8A27BA01AF33DFBCE9@SN6PR11MB2846.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s5CigtdMMbjJ2EXrT7BDQtWBBU8iygPTqailH0MIWtnWZyEpoMOQtSD6rKIvmp94f3Vov6Vq8f3uFRBEsn83X47MfVd7OtEuGuH6Kk+2OKzIK+UOf8JDq5HsJp25UDvD9MldPC4PMicCqWY+VyN04R01p/hMZ9nqqlb7qbiw+KBxbeeKDuwbqTG+tRDzTLn3ZMvpueLlJqHUjH7ayyN1c+APHWbVMLvh8eUxSmIRmJY2+lAKxrOY8RRQcxTg10Yqk2yQctR1yj7cAbWtJ4XQS7142MuCMX/uWcp8a1+NKS+USE/jtOh5pKpJmZvlqcL4tc7490koX1sBeEav1c9xn+cPcw3uwPbtsQj1Q2FJ89V/bmZ+0mRACr3cDOjSt80ve1xvSVxtkrTiQrUGrdAVDny8B87dUmvCtbk+jLPTkbtXwHZbC+ZeI/UeDZ8/23P7bo+Gw5dgNRjXtDumcrFgNEMwdYwmLxEpK9SWjEsZ0eyqz9x0bqNbdlnn7B/oQx1gKshemv9MkJOgAWM/zZfo1/6ZKKnQBLR1UNpes6mHz/MKi2qnCZMWO93CIgKeCNcVLumSwW+f72tqG05QB3cFZh2Q5ghIeDJC7sJBcr24GGyF3UIXWR1tWgrHESbOh8h0hTZUFSs/E8G1ea3S1aZi68snHtnlOjhd1VEWcAjdWQRuAhvrxBDPmCd74yjgw/p04uisvO4Kh3q5LXhZkyIuKRBVuwakn5Fd5vWUBCzy2Jb7yCxhqw/3pf53MfLlKY26GIGeJAm6qh3WZsiFEmrDutdXADHFaU+m620mo+q1e1iiD1V6cU+B0Fl3VGQR6ALU2U49wzf2bMcN3N685wMd1962WcjLzpdV1qBfK7otiqs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5933.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(6916009)(6506007)(186003)(2616005)(83380400001)(66556008)(66476007)(8676002)(31696002)(86362001)(66946007)(6512007)(26005)(6666004)(31686004)(82960400001)(5660300002)(8936002)(966005)(6486002)(38100700002)(4326008)(36756003)(54906003)(508600001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTVyeHUrMHd4bWVFb3ZNdm4zUWNua0dzaEhOQVBlK3JUZ1dHUlZqclgwSFFM?=
 =?utf-8?B?dmpsREh3UHQ5SmE2b25uU1NJUVBLd0JpN094RkNHd1I1RVlLdTQyWTJVbWRX?=
 =?utf-8?B?MFhTU2kxM3B3cm9ESWZwR0NSTzU5ZVY4djFxR2xLS1VEbTJva1RrSnczL1pL?=
 =?utf-8?B?OFdUeFhHWnRtR1luUTZqcXBibGh1RE5JMTRtY1Zna2pLUDNMcTRrQjVTV214?=
 =?utf-8?B?ancrK2ZkcWZCNzlScjNOYWNCeUNMdG9EUm96VFFoenlacHRMOE91R1RKL0s5?=
 =?utf-8?B?N2NIbzBPdTJoVTRKSXkwOG51b25FRUVoZGtFak5WZXh3b1hEZEhCUXFrSS9u?=
 =?utf-8?B?OUMrZGozV0p4SnVneTVZc3JURW8rRWNNdWlQUm8vVnY3ODRlVUpvdE11ckw3?=
 =?utf-8?B?Y1h6RjNablpRQkhoR0pYQWhLRE56L2FZZEpSeWRFQ3ZzWlhBdDZOMW1Ucm1M?=
 =?utf-8?B?bDZ4L0gwWldaNGhPejJDSlFhL3ZiSEVkOWY5cXN3MFVUa3JaZk5HN1hyUkdy?=
 =?utf-8?B?WjFKbjdrSUdBd3lNRm1XSG54UVBIZlh1NWswREVUeHp6V3pONWY1emVGbnd4?=
 =?utf-8?B?TWoyTVNDVUpDNTE5aDJQRzh6cXVzQ1I2dEtWdVBYK01DRWtjYjl6dUdKTXdU?=
 =?utf-8?B?MkRGcmJ5VXk5QnVpVThWeC9aSkpDaC96UHZiWW5UeStwQlVNdzFiN20xOXo3?=
 =?utf-8?B?TlpSaUhMZFAxRnp6cTJOTVJEN1pDNVJ0b3lGTnBoemhJOHBvNE5LT0tvOGFQ?=
 =?utf-8?B?ZzMxVjJOTU9LL05vU1dVM0dvL294K0lHNnNEeDBhYjdPQjkwUXJiTjIzQ1dO?=
 =?utf-8?B?REYrNkxzckh4azd6c0t1YllDbE0yL1R0NXRQeUk4ZVdPcUVRRGQ1U1QxRGpM?=
 =?utf-8?B?YWxEZTh2RWN3dnpWZjM1OW1ERHVNOFhvM1cwekJJR2xVaTkraXJhUXhvYmdO?=
 =?utf-8?B?bzhVUEZhQUpGRks5eDdza1gxT3hkc1JmUjFnL3ZGQkVOWm5jUXZ4a3dWVW05?=
 =?utf-8?B?d1JQREhXM3ZNSjJwRTZTcWFPUEVjd2N5Y1Z3NkpYaTkzcU1IT2xLR3dNdURi?=
 =?utf-8?B?T01KMDFjS0dFZ3hieE5aMzN1TDlpc1JoNlZ4UXdHWGtobHNWV2RKUGF1aWlu?=
 =?utf-8?B?Zlh6aWVLZ2xDVGpFcHpQZkRHdUF2R2d4SzlmWE5SWkoxL1A5RkcyM0p3Y2w5?=
 =?utf-8?B?UjRwTlBJNlpzZTF2WjU0MWNzeGJjOHpveUNPSlZxQVpuMWw2RHByVlpNRnBV?=
 =?utf-8?B?clpVQmdaWlJZOFBWc0lUdVJ3VzVobGlzVXBmaUxHVjNFNmdkNW5WNVFrQ2VR?=
 =?utf-8?B?eEZaRzhtSkVZaEd4eTdpc2F4Q3AwU2pmY24wd0VoYUwrNFd0dTlXU1V3Q2x2?=
 =?utf-8?B?Nlo2bUhBOGdFaTRvdWhaUnFCZzg2a1V1Wmx1cTAvaFRRTUZYc2ZiTWtvamRs?=
 =?utf-8?B?MEJwWnUwTTc1OFVjaUhERHYxMzBVQlVxYVNjSUZiS3VKQnlWRUNsRTFPUkJZ?=
 =?utf-8?B?YkpBQnRhWXhRMTQ1SWpoZUZUWXo2b0h6b1NZRnNraUtGaHlHNmxFZ0FmK29O?=
 =?utf-8?B?L0NrUlJSWWJ5TmwwckY2cEhSa1FnaVVSemkvdXhnQ3NCTUllRXlPazJDZ3di?=
 =?utf-8?B?eUttZnQ2SzQzVHNpRElBcVFWd3lEZ2dKaG9sUXZLQzlmTm4wT0t1UEQ2ZFRF?=
 =?utf-8?B?WnFnMmx0cHJodkpOeUd4czRQR3FqMXl3Y3I3U1QwM0NQNTE3cE5RbEZhdVZW?=
 =?utf-8?B?eTJmR0I4V0lnaGJVZzhHUWxpRVRWUlQwY1UwTTVtOFVaNEdncHZEL2wzQmIw?=
 =?utf-8?B?cVRHNHdTYWs5aVZ4TWJBVzY1TVM2Tk9USS9ZdXhYNWw3WTRjdThCOWFjazNw?=
 =?utf-8?B?VnlBZXVYZmtuemFVRjlHMnlhd0NOdVBiQnZ2dFhmTys1alVicUhhQ0t3QWE3?=
 =?utf-8?B?ZWkzR2JxemJwTVh1djFMU0hkRTFLQ2ltMlY4dC9xS0FsbjEvb0NHblYvWmlW?=
 =?utf-8?B?Z0JHdFFTYlpyTFdGL1dpb1ZZUUVUSDYzRnpNOVBqWDREcUpVY1l3OHZoRndD?=
 =?utf-8?B?R2VyazM4ZzhTUUoxblJBN05uTnFlZ1d6WVZmb3FCaXhKUFYxZkNZZFlGMmhl?=
 =?utf-8?B?NFFrc05PRTF5RjFEdllSWVd6dWIxakhURkI2aFQ0T1BGYUhkeENvRXFuUmRE?=
 =?utf-8?B?Q0RseDI4blBGNWt3NHBmdTA0VVh5bDZqZm94RE5NS0pmdFNnSG1YQXB5VnlZ?=
 =?utf-8?B?ejArOFRndkgxd3NSN0M3aEovc2hoSFI1dHJxcmVuN3BKa3JBTFJUTnQrMTl0?=
 =?utf-8?B?bmlFenNEelhwYURPOUpmRmJycW0yR0pSSWk1eVlPREdWeitRRGdhVXo2QkRV?=
 =?utf-8?Q?r7Grz2Waramhhq+4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4e46ea-d4c8-4c4e-e062-08da37d46494
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5933.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 07:10:58.9699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: crLZFVr2X5g0I0STi31pMGMElwqCob9QEKqu9cuFN56gHugKhSaG0hB4k6ztVXUoBWbcARux5XVm+zzXaCQlhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2846
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/lunn/linux.git v5.18-rc4-stacked-bridges
head:   54c29cf210da59f450762e12946a2dec224c6850
commit: 104ddfd33f3bd72e3a37262edefff94c0c7d55d4 [1/2] platform/x86: Add Zodiac Radio Access Point platform driver
config: (https://download.01.org/0day-ci/archive/20220517/202205171346.hbcZqjB1-lkp@intel.com/config)
reproduce:
         # https://github.com/lunn/linux/commit/104ddfd33f3bd72e3a37262edefff94c0c7d55d4
         git remote add lunn https://github.com/lunn/linux.git
         git fetch --no-tags lunn v5.18-rc4-stacked-bridges
         git checkout 104ddfd33f3bd72e3a37262edefff94c0c7d55d4
         # 1. reproduce by kismet
            # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
            kismet --linux-ksrc=linux --selectees CONFIG_KEYBOARD_GPIO_POLLED --selectors CONFIG_ZII_RAP -a=x86_64
         # 2. reproduce by make
            # save the config file to linux source tree
            cd linux
            make ARCH=x86_64 olddefconfig

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <yujie.liu@intel.com>


kismet warnings: (new ones prefixed by >>)
 >> kismet: WARNING: unmet direct dependencies detected for KEYBOARD_GPIO_POLLED when selected by ZII_RAP

    WARNING: unmet direct dependencies detected for NET_DSA
      Depends on [n]: NET [=y] && (BRIDGE [=y] || BRIDGE [=y]=n) && (HSR [=n] || HSR [=n]=n) && INET [=n] && NETDEVICES [=n]
      Selected by [y]:
      - ZII_RAP [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y]

    WARNING: unmet direct dependencies detected for IGB
      Depends on [n]: NETDEVICES [=n] && ETHERNET [=n] && NET_VENDOR_INTEL [=n] && PCI [=n] && PTP_1588_CLOCK_OPTIONAL [=y]
      Selected by [y]:
      - ZII_RAP [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y]

    WARNING: unmet direct dependencies detected for PINCTRL_SX150X
      Depends on [n]: PINCTRL [=y] && I2C [=n]=y
      Selected by [y]:
      - ZII_RAP [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y]

    WARNING: unmet direct dependencies detected for EEPROM_AT24
      Depends on [n]: I2C [=n] && SYSFS [=y]
      Selected by [y]:
      - ZII_RAP [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y]

    WARNING: unmet direct dependencies detected for MMC_SDHCI_PCI
      Depends on [n]: MMC [=y] && MMC_SDHCI [=y] && PCI [=n]
      Selected by [y]:
      - ZII_RAP [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y]

    WARNING: unmet direct dependencies detected for RTC_DRV_DS1307
      Depends on [n]: RTC_CLASS [=y] && I2C [=n]
      Selected by [y]:
      - ZII_RAP [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y]

    WARNING: unmet direct dependencies detected for NET_DSA_MV88E6XXX
      Depends on [n]: NETDEVICES [=n] && NET_DSA [=y] && PTP_1588_CLOCK_OPTIONAL [=y]
      Selected by [y]:
      - ZII_RAP [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y]

    WARNING: unmet direct dependencies detected for PHYLIB
      Depends on [n]: NETDEVICES [=n]
      Selected by [y]:
      - ZII_RAP [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y]

    WARNING: unmet direct dependencies detected for USB_SERIAL
      Depends on [n]: USB_SUPPORT [=n] && USB [=n] && TTY [=y]
      Selected by [y]:
      - ZII_RAP [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y]

    WARNING: unmet direct dependencies detected for USB_SERIAL_FTDI_SIO
      Depends on [n]: USB_SUPPORT [=n] && USB [=n] && USB_SERIAL [=y]
      Selected by [y]:
      - ZII_RAP [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y]

    WARNING: unmet direct dependencies detected for MDIO_BITBANG
      Depends on [n]: NETDEVICES [=n] && MDIO_DEVICE [=n] && MDIO_BUS [=n]
      Selected by [y]:
      - ZII_RAP [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y]

    WARNING: unmet direct dependencies detected for MDIO_GPIO
      Depends on [n]: NETDEVICES [=n] && MDIO_DEVICE [=n] && MDIO_BUS [=n] && MDIO_BITBANG [=y] && (GPIOLIB [=y] || COMPILE_TEST [=n])
      Selected by [y]:
      - ZII_RAP [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y]

    WARNING: unmet direct dependencies detected for I2C_OCORES
      Depends on [n]: I2C [=n] && HAS_IOMEM [=y]
      Selected by [y]:
      - ZII_RAP [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y]

    WARNING: unmet direct dependencies detected for DS1682
      Depends on [n]: I2C [=n]
      Selected by [y]:
      - ZII_RAP [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y]

    WARNING: unmet direct dependencies detected for KEYBOARD_GPIO_POLLED
      Depends on [n]: INPUT [=y] && INPUT_KEYBOARD [=n] && GPIOLIB [=y]
      Selected by [y]:
      - ZII_RAP [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y]

    WARNING: unmet direct dependencies detected for USB_SERIAL_CONSOLE
      Depends on [n]: USB_SUPPORT [=n] && USB [=n] && USB_SERIAL [=y]=y
      Selected by [y]:
      - ZII_RAP [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y]

    WARNING: unmet direct dependencies detected for MARVELL_PHY
      Depends on [n]: NETDEVICES [=n] && PHYLIB [=y]
      Selected by [y]:
      - ZII_RAP [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
