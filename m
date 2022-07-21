Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF5357D747
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 01:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbiGUXOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 19:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGUXON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 19:14:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81D077A5D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 16:14:12 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LJfSRN022522;
        Thu, 21 Jul 2022 23:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=xhacsRNwiJidwg1I2IpUvqt5lmmtJst/IDF/Vy29Ipc=;
 b=nPvP2RIQTfywhUl2fDb+tyftQQILePBpznI4a9ThFC55MDn1oTy6K/cO0XMFNM/s2n4T
 fJm/mujThC7kErctvGXw3PUM1Imj+7tTLLAZUtjAt6a5/orh9Cw/bLs6MihefrE5QH+E
 KMdUJlcMVqP1jEloaLEey8+EcxjQv6wUANRmDKMYIPR/wX72KJmwS/Dy1lYyaUVGIC4+
 tfK94LPTleHOm9a7pw9g/wRtXoklfFPXZFvstgf4vQtwC4ylBujKXYtFrP28GSL4U0Wj
 fQJAoAi4UnZdE3xWA2x+zArYW4V/fz97w4Aoys8oD4ap3R9I1kbwn6cFnj8RG/oSLAr/ 2A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm42p0th-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 23:14:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26LKavdb009851;
        Thu, 21 Jul 2022 23:13:59 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1gk3jbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 23:13:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUsPIPblYh8NLoSMp+Ktf/8wXrIrFlIqDXMgX9E/3bcnpXl9uAwyszdFqyhjl+lLzYqjEePIvBFpWM+136dSB0QULV4HrOr3hGD+aV2WdJUKe0HmRPOYdZ28epDBXgaSmiypB7e8jMUHlmdSufbQE/7O+kPu2lQhBFCU4QhzwFQs246J1aaUx92yYAq7NQb9FI/kEsrOKE9E4iAtQn11zj43lW7jiEswH8fmBQmUSVeU/H/UXnC962BqPzZO2+PLMqpJ3tgaJQT5z4qyWqETjMG70hM/5HnjkxXs/f+Z+Qhk0G+xhJ3K16nSj6kVfxhDjMNhT98CvTcFFBB70v2+rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhacsRNwiJidwg1I2IpUvqt5lmmtJst/IDF/Vy29Ipc=;
 b=W6nw+JBRwjM6icXIG7vDjxGR2soc0D7BdQ5LKP6++X7RKvBpOkb4QXkjDmX5JfZjreSmIEuNWPe+W3mxmy62Hrv+ctOF0lXB4joZifdE19D35/KcVqiHSKtHuyw75sDNwvHlSBPNTGOpus/Vf2NR3HeSXWrkbXvDXpsAracmYRF3D9hdiNeUdp4fOPpfXmdZSZ3APtQDjf0hIZJr2A4aMb7iync5rLLljdx5mAFhJIhno+z48i8PrqaHHR5igBt7rxD6dT+N8+Z+z4UlkGqW57OZz9AsLTxIwPG1COG6gVVtBsKBO1Y9lZVttfqaqEpcPH91acka6asQdoULUBiAiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhacsRNwiJidwg1I2IpUvqt5lmmtJst/IDF/Vy29Ipc=;
 b=Eh+Haqb4IUFbA/Nr8qI5MAPIZJ0ELvcW/ygX8fF6wrVJJetuVcZmM1xZWL/z7DeRBsS2OMzCBxieXbSkruq/FXi89q5RazwyFMuTZ2tE453rdF1l55oOMC2pq3c/aHb1lLLjwYKTr+mz10aP420ZahHfU98OJ/V4bBc6xtx0b2I=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM5PR10MB1307.namprd10.prod.outlook.com (2603:10b6:3:e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.20; Thu, 21 Jul 2022 23:13:56 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%4]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 23:13:56 +0000
Date:   Thu, 21 Jul 2022 16:13:52 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] hugetlbfs: use helper macro SZ_1{K,M}
Message-ID: <YtndsNoQuZqXgP++@monkey>
References: <20220721131637.6306-1-linmiaohe@huawei.com>
 <20220721131637.6306-2-linmiaohe@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721131637.6306-2-linmiaohe@huawei.com>
