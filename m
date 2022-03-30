Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598F84ECA42
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 19:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349175AbiC3RHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 13:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243512AbiC3RHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:07:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98EE11C15
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:05:16 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22UFL5Fm029851;
        Wed, 30 Mar 2022 17:04:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fQzQVOaU8RzB1HSCqUUSUKceYomRstUDRnd+shKIkvM=;
 b=hytE3Kyrtt3L63yVDLmjTSpf/xmGjZwDHbYoV5M4eX/Z67VBqYJ8CUw+aRl69t7V3pac
 6/NIvWFKESCWcgBfr+vKJZuAnTkCHG5ZE9QPhMrtceEze/EN0lmztLhMch4uRL4/n05I
 BKFOHeLz9yjBdV68SblJRk3HXHALYiS/3I8PRe9zpSGjdqtob9XqoxDkeNjtKxZe8rch
 U1Q00beoPAUnI+x7+cey54CWTzQYLxlvWDlyYp5xi2FsaBIZiaJJpBES3INcJm29Vato
 /5rkihTShlMoCERqWrTrVo7JrVqNinJgfDO1v2eeA3w4PtBZoEfdlf0vDvP3ewf6+j8R Kw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1tqb9y9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 17:04:35 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22UH2VHg035066;
        Wed, 30 Mar 2022 17:04:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f1s94d1sn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 17:04:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNW2xhx0l2655VvEbmjhfwbU9csI9WXgPSH87ZlkMQbKGcAb+k1NIDg3sHfmc2Kgap1to7mAQ2P+RmyiYyD3SeZXKbr/E/FBeu5mnMmOMiO5CU1VjsyziIkckLDakipTaF1pD1QpGJdJCToBWVhGrQDZF0wUxWeX76mw1N6kw4cNBFwIwZeHUUXZrczvBsTRzWBBYSrInkhgTKBntT6uH6QdP/g91BhobvHjYR9AqyirvMzbz9usgQTDH+6hVZ/trCUZorntjbuZf/v09Rzv5XsetPfkKV5G6w73A2gqDikx7zfBJ1emi1kHEb+rXPp4aAtq9w3igdT1275OeVmg9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQzQVOaU8RzB1HSCqUUSUKceYomRstUDRnd+shKIkvM=;
 b=ii2loUayt53DR1dyOYvgXQSR60SQNbZeGxlv3yaqx57hxsltPfRSdQgt0dpXoEC8DbMeSAHWP9evg+zMViOxuTYgcpEEVgT7DUR1cLL93gouow3fq0EhidRzmOIdWF5bN7oJcY/TzPaAYdPXB7ijdsdnK4vRnvzz0BYLHawHKagkfY4QwaMZWwOVtbtvEJ7+LwCa1GuscZB041ItW+evWxPh6Fx442dJec7pvcxGkZ6phvJK24mMYO1T/c86kE+HshJThvk24Iz5HYnIpt+JmBc5J+2ModkOJL0GVUOmIW35HlHEGI1CnP3NZoMyFPVBuvPwkqemI3uHNBA2GYcr7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQzQVOaU8RzB1HSCqUUSUKceYomRstUDRnd+shKIkvM=;
 b=vEhCGsa2HO5Y5G1k98mT/7StvKUSgYZUD/T+Ld+4LhNglnQIyh7Y9v32QenIO7745laPiGuVlsbCmfGfRQPaCrW8kvtvuCAOHAfM6bkkdAAy2Txs0MdUTIx5ofUGXgIzUQTTezCqr/dRBXHEX9L4qin5vMyp9THbhKqbNmgx0a8=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by PH7PR10MB5814.namprd10.prod.outlook.com (2603:10b6:510:125::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Wed, 30 Mar
 2022 17:04:31 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::acc6:a1e3:a7e5:7165]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::acc6:a1e3:a7e5:7165%5]) with mapi id 15.20.5123.020; Wed, 30 Mar 2022
 17:04:31 +0000
