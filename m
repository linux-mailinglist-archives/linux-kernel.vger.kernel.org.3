Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C6F549B50
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245056AbiFMSTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236871AbiFMSTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:19:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F8C46B0D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 07:24:02 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25DDYwX6003921;
        Mon, 13 Jun 2022 14:23:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=NzmFIbnKv22ty7ltcxa7/OTLNnbN0elfoCpA4jthQ2M=;
 b=norvfExqmj1FkZ8nd8xzaxuDQplaZh7b1V+xPQzgGOC950dViVuchaTOTdb28cQjdtvG
 naJyToRuxjQ0ut48fFUPAK7p0vIGf04LUqrBDDt+PKjlmfO3P/tvyusCykR/Jhhp3ewA
 F7CsLX5TZZZm0r2yn3kAzyy4FpoAvCUGezcVr2hCqspj7CrJUfzSdXi/ReymxAXvXmT5
 vzTJ4TwJgZoekCG9YKqksN7LIYc8AUxWZyCl7a+ZhWZUk/CzBTEhAPvrJqCg0+MD+sbX
 8rUleucfhEfls291CccAHu0opN+xTxUfcUOhh9oQ5bryH546y5cA8ZA095iB7AIBCUEO zA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjx9b718-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 14:23:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25DEK6Ca039743;
        Mon, 13 Jun 2022 14:23:58 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gp6me0n7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 14:23:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrTVW8IBktAJ3l9ujJF/r4Oe+j6DXoZw+KKL93xn5indMh1ZKw4Zq11CfJb3UfwpK1tfg1pGPihkUW0uAZKAQOaShYxonGD+SXi37FL7WpbLmika/crgjFF7ODX4JCOboLOQjA+dqovlfArurrcNh2RVclL/CqeSzeJgyOdwSxd+hWc2YQyBqOox3Smu5SGqMz5nShk6zCbU4gHlaVLwl9VFu9YIjWG4oAFJoEevXiOrGeoXBekyIsuDSJpyqBo2GE5GI98CQ/eGJkGA8R6qy76BXA3HdoYEc5mje0TrUYejbLHwixNb7p+4lrZpIf9C4qarVIfjIWmNx2815DMFjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3waqdCkkMOHneC9zOnr+j6f1VB9cYBF4drepi70XQw=;
 b=hYuUMwohT+LmFPnDAVKCH/ArtzeFYEQbbBRjiNY9guVTnG7HuwUpQd1Lq56ZRGaIHoT50bqd2JJtIVWQpVvYgPe2C0zmWmWofLkQM5MqxgD04g1Yep67LvraghjNevVL4c2hKzgz59KoCKY3sfumHEKS917A+Q2epF8RBPF7MiElv9boGBk8iegGgdrGPem4Tzp/zTeNtUuc60Av/rOiFqGYrjiO5Y6d72x/wgA19U7NpaR90AppQQ+WnJ0CkX34l0YUweSn6bnMJ8qrOnZ/kisajqx1EbfDIHFFnzszwzuhaVHCgnIVFEirqEDcgscZPRvKZYZKXrFgK+0c++df0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3waqdCkkMOHneC9zOnr+j6f1VB9cYBF4drepi70XQw=;
 b=mKcCC8pQa+nEBoIAbWBMEqSa37dMcX0jRRQMC1qqO0QyD0qxjKouttF2oOaLq165pwmNAm4plWFkSEgEUf8CG+YRZE6ZkbflKyfeop0j/Hzqz7M78JW7WEugM9x1LAdzl7cUIjvehhC0UIofSsCY6Q/zILeC6xrPsa6frHAOsI4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN0PR10MB4888.namprd10.prod.outlook.com
 (2603:10b6:408:115::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Mon, 13 Jun
 2022 14:23:56 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 14:23:56 +0000
Date:   Mon, 13 Jun 2022 17:23:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Alex Deucher <alexander.deucher@amd.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Guchun Chen <guchun.chen@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1133
 amdgpu_discovery_reg_base_init() error: testing array offset
 'adev->vcn.num_vcn_inst' after use.
Message-ID: <202206120158.qKV3o9Lh-lkp@intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0005.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::10)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29d79b7a-110e-4ffc-466e-08da4d485940
X-MS-TrafficTypeDiagnostic: BN0PR10MB4888:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB488895EC219B462B722C37298EAB9@BN0PR10MB4888.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: smuEL4FWhwU/IomAGT4vh2GyHcxej/jNXy95hvG0UcPrrnNR9RhuQilIuruHUrX1+N1tq6Xw5P7+yI27DdZI3Mk+t2qgfK8DOD01xabsFL2PcZp/PN5RJwb5D7EXUvUs3tJAqeu/AnXUxXZSfw5r/5lZIPlWA0zI3y6yNZWQdAZbjNRHyu+jvV1R75XfihdBqDrzLNLLpCq1IDl3BNOL+2jLPYm+jXSsVHNUvlykR4TD88LEYhihlBd4XIlXK0X8fahc1u5G2Mu9j2kgmHUbLLFgQdaEs06VOaKBw9uZUnJtZYhFlKDK/oDJsG5AVXjp9VKxc9pcMKD/nDH6Gn/Go/HgMmVQzjm/8kesMoEhDZSf89WsGTTduvw0lR7RPhP0sW7/eXVo4WpWYQomMFcjfdJE83NZw0ZKcmzW/pwfqMDCEUmueYbw3v7acYxinazFLLsYk9tnaK1lM5WbLW+LPYk53oPfq0hb13rd997nImVufqzj0YtlKnuOrAp0KS3OjqOzg/1rtlMkoOszSCLepCSQ0FZ3ZovPVmpjrRQsiJteOEPZ+rwfY5M4f5SMZhdXuIxBAwd1SFJIIC5rYqFheMLR+Xk4COm/Er8UxewcvilHObHqOHwRBlDmnhQVzXiOf9518dw442XchSnTN10dMznSXbDYHPEr1QYnOiFHWKal1ddl55BxwroX2Cu8UAJOdheBc45MAKdZaG9cIIf8ZNtOdR7SyMxNEVxoaPWr5KXhLyUKX8W3TGWLQL49e0KsW5kxCkpA0tNRDV9hvtCtxcMeIPI9bwo1Pzd9+LpQqbteieNQjQn9nDkJSBqOEO2M4YJvZSpk3Pv9NGFin6qYPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(36756003)(316002)(86362001)(186003)(1076003)(66574015)(6916009)(44832011)(5660300002)(6486002)(83380400001)(966005)(4326008)(8676002)(66556008)(66476007)(2906002)(66946007)(4001150100001)(6666004)(38350700002)(52116002)(26005)(38100700002)(9686003)(8936002)(508600001)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?QlcFkfb3AkvBLZl2mm+F03zo5yIqInmEqIOHggLWVWDts6LREOuzvZAMUT?=
 =?iso-8859-1?Q?cYjcVQyD6MncE8HRzU7xWAD46MDdXNKJElAnZIgfvvOHW13yrUpxidTRHi?=
 =?iso-8859-1?Q?nUXhew+DE2MKzJf4qdA5MkfL9jWBi8GNZxpLBVXbuQX690gcMvass2yYOj?=
 =?iso-8859-1?Q?qx4o7Rcb8g8ZaPVefOujs67FsCAVJWxT5H0kBiY2XVR8iI53YITrM71WMl?=
 =?iso-8859-1?Q?cmtPSJaHzkk2EvCqUdsLXaX43TzGdDiOVMCb91pqjcinWc57V2sPto1cNo?=
 =?iso-8859-1?Q?DLYmOmFMl97vrnghacmZkTSoBMrpIM+XWeuZlA4qGl08/b0KNUQYM5zu3N?=
 =?iso-8859-1?Q?ziRHEhbTw59cNnIKaWQMLKxSO2irPoy1DhZ1MiKYRRMhZ6WNWoKB946tNW?=
 =?iso-8859-1?Q?LRJ0TatcVmOgXdvL2f1GW/cig8mPRwwqdO54Nh9dGuGcd6JPiZC47nzRdc?=
 =?iso-8859-1?Q?3qrOMaNLOmYeuDrYqJLB438Uv2KenRSpRYI0Iay0HM953kTuZdnwVeViNZ?=
 =?iso-8859-1?Q?1jKWiO41Sb6Vc/RvtY6qHRYzJvw+B3bVA5QefdI1P8DiMu+9TahauY4T+h?=
 =?iso-8859-1?Q?3xkLeWaqr/b+0wXePcv8ZflcuGQ575jkLmaw5TOACbPygGk75BEc8T5dGD?=
 =?iso-8859-1?Q?7B1IQpM5j1ozjQcydKzum8gU9FTmhx3FXLsFOeLEKuPLVWerSCVTD1JUOG?=
 =?iso-8859-1?Q?m8V3nqFt6Iq0NnWgq7NZXjyIME+fWeYmPQZphaBkaggOYOLSh24eCuevww?=
 =?iso-8859-1?Q?Hkd0SZTHGd0gpen4XhGulnwsNuA1OBxfK+0bsZaK5tPvjQjxXiSm4inr45?=
 =?iso-8859-1?Q?ZHX0PaVyk1ruqVfcUvJ1kBKVo0HrivUWpy0A/jLR7Y3/HPQynBDeD0GOtW?=
 =?iso-8859-1?Q?jl00zwMRaEE/yCYdGjyOKaiQpRDANe6OKCpJbOWQ2Ah0c6VDZplVzvEvmG?=
 =?iso-8859-1?Q?vAyQk0j3O+C80CkPaiqllwu2FEaOLrMw5oAn6NQYsvZCZOOxzeyHQGVpnp?=
 =?iso-8859-1?Q?FJ/OlGgYnPBwfPSv3kZ8li88G4hlpelC5ynvROAxAM53nTAzj5I2zNf05q?=
 =?iso-8859-1?Q?/W8e8i/i/MQUwruATRnHmNuaI7pnFhdkl1azGZi0Zk+23FFP2AaKdx30hC?=
 =?iso-8859-1?Q?u+AdMtF+ahC/zDYzuiK5r/v4BoD1+o3ODpKTufDvU4kpjM91gemCsADOsG?=
 =?iso-8859-1?Q?pjSAeml4ZUr94aHCKntFkVbLjAEP2qYA7HqjTEbWK794J+VIR900bIGBeu?=
 =?iso-8859-1?Q?9tw2ZSZ+4ptUNEackdUffHrQ/u7FnhnhzCgV7zEC8OAmslAChN4wyeiaUf?=
 =?iso-8859-1?Q?N+TBGlIK8AMSdFldsyQtQVGqfKKMVnXndtVyiCxnFirx8ZjRXFN1z8zAaF?=
 =?iso-8859-1?Q?i1A9qe53exyKKFzm7DnR+ZGjD7ejFOc2U+HJXdzvidCkG89bLRFyrgBQDT?=
 =?iso-8859-1?Q?yWMR2Hd95x0YOid1S4CIImXKblZJ0JivaLO4/thxb9o/i8MC+nw17tBrt0?=
 =?iso-8859-1?Q?NA1aWXE6cRKDjSnC82BdRvtvTnZEKjsK6EmHZj798LhZSISma9VqtrSJCz?=
 =?iso-8859-1?Q?+Bc20sT5dIRI/4Ut86ck1kDV9VO4XT53Es+d3O9jzOJJh6CcAnzYrdHII1?=
 =?iso-8859-1?Q?giWkKvhTLNzz7naF8iJ4zBNdwvXAD+IhSa2rrOaDoFZjVv8RthORF9Qjv9?=
 =?iso-8859-1?Q?Ixw25G0zrw6WDN7JYhiqld8IS7G6uRivmtLk160ZHIhmRB7Jm+5ETWgZU+?=
 =?iso-8859-1?Q?sQVWh4uJlc8DCWSsblhE+pSe7Rw7+G6KX8cuF52HJJCLqsN8L690PqHxr9?=
 =?iso-8859-1?Q?Aqk6OgVh/wxwjusp+PNHsGT9bcfzBaQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d79b7a-110e-4ffc-466e-08da4d485940
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 14:23:56.0621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jxz+Q/0Pjqg6MBJ/jQnK5TIl3AGdmljp+/UnHMqe6EAvUGycrFk04xyx6KEdn1FuXDgjNakSTNtGN11wWEET2ZMWgxF6qf7Ssas2aDxy+AU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4888
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-13_06:2022-06-13,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206130065
X-Proofpoint-ORIG-GUID: gAXRd-hEXWjaCskNEHI3hAxjeRvMVP2K
X-Proofpoint-GUID: gAXRd-hEXWjaCskNEHI3hAxjeRvMVP2K
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0885eacdc81f920c3e0554d5615e69a66504a28d
commit: a0ccc717c4ab3ef572f023fdceffb4b6df496a0d drm/amdgpu/discovery: validate VCN and SDMA instances
config: parisc-randconfig-m031-20220608 (https://download.01.org/0day-ci/archive/20220612/202206120158.qKV3o9Lh-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1133 amdgpu_discovery_reg_base_init() error: testing array offset 'adev->vcn.num_vcn_inst' after use.

Old smatch warnings:
drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1454 amdgpu_discovery_get_vcn_info() error: buffer overflow 'adev->vcn.vcn_codec_disable_mask' 2 <= 3

vim +1133 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c

e24d0e91b33676 Alex Deucher    2022-03-30  1065  static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
f39f5bb1c9d68d Xiaojie Yuan    2019-06-20  1066  {
f39f5bb1c9d68d Xiaojie Yuan    2019-06-20  1067  	struct binary_header *bhdr;
f39f5bb1c9d68d Xiaojie Yuan    2019-06-20  1068  	struct ip_discovery_header *ihdr;
f39f5bb1c9d68d Xiaojie Yuan    2019-06-20  1069  	struct die_header *dhdr;
f39f5bb1c9d68d Xiaojie Yuan    2019-06-20  1070  	struct ip *ip;
f39f5bb1c9d68d Xiaojie Yuan    2019-06-20  1071  	uint16_t die_offset;
f39f5bb1c9d68d Xiaojie Yuan    2019-06-20  1072  	uint16_t ip_offset;
f39f5bb1c9d68d Xiaojie Yuan    2019-06-20  1073  	uint16_t num_dies;
f39f5bb1c9d68d Xiaojie Yuan    2019-06-20  1074  	uint16_t num_ips;
f39f5bb1c9d68d Xiaojie Yuan    2019-06-20  1075  	uint8_t num_base_address;
f39f5bb1c9d68d Xiaojie Yuan    2019-06-20  1076  	int hw_ip;
f39f5bb1c9d68d Xiaojie Yuan    2019-06-20  1077  	int i, j, k;
dffa11b4f74b15 Monk Liu        2020-03-04  1078  	int r;
f39f5bb1c9d68d Xiaojie Yuan    2019-06-20  1079  
dffa11b4f74b15 Monk Liu        2020-03-04  1080  	r = amdgpu_discovery_init(adev);
dffa11b4f74b15 Monk Liu        2020-03-04  1081  	if (r) {
dffa11b4f74b15 Monk Liu        2020-03-04  1082  		DRM_ERROR("amdgpu_discovery_init failed\n");
dffa11b4f74b15 Monk Liu        2020-03-04  1083  		return r;
f39f5bb1c9d68d Xiaojie Yuan    2019-06-20  1084  	}
f39f5bb1c9d68d Xiaojie Yuan    2019-06-20  1085  
72de33f8f7ba0f Alex Deucher    2020-07-29  1086  	bhdr = (struct binary_header *)adev->mman.discovery_bin;
72de33f8f7ba0f Alex Deucher    2020-07-29  1087  	ihdr = (struct ip_discovery_header *)(adev->mman.discovery_bin +
f39f5bb1c9d68d Xiaojie Yuan    2019-06-20  1088  			le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
f39f5bb1c9d68d Xiaojie Yuan    2019-06-20  1089  	num_dies = le16_to_cpu(ihdr->num_dies);
f39f5bb1c9d68d Xiaojie Yuan    2019-06-20  1090  
437298b833996d Xiaojie Yuan    2019-03-27  1091  	DRM_DEBUG("number of dies: %d\n", num_dies);
f39f5bb1c9d68d Xiaojie Yuan    2019-06-20  1092  
f39f5bb1c9d68d Xiaojie Yuan    2019-06-20  1093  	for (i = 0; i < num_dies; i++) {
f39f5bb1c9d68d Xiaojie Yuan    2019-06-20  1094  		die_offset = le16_to_cpu(ihdr->die_info[i].die_offset);
72de33f8f7ba0f Alex Deucher    2020-07-29  1095  		dhdr = (struct die_header *)(adev->mman.discovery_bin + die_offset);
f39f5bb1c9d68d Xiaojie Yuan    2019-06-20  1096  		num_ips = le16_to_cpu(dhdr->num_ips);
f39f5bb1c9d68d Xiaojie Yuan    2019-06-20  1097  		ip_offset = die_offset + sizeof(*dhdr);
f39f5bb1c9d68d Xiaojie Yuan    2019-06-20  1098  
437298b833996d Xiaojie Yuan    2019-03-27  1099  		if (le16_to_cpu(dhdr->die_id) != i) {
437298b833996d Xiaojie Yuan    2019-03-27  1100  			DRM_ERROR("invalid die id %d, expected %d\n",
437298b833996d Xiaojie Yuan    2019-03-27  1101  					le16_to_cpu(dhdr->die_id), i);
437298b833996d Xiaojie Yuan    2019-03-27  1102  			return -EINVAL;
437298b833996d Xiaojie Yuan    2019-03-27  1103  		}
437298b833996d Xiaojie Yuan    2019-03-27  1104  
437298b833996d Xiaojie Yuan    2019-03-27  1105  		DRM_DEBUG("number of hardware IPs on die%d: %d\n",
437298b833996d Xiaojie Yuan    2019-03-27  1106  				le16_to_cpu(dhdr->die_id), num_ips);
437298b833996d Xiaojie Yuan    2019-03-27  1107  
f39f5bb1c9d68d Xiaojie Yuan    2019-06-20  1108  		for (j = 0; j < num_ips; j++) {
72de33f8f7ba0f Alex Deucher    2020-07-29  1109  			ip = (struct ip *)(adev->mman.discovery_bin + ip_offset);
5039f5298880f7 Ernst Sjöstrand 2021-09-26  1110  
5039f5298880f7 Ernst Sjöstrand 2021-09-26  1111  			if (amdgpu_discovery_validate_ip(ip))
5039f5298880f7 Ernst Sjöstrand 2021-09-26  1112  				goto next_ip;
5039f5298880f7 Ernst Sjöstrand 2021-09-26  1113  
f39f5bb1c9d68d Xiaojie Yuan    2019-06-20  1114  			num_base_address = ip->num_base_address;
f39f5bb1c9d68d Xiaojie Yuan    2019-06-20  1115  
437298b833996d Xiaojie Yuan    2019-03-27  1116  			DRM_DEBUG("%s(%d) #%d v%d.%d.%d:\n",
437298b833996d Xiaojie Yuan    2019-03-27  1117  				  hw_id_names[le16_to_cpu(ip->hw_id)],
437298b833996d Xiaojie Yuan    2019-03-27  1118  				  le16_to_cpu(ip->hw_id),
437298b833996d Xiaojie Yuan    2019-03-27  1119  				  ip->number_instance,
f39f5bb1c9d68d Xiaojie Yuan    2019-06-20  1120  				  ip->major, ip->minor,
f39f5bb1c9d68d Xiaojie Yuan    2019-06-20  1121  				  ip->revision);
f39f5bb1c9d68d Xiaojie Yuan    2019-06-20  1122  
baf3f8f3740625 Alex Deucher    2021-11-30  1123  			if (le16_to_cpu(ip->hw_id) == VCN_HWID) {
c40bdfb2ffa4cf Leslie Shi      2021-12-08  1124  				/* Bit [5:0]: original revision value
baf3f8f3740625 Alex Deucher    2021-11-30  1125  				 * Bit [7:6]: en/decode capability:
baf3f8f3740625 Alex Deucher    2021-11-30  1126  				 *     0b00 : VCN function normally
baf3f8f3740625 Alex Deucher    2021-11-30  1127  				 *     0b10 : encode is disabled
baf3f8f3740625 Alex Deucher    2021-11-30  1128  				 *     0b01 : decode is disabled
baf3f8f3740625 Alex Deucher    2021-11-30  1129  				 */
c40bdfb2ffa4cf Leslie Shi      2021-12-08  1130  				adev->vcn.vcn_config[adev->vcn.num_vcn_inst] =
                                                                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


c40bdfb2ffa4cf Leslie Shi      2021-12-08  1131  					ip->revision & 0xc0;
baf3f8f3740625 Alex Deucher    2021-11-30  1132  				ip->revision &= ~0xc0;
a0ccc717c4ab3e Alex Deucher    2022-05-16 @1133  				if (adev->vcn.num_vcn_inst < AMDGPU_MAX_VCN_INSTANCES)
                                                                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
If "adev->vcn.num_vcn_inst >= AMDGPU_MAX_VCN_INSTANCES" then the memory
has already been corrupted.

7cbe08a930a132 Alex Deucher    2021-08-09  1134  					adev->vcn.num_vcn_inst++;
a0ccc717c4ab3e Alex Deucher    2022-05-16  1135  				else
a0ccc717c4ab3e Alex Deucher    2022-05-16  1136  					dev_err(adev->dev, "Too many VCN instances: %d vs %d\n",
a0ccc717c4ab3e Alex Deucher    2022-05-16  1137  						adev->vcn.num_vcn_inst + 1,
a0ccc717c4ab3e Alex Deucher    2022-05-16  1138  						AMDGPU_MAX_VCN_INSTANCES);
baf3f8f3740625 Alex Deucher    2021-11-30  1139  			}

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

