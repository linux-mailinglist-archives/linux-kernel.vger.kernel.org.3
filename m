Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E9E5092F5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 00:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382889AbiDTWlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 18:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbiDTWlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 18:41:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DF6BE35
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:38:28 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23KIvnrx013493;
        Wed, 20 Apr 2022 22:38:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=CF2qVfWOEMavrHQStKfMoXzdNlCX8t2s4lrC+s0lMlc=;
 b=P1Uq+/XLZkFvxa+0wp8vnJAwDnoGKrlmt1jNaPnvbBtuvhoCqq+6vBBcP7VU38MYsXMg
 Hucyi3oTlph8JTn1EVLKTyqxUsXlrXp4sRCcnNutBCihKGaWxy9+M82NHr9kyvZNrzSf
 Ks5C3uYMdh8itJfBxh9spyDubgovW1Fs6HvdDjhUz4jfNugR6rCwaTa1tNxBxxlkzdEW
 0nl5cC97vrua0+5wA6Hb4ODtfoyrWFkJdzFMtnkpQJP2lxGguPWBbN34f+OYc3Ba3Ofd
 +etiDOyhjjQX1v2ZI59/yr2qy9iBXQFaZuzcFtEPdU+wekWt152/uj3Toi3E5VFPcLe+ EQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffndtjh21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 22:38:11 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23KMQMIF010589;
        Wed, 20 Apr 2022 22:38:10 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2046.outbound.protection.outlook.com [104.47.73.46])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm883je9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 22:38:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwk6W1f4bMnVHq2jjJynYBWhinm7R5Tspw6JhOpMmsrzuAm/mn5aqU2iF5aZk3pQGQiJMdyWhzeKEv6S+vYfEdWWZSX0psEJhDHgjE1prFu4CLNqXHPGkL2R+S4gSIGR19dy2C64nlH8/bw0AGTpmcruEjvtedcxq5c9aJaiGK2ChpAIxR/NzBPjTXS2AlLLARFAvkwqovOEpTHBncEtP14OZxS/9RYbNPAANL8VaDNSR65hNqLGBd2mD9xNT/hbzrFMCeJXJfi5S86fa20/mkwSXwbqe9yI1yzMrc/Hi7jYh653/Fvfv680ilYh2SYdL3pPDXzPk7j/n+vcfpDjEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CF2qVfWOEMavrHQStKfMoXzdNlCX8t2s4lrC+s0lMlc=;
 b=dsTw2pAFnHMiVV+bMIYKwVmeKkucKNBi2VScHLcTo5fvqNwhJaf10vErhI3JQyFyYPsC7UbW15MQm7xbSRIou2X7qeDQr13VABBKdBda7MaX7dZjjBG6wlDxDyDapa/nyJoiCv+QSJoY2OsqetWiKmyUie1dNUTXZF/tlq0ZYt9F7GfSBL1RS+0UgrYSjCwuS6RxAZv707TtOTIfI1hUcwucZqDzLdWTGYj/+vMPjRExNOlALAM5rTFdCSFXmFBHp5XRj6R5+HmYCSEOtRlQPKO3KpMPBZCILmBK5xJ8SSbI2NCcYIJ8Phh3DgCDbgO3bGoS0R0dQC5QRewlsyk3vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CF2qVfWOEMavrHQStKfMoXzdNlCX8t2s4lrC+s0lMlc=;
 b=V6yPoZ0bNsnT2WijZWy2mBNBkceRxqPcb2grCtDj/7j2Qd90fpE1bbqVb4mdGoxkGXLC73myFnlpFaL11yS6GPlqZ4WtpJLSA1jsXTHrBsc48g9D6ir43Zm3jjmSonqtM8tsJ3jexo4JekUPp8N8CfMiIy+GTx/7tuyuuIEYkew=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH0PR10MB5035.namprd10.prod.outlook.com (2603:10b6:610:c2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 20 Apr
 2022 22:38:08 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bd4a:8d2e:a938:56af]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bd4a:8d2e:a938:56af%9]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 22:38:07 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC PATCH v2 0/6] hugetlb: Change huge pmd sharing synchronization again
