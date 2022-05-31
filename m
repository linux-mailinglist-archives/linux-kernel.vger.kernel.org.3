Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E2D53951E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 18:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346230AbiEaQ5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 12:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344868AbiEaQ51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 12:57:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220D822BC5
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 09:57:26 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24VFuXhi007308;
        Tue, 31 May 2022 16:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=iPbETvrj5Ec6vjZY8jMH1HJEnpTjmXdtgRrarC8tQJw=;
 b=TaJ1oc0MZVY2AewBBNFQ5GwyKWDOTEaGu8j1VF0uwuWnSeXVWLCEre5T4XhpWFpIMRtb
 4kYR1xkgHK9qPW7mqN12qpWKzKNX4nPrlUHy+87xj7plcJPNi/TS3sFtu1qD1kh7TVH8
 pX0IaIz2KgLwtK5uIqFusrFKgGw1NNOO7TcCLh7NmVwyO5/EzpxSGPG3dxR8JcIwzTuh
 1NagD0ZzdSsjQmcO36+9en9EcudICrG7OX8H3yJmKkKpPqPS3KJGtkcDLZBvcz8Ml/qc
 5MQ4RBi/OO9I+k06wO0eEWVXzrEyNMd2AowwMR+JbXqIq1zZPQC6OOCUfMj0xytbCBy2 aw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbcaunrh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 16:56:59 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24VGoFmQ022861;
        Tue, 31 May 2022 16:56:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gc8hvj01w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 16:56:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnKYwgTsMop46fq1V6R3K2wz1FDGWniUMyANVDjW2O0+IV/B8Qzfz8IVsLrkXCxZWuI6cggyTIA8vuA2oPRI9kFJfAC14X6pdnFbmmfSLWylqYo2hLPMksEiKJQ+ylCDaqtxPH6+EhV9NVX+0ZOFApm5dbMZ9zcc8b7+y1TfS4lX7N1lHz03TyfoEwpRt0hpvhQs/ugfAZM/zA6OLnxZd5MeH4GAzr8GiwOU0A0hVCdQLD3k3X+cN/CEZLybrEf5Eozo81z+9JkLiE7WTp7qHHF1qG+rBUGNDbKN87PKXnn8biE4WWh3BJAMnUvdnSnpfNyiOQgEAEtzUMNzcZ62Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPbETvrj5Ec6vjZY8jMH1HJEnpTjmXdtgRrarC8tQJw=;
 b=I2/mntgGYhMzJY5wLBgo0RgmSRHsyDyICf82KGy39232C1VMCY9AGuRySqJaM8+AJEZJZRM3bgQMGqMMBxBGocGgiwioAQ2zDAgMRSfxvAtbjdWOTGgl4H0rLLICsKcUpI/E0HKMoP8P/NPQHMm6gSVqMDavreFK3SwuGy/k4VKIqgfyq35q4RlAUvpuYtE1xFwMY9eocf1m64wQDefX9V4K7zPqG4AUBDb+CTXVil6AoTQtZl00rIppV1WYzOhEnPJ6bbTqbq4azw9ITczmjUBHSexExpv8ftTXhECMW5OFjPhP6bQyASxI0/VgO4CNK//e3rBiYnJURH4/uyPRbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPbETvrj5Ec6vjZY8jMH1HJEnpTjmXdtgRrarC8tQJw=;
 b=qFHCT42octJPYnU+mEDqiMDZfUAJlkdc8oCfwe4aMyZDPNuDgOnswTBAGORx4zjcmAg56WRVNMuBKdRZtuR7rZJYUAvhMmO/o4TY4Dnnk6g+1Nm1XL4CnLjcbTBczmHV5kjLs4acC3iTs6f5IPNb9yuREYmo5cPinkIRae/kiZQ=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN0PR10MB4933.namprd10.prod.outlook.com (2603:10b6:408:125::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 31 May
 2022 16:56:56 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%9]) with mapi id 15.20.5314.012; Tue, 31 May 2022
 16:56:56 +0000