Message-ID: <689c199f-9954-524b-7a2d-40f186e87b34@oracle.com>
Date:   Wed, 30 Mar 2022 11:04:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 01/15] mm/rmap: fix missing swap_free() in
 try_to_unmap() after arch_unmap_one() failed
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>, linux-mm@kvack.org
References: <20220315104741.63071-1-david@redhat.com>
 <20220315104741.63071-2-david@redhat.com>
 <d98bd1f9-e9b7-049c-7bde-3348b074eb18@redhat.com>
 <909cc1b6-6f4f-4c45-f418-31d5dd5acaa3@oracle.com>
 <b46a5be4-27a0-6ab6-0f98-658ca82339db@redhat.com>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <b46a5be4-27a0-6ab6-0f98-658ca82339db@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::28) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d594868f-3c64-45f2-cb69-08da126f5b45
X-MS-TrafficTypeDiagnostic: PH7PR10MB5814:EE_
X-Microsoft-Antispam-PRVS: <PH7PR10MB5814A7B1897F27246F1ACC3D861F9@PH7PR10MB5814.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bhiXVMGGpQkY8kM4dyFChBov5YymT/1zy5OPWPB+TzoW5wN79rAZmVjnYIU0ITopbYNzzOqzkZh+cUC+2p3Iir/jRdE9hEu7ECtohQQxhcfnKIm2qvQ5WwLq2CW2ZllQuNBzmNoehkZz9XuTsoJQ0L0Ts8XPHMCcSmCkikIIL55XKziOzIruYYXnREbSxJ3GyoBGa4b8bNb6D13mjxzYGZuHUAGyP8zJDzQGPf1lFlaliyvVNgRx9uBllsCM76N7ammJ7MJ7FYDTemtS5C3WghZSF4Cc2RdVgWZ8sO7QcqX3dkUKYBWPAlfvD54PTzurH04gxPwMPrt8ODhSEwE9JQ3p95amSiLJPuXNCn5GBpXghdZT/TKDZmSM86rgJkcOCvJhrlRqQC/rewZS01TIBJ86o483AwC8Gzd7YT9JzUhH9OUZboqP1zJbq13hHW+vfgc9VbRKf8sNILjls07USOPQ91WXmO49jPpCJoKqTlU1zgCbJ9uLYVHdEoxkiDgSOZbR4qQKcH7KCgCvJc1HHbws4zbVMFpKMvV92XiZac91kT3z/AsYvagwu9zBE6WZZKnxQNRw7Fh/Ct75kUYGZt9ZTf/PQgB6VyHSOTgLrosHOZ1xW8wLxBKGTff/RBpLcN9Z424bxP+YVyLfNk1EIq7ua1y9LQGi+qRCc8lOxFT4K0kYVJpqFK4nVav/2XEcTAE41ZN37KKq09NbjSElm/T2B9NkKkZbnn0+qsr1ivM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(8936002)(53546011)(86362001)(6506007)(8676002)(44832011)(508600001)(7416002)(66946007)(4326008)(66476007)(66556008)(186003)(31686004)(6666004)(5660300002)(54906003)(36756003)(316002)(38100700002)(26005)(83380400001)(6512007)(6486002)(2616005)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VitNTDNMMUtPRXMxcDR1akNXRUwxV1VyYWZ6UGsvVFVoN1I5ZEtkNVNFWS9F?=
 =?utf-8?B?emEreHVjYWFtQUhwVDR1V2UwTU8vemJZUUk0ajRKVitmZFcrYXNqTm80cno2?=
 =?utf-8?B?U3IzWit3a0FPQlpOLytTZ1ROV1ErL0h2bzliRWExRHZtUUhKL09oelhMR0k2?=
 =?utf-8?B?dVNDOTNvVk9aSjVQZzU4WGdsTjdZZ1l3d1Uyc2dGdStIcjBSdlJFWUFxVVI0?=
 =?utf-8?B?aERCSWRabDVQSldUSi84b3ZYbFZ5WlZDaXlLell5MHFlbjdCTWpaUEwxVExo?=
 =?utf-8?B?dVV4MHNtNXdkNld1ZGIwMHdWdmprYWthMlo1aFZxTXQraGVDakRGVG9mTzZU?=
 =?utf-8?B?RUR6UWRjRTI2a1pacmxIak5sRTlmaWZ3dWxOdUc0SDlGRUViMVR2WUl6WStP?=
 =?utf-8?B?NWZEUERvZjF1M09kVmIvR2gyQkdhWWVLVFc1eEJtbVc1QzRkcUNrWWo0NC9E?=
 =?utf-8?B?M1ZiSE04akpWdkE4UFJPd0JLOVlERDJIZlVBN3RwK1YyczJ3dGgxTC9vT25y?=
 =?utf-8?B?UCt6UlJRSmtoa3ovRjJEVzBqWEhHaGVPWHN4M2txTFV4M254UFIzZ2VKQ0ND?=
 =?utf-8?B?VUlOM0dFTUxZYTlsYkpWbXBiWGZVRVVZRVhTV0xqdm50MmxUMFdGTjY2RjU3?=
 =?utf-8?B?cTFjTXluTHc1SFRzcnlRTjQ1WU1aeDVDWEcyeDhpbUE3SGNrVEFCSVNvcnJU?=
 =?utf-8?B?UGhqNzRuM3NtSmc4RnBWQ2tIWDVvSmNkRTdOWFN5V0UrejFYcWVpUnluUG1a?=
 =?utf-8?B?WHVROGRZZE44VjNHcUNLSFJpZDhMOExvR0xvQ0xuL3BKWnkrZiszZXpmaHV3?=
 =?utf-8?B?YmxBT2hiL2pMYUh2T2JvNm4wUXByMmIxcnU3QTQwWmVXMkZteUQweUMza3hH?=
 =?utf-8?B?OW44bCtLT21aaGxvZ0lMcnI3aHphRk5CSVZtK0FOcnlpc2xTTkFXNDZrd0hU?=
 =?utf-8?B?ck91M3hxL0ZuYUxKakU1M0hlb2RCTTBhYmdhbzV3SVRONmlCTlZ4bDBySFdq?=
 =?utf-8?B?K21ta0c1UWNOSWlmbE5FMk94V0xUdlpzdjBBQ3VWek9UemU2WWlwNHU1RStO?=
 =?utf-8?B?UVYxazdUcmhXRXlCamJPUWp3ZEUrSkRhWUR4V1FDa1hqUGd6WkREbUY0T2wr?=
 =?utf-8?B?R01FczZmcE5sMWVqSWhvQUV3VjU4SXVrSERPOUtTczhhZUxoKzJnd3JBTFNR?=
 =?utf-8?B?dWpHRjhsZmZlZVBSNVVDNFR0ellZeDcvc0hDbXhsSU1jS3QreWd0ZGgyQVFJ?=
 =?utf-8?B?YVNsTHZWVDNuSDFUQlEvcWZxbGhUSFhqdWVobzZjK1owUTdKV1lNS3JZUlor?=
 =?utf-8?B?NUdwcTRsYldDUmNEeUYzTm5vdUc2VmpsaVN6SFNqVGMzYktZV2VwVGJUcDNs?=
 =?utf-8?B?QVN1Q2lwd1kxcFZheEkrNWg2S213TEJLOWF0azh4ZmtBYnFTNERNa3ZUVy82?=
 =?utf-8?B?UGd5M2QwVCt1RFdjVEdaZzlXMWloN24xc2hEcmpXRnNsbHZpSW85UHBtbGZK?=
 =?utf-8?B?aVNIN2FydlFZQ2tWeHF1QTdGVEJCdVh3c3hZYlRiNERQNkxwRWJoVms2a0gz?=
 =?utf-8?B?OXZwQnI0VUxhZFJucTFMYkI1aHphanNsUFp1dFlSTW5wQXRDaUQ4dDRkdUtY?=
 =?utf-8?B?NDlnSGxybkl3Nk1IUGN3bEdScjdianVzQzIxWkdZZ09hRnlQWnczSk9Sakpr?=
 =?utf-8?B?UVZuS3hMbDFycFhWT0kzN1RGOWJkK3hJeDRIaTVKRzN4TGp4TS9XRXh4bE9D?=
 =?utf-8?B?OFRsemt1dmxzTlNpbHZVdmpNRHN2NVF0SVpiM0FFdTJqUWVEK0oxVDRNQkdw?=
 =?utf-8?B?bld3MmlYLzYwdmpMTzNLY2tXQTdHMTBiRUlXQ3hQZ1N4TXNYeXZJKzcvMjE1?=
 =?utf-8?B?N0hGVWp2NDJialN6SmVvZXVuNERDalB1TjhIc1I0eDFTVndKMkgwWjdqZ25p?=
 =?utf-8?B?cEo4NWtRTGxMTEpqd01RWG9zRmFiWks2STdMNkJSQU1iSUhkdkl1citINVVr?=
 =?utf-8?B?SmUzeVRUUnZSSzNrZFZqS2JqR3dreVgyRXgzajUyMmlLdjNNaDVBSXBwckov?=
 =?utf-8?B?eCtCUmJIWVNVa1Rwc1Nkak50dVY5YUNCbFdKZUtMbS93OVB6VXQ5dGR5Q0p5?=
 =?utf-8?B?RmoxRHRBT2lud2w3MmdNZkN6cUR1eU5XblRLUGZvWHBMa2ZPN1FQQWZuOVRv?=
 =?utf-8?B?R0JlOUtjQjU0NlY0UWtIeis2dDBraCtwQzFBUFVDMWNxZ0g3Qzlrek05UGtu?=
 =?utf-8?B?bkFYZGhiQmxrVXpJRDRmaHBLTit3ejc5OVlMK2lyaFcvVDJzaHQyNGk0TzlN?=
 =?utf-8?B?OTFaTUNCSHVFMHpZdHBJVDVvUmNpeSt3Z1kxeERnZGR5WjVPcDE5UT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d594868f-3c64-45f2-cb69-08da126f5b45
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 17:04:31.1129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nBi/WQ0dMMtkUPE4JtD8FOoVkk/UF9Hfe2GIOVtDr5fugpGcw1gyY+Qk3qCNLj6LAeJtyaUruDLH4O92sVMvAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5814
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-30_06:2022-03-29,2022-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203300084
X-Proofpoint-GUID: K8VBFcGWS5Uw9GfsQ4Vz2SSfdPUm9VbE
X-Proofpoint-ORIG-GUID: K8VBFcGWS5Uw9GfsQ4Vz2SSfdPUm9VbE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/22 14:55, David Hildenbrand wrote:
> On 29.03.22 22:42, Khalid Aziz wrote:
>> On 3/29/22 07:59, David Hildenbrand wrote:
>>> On 15.03.22 11:47, David Hildenbrand wrote:
>>>> In case arch_unmap_one() fails, we already did a swap_duplicate(). let's
>>>> undo that properly via swap_free().
>>>>
>>>> Fixes: ca827d55ebaa ("mm, swap: Add infrastructure for saving page metadata on swap")
>>>> Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>    mm/rmap.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>> index 6a1e8c7f6213..f825aeef61ca 100644
>>>> --- a/mm/rmap.c
>>>> +++ b/mm/rmap.c
>>>> @@ -1625,6 +1625,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>>>>    				break;
>>>>    			}
>>>>    			if (arch_unmap_one(mm, vma, address, pteval) < 0) {
>>>> +				swap_free(entry);
>>>>    				set_pte_at(mm, address, pvmw.pte, pteval);
>>>>    				ret = false;
>>>>    				page_vma_mapped_walk_done(&pvmw);
>>>
>>> Hi Khalid,
>>>
>>> I'm a bit confused about the semantics if arch_unmap_one(), I hope you can clarify.
>>>
>>>
>>> See patch #11 in this series, were we can fail unmapping after arch_unmap_one() succeeded. E.g.,
>>>
>>> @@ -1623,6 +1634,24 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>>>    				page_vma_mapped_walk_done(&pvmw);
>>>    				break;
>>>    			}
>>> +			if (anon_exclusive &&
>>> +			    page_try_share_anon_rmap(subpage)) {
>>> +				swap_free(entry);
>>> +				set_pte_at(mm, address, pvmw.pte, pteval);
>>> +				ret = false;
>>> +				page_vma_mapped_walk_done(&pvmw);
>>> +				break;
>>> +			}
>>> +			/*
>>> +			 * Note: We don't remember yet if the page was mapped
>>> +			 * exclusively in the swap entry, so swapin code has
>>> +			 * to re-determine that manually and might detect the
>>> +			 * page as possibly shared, for example, if there are
>>> +			 * other references on the page or if the page is under
>>> +			 * writeback. We made sure that there are no GUP pins
>>> +			 * on the page that would rely on it, so for GUP pins
>>> +			 * this is fine.
>>> +			 */
>>>    			if (list_empty(&mm->mmlist)) {
>>>    				spin_lock(&mmlist_lock);
>>>    				if (list_empty(&mm->mmlist))
>>>
>>>
>>> For now, I was under the impression that we don't have to undo anything after
>>> arch_unmap_one() succeeded, because we seem to not do anything for two
>>> cases below. But looking into arch_unmap_one() and how it allocates stuff I do
>>> wonder what we would actually want to do here -- I'd assume we'd want to
>>> trigger the del_tag_store() somehow?
>>
>> Hi David,
>>
> 
> Hi,
> 
> thanks for your fast reply.
> 
>> Currently once arch_unmap_one() completes successfully, we are at the point of no return for this pte. It will be
>> replaced by swap pte soon thereafter. Patch 11 adds another case where we may return without replacing current pte with
>> swap pte. For now could you resolve this by moving the above code block in patch 11 to before the call to
>> arch_unmap_one(). That still leaves open the issue having the flexibility of undoing what arch_unmap_one() does for some
>> other reason in future. That will require coming up with a properly architected way to do it.
> 
> I really want clearing PG_anon_exclusive be the last action, without
> eventually having to set it again and overcomplicating
> PG_anon_exclusive/rmap handling. Ideally, we'd have a "arch_remap_one()"
> that just reverts what arch_unmap_one() did.

Hi David,

arch_remap_one() sounds reasonable. Would you like to add that in your patch series, or would you like me to create a 
separate patch for adding this on top of your patch series?

> 
>>
>>>
>>> arch_unmap_one() calls adi_save_tags(), which allocates memory.
>>> adi_restore_tags()->del_tag_store() reverts that operation and ends up
>>> freeing memory conditionally; However, it's only
>>> called from arch_do_swap_page().
>>>
>>>
>>> Here is why I have to scratch my head:
>>>
>>> a) arch_do_swap_page() is only called from do_swap_page(). We don't do anything similar
>>> for mm/swapfile.c:unuse_pte(), aren't we missing something?
>>
>> My understanding of this code path maybe flawed, so do correct me if this does not sound right. unused_pte() is called
>> upon user turning off swap on a device. unused_pte() is called by unused_pte_range() which swaps the page back in from
>> swap device before calling unuse_pte(). Once the page is read back in from swap, ultimately access to the va for the
>> page will result in call to __handle_mm_fault() which in turn will call handle_pte_fault() to insert a new pte for this
>> mapping and handle_pte_fault() will call arch_do_swap_page() which will restore the tags.
> 
> unuse_pte() will replace a swap pte directly by a proper, present pte,
> just like do_swap_page() would. You won't end up in do_swap_page()
> anymore and arch_do_swap_page() won't be called, because there is no
> swap PTE anymore.
> 
>>
>>>
>>> b) try_to_migrate_one() does the arch_unmap_one(), but who will do the
>>> restore+free after migration succeeded or failed, aren't we missing something?
>>
>> try_to_migrate_one() replaces the current pte with a migration pte after calling arch_unmap_one(). This causes
>> __handle_mm_fault() to be called when a reference to the va covered by migration pte is made. This will in turn finally
>> result in a call to arch_do_swap_page() which restores the tags.
> 
> Migration PTEs are restore via mm/migrate.c:remove_migration_ptes().
> arch_do_swap_page() won't be called.
> 
> What you mention is if someone accesses the migration PTE while
> migration is active and the migration PTEs have not been removed yet.
> While we'll end up in do_swap_page(), we'll do a migration_entry_wait(),
> followed by an effective immediate "return 0;". arch_do_swap_page()
> won't get called.
> 
> 
> So in essence, I think this doesn't work as expected yet. In the best
> case we don't immediately free memory. In the worst case we lose the tags.
> 

I see what you mean. I can work on fixing these issues up.

Thanks,
Khalid
