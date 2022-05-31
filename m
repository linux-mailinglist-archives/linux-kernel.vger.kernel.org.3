Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D363539A34
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 01:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348738AbiEaXrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 19:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238559AbiEaXrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 19:47:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA93B427CA
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 16:47:47 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24VL0CVH018888;
        Tue, 31 May 2022 23:47:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=lbVao1JCBBKYN8zmWY2H54vkRsxRxDfC/fACEIZ0Vbk=;
 b=wnTYOMkZKWw9c8JrJoFRnsoi1KcbTMjw/30LNM36PJrdgrGhvO+4Gf4I49V2OZE6liO+
 uXJfc+vCWUUYDXH4sgAcx0vyUh7piPfl/FoDTOd84ibDIJuUHdSltaU1Eg1/3Y8fxYIs
 lYt9TDpI5DsHrRy54YyzJ5ixMrKuU7b/EYNKmqFe6lnaw5TsoZg5ICfprEy+vPTbD4vl
 5/8shID3Kemymk/K9IcJfCcsincgIuAahcS11KL8W+DpfIL3NGQBP3rQv0ntqOF8X+mx
 i/oxKnAxgzToVnCnE0vpt1iMHgr6mU5g8WlW6lIzCNuQlHzndFB9Zo2az0KgHWud4JYf pg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbc4xpfu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 23:47:44 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24VNk7Co036067;
        Tue, 31 May 2022 23:47:43 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gc8kg634s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 23:47:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjmN5AU9oDTq4x+8f5xPi40EPgbQe/53XhjJCUGmm1sqJYyLOoDpbpFTc1/flNpbA4MQVdPeGzapy2OzMnnmDChUOWPDWKcx14ohMtJ0D9ocZ9/ItX0kB7A8bj5C1lwimcJTv2QxTIArNaFgiY1vBmx0jpg6LW3+Fka+/hB2nHfBJJNoxt+YlAHN+VTZkOTNrhIDd9Gqna/bvE7hP7dU9oNU1/Ye9xv5s8G5I4LzosIYT1VRbZ6O8iZMof9Em9xDrKmXN1AFo4mUHR0cBYRBzWX0ORwnj9CQ/XTT1MsOiIEwgNE6n/EhKz/iQFdTYwNI1oAptSaGTp7tt3ruumC1sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbVao1JCBBKYN8zmWY2H54vkRsxRxDfC/fACEIZ0Vbk=;
 b=ctyds2OYm13wb/4K5a4n549APNvKd3wfuvessVHnblpACk62spwVS5cPHGDlFc1514vlQs4OESprr9KQuxhKlGpsSj8ABzPEA0wg3lFGV0VURHb9otduDi4savuJ+//v17OThEZeyD/83qDTCLu7Lo+9yiPcV9FTBJ7DW6IaX3WWGsUZBBEtjpcncOhRiWPq9Sufe3eAnNN0Nfm68Z32QHWUEfaBgeS4C1Re4Exnv7n6K1wb6LJfKDNUbkB+9uUHTTh5O9Va0QXcTvf9oXYQkVwZ+ugJ2InRKiKST0tAdPQlrETrdKkUGWkZeTiYT5aJtwErQv2U5WAXxAwPj9XHJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbVao1JCBBKYN8zmWY2H54vkRsxRxDfC/fACEIZ0Vbk=;
 b=DjSlon0v1RDaGClywHPjKpjLaCCd8kBG/8ADhsWBXk+Eqsl11R15t6gaLxRIANCsRRQgaxrlVAnEEa4TStzInh0xSRJAEqjE1x7WD35FGWsB8fVVYKaGpWjZlNigG7ER5FpV5KIpHa8VyPsZ+M/99MDmQAhOYVhvyjKHJ/273y8=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM6PR10MB4058.namprd10.prod.outlook.com (2603:10b6:5:1d6::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 31 May
 2022 23:47:42 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%9]) with mapi id 15.20.5314.012; Tue, 31 May 2022
 23:47:41 +0000
