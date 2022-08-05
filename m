Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0746A58B27C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 00:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241340AbiHEWmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 18:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238057AbiHEWmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 18:42:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BA21DA75
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 15:42:18 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 275MSk6d018534;
        Fri, 5 Aug 2022 22:41:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=HXrKptEeIZ3Ddei+aJSNZMW98NacYD1bCbCOMhWPrno=;
 b=KapuPc2fS2TQhO92MVJGyTSfBl3QianYMHZ8xQS7CsyCx7o/2Dgfrvl1CnwQVA53u4r8
 DIN1OVQHTGfFL1QN/4h+nUhgY5SJ1GN2qpC9tipe6En3sVWXXgYxNBUcCVwOFKOIEOyZ
 M4GDdXnNUH/ZQfbSY4NcqkswmsbxrE4ztEa2ec+lFuxOfVbo/txhkEmhijN4122lAt6t
 Qw4yCIRPlwXP7ss7sRKHjDBwIadPPbGBkTN0+0MJN+KiQFDsjuGuGzNJFI4CLS/POJm4
 eikWPHosqn2a3lul0RK51RnWgHj5d5+2pMPWjKpvoIvwRv8T8stY1rtEa8LMBXJ4Krwe 2Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmvha0jg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Aug 2022 22:41:38 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 275LKgnh010951;
        Fri, 5 Aug 2022 22:41:38 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu35sf9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Aug 2022 22:41:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBFCoRyp2s2qy/mRgPIbzQ6kChiurcQOSKTjfF4FDIVIm1vqv81ovpHXX5ezxFeQtvAuAcCRuLX5C813TbG03m+nOs5phuYloemHnyuL4D0Fb4xVVqnIQHiDken1RK26uxOLKCLwOR6Y68L9ZENDMITSv2JiPicAIYCRIApzjlFDq8hlssbYgjYQi82P4XHKjOiBSPKUAQ2JLZfJSCcFBaTZo/AX7DyD24JE9EKtaabetCoji3LRM4o2J1s88FzeSf/yLxXpRfTMbn2dNzhBCy2ftCWCYXhy2KIPN2gKyRboc1TZ7tktiAp/lslNy8yM65q6scJxnjmBu8ZilfTgKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXrKptEeIZ3Ddei+aJSNZMW98NacYD1bCbCOMhWPrno=;
 b=NUvlSaaH3+l+9Wzx+5IW4AxF9Re58bp2w9vuhlhdJ3+/H8yx2zo8QuL4FHyJ+YKZOECezbKt1I6m2xHKcvJgzZgUSK8p/aCfiAu1ndQIDFy4gQgxOp0t1bGaeieEP/7I7YqzJaqjeJ9LA8Jb1fkfos/3evvTWNhD6eGAtu9dpyKQJrOaFk62fZFTu/xppv5hSSnagcf91bYNocMD4MS9IGhMxygFC1gkwHY7znYNcjU/KrPCM98GM2nmWoGSL+FDsOlfteP5zNekLxkl7goAEP7EvXLIcLy/23j5a62r3eJf7cqkWzUWZAGDvfgmztBQ3/dns5JnzbxhCWzIDbdCbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXrKptEeIZ3Ddei+aJSNZMW98NacYD1bCbCOMhWPrno=;
 b=FUkBMGWSpU2Dqk4LYhhPq33YaII9LdgJreJ2CJhoAD7goUXefMm/sBhAz8NRDOLs9mt4KTERcjGBJ87bhT3TGNSHI9jabVClBEWT8DVq7qQ2g3xYzsZycF+YR7bWxHqqDpnY/U9WO8GjOI3f+isbxW7Ij4jbZOakEYpDPOFol1c=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH2PR10MB4071.namprd10.prod.outlook.com (2603:10b6:610:e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 22:41:35 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%5]) with mapi id 15.20.5504.016; Fri, 5 Aug 2022
 22:41:35 +0000
Date:   Fri, 5 Aug 2022 15:41:32 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
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
Subject: Re: [RFC PATCH v4 4/8] hugetlbfs: catch and handle truncate racing
 with page faults
