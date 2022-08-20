Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314B559A9DA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 02:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbiHTAIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 20:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbiHTAIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 20:08:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFF150700
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 17:08:33 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JNsWZq030760;
        Sat, 20 Aug 2022 00:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=moJdl0qKa3tOleuYeGlbPTEX9w8AD68cnIDee+NQAyg=;
 b=k6R07Acm+kTT6saq2Mk4cqJ2/Rwo0SzZTjyZ6dnVRy/6/O7vblqRcmkQC6vRPvFm+P7s
 ye0hr8zuxRTksSxYPDoEvl+d+KPyvYPx+kvd2Rw0eXWWHNI0fwoPXo+gMlT5NaqcVpiQ
 8zcGwbIg3VXb8o6yKW3ewHXgE+auobHvZr6eXTXrGXUS5zirxw3QDJVKrLzqs+nOjcki
 EN4F2At9xIPq5FCcuNkomxlKqJ8NK9cQJMb3f/K9njftq1KflfGTo6VEUjUE9kJLdpNP
 Yq4bjXiJrHRy1EIvtkqk+jHhapjXCs1Ae2+e13lwspYtfoF8A97r17MG6LtC0sIrZZou /Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j2mkp80c0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Aug 2022 00:08:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27K06VKs007828;
        Sat, 20 Aug 2022 00:08:27 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hx2dbygdu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Aug 2022 00:08:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QR2+LHOzxtyAxVXbXk/xFCHU57VZfVFu28wz3U91lxElqBcFetkmIymIolnFY+KmhlfqX6Pdi8Q4e+b7XMWTG8HIjYtkm9E7WbwfBBc1fYtveXCjYA2pAc2ho3ujdl52wQ14Ru6n7XWjZn+LYaMKPJlQuJiI2D7EKanawF18HsGeoGhcDzxO0E5xgu005u70JQIjTi9Dgvyxa2cZ6sYxGtS7hqpCvqwQvpDFPJMSap/4BXO8ifh1N/rjK01vBR7+e3Psuq8mzpXMNy8yBHADZ9zcLmy8bVESuOGdkBBy+7COuzmE1mRNVMtMtGpvVidZQYcs0XXv6YW1pm4kRoTi1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=moJdl0qKa3tOleuYeGlbPTEX9w8AD68cnIDee+NQAyg=;
 b=CyWFW/FCo6Zl4qrbbjyM8WlVD1cDEqTq/09nqO8TXZ9coU0w38ONSJ77RQ3OAk/323FENjB9moydgJb7NUH3uE10RZFAwP4SECjzstfT86llRpPo2wrOMsiImxmzOVYQKwEqib/AMy8cQdJIzIbMgbK6uBQOGqg2G2y1BdWgHDV6FsVVqCRQ+XAoDhxwPpE9U62Om39eyrDahcakMM1et9mwb6kbUdn3TBrjacZFlsQVYei/nCPyEI5SDqDArJzETh+kh59To1AdvWN1uaCu+FpwkC0P+UHPsGm5yVw8mvBUBwG7pPTiRlj3Z1V6Q8Ag56pLYY29Jei5Sb9YN6Vidg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moJdl0qKa3tOleuYeGlbPTEX9w8AD68cnIDee+NQAyg=;
 b=UyJZ8qw9Y2Td1Y35RzyWx3dMhy97LplBwikQkNmgzlaG5SI23cz0oi5zX4A132eNCcrhzuLC4LNkYoEqNAZI5p4xMgYKA2zNiQBwEL33bZb3DHD10mUaBrJSRZtvCggGs8XpRI4rHqTsyHa5b/H7WKGb4EUdsUbQHRgvam2t2DU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ1PR10MB6001.namprd10.prod.outlook.com (2603:10b6:a03:488::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Sat, 20 Aug
 2022 00:08:25 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%5]) with mapi id 15.20.5546.019; Sat, 20 Aug 2022
 00:08:25 +0000
