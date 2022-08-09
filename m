Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0E558DC3B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 18:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245161AbiHIQiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 12:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245167AbiHIQhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 12:37:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90A8D6B
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 09:37:36 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279Efkrm021088;
        Tue, 9 Aug 2022 16:37:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=3qrP1NU5AmF3IbbPPyK1NralUsT1GpaUuJHgtaT4JKs=;
 b=QxdLE6935JCFD16wOPV+Y7eNNF+kzeFwRT5yDatOtzEYU34bjVE0AVZIF1CgueeDTV7g
 9vcVCXJ4fSsHp0yXpRNhSRqgUZfY/PYdsMpLb6ziTwWd6hTiCqGv1WVABidCSELZ5GjJ
 6w3HBJK2sUpx0HeEtRZYxt8EqCNoQAxyPEnIUyk2l7ooJu8FMD/prx5EKsONR+v2nxEP
 hpNyEFUmsWExgsiUcf4G3Zg7qk0hTCFScVxiPQNGtqfYbjsHx7xyIe3wIzBcXy6K+Z0w
 stOIAA1QPpCDUJZIpRBbCiWRCpirQmwJMbLPm+J2lEMAKnY/u3VHMIHNuLt8bKl0x/zl lg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hsg69q04r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Aug 2022 16:37:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 279FaGpw013976;
        Tue, 9 Aug 2022 16:37:14 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hser93c48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Aug 2022 16:37:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUL/9xQBxe1BC8L8eifQFKUwbYzRWZFe/GxA/ABXwRpt1E0ieQ1HWPrtBCj7goGCbSTU5Ca0i62qzgx6azchUt7Q72VG3QP2nbXGZfso3c85/Rj/DcenG0GnQAIWlXYdCnQC1pzuVJqfWOkkkhWj/YWj2GEDxcLJ3c1RPjoRx4Hf+cUs4ubbVqI/racJDGIfSSS7Sd/rpCQ0sAzidHPiTaLdHbSfy9Ew8UrjmkxUrRefzB/S9yCNh5zn8+kpFZhUZo9S5se8KkoQN7P+Y3KE37yZFBRGZwCBS3w27DS6v3gsJTAZZ59qJd9DkdOju1nBDD0t1+lbnOvh6JOYWHm/jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qrP1NU5AmF3IbbPPyK1NralUsT1GpaUuJHgtaT4JKs=;
 b=mBdYhDfSF2kylauJEWLf5XUttywQiREhSxyc8dnDY1QnT6pCHYFtD70CMT1Gb3hobuh7JctNMBjEh50N8Vt0EVaae5FhKkWhkjjWZVOrgtBk/lbIUUsX0ro6GW5wX/kJAAo/CoWFbIOueIYd6Y1hn4KE6Pa3Bter6z+M8ZOdsmbx07Z3Fjh5gl0yGKP+2QYrcSpfmf+W7Pv8HqpFrIfBq5amGSh9zsRTEJNHJN6Dee7OwDW+GnpED69fCukDRXedebPtCPTEy2dWkgo9b97HUegEyrZ+wDrHZU6OUf6edqu0Mo63e/8gy81D2EccXIKJFOBV1U8HDzpFy7iyg1rv/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qrP1NU5AmF3IbbPPyK1NralUsT1GpaUuJHgtaT4JKs=;
 b=Et4zebdb/3OlMr9zDi7QKmJU/MIeM7fgihZyUVlfaam77JjH2LqYSaIc37FtPIULIYaBYeFT8bS3k1CivfY+OkenRlJsP/+V5mAuYytiEC42BOPcTU6Wkfo2Q0AeOytIIRVfkTfUasZdnltip0gIv2hz6MG7f2UDR40zoYmVfQk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH0PR10MB5259.namprd10.prod.outlook.com (2603:10b6:610:c2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 9 Aug
 2022 16:37:13 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%5]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 16:37:13 +0000
Date:   Tue, 9 Aug 2022 09:37:09 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hugetlb: freeze allocated pages before creating hugetlb
 pages
Message-ID: <YvKNNSEWd1va4jo4@monkey>
References: <20220808212836.111749-1-mike.kravetz@oracle.com>
 <119542cd-939f-3185-1d51-a177d4da1dff@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <119542cd-939f-3185-1d51-a177d4da1dff@huawei.com>
