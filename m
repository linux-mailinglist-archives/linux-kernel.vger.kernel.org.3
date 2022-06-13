Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156AA549DF0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238885AbiFMTpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345166AbiFMTox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:44:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B15E819B3;
        Mon, 13 Jun 2022 11:15:50 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25DHnVxs011671;
        Mon, 13 Jun 2022 18:15:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=fdn7dJv3XhTVHpoKycUIxvhJgnukWFM+fUkR5eY8oEI=;
 b=UdVrvPiJoDMyWstRAj2yW/iLNWvsL06tFL9PAtdh5k9gwV9tkn5nJku8YvwL5YzKedNc
 a5mTJSy5+6ZK/tdxqBaBLk+RDOpsTTtunpddpH7YMSU7eKK0hl0/2giDR6PgMGz34Y/o
 JeqL+q2H6V5f5AIZ8xeMqc9T2MaDD9DlH4jHWhFYBFGCxoPT5RFUsILRoxZPsyP/3PO3
 ruB7wT/eu4K1f4kueyaw3VQnrzKIb31B9vcRKuSfv6ZnDXgPhnMDRxTYhpct71UAgp30
 UdHrDiAjNUMD0nd6vADS4L56AvsewYr43imnfKwV20k4P5gHTvZUns/haSdXB4l62YFl jw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjx9bsks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 18:15:39 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25DI5nPV009798;
        Mon, 13 Jun 2022 18:15:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpa4t0c9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 18:15:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFydadU2PHRHOqlxxAdAyRBipAO96cwijtPkQpFCSfG3Xht2ra758YgobKf1CiRs9ET7hjkxYz8caYOb2l1EGguSKUFIqkv4sRUGY6ElDekLAPF6iL+XvuS6rYqnFceH7ovuMWaASq8cRwIOV+1vVoSFiK1N07UdWfnz/lweiFZSZjRnM5KeGtyy80yWBWy5V1fMqlaE/VjTmgT2i5XMlOlrqkSSmILPDX5qeD40jHfnWPkuKVoeL6EWJIL0zniztJsLAH14+rVbbBbGSzCOgMdGXzKv0r2SmgKfxfJln+7Gqf2b+F82yzUgK9ziy7+3rKWPujawnkHc8+0K9sxG/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdn7dJv3XhTVHpoKycUIxvhJgnukWFM+fUkR5eY8oEI=;
 b=ZNMG5HRgQ+uFIyN/UT7IPVKMtaUgi3GIp0p+aemw7KSBwQVEKQDWeyitV5hov7YXh0Bl+KPZUtgJ9ntGusddZkjhJO2K9Fu90Djkx1KMUHqGcHWg4KsBQPC9xCCU7KLSpG1oaq5HdOZwd8YAtsTG2fO8YglPWGAz5o6r9iZXjShbqP/GgtwEB4nygCJgG1lxOL6d1NebTRExEKYZ03DC3A2YEMEcUeczw2fEy5PhClkchx28nh3XRGHcMuFhcskW//qwfUutAPxfTyBjV2TKCPStUk+S/qZra9Pue3abh/fZl7c4YS2Iyi8kHIQap6GaKQtR+E3F92yKZoIy/WiElg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdn7dJv3XhTVHpoKycUIxvhJgnukWFM+fUkR5eY8oEI=;
 b=h5IKydJ3872NEOfk2bt7vQH7Cb0n3/hJLb+zUQFgv5NdHqXBt7onqFwBl3KdmFWMmqRGEIdGJd1E1e95tY91SBC5JiztcgEbH8P/h9irtzWxfatlYQaHbpu6Frn7vMa5KGT72K1X91GxTemgk+Y7fcOPOXi2wroYl2Nr4Xmo41s=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY4PR1001MB2310.namprd10.prod.outlook.com (2603:10b6:910:4a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.18; Mon, 13 Jun
 2022 18:15:35 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%8]) with mapi id 15.20.5332.022; Mon, 13 Jun 2022
 18:15:35 +0000
