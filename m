Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E98F4F84BD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 18:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345701AbiDGQUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 12:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345679AbiDGQUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 12:20:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F0A1E6FB6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 09:17:56 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 237FtoID024447;
        Thu, 7 Apr 2022 16:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=MC8tOnDZ2NWnRMFdIkP1zHUBFw3Cq93Oufw31REUKxw=;
 b=AmapimREB9Vu8kFe8o3k3tjZ8VNqnUALUPmmgPXmcBPS8BMbCrnPjlKYMV3668YXgDBl
 I5H7aIMwW31VCcn66pPOcUU1CgwhRh8Ga2L6FxSUQt+uCV25LeP2pxzob608ayHDOVKj
 Ou4020niica5Z6IOrdksxPaBMgPUmBs7D4XNg2jCUAgdqkhht2laaxDX2c23mbkJwjlb
 PKPaVNeytXhwkVnK5w6QA/LnvF9b6Oa/1YRC+0UCcphGLHZZzHGbOkr55nPUPBqdz0cQ
 gEY+91nGS3z/A8ugbP0//eqeQIpQVO1RR6sbsJXTz9e764WhZ3119+vRnvZca1joRYhs yg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6f1tcmyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 16:17:38 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 237FLM5e031731;
        Thu, 7 Apr 2022 16:17:38 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2168.outbound.protection.outlook.com [104.47.73.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f97y7sd2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 16:17:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P606e6Iwe3z8bvUvrIBu0Rba+Bq7NvBHHJlEesWFRUm3cq8DZK5gd6fWRxdIBwuhvLb7kV7aB97vWGwl+G0x2SjqqTwO7/IUAmREkCu6gkMV5Pd/nL8J9BaDpWJZkYrmpKOO/QAqHSGtZS+qS6kPkhptJxPbjqqaN/OUkyCBY0uVPPfGXJ6eIknKj7eBsVMFO8gt/tZhQojYtBE3nbdk3N7nID6lFgzAfMdboQPO6GWdkE1uzBnHtkFXkSNkzXDKNI9NErnmxNITt0psWBzb/66p1pQUEbeiGXJWO9k8rSIcHL62j1Cqamgws+P++TA/AaCe7miu/id/VoO85kJInA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MC8tOnDZ2NWnRMFdIkP1zHUBFw3Cq93Oufw31REUKxw=;
 b=U+AufFFgw1SY6n8eGAt9Y7f6m6sXG9km5XAQqUwPJw3yU2gSb8zPt52VACEVTXbLovye3QSr2hHOhuVhhX0BT7Xvr63PX/reRX20zwjJANSZPTPg0461GfegdhHdABurzVoeXnX92l0vwvKaIe6CjjQ5UgRHEqBOcbeIqAOn8h+8XbOn57919hjuRNK7fPJmzwfAYGm1YOS528tE2va5rCEkcBvgQPL1cETfmpBl4kX7A+02dNZYp/ONlwFtBvhELMBZ4xDC/D/e7kkpRDhldv/dBG0NrtM9HAr7nMefYkA+GJbjWoMEDRYU4nLN5x9ganoArfQRR06Y5XRMhvcexw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MC8tOnDZ2NWnRMFdIkP1zHUBFw3Cq93Oufw31REUKxw=;
 b=RiW7prZXDNnup69g1cIaeeIStdhjszGWQYwcVIBVVRQB7bB88F1x7qBG4Vt6I/xf5BS0ep0cmxUWbt5IN+6S2gfAyiLB3T0mFxT2Mh05dAVvG6xhQtKS/TdxEdttUR/t36boH48O4EWIeWrWEVBOdwPc1+soeOyNIDdxN18j5zM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN6PR10MB1633.namprd10.prod.outlook.com (2603:10b6:405:4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 16:17:35 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::245f:e3b1:35fd:43c5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::245f:e3b1:35fd:43c5%8]) with mapi id 15.20.5144.023; Thu, 7 Apr 2022
 16:17:35 +0000
Message-ID: <4ddf7d53-db45-4201-8ae0-095698ec7e1a@oracle.com>
Date:   Thu, 7 Apr 2022 09:17:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH 0/5] hugetlb: Change huge pmd sharing
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220406204823.46548-1-mike.kravetz@oracle.com>
 <045a59a1-0929-a969-b184-1311f81504b8@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <045a59a1-0929-a969-b184-1311f81504b8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0008.namprd21.prod.outlook.com
 (2603:10b6:302:1::21) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76651278-e7f4-4d45-4b92-08da18b22053
