Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B02157222E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 20:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbiGLSHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 14:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiGLSHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 14:07:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5BBAA803
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 11:07:18 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CGd4hV006969;
        Tue, 12 Jul 2022 18:07:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=dO3z4ry8ekxqCb8o1dHYO2e6InWoPpuTAmFzSvsZpb4=;
 b=j+pfKEe151mWfdF8/hgDXwxbaVOZYfZSHyQrSP11qzmHXp2di1247Ed0k9AhgP5k2hQm
 gx7Tp6AKnAYVuxbS+65lAajRSwBIaGe/fjRptZ9Tobohfr9gWPKf155rulzAu4nS44Gk
 XtiFDkdMh+XRTv9zhJHWCfHW2/5vyCii7kkx7EAcAO0fOrHpBE1XxLMcP6S35m9zYuur
 MAVM0aAqZSTsTBAbhlTVbLxi3bkHYJsiE8aSzmwwDnR5/SnT7oSEmKP+1W9k9/rVxvS4
 6/54wDt/5LEpwKW8AkHJ1ch2BKlErNuUZLyqLf7lwyhXILoSTQZGTi7dJM4N2zqY78/A Nw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71rfys1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 18:07:02 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26CI5a9G019274;
        Tue, 12 Jul 2022 18:07:01 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h70442y0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 18:07:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsN4mglVTVYl0cfJfCtXqqOnm55h16dSDWZy+FHb+yP9a0rHHJuPn1VtzHoamtBVU/CNUTGNqcKmwSAMXrFjHzzyCW/qg+gXTVDHadYDDdxxrtsqTu88p8Oi6SUpA/Goy5Xt+vnQb1VcZmvyjFYO1Xr+ivG93j6Zlb6bP/d4LSQfn4rqACdJUHvUyTgXGiYO3G0ihaouMGsBnE1I/1pGXm9kfKX5ThnX7IwFbUUc8N5g19/2giwylD/lFds0Fr48k9m6QatEB8Z6GNb0OnB+rC2zLU2+A1BUXqHApxPVmsTYVXWAuvK7/fKMt3mzGxEKSrqVBgY3Ck2ps1WndnunvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dO3z4ry8ekxqCb8o1dHYO2e6InWoPpuTAmFzSvsZpb4=;
 b=jW60fD9DMaK2cWSFhpqRoVVQF1TNdvjSMzT3vlsPVsvzqodRyr/hayudDIKWa0Ve2MCtw83a03PL/sh/Arjc3YqM4BcDUvVZSfmAbQCOqKgrq49bAfydZ/nHlEdUlxLUswCh+JTj2i1xwqDWSW3+tfcDJp5F6XbYCMtWVKV1puI/fSozcWzvj44HYxRISkUT5Xnxa4FUtycmg8MOJG7duOcw7BY8IyFlUGLPle/Rt8BMi4Z9zgRSg450dwxq7WFBs3HkxBx9txTqar59TFxuzhw3rlldynYbKH/ZcNkXhNrzobvCC/ZCjUYMuFE7pLRE4juLGqdFL660003Icjbm7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dO3z4ry8ekxqCb8o1dHYO2e6InWoPpuTAmFzSvsZpb4=;
 b=p30rl0bgvSQ3BTcrU/ZFtmxaejNA1snDKJSRj6S3FqTQPwLIoFkauTqKKBcxwaCL8bMwON5Bh8swyUNEq7ixFSW3oPM2g1JuMwj+ToyWD1tBwPqmURGHfQ3itB1cCZIPPtlqtTm5JJSnmmsryuWsUy7GMkU7LVC+Z7ElIHjgbOI=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MWHPR10MB1854.namprd10.prod.outlook.com (2603:10b6:300:10b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Tue, 12 Jul
 2022 18:06:59 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%6]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 18:06:58 +0000
Date:   Tue, 12 Jul 2022 11:06:55 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     James Houghton <jthoughton@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 19/26] hugetlb: add HGM support for
 copy_hugetlb_page_range
Message-ID: <Ys24P1ODVr+3/P0p@monkey>
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-20-jthoughton@google.com>
 <Ysy1EySRmjxl2TmQ@monkey>
 <CADrL8HVimb9qx8fjhgFMfj2hWwD3+6_ZY7W=gHbf6as6qbiLYQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADrL8HVimb9qx8fjhgFMfj2hWwD3+6_ZY7W=gHbf6as6qbiLYQ@mail.gmail.com>