Date:   Mon, 13 Jun 2022 11:15:32 -0700
From:   Mike kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     david@redhat.com, akpm@linux-foundation.org, corbet@lwn.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 1/6] mm: hugetlb_vmemmap: delete
 hugetlb_optimize_vmemmap_enabled()
Message-ID: <Yqd+xI9KAG62+Lr+@monkey>
References: <20220613063512.17540-1-songmuchun@bytedance.com>
 <20220613063512.17540-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220613063512.17540-2-songmuchun@bytedance.com>
X-ClientProxiedBy: CO2PR18CA0050.namprd18.prod.outlook.com
 (2603:10b6:104:2::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f583f96-b879-4cfd-7a0b-08da4d68b5f5
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2310:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1001MB2310FEC65081DF49E47E7464E2AB9@CY4PR1001MB2310.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6PzdvS9BziAbd+otfydBVW4CcvR6uDrQBVE7T3rikgGz4EI8ExEJZfKuoaqveQivbxV9Bs1LOxmFiMhkkANxCqwNirHUMLw6ZnqQEmlbPWjwzeea71LNgiPcdmX49pv7RnNCfX3nVYMjAdojuQTDn3ksCuPJ1vezTh3dtWEr+17T2wtXHQ0bY8h+r+c6eEJKIZhE34+gDdmOoo5KpTgciSWVlZOQejsvYRcK4SNTfVopP45Pu6sgJe+THaQW4Sw+ZZgyuATlT1pSPqbsxeeD4QQ1pRpS0zFhcfo2e+559uLee1SudIoasj53Qz2oXyv4oQOpi39iJ40coAhmWUjy35w745MT72nvMlZvbkQP2md6b7k45l//Ck7PU4iuZum2HO20MUVvFpUWCU09jZWi0dLqEZCTPIeu7E06al6bGIDeHTwFdolBaVx0rYBFcWiq7UL9LXnX2F+BkkRx91UgUUkEGvT7eO7SL69h4iF2ya92LYna9DW1Tgdea2GLpnSUHhFmiM7JSiwtO6atxfG/sfH/PeNXZiSI77bt/wa0vMwr66qE+SiZ3ovfdSEr1X+j3LIrArq6Hzhihy/wbxnDhl5yIevu/MGlNPc+Q1xQjGjXwNOtymlbfXCM96dIYQuZkYpJrKj7zSkLcKb9r049TmCeYdm3bAH6BNTKNh5zlcRvjGt+ZoAOmMC83Jd6q3DTAvV22G53+3vvYSKO2RJcy858v2F+/sc71asn672ee8c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(186003)(5660300002)(7416002)(8676002)(66476007)(86362001)(4326008)(33716001)(83380400001)(66556008)(508600001)(66946007)(8936002)(6666004)(6506007)(54906003)(6916009)(38100700002)(9686003)(26005)(966005)(316002)(6512007)(2906002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0U1QXk0TE9DQldrVmliMTl2SmI0NzhMUVZkTEV1c0tuaC80SjdTMnVXRHlP?=
 =?utf-8?B?SlV1VDIyWUNVWm1iU1JraWE4WHgwcDZiYmdJU3N3RUJ5TmRKT1VWQW5DWitv?=
 =?utf-8?B?M243clJ2SjFUZEw5ZjJ5OE1KMXJDYVArcXJ1N1V2L0diYytDQ2VtWUcrTnFL?=
 =?utf-8?B?b1lyNnRmbUdJQkQxVitkR2hzRHk3NGhLaHkySytGRXBCaWVjck42cm1SUTBS?=
 =?utf-8?B?ODFVSEdyQ3JjM293UHp0bTlYTTNsMERQSGJRelVTSFhEUmVyVXFMdXNvY1NR?=
 =?utf-8?B?MHVvdzBVTnAwTDhXUWhTWVJSSFhIeEw0WkdxRzNOT1JFSzN5WXZMV0JTdWlX?=
 =?utf-8?B?OFhYb3prVXQ4VjMyWEJLbFpscnpFc0JJNXN3YlQvUUFKQXJPRi9KOUszSmYw?=
 =?utf-8?B?Y2IyVGpkUktTZWxuYVJjUk1MUzVHQUMyV2ZWT2Q5elZSNnBURVVGdU9FTDRP?=
 =?utf-8?B?K2xZZUE1dzZIL1dwMW1oai9YVEM4V2laNXh6OVlYU1UrUlYwWHRXcjJiUTNi?=
 =?utf-8?B?RGVaa0J3bkZlYUowdXVIbUY1aVFHYnZTd0ZEY2c3OWpYUlZkR1M1cHB4U3Nv?=
 =?utf-8?B?bTNaSE1Sb1RvblFYRVFkZjRtUWhlbUxRRUhGdWh3L0JDRGN2SDEvTS9kMmF0?=
 =?utf-8?B?MHRybXlBTlNCSnlOYTY2WTNXYThLaHg5L2NEUWViQ3czdjFEazV0WWhXeW42?=
 =?utf-8?B?bDZiSWRtOHhUTC8yZVE5NjlYSVFPUHJTaURZbG50ZFFDODVPcjd1YXZWZjJv?=
 =?utf-8?B?REQ3WS81eTlYQ2dFQ1dHcmVJcXhqY2pmL0ZDeWlpUEFIWE1OSDRCZjM0alBX?=
 =?utf-8?B?OGRKRlE2eEtkQ3hjUFZYQk5ZRnIrOWpDQ0NDT0hmMWhvcGhWSFV4OUtqS09D?=
 =?utf-8?B?VUlON1VSdDQ5N3VBd3Z4MVRJTUJ4d0g3Um5IaHl6QTNGd2R5VG9QZEFVQm40?=
 =?utf-8?B?RjM4cHl1NklhNGVWbUh6NmtMTlNsRlFWeGdIV3didURtWSthRW1vdEtVTmFB?=
 =?utf-8?B?ZlpBNzdFczYrbTJ4ck9CeFlSYVlJeDRXTEJncDhUNlNuMDFkNlJha0hNeTdE?=
 =?utf-8?B?SUtOVnF4Q1c3K01JSGpuZ2o4STVObFV6eDcra2g4UnFLUktJNnc4ekYyOE5i?=
 =?utf-8?B?WGpJMzNld0lJU24yUHQyT0UwRkZKZUMyTmxpenZxeDVzd1BSai9KK1N0eHhR?=
 =?utf-8?B?NXMrUFIrUWVqcHQyOUsrK1UyNjJrY0VoaUx1Qkd6R2EzOVF3MWNXWnRYRURu?=
 =?utf-8?B?VFJaMThEQXNodXhwcFhXNEV2Vzl1ZVQ5SkRQL0V2a1AyeVMydTd1V2RmaTZ3?=
 =?utf-8?B?b3MvQnhCN3h3V2tIeTJSZnlmcFJmQzVvSmcrcFBPQWE1ekJQT05oQVUwaW9Z?=
 =?utf-8?B?TnUvTk4yQ3p4d2pSeFNlZzV3STdsdUtpYS8yaTF5VldIVklTRG9PNEZNSkc3?=
 =?utf-8?B?cTU0d0FVdmlOblRSMjI5MWo2UnVuc2lTNzFITndwSmMzRm40VjgzTlVGNlY3?=
 =?utf-8?B?NUUwRUVXeEpwYmJTdFdCZy9EWXl3QUpIaitHNkN5Q3pCOCt0NkFrSlVWQnFn?=
 =?utf-8?B?eGl6YWdUa2ZwcjVRelZEOEpnTnVHWllZNlVFOFpHSDA1SnRTRUhyUzg0c2g2?=
 =?utf-8?B?YUlpVkNmdGRHSG10bklOanlkZGkwdHRlb3JVNEt3blhJcjdnVjl0ZFY4TUtk?=
 =?utf-8?B?QjNvRENqbTYzMW9YU2JLcDNpNTV5Vjh3V1QxUS90aStscGFvRlFBenVkQklS?=
 =?utf-8?B?cldlRFBMZE1aWEl1aDdQalZmZ2QwTnpKWHRrWEtmNkEyanIwR0luWFhCM2ta?=
 =?utf-8?B?L2prZEJrSWo2OVlCVlVqS0dCb0lIa3dUZHQxVzNMRm9BNXF3OU5VOGZtOGE1?=
 =?utf-8?B?OS82eTJxT2lqbDVGRWxQc09wSEZJbENicnNZNUE0c1JEd2daRXpZYTNWcSt4?=
 =?utf-8?B?RS8rRXBRU21jeFNDL1Y0RkY5Q3VKYW9mWGdtam1VMWZXWGo4RlpZYWkzR3lN?=
 =?utf-8?B?R1FYYmlKR09ydjNnS0hvOCtsU1hYVjJ0d0VjOHJ3SE9XdnM5ZWVqWlFKTnds?=
 =?utf-8?B?WDZ5RVl5V0lROUh1RXB1U09ubjJOZWYyVEhlWE52bWZEZUZlR3VuMkVRQjlL?=
 =?utf-8?B?Q2pJd0dDUlp2eGExV3hqQjQ2RGNZdENQZzdxTzVYSWVTUDJDOUdSNURGQTRR?=
 =?utf-8?B?eWFCQmFGdEFXMGRuVUJWVVBqbUFHZHRZTnJFdVVEeU1nKy82YVpnQ3FZN1o1?=
 =?utf-8?B?ZytHL29pZC9mY2llbE9KakpkUERSZVlRL2JRWkdpU21pWUlsRDE1WjZ4aGph?=
 =?utf-8?B?MEpQaGE5Q1pyMC84ejlGWjFOTEYvYUVrZkV4N2N0amQ1elM2TFhOL3MwMmVq?=
 =?utf-8?Q?WHJLYArQfWPQdJv0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f583f96-b879-4cfd-7a0b-08da4d68b5f5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 18:15:35.2453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LkyhhCBzHuweWrYZvhZdCxNiMQMdqeflwrfcG757fXSkOVyd814ea5FgoICG9msCNsKv78jhoiyExTPXKWm/gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2310
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-13_07:2022-06-13,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=692 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206130077
X-Proofpoint-ORIG-GUID: MRNuWiFeH3Jrc0ZS0cmi2Vp0DKecqx8e
X-Proofpoint-GUID: MRNuWiFeH3Jrc0ZS0cmi2Vp0DKecqx8e
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 02:35:07PM +0800”, Muchun Song wrote:
> The name hugetlb_optimize_vmemmap_enabled() a bit confusing as it tests
> two conditions (enabled and pages in use).  Instead of coming up to
> an appropriate name, we could just delete it.  There is already a
> discussion about deleting it in thread [1].
> 
> There is only one user of hugetlb_optimize_vmemmap_enabled() outside of
> hugetlb_vmemmap, that is flush_dcache_page() in arch/arm64/mm/flush.c.
> However, it does not need to call hugetlb_optimize_vmemmap_enabled()
> in flush_dcache_page() since HugeTLB pages are always fully mapped and
> only head page will be set PG_dcache_clean meaning only head page's flag
> may need to be cleared (see commit cf5a501d985b).  So it is easy to
> remove hugetlb_optimize_vmemmap_enabled().
> 
> Link: https://lore.kernel.org/all/c77c61c8-8a5a-87e8-db89-d04d8aaab4cc@oracle.com/ [1]
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/mm/flush.c      | 13 +++----------
>  include/linux/page-flags.h | 14 ++------------
>  2 files changed, 5 insertions(+), 22 deletions(-)

Thanks.  I think this makes the code less confusing.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
