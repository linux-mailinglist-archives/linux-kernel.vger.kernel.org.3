Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B01055C239
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239310AbiF0UwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 16:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiF0UwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:52:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E303615FC0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:52:05 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25RJf2Ja031567;
        Mon, 27 Jun 2022 20:52:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=zOW2bjWI4nmTuHstZl081QFDk/lt13dFqJ3SCVtfayg=;
 b=sCNQo3T2VM536SuY7eSJ1+KlkwFdatM/EjTC/4oxNz0itsqmxjXj6baImYO4B9X5mavn
 cPOOpI3nX/DL99lHrCtyzOexlsbaIlcRLv/1BYChQ8P6PepbzKFrHvOtPG0b95YPEqaz
 ZHfYGPXD+at1rXiLwbuvXoYguyqc+yJQ0vCGH+O8el+0nNqkM1yL30QAD3gNpfFXMW7u
 pdCy0otx96WTQ/7PVuIxrKJSqmIXaOiFmEZ9QpiTOEU+KVVIGmRPxwaG4gvmOxCL9Ep9
 nN9aH88baU/bMK1RgV59EOAXmt7FXfR3dJyYVjJaLgxrAC9rnxhnphEyA3/+MNWKge04 dg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwrsccb8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jun 2022 20:52:00 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25RKjT4j025675;
        Mon, 27 Jun 2022 20:51:59 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt18ujw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jun 2022 20:51:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lezt1bCjGbPEU8gXYDgL16i7AZDv3mbYijLd1oZg3oDQvNOl87IaqeFcdwQcOlGR0C/xULglczVRlG4XPMfq6iCXjE6Yax2IMhzU5yiAHWx9lEmvwMtGNzJRb97JwGUi7MJVhlo9l6Rgk5gx2MOXTBpBJV08CARp9qjvd2DfqOC+QCDJ4hVp0Ns+NB1apJg771DdypgdnP18sa2oWcfp6aytgX7rFLat8Syo1rJa/40PvanYau14P3zeN7oaD+qGNo1gBaynu1ssob6MPutS/jQ18D+IoIDqgbHNn06s6Wr61u94NhHg13sthkUh2d6Ha/fFE3MkEVSREf0EgE8q+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOW2bjWI4nmTuHstZl081QFDk/lt13dFqJ3SCVtfayg=;
 b=cwpVHOKuiCiOsq7k0UobRJJl2P01ZLXi3Xd1TviTFx43oo2xvcjNAA7da7TV/2tc1tOlsG07sji/VnxIs5oB2dCMNtN7xviOjeuWD69iMKoa/7wv2nprSnHBy+gjXNOwFOpsDcrAsQDiEkqVfjcOWwkTpYtrTV4+himoDJIKEepDlpotubhIfhlGr66tBaWIebHbRKvnFm2gpZuVsknWHtY6RQkdb/XVGBdRWEIuuFZzfEWu8H0NWn84Bk7g9S4SFu9EMBGKxQb1pBvEC2kvf8a07S2xMreV1xOvBOxEPuJhXX8Wbmwz86Tx/efacmvjvrUs58bCrRlSXc4Evvn4nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOW2bjWI4nmTuHstZl081QFDk/lt13dFqJ3SCVtfayg=;
 b=O3o1XfRw24T7TzZkKLpPyd0efYtb0BBc23y1y7M9sJ3D9mxYCVqthrZmsvVIYQYgdl/k+Pq3ffP1Q6G+r9av3agWVXaWXB4KwvmNLVZiJzlBRDLT0H0dwy2MZJGAgNb9JnrTcHJzd74vtoA6i2ts7oGXSi20uCMl+oRNPmfvMVY=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM5PR10MB1386.namprd10.prod.outlook.com (2603:10b6:3:7::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.18; Mon, 27 Jun 2022 20:51:56 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%4]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 20:51:56 +0000
Date:   Mon, 27 Jun 2022 13:51:53 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 04/26] hugetlb: make huge_pte_lockptr take an
 explicit shift argument.
Message-ID: <YroYaWVvNZJvtqsH@monkey>
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-5-jthoughton@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624173656.2033256-5-jthoughton@google.com>
X-ClientProxiedBy: MW4PR04CA0314.namprd04.prod.outlook.com
 (2603:10b6:303:82::19) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a3f6de7-9a8a-4fc2-785d-08da587edf90
