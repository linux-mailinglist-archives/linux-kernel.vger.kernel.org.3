Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA275A176F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 19:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbiHYRBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 13:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240358AbiHYRA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 13:00:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D189CB14ED
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 10:00:57 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PGhkTe023815;
        Thu, 25 Aug 2022 17:00:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=KdzEOtOorwrBevS7lfbkyZdLvkxFlIjuISoHzVjiZ1Y=;
 b=VKCmX+C95N7kakofMazkFEAFlQX7UkvtN5j6VnHWOD72P4kimCX399PB9QLsY1qDW+bN
 cfQ6tSn9CVi6e1ipBmfyrbDDIT2zK67HI4OGiFdUQWwpYenN6PpOseEuj6Wjszcl9NlJ
 w9hX5z1u27B8wcj4kQhFybiUF4bFeTnClqY+0s3Sfv4JbrGYfkBzBUHma3HQfxFO5CzT
 FT9Y/z7v6YxnReR+FgjietxvKF7+WE5K23l/pWqA1DRjgAagKM4Afew5x/wsuPByl7Xx
 rvzQfORXqhP/jKFeTdEP0d4Iq++by36Xh9uaN+6qhr9hWW44jAykZfAFtriiV2WyCbO/ KA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4w25q1es-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 17:00:26 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27PFJIMo016694;
        Thu, 25 Aug 2022 17:00:25 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n57up2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 17:00:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTWxVsfx4UKUXmvhaoAqyUKo5oEYSeLI7moDtqy94/mNjjp5x0lp6JfUXPer/EMj8q4FzFvAeF8izADxYJZ4uCMx+GaNQIr9SiFwodvCb0De4mawDcfJSuvyuPVj3qKsmp1wh++ijUbnof2haHlC+fAJ++K1QG8o5BXUYlx4Kgc3sAi0hP20lUII/hs+3gDfO9vaAnHY0+k3nSBZoaaK7ktEQQvo3P7YpKLaEYjECD65fRq3/8XJMY7+7OHL0IU9Dxnio0Dt90wdN8Mgd7X8lka7YGwvhvN3V412dH17a90K726OEcV7Zec0L5OV3H963+xxBfxW6ynXBGEJeSB6Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdzEOtOorwrBevS7lfbkyZdLvkxFlIjuISoHzVjiZ1Y=;
 b=S4RRT/5fD2+ZpiWaEJ5AQqff50f/dZg4M74Yhg0ftrARNP0FaTKjDo5L6OjggN0mqCF9qjzmbFb8w58xNu1ZE2Olnxpvb5LhEZQYm97eZj+1yPUVFKiBmqKdfOjPdjszsCbKOD0s9BRlcGxSf5xfBrocSmtJbnIc0ZCo87qyiMwz+bROptHXklNPWuIeaUbhYgumoNjXyhyqoiAHoovUZtMBZeK8rPYEqkJvfCPGCsURMhdxZbrftjVKL0u8fs1I2W6+AFAgxjR1rH2H+jBdW49B/z2AP5OURDaMRAisNIkSvHC0h3lqEnRohzxP7opNOo+/4tQFLvaeT3omrNZEbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdzEOtOorwrBevS7lfbkyZdLvkxFlIjuISoHzVjiZ1Y=;
 b=yL3IcZL7jPBPGSIGv9vOscWiqNucjUF9vOm0WvEmBZCZYLhgu0T4mUTmz78lg/vgLQJyaOHx9Am0D39T4p03l2Gq4FLzK7by9CgGlcM5qoOj0IJLLDcU1pvSNKrZxWA/81FlayX8+ZHu8SnfvRF30Q/qG5BZ4o2cvjXZ+HdzTcs=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM5PR10MB1531.namprd10.prod.outlook.com (2603:10b6:3:d::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.14; Thu, 25 Aug 2022 17:00:22 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%5]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 17:00:22 +0000
Date:   Thu, 25 Aug 2022 10:00:19 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/8] hugetlb: handle truncate racing with page faults
Message-ID: <Yweqo6R7qPpmy1S6@monkey>
References: <20220824175757.20590-1-mike.kravetz@oracle.com>
 <20220824175757.20590-5-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824175757.20590-5-mike.kravetz@oracle.com>
X-ClientProxiedBy: BYAPR21CA0020.namprd21.prod.outlook.com
 (2603:10b6:a03:114::30) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 161b654d-bfe0-4416-dc1a-08da86bb4c40
