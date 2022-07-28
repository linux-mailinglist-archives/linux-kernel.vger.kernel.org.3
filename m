Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5A8584456
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 18:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiG1QqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 12:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiG1QqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 12:46:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D1142AE5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 09:46:04 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SGd3bm017395;
        Thu, 28 Jul 2022 16:45:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=ePuKe/hgk8iLHJRO6W5MXxK2h0hIYSey+t4n85R1mQQ=;
 b=Migd2E12K2ATWAhdUEBEVn+G73WVD984kB0GJmsoISr8/Oo/aADyEJJhhEoVADEtY1U/
 TrV9d0po9VkE1fiWI2XiNAtNQEaac63FlaX6wMLI1xsFB80eRNYFcQA532Hp0wolU61s
 +kpU32mcwu3lielGG+M3zKV+52CH+lcHG1Nqc8w55vdLt9ePYQZbWE/X32/eCT89AVjh
 91Yw2k+02ceaIVgXiMTeB2eu90rJwPTKAD3jPiaeLt2TxPCy7DrF7Ys3dcV6SRiog7LL
 Zbp+18AsQdDLeGC2YeJO75iJCrrdwD/lqw3Af5VPWaHanXoqueznsfc9FKA+wjvyErVb 5A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9hswncq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 16:45:37 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26SFum0e020567;
        Thu, 28 Jul 2022 16:45:36 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hh63atbqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 16:45:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Syt+xquPjjb/GU9mmP2x3+ITiXBejpbAZiTKGA4rmnGYghItjn7Dynj8lZ/l9YYzBDL8U23uASdAbgeFyLI4Hdg60U87eSlzTgVAQKU+JxO/Iqkgt9dObAdx2CYY3ahoVa+y/ecwZtU+qms0/qeV0RwqB6VV1uIqQGTPLiyFiufoNv/Zgg6zRgDR1IU8T2a0/xvTyGVrckakiHmqk/4v2ZP7a7i/9A7UsaJrctmnS4/5aaUtJt+iUbwGARzwAUwPpMdp+O9CpoWXihgci66cp7MdQkcjrB1wj6ZXxEIefRMQFJ/TNvPp82/Su8+E+qbP1TSpEhOwYI/EbKZMr8QFLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePuKe/hgk8iLHJRO6W5MXxK2h0hIYSey+t4n85R1mQQ=;
 b=TlcDI8nggp+0p5Z3YjnTylqTh2fIT97rXo/mFNYyMECY+mwvtu/dV3TaLU1WmCXqWrxz98Zwfp7zuIkGZ8jtkv4HafhnbNkYnkDJDDtk9dP8RTX6aqn2aPNa2cLm3yIw2XrTh9mtEbyFrWnUzXg1HyarL6aiZ2nlvjyaOoTVMnb6AUj8+GmOvquur2oB0WJuEFJ+wLYdtDGRhgGZYp2th+ab8zLiBIUbsz90IlRvcyfIZfoeONcu/vT63EwndAaQpAPU86QYKgHfEeD59dTMUaDt++9n4sXTl9gvbjdBp6LtQKrxfZU6iV4NA4u4a+FYOjBuj+NsQK9LMAGBeKUHTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePuKe/hgk8iLHJRO6W5MXxK2h0hIYSey+t4n85R1mQQ=;
 b=nSFlSWtlyj60TS9XxYPcZVEHe220I8RQXmNYMGzbHvIBVNqkSXPzrD1EdFFSiqM+yWC3xDCvJpcgKT8SKFdPy5DvFnILzGBS+u54ebFLh1kcrlpm6NSUcXmocjBs5Qx/ZExKtu5RLUHnMoPvQc1UOEwmw1gVtBUd8WvLpRYDIjE=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Thu, 28 Jul
 2022 16:45:33 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%6]) with mapi id 15.20.5482.006; Thu, 28 Jul 2022
 16:45:33 +0000
