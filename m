Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8015E535AAA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 09:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347777AbiE0Hqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 03:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239205AbiE0Hqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 03:46:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9980F6AA62
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 00:46:43 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24R5dTRF013206;
        Fri, 27 May 2022 07:46:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=xkrI0dJIo4Yyt99Dn88msowQROoENKZOUXDduvs3Hn0=;
 b=wB/Cgnxaocmv0x0o1RtsxPQHRrs2AFGXEUMbSJFeAUDeSXwlmLoZ/84jeJTBf6LkIMOU
 OLbaYkoFnzUOEXEsfaMtTsHzm3hFMRjJ+tg46L61COwUkGoqBb7A7WAQQ+zDwGXq6EHZ
 /HBerdxUkIqiBNgj81jB9BeFbpC48GQHcLRGt2PSyhlsBiqGvXl+UwHRHDy7zZAe+tn4
 0+/U8YWnfdbXal9BxWTMpBm/nKpjH8PEhPt2wce8S5ruAiqJLw112lAYQJPMjeXNAlxm
 Ppv8yQw4psrPlFDH0zP9dO0FXyscmiQR0kCjBzwnlj3bfltL7CZbfxffKHvQV4bBn86T wA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g93tdxgfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 07:46:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24R7gF3S010408;
        Fri, 27 May 2022 07:46:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g93ws7aj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 07:46:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUeJEL74c+/woChZ43UkJV3dJ0D3zxAqxtY5Fdzv/JQITVhM9FDyoZ4U1BhGyzdKNfQO16+bUhwIuG46vKBHFq+3boO/+HMF57m0uD1wOz0D2oB6DoILcTr0vw3Uu/PAeHNjWp8gdD+efcLS0qmIvtUQUbBA+dNMPEjw3VU/qpa+fP3EI3zZFj1ZTKMuPsPxJl9NTGf33jiGhQVbq0Dgx2NwA9NtlfAs5Z2RFPGRs7xDP+zJFhB8xtG5wk0OSXFwulizLVxTq7Tu0/+dSLfGxvrEUUxHyQJeEE8icZl8acz/oWP8z+aRD2ejDHu9tmYavSdy2Xa7qK0tc2+0UL6xlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkrI0dJIo4Yyt99Dn88msowQROoENKZOUXDduvs3Hn0=;
 b=Ui7lT3QXMFuBq0K05YeHEfzIQ69ukSTjSSSEn967KW549R6bEnATOg3X4muTFXW/IFgU3XbF48c3P5aSK8FHCgKMqdJ3BIsdkdO/D7R1lBuO0Nsk7oZ7Zw69aKSwZbt/++8tq8M/rSsJQSiTJ8Xjw6V6MsJGO6zBigEwy18h9MpScm7txdoPFJOZ/3aWaQ3dQTMjmIrQXHlWeASOMj+fd4gxDceK/PrNECeG0F819hFmN+4ulrAxV+ySeLywkCt9n+I9sESAdnVys2q8rlNMcKNvVgdNx7RbdtlDVKQY7JVE1bz0MiThcGy9MKDi6oWYGxVGZYxXuEXbLFRbkwtP8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkrI0dJIo4Yyt99Dn88msowQROoENKZOUXDduvs3Hn0=;
 b=zirz12Lq2KTJAQZz4Bg8Sacs2eZlArfRkhRluyHpHtGlfMju7rGztrcTRR0OAHJBOJG91FqHddnnIyv9s1YBZ7zgwzazGWVOQ6oxnKTGjGSMOxyiWF9O5sHlIYJPs5bSA2v328maz2OwVbpo7aagdh7gf3iS6kwh4uyE+dmgNE8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB1963.namprd10.prod.outlook.com
 (2603:10b6:3:10b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 07:46:36 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5293.013; Fri, 27 May 2022
 07:46:36 +0000
Date:   Fri, 27 May 2022 10:46:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Alex Deucher <alexander.deucher@amd.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [kbuild] drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1433
 amdgpu_discovery_get_vcn_info() error: buffer overflow
 'adev->vcn.vcn_codec_disable_mask' 2 <= 3
Message-ID: <202205271546.oV14N2r8-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: RSXNMVBDZWM77U6CNZCI6SNQ7TXGEQRJ
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0126.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:30::18) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5be00a38-bb67-4077-0814-08da3fb506ac
X-MS-TrafficTypeDiagnostic: DM5PR10MB1963:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB19637DDE6F227CFBA79AF22F8ED89@DM5PR10MB1963.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CLzB0uWZP/mmVP7SqYW/87DLNU/cEFBOmhNfLzL5WDjBwNbMYvoGmkxsBbr/f5IXIVMSWtN3wbtgdcsvDM0v6P7oa8UVAmJ0j8B/nEcTC7rtEfqPk6FP0eK6mJU4fHjRgcsoRsbO2sQjaLYPVl52r+tx+mNpB8lxbejgQDeNIvnvlte4xtOhrGAAS52WQN6VEB7XpjxNlY1qiwY/tqeEahD5Rk9VTJjcMu4sLz/9lREN5RUS3OfKqbETM6XtHt22JlA6P3wEPv6xIUmU4iQlR7Jj8qG65P9OngWCX2yZiMUUKJgghnP0CpCrYR3pv+yFLyMMclQfTHh6htfEb1rio8n7u8ETijsEcOhG6s/dj4fgzu0/cOVvhokjr8ifs4vW9AlN92m0KQDFSNcAzbeuJYv/wY3WfRZ7w2b4mjAgzQE4uMPINwv/cPw78Z4Ma979kS+/SjkesBdN+0JanrgV2ZtnERHh8ESI0gNYcnukWYGqtQL0djd8jMQr5EX4TE0gDR2x0PRN7O8sRQ/alhvUhrJc2F827Y53YFUIt1OvJFAhO0ZqyzJmXINmNKosNBoqsKyTKY9eDuvEZzNMtBhKAoBehL9g65ZWN7boJGyR3+R7848uCRY2DzoDwtYv6CfDnjZQ9ol2ozY38F8CZ5fh0rM5gfxUfvTpcc7zGEarmeKgFXWCfXAC6nh8KBxWFAArPNMbSVgSsuGcnZ5O7qIibsLSYo05klEJ6ihWm/KGDdn6fYQhpN1IfOWKQhHDegqIcqLj1xR1Hc+We3kfC9uc//8iroL8KO8NGe87BSgwJawWRNnY0gSR8hO8Jt7Rf+wtutsJbPNb2dJ7vAmh0uOcUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(316002)(6916009)(966005)(38100700002)(38350700002)(66946007)(6506007)(4326008)(6666004)(6512007)(44832011)(26005)(9686003)(8936002)(6486002)(52116002)(5660300002)(508600001)(66476007)(36756003)(2906002)(66556008)(1076003)(83380400001)(186003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PjynHt5/E4ta/enGd2ejW/QhkUMSFMV/fmh2HVFB7nIESpVtW7gsxwt2I9n3?=
 =?us-ascii?Q?pv5IvaGN61rr/EjmXk7JLiWRFkc3H2Jgfq0WmofxBu6tB404u2tG4jR17kKR?=
 =?us-ascii?Q?wkSXxUJnVy3WPWqBZNL5rwdgxea8NEaaYyzw+zQX+CgMyW7CeoMv++B6YI0U?=
 =?us-ascii?Q?/ywbbckM4mObUsoqfEcbq9q30CSlg9RGKXX6e5FSGaUu+NQoBjUNLzfQPVC6?=
 =?us-ascii?Q?36hvKS/xEZclahlSP3hT0RaR5B/vX12ohqxxC2/2om6eJGvrl0//S1R3Abyj?=
 =?us-ascii?Q?eF+bBBulyFjKxMz8ektY7nY+VxmuFdINZMU4xXoZbIaGkIxNoEf0CoCdqh/d?=
 =?us-ascii?Q?RKBwZ/75oMb8h8NXumy3B01vMfTSN+U48KTqzHC4/x3xHbzyTAP5y0z5sc36?=
 =?us-ascii?Q?V0YPo0qkHdrEs5/dF4tesXMq6E8txBx6FI7s0gD+qUZxXM7k5BfeIru7WdAH?=
 =?us-ascii?Q?Y4L9aq6s/NVBwLe8W1ZZrDrayp4wugfRG4pnMIRvFgUngRmJiFqjbTGvwt6X?=
 =?us-ascii?Q?gSJWL1cDO3LjsF8mMciPfizpl5qcKCfjnQZXZh67xsoQ8iflyV5B1tZKY0dP?=
 =?us-ascii?Q?htZgK+/Tdv1HCaf+lovDvjBYh7sq29c38wHnwFdARjIpBW76iX43u+fkYLHp?=
 =?us-ascii?Q?wmLRyoWQSoaOR6LbuzFfGwbsNCy0ZR/FQdOpLE1ZriobgU+zQ0vIruYTHuq0?=
 =?us-ascii?Q?ugllKv4IR4Pb+Exumue8MIrLlljCKZ2Q8xAx1OavwDjWd1QMNYiWV/hbLXaX?=
 =?us-ascii?Q?C4ulzgutN74kpD0dvdcIxBNlD7+U8AM+NC0cRit5r/FdllzySLoKZxrVt2rg?=
 =?us-ascii?Q?prEjWwicxigdhucR6cpeGr7IixFrUZFKfvCGdOdHpOzrrj7lhr8L9yHY9ryX?=
 =?us-ascii?Q?oGFGLbsPPGyvoewJrXmRwsoPm2lUiIJ2HEgpjaha5Tfy3c+g2oC3HJ2yiFkd?=
 =?us-ascii?Q?0Duj1eTYF5AjOjWSqHq2v+EAIe9+S1MwnFQxxDlQrrGwvFxCHrTX6xwkSl7R?=
 =?us-ascii?Q?XxbPCzPYhoapqnuF0d2zVUDR6lJrAjMaeFxfY68snC7iuqx7Ib0KUHnujMAC?=
 =?us-ascii?Q?jPihW9iZeGL+4lW5scBFqZJN90fD+nYtaytz5GRp+gaLhJu6tt7ERPvM3xIP?=
 =?us-ascii?Q?OsgybYfy664pe+gCMW+j4koDY+IVsclFXB0Yss3vC6k9t6RQEmklrPifNwxP?=
 =?us-ascii?Q?ZUven7s3gNmdyTmrQUv+Il6TTIaiFW5y1UblwwmbRDqdTEpFHACwjfGVrslz?=
 =?us-ascii?Q?4eWa8+wPsyly1wvHj66FRaFxDpBZ1SOCdShZnFYYxBss1nIJ7YGXsAMXh5BS?=
 =?us-ascii?Q?Hnzx+b4dtUW07Et5d1TFBOJlOCZROD2u+qUid2vbO1JZs4dia/Caj+GKTw0k?=
 =?us-ascii?Q?PEnkqIBjnxTxm0lx0SWprAhGdSHrxXCzKpifFUcWLu7g6LsKMnATdnw4I1EP?=
 =?us-ascii?Q?M4fSt/2Cc6rPBGE1xhmnPrO1YNoUmCMMAuRTMSo+/rncR8WNQXnliBJoz8Xl?=
 =?us-ascii?Q?/w59GEe77cq4+fbpllSWKcgY4P/w8QMy0oQt5nzqGeoxoJHwT0yOQdP3EdhN?=
 =?us-ascii?Q?TZdcKj2MKTIuUhYYiPF1K2nk1wJvkoV5LHVR/lLCBLyYH2m8c5Ex4SYXqQ1A?=
 =?us-ascii?Q?SUBprVUuLZjwNNueGFkfK6zBvgROfDl0k1HZLA9seHhGTAzfSzS+W3XxfFVS?=
 =?us-ascii?Q?xGKVVefwyOGKis6dky4kuuzNcrRDb60zM/R1iEWLOgYXd/FXC9GpZennYMWy?=
 =?us-ascii?Q?GHdOfM2YfMxXk9tzoufxI+fIkDjKStE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be00a38-bb67-4077-0814-08da3fb506ac
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 07:46:36.1008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N3wkoM4Fs2wGiM1XgVD6i+mJwMQLCrzfulWV12RI2fcpEg+NjCJ1z86hl5vkgkP9sAHiXNN/x1fyOj5Cg4sQKgOTCJ9yki7FDy4K+v4x9Fk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1963
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-27_02:2022-05-25,2022-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205270038
X-Proofpoint-GUID: g0BCByAmCg75aCIdroOoq0PqklTSwAqM
X-Proofpoint-ORIG-GUID: g0BCByAmCg75aCIdroOoq0PqklTSwAqM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ kbuild bot sent this warning on May 4 but I never heard back and it's
  May 27 now so sending a duplicate warning is probably for the best. -dan]

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
head:   7e284070abe53d448517b80493863595af4ab5f0
commit: 622469c87fc3e6c90a980be3e2287d82bd55c977 drm/amdgpu/discovery: add a function to parse the vcn info table
config: arc-randconfig-m031-20220524 (https://download.01.org/0day-ci/archive/20220527/202205271546.oV14N2r8-lkp@intel.com/config )
compiler: arceb-elf-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1433 amdgpu_discovery_get_vcn_info() error: buffer overflow 'adev->vcn.vcn_codec_disable_mask' 2 <= 3

vim +1433 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c

622469c87fc3e6 Alex Deucher 2022-03-30  1403  int amdgpu_discovery_get_vcn_info(struct amdgpu_device *adev)
622469c87fc3e6 Alex Deucher 2022-03-30  1404  {
622469c87fc3e6 Alex Deucher 2022-03-30  1405  	struct binary_header *bhdr;
622469c87fc3e6 Alex Deucher 2022-03-30  1406  	union vcn_info *vcn_info;
622469c87fc3e6 Alex Deucher 2022-03-30  1407  	u16 offset;
622469c87fc3e6 Alex Deucher 2022-03-30  1408  	int v;
622469c87fc3e6 Alex Deucher 2022-03-30  1409  
622469c87fc3e6 Alex Deucher 2022-03-30  1410  	if (!adev->mman.discovery_bin) {
622469c87fc3e6 Alex Deucher 2022-03-30  1411  		DRM_ERROR("ip discovery uninitialized\n");
622469c87fc3e6 Alex Deucher 2022-03-30  1412  		return -EINVAL;
622469c87fc3e6 Alex Deucher 2022-03-30  1413  	}
622469c87fc3e6 Alex Deucher 2022-03-30  1414  
622469c87fc3e6 Alex Deucher 2022-03-30  1415  	if (adev->vcn.num_vcn_inst > VCN_INFO_TABLE_MAX_NUM_INSTANCES) {

Capped to 4

622469c87fc3e6 Alex Deucher 2022-03-30  1416  		dev_err(adev->dev, "invalid vcn instances\n");
622469c87fc3e6 Alex Deucher 2022-03-30  1417  		return -EINVAL;
622469c87fc3e6 Alex Deucher 2022-03-30  1418  	}
622469c87fc3e6 Alex Deucher 2022-03-30  1419  
622469c87fc3e6 Alex Deucher 2022-03-30  1420  	bhdr = (struct binary_header *)adev->mman.discovery_bin;
622469c87fc3e6 Alex Deucher 2022-03-30  1421  	offset = le16_to_cpu(bhdr->table_list[VCN_INFO].offset);
622469c87fc3e6 Alex Deucher 2022-03-30  1422  
622469c87fc3e6 Alex Deucher 2022-03-30  1423  	if (!offset) {
622469c87fc3e6 Alex Deucher 2022-03-30  1424  		dev_err(adev->dev, "invalid vcn table offset\n");
622469c87fc3e6 Alex Deucher 2022-03-30  1425  		return -EINVAL;
622469c87fc3e6 Alex Deucher 2022-03-30  1426  	}
622469c87fc3e6 Alex Deucher 2022-03-30  1427  
622469c87fc3e6 Alex Deucher 2022-03-30  1428  	vcn_info = (union vcn_info *)(adev->mman.discovery_bin + offset);
622469c87fc3e6 Alex Deucher 2022-03-30  1429  
622469c87fc3e6 Alex Deucher 2022-03-30  1430  	switch (le16_to_cpu(vcn_info->v1.header.version_major)) {
622469c87fc3e6 Alex Deucher 2022-03-30  1431  	case 1:
622469c87fc3e6 Alex Deucher 2022-03-30  1432  		for (v = 0; v < adev->vcn.num_vcn_inst; v++) {
622469c87fc3e6 Alex Deucher 2022-03-30 @1433  			adev->vcn.vcn_codec_disable_mask[v] =

But this array doesn't have 4 elements

622469c87fc3e6 Alex Deucher 2022-03-30  1434  				le32_to_cpu(vcn_info->v1.instance_info[v].fuse_data.all_bits);
622469c87fc3e6 Alex Deucher 2022-03-30  1435  		}
622469c87fc3e6 Alex Deucher 2022-03-30  1436  		break;
622469c87fc3e6 Alex Deucher 2022-03-30  1437  	default:
622469c87fc3e6 Alex Deucher 2022-03-30  1438  		dev_err(adev->dev,
622469c87fc3e6 Alex Deucher 2022-03-30  1439  			"Unhandled VCN info table %d.%d\n",
622469c87fc3e6 Alex Deucher 2022-03-30  1440  			le16_to_cpu(vcn_info->v1.header.version_major),
622469c87fc3e6 Alex Deucher 2022-03-30  1441  			le16_to_cpu(vcn_info->v1.header.version_minor));
622469c87fc3e6 Alex Deucher 2022-03-30  1442  		return -EINVAL;
622469c87fc3e6 Alex Deucher 2022-03-30  1443  	}
622469c87fc3e6 Alex Deucher 2022-03-30  1444  	return 0;
f39f5bb1c9d68d Xiaojie Yuan 2019-06-20  1445  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp 
_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org