X-ClientProxiedBy: MW4PR04CA0362.namprd04.prod.outlook.com
 (2603:10b6:303:81::7) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2bb313c-e28f-4c70-8764-08da6b6eaf43
X-MS-TrafficTypeDiagnostic: DM5PR10MB1307:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eUsPGhUQkf+CkehuerAA18HNsgVwVXIcBVNrrlSZ1lAI2XEUn4TH8D3wP2inCvAgQ+b3qk727dMv3z9ZRRO8b/W4qjGsQrBAD7NOo/ocBawM8f62COBsxXT5xDgwPcVhHPeuH6IP9Xe0RH8dq4gK0z1jDTLh0cxgHDaoE0jLtwxrn9FI+n0BT6NWsFsTO9ndksTemxHdXVqtFdvraWBQITIGAYl0T+vnE/Ojd12ef+ib/3C+rtmkEWzCMc+Z2i+KRjDADTEoFySHKE8s1JxEkYPZkeuxebuQwcxDm6xF08lxq++bv9nBQbPK9JDySK7RJd5jMtG7y7Ni4Ea1Sz+2z8/kV+qcqDzDlNYjQeU6ZH330656RwI1/xgmwr58LxS2bpFfExcCGruJ1YrpVYACLDPtK1LvjO7ksZvvcCv0LFZD8WGSRW820sTlsRTcESgZWX43NWGrjKGm73yuJ2tGv1QqP+T2zZD+9htBUciqIIHL6v/RCam7R7b5hAJhw6qHaepfe6GjmUFEgsqmnY7hrjUdBHbPsgP2jqJc70eUMETgTmpbX3nAhfaKYXf8SRbEU0ag1Y6flCBqghmGUrYu+1toBC9Ixn/WkBUFeuMV3l2kk+rTrF2a5Qe6kXbLZV4Na5omeOlWVYwWF1R/YeMqVS2eAouWb0/tgvvmwwxmMPGN2/99JlC8uDxZwc2INpoGgWPfi3e/prpWZJmCXRfIEIdE2paz+t2kJsNq/OJmP32i+NeRxA1vXXnXGcP+MLD4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(136003)(39860400002)(366004)(346002)(396003)(38100700002)(4326008)(8936002)(66556008)(66476007)(8676002)(66946007)(6916009)(2906002)(53546011)(9686003)(6506007)(4744005)(478600001)(26005)(186003)(6666004)(316002)(33716001)(44832011)(6512007)(6486002)(41300700001)(5660300002)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l236anHSV/fWjn4gRrumtjCQfxmbokRe12z8BhXOTesA12GuV2JBQfW8Ox40?=
 =?us-ascii?Q?Zok9FXdXIloxBzY6CWRy/3fM8dExj4lzJZVW6Tqh9lp1R1NuNa66AX9F7ylX?=
 =?us-ascii?Q?RJdsl3DsVy2PBQA+SQEME47bEO6QuCqU5xVXmAbBQEZsWWhNnEnG76WZcpUn?=
 =?us-ascii?Q?TbYTimY+fyO6K35kH1CB1jB4KkNecPIyWtp1fB2TX6CuDdlvA5A0UKe7LOMt?=
 =?us-ascii?Q?s+52vP+MGIC/744yM9L7twApVheRAmG8/WDSHKX21bdFwxK0DTgfZBFZZTAq?=
 =?us-ascii?Q?Q364iPJcKEy4CfL2dXhOz+WzDnTIPUaAuKnaAfWppcuXS6ZIlR2bk6GG0wMN?=
 =?us-ascii?Q?6gTt+HM6F+cy317lyUQURUVt6UXbCFbZjiIj0FLM0Ga83z8nOjxJN30JSZRD?=
 =?us-ascii?Q?fR/fPKVqLEfyI8JvrbveUH8g92wE697n9QOtW1zcSslpEfngxpoTVwp569Pt?=
 =?us-ascii?Q?U9grLbpzS+HLBalcqllNBTtobZg+M+9b1oSPziPJ8wGyriz2vZiQXC80ssSQ?=
 =?us-ascii?Q?enz87LFqSsZUgFmyaLNCFsWyazI6sth99vhD9I+aU113YgdwOOHom5RvYIyw?=
 =?us-ascii?Q?k+VsjGJRBb4nhII/gNHuKfuPquUA5l4ij7tZcUe+If87pYcqPdvxzd0sqvK4?=
 =?us-ascii?Q?HYTxPqj2KlpKf3k1/s/aNQi9OBB3VeLXUQxCXspLDSiFl62ZzcMw1Opkyg/B?=
 =?us-ascii?Q?0tgrpyiZI2NkiiMK3/8ekBINRCQ72ndk0iQcrEwWUQDYoeAWAMq74IhSlBcd?=
 =?us-ascii?Q?873S7iZwooX8jZoRyGV5d5tfRmimBUHYVTT4Qi0564fK9b+RnAGHb1wb/UHC?=
 =?us-ascii?Q?zYffkWPhp3czF+uEtR3zduRiZIL78Ts9CaXyEi3u3jyfRMhbmQnpVVdB7/WM?=
 =?us-ascii?Q?W4yVZZMX+WDi797XtzwB8yVxFnuOHSedLH/iuoZsjakiZeslbhPnkzcHSVr0?=
 =?us-ascii?Q?fJISczlu6Qj/1PuH/WV1tGyAwfrTzRSM9jSw1uid3kdoRHvmjiEawL5OdY2l?=
 =?us-ascii?Q?cnU2qOY6oz2K/NJ2les3zi1BaoQILaXvvqfK38+ZXAFdxNnC2H2Ermhpuzx6?=
 =?us-ascii?Q?217JVmJyZOSH0z3F97tzgPaDLxFxFAn/MxasHVUDv9dFfBzymzCZQyWVl7jq?=
 =?us-ascii?Q?X/BLBoZlF6I15ims6nScqf4ckQyVltiW1fRzcl0rvYQly2JE8b0g50S91OFE?=
 =?us-ascii?Q?AeBlJzD5PUdQKrjTfjBgyy1SsR7t0N3UYMgVYFzsoDjkOR9PzCpl4kBnkxat?=
 =?us-ascii?Q?so6wQODHoJbuH2qmSeifDI0qqF7dkFPOMNNfsOchBbnUlhp4Og/7ZMPPSTIp?=
 =?us-ascii?Q?BUdEl5HZ+prceu2YyNH/IE6rwyxSEaCaOLmzagYLcQ1x7AF9Urt8fzxrNJwM?=
 =?us-ascii?Q?LX8wp9IWYxY1wXs+WRGCpgVYWPCpbpf3VTyfNbiZWMBg14eJtHLEiupd/Aii?=
 =?us-ascii?Q?BvfsBJa0Tz//VvBpTE0FHhQs5TpHuv/vvrmMu1NwX8L/p3D9mPkr9PDAN954?=
 =?us-ascii?Q?Iwbfw3no+BCWups5LcxT8fL0+yp9i+gTgN1Uuy8xjtNuXkqPPEOuREpBaSOV?=
 =?us-ascii?Q?R76+8lWIgScAS77lPuAw3xMLXqZjTKLJNocG0YVHv+wHSdhkcEJb5O0n+Ucq?=
 =?us-ascii?Q?bQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2bb313c-e28f-4c70-8764-08da6b6eaf43
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 23:13:56.0015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q71va337/ACBOR9Y0tzcnCDhrqCsHyQPHrGgSfmGg4AzPM0TJO4hBzhhuCJXcd5vi80dSQO8GLM8MyRExMq3dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1307
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_28,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207210096
X-Proofpoint-ORIG-GUID: lIlO78L2jbtTsJw5BaguwBQggNvp5sJg
X-Proofpoint-GUID: lIlO78L2jbtTsJw5BaguwBQggNvp5sJg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/21/22 21:16, Miaohe Lin wrote:
> Use helper macro SZ_1K and SZ_1M to do the size conversion. Minor
> readability improvement.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  fs/hugetlbfs/inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