Date:   Thu, 28 Jul 2022 09:45:30 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
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
Message-ID: <YuK9KqTLqEGavv7N@monkey>
References: <20220706202347.95150-1-mike.kravetz@oracle.com>
 <20220706202347.95150-5-mike.kravetz@oracle.com>
 <ee6af38d-f797-a64f-e5c4-78bad3753aca@huawei.com>
 <YuGLT+RlCynFM9Z4@monkey>
 <ae24c722-0b4a-def4-8cfe-e8b3b48a22c6@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae24c722-0b4a-def4-8cfe-e8b3b48a22c6@huawei.com>
X-ClientProxiedBy: MW4PR03CA0205.namprd03.prod.outlook.com
 (2603:10b6:303:b8::30) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6de007c0-9f71-4862-9a96-08da70b896de
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7GxbAPveOEakxgLEFhQbGgruyp+mqGbxpSGJZcwwNOyFcRKnt86ltx9cf91+0biV1cNXGDyIT3xQTD+U490szrC5BAjuXQgrcU2lIWxYwLWx1E386Q7wcRHliT/uX4sOqKpVNlazhiky2kzu/ML5ivvfdf8u71X2OSRYzk04cV+KA+pDlkRWkIBSDvpmQJJybgkuEMvQpYzBITBgEzkiexQLY+mMpPNWeFkVoIP1rWn4hx1BIQ3pYrtFw/pU737e/rCmJmsNhSzIU8LeTZY7gnHo/0K3iwZoYippXR1fEmfPhp6jPyot+fvocgVx3/Su/3sxzEh1bEfIJc7Y0/AKiyGc2UKsRbq7EH5qESxktR6e3fQEy7VjmkiGP4jvKXSCA6pmxJyDZ2zVkMNAZOpRqvpgR0b3li9bpfBi50JCn6ZISEnduT+y1VmDqcjBxd6g3dzUKj49HTvKUuy4/6IbtAQiBZ0SzAOp+k2uK4PcOUnLsv40sbFpCy0B0MFpq1XYmy+YLUu1swoZJ9JOEVh+lWVW675cEfn+rNFo3X07SenY0bai3bB4vh24h7KB40PlyoWMqqbooJNUMY37CT2V1jMoGIKhc34NaUU9gBsGb+iXE8VjuCFAVelof0jW/j9ubylWz3Qrn/xKxQ4mJWIKBrQRBTmoA4nRXDavdSUMSpoOvT3q/zHo8s8+hhvpcDiLYRefze83quX5d9iwgJ1HvZbsu3VR2C7VIVIi/9wN+EdISaFebu6iDhKdQi9Z3uqg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(346002)(366004)(376002)(396003)(39860400002)(41300700001)(6506007)(26005)(86362001)(9686003)(6512007)(53546011)(38100700002)(186003)(8936002)(83380400001)(66946007)(5660300002)(7416002)(44832011)(8676002)(66556008)(66476007)(4326008)(33716001)(2906002)(6486002)(54906003)(6916009)(478600001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EdbllrYvu3glkaP9VK+gn107WJJEvFLaYREt1aua3DimHSMf+9lsSe7mgnxR?=
 =?us-ascii?Q?sy+POMe/kS9nvnc44LA87F5vn97v1fe3uMfoT3PNswqY7Hbflw2l+H9mLEy9?=
 =?us-ascii?Q?Ndfkzo1x6aDIFNvd9228qFZDav/VMRPb82jN2723dlpeNgyeSEW6lNssqXJ6?=
 =?us-ascii?Q?sb1JpdTAAV/z6hedEDIDtaSR+JkEGufbNADfDElJ+tMchqAyGU05wlz7GIUR?=
 =?us-ascii?Q?RmGcDza+Sfgekcz4WlSYBhQ0fF85VmiCVC4Geru6er/i/uYr+ZJjatwbBKNm?=
 =?us-ascii?Q?uPZrLv/T/mLp5Scw5K6u+wX26nra3Zf28Igvd5AIb0pgVniM2kJldvj1c/Y9?=
 =?us-ascii?Q?COnC3bRIez4SKLuMM2RqHiKsckP0FoBHruj3DufSyTqoQ6QlulyyUVMg7itv?=
 =?us-ascii?Q?EEaquAx0HmFB75F5Xt7IUVJ6/VklXS7o4k8PjIb9+N5BQgHJNcd4InV4N8ed?=
 =?us-ascii?Q?X/riivh9GQSGpLy2iRe3ppmLWRZ9FAD5fop9byStT6kj9ejwRVzS0GNBJhkw?=
 =?us-ascii?Q?hYIcwyv4GPfPqZlJXU5Vh7Oh/VPCtTN1Nkr18TLUzGDLvwJMVTGWjRk5jjvq?=
 =?us-ascii?Q?VarJ292LklHQ1IIswfPI8gfv0SQ4oY0/Lqp5Z7wENmYeEY2QZ6hGP0QwReYm?=
 =?us-ascii?Q?9Ve+5l8S4l8KgCrchtu7UP2/22J+QzkzUO2P6WxIvptwnn273JlhRI+xDj9s?=
 =?us-ascii?Q?Rh/oMWXPdQOWvEgXajZsjgzGNeiniMPvqB7nRgALqC3aaYfA23hLiLomItrX?=
 =?us-ascii?Q?HIAMHwYAEZcS6Z/I8uv3pl18vQYC6MXJLLyVnKwSw2Ye6J7RCPuM1AVL4NYX?=
 =?us-ascii?Q?uoJO13Bb/rhR5N7SzN1C1QcCTE3q4VQbL4StbxzVxtjtRhFSGZeFKBio411F?=
 =?us-ascii?Q?VEpPANdzOfYFC9QC2pqjelBRljCtCVgTkCFOwP/JVG9aRxq/zi1BJKYNTcZn?=
 =?us-ascii?Q?vTrnFJDpsvv1BZazubZjInbmbbIl+EyYFDhyywuD1oCeVNPGZoHfzOuqMMik?=
 =?us-ascii?Q?O8iPWlX158C/mgJ+MuWMu1bXA43AEMS/avbWhnfy9XaBIqjNvCdB/whvsjZg?=
 =?us-ascii?Q?ff1eOErlO4FyTRXPWtWVho3K0cMyYF61Zt8p9pps6wH7wV9oudrPwCIEwt2q?=
 =?us-ascii?Q?QYx4Qk6dIR0rxSqRW5tfqRJs7siGGIdA89XAcq/9VGn9c+agQ1yehN0W1GRv?=
 =?us-ascii?Q?hM2Plp2JSW5Nko5q637ER33YMV1kIMB7xGYCrRLYLSLbR9hlgRUKaAtVYv8Q?=
 =?us-ascii?Q?cazwm5T8VDy7Yw17GcTvmfwTXJSviNifcnhTt81x8ZivpbKBrblsipZBfuZ/?=
 =?us-ascii?Q?AU6jsY/H1GOigrglThcrDS7+3KgJc1crPwAsVfRJIJg922wfzRleV/uAjOYB?=
 =?us-ascii?Q?e1xNwcu3U7KOt0rE1zUz88W8cuf1Wlv+0qkHWAh2ibaBBiGiO0GXQzY2WBr7?=
 =?us-ascii?Q?LmyMujsV/7Vogts/31IYOUuySUyShf+STiJnu7KfTja+i94aBjZ7K5noXU+X?=
 =?us-ascii?Q?xb7Eac5EC4N9hwOY5T2ZnSYMbqCXwqQPvGC4ihvJ+mX94KwHJ/9Raf3AulcP?=
 =?us-ascii?Q?rwhxOIepHMas9E4x+4P7Xi24xEAE7xgNCvpCsPdwcnG5efclKBnObrt1YFYh?=
 =?us-ascii?Q?OA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de007c0-9f71-4862-9a96-08da70b896de
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 16:45:33.5685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/6n1gW+Sew9gNl+tmVNv4OyZVYFJZpI5sFhWpOkCftmWTOTaeBXbWbxCT0It2pBzGQyvg6mleu7G5cIKeacLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4196
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207280076
X-Proofpoint-ORIG-GUID: NsDV6uHp9rlEVSLWJMovf-T_hUv6ivim
X-Proofpoint-GUID: NsDV6uHp9rlEVSLWJMovf-T_hUv6ivim
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/28/22 10:02, Miaohe Lin wrote:
> On 2022/7/28 3:00, Mike Kravetz wrote:
> > On 07/27/22 17:20, Miaohe Lin wrote:
> >> On 2022/7/7 4:23, Mike Kravetz wrote:
> >>> Most hugetlb fault handling code checks for faults beyond i_size.
> >>> While there are early checks in the code paths, the most difficult
> >>> to handle are those discovered after taking the page table lock.
> >>> At this point, we have possibly allocated a page and consumed
> >>> associated reservations and possibly added the page to the page cache.
> >>>
> >>> When discovering a fault beyond i_size, be sure to:
> >>> - Remove the page from page cache, else it will sit there until the
> >>>   file is removed.
> >>> - Do not restore any reservation for the page consumed.  Otherwise
> >>>   there will be an outstanding reservation for an offset beyond the
> >>>   end of file.
> >>>
> >>> The 'truncation' code in remove_inode_hugepages must deal with fault
> >>> code potentially removing a page/folio from the cache after the page was
> >>> returned by filemap_get_folios and before locking the page.  This can be
> >>> discovered by a change in folio_mapping() after taking folio lock.  In
> >>> addition, this code must deal with fault code potentially consuming
> >>> and returning reservations.  To synchronize this, remove_inode_hugepages
> >>> will now take the fault mutex for ALL indices in the hole or truncated
> >>> range.  In this way, it KNOWS fault code has finished with the page/index
> >>> OR fault code will see the updated file size.
> >>>
> >>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> >>> ---
> >>
> >> <snip>
> >>
> >>> @@ -5606,8 +5610,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
> >>>  
> >>>  	ptl = huge_pte_lock(h, mm, ptep);
> >>>  	size = i_size_read(mapping->host) >> huge_page_shift(h);
> >>> -	if (idx >= size)
> >>> +	if (idx >= size) {
> >>> +		beyond_i_size = true;
> >>
> >> Thanks for your patch. There is one question:
> >>
> >> Since races between hugetlb pagefault and truncate is guarded by hugetlb_fault_mutex,
> >> do we really need to check it again after taking the page table lock?
> >>
> > 
> > Well, the fault mutex can only guard a single hugetlb page.  The fault mutex
> > is actually an array/table of mutexes hashed by mapping address and file index.
> > So, during truncation we take take the mutex for each page as they are
> > unmapped and removed.  So, the fault mutex only synchronizes operations
> > on one specific page.  The idea with this patch is to coordinate the fault
> > code and truncate code when operating on the same page.
> > 
> > In addition, changing the file size happens early in the truncate process
> > before taking any locks/mutexes.
> 
> I wonder whether we can somewhat live with it to make code simpler. When changing the file size happens
> after checking i_size but before taking the page table lock in hugetlb_fault, the truncate code would
> remove the hugetlb page from the page cache for us after hugetlb_fault finishes if we don't roll back
> when checking i_size again under the page table lock?
> 
> In a word, if hugetlb_fault see a truncated inode, back out early. If not, let truncate code does its
> work. So we don't need to complicate the already complicated error path. Or am I miss something?
> 

Thank you! I believe your observations and suggestions are correct.

We can just let the fault code proceed after the early "idx >= size",
and let the truncation code remove the page.  This also eliminates the
need for patch 3 (hugetlbfs: move routine remove_huge_page to hugetlb.c).

I will make these changes in the next version.
-- 
Mike Kravetz
