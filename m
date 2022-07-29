Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D70A5854A8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 19:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237774AbiG2RmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 13:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiG2RmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 13:42:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E7E6171F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 10:42:05 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26TESvKN001482;
        Fri, 29 Jul 2022 17:41:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=/OKZN0+Ce+4f0fuHYVCwjEje+Bs1NOp2uhgQ8nvWnLk=;
 b=UyH+USuoL1zc/N2LuF7c9hpu/8DyCIItfrzeMPJkN14mTzXJeSn+4WN1q+bQ7reosfjh
 tJBfQQlam97Cjw3AGJIUIN7FJL+BMhsfXqmNmvhmbrDvoCkT4pxTQnDOzW4LdC0tit97
 IxV0JLowSvkA7Rq+eHHNGvmRZFTLbxVMk2DeA0J8KIU0hvItSq9iQWjdubx4m36CouAf
 SjrQ28qoYyKEd5mNhnAcf1odtvd/3ArXG7s5s5HKs0Bj7TN70ZQNDz/b6vS/7oZafEl0
 z2CxX9cecOWwwrzr/D9lwhf7iJSgQdrpEAMcboYs3hug6N8phhGs8O7dVZowwQ/VSd3t zg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg940yh4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 17:41:33 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26TGcbTF034492;
        Fri, 29 Jul 2022 17:41:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hh636u9c9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 17:41:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzW3s1YxeCq7MOdVZNIF6CJr8QKKVkdolNpskK1RjGGwDDYe9LUdBe6Qiou4vOgvh3J3B43C2ZOKzQBgnM4Z+5YaC83xy21LVU6YSO32eeZYZRFstIgXtGd86F3uEqM4PRKTuZmsnFVhEqgkVG0N70xgdBGEex86yOs3PRJzOOuvGhvjCaM37yGJf0O6oQrWJ/6xxz2WHYeHhQLX/XgXJVW1tis+EmaViqV5HJ9jrcAGMYgK1XoJa5ddlFDwxAw37RBn2GYJizmXgNHQyVuvb/uus4uYlHwMbJMmeiHdlG6UQL+v0f3yBCEpHr+7DOzXdOupfpGzp3JfQQgLwTeqzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/OKZN0+Ce+4f0fuHYVCwjEje+Bs1NOp2uhgQ8nvWnLk=;
 b=T3DerkXW/vasWCXKldCneEAvpNc8EJCglIpY2xxMJV6FKTdHYIrpfHBmTMm9IUX/0MbKChUikl4GxVE3mxJ9Dv/xO1yhmNAG5UaY4CXlv/JaaOHipzPL/hIo88Ly8+9sWOR7fj6X50zBcO9zc7A69w3mrHJIC9CiogUX3y/yDWV0tgAIzTZ6bzIdDLC6+SHgpQoNnPLq73+vMK3VScclVXWb98TX3mltd9ybrJxJano7Yxjm7HEiBecV1L1KwADFi+os8+3iO/KUjsBcPzFrLOBVcc237nwQp3Sr5jjfa/JXAM0qYCtjztAPSEdbHGct5ekhONJ2LUuXAIOa9AIyiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OKZN0+Ce+4f0fuHYVCwjEje+Bs1NOp2uhgQ8nvWnLk=;
 b=jpFS3XPKFX6vuE8/j/CMblGMjTN1XxnWu1qaiT5b++n9MrOiC2FjViftwlVohI4AaWzhKOBz6jV/sFG4P2Y98P0mwushzkQ7f7xUXFn/4NqXvarT8fGlYqu3256rwHzLqGrIEOt1q2DPihFKGcpW1b02VTLoJ/uoBQPipYjky8k=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY4PR10MB1590.namprd10.prod.outlook.com (2603:10b6:903:2c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Fri, 29 Jul
 2022 17:41:30 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%6]) with mapi id 15.20.5482.006; Fri, 29 Jul 2022
 17:41:30 +0000
Date:   Fri, 29 Jul 2022 10:41:25 -0700
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
Subject: Re: [RFC PATCH v4 8/8] hugetlb: use new vma_lock for pmd sharing
 synchronization
Message-ID: <YuQbxTHGMWTbvahN@monkey>
References: <20220706202347.95150-1-mike.kravetz@oracle.com>
 <20220706202347.95150-9-mike.kravetz@oracle.com>
 <ddab06a9-ab81-5ebd-9273-c50744f6da60@huawei.com>
 <YuLLqbq1aOwFPsdi@monkey>
 <2adbbbd2-51d2-744d-77b4-374fe651873b@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2adbbbd2-51d2-744d-77b4-374fe651873b@huawei.com>