Date:   Wed, 20 Apr 2022 15:37:47 -0700
Message-Id: <20220420223753.386645-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46648468-c870-4a18-4778-08da231e70a1
X-MS-TrafficTypeDiagnostic: CH0PR10MB5035:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB5035B09567B82FC512A7FFF4E2F59@CH0PR10MB5035.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HnXQl1xIoM9OHEFz/c3ARou06wmkrSi2ZIVBuwNv9kPx63ym79w12dnvVB9Cvo4aQwO/DX8SxZGsPlF1ck272ZidjM0XM+BgFFJ3Qv1v+SltMOi+cnlmdJTyTt1FoZHYds4lGfzi6XL4pursuzDKDoOGQb7AMAio9wCvF4kowtWfZiwv+GM+XPSQvL1qUDwiSx1D82Nqi0phioKt30iWbsH1mVlwwzX7/bgV2XbpVN9GE1E+5myf4euUZNYXGM4DlY6uMTIGNgaSRJqy2r6qJSgABXdU390D6C3ushj1Jl09MAGyQTSHM1/Y8//wwTl4acGasfw3QD7Rqi6QmSHm37G194aVOQsjfa/1o7qtZLzEdvGLCQ1vlATl1X9RoEmwI5jNpF77yCcmqdVauoCOavdc4cDkPQZO5cDXL16wGIiuUkGUtn+OF1ffUHTTIzP1DHFr8M/kMZ3h67BRR5uCDSjRpQFMrkufBoA9Y3Vqt1xfu0VXjLLDbMibjGJ79BrfpJkvva3Yq+z9MvhDPhY8iohc6Dr7MqahM2cZRcHCEQgfiv/dQK5C+wBnmUdccmDQDQ461nsZKDoelU+ezdyCGk1YtDuBmdIvLrVoCE3Jp3WKK+vE2so+m96tJ1Fy4taw6niA34LagYKm+p1Nvoxk0JfxxrCkIwjiYmJIHxPcthevE8KovSlB3/BH302fb3CKci+ibzLQYAcUQCNP2YQ7OiaKBpiB/NJ+BtQ3Y1opruU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(8936002)(107886003)(26005)(2616005)(508600001)(6512007)(86362001)(186003)(5660300002)(1076003)(44832011)(2906002)(6506007)(52116002)(7416002)(6666004)(83380400001)(66556008)(66476007)(66946007)(8676002)(4326008)(54906003)(316002)(38100700002)(38350700002)(36756003)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MVtEJNoqa915HsjuaVYCqJ/x3NGcJSiVysFnBMVKHFmzoNn59Pu4G8yg0KVB?=
 =?us-ascii?Q?Y2D6sGu/S0l2Pw9sdqJ7wGQ2l5u4VkQctoALfij4eB58gPR5/Jn7lgs8RJm3?=
 =?us-ascii?Q?ofAXCi+BErgkHX6Wb8SGncxIpoE202hfQl7JQIWzHb2TtG/2u06bolp6rSZl?=
 =?us-ascii?Q?2+hMYzLg14u91aLF8QrehqLj8kQn8MU5lhmbzeNrM4ms7htPS+EzvZabd3Xe?=
 =?us-ascii?Q?nSvKWrfIHxtuPd4ce0OYcb66ipQeESFOT0es5gaC6+NRBcCKsODoVK+9kZSh?=
 =?us-ascii?Q?aVCTmTwOugx8gQsJpX1HUv/R5Y3d6++eTQ4pK3dBUOZcLlWmeKfU6kWDD28h?=
 =?us-ascii?Q?Lma0btPgXJcBlmZip0PYGisyTkbtILUeldSUKAjdeyyfUit6YbE9cQ1pRJSB?=
 =?us-ascii?Q?1ketQfF8dVpptA/ly1zWoihvIn1gHHAT/qaZFUG8kUH7pzkZQ4yfLrzgEGQD?=
 =?us-ascii?Q?NExd4Lf85o7mCZauV/Kd6qs474BhaES5IznyvVyBlVClXIxvv1g5KNyQX0K9?=
 =?us-ascii?Q?eIKaDxCWx0Al/HrtYe3cU8LN2cEwhWsXLMzndIDj8Ga2/Bm8sumMC5YHx4G0?=
 =?us-ascii?Q?ElbarYzPYEFyN8cPgLjlXdwY5VEKO3rQAurM8dnVXKzPxhSUugGueWznzCS1?=
 =?us-ascii?Q?7mXztroRT2IGuMsuuXzVMPRhwyTVYtSftKkJdJ0eVUtfaq0Bo9uKfowkVqSm?=
 =?us-ascii?Q?pykL742X5rfDYUgaKsKSfWT5ye3VuSVbyLTP/C/h2H10ioqvMzZTbETGkEf8?=
 =?us-ascii?Q?0D7P56WjTXAfzOgDMk3Q3baiXq+A3GmGhJY28AZ6eep01M7jEyE0mjXDxoxU?=
 =?us-ascii?Q?z+TDcGXKaulumkigS6rUtrGIiSStZQHT4v0Tob7I1vgEPOw/kBJ9MxS76VDU?=
 =?us-ascii?Q?VsLxzP6R8dQA3K+siKCQ4R8kfMWq/13BHlTN1hfN1+qvN/GuCrDyyqikJxw1?=
 =?us-ascii?Q?4cj8EVxxA7dtSu7yd8m9gOeLqUPFCcv6/Wppu/40Ei2GA1s+uoNdMUpOyTBh?=
 =?us-ascii?Q?pTFOOul5TGxNfvyU/+CXApNOIVgJbzZgjATSduPioVnoDHZOQkT8Z9Z7UbyB?=
 =?us-ascii?Q?8ivCRMLdsjrh7GtpgCRKhB+HH+zeLqwzmihwR5vfSwdRQ8as23fzySa2gaLS?=
 =?us-ascii?Q?R3M7UXvfmkXeA6YYriPiiitMZohFr2BqPlBqgFUvkQo9hltEDsJawlGj6j15?=
 =?us-ascii?Q?n/HbhzOnP+6+dVtP6yDA92r02UuSk5tQX3RA6NXeKPrwf1yBY8fN5b4nx+KB?=
 =?us-ascii?Q?RZDsdrLzGb2PpONMefYLVeAPnlPggx9L8TG1KQf61KBjBYSGjl98FTRzoXdu?=
 =?us-ascii?Q?MTgsnezCehx0t0G1jtFahZDvoqMCR3Qlku64ptxqO5aFS0qQDfjdsgXThUGN?=
 =?us-ascii?Q?QYhrv4B/PuIEfK8m4i331Y+H1vrgUbU7n0Anl3UGmo0xbZDzYQxtMvLDC4C0?=
 =?us-ascii?Q?cbxi90jMj81Y3C2/HSR06n4R4jSjzQcwSM+vqmjC1BaiENFBrvJI9tSjf7NE?=
 =?us-ascii?Q?/5a+6CWeasOCKMc6SdpupUhIsDpVa2W/0Xfh+abEuodvtyy5DRxj/x9Tdinn?=
 =?us-ascii?Q?ClN7ud4Ci/TO4ygbw46fOrRz2mlXJtrPf9tcXYV/vYQwfySkTC1R4H8ERf0o?=
 =?us-ascii?Q?tO8j8GZjx5O/vJZiSWAvTCl+CKRPAw3Eq0gjcB/RRbkkw0+ran/2lLoHdPif?=
 =?us-ascii?Q?buwOPzzdUM0SvgA4YCp1KeIXpBPwV2rXCjq+cvsvv8WJwBjg2kB77VmrXYEL?=
 =?us-ascii?Q?7x+M572EcAEW9hM74bREtPaXW9OyxpI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46648468-c870-4a18-4778-08da231e70a1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 22:38:07.5561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3yHUJkKyZwnJWQRk0PZg6/6QrXMZCB0vk5ag+8UY9Z12dPHnTuibtlEsB+Jo3qFY5kclD89Vm37xwgoCIJkvdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5035
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-20_06:2022-04-20,2022-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxlogscore=409 suspectscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204200130
X-Proofpoint-ORIG-GUID: 7clf-3V6R433uxdUBnQr-lFH5oDfgD5y
X-Proofpoint-GUID: 7clf-3V6R433uxdUBnQr-lFH5oDfgD5y
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am sending this as a v2 RFC for the following reasons:
- The original RFC was incomplete and had a few issues.
- The only comments from the original RFC suggested eliminating huge pmd
  sharing to eliminate the associated complexity.  I do not believe this
  is possible as user space code will notice it's absence.  In any case,
  if we want to remove i_mmap_rwsem from the fault path to address fault
  scalability, we will need to address fault/truncate races.  Patches 3
  and 4 of this series do that.

