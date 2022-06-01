Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47267539A55
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 02:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348615AbiFAAV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 20:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235844AbiFAAVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 20:21:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5213422B0D
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 17:21:53 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24VNxEUd018461;
        Wed, 1 Jun 2022 00:21:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=S5aFB8pK1q4/tQGCS1voDodiNiEO0Ya85/YBR4aoY/E=;
 b=otzKxhMWeRPJJKWaRYj38Rlbn2WQKzvtHZx5YdTf63OwDOfTd64AamcNFQwwiitQhXws
 ju+MLxzx+q3jwMuvp5tBmZ4onXm/NbDFBWg7v1OHPLmZDtWZCLtfkw/TyBAZhGLwPi29
 BtpPpAh6HwYaHCYrMN5N5xkSuaen2jCWql+6SZZKVzrnEJ13ry1PTAIAm4OerfPnMQIa
 POQkf4Xtl6UOF/oa6XKEKc/PCHy6uZNX/ScQ9B+QbWiD7wOQWW1y0HyB2o8iLefZXfS/
 L7CTUE9ECeUSgY9N308wiD0AuidnR3Dl1aoyZZ2kviVcgPuh3SYoQd0XGof/8dMKeA0T vQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbc7kpaac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Jun 2022 00:21:50 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25100Tai015499;
        Wed, 1 Jun 2022 00:01:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gc8hw6pnu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Jun 2022 00:01:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QeJrjP+kOkqoOokM9c7shH0p/8NUyMFEbcsCulRqIu9ZpNUv1aHrnHgpTIx+CLoYj4VY24HzOwgrik5nzb/g9dorORnyv91/UBbNtpoyaLjwcSp0O2BAti3BUtXz/sS9d3YmK7RqmGgdnmx6XCG+2lS56vHd6VGwoUc/OPOhXZ5dz63F2AAOB8eTe7qcl3MgYawDdBgrsAMVcSf5o+/zzjtVqZftg5wXNFS4Nes+gWtuuatldx/iX1d1SONinfjZNAOG6xAiopwXrngHoXwuN+SO2ATETIDK6ruFaJSTd+A+nLG+lEdjdi6sV+oKWvtZ4+QYDxmTc0DL7WchIxCa4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5aFB8pK1q4/tQGCS1voDodiNiEO0Ya85/YBR4aoY/E=;
 b=HCVf6uhP7aCOAgSeaVCjpUiuW4mv6EY42pcQf6weGxlwt5YBoaq5lqZF/FB+vlErldEWCl31wF/M45y2z2xBBKoy1o3riH9ixZoaSvcrms5yZNWuXn/pxCO7cbfMYMxxUUKxzVI5TZ8vzdLN3Df9/gKmHfgvOjyV2xOcLRyTVQesO0JJ19/Rgs1FawwmRE/mGG8WfUegsxQqAyakOR/depXwZIqTqGUjmEWzkplVvPzaTVfzhUesAoMOpB3a8KCcfVdJgJXIhG5Ww1VuJ8WT45VHqfzHozvgRSkdd3Q+VgK7hyBoEBKLZbgRBGsFb7p1AoddA/7x4UM5RQ2ZNGZysg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5aFB8pK1q4/tQGCS1voDodiNiEO0Ya85/YBR4aoY/E=;
 b=Cr6I1mKDZhNtCFtKrGsKp0Y3HxSLIlPHncP+PSxAwnUHhIy2B1Hhi11Peee+qxbmMz8BMIH2N5Ry8/NqhdIsmh9LMqil57vppRspM3/CsfkrQ+jm7IgtdUQ9yyFwf+7Qq2ZAAEnwgNIMitL8P12osz1YtCRi2yC8ZS8POmGj4+4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS0PR10MB6246.namprd10.prod.outlook.com (2603:10b6:8:d2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 1 Jun
 2022 00:01:38 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%9]) with mapi id 15.20.5314.012; Wed, 1 Jun 2022
 00:01:38 +0000