X-MS-TrafficTypeDiagnostic: BN6PR10MB1633:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB1633F04801D546FFD67FDB89E2E69@BN6PR10MB1633.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZcYfW2yRk4zQUUdx0AL+zYEf9gx1uVLnONDNJRuCqYEd711R0ut5nWDz5smKw4iKxQReVc0n7QwKfS8I1UZxOgo0wmRJ/iB0++olGZi4Mp0h91YQD2AXbR6Vs8Xxr8SzgWC9dciR6r330KUFp/YhuI5qNOSldvBJFw8fhNOJ1btS7670kuuZkkGoBuRgYmYNFefYOM5x/A5NIBrSEvsFJQkh+LJSrvtpBZ92F8l2VP4waHJfHgzqBJGKnukutQWlS5EfZ7hgIemFO6986K/jLT7b6LJ00ZSNfRtP/L8LC/LitDaw3rnHpFDmtmhbNDx4lM9ovW6bTLfpIZursgciAoEcpL4RUfXYXAWodHB/ulfCPbvJX6Imno3peq/thekIaVCrkZsjuAXGi7d/ORxv50jVmFKQfk7VHxytX6pXnBANJAKSo/KAvqs/XGs0N10u3fOLdfRZztyPWOeKo/koHT5cyuacxW25li4wj+Pm/raPrlDLPLumqAgOwTlQuGSFTioBOBuz+Xdz+7yNbdySMX/gbYEdKse5eCcRH1WZXoHh413lLvM6vweTJlnzAw0r9B5Id5ud7zgMqvyfBwHGH9R/jHRK/rm+UTqonqoNl1N6ViGR+AiN2gR6GUDZ66RIThyEm55B+4m57u8Pcg2hK/GiioxWjeJgwA0dixxrHPmPHNb1RquyeS2xVz/WydnF6jl2PUbT9vQD0bUxD7JI6ycRSZxteyIvat0lHgXuUvr4rvjKOzhjHmJKG/p/irEUXRWpuSG5MoHdLW5jLnblDc0o4C16a1YSsdqdff/EAOU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(2906002)(26005)(7416002)(186003)(6506007)(52116002)(5660300002)(316002)(6512007)(44832011)(31686004)(38100700002)(31696002)(38350700002)(36756003)(2616005)(8676002)(4326008)(8936002)(508600001)(54906003)(6666004)(6486002)(83380400001)(66556008)(66946007)(66476007)(86362001)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTlTNDRUM2I1WWtzZVNIeFpvaW1pNzB2Zld6amYrYWYzV091R3NiSThTc3NF?=
 =?utf-8?B?SmVoUGtEREVPQTU0Z3ZqNmFIRE80ZHRIS3oxWFZPU1gvOCtXd0FmVWVmYnFL?=
 =?utf-8?B?RUxEcDJpbVdtTjJYbmxVYm9RTkk5cVR3Q25zK3hyUlVxaVlLNGtOVXErdjNl?=
 =?utf-8?B?TlRZQ09ycWZMT2MvS2QrQ3ordzVGVVhXYlJ5NTFYWkN5cFhWRlduU0Qva1hh?=
 =?utf-8?B?dFNZbzJzeEo1NW1qUVpOZjlVcmYrS0NQeVBwQWFiQUwrTStxSXBUNVhGMjkw?=
 =?utf-8?B?L3J5MUgzS1BSdzkxZnA1V0tUc0s4QkRwYThCeWhtUksyRDVtUFVpdnpUMnFN?=
 =?utf-8?B?S0wrb1VqbmZOUk5heUx5MFFYNzVSZjUvQmdsY1lsL3FiM3l5aU9hQi9oMUR4?=
 =?utf-8?B?d2NTbEVtRmVHR2dFcGUvdDlaekR2UWZCR0RTcDFXZE9FS3lFZUxDN3JXTVBw?=
 =?utf-8?B?WnNwYTdQSjVjSVR4bTJGaVUwejJTcDN4cFljL3o5bGJaTXpkWWRhalhGK1F2?=
 =?utf-8?B?RDI0L1pkY2JYdjJUNTB3dlhqa2tEZ0RWTE5uZlVOTmd5ZjQxQXVNUjh1cWZU?=
 =?utf-8?B?Mm1LaHV4QnNJbEx6K0dTZ05nNjhLSWlBTC91Rm4xa2U5UTBMVnVhRktqL2lD?=
 =?utf-8?B?YkhXRGoweEttRitOQzZpMWhaUTd2NXFPT3Y5cGxocHhYWWx1a1puUkl1S1I0?=
 =?utf-8?B?d1diK3E5RFFrQWplNXFkTTVlaHozck56b2Y3Z3F4bUZWcEpRU2VTQTNUOU55?=
 =?utf-8?B?VWc0NDdsQWpHSjJwTmZ1Rk1Hb3M2MmZnRmFzOVpuZnMwOWovMXdBdnowVjFS?=
 =?utf-8?B?NGV3TDYvSXRLVWpPeFlrRjhPSnRGZ3lJcnJidWFpSVlkcTRBdUNXVWVSdVg4?=
 =?utf-8?B?a1BjSGF5dVd1NFA1c0toNmxRSkhab0QxV3VKZGp0VjVlMFVFUm4rUFdrV0hK?=
 =?utf-8?B?U1h0bWVoSWJiMWk2SUxmVFBlNUdPa2ZZT3I5YUp2cndHNWpMV0NESmwrMGk0?=
 =?utf-8?B?VFB2UjAybDB1YlpNTmg1T2lOZWZpcXV5Zi91SzMwdjJtV2lGM1hXY3VUck42?=
 =?utf-8?B?Y2xsS21mUndWcjc2OVBsTmN0ZmxJOVRVWnpFS1BIVXZuMXRCRW1iZCtiNkF0?=
 =?utf-8?B?SjU1eE9FMmI2clJSMGtGRHIwM1hEZEdNQW5STWdsbFh4cittWmhBYUx0N2x5?=
 =?utf-8?B?aHRITVByUkhuUUVMK0ttN1pOMzRPRVNnRnAwOS9pbmNIUFpzL3pNeVBkL1Qy?=
 =?utf-8?B?OVdQeXo1aTFsL01taHVYVk9iQ2pzQjkvM01Ea2pDdEVZdlVFaHlqcnlpSVgx?=
 =?utf-8?B?TWgvcTI1SUhWQXpsSS9uTm9Bbjd2cnNQMDhNYWc5Q3dIaDgydVBlUWhhOHhn?=
 =?utf-8?B?UmgzY3paV0NlWloydkMzdEZ4Vlp6UnBUeUhOOHRDbUQvZDBHZVFLUytjZ0Zp?=
 =?utf-8?B?OGVQY0I2Um9raGlEaTR0UGw5Yy91WWZwbmFRVnRVMUloaVhuUURQREJDN3J3?=
 =?utf-8?B?N1VtZUdIamdERGlOWFc5c24vWkNoNTVxK3JqSXMzZTJVQWNDK0k2cXhZQ3ow?=
 =?utf-8?B?UWhzMWVuK3AwY253T3RFbEhCOWhXNUtyejRmL29ZT0ZtSE1NcmRVd210VS9E?=
 =?utf-8?B?MGsxbjZvcXVqa09MWHhLclhja014YVVvb1hYRmFudXZnY0hOSnQvZklxSG1m?=
 =?utf-8?B?Q1MrZEpQbHlzckJRWkg3WnNjY2hSVnZJYjYrRkRVN0VMQXg1RkRyM0pQT0d4?=
 =?utf-8?B?QVd3MXJHZ3hURWhIeGxUZnNVRnQ2Wmpjek42UDVWbDdkcXU5aXlyZXJ2M1hj?=
 =?utf-8?B?dEtpcjE1bkhJSk9GQi8vRVdIKzEreXYza244cjlOdTNBNmFFVTc1UmptNXYy?=
 =?utf-8?B?MjA2QUhxcG1uVUwwaVFXZThIK2tBcUNGLzhva2NNYWk1MHplekZ5bVhPeVJK?=
 =?utf-8?B?cThTY1BmQjhLenhReDUvakdtbU1ZSmFFQmVlb1ZXSlIza3NiaFFxV2NkLy9t?=
 =?utf-8?B?anVuQktWcHVBTlROVS9DYm03ZGNtNDgycFVNQWptUmZPWXZBWnRwUXR3QTVU?=
 =?utf-8?B?dXJzQml1ZjBJWkVCUzBYOFNFdlI4MFM2UXlhZng0eWJrQWZseWtKUkFWc3VU?=
 =?utf-8?B?ZW85REFvU1RqT1hubldJbGRHMWhGeitFMVRWODFpTzd4MmhPeURyVThBSWcz?=
 =?utf-8?B?cDN0K3BCczBFOTBOTlFyR0dhbXRlMjFMMEZUVzZXY1BIME1nbkJkV0lBcTh0?=
 =?utf-8?B?UDNQamJxMUY4T29qNXd6WjZQOFgxODNnZEQ3d3VkOEdqNGZSUGE3ZFpQb2hZ?=
 =?utf-8?B?dHBDZWFzSWJaUXNkMWRZdURoN0hPTk1qRTNHbThoekpIT3phOTd1MkpSZUJh?=
 =?utf-8?Q?8mJ6JK3xszUHcyhY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76651278-e7f4-4d45-4b92-08da18b22053
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 16:17:35.3639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u0V21mZTLgKfgOAialZfLQOGX12/H3Ku1roVXp91eshPdoPvrkHTMuezZP+REVVfLXKtk7iovB7yuvYDHVDR+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1633
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-07_01:2022-04-07,2022-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=752 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204070064
X-Proofpoint-ORIG-GUID: 5mJ-_1bjaqUARNr_h55JuSEiuSkVkMn2
X-Proofpoint-GUID: 5mJ-_1bjaqUARNr_h55JuSEiuSkVkMn2
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/22 03:08, David Hildenbrand wrote:
> On 06.04.22 22:48, Mike Kravetz wrote:
>> hugetlb fault scalability regressions have recently been reported [1].
>> This is not the first such report, as regressions were also noted when
>> commit c0d0381ade79 ("hugetlbfs: use i_mmap_rwsem for more pmd sharing
>> synchronization") was added [2] in v5.7.  At that time, a proposal to
>> address the regression was suggested [3] but went nowhere.
<snip>
>> Please help with comments or suggestions.  I would like to come up with
>> something that is performant and safe.
> 
> May I challenge the existence of huge PMD sharing? TBH I am not
> convinced that the code complexity is worth the benefit.
> 

That is a fair question.
Huge PMD sharing is not a documented or well known feature.  Most people would
not notice it going away.  However, I suspect some people will notice.
> Let me know if I get something wrong:
> 
> Let's assume a 4 TiB device and 2 MiB hugepage size. That's 2097152 huge
> pages. Each such PMD entry consumes 8 bytes. That's 16 MiB.
> 
> Sure, with thousands of processes sharing that memory, the size of page
> tables required would increase with each and every process. But TBH,
> that's in no way different to other file systems where we're even
> dealing with PTE tables.

The numbers for a real use case I am frequently quoted are something like:
1TB shared mapping, 10,000 processes sharing the mapping
4K PMD Page per 1GB of shared mapping
4M saving for each shared process
9,999 * 4M ~= 39GB savings

However, if you look at commit 39dde65c9940c which introduced huge pmd sharing
it states that performance rather than memory savings was the primary
objective.

"For hugetlb, the saving on page table memory is not the primary
 objective (as hugetlb itself already cuts down page table overhead
 significantly), instead, the purpose of using shared page table on hugetlb is
 to allow faster TLB refill and smaller cache pollution upon TLB miss.
    
 With PT sharing, pte entries are shared among hundreds of processes, the
 cache consumption used by all the page table is smaller and in return,
 application gets much higher cache hit ratio.  One other effect is that
 cache hit ratio with hardware page walker hitting on pte in cache will be
 higher and this helps to reduce tlb miss latency.  These two effects
 contribute to higher application performance."

That 'makes sense', but I have never tried to measure any such performance
benefit.  It is easier to calculate the memory savings.

> 
> Which results in me wondering if
> 
> a) We should simply use gigantic pages for such extreme use case. Allows
>    for freeing up more memory via vmemmap either way.

The only problem with this is that many processors in use today have
limited TLB entries for gigantic pages.

> b) We should instead look into reclaiming reconstruct-able page table.
>    It's hard to imagine that each and every process accesses each and
>    every part of the gigantic file all of the time.
> c) We should instead establish a more generic page table sharing
>    mechanism.

Yes.  I think that is the direction taken by mshare() proposal.  If we have
a more generic approach we can certainly start deprecating hugetlb pmd
sharing.

> 
> 
> Consequently, I'd be much more in favor of ripping it out :/ but that's
> just my personal opinion.
> 

-- 
Mike Kravetz