hugetlb fault scalability regressions have recently been reported [1].
This is not the first such report, as regressions were also noted when
commit c0d0381ade79 ("hugetlbfs: use i_mmap_rwsem for more pmd sharing
synchronization") was added [2] in v5.7.  At that time, a proposal to
address the regression was suggested [3] but went nowhere.

To illustrate the regression, I created a simple program that does the
following in an infinite loop:
- mmap a 4GB hugetlb file (size insures pmd sharing)
- fault in all pages
- unmap the hugetlb file

The hugetlb fault code was then instrumented to collect number of times
the mutex was locked and wait time.  Samples are from 10 second
intervals on a 4 CPU VM with 8GB memory.  Eight instances of the
map/fault/unmap program are running.

next-20220420
-------------
[  690.117843] Wait_debug: faults sec  3506
[  690.118788]             num faults  35062
[  690.119825]             num locks   35062
[  690.120956]             intvl wait time 54688 msecs
[  690.122330]             max_wait_time   24000 usecs


next-20220420 + this series
---------------------------
[  484.965960] Wait_debug: faults sec  1419429
[  484.967294]             num faults  14194293
[  484.968656]             num locks   5611
[  484.969893]             intvl wait time 21087 msecs
[  484.971388]             max_wait_time   34000 usecs

As can be seen, fault time suffers when there are other operations
taking i_mmap_rwsem in write mode such as unmap.

This series proposes reverting c0d0381ade79 and 87bf91d39bb5 which
depends on c0d0381ade79.  This moves acquisition of i_mmap_rwsem in the
fault path back to huge_pmd_share where it is only taken when necessary.
After, reverting these patches we still need to handle:
- fault and truncate races
  Catch and properly backout faults beyond i_size
  Backing out reservations is much easier after 846be08578ed to expand
  restore_reserve_on_error functionality.
- unshare and fault/lookup races
  Since the pointer returned from huge_pte_offset or huge_pte_alloc may
  become invalid until we lock the page table, we must revalidate after
  taking the lock.  Code paths must backout and possibly retry if
  page table pointer changes.

Patch 5 in this series makes basic changes to page table locking for
hugetlb mappings.  Currently code uses (split) pmd locks for hugetlb
mappings if page size is PMD_SIZE.  A pointer to the pmd is required
to find the page struct containing the lock.  However, with pmd sharing
the pmd pointer is not stable until we hold the pmd lock.  To solve
this chicken/egg problem, we use the page_table_lock in mm_struct if
the pmd pointer is associated with a mapping where pmd sharing is
possible.  A study of the performance implications of this change still
needs to be performed.

Please help with comments or suggestions.  I would like to come up with
something that is performant AND safe.

Mike Kravetz (6):
  hugetlbfs: revert use i_mmap_rwsem to address page fault/truncate race
  hugetlbfs: revert use i_mmap_rwsem for more pmd sharing
    synchronization
  hugetlbfs: move routine remove_huge_page to hugetlb.c
  hugetlbfs: catch and handle truncate racing with page faults
  hugetlbfs: Do not use pmd locks if hugetlb sharing possible
  hugetlb: Check for pmd unshare and fault/lookup races

 arch/powerpc/mm/pgtable.c |   2 +-
 fs/hugetlbfs/inode.c      | 136 +++++++++++--------
 include/linux/hugetlb.h   |  30 ++---
 mm/damon/vaddr.c          |   4 +-
 mm/hmm.c                  |   2 +-
 mm/hugetlb.c              | 273 ++++++++++++++++++++++----------------
 mm/mempolicy.c            |   2 +-
 mm/migrate.c              |   2 +-
 mm/page_vma_mapped.c      |   2 +-
 mm/rmap.c                 |   8 +-
 mm/userfaultfd.c          |  11 +-
 11 files changed, 261 insertions(+), 211 deletions(-)

-- 
2.35.1