Date:   Fri, 19 Aug 2022 17:08:23 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix some issues when looking up hugetlb page
Message-ID: <YwAl948ny7AZEfT1@monkey>
References: <cover.1660902741.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1660902741.git.baolin.wang@linux.alibaba.com>
X-ClientProxiedBy: BYAPR11CA0088.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7db142eb-43d5-4e34-a362-08da824019f3
X-MS-TrafficTypeDiagnostic: SJ1PR10MB6001:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U0+RpoVQGQLFaQ0L8iOSm5PqYCREhmNsT2g5YtnbMP7/5dRPAsJMRx+6Gfyco6PszthJpHxg2zcajf9Iy3bSzYXV+bkbNFJtUHO07su1c801baA9d/UuPmANtmGBWaa1PrJA5donJiv7Uq3SjnMgTjaDr16NG5+y6Ny1nvDZbOWRmt1+BLC4sI9KRUQWOGFaxBt2qhRe/xxeGyG80Uqv4A6pAc9sPZTZWLa5i7mzPvwtv4Yuj66JdaiC4KAaJ79KdLSrE/L44S7uqTintdbjoL2DZFQd73yfPkfvjfYlcU0OMJnIvPoaksSDuZ82wuJybTwAqjwCkdUDqgtK/KucVPPj4/OJaT+AfwYyoPPJHA0qeQ75ZWBI+ELxZiaJhuEnaXL999vtoJN779fXDF0HSiOJWiKz68GHlzb5uvOJvbKi7ivFAQBACQhZlMU9pSGzjGh4wu8cEswm9zJNi7F3o596rqbVvo9S4FHmUD7Lyd2/guuR4/+bWv9uiQ2hiwhao0SC1KzJEz1ULeejuTQfsfr/YZyOUm0OGwG70O4mRj3dUX47Km9SKA78c9Ji/31+h81BPG4DCCMGB9K61AUFzy5pjiKlwT4CXOPr31v8sfnOtx7vJrHaZHcQJMc39Vi4L+lFcpMnWEmgX8BmmrPfa+V57orqreL6J0+e/Sf0BWV7zrWo8AEH+Um43geU+bh4wdB0s5G+Yg7tGIUiUiob1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(376002)(366004)(396003)(346002)(39860400002)(83380400001)(8676002)(66556008)(66476007)(2906002)(44832011)(8936002)(316002)(6916009)(66946007)(5660300002)(4326008)(53546011)(478600001)(86362001)(6486002)(33716001)(6506007)(41300700001)(6512007)(9686003)(38100700002)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Obh7PrRMgdEApL6rOmNmaSES22v42FpWGTCbAaicOOdx07roVz6yKyUyheEg?=
 =?us-ascii?Q?XjhGfBr0I/L96XIHtn8JLamrC/glzhxPcXRNy3jlGnk1QrdFFj700h0oYxR9?=
 =?us-ascii?Q?+Ed1npqwHlLSmXRWllhecpgPMmPpHE7apzj1CrMZ96VrqzYh4iKzXQwL7MEa?=
 =?us-ascii?Q?5Fuj5cZS+k6IGaEF1DuDkF7Af6d6uc1zz+Ngkcn4NfIapcIkTbQ5NW46mbyW?=
 =?us-ascii?Q?BPEfFSeV0Gk9lFqIzIpwJdqDk1jWK7y8WiXuZiEFXttL/OyJi7pE9FAwWyHL?=
 =?us-ascii?Q?+8ZXV2ZXE1WBa+BawIuN9hnlTw7kgcIoB2IVi0TyJiuLneaovliNcdUal7pt?=
 =?us-ascii?Q?2CWX/aowJmaS/hsZiTYflBaCn6ZDZp7yAs6D4flJnqYz00/BReHy+8Bul70q?=
 =?us-ascii?Q?FaN0PMc/xZ7sEbUG3ZLrjdsqJRBSGU5JagJ0P57VUKHjk+riRTDi7Soh4M4L?=
 =?us-ascii?Q?126BK8pGxC5CIB421N9vwaOdxkiqM4qFCf+nuk8HHbn9FYiFmZLail6nxuqH?=
 =?us-ascii?Q?8sH2WFBE+O8hF1bRDpYPkflG9+GAd4JvpfKjozgKGR0HaOnWZMzNc+gziBil?=
 =?us-ascii?Q?p/7gHHVPQ9/2i2GzgMNnhwBdaLSYdbXRfQI4zX+fv4L64VCbXFM06ucGe3Y7?=
 =?us-ascii?Q?m8W4v0cHX6r2i7hjWVyPg+RAB7LZPJ5BKUcPOa/1+twLu8AbYXct/pMCjByD?=
 =?us-ascii?Q?65S6IbX9q4EwW23ijbtHNYbWWcLj2xPJIgqSpzzs3aloXyg4VODV+GJLYmTO?=
 =?us-ascii?Q?+DZHcD2veC6BQO8MHImAssdEfEupWXcjrD07oOwm46eqZHFVHmO4KKrNI+Uf?=
 =?us-ascii?Q?PSOSz88vT2tnn2AcFr2YnfyX2tGNERpoobiiU9rypD6K/ls0f1trGeFiN7YC?=
 =?us-ascii?Q?Ik3f2yeKJw0lBDQtlp+mP9KLTsqHU6asTZ0ju65F4NFQ2YHjMMIiRw9DulWZ?=
 =?us-ascii?Q?iNl594TYUihlcPAhAkMsDbzzDH5KTdjVNAufWQc07AejMpK9T3e32P6VwcXm?=
 =?us-ascii?Q?qDXLrGWYNqPpvhAmD2TomPudVNOzESNnXk8jR3pJi4PhyaBpb3a8RjxO1s4C?=
 =?us-ascii?Q?1d+FZGCUyGLoDIP8kEMj6oFgOTZYL2cYep4arL0hWyy5mk45/u1ddXoX0QpK?=
 =?us-ascii?Q?IOG1RBp3J1+MAoudg5GsgM+EijET4r62NDfOnEx9uCEpXU5ZMce3D2NMB3BQ?=
 =?us-ascii?Q?mpCt0+rtBg5Y+lK1ysszm4/zj03KRYFu0wXkbiD7RAfhIv6iGkVyLQYckWPe?=
 =?us-ascii?Q?H53elj0+5ib6SBne1JzrV832OgoCPLD/FKHiNoslvNSw2aAHS1m2ZyxNzYO8?=
 =?us-ascii?Q?BRy6p4TsjcMQGHWB83XZHxzippDq+jjQhHuEim9Orin9avuKwtQRFa4inyB8?=
 =?us-ascii?Q?dKt6nE1yASV3PWKuZUnXfte184/D26UeSfhCh6R+LjpAOiO1c8/KqJATPn6T?=
 =?us-ascii?Q?8JaHak21oMvMUF2GcdZCjhY4vz/C76D2dW5SYSa4gFqmOzKcflKaodp5+L+i?=
 =?us-ascii?Q?xGUFWEDznbpUkdyVz6n/w4hR/YaNX+MYZQVhgRRU4HIeRRS976Wv8ntQ+5OG?=
 =?us-ascii?Q?qEc5bs6ss4xWZfy9sEtLdjT0rRZpj3c3/8uJ+8wpYcAdM9Uys85XsxKN15ff?=
 =?us-ascii?Q?RQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db142eb-43d5-4e34-a362-08da824019f3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2022 00:08:25.2823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e62Ba/UMKY/VyeHNsTQeInm4zzUtXnLChNF9vpTnQgH3dsJZRUmPBf68ImO0QqhC3Yg5j/XQEpU9wvdPjYP46A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB6001
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_13,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=673
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208190091
X-Proofpoint-GUID: dqTv57LZt7C_ttoRagi7gHqVsPvqXV-V
X-Proofpoint-ORIG-GUID: dqTv57LZt7C_ttoRagi7gHqVsPvqXV-V
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/19/22 18:12, Baolin Wang wrote:
> Hi,
> 
> On ARM64 architecture, it can support CONT-PTE/PMD size hugetlb. When
> looking up hugetlb page by follow_page(), we will hold the incorrect
> pte/pmd lock for the CONT-PTE/PMD size hugetlb page, which will make
> the pte/pmd entry unstable even under the lock and cause some potential
> race issues. So considering the CONT-PTE/PMD size hugetlb, this patch set
> changes to use the correct function to get the correct pte/pmd entry lock
> to make the pte/pmd entry stable.

Thank you for looking at this.

I often get confused by arm64 CONT-PTE/PMD layout, so my understanding may be
wrong.  Can we use the PMD page lock for locking both CONT-PTE and CONT-PMD
entries?  Again, I may be confused by the CONT-* page table layout, but it
seems these would all be referenced via that same PMD page of the page table.
Or, perhaps CONT-PMD can span multiple PMD pages?

If we can use PMD page for locking, this would be much finer grain that
lock in the mm.
-- 
Mike Kravetz