X-MS-TrafficTypeDiagnostic: DM5PR10MB1386:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2TeHoiz8we7op2WQ+k9pfBLl1IyMAx//CrxyCwH+FJJxT7e1Vho8qciL89+x3gu0BjGK3UkISyaXl+QS8J4t3LEazKHWpdmw7oV6owMwhe1GLq3lAaCLzhMCJ6+9CO1UWd6gWk3XJ8eoE+5S0gm7h53M8CzHMcNLC3DrNzwah8PxvbyVvcSTBEVm5+R5o+C6jRk8ma2HIQg7QAumiimM1JZWShYf+SW42eqDICK1nsSI6ffoRB8fvEN5ZdXnwFTrlNV2O6adZQkuuGUm7PUVyogLWH/5JQbDdLfBG4b162chbCDxBOYxitS4pk92hVfqaC3+1L01leV/7Br+z9e9mYASdnaU2xaICr+U9EMWFBpVXnN6a41MCsUJwyy5bMu4XTzi0TZYMd1LrjBIdgAaM7dpd+r5vUycK5oILHZKzlHiWv3fgZeNEq411LTWBvoaemGzXiqmHPSg1K/mDSoMPeNezKemia75umdVcWvzojZ3JYPPy19UlbxNIHrOABPG/OrTBtf1JvnJ0SUHX7EIbfP4bGiG3E9ugH7949Azh/GqT4+7r8xBIvvdNLbygzP2kityHJK7e+9rZPKULqOipnR9/H9AghrjdqvDxROkqIrU+fkozXoltv3HW4EdfYuyDZnU4hu561iYgavHcqhxdORbPjFF9V6yHCDTyrAuNqQqRFSyhrrnuIDvSSd1Vr5q0D7Wpk/iycOPP2UYhHyZpvpH2cA/EeRovSTWhH/ZamLeu9H6s0gIrVAWOx6Mj1Pu9B4G5EgforcrnIcuc6inug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(376002)(396003)(346002)(39860400002)(366004)(8676002)(4326008)(8936002)(53546011)(66476007)(83380400001)(6512007)(66556008)(5660300002)(66946007)(9686003)(26005)(38100700002)(86362001)(41300700001)(186003)(316002)(6916009)(54906003)(2906002)(33716001)(44832011)(6486002)(478600001)(6666004)(4744005)(7416002)(6506007)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GVrW/n0puFuFUiygcJVdUMgeHU2UjW2kpXoohA5wYBoU3T6TGj2RHvJPtatX?=
 =?us-ascii?Q?WmN4ydDCo6uksyqU060jl+5j7PbcGsI04RB2jRvKbRwun/9eD5EwMWt2zaJ0?=
 =?us-ascii?Q?M4C3KHp5McqoCE+R76LXF8O/sQU9Uqu9SK5JV4RG1pI5Vic80kF8EB2GT1CJ?=
 =?us-ascii?Q?6MHuwqJ7hI87qa87uTg+FPl2Ioz72sM4Gy9Dtd4X9frCUJ6S6lQOcl3bgWsB?=
 =?us-ascii?Q?wx1y/y9AY7+s85Gr76fsaJXkhpzCuJeKBqGK7GTcUc9Y3ltXr2VieXukUJ5S?=
 =?us-ascii?Q?7h1abSDK9+FQUBZPzdjoUPd+t3EhBGzyGE3GeLmAFt0tFpilVhJPXfMnAT7w?=
 =?us-ascii?Q?0dI+Tafj2IubGHJuCmvrJWoyQhYbN2j9EtiRZijEgtzkct6/WCaEUmPjPotB?=
 =?us-ascii?Q?pLtSPFUQh63QlKGw7JDqAic92yfldFD+IJ2UVDTJCSUSD4vFK7gReeM7xKrb?=
 =?us-ascii?Q?GBi4TrickHkh4u3BuQNN6AAsOH8NWeUsj7QLCmCRjK9B5Mtzkihw67S0yuHU?=
 =?us-ascii?Q?y7PDTjImoyE0dlZu6MBC+9zc901ACreciJ1bE5Hazv05vM+yIYP26JaJ1For?=
 =?us-ascii?Q?koBng8OkD+9i6BCJX53VkSpPhauPCBSUVca9RGRhajyETTXgZeZ7bM+ltHAg?=
 =?us-ascii?Q?B0V39V8oHUW0fV3Q8rFeJP6fd3XLCECen50uqDlegcRQ5Bc6kGUNv1BoiDYH?=
 =?us-ascii?Q?PXlFFgG3GuLTa/EYlWB/GhhgY7Xm4vhnlgl5uetE3nYcQoq1FpOBe4WaH53o?=
 =?us-ascii?Q?wiCCNsZv6xrOw7XRSe12WAJXHy/e95vfyNfNuFcSG5lWK3+1f1/WLX8KlYhS?=
 =?us-ascii?Q?YhlfA+9adykOM21gW0DfCg3tHoy7Ch40G4QgK5+qjpCHiNXJ4V5I4kN7HiUy?=
 =?us-ascii?Q?dXZQeTuFaT4ftqkOI9TB1Oup9H54MvatJwIaQMQjPrw38tQWhNa2/N31VPdm?=
 =?us-ascii?Q?4FuN5prNQghe2xwtVl+jljpHThVd/XpRxfq+CIjxbrj4Ym8Z2+W0rpmkZV0f?=
 =?us-ascii?Q?c0coTwJ6n1WKIIsZrSkIy/7WkHXLKAvef5JXW1hnLWSGxSFAMkp0PMcS9y2P?=
 =?us-ascii?Q?gmyQ62WagvGb7lIQxIc+MWU9ylgweY7zxvHbNwjclfe3VH0nWDUqREuJangC?=
 =?us-ascii?Q?zp0odsnsv59XFXVnCSrujuqkjH5FBCa7juaht1KdA04cQPwc3Y7PuGR8rJ5H?=
 =?us-ascii?Q?2Bu6t3fqyheFhnvxgELR/sH2CEGy610dy14Gmj1kGodK5nAGs6wM76+n4VoY?=
 =?us-ascii?Q?kXBbmz7IsL/0S+kt7MA2O6x42zekC6/FRDhXqvw6e+qIoCry45Kgx7nHnvNP?=
 =?us-ascii?Q?2xwCgKiXCIkvPHHwStC+apPcrldVHDgT/cWiZsISiI+DwDPRsVpblPebxMz2?=
 =?us-ascii?Q?WeezZ10IAiAr152TBuoG8zvbubI47vijiv7umRlh2ZfCk13ETSozcGgP0brE?=
 =?us-ascii?Q?N60t76ykXsn5CVxrMF4bs2uK3SfYM6hgr7P1zUFeyHTbuBY6ppxbsEsT1MOm?=
 =?us-ascii?Q?7THDMDHP9aSXXEJ4h5JFLlOuv8u8DTe645AAxzFqlYvBjFU7xnnY1s2GkYaf?=
 =?us-ascii?Q?MOKuVQuvPp34ddtnfV2dgQENBJGrd8oOM8uczbQmJ0tPvvbDIetUFrtc9AYc?=
 =?us-ascii?Q?IA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3f6de7-9a8a-4fc2-785d-08da587edf90
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 20:51:56.7350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n6nUGplN9HF9ToAdytGjp/8R48fro8+myZ3fAJNzXFDJcxPCVneymMXOD1Zh6g5foKxAKVBWWyut4/D25Y40pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1386
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-27_06:2022-06-24,2022-06-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 mlxlogscore=539 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206270085
X-Proofpoint-ORIG-GUID: pgAzCPE3nc05LZT6N4jGI2qILS15rrkE
X-Proofpoint-GUID: pgAzCPE3nc05LZT6N4jGI2qILS15rrkE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/24/22 17:36, James Houghton wrote:
> This is needed to handle PTL locking with high-granularity mapping. We
> won't always be using the PMD-level PTL even if we're using the 2M
> hugepage hstate. It's possible that we're dealing with 4K PTEs, in which
> case, we need to lock the PTL for the 4K PTE.

I'm not really sure why this would be required.
Why not use the PMD level lock for 4K PTEs?  Seems that would scale better
with less contention than using the more coarse mm lock.  

-- 
Mike Kravetz