Message-ID: <27ea9c9e-cd1b-c92f-5fe5-ccb778d90f95@oracle.com>
Date:   Tue, 31 May 2022 17:01:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/3] mm: hugetlb_vmemmap: cleanup
 hugetlb_free_vmemmap_enabled*
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        david@redhat.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        smuchun@bytedance.com
References: <20220404074652.68024-1-songmuchun@bytedance.com>
 <20220404074652.68024-3-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220404074652.68024-3-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:303:2b::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6693b871-abca-40a3-8fdf-08da4361e636
X-MS-TrafficTypeDiagnostic: DS0PR10MB6246:EE_
X-Microsoft-Antispam-PRVS: <DS0PR10MB6246105B3439EDA99976980CE2DF9@DS0PR10MB6246.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t8KRtT4Sa8jfoVzQkYnBRf/uHbSAMGMW7fK13bKzSpBEzz/ZnJcbq58IrEL24C+7EECgMXz2JA81AAGWWqThLRFvd/jGoKUQvvFvzXFY52B/FDzg6DazpTrFL17thP78wS+GiyX3xTfoIWe/m7AZ96LAWbXSWDT4Ru5wro9gw5TD3t76XFcXOYeF6lE8RmwLUPRg6n/sWyCMDPo7p9flcRiIbZ8QbK4KrcD1sKxFVkiCTGIvKJpmNTugwEGy7ZyD42iGboSIBJONy8Q6EKHkjcuV90OHjAmTZOrCKiDn7gZW/pn46RMQ57tZQ+P1HEH3peKRb9N/9CpIaa8IcnYf4GFnnxCvVv3MTUMPXB5s/bjPNRAXpRb8G233eQWBELS0LtHzc1y+CnB97gayNk/41IfWQ5Z6yBMHlxhTOJwUkdrxZAqHpkryP7ItV0lM5pGsYR7eXVJMiYLh5uUlK2rKU7nvR2KhCuIaWXsrIAe3gqrz9UgB9vK2rbJX4g69ov1Quw3gzzXriX4XNG7hkNJWlpLQj/g5aYk4RtQCECRBoviuf9FIA5tbyqLdNvf9kzZ3KbLO6hAaz28DFdYRURKQdVQh+CiWzQ1x/59PIl2VGTOVPxj6Tu6nBb4HypjNmPxWIGK6l3tSJb1ppoLdE7leenebjuLM7H1pR2t73Drtp+Nmn2S8eLIBKCr59gE7Lcjy3tDcUGxjbgium/Umk6HRoWpFo13nXctSX325WQMYpFZydWMiaIJrn8tdNbkgJjSDJxsuPc74pXdtvOMoPslc/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66556008)(66476007)(4326008)(52116002)(8676002)(53546011)(2906002)(44832011)(2616005)(6512007)(26005)(6506007)(38350700002)(38100700002)(186003)(31696002)(36756003)(31686004)(508600001)(5660300002)(6486002)(4744005)(8936002)(86362001)(316002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YU9INU5qNnhYUVBWbXhHMGt1eUZVVC9xazAvaVB3Rkl4aWd6aTZFa3VpN0NU?=
 =?utf-8?B?WXlKa1lQbGZpMFdWQ3JYQWVXVWFqZURPbWpvUVJ3STAyaVVmZHZLbkdWSHRJ?=
 =?utf-8?B?RUpxN2M1SmZGMUE1Q0lkdUZtbytseE9BalBFK3QwSERUdlBHbWFTbWNZY1FH?=
 =?utf-8?B?Y0g4U0hoV3RXUTM5S2pSa2UxNmlZMUMzdGxabGpiVC9Zb3pIaXhQSmpYaHcz?=
 =?utf-8?B?SXR6RFpoRkNkcXdrOEt4VTFCV0lJUy9KNnBJbTlobTJKcU45SVJPL3pZTWEw?=
 =?utf-8?B?NlE0aE9aOGVlS0FlbHJzWnRoYWtMSnJNZXZjbW8vd3VEU0JMYzJzYUg5ekJj?=
 =?utf-8?B?dStqb1FaVFVqbGx2TVY5cVVNZlZDRFoxSXNvSVJuRVJHUlRxYTdVOVV2dDNH?=
 =?utf-8?B?VnFHZllWWXVvQytpL2dvcmRWcXBmNUFTODQvc2hBWi9hMmZPZHRqZFJRREJR?=
 =?utf-8?B?RzA5aFUyQ2NGYUs0MEJDVW9rOFpmdUhFaGJuSklDVG4xTEVYc0YxQjNWOERx?=
 =?utf-8?B?MnRpZ3Z4L0Nnb0MzVlNodm03QWl1YWlkb1U0c2RLQjkrWHhvVmgyd0JOVzhB?=
 =?utf-8?B?Y3J4YnViWWtGUHBqQUJBQ3NrTWEwMWlpRlZOdjhuTzRNV1RBU29ZM3JPc1Fr?=
 =?utf-8?B?OTY3UlRCUm9FWWFObWRkMmRNaTd2dTYwZG9MTWtmMThqcWZxbXJFQVdMR3RL?=
 =?utf-8?B?a1NybVFXNm8yVGZGU3pubmozZnViTXQxZEhsdWYwVDZtdllzc2Foem9XSnFX?=
 =?utf-8?B?ZjkwZmtjMkVsM09EZGJpQStBWmtaL1N4dTExQ0hLZnFGSVdHbGh6TDNudFh4?=
 =?utf-8?B?bDQ0R3A2eXczTmlEaWFqbDBIWGRKYjB2cWRhVGpXaEl3Y2hpZmZoRGhpZlVJ?=
 =?utf-8?B?NnZ3dHpBWWFNOVp2MzBKZyt4M1BMYlFWWXRFUVNnRjRSdjFYU1N3Z2JhdlFW?=
 =?utf-8?B?ZHRnVnJCR2pML1pKcjZNMVlvMUlkL3Zub1N4aHpYWVhGMFlHMUdOa3BJQ2xL?=
 =?utf-8?B?eExOUm5UMFVtZWV4S3FXRUU1OUF2U2VnS25VWGFhbWY5ckRWTE1OM09DdEVY?=
 =?utf-8?B?b0NIbWVRZEliaUJTSW05ekdPd2ZMejdqZlo2dVRmRG1nSHYwRGx2Qm4wN2Zm?=
 =?utf-8?B?eE5hRG5CY1Z6V3F5SUpJNVRVL0Mydkh3V2x2UytzSDNOSEZMMWsvTlpuQXdw?=
 =?utf-8?B?U29qc2hNOTIyVVdtWWU0Q0FGQ0gzQ0MwNzBGc1lPNVFKam10VStCRkNjZG5L?=
 =?utf-8?B?MGVUOGxuNFM0a3JEclQzY1JlYjN2Y09zTVZlcTloRWduMjgwSG1RRnpINmYr?=
 =?utf-8?B?RUdBU3RDRHVGZG0rTXZoWEZsZnFYTWxreTdxbVFFMm5pRElJMFJ6K01HVUhu?=
 =?utf-8?B?bzhONzhsdTI3TG91bTc0M21BMnNtQ3NLZXIwUDhLVHg0VlppNmNCUUkxREJR?=
 =?utf-8?B?NExVT3ovb0JWQUxwTHYvdXRUbHlUTk9aNVJEc2ZLTkk1YVV1UlNqQmNmSU13?=
 =?utf-8?B?VEFkU2RUeWFLZDJQUzVQY3IwRDlsMm14UjhucitramxHa1BSRXFCMi9wRUpP?=
 =?utf-8?B?UzFQTnkvZmJac1pSOUFTWit0eG1rSjM4NUtia29udWZmVnRWOU9CalNmWW5p?=
 =?utf-8?B?N3dJV1A3Mll5ajNRZHk3a2xycDZReXIycDlPRTE2UWZpRW45R0ZScEpWV01N?=
 =?utf-8?B?dUNickFVMEs3R1RhWjQrdmtNYU15UjRSWFNoajRvMUoxNmpIQVdjTFR2RkZC?=
 =?utf-8?B?NmxrLytwR2JGRlFERjVXaW5MdDQrRVJLdkFZVzFJYnNHQmx6T2ZPVWs4NUZq?=
 =?utf-8?B?L2o1R2JhZU45S0Z2S2h6Z1Q5cm5hZnJ4ajQrTE1ia2dXWUtoclpkS0xOenRQ?=
 =?utf-8?B?aUV2WjlCSk1uTTZjM3ZNVEI3L2V5WDkxak1ER3JtTzUxZW5CZmNpUHY0RHBM?=
 =?utf-8?B?cHpHR1M3UmhWazJmTFZyNFFQdjAwcVcrRFBsbFdGRE9sVFR3bzNPOHVvaldo?=
 =?utf-8?B?ZGdXUzIwQmZkUXdPSVROK1NnUG5QQ3ROVkNYdmlSZStzS0VZNm55T2srS1Bw?=
 =?utf-8?B?dXkxeTlqTGR0cExPUXlEWU8raTZLRGJWU3g3bGJESFBrMzBqOEFEbDJCQy9R?=
 =?utf-8?B?R2VFVEVIaGVvRHMwUFBsNDErazhkR1gzMzB6cHE5a1FpK0hJTmtHV2xpZ1pL?=
 =?utf-8?B?ODl1aFhYNEhhUHBrSlVpcXl0NXo5TE9RQVdDcGk3RWlQdGxiR21CdlN6S0RJ?=
 =?utf-8?B?MkViUFdEQS9wM0FCR2VwU3JqWHZRQ0hxSjBGVW9xUDNKelpFZFBRNHl6dGpW?=
 =?utf-8?B?R2F0Z0haY3hkeVcxRlR5SWZ4QnppMlpqeTkzOGd0VDhQekN4cXpDTWJycndQ?=
 =?utf-8?Q?TtYRtjha67vQHVds=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6693b871-abca-40a3-8fdf-08da4361e636
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 00:01:38.0507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /+1yhclOyFwdRN3pPuDtH/zartF817zpG/Gc3jPIVjOG2MpBhHrU44hDbdiXiAJNShKZIeqIf/nXYdsqXpa6Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6246
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-05-31_08:2022-05-30,2022-05-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=948 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205310104
X-Proofpoint-GUID: rCP_7MDxAlJqfZKbwnbvGeNFUlQ5sHG-
X-Proofpoint-ORIG-GUID: rCP_7MDxAlJqfZKbwnbvGeNFUlQ5sHG-
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/22 00:46, Muchun Song wrote:
> The word of "free" is not expressive enough to express the feature of optimizing
> vmemmap pages associated with each HugeTLB, rename this keywork to "optimeze".
> In this patch , cheanup the static key and hugetlb_free_vmemmap_enabled() to make
> code more expressive.

Commit message might look better as:

The keyword "free" is not expressive enough to describe the feature of
optimizing vmemmap pages associated with each HugeTLB page.  Rename the
keyword to "optimize".

Rename the static key and hugetlb_free_vmemmap_enabled() to make the code
more expressive.

> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  arch/arm64/mm/flush.c      |  2 +-
>  include/linux/page-flags.h | 12 ++++++------
>  mm/hugetlb_vmemmap.c       | 10 +++++-----
>  mm/memory_hotplug.c        |  2 +-
>  4 files changed, 13 insertions(+), 13 deletions(-)

Code changes look fine,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
