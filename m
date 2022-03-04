Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F40B4CDBE8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241545AbiCDSNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbiCDSNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:13:45 -0500
X-Greylist: delayed 917 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Mar 2022 10:12:57 PST
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64D44ECEF;
        Fri,  4 Mar 2022 10:12:57 -0800 (PST)
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 224HcX6k009408;
        Fri, 4 Mar 2022 09:56:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=message-id : date :
 to : from : subject : content-type : content-transfer-encoding :
 mime-version; s=proofpoint20171006;
 bh=RIXm2RJm4PsBnWO24JGxllwstYgN4WvyAUUYQb4oI34=;
 b=m3kKXi8GsXIw18Qu3I0G0FzriIEo1FgROphLlnPggLxtEYxWzDk/09gOpLZhDcRf0s9s
 +8hHJBUovHzRccgOtFug6JLykv/fOsFIpU5KyUNwiFZKsBj44LTOLn3iCnn+N4N+mlwJ
 kau1l9X4m3giBTGkdjF+WOXt02mZqFZzujIKe5Eo7jLyzEUtHagrtnwb8jUYSWbBN6PX
 V6PcvQXjTXsi0Fjd+ZyU/jXd1t6iOJ+7FOmpXKknwb7UND/xdliZzTboRphtgzJdbA1V
 0s+GN1Oa5131yCwosjoOwKvfs+PS0999/ZQr623vUmd6J/JeBwJATR11skEg+azA/t1a +g== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3ek4j7j3t4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Mar 2022 09:56:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0HeRW0oyLmcDtfJqMlJHHBrwVl47dpOEeFQW0ZQtP9+RWXEKd74qN40gUTkPJ4WW+plPDdLj3lpuFEEDbSirDh4Zq2OtwCXPq3Y4vELkChXjQwUBOqK3T3CkBnbiNWRQeszS6li2ndN1WICha+VuYcCZtOsq5JapCev4RzUbJSgm2HIJweGpK8lVqyvM5aL3n8Mopc8aOCQLEaI/eqHdcVbytHGqDE+ZX+eiGfZqTDQbcDGjErJRcCqevIuS1aGmIQiniqGFveWDX5mHmezCnQ04hb3t09zaDcRYkSJPEVrfkhc3VY/OgZXyAYC+NjrI5pNZb5oNYKdA1i+8lGWVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIXm2RJm4PsBnWO24JGxllwstYgN4WvyAUUYQb4oI34=;
 b=aBHcJlE/GnrjZvORzZ7SZtKCn1/i/j3SRpJDiG2NFAqYxLis4WjxTb/DjnyyoWRQRx3P5WEIsDMmzwXCddDW9E88p1vI09ne74VmyvMNYSLaHyTkAT2vBJIPrkwLJIOf7B7ig46KkOddNB0dP9ugapElBJPsnQoL+MaWDT7bt6fAqt9w/KV9mCeRWe7n6NpBda8AW6bHf8QoZ/vvaWSWnxXIKL6EjA1PPvxk6vzrwEVGejzDaX+nm+urbg3YDrpt0rthYRcBg8IyIi07arUFiyWIT1pZhHupAjVhIDKdiMebLpyHb2QIFpaiUMygL7zIh2FTWQa+VwpdBtykBl7Yng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from CY4PR0201MB3460.namprd02.prod.outlook.com
 (2603:10b6:910:91::14) by SJ0PR02MB7694.namprd02.prod.outlook.com
 (2603:10b6:a03:324::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 17:56:08 +0000
Received: from CY4PR0201MB3460.namprd02.prod.outlook.com
 ([fe80::7567:4530:d91f:33b3]) by CY4PR0201MB3460.namprd02.prod.outlook.com
 ([fe80::7567:4530:d91f:33b3%3]) with mapi id 15.20.5038.016; Fri, 4 Mar 2022
 17:56:07 +0000
Message-ID: <dd620dbd-6d71-7553-d1e9-95676ff12c82@nutanix.com>
Date:   Fri, 4 Mar 2022 17:55:58 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     minchan@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mhocko@suse.com, hannes@cmpxchg.org, timmurray@google.com,
        joel@joelfernandes.org, surenb@google.com, dancol@google.com,
        shakeelb@google.com, sonnyrao@google.com, oleksandr@redhat.com,
        hdanton@sina.com, lizeb@google.com, dave.hansen@intel.com,
        kirill.shutemov@linux.intel.com
From:   Ivan Teterevkov <ivan.teterevkov@nutanix.com>
Subject: Regression of madvise(MADV_COLD) on shmem?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::22) To CY4PR0201MB3460.namprd02.prod.outlook.com
 (2603:10b6:910:91::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7c780b6-3d6b-4c84-061a-08d9fe0841d9
X-MS-TrafficTypeDiagnostic: SJ0PR02MB7694:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR02MB7694D19206280441A7F5293AE9059@SJ0PR02MB7694.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YBCErF6Cgp7QFZAQ70+VJ8YAIWeGP5B8YFt3IXvZjeaG2s1JNWsV3BoGso5QBitkjhFWlIQdZJVeYcddTNr1v07Hq9pwNRi8jK5p0iNMT844GxFEIA6WVQHEBjMGV5izTLTMLrkbC16fAqZ5fOUbrbvxXpqS+A2ksetsfPgW1dyxZQY32LEHse+QJkleMKgGsurD8U2XPlG5iZ/SvpO9IF9JGQAcgvSpr5Qk7ho+ovNo4T4FI2QSwp+vNIGNfg12i8SrNsK1x9DugDCNzM1h0Q1hTiTFlljxrJHUw5bsRK5gx0Mm7hh7oaxN14Uia7oAdCTm3ws72vjGetdMgbtgsUxHOEbvRHlfanHCje22pOfFM0DrmMp3jw14OFekYj0z0nblw0yUMq+BssH1P7mBkRB3hOmv2WJpGJG8er0t+8UwEYfg605bvIbOrDjmkUDJnc+S0duTKYyDVhh5h2ssObV/Ll7OnKYH66gYx9DetYC1FTBIMuTCpMaUzLeHtHvhiRRVu81yOEdIqd0eIwz8IEMgMfTMD6k7j/b63h6nvHRPQg4gq+H/bGEwS0WUAVrE0yhnnrncX7UYlwLekktmVZeLh1VgYXVqXNZQaf94wd2syX4+YsL/EIiTc0CJNkG/xdLq9/YvUO9SDS9pKos+ErBssmXN0nmg+otQXP0a5jFarTBIsba6bOTBc9rRjac9SjY/WDMvRUlK0nCfHNYBEZkxexDsQR0Eui/CjcnBzTZw8fTGINnVTBohEzIUDfHLSHtrOB6+glXa1OF27QATGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR0201MB3460.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(44832011)(38100700002)(66556008)(66476007)(66946007)(31686004)(6666004)(6486002)(86362001)(508600001)(921005)(31696002)(2616005)(5660300002)(316002)(8676002)(186003)(26005)(36756003)(7416002)(6512007)(2906002)(6506007)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1lpRTQ4TFMzUnQva0FsWnRYOXcyOXByVXc3Q09sRlUyeER4UHAzcXVPblBS?=
 =?utf-8?B?SllKRW45WVZwT2REMTIrbXV3citxdEsva3BUbDFpWCtvSy8xZ0dDZkt5Y1VE?=
 =?utf-8?B?THVRK0N6YzVlN21pekZad2NacDg3WUtjd2Nza296UDlZK0dTU3phSkZPcHov?=
 =?utf-8?B?TU9zR2x6VFpwRmhDQzdzS0hBeFo4ZkN0d01tNm53UU1ZaVlWN0ZrK0NPempt?=
 =?utf-8?B?YW9qYWFGakd1T2VTMzVtMjNtS01peXQ3czlwaHAwQUU4c2pYTENmRTRTZmVm?=
 =?utf-8?B?U21WMnBuSDdiM3BQME9pTzBjQ2hGNEZxeEZSV0R3RHoyRkk0TWd0QTJhdSsw?=
 =?utf-8?B?Q3Y2cTJSTnNNSytTTktCb1JDbFpQT2dGRmlYU3czbk9rc0VzbTJGZ2ZRZlNw?=
 =?utf-8?B?M0NoYno5SEVGTmFaS2ZpaTJNRnI5WE4vQ09kOFd5ZjlsZFdLTEtJSUh6dk1n?=
 =?utf-8?B?MnZIWGdOSnpsYTZIVzNSdHpVaENPU2VrRTQ5NHo4MzQyQzJIR213TWtzb3BN?=
 =?utf-8?B?Z1g3RTBZckVHYXVXbDBDM3oxZWtSc1lMQ0JUajFWWUVIeDQ2STFhdTlFK0kw?=
 =?utf-8?B?NEZUYU80NEpIQ3ZhRVcxc0FhZllSUy9uTWxFY001R3B6RTdqQUFFenZOUFlP?=
 =?utf-8?B?WU1WU3BSSlR2SUM4UWt4K3piYkdkSnR6YUhEY2s0S3VqRGVKK2xIeXcycndW?=
 =?utf-8?B?OXp3Q1Z5cFFKSi9tZHJLZVhrcXU5ZVQ0QTYzOWlMNnJRcTlidXZScjBYa0k3?=
 =?utf-8?B?ME5VS0w3dTg3Wjlhcm9NOUVqVFRBQ2RxNlE2cGcyN3dTY3BYWEVLNFBBQnV3?=
 =?utf-8?B?L2lzWS9lSDZnY05wMURVV0hWVFM1RDFSVjdMdGV0ajJTZk1VWGdYcXlsYUMy?=
 =?utf-8?B?WGdWQTQ0ejAzY3BqNlI2TDk3VThRb1V6RmtOUzU0Um5HRTFRMG1EVTJhOW40?=
 =?utf-8?B?c2FnWnp4ZEJZNUxMblQzU2NNQUcwY25PNGhWeU5oSUdGeTg2U0lIaUxreVpj?=
 =?utf-8?B?Zm1FbEsvWXRnaUxxZG9xd0UybkNvWG00RU5xTUN2cU1zcU82ZkFmVWw4Unda?=
 =?utf-8?B?dG1XVEJ5TzgyNG5TSlJYbit6c1BHRmVhOTlQVHZZM3JvbEQ3a0xhQW5VKzhK?=
 =?utf-8?B?WFJWQzQxdHBTTDhyNXNRTDlrOXBiUUF1Z1o2b3pEVEV3YnZTZEx3bVgrMEtm?=
 =?utf-8?B?TitCcElkN1lHT2swNnJKcXN2aWsvQlFzdTRsR1dXdXdBNklFcXFqQmtWLzBi?=
 =?utf-8?B?M3FYS25ONE45bS8zZ0l1dmVWYnZUOGEyR2wrQ2FSMXpJWHo2TUJvZnNZTGt1?=
 =?utf-8?B?ckhIem9Ta1FUYlpNZm9QSGpMZU54ZUdHK0RicVJoSVppNGx6Ny9YTTBxY3U3?=
 =?utf-8?B?RHVVYmpRZ0thVGMxdmtpUSsvUERpUlBNVFVWTE1xTmc0ODMwUlkwN3ZNc1FU?=
 =?utf-8?B?VldaRml5ekFFMEROZjl5Y2FiZkxBZm05bHQwVFR1cVZyV0R3RDRxS2tJbEVJ?=
 =?utf-8?B?Z3JjTVlLNjNWOWNCZlpHM3YzNmthTmFKS0JkUUZsblUyZVVMcUR0Y3VySTB5?=
 =?utf-8?B?TVg2NEwzTDRkUUgyWlJVSW8xdXpKektITEpsY3IrQjkxN0xyQXV3Wm5IRkd0?=
 =?utf-8?B?VEMwaVllRWZSMS9sUmNqQlQrY2p2Snl1eTYrdWpRY21xenYrMUxBY0pFczZI?=
 =?utf-8?B?djZtLzY4RXFJQmRaZ1QrQldNOU4zNnhWY3dtWXYwVHNkRnd5d3NuR0daeFFU?=
 =?utf-8?B?Mlc2UXhWT3l1azcyaENWbm5hN2ZYMm9qR3BaZldmWWNZSUtDdFpaOUJnVWUy?=
 =?utf-8?B?VmhTM2N6aGFGOFRtVUVUTlhlYnA0TzhzaEpURG9zTytyOGRQY2NYSDdiNDRj?=
 =?utf-8?B?SmtIcVpsTXpLYkxQdmQ4bXNxT0p6WUJkR0RRakQvUVV6dEFUVE5hUlRITnNn?=
 =?utf-8?B?dmQyZU5jN25XRTM5OFVRRUc0Um0wakhSUW9QSXBNZklVeTUyWHZackhqZjZY?=
 =?utf-8?B?RGRxdG5IL29SalF4WmFlMjZsdWFmU0o1OG8wSUozVjVCMVo3NmpqcmZnV2Nw?=
 =?utf-8?B?TEdiWk12Z2FrNXE5VVNlUWtJSmZ4aVBxMVhjUFRoT2VBc2MweVIwdFdaUE1V?=
 =?utf-8?B?cElGcDNWbjQ5d2FvektRcWtTM090R3VSbVViSmFhMTRpeDZ3SjluYis3NSsv?=
 =?utf-8?B?TTFkdHlGWloyN2toRTZYaFY5R0ExY0lOY24rUnArYkU2dllFd1g0ek9Ha3pS?=
 =?utf-8?Q?5RWkpcQttzm8XGbCKJ15rkbhHYxBY+96fFiTZR4byo=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c780b6-3d6b-4c84-061a-08d9fe0841d9
X-MS-Exchange-CrossTenant-AuthSource: CY4PR0201MB3460.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 17:56:06.9602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2AsbJRsd9j5ewPhdnQOVOjaRp4nk1P4ArSSADaZDGesO7+CsTs3Zz3f4z7+6PEgVaRlP7oZOkgyRU6EWxRBAzJQ7seCM2mA33eXP6D6hkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7694
X-Proofpoint-GUID: cyu-aBlLuBiKVvSwdhw2-hOe2UTUmmk9
X-Proofpoint-ORIG-GUID: cyu-aBlLuBiKVvSwdhw2-hOe2UTUmmk9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-04_08,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I want to check if there's a regression in the madvise(MADV_COLD) 
behaviour with shared memory or my understanding of how it works is 
inaccurate.

The MADV_COLD advice was introduced in Linux 5.4 and allowed the users 
to mark selected memory ranges as more "inactive" than others, 
overruling the default LRU accounting. It helped to preserve the working 
set of an application. With more recent kernels, e.g. at least 
5.17.0-rc6 and 5.10.42, MADV_COLD has stopped working as expected. 
Please take a look at a short program that demonstrates it:

     /*
      * madvise(MADV_COLD) demo.
      */
     #include <assert.h>
     #include <stdio.h>
     #include <stdlib.h>
     #include <string.h>
     #include <sys/mman.h>

     /* Requires the kernel 5.4 or newer. */
     #ifndef MADV_COLD
     #define MADV_COLD 20
     #endif

     #define GIB(x) ((size_t)(x) << 30)

     int main(void)
     {
         char *shmem, *zeroes;
         int page_size = getpagesize();
         size_t i;

         /* Allocate 8 GiB of shared memory. */
         shmem = mmap(/* addr */ NULL,
                      /* length */ GIB(8),
                      /* prot */ PROT_READ | PROT_WRITE,
                      /* flags */ MAP_SHARED | MAP_ANONYMOUS,
                      /* fd */ -1,
                      /* offset */ 0);
         assert(shmem != MAP_FAILED);

         /* Allocate a zero page for future use. */
         zeroes = calloc(1, page_size);
         assert(zeroes != NULL);

         /* Put 1 GiB blob at the beginning of the shared memory range. */
         memset(shmem, 0xaa, GIB(1));

         /* Read memory adjacent to the blob. */
         for (i = GIB(1); i < GIB(8); i = i + page_size) {
             int res = memcmp(shmem + i, zeroes, page_size);
             assert(res == 0);

             /* Cooldown a zero page and make it "less active" than the 
blob.
              * Under memory pressure, it'll likely become a reclaim target
              * and thus will help to preserve the blob in memory.
              */
             res = madvise(shmem + i, page_size, MADV_COLD);
             assert(res == 0);
         }

         /* Let the user check smaps. */
         printf("done\n");
         pause();

         free(zeroes);
         munmap(shmem, GIB(8));

         return 0;
     }

How to run this program:

1. Create a "test" cgroup with a memory limit of 3 GiB.

1.1. cgroup v1:

     # mkdir /sys/fs/cgroup/memory/test
     # echo 3G > /sys/fs/cgroup/memory/test/memory.limit_in_bytes

1.2. cgroup v2:

     # mkdir /sys/fs/cgroup/test
     # echo 3G > /sys/fs/cgroup/test/memory.max

2. Enable at least a 1 GiB swap device.

3. Run the program in the "test" cgroup:

     # cgexec -g memory:test ./a.out

4. Wait until it has finished, i.e. has printed "done".

5. Check the shared memory VMA stats.

5.1. In 5.17.0-rc6 and 5.10.42:

     # cat /proc/$(pidof a.out)/smaps | grep -A 21 -B 1 8388608
     7f8ed4648000-7f90d4648000 rw-s 00000000 00:01 2055 
      /dev/zero (deleted)
     Size:            8388608 kB
     KernelPageSize:        4 kB
     MMUPageSize:           4 kB
     Rss:             3119556 kB
     Pss:             3119556 kB
     Shared_Clean:          0 kB
     Shared_Dirty:          0 kB
     Private_Clean:   3119556 kB
     Private_Dirty:         0 kB
     Referenced:            0 kB
     Anonymous:             0 kB
     LazyFree:              0 kB
     AnonHugePages:         0 kB
     ShmemPmdMapped:        0 kB
     FilePmdMapped:         0 kB
     Shared_Hugetlb:        0 kB
     Private_Hugetlb:       0 kB
     Swap:            1048576 kB
     SwapPss:               0 kB
     Locked:                0 kB
     THPeligible:    0
     VmFlags: rd wr sh mr mw me ms sd

5.2. In 5.4.109:

     # cat /proc/$(pidof a.out)/smaps | grep -A 21 -B 1 8388608
     7fca5f78b000-7fcc5f78b000 rw-s 00000000 00:01 173051 
      /dev/zero (deleted)
     Size:            8388608 kB
     KernelPageSize:        4 kB
     MMUPageSize:           4 kB
     Rss:             3121504 kB
     Pss:             3121504 kB
     Shared_Clean:          0 kB
     Shared_Dirty:          0 kB
     Private_Clean:   2072928 kB
     Private_Dirty:   1048576 kB
     Referenced:            0 kB
     Anonymous:             0 kB
     LazyFree:              0 kB
     AnonHugePages:         0 kB
     ShmemPmdMapped:        0 kB
     FilePmdMapped:        0 kB
     Shared_Hugetlb:        0 kB
     Private_Hugetlb:       0 kB
     Swap:                  0 kB
     SwapPss:               0 kB
     Locked:                0 kB
     THPeligible:            0
     VmFlags: rd wr sh mr mw me ms

There's a noticeable difference in the "Swap" reports so that the older 
kernel doesn't swap the blob, but the newer ones do.

According to ftrace, the newer kernels still call deactivate_page() in 
madvise_cold():

# trace-cmd record -p function_graph -g madvise_cold
# trace-cmd report | less
     a.out-4877  [000]  1485.266106: funcgraph_entry: 
|  madvise_cold() {
     a.out-4877  [000]  1485.266115: funcgraph_entry: 
|    walk_page_range() {
     a.out-4877  [000]  1485.266116: funcgraph_entry: 
|      __walk_page_range() {
     a.out-4877  [000]  1485.266117: funcgraph_entry: 
|        madvise_cold_or_pageout_pte_range() {
     a.out-4877  [000]  1485.266118: funcgraph_entry:        0.179 us 
|          deactivate_page();

(The irrelevant bits are removed for brevity.)

It makes me think there may be a regression in MADV_COLD. Please let me 
know what do you reckon?

Thanks,
Ivan