X-ClientProxiedBy: MW4PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:303:8f::34) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97ef841e-347a-4eba-8fcc-08da64315006
X-MS-TrafficTypeDiagnostic: MWHPR10MB1854:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mhAhru9+2p+ORbcL08h5FkrlubOEMMYdlnNbPQqPfwumcounx3D9j2mEWBJknV3+mPZ3leJvx/9MbutcbuCvETm1ME0+Nq7XBw6oaZbIABDcfyV2VVzUMokcfWieB1dIEZi0LIhNLDgoQdD/xLiXcc/l0qdDZo5Pyf+mFUgbWs9ohnIP/J3AERN1P9gDZutjL8XYjI/zEGSXDkA7ChEA/DEUvaWauarOMU0g2nMLZARxKpqG6/v9od6//D4J0EzMZTaNpj8h57PPVQuoorWOlQohNJRMFC4CGuHba0BidXqCEfZrdc46Z6ESiYc2RI+ICf49adNZSzqlZC7dUyu3lU79E8+LJDQ88XBatD+ZUm2w7C5/018jc7+M27wLj5W+41Sn4lXqSt0zVRcyTKYyLo56kjGMzU87kurO8lh4PmKxVu+Jtv2CPtZKD+4jqppT6VaKIjG/qBjH3yVV8WfkibQKTVUcuFKsyKg9X0kAWTG1J6bGBjiXEz6/hhF9KYlVNvRRfK4bn0DOzWxNuF5gXwKtUXBjt7n/uOP2Mt3rf46v1ui08w+izIz1OxfTQliQ0MM8AddL5wIPtORkV3O3w4PYW+joMQyzx0GEFueYXWqdBW2RW7yCjH4gidOfaj7f+n/FmcRKnfKKbnOvBAN5/P90giwyePU/RkxWrzi6JZ3toYeZ1qhpk1zwxttFyCjUR/aq3rwUIr093vjh0lhASyHpMLVyKN5MOFGNQFECR7W6pR2ncZaXq+qMHvqE6ZpvBuVAkPVRzj9qHZWmnqBlsqKv2tRzQFt6wpA3efsYjIU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(39860400002)(396003)(136003)(376002)(366004)(66556008)(66476007)(8676002)(26005)(4326008)(8936002)(478600001)(86362001)(41300700001)(6512007)(316002)(53546011)(66946007)(7416002)(9686003)(44832011)(6666004)(54906003)(38100700002)(110136005)(5660300002)(6486002)(2906002)(83380400001)(33716001)(966005)(6506007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lDZz2Flyckc70JyJajCy+P4uYW1YVaetPXgBMQ8ewUYSf/7+vSN1StVE7oQX?=
 =?us-ascii?Q?n0bh5d0COOB3a2It3GkKIa9zyGTk00Hvy/3U1BhPt1ARa16T9qB+4FzA9fQ4?=
 =?us-ascii?Q?p/oLPfUGLjb2AQc3ivAvUHYwS44OcS0+bfotLRor9ZQbimRucPg3AmBjDq+1?=
 =?us-ascii?Q?TNUM6+GIJv4eVWX5JWH/kilbQ58YFaTqPF3bqmqZTU+z1i5r4KFB0Ods/cjg?=
 =?us-ascii?Q?/lcJGbBQt1COmDDVNTmYABXknrLnuZNSvcm5/LWedp8n6pFGD0hyPmpSkgnv?=
 =?us-ascii?Q?4ZUxjQmhYpdpQ3dxwTBN2N4QoKE0Up3/fDJLjnY9DHyQp1JMpFxIzq/FMhP0?=
 =?us-ascii?Q?5q/iUBaL7FLFKjSO3bbTfVbii7pkZ+ballFn7I09fW2IxKd0Yh4xJhcZt9Yi?=
 =?us-ascii?Q?0gy8jB80k6sX95cZyw2akmeKen9xk61UnMGd3cBp8FPpp7+tQPvBwL0xOPqZ?=
 =?us-ascii?Q?fU+0yOJMKJzbCMtoeW8lfHbBwKwcbSElm6wteMUZGFZ82azofVVJCZBjQlQu?=
 =?us-ascii?Q?4hSv+wT4hB4o8XbF7sqTukLiwZoJ/VfxbDlEdjn8+sIR7ft4xqr6fcjiqY16?=
 =?us-ascii?Q?ptDdlbvEBMDOvdIgx+cGqpA6KowlsBKHFlsPrhfM0VI/TAg+jpehU6MnByL8?=
 =?us-ascii?Q?Daqi8zU7pwgxn8IH0qGJ4fsCV7SIRdEyx6iLBDAhI6FHjanKKmqGdIfOFkDZ?=
 =?us-ascii?Q?qHkwV6DqLn9mK8oySsU/XuylHQFfaAxA5RUD0+zDJwBEB61W4GEB1Hebzc4k?=
 =?us-ascii?Q?xHl19BqyyzA8wLddJ1omhYi4MbnNsEcQjKpmAaBNC+OPsPSi+8TIWoIswKop?=
 =?us-ascii?Q?kmYgP4WfAaMkmHVXekUv5hhActgN9G2K26Cbb64a/uPU0IpZcTEsag1KJHFe?=
 =?us-ascii?Q?YLwxNA9/Y+ymcNccG1+VP/CdTC4rGOG9ftnuBCr+Q7ncFqhFj+CRh8ssTcr2?=
 =?us-ascii?Q?j2hOjRLOXCob6Kx6j81YjSb9pgBin8VUgOTrsRnBnMXLxSlC1FK7TrQZsQfH?=
 =?us-ascii?Q?c4RozU1gINaJUP9q6juV19JxVQY4eIklzleksSyeZ7lCXd/FpC9HgCgFda6o?=
 =?us-ascii?Q?RfPhY+Kcxn0dI1HhHQFHuhgaNmLuq71VOyw6kknlmGAS8sX9MD19a9iWqFvk?=
 =?us-ascii?Q?7zb57Tciu+lX71R1WLDuafoqNqoEH5sa14RK0+zsnQ5YRBir/xIWQ+5kh7tn?=
 =?us-ascii?Q?TrLKBVnxAHpI8ugIhFJtp1O80oPU1T1E1hjQ+cVsT9AWRnUy/xF2cVGjO2KL?=
 =?us-ascii?Q?wnjzUEkIIqIGviBlRazJZFUCeiw/8/XHNrMZ2eVmI/cCb9fOblJQuc0DLBcU?=
 =?us-ascii?Q?DVJeDk6LfcegdVJ1Fi67g+lPSmQHaP19cceciexZGoeCNoTwbDuE3IGHHU2d?=
 =?us-ascii?Q?nhK4EnJzNWCrAbeWd5UZnQYcgSab5upnY3Eg3EOpXF6uRo1koncON5v6V5Ti?=
 =?us-ascii?Q?TpHI+WPWzKdwK5id7hQ4KZJqAXDzSnydgUKkU8Wle6fhNQrrZyiNuTYsz7Ju?=
 =?us-ascii?Q?PuzNSEFbMDwEhnB0+ZUBXY47QojO/JMSsjpK3r0MuUizhrTujKFxemvIIZIq?=
 =?us-ascii?Q?1stLeWZtIwKUMLB+BbTIzhb2QmBa/5qHOTayVb0HswtYZcXTYQxGhdmjAWUc?=
 =?us-ascii?Q?Gg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ef841e-347a-4eba-8fcc-08da64315006
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 18:06:58.6066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a7ppkoL8sOKs9QnQM70NpG1zo4BAJRP40rSoLaxo3IkLncPeb26bnl2M3ZwTSp24VM9qs4iuqEyKRBhtw10ZBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1854
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-12_12:2022-07-12,2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207120073
X-Proofpoint-GUID: RIFU1PjDYGx6liLVUfQgoXqCPLAI40um
X-Proofpoint-ORIG-GUID: RIFU1PjDYGx6liLVUfQgoXqCPLAI40um
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/22 10:19, James Houghton wrote:
> On Mon, Jul 11, 2022 at 4:41 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >
> > On 06/24/22 17:36, James Houghton wrote:
> > > This allows fork() to work with high-granularity mappings. The page
> > > table structure is copied such that partially mapped regions will remain
> > > partially mapped in the same way for the new process.
> > >
> > > Signed-off-by: James Houghton <jthoughton@google.com>
> > > ---
> > >  mm/hugetlb.c | 74 +++++++++++++++++++++++++++++++++++++++++-----------
> > >  1 file changed, 59 insertions(+), 15 deletions(-)
> >
> > FYI -
> > With https://lore.kernel.org/linux-mm/20220621235620.291305-5-mike.kravetz@oracle.com/
> > copy_hugetlb_page_range() should never be called for shared mappings.
> > Since HGM only works on shared mappings, code in this patch will never
> > be executed.
> >
> > I have a TODO to remove shared mapping support from copy_hugetlb_page_range.
> 
> Thanks Mike. If I understand things correctly, it seems like I don't
> have to do anything to support fork() then; we just don't copy the
> page table structure from the old VMA to the new one.

Yes, for now.  We will not copy the page tables for shared mappings.
When adding support for private mapping, we will need to handle the
HGM case.

>                                                       That is, as
> opposed to having the same bits of the old VMA being mapped in the new
> one, the new VMA will have an empty page table. This would slightly
> change how userfaultfd's behavior on the new VMA, but that seems fine
> to me.

Right.  Since the 'mapping size information' is essentially carried in
the page tables, it will be lost if page tables are not copied.

Not sure if anyone would depend on that behavior.

Axel, this may also impact minor fault processing.  Any concerns?
Patch is sitting in Andrew's tree for next merge window.
-- 
Mike Kravetz