X-ClientProxiedBy: MW4P223CA0024.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa2c5ae9-4fb6-4d57-db07-08da7a256947
X-MS-TrafficTypeDiagnostic: CH0PR10MB5259:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PE8LioevUV4eT0X7BuMKjWnP2JVbI6hBqn26iQ9f7b5iuWAmB6T+oQC1kWitnvA7Mb1PrvG7hWBefFSbcJcAho3I2o+2WD5A81I6ebywX+t5TDdbmWzmpgzzNrn9FMn8gJE7uy8nTtn0sRoAQwyjOHH5RwPaex0jzGFmjYXYw1Twwwn9iSFL4xRdmEDPNiCE8LB+10ALyZnnoNfMBNNaPtVFPU6uZQ44L6An3n1XDA1qDXm85p/NiBi4iTsKHEFGlMfPQgXMc8eeFyvSThfq0uHp16HslbfnJaG1oBBDiJMtsSbBy6jOl8/U7TiVY1QNvkUtQQu60rEmGmENi0TarVKBVGKj9e79dp4+BMpXXwG2sfH/RMKT8M6AQUZyitsnUe85LUKVSO0B04SDgufT06a5wjqw4kVtQVbfukZc3ZBsVhZWGbvWjgNIv7Hz3ClSJx5CdWZhE28VgH1ToNtMYVqIBrtdcNck79e7kIkXwyiW8qnGCJZSI4t5gMPd68kd5Ubb1Uj9cWOm7otunVakJ7FApEyVuEGvOMT6uJHjKxuvhknoDIgty1GCBQotVwYOITHt2vZTMmG8JvX+Zo/INdu/59XVlOGEVfimU2iqoqrnjeMJwqxkZjA6BXeIVIm0zLyJhNFvi/kd1EeIqB6/ysbkIXDNaKKdHCKu97Xp/EkacpDuJVRo1K0TIxTTkxMoORdllVUF9S9pNYYB699QJ+gKJFCOyJwBSExYhdSH+Qe/wJi4yQKfIb6dvafFpJqT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(346002)(396003)(39860400002)(376002)(366004)(6486002)(478600001)(44832011)(41300700001)(6666004)(33716001)(2906002)(86362001)(316002)(6916009)(54906003)(38100700002)(186003)(6506007)(26005)(53546011)(9686003)(6512007)(83380400001)(8936002)(66946007)(66476007)(66556008)(5660300002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m08no4iogmRbbJVlwSQ0IaITAt3s7p944A3CtMaxRHRniUy2foMTW28Wli8Q?=
 =?us-ascii?Q?77q8iHNXQh+z3kqujmwGOc5+OqWTbLNvk0mmzGGgfv6KWSAZvS9NLHLNfZUL?=
 =?us-ascii?Q?bc6zyzR0FcHje7GpIaDbx5gQFsrUAVmuOUna1m4kTxOaCm2pqQwpnZIjtYLR?=
 =?us-ascii?Q?JT+wZ4K5YWlIm1KUfOCpjPn71V7zsavLPGESd3wgv8UXgrUddqQyGMYhzudp?=
 =?us-ascii?Q?WJ0w9dA/3fYeowkxheVgHROSuZ7QITbET3AHgRRAsAGrOb2Se9JJLhZ1JDqB?=
 =?us-ascii?Q?XtAGouyr7dSxsCK0IMHSdXbL3N4vSpuowHjrROqDWoMKo2QcfXp6khAXa9g7?=
 =?us-ascii?Q?qSNpkr0IrMfKxxGT3e6yaNNscKHHuAhP4vwlRrhIIfTlXFbFBxa14yTSOZsE?=
 =?us-ascii?Q?ZTGhcIlq+p69p53crOXfCc10oQADGFSOk+q6PChEYgyfTHf2Q35QLoCDOQk1?=
 =?us-ascii?Q?x20+eyqzOJp7kJXAbYorJeCE6e4LUs5C5rbFtJVzq1F5zDWyjIq6x8Ua3eLl?=
 =?us-ascii?Q?I4RAOfj2a2zPF0Q2AiaDCgzi78c1tQ9eXwH4hr9Q1EBLF2nyFBd4U+TSCKDI?=
 =?us-ascii?Q?LcKyzqH7nDK/Nm35FpVYRMBYzHooGYWuvlO2Kt09kPMB3bvFgE5sHGkPIpkY?=
 =?us-ascii?Q?klzychPRSBsn2n0oXdYhqavvgwqlTK1YrkK7s5uE8L/jUQaroNL11HHdm7pZ?=
 =?us-ascii?Q?qWcDpfsj5lxYM+GjJWwPR2qIuoz9griRPAJP+EuRs4outRq5C1oHV31PLAAr?=
 =?us-ascii?Q?2Lof6Lj+/o9kkzY5TJQ5a4Zyt9U+9JnoN/acQ7stBX5qD6lxbZuO7dt6unEu?=
 =?us-ascii?Q?yyAkhjXXDEWiADe854StoYl35pufSly1yru6thJvIFlAOpb0q9rOspVJmsY+?=
 =?us-ascii?Q?Sz+WeID0UQN+qgfWzrfy4lUdNn1FtAnN4rm+La+rb+95HvV3wXGq9EdGYIpA?=
 =?us-ascii?Q?PY5Izjbz4yYNcH/c3Myzv9laMbaEOhnnqYReNH7ZtxXuBMqzVQJFRlPucwmg?=
 =?us-ascii?Q?nmyOuYUcbS2mMvgZ5TR34vJYYCYIYsNdWmnj68Xw7SqSIA+U2GS++qYlzeT3?=
 =?us-ascii?Q?DvrJhdWjNGSH8hxEPducc//afeNYuwG1zUrFmvOz6VORILOODxmwmdrXXL2A?=
 =?us-ascii?Q?/FWiRFfFF/2EY6PqOn4ZPEqGoys7lSoKYZWy9ZJ8cyc3/Ixr9KW1jnOvz2hE?=
 =?us-ascii?Q?zL/GsWXXBxadCA+lSXhxP6RbPK8KrMpfVnKRezliOpTLZK77YZjh3WEPKZTR?=
 =?us-ascii?Q?AIXnNR+7Rfc4V2nV+QRpSawewo6zGLpFgeOZUwuZ0eMZ7jTPI1tH7R+AvJcV?=
 =?us-ascii?Q?FbFIMbHY24/lS+/wnzbU1C54A9S4O+ytKLYmbqEoz762LiaP3nInyar5DtQv?=
 =?us-ascii?Q?H+8eMzse60klzZZNEH07DTtypXivcG+1iiAObf/ZhZVzrW693oQdwMxD5k57?=
 =?us-ascii?Q?jwWmb70j4ZRwCBuMHk9+wdLZNHcIlynYAvV6OWXXMdYW6CPPtfD3GW1W4V5L?=
 =?us-ascii?Q?JBzIsM0QkMapvgWGEvw6NXLfAdq79t8rdyAO0ny+Qng37I7ltz4Shb5PI3BV?=
 =?us-ascii?Q?7mAtcBvyke+Yu/7v3unrh4FvXgUgL35O1+oG0TugdMd22L6B4kJ+iFlWuEbz?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?hnAVoMtHpQYliVkeQ5OO8jRaOtaCFv9ey8fCxZwWzKtilpkCbunQpEsZmfBy?=
 =?us-ascii?Q?jytpsEbIu0d6kzWJJRMEy/w4SxI2lxAMidP3XdV4qut64xOZY5RHZqyGpl1+?=
 =?us-ascii?Q?7YQF633F8t5OrRnXQWMjsRuI5nZc06BGcHFx2Rk+0asBFefj0wDltCLqLV2P?=
 =?us-ascii?Q?TdF0x/+6J20IlO9dwrsA6k8rJBzct042UcZgTZu3932z7tVeG0UF/pOjNmPS?=
 =?us-ascii?Q?AlFdHouoqzltc0mssp69b9qy8LPmSP05nQGtn7a9omLVIelRbk2QLenXzxw6?=
 =?us-ascii?Q?vIgTeKDHlGRTo12e/BDoTtnRbWOnAfxYMUjK53Fw0u1G6vI81XcsIYzCxtXJ?=
 =?us-ascii?Q?r4SEmucR3vZnfFbHBSJVPUYY2rrVHayJrgjevPnMOixYy+6fwXHBr+VOymrI?=
 =?us-ascii?Q?wmHpcFnN7OsOM9VzOrldyYq9wXKzAC4vSdi8yAj76UZNarfJzVmVvhS98Kns?=
 =?us-ascii?Q?2NQLUYzfNNJ3G6G3/07idtTUCU3uvN9WnaTPJc1dtjf0GSh2XBG9AfEBztnE?=
 =?us-ascii?Q?1TxO23i1NxhZsQwvZp73sPWMW6qpR6DiNV7zlN1HMyu3PebulAOHIE5R4Vu+?=
 =?us-ascii?Q?eG82B+rAEEXRi9XayB9zr5zTR4XPuEnGEcTcIOH3CpJ93LKtmFOfcXrUJVea?=
 =?us-ascii?Q?we3+WjV4ywEVQGgqvZPKoEdv46cCG8jY30IAoswT2HoBFaJFwvhfA5GGLC8o?=
 =?us-ascii?Q?veZR953wUz1vRBQ+fqQ6B2HYRXWku0Wc6w29f5z5/I9gAJ1Cu6mZ1kt7AsEn?=
 =?us-ascii?Q?f2pNQwKS2pVNQHdM7+7y7gfJEW1FPCKnvGB5KdvCc9DlCL5D1ehiWu1ckAsP?=
 =?us-ascii?Q?UjO2Edfq7C7Kvl2garOzZKMleXbqJMQ/ds9DitrPljBdTSRXe/PRjHB0HKY3?=
 =?us-ascii?Q?faUGf716Br2sAveeaoTBEzUD8gOfBn/iEaT+mg+m13CqbevcDxzUjkn2/Su5?=
 =?us-ascii?Q?UwEr5+LgryVXoHcvOxTQbw6g3Fwv3Z1OTZAlm6F5tbML7b0DgCUyroquaV+l?=
 =?us-ascii?Q?aWJvE/4tmclo4dicTYHRU7f4EbXWlghHaypXy/xQpBHXOqJYZLOqBAKSVMwI?=
 =?us-ascii?Q?NzQdr6QWymJ9hcAy10A0yI/am0S/I4/svmfw8BiTVNOG67zJZY8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa2c5ae9-4fb6-4d57-db07-08da7a256947
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 16:37:12.9097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +PaqoAMqLiP7xkgtcYux2sehqdYvUHlna0eO95q/bq4hExFD7k0EuDDGnh/k0DhQl2uY8MTw39qyYIbv8HzXKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5259
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_05,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208090067
X-Proofpoint-ORIG-GUID: bx_tR8E2Bs6nlIbfiVPvGQeBCqLLOXle
X-Proofpoint-GUID: bx_tR8E2Bs6nlIbfiVPvGQeBCqLLOXle
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/22 10:48, Miaohe Lin wrote:
> On 2022/8/9 5:28, Mike Kravetz wrote:
<snip>
> > There have been proposals to change at least the buddy allocator to
> > return frozen pages as described at [3].  If such a change is made, it
> > can be employed by the hugetlb code.  However, as mentioned above
> > hugetlb uses several low level allocators so each would need to be
> > modified to return frozen pages.  For now, we can manually freeze the
> > returned pages.  This is done in two places:
> > 1) alloc_buddy_huge_page, only the returned head page is ref counted.
> >    We freeze the head page, retrying once in the VERY rare case where
> >    there may be an inflated ref count.
> > 2) prep_compound_gigantic_page, for gigantic pages the current code
> >    freezes all pages except the head page.  New code will simply freeze
> >    the head page as well.
> > 
<snip>
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 28516881a1b2..6b90d85d545b 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1769,13 +1769,12 @@ static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
> >  {
> >  	int i, j;
> >  	int nr_pages = 1 << order;
> > -	struct page *p = page + 1;
> > +	struct page *p = page;
> >  
> >  	/* we rely on prep_new_huge_page to set the destructor */
> >  	set_compound_order(page, order);
> > -	__ClearPageReserved(page);
> >  	__SetPageHead(page);
> > -	for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
> > +	for (i = 0; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
> >  		/*
> >  		 * For gigantic hugepages allocated through bootmem at
> >  		 * boot, it's safer to be consistent with the not-gigantic
> > @@ -1814,7 +1813,8 @@ static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
> >  		} else {
> >  			VM_BUG_ON_PAGE(page_count(p), p);
> >  		}
> > -		set_compound_head(p, page);
> > +		if (i != 0)
> > +			set_compound_head(p, page);
> 
> It seems we forget to unfreeze the head page in out_error path. If unexpected inflated ref count occurs,
> the ref count of head page will become negative in free_gigantic_page?

Yes, thank you!  I forgot to modify the error path to also fix up the
head page.

-- 
Mike Kravetz
