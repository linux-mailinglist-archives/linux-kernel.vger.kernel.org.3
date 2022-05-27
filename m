Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1623535E97
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351134AbiE0Kqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351179AbiE0Kqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:46:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EF212FEE4
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:46:00 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24R96SKB021674;
        Fri, 27 May 2022 10:45:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=GrdGlBgsQ07yAoPSFjQkBZ7t3bANh8a9HzJ17WbWoLk=;
 b=Y3VVMdboIDARpmowGsJy6ExPgRIEXaJm8xaTycUq79Kwl8CC1yEe8BP1c0N7co1OVfT1
 r4J+kPIHzwbRQEHHCR83iuy3w3L7GVzIJB3InaaXAHGiNGyfnkfb2EKS+pu/Cd2sdXm5
 Pyxo0X/AuI+cDRzPvtS1ztLcW1A5VlWu99FyyR+80bwDBBbFXD89+qeaUkDkUj1XxziA
 9qcmN1u1L+sitJiouvLYadf2onaXBS00VB7C1f0TP3rFuzl9F03uPid+bvDrbXa9nLri
 ertCR+nZREXaBtnoEKSo66EG20osflAbuBH3kE9jqm0fZic9ajCfA5S26/GYB7tPlN8X 9A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g93tby2cu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 10:45:56 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24RAeCTr002654;
        Fri, 27 May 2022 10:45:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g93wx6a0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 10:45:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1z5zv5zjCLC2zmDN47VWrGBujptubfnMkNmvSLI0ET2MP6FNVQ4O6CvpNnDDNKLop+nCtF8WnKkcAwyLvb1qglsrYJEpokPO6N12syYTjpBsYLvtHlhKEytys1F6zSPkLuh66q0rn28wnqGq3lOFbZS8tV0ySazjWghPkYE5dDMg/vytmVY+R8sQEBP1CLOm6xWqEu8BQVkBB376aRNeVQoKPCLJ+0+nrjrX2ut0TTwWJJu2fOjf4N88TF7BiOL/Fc50JpM7YSU61mJWPuQiabSJOVR4Pg46hWjKSTxlc/70PgR6eICgUbwQH0c7bjy6GfrpXNs8jN0RptyPM4W4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrdGlBgsQ07yAoPSFjQkBZ7t3bANh8a9HzJ17WbWoLk=;
 b=EF+jHk/rksD/QixfIjyOiBDNxBgrsa3z6qnFcMtsvzQeV9AyPjnPmYuD4TPD+iHCs8BCqY4rNEi5ybh2beG8e4JYWGBVQEKKCaPirBlK7M6AyxKMlngThqYcQoijjpaM/sjyVB/p6ExO7Al0pVMyZ3//71MFkDusF9QixLXAvrPSEsyFN72sg7k3otd+FPc9awuEBb1eDO4T6G7VAop9xha4qE7IZlsA24YJmDs2OFQxToeAGj+VzgmDneQr3khk0iS2q3FAMsbjGU1+wemv0GXInAPehVeH+UbrADPzQiQ2chP2mRGH4c+xTcZ6crhltRl6DEMfwujezISrQRkvpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrdGlBgsQ07yAoPSFjQkBZ7t3bANh8a9HzJ17WbWoLk=;
 b=oaDwHQRYHCsyZVAXDUxMu5JgdmB2copVHN4iePs7oGaAL45M4CJIJXbAgmvdSHwep3FJFUXgKzzXHpKuFgx/6Mq94vil1kfu3Galivwtw+7/EHoMUIKX6F+O2WA/1WfkgTL6egiOuH543RlylfLa7+h2GRoJzUrRwKdmFmUtGqg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB2796.namprd10.prod.outlook.com
 (2603:10b6:5:64::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 10:45:54 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5293.013; Fri, 27 May 2022
 10:45:54 +0000
Date:   Fri, 27 May 2022 13:45:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Alex Deucher <alexander.deucher@amd.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        amd-gfx@lists.freedesktop.org
Subject: [kbuild] drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:1292
 gfx_v11_0_rlc_backdoor_autoload_copy_ucode() warn: should '1 << id' be a 64
 bit type?
Message-ID: <202205271813.mDvYkTtW-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: 2UKLI36QZL7CTEIKPG6BDTNNPK4INN4K
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0034.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::22)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97bbf557-f71e-4902-e423-08da3fce12ae
X-MS-TrafficTypeDiagnostic: DM6PR10MB2796:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB2796D441A4033A66953F75F68ED89@DM6PR10MB2796.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qLbiXs9uC+ou36XG9vwTN8WuXADHabFKQyXpijWzTS7rAV6wWKD974u+l9c/GtvJh2vWAZqPUNqUwafgYktre8IZbymZCzfJ/gEUXjPqg6K6E6QHB/fI6WkjMnDszl6mqNLAXEHAk/wiu+/kKn3iPwcnuhwzZvFF6ld7vdMNVl8HnkrFV9nXUnvPWrcVKZO2RqjGvy+XuPQtbY7CuqMNzL1J4hGcgMp//YIWsUlb3b8vpOR0Uc+AJjs0rVMGc1PnnE8voNbsRND5Wn6sIAw+qsfh3tIgpe/ePl66RjC5xTKBdFh5pw25F1qAyc9Dowqt1c6FObzpW9jQUcGYzO4XV5TDAeXD8HpMqqXHpLAiWqIS1VjbA9ZtfbNwvr7ajlWhorUvOfaxB281v127NVOWbXa2JNJ27NikghA13hfccLpvqmDFC9slATHZaDaCmcEYaDgjPorKMjWLzPDeNLUfBlkEP8BxPBwmUhotjDqfi5iIIpuSn02M5dcSnwiJPqNVfw0BZuaWxg3ve88t6qUq8Dk6o1FflZXh6XI7rnn1ccfD04Po87uHnLJgtO9iwLq2Hn9xd8jSWCVuvdX/OkNg6KnfLgUJVd5mLxbu6msh6GEtXNGCxpn2m4Whn9EpHCwgPstSWP84HfGxPEoBMJTGaik0r436wLGPjAEJv/9XfNDsWc7kSe1CxPduYfBboxasxMi/VUcQPGvfSLsuPPHojY520b/74a/EqYk5vh5ldO05CZ07ZMGXzR3sT1eaLFn/Ql+CB9w9+Zd4ZW1d0LlM7NeXr05nC7+5aiJuOYZRRKeJsJW400EOcoX0bmwiTBigGwVdeEcRqzVUBtLpGB5GWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(66476007)(8936002)(36756003)(44832011)(966005)(6486002)(66556008)(9686003)(6512007)(6506007)(26005)(6666004)(38350700002)(38100700002)(8676002)(4326008)(5660300002)(2906002)(316002)(6916009)(66946007)(1076003)(186003)(508600001)(52116002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cwj2bcX465jzTV9Y1KEcjYSgMLRG2oeDpue3CjZZNPZIy9rUIGqgzg/QCcWh?=
 =?us-ascii?Q?69GAk5PbpPgpqToA2CF56p4ORLETGeNVc7a4UlrY7Fjh+/lIoHYeTaYKLdPx?=
 =?us-ascii?Q?r6iBQ3QdXoFqGyQOWa34/bbILkC3FujgmyjYh3p8r9RIPt+ea9z1dkP9c4TS?=
 =?us-ascii?Q?64sJdpjZ4f9WtzHKMXe1mUZMQzhI7oSHWIQ6jaYY0/zhm1InkmbGsQ+MCU4B?=
 =?us-ascii?Q?IStDCMy7uouNTbdxMJy9tASvku8cKvQmDhvmoF+ipXqlRf7gN3kmKw/ayvyZ?=
 =?us-ascii?Q?1unQAHVfUUwOC5/K6DwMg54b9ytWOPBWCZwYg1MeLJ5lSal2YAax6l5wz0Ot?=
 =?us-ascii?Q?KL8jOKKXlidThtYvzl7CITLjlEamMESppi4xlk30GmL1Y+UV+4ddzUxJtmst?=
 =?us-ascii?Q?vPWEmhhyCBKwlVoDuFpCidFvc2wc2MJfZaIHRuarmaDLsa/aMyJursT2j0qc?=
 =?us-ascii?Q?Th71EBEBH6x/mw9xsP4x/y7s8VRcXe+D1iwEvZd6+PEBzYgMb9xSQDCMVUkg?=
 =?us-ascii?Q?mHqpLuQfKsfz5VJotLHu6xnOZMOAnM59LA9VYYpLnStglks+RUq890dn+Lnm?=
 =?us-ascii?Q?v6t9/4nM0HD+5cyO9HSMCMb0b1XlbPFf0B0HUs2QKCsTH2WBePFMFdLg9JgD?=
 =?us-ascii?Q?ZC2rmGCjYAaphonjt84YWOx6J62VudgTxPKfUcxD+5TjhsZL95JkNCun02hA?=
 =?us-ascii?Q?YXqWfGc3WpjiAVyXWsTvXY4IGJNi0VTFtjNU1GR6IdWP3TgkDXjBjR4Tpl7Y?=
 =?us-ascii?Q?fOmfi8khoHSHURDuja4f73S9JVZdQZfGWZYZl9AUGgKnZjD8Lipt/fwd09OF?=
 =?us-ascii?Q?WzGoH5xONATCrAlUKxeUhca1dvriCpS3LEWPV8gXbfA4z4zulb3Ftin3jnxH?=
 =?us-ascii?Q?Am9zlb93Ipol8gWTdnEeKQdTApIQCE9DTUtE3cZZ/dE0mT5gpOZ36FP4xfcW?=
 =?us-ascii?Q?v9ZNFX+wZhPXqvMnQjWi2PzaFPFSTvLZO8C6L0rO0zCQXTNEEK9edGKJfByG?=
 =?us-ascii?Q?a2HeQWNk2fB8MxD5bDoE1fdi8RgNjuxcZO9Db2iGfu8u0cXcyiRImd5ObOiK?=
 =?us-ascii?Q?ZNqYxI/45xMK0UfO25yvoqYzRQr8UxO3APZWgQhaB59cGncvQkPU5/pqUptF?=
 =?us-ascii?Q?rrt0giuGVEoLb8fDpbPJ0ugUOA1f+Nn7P7QETE/vVfITOP1+YhUV07bGD27I?=
 =?us-ascii?Q?NSYYYOPa0q187NAnehIIyk0yc+rvS/ZlU0fZUWymdFFTRN9ZeYXWcUR2s5/+?=
 =?us-ascii?Q?tXQFJJ8ln/p//17ckU8Jn3AqOnBS+yLwB2xNKCSkiF4VT8VPNO0N8iYuTgH8?=
 =?us-ascii?Q?DHti5PkEAcI7mNf5MN8jFPejyTGs8TxfaaGDE/GGaMxzGy+tLqYYMaEVDSiZ?=
 =?us-ascii?Q?xSBsQPdGWOoa8DBS98UCj0q4SgeQbJIu0/Kjk5JQQzjymmDS688jrytcx6To?=
 =?us-ascii?Q?jWtmxH2DFBuEtMnIwtLGJbev94zsgowvxD7C6Ghrm5vD6wCJnAA5Z4vUIkrE?=
 =?us-ascii?Q?swYI7SUzUf3nK6ReSpPh6LNqKHdWKJp2ULzItCKRslQrvUNH3OZOb2QC3MHW?=
 =?us-ascii?Q?zTibpHzpGzXfzzMUtriXPE5VYXneCZ21dHd/K1/4H0c0fZCU/uzDd/CRGGt9?=
 =?us-ascii?Q?jDjLQSOWftKAezLyVPZn6SOtMlxxQNMGA9EqMcp7FDCJY8esi3kj28WfN2UC?=
 =?us-ascii?Q?RwDSz4DE/xyzNPF6E9zt+26eJeev1NolOPiCU30Jds2/r9TdzdHIMihDliIK?=
 =?us-ascii?Q?Hp7LClu1Iux8rrjp2k4AgTG4d3TLWLY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97bbf557-f71e-4902-e423-08da3fce12ae
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 10:45:54.0298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pRsOnYkd0PQxtNWyJ5MLB1CRkGtVlke3J9fR8uLYFzde7pnMmhfs6ryzUQ/fzN25dSWtGYFceDBD5hoRVGS08gnlztVD+g/JBccGWtOLfhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2796
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-27_03:2022-05-27,2022-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205270050
X-Proofpoint-GUID: 82lRgHmuQ7lJO0taKEDMvFMc3cc-g1mP
X-Proofpoint-ORIG-GUID: 82lRgHmuQ7lJO0taKEDMvFMc3cc-g1mP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ I sent this mail on May 9 but didn't hear back.  I'm not sure why
  kbuild is sending duplicates but it's probably a good thing.  -dan ]

