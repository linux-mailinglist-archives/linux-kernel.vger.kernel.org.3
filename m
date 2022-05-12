Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8261525756
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 23:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358887AbiELVuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 17:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243633AbiELVuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 17:50:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D088849F34
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 14:50:07 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CKhwcP003183;
        Thu, 12 May 2022 21:50:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=gC4BnA5XozkPwtYP0J1hwdFQ2ywZALTn131caBwFg/Q=;
 b=yzlLloa/f0gAWzL0WOryAe49+CSSfeo9s2CH4U54jEDCvSF871lTclL+vaqNZc9EalfS
 VyRkbBRqSj8pqcLSQG455KB2+SY83SRmd5LMR/bU923zHd7uymE6G8UKOy6qxorSIPAp
 8BOCNJSXGUAmfVfzeSrKKiChXPZvv10gab/uAX6QUObl5YLx9WoMdzjL6K1KQmfu4zNF
 TcCFB4hKHZ1xsj6ZPfFagBhkCP9FJvOx2yEyoM+ltEehD59RDZDKTPDKo4iNyNOEl/DE
 OtX0GmQatIaUr0eiNC2npBl2h1cV/dqgEsn2FASBjHY7xropc9QcUFVM/8HMA7jD81CR AA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g0a04n2q0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 21:50:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24CLfkKk025625;
        Thu, 12 May 2022 21:49:59 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf762ref-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 21:49:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8xq06gPpTsnstRi0jic6QeWJbU7yiWFJEMYUHTbYuuKD0/gwZifkWIUbSpTaYZx5j/apJgyfiy4i7h14hoyBg8Qy/fn5cJPx7RaJQzeGu0HGsUwG+Sdd73q9AA5qyHLzo3KeQwRtQVpiICEUnWqTZcPBSdRXamp1UtCf97PmbwlpHER0BldQ6TxO/SYSsnsM9z8771h9XSTZTlFoOF1WqyK42NHj8uCrFF9uYCahsyUxJ4iT/X2n5fA5iSfEqFzQi9ByVqwN3C8zQwqeqVBwM0poSP9CQUW8V0Vpu6v4nsXFDzL2XMc8En2bVyHFbPJ7ic+qhONbyrcG+fOtyqaLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gC4BnA5XozkPwtYP0J1hwdFQ2ywZALTn131caBwFg/Q=;
 b=j5LDWAE3v3RLoQRdzhcfKZDh7G4VbpTBFbdN+HWEx1OYvv1tORBFEwfBQoMchpNLQvSSwtPjeOduX2PYbtnB2SzP+iJhccfxvT5xsh7jIrQLzFDiPvClfXIG/Oax9dLQdYdcN76XfnecqGTLGxmgja0gxvQUXvjJnjSJ7G7+TipR6p5EUTUtvC1GbF3p2nq8F0NyUZ87Gj21ZiCyz/RO5X0CXnZR2t9hZ2thQFnhlN8c3Fral+53j2mLut8AfLHB2QedUO6zVOAyP3cUoVaS6LiV8PrZMB9NIql1SGRcK+9Td+SFo00hbmICWiu2Ilx3yNYkK9wezrwKCoCQ4ptD2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gC4BnA5XozkPwtYP0J1hwdFQ2ywZALTn131caBwFg/Q=;
 b=zfGQcNBSiJj0bQnFAYeQz2vDBlZA4b2opVLMn+n9OktUKhYpouvxeO4YFZ9aIJNyb5o4iYSmvzETl0CBY6ezmZ16Plh7L8VDw8yeHpyJYUF+jabHHJPl/WZSgkNHWhmGRF9g+Mjk71CwQKJeaAqyNMz9ipgseyxhXbAMR060FZg=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by DM5PR10MB1564.namprd10.prod.outlook.com (2603:10b6:3:9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.23; Thu, 12 May 2022 21:49:57 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::4421:897e:e867:679c]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::4421:897e:e867:679c%7]) with mapi id 15.20.5250.014; Thu, 12 May 2022
 21:49:57 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Len Baker <len.baker@gmx.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH] assoc_array: Fix BUG_ON during garbage collect
