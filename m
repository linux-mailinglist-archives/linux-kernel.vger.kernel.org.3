Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7CD5A2CD8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 18:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344678AbiHZQwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 12:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344837AbiHZQvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 12:51:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF68F22
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 09:51:41 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QGVhLG024652;
        Fri, 26 Aug 2022 16:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=s5amxBEkmT3Ab4jVnZlHiHHcgpkclIg4EWSi8Ri2afc=;
 b=LmD8t0C6K0XGXIlXeLJr7k3/ySkOTUiwMh/uXxxAV8767wLK1GcSIqlQlifs/bhdK5Uu
 4mrmi2HjiQpZBbg2zUK4Bwqbj9x7fL2zlyXhDlbQdK26cmU+aCYQILThO1Ati4PY3XUt
 tmaBz5wAJDEuue1iVRsyeP+JjcoVvZTa6aCd089Lw1fZA5nqrGCEfwCEXEG1m6AiLHHJ
 3X+1Ov2FEB1KclnSgQNBnZVFjCGBcdcF6gUAEUgqRa+CuT0KyNgDG/eqU2i/8UA3DsyW
 iOUo8t7MPodmFtUG83urC5KT2D4Xzs0lAMQVwSPBgizfLc8sd+AvoIaIYhT/gmnpPSsM Wg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j55p28afb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 16:51:15 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27QGoWpx029883;
        Fri, 26 Aug 2022 16:51:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n5r2366-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 16:51:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bodoMscFqzSX3Q59eOmKJXOiMLJrxEKzirXff1CvRwiHnw2AXO1TreIdNy9Jeu3bQeMNVPE9WcAjYvHr1cnMEH0BxWgPzW1J93b++wNYiXMA35hgWoJh5OmcLcWCxXQcuRRftqlxIe4Jh4UkFUPt/UnWmAFYk0Ah2Uwlc8Dic+/6lE/HhhoBLtnT7atgINsmZJwDXDGESDVzUraDQPInrbuD9LerVv7IKkChQOoCibgHNkjzGbC9EzGVms8nek5LuI9LqBYDnxTYXHa2ktknkPstGcOiCbHAVKdDpQpV58Y0qtEQX5TpaAvyHkN01oSqkHthAR3AolY7s2+GY6eMyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5amxBEkmT3Ab4jVnZlHiHHcgpkclIg4EWSi8Ri2afc=;
 b=azlQBEjEL48Ke4TcpwQucPjwoTX7uPjBswl8U1tre2etV76ipjfXphab9m4AJMd1Qnu4v/o80OHSBTLIY/UFuQPY9+h8i1HzCOH1O1Q5Md5FLlnPzol+fvuUuww3FINbnQomt2la5/Ej3qQiw1OW9aftkaBjcR9gwi1u9MqTTKwQQbwXQLbgDQZ4ytUUHj+h/YBij6nYhpIYoZyMiVmDHt1KzDMDR5n6PYdJfNtsBXRpg952rBh/CYiF5nSE3kccsw1ltSKVkGd1GRRLsNzJS3SyK/kJhMli6zzongSjSbJAY1VOMXg1fELtrF2tmwb5U6pE7+43OwIP7YUR4GFKKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5amxBEkmT3Ab4jVnZlHiHHcgpkclIg4EWSi8Ri2afc=;
 b=hNU3qPVOEBr0SEpoeISgFwFig6SaU3qZqAlBo7B/FCsbhLghOsyW2j+5ob8yUkqgm9/k5O+IPEvLJbDt7l0GwOeP31AFStxCKs3D0z+5S4l+mqFCrY1IUSezH6/1/xPoeKzKLBtAb8WY2pYpgzWCephL//koKVIMSwsAmOzidPg=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Fri, 26 Aug
 2022 16:51:11 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%5]) with mapi id 15.20.5566.015; Fri, 26 Aug 2022
 16:51:11 +0000
Date:   Fri, 26 Aug 2022 09:51:08 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Haiyue Wang <haiyue.wang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, david@redhat.com, apopple@nvidia.com,
        linmiaohe@huawei.com, ying.huang@intel.com,
        songmuchun@bytedance.com, naoya.horiguchi@linux.dev,
        alex.sierra@amd.com, gerald.schaefer@linux.ibm.com,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH v7 1/2] mm: migration: fix the FOLL_GET failure on
 following huge page
Message-ID: <Ywj5/F2MwgVIlEPl@monkey>
References: <20220823135841.934465-1-haiyue.wang@intel.com>
 <20220823135841.934465-2-haiyue.wang@intel.com>
 <20220824113858.9f0a2200c4d4875a5f4da31c@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824113858.9f0a2200c4d4875a5f4da31c@linux-foundation.org>