Hi Alex,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
head:   7e284070abe53d448517b80493863595af4ab5f0
commit: 98bae89647603309ca2a5f172299ecc31c5d2db0 drm/amdgpu/gfx11: remove some register fields that no longer exist
config: arc-randconfig-m031-20220524 (https://download.01.org/0day-ci/archive/20220527/202205271813.mDvYkTtW-lkp@intel.com/config )
compiler: arceb-elf-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:1292 gfx_v11_0_rlc_backdoor_autoload_copy_ucode() warn: should '1 << id' be a 64 bit type?

vim +1292 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c

3d879e81f0f9ed Hawking Zhang 2022-04-13  1264  static void gfx_v11_0_rlc_backdoor_autoload_copy_ucode(struct amdgpu_device *adev,
3d879e81f0f9ed Hawking Zhang 2022-04-13  1265  					      SOC21_FIRMWARE_ID id,
3d879e81f0f9ed Hawking Zhang 2022-04-13  1266  			    		      const void *fw_data,
3d879e81f0f9ed Hawking Zhang 2022-04-13  1267  					      uint32_t fw_size,
3d879e81f0f9ed Hawking Zhang 2022-04-13  1268  					      uint32_t *fw_autoload_mask)
3d879e81f0f9ed Hawking Zhang 2022-04-13  1269  {
3d879e81f0f9ed Hawking Zhang 2022-04-13  1270  	uint32_t toc_offset;
3d879e81f0f9ed Hawking Zhang 2022-04-13  1271  	uint32_t toc_fw_size;
3d879e81f0f9ed Hawking Zhang 2022-04-13  1272  	char *ptr = adev->gfx.rlc.rlc_autoload_ptr;
3d879e81f0f9ed Hawking Zhang 2022-04-13  1273  
3d879e81f0f9ed Hawking Zhang 2022-04-13  1274  	if (id <= SOC21_FIRMWARE_ID_INVALID || id >= SOC21_FIRMWARE_ID_MAX)
3d879e81f0f9ed Hawking Zhang 2022-04-13  1275  		return;
3d879e81f0f9ed Hawking Zhang 2022-04-13  1276  
3d879e81f0f9ed Hawking Zhang 2022-04-13  1277  	toc_offset = rlc_autoload_info[id].offset;
3d879e81f0f9ed Hawking Zhang 2022-04-13  1278  	toc_fw_size = rlc_autoload_info[id].size;
3d879e81f0f9ed Hawking Zhang 2022-04-13  1279  
3d879e81f0f9ed Hawking Zhang 2022-04-13  1280  	if (fw_size == 0)
3d879e81f0f9ed Hawking Zhang 2022-04-13  1281  		fw_size = toc_fw_size;
3d879e81f0f9ed Hawking Zhang 2022-04-13  1282  
3d879e81f0f9ed Hawking Zhang 2022-04-13  1283  	if (fw_size > toc_fw_size)
3d879e81f0f9ed Hawking Zhang 2022-04-13  1284  		fw_size = toc_fw_size;
3d879e81f0f9ed Hawking Zhang 2022-04-13  1285  
3d879e81f0f9ed Hawking Zhang 2022-04-13  1286  	memcpy(ptr + toc_offset, fw_data, fw_size);
3d879e81f0f9ed Hawking Zhang 2022-04-13  1287  
3d879e81f0f9ed Hawking Zhang 2022-04-13  1288  	if (fw_size < toc_fw_size)
3d879e81f0f9ed Hawking Zhang 2022-04-13  1289  		memset(ptr + toc_offset + fw_size, 0, toc_fw_size - fw_size);
3d879e81f0f9ed Hawking Zhang 2022-04-13  1290  
3d879e81f0f9ed Hawking Zhang 2022-04-13  1291  	if ((id != SOC21_FIRMWARE_ID_RS64_PFP) && (id != SOC21_FIRMWARE_ID_RS64_ME))
3d879e81f0f9ed Hawking Zhang 2022-04-13 @1292  		*(uint64_t *)fw_autoload_mask |= 1 << id;
                                                                                         ^^^^^^^
"id" can be more than 31 so it needs to BIT_ULL(id) or 1ULL << id.

3d879e81f0f9ed Hawking Zhang 2022-04-13  1293  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp 
_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org