Message-ID: <Yu2cnC+A+zPvlA1G@monkey>
References: <20220706202347.95150-1-mike.kravetz@oracle.com>
 <20220706202347.95150-5-mike.kravetz@oracle.com>
 <ee6af38d-f797-a64f-e5c4-78bad3753aca@huawei.com>
 <YuGLT+RlCynFM9Z4@monkey>
 <ae24c722-0b4a-def4-8cfe-e8b3b48a22c6@huawei.com>
 <YuK9KqTLqEGavv7N@monkey>
 <e0d9b4c4-1195-730a-5838-08c10905adaf@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0d9b4c4-1195-730a-5838-08c10905adaf@redhat.com>
X-ClientProxiedBy: MW4PR03CA0235.namprd03.prod.outlook.com
 (2603:10b6:303:b9::30) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9afc7bdb-e1ab-4ee6-5d59-08da7733a692
X-MS-TrafficTypeDiagnostic: CH2PR10MB4071:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XR5uOOVqiW3Lo+4jZEqfEH8O32cP7H40ajb2AQ14tutyu8a08eHXrPOB5sbGdfSMUIy+IcyhwcD4X9+xgKur5TVrIjzZknvN6pPlk0JEFM/wxwKVvR+4dcZ8AK6WufL5NYhnBJpba0TacYOJ6tdxfBV2srky05w3rN3kfqzoCQv3WaWBzDIygHFnJ/NzeSSswrVBnsg2WPyFKPDq1xiFXrt283A/9b2tAuurQdu79ZJqtKLJ7Q3wv05SlgWhw+mvB1CuLpcZjOiFaDJ7iA2lwmpZvWtkH0PD0HgDq3xLH0ltA1ZBYFVgsD9Brtp41c3lU1K+bxOOWVPtmNq0WnvW9uZtYs/um6vaIrxfARz82dQ2DW+EOE51w0lpqGB0r/iHInPxGKjgZkk2Sh+kIad1urW96w6aJ/NqvXCqEq6b4xp0he8w9rHZ2atsDPGPTyIitAEr4JXt2lXnapd/g6WiUjvpVmNO/6rRGsWsq+72TrO3wqUQ48Q4miYz7tUJ2IL2dpUSNt5Vd4faWKT9qVrymoyTMDs0J2g+L9Zd0w9I85zKgX7FmzcQ9MNl3ds/P4PE6RiZDcBQ1teDBGvIWjaUR/p2SkTiU+OCO7WG+1cY4VjwpGk61nhiAPLLA6m/qPcbXrSBiYiCJkhelC3+qqDwFN2nHiglyrpYf/3Kru+jGnjifLsrd+CSoLSEkQi3HpyN6Hb7LAupN15n5WLrxFEvYH08HpqBIrDaPtSDR9RTGca85PpmiohXp8D8yymIqlBj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(346002)(366004)(39860400002)(376002)(396003)(6486002)(478600001)(41300700001)(86362001)(26005)(6666004)(53546011)(6512007)(9686003)(6506007)(83380400001)(316002)(6916009)(54906003)(186003)(4326008)(33716001)(44832011)(8936002)(8676002)(66556008)(66946007)(66476007)(38100700002)(5660300002)(2906002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZLyMq/ItEMpUwSpob4rjfuznfVbbGK8LyFmyi5TW+A0yD89rw/4FfSAreNea?=
 =?us-ascii?Q?fY46MxAK5BjsWKo6rbSuvix1HGKZ75tUTV7nyNz8ufHAWj1VpJJqFkuObxxT?=
 =?us-ascii?Q?48gKuh+/BTvMeyNXAUddgg82wJbm3OVCEXDQeW6H/Q2Tw1D4FyqCztW/wf0n?=
 =?us-ascii?Q?GMwTK0vU+bZxRcx6P43gmKHFRVbHaqB0jTbACFWqF0S0X9SEWe1Ah8NOTUHA?=
 =?us-ascii?Q?DnR6OLXx4Uw01V3MDHqG2unt9AsuatsEnqKvpXorf4rM8oSPLqk7ruFShZ2t?=
 =?us-ascii?Q?T77UwD+fOQkZ/TJZOK+r7vPrNHCYWxELDS+qhskQcPYC7SuqY47e3qZi7TEm?=
 =?us-ascii?Q?xxos3lEliBz65bmFAwWFKMyBiZjmo0RwR15JPW6p/MxQOryiot9TT2ixNWbP?=
 =?us-ascii?Q?st26Rd2nmdNDY8rykSJn0npK86QyRC7eOIZAQTjhIJiLtTW3BKEsk6jrDVRp?=
 =?us-ascii?Q?G/CsWPUMuY1JNqalrVwbx8dwGb2g+/FqXUGf3n861lULqvguuPFXBk3CygWK?=
 =?us-ascii?Q?/JpgdC7rh2fdheR/lYPLoZP1RGwIjoJlfLE9TWVWZfNl+3VBdoqbv03bwMHD?=
 =?us-ascii?Q?v1hsVjkUvVLFvC8xiCQjzMioKi0XyvRH/iGUQAwmcGkom6XrtpTY0RVa5ZzS?=
 =?us-ascii?Q?2K1nQHN/0hD8JYiV4zb3/Mkwyya32Rl5TVfqJTmJ2mIjNc58ZQd+sqgqBCwE?=
 =?us-ascii?Q?WtAHG+ZSfYioQVnt8LuV2hJqWVRwvQRR9DdmAOmvGocrYyGOh2o6vVu1corw?=
 =?us-ascii?Q?vRg8Lqyo5QVzlT0l+/ymg5jucLv8XB8IdwZdvBpUOMEjDP2AqSOoPJH6Hs6C?=
 =?us-ascii?Q?/wRPET1UUcXJ/AahoMyM8zkWN/vWe1xXViRuHhI2/y4dQDjp4lYD5LrZ0pvJ?=
 =?us-ascii?Q?k0aSqt4ny0gk13jK9vnJFGttBZaSIJ1AuI800gL7iqyCSQJOk12CDn0aOOPv?=
 =?us-ascii?Q?Q4Eg5sHF6k6h+x90fjLn9g5S8CMlyaBdaIJztwpjIXGH2/kkaoM2HqUqQrmS?=
 =?us-ascii?Q?DmjemPkizX+rE57qN/UlnhsBWzbT6GIuAilgmpl5XZU2LIWQNj0hD4z0KdHi?=
 =?us-ascii?Q?hUfnm7xHPVWqjOMwc/BdQ2W/H5cy1xHup/ciUs9LQ1Ew440z2r5YQXgOxmx3?=
 =?us-ascii?Q?8k86eOBtaHPuDBD0+HYT2Mw6sVMLaX1H1Dpg7GOCMltRmOFzhEy5KqebDpEb?=
 =?us-ascii?Q?kgHR9kdWSoCuI12gGAb4jxA07zrdTTIIezCD36DJneYKRi704fC0JS+e94nZ?=
 =?us-ascii?Q?XWCdmXDPPvPN2sok5lh5AIUUMPcl47jWscSKRbQkdmP/oy7Q19VSvEiUpIeD?=
 =?us-ascii?Q?9IPWtgLv+sWGEFjN3IlrYIe293uamcqLhvcv73r24k1CBTcmd4bcDERO0dLu?=
 =?us-ascii?Q?kET3saxR9bHlSAyw/dJVlCR//w2g//m88QHvUqpUXPHu8jLx19WNlTsy4f3z?=
 =?us-ascii?Q?W7sKB9Kzp0f58nqqqA/ZcSuW632OKayXlCxSntBris8RwvhamKF77nKNRrtT?=
 =?us-ascii?Q?Bgmy2WJDMfcZ+JEmT9WlV8soKZMXbry/fp1alnhD2ZgJekijpacy22dW8g85?=
 =?us-ascii?Q?OBr7UEAYPJHScx6fcDANBmbUIzDgyEQvvsJgXFNgl+bSjeMz+l6DT9YZNc2N?=
 =?us-ascii?Q?IQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9afc7bdb-e1ab-4ee6-5d59-08da7733a692
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 22:41:35.0172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uhXxeOFWpcIgd5VkQJH2LhQlqeq1ckD2pV+DN5Qp1YXcRZdqzIxSzEsewveLilRhUrh8v68WC61/qNf8ZcgZYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4071
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-05_12,2022-08-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208050099
X-Proofpoint-ORIG-GUID: ns1GWkV0hFcVzgSuyE5c4aQ7iJHwCM_G
X-Proofpoint-GUID: ns1GWkV0hFcVzgSuyE5c4aQ7iJHwCM_G
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/22 18:28, David Hildenbrand wrote:
> On 28.07.22 18:45, Mike Kravetz wrote:
> > On 07/28/22 10:02, Miaohe Lin wrote:
> >> On 2022/7/28 3:00, Mike Kravetz wrote:
> >>> On 07/27/22 17:20, Miaohe Lin wrote:
> >>>> On 2022/7/7 4:23, Mike Kravetz wrote:
> >>>>> Most hugetlb fault handling code checks for faults beyond i_size.
> >>>>> While there are early checks in the code paths, the most difficult
> >>>>> to handle are those discovered after taking the page table lock.
> >>>>> At this point, we have possibly allocated a page and consumed
> >>>>> associated reservations and possibly added the page to the page cache.
> >>>>>
> >>>>> When discovering a fault beyond i_size, be sure to:
> >>>>> - Remove the page from page cache, else it will sit there until the
> >>>>>   file is removed.
> >>>>> - Do not restore any reservation for the page consumed.  Otherwise
> >>>>>   there will be an outstanding reservation for an offset beyond the
> >>>>>   end of file.
> >>>>>
> >>>>> The 'truncation' code in remove_inode_hugepages must deal with fault
> >>>>> code potentially removing a page/folio from the cache after the page was
> >>>>> returned by filemap_get_folios and before locking the page.  This can be
> >>>>> discovered by a change in folio_mapping() after taking folio lock.  In
> >>>>> addition, this code must deal with fault code potentially consuming
> >>>>> and returning reservations.  To synchronize this, remove_inode_hugepages
> >>>>> will now take the fault mutex for ALL indices in the hole or truncated
> >>>>> range.  In this way, it KNOWS fault code has finished with the page/index
> >>>>> OR fault code will see the updated file size.
> >>>>>
> >>>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> >>>>> ---
> >>>>
> >>>> <snip>
> >>>>
> >>>>> @@ -5606,8 +5610,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
> >>>>>  
> >>>>>  	ptl = huge_pte_lock(h, mm, ptep);
> >>>>>  	size = i_size_read(mapping->host) >> huge_page_shift(h);
> >>>>> -	if (idx >= size)
> >>>>> +	if (idx >= size) {
> >>>>> +		beyond_i_size = true;
> >>>>
> >>>> Thanks for your patch. There is one question:
> >>>>
> >>>> Since races between hugetlb pagefault and truncate is guarded by hugetlb_fault_mutex,
> >>>> do we really need to check it again after taking the page table lock?
> >>>>
> >>>
> >>> Well, the fault mutex can only guard a single hugetlb page.  The fault mutex
> >>> is actually an array/table of mutexes hashed by mapping address and file index.
> >>> So, during truncation we take take the mutex for each page as they are
> >>> unmapped and removed.  So, the fault mutex only synchronizes operations
> >>> on one specific page.  The idea with this patch is to coordinate the fault
> >>> code and truncate code when operating on the same page.
> >>>
> >>> In addition, changing the file size happens early in the truncate process
> >>> before taking any locks/mutexes.
> >>
> >> I wonder whether we can somewhat live with it to make code simpler. When changing the file size happens
> >> after checking i_size but before taking the page table lock in hugetlb_fault, the truncate code would
> >> remove the hugetlb page from the page cache for us after hugetlb_fault finishes if we don't roll back
> >> when checking i_size again under the page table lock?
> >>
> >> In a word, if hugetlb_fault see a truncated inode, back out early. If not, let truncate code does its
> >> work. So we don't need to complicate the already complicated error path. Or am I miss something?
> >>
> > 
> > Thank you! I believe your observations and suggestions are correct.
> > 
> > We can just let the fault code proceed after the early "idx >= size",
> > and let the truncation code remove the page.  This also eliminates the
> > need for patch 3 (hugetlbfs: move routine remove_huge_page to hugetlb.c).
> 
> At least remaining the functions would be very welcome nonetheless :)

Agree.

> 
> > 
> > I will make these changes in the next version.
> 
> Just so I understand correctly, we want to let fault handling code back
> out early if we find any incompatible change, and simply retry the
> fault? I'm thinking about some kind of a high-level seqcount.
> 

Not exactly.

In the routine hugetlb_no_page, there are two (no three) places where we
check for races with truncation to see if the fault is beyond the end of
the file.  The first two are before adding a newly allocated page to the
page cache.  The third check is after taking the page table lock to
update the pte.

The idea is to eliminate this third check that requires backing out the
page from the cache.  So, it is 'possible' that the fault code could add
a page beyond i_size.  With the updates to the truncation code (actually
remove_inode_hugepages), we know that this page beyond i_size will be
removed by the racing truncation code.

Hope that makes sense.
-- 
Mike Kravetz