X-ClientProxiedBy: MW4PR04CA0032.namprd04.prod.outlook.com
 (2603:10b6:303:6a::7) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 290f3437-68a2-40ec-f63d-08da718991aa
X-MS-TrafficTypeDiagnostic: CY4PR10MB1590:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MO10mSOVAc4x902Zn+vFGALQ7V8zGuJKXRB8HaR39SOCYcabB5qZQweXBce7avyz5lBZWKBPwr2NW66sHZ2PB7fuYxnANDwNZca5X1VTM7dyldgVAgRYtmVX6kgfefX8v2XwCPTQGhqBhvI6+82skIGdlTQ6EekLh1yLpPkTz6eL2U8SOxB26X2jiI2TsBQSxxMo4zqpRPqAnhTs2aVyy6vi8GePcCRvXULMgJm7dDWvOYx+8MBAPkVf8iDEP56Lof1IjBi2zRReP2BO/5zNWTPewib4ucDJ4kCfyBMfJ83hxTA9CINbCi4j7g63ewnsiWHcZNLJwl41SP//XJJ1p8s08vxehD+3UEGiUumSW64i2hrQy3JFQKu9FTtPGYa353ZVhFJ3dpMudaduBzwQPs5V+lFulQts1MM1fxkF94ifNpvbvU8YzFrX7Dnpkoo60r1UaruGxUzIkX2RYCsLbeoFqtBTngDUEWIFLVBJ1Cbugh0HUqv7bOWH32UdnmBG13mopmR//2/OFJgjqE8+MHtJklq8jAPwfgCeuFrT0LWGe6LfedfdidxeER4C7QN7uSWiXpK0To4iiMVnQT9XTns7dVTONtgSK2jdr4HahVUZkje/KilZes2ffTyoP0MGRfWujg3xfO1YfpJJFuRbtvy+eu6f1dlV3K93JYygZtC9Im3u9A+tAKiWDkBLy+8KWYAUyV3G9LiUUVs/add/Kcctpd4OfMyOGYfO48RcXMgH+UIcwcItKefuv3o7dnMc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(39860400002)(136003)(346002)(366004)(396003)(86362001)(44832011)(83380400001)(186003)(38100700002)(8936002)(5660300002)(7416002)(6486002)(316002)(66556008)(6916009)(478600001)(66476007)(33716001)(53546011)(6512007)(8676002)(54906003)(6506007)(9686003)(2906002)(41300700001)(6666004)(66946007)(26005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NYiVpo8tRXqMLMsxhEzI2/3/uGYL8MiaKIOgUh0m+9GXFV9PGEX5sXmmbUfK?=
 =?us-ascii?Q?jltj7Q84cjHiX6vHRSOAtUgCzoG8t1XI+AECaphl4/m3xdwldjSu69PXhuts?=
 =?us-ascii?Q?En7KBGPkKWJ9sxbxwrTmjrB8RdcvQ1jv1OpG2cr09WkAXv41OZwYNJewPePm?=
 =?us-ascii?Q?N6JxfdWPFLIKBFMKj5bUazyqC+nyYIydo9TtF1oKr3zg4qkFf4Jb7RaooRLO?=
 =?us-ascii?Q?EMSxmuEwpEZVWTnbZYH2svnYclQKEA63lw4TfUlUzL1zNJvwoFR4MvlNdfrF?=
 =?us-ascii?Q?6r2WikXZLCN5SdQ75ROyEeP20Ipr4h83LjYqIjm8ORMPTk+upQjX8nhha+S7?=
 =?us-ascii?Q?K569XhEJN+wlfPS1SEc+S9bc2ql1Ox/VxyOuOjT6ydc/rCJH2SoBZT1Ozd8n?=
 =?us-ascii?Q?qg0/NlrkI0uJ+XwtMYBfe6dOv2Z3taJDVcxT2DFotTQKzurdwjT+SJajVydv?=
 =?us-ascii?Q?keC72nntJrc4XL1FDhAEjeM8BxVg/xNhHE8+KCO4wzmJ1/IF2t4H11ADh2jk?=
 =?us-ascii?Q?AgViTLR4Pg4JQWYUiNbfcy3hoS2yKMt5SQvdisv0tI16sVcRj/MTzaexny+W?=
 =?us-ascii?Q?8/W/wRNpt1kZInQHehIiMNyWCfunWvFNkCbAvJz9p4xcil3AyeDvcn8zv8e+?=
 =?us-ascii?Q?Awa6HnsEflpp+A9D3RbuBeWIwzaJC7DzEPvQ3ZURgQkP+gTMuZAyunzmk5lU?=
 =?us-ascii?Q?AhdYW/UoFE3yzAyRREgsmKmJJsSAUW4aRH49GpVHUPR+Zeq0PUZwExC6eb+E?=
 =?us-ascii?Q?kj8m+REY5ReQ3e0MFIdS2PRfnDL/gTMSd+J+9au6AqCCAaoHv66YbEe3T+7v?=
 =?us-ascii?Q?4FunTZGoW50fL131YwQK1V/CWrrogpSz93T4q5XQmOlluTHaChDNm7FHT65H?=
 =?us-ascii?Q?B0njizPkutz9BSMckIoDuOYngaqiZpl5PBPI46Hk71wPIHw3hubdZMbjBUBt?=
 =?us-ascii?Q?MhXzEnERDz+JHlTMYQqqrxdWU3HZYeHhAWjCXkyEOJJTsCCRtTAZdaHI7Lp1?=
 =?us-ascii?Q?lnMDCWIepnqKVxwFJem65Psg9YfQbEFlHjAKvFQmRSoZsm1S3mlghcbEyIuK?=
 =?us-ascii?Q?YOeBZyQC8JB+FFVaTecxLNfOhf4LxZ/NKZQhu6osjCiu5m4xh6r3/VscfvRe?=
 =?us-ascii?Q?M0dYzKwfV/0II3b/3/wCefhhVYLqomqhran8UspHO+zAHgKuIhoHjT9cv5M7?=
 =?us-ascii?Q?m4XAbHfDX4eN0uDIKqiWItp/Mp4TkYlHg4dZzou+hQkZi108s2WoiUr/xU63?=
 =?us-ascii?Q?MV5rLQKM1zvkR96IlKeqkbfygGwnQtR6QFNOShHNMCABbusOa4YXPGptpdJU?=
 =?us-ascii?Q?z8kFTVe48BWLxUbNWmhSnT/kXsFcsZObH6NA+GLraUij3iqNLYE85FefxOa9?=
 =?us-ascii?Q?RegnUAGzUFlZo9NoMG91eBKBvpeoCVfFm/hcxfU460w6yPb3DqjveDH9L3cL?=
 =?us-ascii?Q?fjxWO9TTubhkUNECcAkkx7XNWaHV/XaoqOFVkyw7gHLUD+Wd+Tu7wToQdXhi?=
 =?us-ascii?Q?CcOGdbklgEXnrjE5FlOCtQlxF78O2Fc4qLiv2RqN9i3Tfr3Gkxa0lc/Jx0JR?=
 =?us-ascii?Q?dPTcp+WS3yU+CA+CTjst+PCiud+xgos8QlyaIypzSsC6VaVpO9ubUERrZw42?=
 =?us-ascii?Q?GA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 290f3437-68a2-40ec-f63d-08da718991aa
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 17:41:29.8766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wea1wd1osBUChXUtj5Eo/oQ+KNQvM8sUJrX8mmeQgoAJltcKnMiUtQWlqv0PyopMuTVcSo5wubBaiHj32WAH/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1590
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-29_18,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=960 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207290075
X-Proofpoint-GUID: WWJc8Oh0GPvieB--XkpOnrTRGh_2KOwr
X-Proofpoint-ORIG-GUID: WWJc8Oh0GPvieB--XkpOnrTRGh_2KOwr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/29/22 09:41, Miaohe Lin wrote:
> On 2022/7/29 1:47, Mike Kravetz wrote:
> > On 07/28/22 14:51, Miaohe Lin wrote:
> snip
> >>
> >> Do we need to check &mm->mm_users == 0 here in case the address_space of corresponding process
> >> has exited? In this case, mmdrop will drop the last reference and free the skipped_mm. So we will
> >> use skipped_mm below after it's freed?
> >>
> > 
> > Good point!
> > I think we need to wait to drop since we want to hold the read lock.
> > Will update.
> > 
> >>> +		vma = find_vma(skipped_mm, skipped_vm_start);
> >>> +		if (!vma || vma->vm_file->f_mapping != mapping ||
> >>
> >> If skipped_vm_start is unmapped and remapped as a anon vma before we taking the mmap_read_lock,
> >> vma->vm_file will be NULL?
> >>
> > 
> > IIUC, vma->vm_file will always be set even for an anon vma.  The fault
> > code depends on this.  See beginning of hugetlb_fault() where we
> > unconditionally do:
> > 
> > mapping = vma->vm_file->f_mapping;
> 
> What if vma is non-hugetlb anon vma?
>

Right.  The first check after !vma should be for hugetlb as we do not
care if non-hugetlb vmas and want to quit.  Something like,

	vma = find_vma(skipped_mm, skipped_vm_start);
	if (!vma || !is_vm_hugetlb_page(vma) ||

-- 
Mike Kravetz