Message-ID: <3029924e-0857-3684-52ea-f37e924ceb4a@oracle.com>
Date:   Tue, 31 May 2022 09:56:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC PATCH 1/3] hugetlb: skip to end of PT page mapping when pte
 not present
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220527225849.284839-1-mike.kravetz@oracle.com>
 <20220527225849.284839-2-mike.kravetz@oracle.com>
 <437e45c5-c46a-46f4-f9cf-d8c2397c988d@linux.alibaba.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <437e45c5-c46a-46f4-f9cf-d8c2397c988d@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:303:2b::34) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44f8d333-6645-4098-3ee2-08da432691b2
X-MS-TrafficTypeDiagnostic: BN0PR10MB4933:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB49337705A82E4FB2A26359B7E2DC9@BN0PR10MB4933.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BnrEN2/5IeR7oYnpKokUkYuTk+WVBgvpY8wpS6iMrMIlAVK18DPDGkdpbjQk91PkaKYuQD74Xt4KxubUdv26pF5Lqra78Mq0YysvayKlf48qhjqSWb7HHM5tWFJ3yqK2cj9zk+0g1rlQyVPuwFPVbfk862lOMLPyqNa7XEnzVwLvIRUx3Gv6BmtCN7h53PlgQno6fbvuUjvsH2Hfl/MNkaZYVNI4OpRyWFELD+K1GG1Gp+CfYEcwlT1UdrHZX+evLhaSviYoAaAsPLh8Xv2WElOgrCyrNCVCdaZkY0SDaoGPOs4ovJRuTP7mXbDVufrf+XOQeJ7MCAuX1fKuF7hcMV/+K95Mou8vwLcBJs11FKfmWmFM4d5I1SPc+LIWC7aSrPuuc6j0d43tNvxPlaofdX0d/Tz6IoKiLZAyhSFJg8V0erQeZYWa+0MkTCx0ajemcWROy35IemLOKS7SoOJdXa4/xDpuFIT24wcWrK2fNDzhx/7RMIHUvuHiFvaQoBDQRNygFF+sz/m2QIA0H373aXks3suOpVFzST3FW6VR8GPQ1UfnM+ZcVSqOsxrIx4hQ3i9no08+z6tMRotfISOIwYzTxSPNWYveviIVf566wLuz/1wDp+baYxuBsWS8gTLAvLCzFV1DDioT7zs/3RpFFpAn1/ByO0MShZhwceNL2QZnCPEWizlgXjiP+Wcwgk91wxOnhnkEm8v2EyzkI3kpdsx868/fLvDAGj4UjApcirEoxgrV9JBk9ztGwGaHUIsrjnOCy6akyADJtWBFsFUegw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(186003)(6512007)(31686004)(36756003)(8676002)(2616005)(66476007)(66946007)(66556008)(86362001)(6486002)(26005)(7416002)(316002)(4326008)(31696002)(2906002)(38100700002)(54906003)(83380400001)(508600001)(6666004)(44832011)(38350700002)(8936002)(5660300002)(52116002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmR2ZGpqRzNURm92WWU3eGtTZ0FNTm4rekVrZUptVDVCeFVvRDRacEpWMEdF?=
 =?utf-8?B?MlljMUJPcXRyRnNDZ25VSGUrZjE3eDNhVW9oZktEUDVtUUVHU210V0hNK0FU?=
 =?utf-8?B?YWYycm5QZDZLbEVDcm5ZK3lHTXFGZWUxcnpqS3ZGb3JkMW91aEhQMERYS29C?=
 =?utf-8?B?RlVVQU5WNHcxK293eElmblNNTUNpNWM3cnpmS0tLVkU3aWZjM1Qwc3dxUFJG?=
 =?utf-8?B?dmlNSEFUZUJ2S1lYQkdWYmtEazBNUWtzZjBzWHRna0wvbVZKQzJzNTFuK0pw?=
 =?utf-8?B?cTVJQWd0WXVUaENrVlJjN013eGpmWXFGYW5vdTlWTXNhcm1qekh1WnpjdUJ2?=
 =?utf-8?B?a3E5UU0rYnhaUlpOYUw0ejI5VzZXbVk1bE1aa3dKbVpPNVFzZFpFdzUyV3N2?=
 =?utf-8?B?c0ZxRmh0K1RwOVg0cHh5LzlHak9YRWh6aGxuRmlJYXpBNnZwU25uTXdQbWJi?=
 =?utf-8?B?REJGU09wNDR0a1ZaMzBVZ2RzQjlUY0VpMTAreVdveHc4bk1CRFhPeFpWZkVu?=
 =?utf-8?B?SEhUa0FkS2dsKzh2d1czc3J0ekNEeVo4MnpzdE5YaUJDRm9rNWVPTThTd0Nu?=
 =?utf-8?B?bzh5WDRxRGxvZW5EU2VhV3A0LzJLbWtOWjV6RDU5MXd5QkFobi9iUGJqeFNY?=
 =?utf-8?B?RXIyRWZPbmgrb1UxN2ZVei81aFFpN0tEU01xd2h3N0VOcm42OU9GZWxiRnk0?=
 =?utf-8?B?bWl0cU9UUDFWbFlTTlJjV1RXc243a0t3MDRYZTZNVDNBSnUwV2FpRVdaZGhi?=
 =?utf-8?B?UkJ3RDI5Q0tnNFF0UFV2NDRaVE9TeG1wUTZsbEV1UDdTRm9CYmU0bE1YdTBh?=
 =?utf-8?B?M3FUcGR3bThBUzR0UnNBd2s4MHgyZGIySmNXUExiK1c2RVZtUFE0TWZpVWxh?=
 =?utf-8?B?WElUQldQdHM0VktrRURzSE1FOXdFMS9semkxNExpUDdJR1FMbEU0Yy91OXJE?=
 =?utf-8?B?SGhzSDdyY2ZxdFNrRzRuS0NyVkVNa1Vvd3RZOU53b0VyeitUbzlvYktuUUNt?=
 =?utf-8?B?NmtKMWwwejJGWThBZUlxOUNWYmVpaEhOekFrSzJhSE5QODdidlRLVC9MRHhL?=
 =?utf-8?B?cVR2SFNVcGVlUEFUQUcrK3ppTURaQ2VkZlVKVGRRVmVwbXYrSnlveFgwRm9O?=
 =?utf-8?B?dm9Sa2RWbEtOM09QVWxMQkZNb3U2Nmk3ZElvSTZmUFlhbEtNQVl6RFl5V0o4?=
 =?utf-8?B?TFlEcWVoWWhSTXUyb0RDc212K1NIbDFla0p5YVZvKzFNVGN5TVNUQzlWMmJC?=
 =?utf-8?B?WU5WeHA3RGVSRTRHWVpnMnVqUjEvTXZmcjZnU2FoOWlubmIzUHFNSDh1UHlY?=
 =?utf-8?B?NHdpeFNEVk0rbm5KSzU1SXIwdEYxM1Uxb1RjNEVGM3hYS29ZemE4UklRTjdP?=
 =?utf-8?B?MlEweVJicVhpNWFXOHBnWGp0dUtRVWtiSW1YVldZM0JhV1VsdWFxOVl0RVNL?=
 =?utf-8?B?alNZUVAxdnFtUFFGSDZJU3ZFWklqRHpjOVc0REpzR0VMaFBNR0NJMGlDNXJ6?=
 =?utf-8?B?cGpkRThjVTQwRzQwRVRJbkhOaGNVZnZmTUVrN0paQmtHSGV2VWRYZjVDYU5W?=
 =?utf-8?B?bk1MRW9FMGt2SHNrZjVPMlUweWJ1TWRNYlpMZFdxckJQazBOUEFaOW1kcXFa?=
 =?utf-8?B?SGFtWUVtOEJBK0cvTXFIVEgyR2pud0VQcnJDRlhlZjRBaFpOdFJLWTVXMVpS?=
 =?utf-8?B?dk85ZXQwb0lIaU1rdjc1NXE2WUNVOFNtRTdUWDRDRDltakQ0T0xhUHVDNjky?=
 =?utf-8?B?ektYa0FZaDJxUEJCVmp2eEpMV1h6ZzZEdjZuVXBJbTFVSGlHR2NpUlZOMXJ5?=
 =?utf-8?B?cnJ3YTU4ekN5SVMyZ21kMGJ6TUl4dTRSQ0VGRUNMMDByakJpYmZZNEY5eG9Z?=
 =?utf-8?B?OHAzZE1wRWd4eisvMXZtTzZXU0tJVUkyNy84aE5mYmZ0UlFpTnc5d0F6QnYw?=
 =?utf-8?B?OFJ2WjlOeEFJWHozbjFhMi9jNFJjUmNhUEVaRWxZWDdYamtWV0xJSEd0T3hO?=
 =?utf-8?B?cEhyKzM0UDNKSUdtZEdXcWg3RW5tNFBTd3pQSENVVEZJanpVdHR4VkxvaWo2?=
 =?utf-8?B?V01ieW9TSDYzcXJwb1F6eWRocG9XRyt2Z2t0STVTNnZmSWZ6QnhwdjdoZWN5?=
 =?utf-8?B?TGR2c3BDVXBKclBscW9XbDV4U3AycWZaUGo0Mnpwck9Ycml3ekdhWW5OeXRn?=
 =?utf-8?B?MlozeC9VemdObTFsTVJ4dVY1UHlKay94M1lwZGlOaTRaU0I5a3NxRE5WTXNi?=
 =?utf-8?B?MDFVbHl0VWZFNVJwQ0diN1Y2YkZ0OEx2VFJiL2VUUTZ2dldHc3RBSGtmRUxM?=
 =?utf-8?B?b1dEc1UrZ1ZIeVBJWERuRjJ6dEJETkxBUzMrQ3pXKzMzSFFOSFhrRTVlbTNR?=
 =?utf-8?Q?KNU8f/5i/Mz4ZCSk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f8d333-6645-4098-3ee2-08da432691b2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 16:56:56.0430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S3gVh0y78KBnE/3f9SCE/G75Uq571L05yfWWTBfkkFWLbE1iaFw48sT0MtDtrpT5UN6DdO0+1fH1yTQ8yW2ffA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4933
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-05-31_07:2022-05-30,2022-05-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205310080
X-Proofpoint-ORIG-GUID: -aiL2PiysDNXBWbfQm3r0iPupoggc0FC
X-Proofpoint-GUID: -aiL2PiysDNXBWbfQm3r0iPupoggc0FC
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/22 03:10, Baolin Wang wrote:
> On 5/28/2022 6:58 AM, Mike Kravetz wrote:
> 
> I tested on my ARM64 machine with implementing arm64 specific hugetlb_mask_last_hp() as below, and it works well.
> 
> Just a few nits inline, otherwise looks good to me.
> Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index d93ba128a2b0..e04a097ffcc4 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -376,6 +376,28 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
>         return NULL;
>  }
> 
> +unsigned long hugetlb_mask_last_hp(struct hstate *h)
> +{
> +       unsigned long hp_size = huge_page_size(h);
> +
> +       switch (hp_size) {
> +       case P4D_SIZE:
> +               return PGDIR_SIZE - P4D_SIZE;
> +       case PUD_SIZE:
> +               return P4D_SIZE - PUD_SIZE;
> +       case CONT_PMD_SIZE:
> +               return PUD_SIZE - CONT_PMD_SIZE;
> +       case PMD_SIZE:
> +               return PUD_SIZE - PMD_SIZE;
> +       case CONT_PTE_SIZE:
> +               return PMD_SIZE - CONT_PTE_SIZE;
> +       default:
> +               break;
> +       }
> +
> +       return ~(0UL);
> +}
> 

Thanks!  I was hesitant to put something together for those CONT_* sizes.

>>   +/*
>> + * Return a mask that can be used to update an address to the last huge
>> + * page in a page table page mapping size.  Used to skip non-present
>> + * page table entries when linearly scanning address ranges.  Architectures
>> + * with unique huge page to page table relationships can define their own
>> + * version of this routine.
>> + */
>> +unsigned long hugetlb_mask_last_hp(struct hstate *h)
>> +{
>> +    unsigned long hp_size = huge_page_size(h);
>> +
>> +    if (hp_size == P4D_SIZE)
>> +        return PGDIR_SIZE - P4D_SIZE;
>> +    else if (hp_size == PUD_SIZE)
>> +        return P4D_SIZE - PUD_SIZE;
>> +    else if (hp_size == PMD_SIZE)
>> +        return PUD_SIZE - PMD_SIZE;
> 
> Changing to use 'switch' looks more readable?

Agree.  Or, I might just go with Peter's simplification.
> 
>> +
>> +    return ~(0);
> 
> Better to return '~(0UL)' to keep function type consistent.

Yes, thanks!
-- 
Mike Kravetz