X-ClientProxiedBy: MW4PR03CA0087.namprd03.prod.outlook.com
 (2603:10b6:303:b6::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e4e73fa-f2eb-4a94-e065-08da87832e68
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wHfiPKHTdYM+rF9Ahcr/JbFqTiEPAgOlS2a6ZGg4vksRrh1UqCepXhkYKAPKyo4dvKRi3Ut2ChkCa8aYFMQzXOIywZg2cbDsub0SaCQQN36jEXqidLwWBdvNystTCFFCknj/sKhALsPm4O+3XBFARdxc+RD06yXGR6IcPHsPLSvXzw5JaxxSIzrUn79sVaGkwzga/sBdH+qY99LmuiycCHqGv7bg5dqNnBIquSM977+MZr1a6lvT3nASeP1Lp9PtyuqSfd8G0tObdFTfmf/0c4bozpdKHGazwWNsOdyxpoQG5BxYqlvYaaRQcAm82JKwF4521H74a5kxdS4nBb9O4ENkTdmu1DAlN0dDLLNanHzWjahWD4YI5jN8AbtvGibwwJ0NQvBUZqJVsEieflESp38yiAV7MWbCWnQWCUWwmh9WPJLHy9d/uNmvgs+xWCFKpMpcZFeYPL078FSH2KguWsHWBlPivfKHD9cYR/v7VZCvDJbO5/Gf6bYihvLY4CppcRBqd3heXSFbl2nFmaaqmngOqy4GBNdG0Gni5urwj/c6vG1lxNp99bl8/nVA30h+Y3qnLUvDh7vxV9Tpw9lF4qbrkaIbdBbWlv/642ja0PMbD6MyD4h1V9qPJ+saHaWzRoNr4lzlKxdAlHUVg3iqzIGqajPvP+MH/+XKIdg6aQLoVfvM7Kw9/G/zYc3Uc7KhI7IgEsYt+LOu8LuygE6oZpympKM3k1IxMPslx/MnNT98xreSXymUMTAfg0DYkIGLaSdsOHDscbVeUlYh+3tMO9rr1xYhjUxmLWaOJzMltwLiX3Rcq7inzlZHUYuFRsexur7KyusLJGc/wV2chxZnJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(346002)(136003)(39860400002)(366004)(396003)(54906003)(9686003)(186003)(478600001)(41300700001)(6512007)(966005)(33716001)(6486002)(6506007)(8676002)(26005)(44832011)(7416002)(6666004)(316002)(38100700002)(6916009)(5660300002)(66946007)(53546011)(66556008)(4326008)(2906002)(86362001)(66476007)(8936002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bD1Mvez6zHRJ798DgVVX6QpOpFuqhs+bVE/6a/kyYupRqXUDRvoGr/q8XlNv?=
 =?us-ascii?Q?yLD/MnUyK+UPl+w/TC0D4oqXYR26kyVlhkvZTIcKnnN3FZjGW+J8gurKVeLN?=
 =?us-ascii?Q?6rc2+/MIqhGEpsCBDKAlzy1cqoax9sonUR45nGTsEbPymOcHcN3m9KJgahY+?=
 =?us-ascii?Q?7uX0Fz9fvEtjBA1bQGik+J0vNXF3O65V5W6bTtSIp1jBiu/uSHsHog6qToHf?=
 =?us-ascii?Q?svzHr/gohM3zt17F8aW/ryk0FlRV0dU7ZkG0UZXH353xMQ2Tv5jjyt3KEZHT?=
 =?us-ascii?Q?hv2y7bnUCzpK+vwP+GYaX+JUH3c/C/dXnGLwDJMuGygn4Rbz2o7orcoTclCG?=
 =?us-ascii?Q?N/uPjqAp11vHIZOvaifuj4QPa+PngKkAiTCh2wxVgvy32MVd11S4DDPz8jVx?=
 =?us-ascii?Q?VC/7miQ7MVC28HiP8KZlFmSqjy13KHmytF6cQEkOg0REqpDp2V2qdNG8vQK2?=
 =?us-ascii?Q?GLnwYzXin9k2lRbR5YN7+H9JbXZ9Wgeq3Z229M7azwaaEChiANGtNx9sutkA?=
 =?us-ascii?Q?j7F5vlr/PlZA053rEDPXzTsi3iyp1y+3HZ+dFwxMCkNmnDszw6lx+UZA7Yp3?=
 =?us-ascii?Q?pWusC1pA2hX5csYbRD9/k9g0Ldi3ouX4tHtq8rCALFzKgIltXRy4yiv8xWT3?=
 =?us-ascii?Q?/1SkAdEPhZuxSvikX66aN2ouIQr+KmcugSexampf8Eun9t/9P1kjzt4lmjFN?=
 =?us-ascii?Q?YfmLfZatXfwP1pMHqIrgKkJxeS7MNsVVvtkjqXqo3OBOMrnjPYVVVUYCgYm7?=
 =?us-ascii?Q?kReCqyyRd3ni6A7N4MkN0ecCU3GhBsfwqvMPPxVDNPjOz2tnkZp3ozcoiUsX?=
 =?us-ascii?Q?zVfWCdvjE0WEvlF4I6lPy5S416QonV5kcbzCjcxEAnYiSoDxSPT3DN5WxT+b?=
 =?us-ascii?Q?8RpfACCtRiHm4Obylrvd9kuN4qdIfu2TnVbt6GMHZchg1eAzAOB6QEkoTgnW?=
 =?us-ascii?Q?ZQulbAsvtunbcoRtBJ2XKP4dzvEKR81bd0WE2OhjWcjdqx97ErCLbMFnCGz1?=
 =?us-ascii?Q?ATNrdE3L6GFg/pzesyEyG17eLBjXJS78DEWDObGdeJ2VBNzHtpNuLFHS3on0?=
 =?us-ascii?Q?i+nUZs3b3QPPMJ0vrnn28p49481LLQGekGgT29B3Uq6t0BN41MO4UYoW5OwQ?=
 =?us-ascii?Q?DgRMJ/mFzNlCdsH/rnmiwSQ22pppxkKSkarEjXv2xvaxvXIBzS9H6wuAf2qt?=
 =?us-ascii?Q?cwVfYcjKK6PNuT9POr9BmD9GEqLnmn/IU7WkJ3RDClxAo7Meljts5zyCiBsB?=
 =?us-ascii?Q?MrHi9uW7dZ2KvUTA2GRRS/BINrPOMR1HdDWXMZP8HcTkKgd5NG/76Y0YIUB1?=
 =?us-ascii?Q?10/tCP7WbivnN626qBoOYVIkFBEjj6VC/dDUl3g1mxz3tn+h6SVH2KamG9Vm?=
 =?us-ascii?Q?RNtNyyYoT3SKp5kAJpubCYSyzN/Gr37s8mrxnzaxO/w4Ylw0vF/TQSO/V88i?=
 =?us-ascii?Q?tpSWeDnQYcfYB0BI2cR//PyCX2R6kGQf8nh/G/A3VVHkFNRhwbnHTUgUFtgq?=
 =?us-ascii?Q?qp31nakFK+eQM+XWjOY4ssE6guZv2anuH/uPumpHxpKw7bv36xE7FXHc6neq?=
 =?us-ascii?Q?+OgmQP8/eRCXBGItbLreJnLRGAPQZ5u7gs2Sa6pHKiuKw+HrwS6AE4NtxgUm?=
 =?us-ascii?Q?EQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e4e73fa-f2eb-4a94-e065-08da87832e68
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 16:51:11.7636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qYaF6Qf0/qzGZD5hDyiDemHlmqNX4SG0FaJx9hMZqcmjyTH/T40l01VOSygABh74KqeEVYLBoE45JY4k8k85TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3366
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_09,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=913
 phishscore=0 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208260067
X-Proofpoint-ORIG-GUID: noQLl7SiTEDf_qiQrD-gp5wDtfBBG72w
X-Proofpoint-GUID: noQLl7SiTEDf_qiQrD-gp5wDtfBBG72w
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/24/22 11:38, Andrew Morton wrote:
> On Tue, 23 Aug 2022 21:58:40 +0800 Haiyue Wang <haiyue.wang@intel.com> wrote:
> 
> > Not all huge page APIs support FOLL_GET option, so move_pages() syscall
> > will fail to get the page node information for some huge pages.
> > 
> > Like x86 on linux 5.19 with 1GB huge page API follow_huge_pud(), it will
> > return NULL page for FOLL_GET when calling move_pages() syscall with the
> > NULL 'nodes' parameter, the 'status' parameter has '-2' error in array.
> > 
> > Note: follow_huge_pud() now supports FOLL_GET in linux 6.0.
> >       Link: https://lore.kernel.org/all/20220714042420.1847125-3-naoya.horiguchi@linux.dev
> > 
> > But these huge page APIs don't support FOLL_GET:
> >   1. follow_huge_pud() in arch/s390/mm/hugetlbpage.c
> >   2. follow_huge_addr() in arch/ia64/mm/hugetlbpage.c
> >      It will cause WARN_ON_ONCE for FOLL_GET.
> >   3. follow_huge_pgd() in mm/hugetlb.c
> 
> What happened to the proposal to fix these three sites so this patch is
> not needed?
> 

Note mpe's comments here:
https://lore.kernel.org/linux-mm/87r113jgqn.fsf@mpe.ellerman.id.au/

It has been a while since powerpc supported hugetlb pages at the PGD
level.  And, this was the only architecture which had pages at this
level.  Unless I am missing something, this means there is no issue with
follow_huge_pgd as there is no way this code could be invoked when
commit 4cd614841c06 was made.
-- 
Mike Kravetz