X-MS-TrafficTypeDiagnostic: DM5PR10MB1531:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f72l9HG0ZQFwbpn+/AsoAhZtOoxlh03o9MCiPxw+/lK6F3XCLh/qEgVdaAOcjG3LaKUre5dLL0znZbdLV2cQ8mn9GUtSSpBxngwrbX2jemW9LS3sfH5q/GbEbRKw0htxX34CtobX3ai3lWqDQZNj6sxUWQZTEoAXbyMq78yXEGzaEWK8MJv/E2XZjk7ezkcAxHr4UXQoEaoqv0++EV2uDpEffgSL7eXvYy3yr2KouDxAz6Cjo5E2rt1036R+If97HxnaLNBsFdqQWEoEXEPMt7QHyRA1mPWjFDe3QWnpHvKPnLEXH0RmD8Jkk9gpv70ZCfpkYCKEh/V7x3///pJgDb00R5kIPG2guxJwf0hG0lbM38JI+Ya0GtxDvxdTjMuiQzX/9GoozZWv351fNBev2KlWEcOZkMXKtou0USzD/AhafqJ0yU0FRtfNWQmU7MzmzBzluQodax+vwJgpVPSN1f3r5JPu0w3gAdJTcpA6uIcbmPRYE+PsqvRNK3zsGt79yMoCe7jc5quXDT/giOb0Xn6fk1XT5ohvdljPnx2WA3DLEOXujziod64IHsuwMCHG8kbOa3wbrGYecsw5i30pdm569ddiamz2nJuwWNJK55h6v/padll2C4kgBQ+nCZS76Lr5bYeDREXf4THR5GOjBvBIMmQiHkbKRIbwHGM30mUx0xEuUuocaAZXDFGinKxprmHb7Yy4Uv/3rVpOEgdabkEg2IMtiCpt/VpG47tye0Cwu4gyIo6Fpc9smHsufYSKz2reZrtDnF8438tHlF7shajaSo3gSkNOt/YTK0UT5FA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(136003)(366004)(376002)(396003)(346002)(38100700002)(186003)(4326008)(66476007)(83380400001)(5660300002)(66946007)(66556008)(8676002)(8936002)(6666004)(7416002)(44832011)(2906002)(53546011)(33716001)(41300700001)(6506007)(9686003)(316002)(6512007)(54906003)(26005)(86362001)(966005)(6486002)(478600001)(76704002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SOss4Imty2N8o27KNlM9IU4Gnsnm9vVzEpRD979/CNjhYzX7AkMmaoyMWi1o?=
 =?us-ascii?Q?M863snNBfrsa3esS5rq2sa7oFvEEMsA8Hqz0HrpMTrWsyQ6IagoMTADy45Lx?=
 =?us-ascii?Q?hooXyBT52m2a/CkiUUi5mVmGtxIHLWW/i3R/2u9WMjQRVQC80ogFaPObVVEC?=
 =?us-ascii?Q?pQRo3fVeTKAHTs5cUjcdW2GkXBdxGKdGhOmuk+clf380euyIuzDGcf6IMx2/?=
 =?us-ascii?Q?vJPcPJIbkjjD0AGLCyELMmLGx6sA/Bnhr+7yWwS/sD4viJkYqgP8isPj0COl?=
 =?us-ascii?Q?R9a4GrsV9annny4n07Pd4vrlMtWkfvJPAoFrsgGkSF2MkaaKELmLKCx8Ik91?=
 =?us-ascii?Q?Sw7Fl3XSabec5pIrvyyqAOnVRsOJUOI064xh6FlnzxGOO8es0A1VdgLTlvlb?=
 =?us-ascii?Q?srzMdnqTC6baSXsk0iUd+bs6d8xEB5WPW0EWaT3YaU7yHry47atdzte+LcVZ?=
 =?us-ascii?Q?rveFGtCL0hNAtbyBzbAoV8VePa1VgN8ZzExBz4Bl3JHMBD5k4X49IVLLBODL?=
 =?us-ascii?Q?PWaYsiudx9C1WVXE/IyYmbV7Dw+i2pmoVX8435t/B8qi0NPznxzLT6zlKqzi?=
 =?us-ascii?Q?DHk23beOlLmQF6Jomnncr5RYv1j7ElhnMAlBBtINei+CMRDycFZN3ZpnrnLd?=
 =?us-ascii?Q?Kc38bEWe4LSm/1MvjVEIUmK9ntCn59/KDPewecaoBlKfZ7TqaCvhDIiB3piH?=
 =?us-ascii?Q?6yAffdsExzJlJhMvARWUMm/d+h3LUN0s1NQSlFeQRTn8YoValgKhVJntQ04u?=
 =?us-ascii?Q?54ZbLO0dcmMWB8+dSdTulIogQt8HGzeQE/0B38SkYrtZbvL2mXyk5FD+RuUZ?=
 =?us-ascii?Q?3IyxSOx/EWUlT5wf4XM9a99NEntfOQSHKZXA9DmwOWkc9JzIFX9sgNr+XuH2?=
 =?us-ascii?Q?Kd5VSSO98p5H7FDwcEtBfiC82g3nd3C2rVmqIncJRZELtzm7bwggaeky2Tpt?=
 =?us-ascii?Q?S09/bJ4TUDo4NsE+A0nWnFd+/w4htPsj9pEpdsfiQPC3uTM4fwYlwVr0hapD?=
 =?us-ascii?Q?DMUMEU5ygSN+0JJ+boOCGpAum4jD25sKt//3Rm5BKV0jHqV9fnSBGKwwfjBO?=
 =?us-ascii?Q?WdGpT6HEqENOfYrEvXH8eRG3Me0w+R9FQuK52sGb5iW+rSm/Usg40DDrDsgz?=
 =?us-ascii?Q?ekld5a6APTlsHrHT5vD+DXfVuZQloF45O3L2ttRBVMwEpgf9qtrnhltkxU9U?=
 =?us-ascii?Q?KxfH5JSJ5Qqc05u3kz7OJBCO2eclKyTWmQ1U0INoYrl8xEZJ856axccpUWYf?=
 =?us-ascii?Q?V606hWzfhMuPuVoMUnzZeukgffN+3YaLmnE6iw99l1HL27xWhzaX9iRWqSwD?=
 =?us-ascii?Q?qafWungL4e7IJrmeWm3IbuOu0Z2RA7r7AV5/XLO7use8pfvNDWTs8ZpIKOWZ?=
 =?us-ascii?Q?LCt1EYPokx9r9FwGuLXjZEKOSrw9RlqLWxtJVzqxzCdKrCLc2NcdOG8tdZTI?=
 =?us-ascii?Q?XjalplPBpzfSgHLp0SBgZLNFlhpjtBoJ87LyyvNuq/6FkcvDWOPKYg4q8TfI?=
 =?us-ascii?Q?g178wJKmSjiAet5u8gCzqfgHd13lQgs0wqYYlBdgbeYLlsWqJvlFBrUKWMEb?=
 =?us-ascii?Q?Ng+Dz0cazBp88R6+udjLH0hT243Z4UDU0/T1/aF6nCYiY5pcOCMikviZHYgU?=
 =?us-ascii?Q?iA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 161b654d-bfe0-4416-dc1a-08da86bb4c40
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 17:00:22.4077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: myxOYCnDbm672lpioFJ/njkhp4eE2chwmzeD81w6Iv77M9ZhQcaN45Dov6iRhhSEAreZZgPxl2e2N7hC/TVESA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1531
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_08,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208250064
X-Proofpoint-ORIG-GUID: TjaV8vVHeUInUCmd_zLoZosq7DRcBSvY
X-Proofpoint-GUID: TjaV8vVHeUInUCmd_zLoZosq7DRcBSvY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/24/22 10:57, Mike Kravetz wrote:
> When page fault code needs to allocate and instantiate a new hugetlb
> page (huegtlb_no_page), it checks early to determine if the fault is
> beyond i_size.  When discovered early, it is easy to abort the fault and
> return an error.  However, it becomes much more difficult to handle when
> discovered later after allocating the page and consuming reservations
> and adding to the page cache.  Backing out changes in such instances
> becomes difficult and error prone.
> 
> Instead of trying to catch and backout all such races, use the hugetlb
> fault mutex to handle truncate racing with page faults.  The most
> significant change is modification of the routine remove_inode_hugepages
> such that it will take the fault mutex for EVERY index in the truncated
> range (or hole in the case of hole punch).  Since remove_inode_hugepages
> is called in the truncate path after updating i_size, we can experience
> races as follows.
> - truncate code updates i_size and takes fault mutex before a racing
>   fault.  After fault code takes mutex, it will notice fault beyond
>   i_size and abort early.
> - fault code obtains mutex, and truncate updates i_size after early
>   checks in fault code.  fault code will add page beyond i_size.
>   When truncate code takes mutex for page/index, it will remove the
>   page.
> - truncate updates i_size, but fault code obtains mutex first.  If
>   fault code sees updated i_size it will abort early.  If fault code
>   does not see updated i_size, it will add page beyond i_size and
>   truncate code will remove page when it obtains fault mutex.
> 
> Note, for performance reasons remove_inode_hugepages will still use
> filemap_get_folios for bulk folio lookups.  For indicies not returned in
> the bulk lookup, it will need to lookup individual folios to check for
> races with page fault.
> 
<snip>
>  /*
>   * remove_inode_hugepages handles two distinct cases: truncation and hole
>   * punch.  There are subtle differences in operation for each case.
> @@ -418,11 +507,10 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
>   * truncation is indicated by end of range being LLONG_MAX
>   *	In this case, we first scan the range and release found pages.
>   *	After releasing pages, hugetlb_unreserve_pages cleans up region/reserve
> - *	maps and global counts.  Page faults can not race with truncation
> - *	in this routine.  hugetlb_no_page() prevents page faults in the
> - *	truncated range.  It checks i_size before allocation, and again after
> - *	with the page table lock for the page held.  The same lock must be
> - *	acquired to unmap a page.
> + *	maps and global counts.  Page faults can race with truncation.
> + *	During faults, hugetlb_no_page() checks i_size before page allocation,
> + *	and again after	obtaining page table lock.  It will 'back out'
> + *	allocations in the truncated range.
>   * hole punch is indicated if end is not LLONG_MAX
>   *	In the hole punch case we scan the range and release found pages.
>   *	Only when releasing a page is the associated region/reserve map
> @@ -431,75 +519,69 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
>   *	This is indicated if we find a mapped page.
>   * Note: If the passed end of range value is beyond the end of file, but
>   * not LLONG_MAX this routine still performs a hole punch operation.
> + *
> + * Since page faults can race with this routine, care must be taken as both
> + * modify huge page reservation data.  To somewhat synchronize these operations
> + * the hugetlb fault mutex is taken for EVERY index in the range to be hole
> + * punched or truncated.  In this way, we KNOW either:
> + * - fault code has added a page beyond i_size, and we will remove here
> + * - fault code will see updated i_size and not add a page beyond
> + * The parameter 'lm__end' indicates the offset of the end of hole or file
> + * before truncation.  For hole punch lm_end == lend.
>   */
>  static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
> -				   loff_t lend)
> +				   loff_t lend, loff_t lm_end)
>  {
>  	struct hstate *h = hstate_inode(inode);
>  	struct address_space *mapping = &inode->i_data;
>  	const pgoff_t start = lstart >> huge_page_shift(h);
>  	const pgoff_t end = lend >> huge_page_shift(h);
> +	pgoff_t m_end = lm_end >> huge_page_shift(h);
> +	pgoff_t m_start, m_index;
>  	struct folio_batch fbatch;
> +	struct folio *folio;
>  	pgoff_t next, index;
> -	int i, freed = 0;
> +	unsigned int i;
> +	long freed = 0;
> +	u32 hash;
>  	bool truncate_op = (lend == LLONG_MAX);
>  
>  	folio_batch_init(&fbatch);
> -	next = start;
> +	next = m_start = start;
>  	while (filemap_get_folios(mapping, &next, end - 1, &fbatch)) {
>  		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
> -			struct folio *folio = fbatch.folios[i];
> -			u32 hash = 0;
> +			folio = fbatch.folios[i];
>  
>  			index = folio->index;
> -			hash = hugetlb_fault_mutex_hash(mapping, index);
> -			mutex_lock(&hugetlb_fault_mutex_table[hash]);
> -
>  			/*
> -			 * If folio is mapped, it was faulted in after being
> -			 * unmapped in caller.  Unmap (again) now after taking
> -			 * the fault mutex.  The mutex will prevent faults
> -			 * until we finish removing the folio.
> -			 *
> -			 * This race can only happen in the hole punch case.
> -			 * Getting here in a truncate operation is a bug.
> +			 * Take fault mutex for missing folios before index,
> +			 * while checking folios that might have been added
> +			 * due to a race with fault code.
>  			 */
> -			if (unlikely(folio_mapped(folio))) {
> -				BUG_ON(truncate_op);
> -
> -				i_mmap_lock_write(mapping);
> -				hugetlb_vmdelete_list(&mapping->i_mmap,
> -					index * pages_per_huge_page(h),
> -					(index + 1) * pages_per_huge_page(h),
> -					ZAP_FLAG_DROP_MARKER);
> -				i_mmap_unlock_write(mapping);
> -			}
> +			freed += fault_lock_inode_indicies(h, inode, mapping,
> +						m_start, m_index, truncate_op);

This should be 'index' instead of 'm_index' as discovered here:
https://lore.kernel.org/linux-mm/CA+G9fYsHVdu0toduQqk6vsR8Z8mOVzZ9-_p3O5fjQ5mOpSxsDA@mail.gmail.com/

-- 
Mike Kravetz