In-Reply-To: <20220511225517.407935-1-stephen.s.brennan@oracle.com>
References: <20220511225517.407935-1-stephen.s.brennan@oracle.com>
Date:   Thu, 12 May 2022 14:49:54 -0700
Message-ID: <87ee0ys9od.fsf@stepbren-lnx.us.oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0074.namprd04.prod.outlook.com
 (2603:10b6:806:121::19) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fd8f6d8-e694-4437-766b-08da34615b31
X-MS-TrafficTypeDiagnostic: DM5PR10MB1564:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB15645B15E0E7934A0141A4E7DBCB9@DM5PR10MB1564.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LgUcvBQ95o0rGXFXYQClmAaz2ev7SAzdSbkl+8NF3r/9ZKSt1wEZZK4oFXeJ5b2Qu8+vb9tN4EFd8Vb0+x9URi1iKkTx9baItqdE0ulUS0NIcG2RHBizSElTD74DUAB1FJDqyUfY5eNNeijMB68QpJGaW2pZhn+zZQBlx6sDLb1e2NJY0Wjn1iFQMmePd4mBypdEeQC1wxtqh2qoeXG7Vw0I4xNNxKuFZY8GvqfEfsrE5fdX3HzRkyl5E5K4+HgpoTNDj3oZK+5DB/ehFXRtq3A7tlDMNBFScaSWNpbCnAIz7/1Mosa0IGn+4EJm5g5D32RpLYGEmQ9mYOM5QgNGUGizINFJ5N9JKQ0c7+RnX8DjOu0uIypm/D7VKuffPoeeZ/0qT4eQAhzNOc7Zf97dbnzXtpdFELKD4z0GNjwGg8RogiaOJkhnXxKcFgJVwcCTWs2RgjA9l1pGLwrtYDrGS4qRTX3u+H87HqCDYLbAIEDm90wElHScVOQH3wg2iReO7F4+XFGphxexSb3ql+xhETyeLDWi8e3UVV+zaySOwnSxKn9Q1MuFCYo05KuEi/StQPvYw/ZDL93Pe5ZQH0kZ0F65qeJLRcmrC3iDN9rdLWdaOR2T6YEGRRNcLo0FPqVYmofrLHEaBrXLfXCmJbnfV87e0gFfUJ1Ocz3rmj3iado0C7HSC8s+Y0ZUnCujA6lHlZCk3elLut+7sKktjHYsdmLkJplfG3u7BFJ1id6ZW9il0UqQGyJq1jH9DetEtyqi5DGFHI21m/tlHAV4AAsvUbGOVzAO2pOgWBcjKxVyZW8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52116002)(6486002)(83380400001)(966005)(6506007)(508600001)(6512007)(2906002)(5660300002)(316002)(66556008)(66946007)(186003)(6666004)(86362001)(8936002)(6916009)(54906003)(38350700002)(38100700002)(66476007)(8676002)(26005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GiIMmhzJvweWcpUn5RA/Bq8COgtP2VDD/6duiu25M3pYqsTHtvt80twKLg/T?=
 =?us-ascii?Q?VQtOh4WSLUOPkkrnyLXTp6PgSMj+nHLEpyDkcezAQIPR+RBwLxsWhGaQNE2d?=
 =?us-ascii?Q?VpsYG2p1Go32Gs/d6YSWyApLutQMq6DHrYAk65T01KYCNIACLDbBfB32prjF?=
 =?us-ascii?Q?MPn1y6+pYCcISXWhhrUZ2WbT84ZYFWZTFs+pfWNZAXvc8lVCzQOcbcBwzzDX?=
 =?us-ascii?Q?1eBV4PG5NINsNI3ixX82KbKIgSMLbIZwgomct6X0YpBSg2bQbBs4qgAsRj6s?=
 =?us-ascii?Q?F5pdsh9nFcoNa0ACS4lFCCUd82GLlvfjjgZJcaNKmQo94yPQN3CuHIRZCYcM?=
 =?us-ascii?Q?S8ti3l8LijGN8+IegYiP12zNuQvmt+dEOkMyrWr+tyBIlZWXgKYH0Vt/OJIg?=
 =?us-ascii?Q?1KOadgswmMEjpc5hvu2ZZ8Qsuoqabv6PzHQnx+deh1OQ/hhUl6u5hnZmzc4E?=
 =?us-ascii?Q?d+9LSd16ZSRgaX4Pco0UrOIgMxpT9tw8jIxKDlecHleSPw/VvwoD9mwA0Sb6?=
 =?us-ascii?Q?XHgsx4J1R04dJHvKerQRJ8y3ZgOsp7N6MFa7X2edXDqoOYK8IZavWveBLaLu?=
 =?us-ascii?Q?J84TGhwM2drmPBkaVteI8EXsgasyyF9LSB44efrz1nVLReEVK9KdgnsngIhP?=
 =?us-ascii?Q?YLD/fDHQJDmOyCcoGPHFt4ug1768y8v++XG9J7yponUwHsMAaEOmua4ZwqDi?=
 =?us-ascii?Q?FdAPERJ3DrPMBtRouJ2dYQwzciG4hPHwbNQ2+AXw86O+enDKUv2YXOdj3OLt?=
 =?us-ascii?Q?H3lcUah+5EpSY91XAKXSqXwzc8zEi7+iCXpJ42wTtfaZsi6+5MGR1PIRck5U?=
 =?us-ascii?Q?VbMdkpe1P+J2x/9kaT1rQmgOdCS2rN7RUJWHm3hYJFxmFMgqoTCJIFsDGT1s?=
 =?us-ascii?Q?sHgIOOSTzS4D5vyINeR2nVmXZaQt9Lw/PWwFM2/5z8O1rPD7x3ZSRQjW5QDD?=
 =?us-ascii?Q?Mt0+FHFqdlBowHN6484CMmw/88poC55ZtJx/rzFk+ljMPFdul1o93KmY5ocx?=
 =?us-ascii?Q?bv8UsA+sVoTrv5ezlOnpLY2LmTpSCOUSkC/W3OtiPi8WV2Higj0VVvXDE5hY?=
 =?us-ascii?Q?Egaka/+GWUXObOOCsKKUCtUwa2TuP39QX7WLuMFt4rwiN/pFhXr0QfmnH3Gp?=
 =?us-ascii?Q?hLKbeqmrO25cfjYgqyX14KaLbGFbAOOjHmkztwRWDyxvfU1v9WTrqjt5gdSs?=
 =?us-ascii?Q?Ap6+szIb2JDMfPA42auc6arNYy4e5pvqGFJlj1/4ZgQjpLV7ftk/fpcFczXZ?=
 =?us-ascii?Q?WpOd+4WTmotpOAqvyTr/hcfIaMFI2SOweh0n7iwRC5HJfQaOjivbplbrhXpj?=
 =?us-ascii?Q?AuecA3eDsWoJcAZeB2JwYI27Q5VnXHVMD8DVO2LtPmbfvJTCHNB2unpzp5nl?=
 =?us-ascii?Q?+YzfAozqKadmg+893ytG87oYRLdFpsl4ZcQ3U2DEPOUC4YyQonn5nDbZJK/t?=
 =?us-ascii?Q?2cI3mIYsvF6iuxQeAicqrScjVv+S8DvOeKAINx26Vc+daEk10j0TljHl+y9p?=
 =?us-ascii?Q?3RG0kcvcle5VmbBDG8t2qHLiNZsMNVoHKAZPvhWCp2PxnsMhAae4+sEb0EKu?=
 =?us-ascii?Q?p3koUmfzYvh3g1k2WFUQhk7pchb1GpAWM3+xFONwQiktIf1NhPJp3rUj9PJ2?=
 =?us-ascii?Q?qPgmdybhCCUfF1DogEp1jVRe6sE4b7HVUHXsmah2p61ygHnrHPZISgt475jx?=
 =?us-ascii?Q?XIAIJfyuAKPIT1iASa7mgxc+Ds2ZgcKNZuieWGb4w7cT2x8Sc0Htx7xFTa7H?=
 =?us-ascii?Q?aaFYm53LH0DJJ+swXm4lyBjzC/Kx898=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd8f6d8-e694-4437-766b-08da34615b31
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 21:49:57.4661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0FXL7ulaiD94ut8iUEMns11X8Pg537grASk0fn+9XFcbEN+a9qyRMWeSbjBNIRsnrg9AoD1uOaU5k2o5uAvx5V7jjmTV33ODUTPsBDE4eQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1564
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-12_13:2022-05-12,2022-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120091
X-Proofpoint-GUID: KhyFBkw0CGN4jKlK8-jz5KVN4hH0i9m9
X-Proofpoint-ORIG-GUID: KhyFBkw0CGN4jKlK8-jz5KVN4hH0i9m9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Brennan <stephen.s.brennan@oracle.com> writes:
> A rare BUG_ON triggered in assoc_array_gc:
>
>     [3430308.818153] kernel BUG at lib/assoc_array.c:1609!
>
> Which corresponded to the statement currently at line 1593 upstream:
>
>     BUG_ON(assoc_array_ptr_is_meta(p));
>
> Using the data from the core dump, I was able to generate a userspace
> reproducer[1] and determine the cause of the bug.
>
> [1]: https://github.com/brenns10/kernel_stuff/tree/master/assoc_array_gc
>
> After running the iterator on the entire branch, an internal tree node
> looked like the following:
>
>     NODE (nr_leaves_on_branch: 3)
>       SLOT [0] NODE (2 leaves)
>       SLOT [1] NODE (1 leaf)
>       SLOT [2..f] NODE (empty)
>
> In the userspace reproducer, the pr_devel output when compressing this
> node was:
>
>     -- compress node 0x5607cc089380 --
>     free=0, leaves=0
>     [0] retain node 2/1 [nx 0]
>     [1] fold node 1/1 [nx 0]
>     [2] fold node 0/1 [nx 2]
>     [3] fold node 0/2 [nx 2]
>     [4] fold node 0/3 [nx 2]
>     [5] fold node 0/4 [nx 2]
>     [6] fold node 0/5 [nx 2]
>     [7] fold node 0/6 [nx 2]
>     [8] fold node 0/7 [nx 2]
>     [9] fold node 0/8 [nx 2]
>     [10] fold node 0/9 [nx 2]
>     [11] fold node 0/10 [nx 2]
>     [12] fold node 0/11 [nx 2]
>     [13] fold node 0/12 [nx 2]
>     [14] fold node 0/13 [nx 2]
>     [15] fold node 0/14 [nx 2]
>     after: 3
>
> At slot 0, an internal node with 2 leaves could not be folded into the
> node, because there was only one available slot (slot 0). Thus, the
> internal node was retained. At slot 1, the node had one leaf, and was
> able to be folded in successfully. The remaining nodes had no leaves,
> and so were removed. By the end of the compression stage, there were 14
> free slots, and only 3 leaf nodes. The tree was ascended and then its
> parent node was compressed. When this node was seen, it could not be
> folded, due to the internal node it contained.
>
> The invariant for compression in this function is: whenever
> nr_leaves_on_branch < ASSOC_ARRAY_FAN_OUT, the node should contain all
> leaf nodes. The compression step currently cannot guarantee this, given
> the corner case shown above.
>
> To fix this issue, retry compression whenever we have retained a node,
> and yet nr_leaves_on_branch < ASSOC_ARRAY_FAN_OUT. This second
> compression will then allow the node in slot 1 to be folded in,
> satisfying the invariant. Below is the output of the reproducer once the
> fix is applied:
>
>     -- compress node 0x560e9c562380 --
>     free=0, leaves=0
>     [0] retain node 2/1 [nx 0]
>     [1] fold node 1/1 [nx 0]
>     [2] fold node 0/1 [nx 2]
>     [3] fold node 0/2 [nx 2]
>     [4] fold node 0/3 [nx 2]
>     [5] fold node 0/4 [nx 2]
>     [6] fold node 0/5 [nx 2]
>     [7] fold node 0/6 [nx 2]
>     [8] fold node 0/7 [nx 2]
>     [9] fold node 0/8 [nx 2]
>     [10] fold node 0/9 [nx 2]
>     [11] fold node 0/10 [nx 2]
>     [12] fold node 0/11 [nx 2]
>     [13] fold node 0/12 [nx 2]
>     [14] fold node 0/13 [nx 2]
>     [15] fold node 0/14 [nx 2]
>     internal nodes remain despite enough space, retrying
>     -- compress node 0x560e9c562380 --
>     free=14, leaves=1
>     [0] fold node 2/15 [nx 0]
>     after: 3
>
> Fixes: 3cb989501c26 ("Add a generic associative array implementation.")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
>
> Hi Andrew,
>
> As far as I can tell, lib/assoc_array.c has no maintainer, so I'm
> sending this bugfix to you. Hopefully David can take a look at this and
> verify sure it's all sane. I tested it on my userspace reproducer, and
> also by booting it and exercising the keyring_gc functions a bit.
>
> Thanks,
> Stephen
>
>  lib/assoc_array.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/lib/assoc_array.c b/lib/assoc_array.c
> index 079c72e26493..7ed20233a770 100644
> --- a/lib/assoc_array.c
> +++ b/lib/assoc_array.c
> @@ -1462,6 +1462,7 @@ int assoc_array_gc(struct assoc_array *array,
>  	struct assoc_array_ptr *new_root, *new_parent, **new_ptr_pp;
>  	unsigned long nr_leaves_on_tree;
>  	int keylen, slot, nr_free, next_slot, i;
> +	bool retained;
>  
>  	pr_devel("-->%s()\n", __func__);
>  
> @@ -1536,6 +1537,7 @@ int assoc_array_gc(struct assoc_array *array,
>  		goto descend;
>  	}
>  
> +retry_compress:
>  	pr_devel("-- compress node %p --\n", new_n);
>  
>  	/* Count up the number of empty slots in this node and work out the
> @@ -1554,6 +1556,7 @@ int assoc_array_gc(struct assoc_array *array,
>  
>  	/* See what we can fold in */
>  	next_slot = 0;
> +	retained = 0;
>  	for (slot = 0; slot < ASSOC_ARRAY_FAN_OUT; slot++) {
>  		struct assoc_array_shortcut *s;
>  		struct assoc_array_node *child;
> @@ -1602,9 +1605,14 @@ int assoc_array_gc(struct assoc_array *array,
>  			pr_devel("[%d] retain node %lu/%d [nx %d]\n",
>  				 slot, child->nr_leaves_on_branch, nr_free + 1,
>  				 next_slot);
> +			retained = true;
>  		}
>  	}
>  
> +	if (retained && new_n->nr_leaves_on_branch < ASSOC_ARRAY_FAN_OUT) {

Hi Andrew,

I'm sorry to ask this of you - but would you be willing to yank this
patch out and replace it with the v2 I'll send in reply to this? The
above test should be a "<=" condition, not a "<". And of course you
caught my spelling mistake on the line below. Both will be corrected in
the v2.

thanks,
Stephen

> +		pr_devel("internal nodes remain despite neough space, retrying\n");
> +		goto retry_compress;
> +	}
>  	pr_devel("after: %lu\n", new_n->nr_leaves_on_branch);
>  
>  	nr_leaves_on_tree = new_n->nr_leaves_on_branch;
> -- 
> 2.30.2