Message-ID: <ec5eefa2-03f7-5f2e-bd99-24c3ab76a0b4@oracle.com>
Date:   Tue, 31 May 2022 16:47:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/3] mm: hugetlb_vmemmap: cleanup hugetlb_vmemmap related
 functions
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        david@redhat.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        smuchun@bytedance.com
References: <20220404074652.68024-1-songmuchun@bytedance.com>
 <20220404074652.68024-2-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220404074652.68024-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR04CA0081.namprd04.prod.outlook.com
 (2603:10b6:102:1::49) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9927ea13-5152-4736-9deb-08da435ff3b5
X-MS-TrafficTypeDiagnostic: DM6PR10MB4058:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB405869B2FE5FA438DE769897E2DC9@DM6PR10MB4058.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l678wIE6Q6DaJERt8KclpwbGyG/KVa8cg+7X2pTf7uxwRhpfBYicogXbZfliqNPRMFVl2DFnEKu7pGtR7dRr0ficpJOrIPAb+PvSJBg88vdnVmi/bR1rrtnZe8SHpXkNBB/2pIG/mAv3t83HnMXo0u/nhjH1Vcq9Lu6K7DXAsUAzLcCqC+9ZZkfiuQF4UTNVlIbuiy6zch7rBbOjrCSlmwScoWRnUFy2yfDV2P0bUievM669vbqmvHj/w4MncGqcwpdxDV9nDTV1fITrwo2wyOSvyB8vzE6mAmbdCPQAK3vdAGW6SeMyo9V85zVE/IVc9l9AT094bQqEbh5mA5BXQBFhutRoKBnGiuSTzsfRbXBJLSmf+tBRPprrjfopLTbf0hfAd3lnaKPTYX51vl6jeXBhMfF451DLIPFcCqd6Q00gpc9OBLTYxAqxP5ByWB/5btETxrQgaG0vjwsYV74YvZG33uLaCwAC2GwwRC5HUAWH948yoVJ9f27x1cpjxEK9uDyKnHXZAjoQgsKIGKNIBAKRTpmZ2BvluHAJFzwGercUmyrECRUqj+IM3NN0WORe0TLSv0YvRDsALS+765scIaPL2w1DQElG46GWPIY3CCEtN7050XVJ/im3yV/7RqR1Tz8zb/22ZoMufyVl5dCZqOHfsQzDh1cDpesIV4WyapIc5W6gY0hPvFh+A7q2+Uqz6OlN9eRTysAvmQ1FPcMdnKnl2lbdCcGq2flk8F3G6dQtQ5MeXBLueMBgIEMh6C8DlteW/638HQpq3z63/QAcfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(2906002)(6486002)(316002)(38350700002)(8676002)(83380400001)(53546011)(508600001)(31686004)(44832011)(8936002)(26005)(5660300002)(31696002)(66556008)(86362001)(66946007)(66476007)(36756003)(6506007)(38100700002)(52116002)(2616005)(186003)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUd3eDJweVhIM00xbEdPV1RzaUF1dWxINFNLd3pWbDVBdlF6eWk4M1hKN21K?=
 =?utf-8?B?U0wvdnFaNko3L3RGbEVwYTd6b0ppWURla3FuMG96SktlVUh1K3lHRlR0RFlH?=
 =?utf-8?B?OGI2dG92RFA5ZTFjTHlGQnBhREsyaXVHbHI0eGdJRTRCV25LMG9GQklYUUNG?=
 =?utf-8?B?Z09xUmswVzk5V3lwVDhQbGR3c1FPQ2ZVWGs1TEZGdDNFdmVQWnJBTGs1R3M5?=
 =?utf-8?B?V0h5dStWZmFiZCtYcWVGZ1JYc0M2NHo3WThiWXdsdVVoVXFUbUVKZzU4OUR5?=
 =?utf-8?B?UWtGL3NWc1ZTbit2M1NmTGxlQWlnNUpNbjlxdnpQVnFPVlBVVVR6RnlUR3JF?=
 =?utf-8?B?YUhnZnpuZFl2ZFVjMkFJWlQvWGdUcW1wMWFodlBZNHRnUUpoY2JZcFQ3aHp4?=
 =?utf-8?B?dUV0QzkyNjByL1lYRllmenk0aUhJL21ucSs3TVNlVXlQcXp0QXRRdUMvbEQ4?=
 =?utf-8?B?WFp4YW5OSVN6WVYydi81cTdPT0xnNGpYdEhMVlZnMm04UWd3eHV2ZWxBbk1I?=
 =?utf-8?B?czdhQ251aXFMWi9HMHdPWDUxbmRBWm84dWNqZmVQSXU0akVZZDZrZkhtMEJi?=
 =?utf-8?B?SFNnUWZqY3hMNDgrcjlGQ1V5Z1VkeDFTV2I4d082OS81S2ZXVHJESVR3bWlG?=
 =?utf-8?B?elZDdlhvaFhhMTZMUE8yY0doTzJQcXovMmdGODg1SmFaY0hBM3VJNGlPdUlX?=
 =?utf-8?B?NTFxajdWUERxTHJaRFFIV2NmUnU2dEVubzBma3VxMHc0V3lOT2IrZFpKZ0N0?=
 =?utf-8?B?eXF3RjFQSUNDZ2lKTmxlMy9oelZ6cTU1NnRXNjBQZ0h1dTBnMUV1N3FRbXpi?=
 =?utf-8?B?UXZXS1hHSXJaVEphekpVLzZ0MDRkMlk4VVJvK3lFWUdqb01saGFua3pHbW92?=
 =?utf-8?B?MHlRaE02NWlHTTR5aXRwQ2V4UkdIN1I2a0F2ai8yZ3Q2cnpGTGk0OVZzajJw?=
 =?utf-8?B?dkJVTy9Zb2t4SXZZQ1dYMTMzL3hHbWdhMHZHdWlGOW12YU9Lai9HZi9IeUth?=
 =?utf-8?B?blM3VmhGZTU2QW1Qb3J4RElCbUFqQzNwR2RQcDB0YUV6TWcvMFRrRC9qaGk5?=
 =?utf-8?B?dHltcm52aGh2eCtJTzZwT1k5aGhYdUZGeXl1ek83THB3SkZjcEFKSEFOVDhk?=
 =?utf-8?B?TXE5UWFRWmRqZjkrSHdwWFl1TE54UW9lSjlUaElOczVlc2lzZ3ZYQVRmWjlS?=
 =?utf-8?B?UGIwRVIzWFlJNThpUW9SVFphU3dwYXVKK0VQTzN1WG1HbGJnUGFteEhmeU1T?=
 =?utf-8?B?RHN0WHNpYjZJYTk2aXJrNUpUQ3dBSUhyT2FPaEdhWitpZnpUenplRC84ZzJi?=
 =?utf-8?B?R1YzQUFqTWRjOUJ3SkVqT0xjVGYybkZEZkNiTEgyQnZMcUozeFF1QUI0SGpW?=
 =?utf-8?B?RDJDWHdRZmVXMEgvRWhBUzB2VHErSzF4aDMxTDhZUThhaUUxaGtaTXZnMGpu?=
 =?utf-8?B?azJXY2RjY0kvN0ZFbVVwd2VBZmVXaVI1THVPa1dIaEFXbEtuQWFyM0tKK0lK?=
 =?utf-8?B?bkRRMDFjdFlleW9sNnhUNmN3SVU3enhHVm96bllQeHF2SkM2aWt0Rmd4V25m?=
 =?utf-8?B?WVMxTm1oVTdsdWdMR3Yzb2hPTVd2NDhIZHRtWXlCZDY3RjlBWGVkeU5vMGEz?=
 =?utf-8?B?WnA0SGpvWVRkOGpTeGVlUU1OMEREb2M0UEgrelBTNnlqY0J5cGxVVW5NQ0pq?=
 =?utf-8?B?WThUR3krSWZiWU54S2tmNFBBMnVBTVo4bjVTTmlneXFOLzRnWTFLSkdpQ1Ni?=
 =?utf-8?B?SEVhRWlvR0NYN2MzVFIvWnBXN3d1cmdybGR1OWQ0MTJ1dkhvNEQreXF1dnY3?=
 =?utf-8?B?bXNOR20ydjEyNzZ0NmVsaE4yMlk3dWJpb2tjVndheHVDTVgzdzM2RGtRSVlw?=
 =?utf-8?B?bnBTL2g1VWNrcVFERDdwV1RMbUwrWGdkUFlnZDE2UnF2MzF0bVRPQm4vcnpm?=
 =?utf-8?B?bzhyTXpPd2JCNGdhUmM3NFFOLzhsSUpFNHNYR3RUNnlHMnhZbU1OS2JDUjNy?=
 =?utf-8?B?SVJLUzNZUFF0T2FBalM0cVZyRFpBcFkybmJzQVJJRkkvQ3E4ZmpkK0MyNkJj?=
 =?utf-8?B?MTVOWDNXa3dUSDVHL0xVZXJEOWxsWkJoM2tTUDYrV2pTTjhpSk1sdksxcFUy?=
 =?utf-8?B?eGtiVkoxRmdrNEFlc1VGeVprK09lT0JjQlFONk9GQ3krQTBiaThpcHh5d1pG?=
 =?utf-8?B?cnUwdzN6bm1mVm1DdmlCWnN5RXlRMWVVek1lYitBNkdaV3FnTXZyVmtNUmxx?=
 =?utf-8?B?ZHcrR1RpSzVsaFpuZk1ZSVQ0M2lOQ3VBcUx0RnphTjdrRnc3MkpHSHE0U21B?=
 =?utf-8?B?U1BlV3RvdjBHbVM4a3lzUDBpbHhvT1laQmhnaExodHBvTUVVZEN0SnRNSVA4?=
 =?utf-8?Q?BqCTXZPB4ekc2L+M=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9927ea13-5152-4736-9deb-08da435ff3b5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 23:47:41.7940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pb8/FKmj84v/mpFn0CmNxktpUm8+xYJI5hoDmWxoKY+RM+vgQ6XKkIWLsvO8VLtpGMDBucvK9Oxi0umpZ+fP4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4058
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-05-31_08:2022-05-30,2022-05-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205310102
X-Proofpoint-GUID: VtYSu-Y11Jhy7MuG2wz8ZOLgCWJNKNRV
X-Proofpoint-ORIG-GUID: VtYSu-Y11Jhy7MuG2wz8ZOLgCWJNKNRV
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
> And some function names are prefixed with "huge_page" instead of "hugetlb", it is
> easily to be confused with THP.  In this patch , cheanup related functions to make
> code more clear and expressive.

Some typos in the commit message.  Might be better as:

The keyword "free" is not expressive enough to describe the feature of optimizing vmemmap pages associated with each HugeTLB page.  Rename the
keyword to "optimize".

Some function names are prefixed with "huge_page" instead of "hugetlb".  These can easily be confused with THP.  Change function names to make
code more clear and expressive.

> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/linux/hugetlb.h |  2 +-
>  mm/hugetlb.c            | 10 +++++-----
>  mm/hugetlb_vmemmap.c    | 42 ++++++++++++++++++++----------------------
>  mm/hugetlb_vmemmap.h    | 20 ++++++++++----------
>  4 files changed, 36 insertions(+), 38 deletions(-)

Chnages look fine,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
