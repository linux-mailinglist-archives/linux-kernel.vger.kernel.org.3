Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867D251FB29
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbiEILVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbiEILVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:21:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7681EAF1B
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 04:17:23 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 249AQ3oG024511;
        Mon, 9 May 2022 11:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=AhVG1TDMvgSfKEtc+TXhoiE9UjB2BoeyuvhagtpcwwA=;
 b=KzWMWS/0mgGOh2qtMpXqrHAW+I3zEsRWPg+k3najHmhhN+6djjhrknncuhTkVYQqJiia
 BbJpmc8NTURjdvlGQVJuUmAN34lOSfO+jauZ/7lDsRbtZPjFFpS2HO+blwWz+0GI/y9o
 2XhkBPdbLSbmL0ZaDfHSTvw3Ov4XK9cVjP606NQdrywJBq4IChHSt2xBpTC+kCi7NH5/
 7/oV+uPraqgsyGDew8k6EiHR1WGI0kSZl0DM0e1ORrTMuQsxpG11AyEJ1yWTg1AvFtEf
 AumIVYvESPvtjTHjRcxYszCJvwYwYbAR7Edva92aV0GHnxAuwcRCylmNR4Wbzb4s90JB pw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwfj2b4jg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 May 2022 11:17:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 249BA96H017895;
        Mon, 9 May 2022 11:17:18 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf71e2qq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 May 2022 11:17:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHlF9221QO9FC28tLRbQPC0PpjvL+7zx8b26IDxZfnJuf8e6ilVh2ORaWqPspuEnjgLcj2V6y2MhFiu9QnUTDAutrFILtFbul2WaAjHqPBZTs/r9Q5oRJv2uEqeGyjy+MwxrfE1kh8i96kjYZcL3GvfVDLkYJQyS3UL1FCh54mlq+BdoJHAiOZknYDQR+QGM4CkDawxXkNt23fn6orl/4UaZFMC0IroQfwSnoL8hAt+NbBsPOqJj+b7vt89Es0YXdSWV1JxLMevixplglxGaoHovn6GKeXrVOfe6PEU9vn3+3YBc+uUdOQ/XwQ2d+qTtf5JyCN49lnYSYmp1ewyJYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhVG1TDMvgSfKEtc+TXhoiE9UjB2BoeyuvhagtpcwwA=;
 b=TP6w3SvC5BGfbMNsBi7mqvyARSSK4AQBIzFFqlUSA+e5bYieCKi5+Lx2q2N+d50zVhMQnOok5ZugFMYW8DMnBDcHnVlZMsm1m4CopWQ5dfNjZfRQHCHQWIz1C46vvUHX6bkehf5O8sdS5vVBmdS9komDVRacoNiqbsXpNHzdof5nlSAXhvSzHLP5SJNnKdQ/mcqnRrEKNSZNl03PYkAfEfvTKSu0WpVNswq4fIzmdo4tqBLIHYzvidvI0sfPvjP90me1+cJ0UhHEUK+of3pbF4t6oVsQsPlmHz7imTwHadMSBqRd9LtrjvSJ9JP1TZUfQdDO2eIM1U6MIKwMhWx+xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhVG1TDMvgSfKEtc+TXhoiE9UjB2BoeyuvhagtpcwwA=;
 b=Y4WqezNg3bTscYY0LdPyKn12a5gO8de/47oHpM7UBTuBi3uNbF8QLtGYD6IhIIjbml9xU0Oee5fyJokjQwg64rRWqUjb1poNPkwxcUHFckbbJSEJ5Gxwrfmco8Dt0FAr14zkT5KgZHAsuMca3sgm8bsIiJuzEPNSIWids9AIfjk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB3850.namprd10.prod.outlook.com
 (2603:10b6:5:1d1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 11:17:16 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5227.020; Mon, 9 May 2022
 11:17:16 +0000
Date:   Mon, 9 May 2022 14:16:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Hawking Zhang <Hawking.Zhang@amd.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Wenhui Sheng <Wenhui.Sheng@amd.com>
Subject: [agd5f:drm-next 429/599] drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:1278
 gfx_v11_0_rlc_backdoor_autoload_copy_ucode() warn: should '1 << id' be a 64
 bit type?
Message-ID: <202205082233.0Gm8B7A4-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0052.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d866fc37-feef-4ea2-4813-08da31ad795a
X-MS-TrafficTypeDiagnostic: DM6PR10MB3850:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3850C624C3CD9F574C09C9018EC69@DM6PR10MB3850.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fHhSZ9Hge2r7caITAKUj9n0iWvQdRyjPss5Ux96xToQmWya1eb1Ll+ND10wuYUFwhjva3xLTJp0XtMIg40xPU9/QlFNdMvBhhB662EB4UjLg+TTP+Zsh0WRQ0/mHpeaJuYJ4Sk8y+y35HNekMl5tItgFw6DsF/cpQvBNAmtQ/iJ9N1jbkfaCQecl9dJ3Wubn0ZTSv5y/ODh2159vO//SHvWx7fEkudJzDtYprr8Ue7ZreH9eWBBnQIjJMDescu7SLF5iW6bYp7/RF+9tpDNQF3FiaucKHMiNC27bZKXuRyHRnpA8YXiGxtzJw95/uy1WJMVehJ5cyc6frfCgB3gHPLHZaBvWmEsnXWkyB/RI/NV0mU+0fCk1kYD8VwsCu48IFk/QQVMfEHvxKwFbx0z85AZlWY4hGYU9O7n6BbQ4+rV93woulDiOo8KtIZOYxEqzxWJllDRRwE9kLQE3qXkcNaJmYIladM0boHFSdnOk0Mj2kugn2waUGYpieQsri91Qeqi2HMEoLf7fGLC9cwJe+RtNva2Vy5476nw2lnbeskqj4YKi8/9nHgQfFucqXZG+mZ167JKsZPLeJlWmA5F0j5i85wdEbcTl5CbHw03wnjOqFKiB3Pk4lQxyvw2ImIhF4iNHanjKWHsD8wvknvJAaLmX0DuZtrNW5YGJMrnBmhNun7m92d4O+mN4deS55O3IzL6ggCo949JfG9/niZOOnqdM5u5s3FUSfVmDlpW+wC6tGmw05YntbtFr3UB1TsYn58vYOL7SlHYHQp4hyRt1vTbZAL/xzLRDipgpJK+Aj891Xt4SvKJs6m7UriufyLVvAAhJLsIh9UFF+mRjkx9HNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(36756003)(2906002)(186003)(8936002)(38100700002)(38350700002)(5660300002)(4326008)(83380400001)(508600001)(1076003)(66556008)(66476007)(8676002)(66946007)(54906003)(316002)(6916009)(52116002)(6506007)(86362001)(26005)(6666004)(6512007)(966005)(9686003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n1+gHHvQWEpThpa2+MArl4+N0mk4rihXb5Bws1VoKrA/NkzQ+pnNS5ShMXZV?=
 =?us-ascii?Q?9Z9a594RL0Y6APSGL9COeVeq58tw6he5B0LcX11evvg5UmDmm+7skZDOPMoS?=
 =?us-ascii?Q?Dg055r0Nwd0dqOSUsUjdmNfVzxv8w0FzB4D5uzanYkEQL9sO/oIrHePJSXU0?=
 =?us-ascii?Q?7T3EgUS1Bzh/lqtG6wuZvc8/Bwp1AfbnJlntQtLkPnPwsP4okG1E3xrW12rA?=
 =?us-ascii?Q?avICOLl+6Qpr/ReyZaU2xeji1lWDUm3bgWVEdmEgVAzBbIq5sDtSeJH5GLhm?=
 =?us-ascii?Q?vE3OmXnUQbgoApaYJN3+g8uirrdrLcDHatumYBXAV+AWnsgHzlSKWmNU4TeV?=
 =?us-ascii?Q?oq/8CeJcdA2wrRLzrZe69/si0Cny3PtttIj5R52f5CWtYklBW6DLQ8bmqRzH?=
 =?us-ascii?Q?oj4yq1u/5iu7r+nZP3/AMnzXOpavJbe4Vx1vydzxDVVRkc+wW7+VQT1XIykK?=
 =?us-ascii?Q?09CAAfStcghfXr3/msOu3BU6YJUWEeJGT/pvZuxTWQMUguO/G2sq/h8Pmmov?=
 =?us-ascii?Q?YeJOPLnUSFfRde7xiXGKc0dsiFh3/9WzUQ0IR8s/Z1yvE6wuf0wAswq6qA3C?=
 =?us-ascii?Q?py5a26z0VMasq97cZw7qH7xy3pNgmlqSnidOzL0wW8AAYlitLsv+4OVvEl8X?=
 =?us-ascii?Q?bxkGqAfw0rAH/vVlxa+3gTHfVH1OEzaTq9JBWa5hnXAXO+GKO3v5swiK7nN/?=
 =?us-ascii?Q?p5BS9X3OJEyF9RrRAJvlceiCszUUprJrDOsxc9+KEOLZDd+fQEIGcQBXU4zL?=
 =?us-ascii?Q?k68gr4oK1rqs8g7PGjK+1Gi7L/hwxs5lfxBT8jMd8PCjP75aOr0SrpwKzQE0?=
 =?us-ascii?Q?PrqOjXUBv7sL9Ebn/ieDOqDvE8u49tXUn4AMrbnkTLrq8jKm6h2dkKjxrNfI?=
 =?us-ascii?Q?lMm0xgbTKmCldslexMgmkC7XCBtS4tkBpus8GCwpyx0pQVtWCEcAuRoIHSw+?=
 =?us-ascii?Q?rtiz2IwgIg2zsjHzsJy+DLBYfGkmVqU6vWCKBtiFhPNoGmJ8NXg/VMeAhhRd?=
 =?us-ascii?Q?20p8TG/+YGZRVvQrKmkO742r7ilYlZC//+iqLTRIL3mVeblkfoNbJ8BMlQ+H?=
 =?us-ascii?Q?IdSBp6K0zBm9V+JuY8LlZ/cVTFdQSvpNAXmUwxYMM+r8jNI2fbKyoZOP8LnU?=
 =?us-ascii?Q?jccAkC984FcF5TcbQVALJQi9shW35fv3g/NQhbXDa5j89QYTr4J09yY34HGh?=
 =?us-ascii?Q?SzTvamG1jQp13O8p08pH5hboEoB0aN9B9pVYZEpk96IPkH1oJy+9R1botZY5?=
 =?us-ascii?Q?wJMUQSbrII4sjYn+Yo2lwxytkXYZ4rh6K91ChiZSSg+hPFX2FDU6c2Pziy1f?=
 =?us-ascii?Q?N9PKLafhAhoTEMNFQXWiGlD0y6aIetrQLA3T58pTmATVRenYlECiV+EZ54Ow?=
 =?us-ascii?Q?ll2x3aACh4+gBISBtb/brSLEdZqSc0q2zhG+jzeCqUXNbbtKF3yJZuX1j/2s?=
 =?us-ascii?Q?Yqj3Ej9QYk6tS/BSplL6hi4hv9PIEXVpr1fqVAt1oggIONz/Y415PBtVHPVt?=
 =?us-ascii?Q?5xfh3gV6gttKAZEwCtjTHNv+mlnuXRJMSRFW2tZDUsKhUjUlKl/0TjEckzBm?=
 =?us-ascii?Q?L9DJhHXSd207mKgv8o9MWqZDuUKxCRem9VDvKG5JwBXilNBiVjb1bayvFNFd?=
 =?us-ascii?Q?128JUXkuy6nRBj3l4B/Wp0zon+R0QpM/vwxELzpjgmWzI7Auvg/vuLOVm5Z2?=
 =?us-ascii?Q?DCVud0GFmEHgwE7oVlDVwJuyCwSBhk604iQ3JozNB7ChSCNrvAZn+LFbZCDp?=
 =?us-ascii?Q?UWCXBZnzgkX4HjrD8pvb3gdZiBtNpbU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d866fc37-feef-4ea2-4813-08da31ad795a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 11:17:16.3284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xFhB7eOJZmwoFSS1Ib5UqPtPuILKXFGFqH5TkxYRoTBtblJ60JzVYXUIlpQpGveSFdeb972uIlrb+uzrJxKjim+BDSukRv1NqFW7USZRboU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3850
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-09_03:2022-05-09,2022-05-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205090064
X-Proofpoint-ORIG-GUID: 93wnu9s9sNqhTSRBN4gTxBk0ZxEwyxoF
X-Proofpoint-GUID: 93wnu9s9sNqhTSRBN4gTxBk0ZxEwyxoF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   3170f5f234272247989fafee4cba4cbbc822631c
commit: 3d879e81f0f9ed5d33b5eda0fe5226c884bb8073 [429/599] drm/amdgpu: add init support for GFX11 (v2)
config: csky-randconfig-m031-20220508 (https://download.01.org/0day-ci/archive/20220508/202205082233.0Gm8B7A4-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:1278 gfx_v11_0_rlc_backdoor_autoload_copy_ucode() warn: should '1 << id' be a 64 bit type?

vim +1278 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c

3d879e81f0f9ed Hawking Zhang 2022-04-13  1250  static void gfx_v11_0_rlc_backdoor_autoload_copy_ucode(struct amdgpu_device *adev,
3d879e81f0f9ed Hawking Zhang 2022-04-13  1251  					      SOC21_FIRMWARE_ID id,
3d879e81f0f9ed Hawking Zhang 2022-04-13  1252  			    		      const void *fw_data,
3d879e81f0f9ed Hawking Zhang 2022-04-13  1253  					      uint32_t fw_size,
3d879e81f0f9ed Hawking Zhang 2022-04-13  1254  					      uint32_t *fw_autoload_mask)

It would be cleaner to just declare fw_autoload_mask as a u64.  I
reviewed the code to see why it's a u32 and could not see a reason.

3d879e81f0f9ed Hawking Zhang 2022-04-13  1255  {
3d879e81f0f9ed Hawking Zhang 2022-04-13  1256  	uint32_t toc_offset;
3d879e81f0f9ed Hawking Zhang 2022-04-13  1257  	uint32_t toc_fw_size;
3d879e81f0f9ed Hawking Zhang 2022-04-13  1258  	char *ptr = adev->gfx.rlc.rlc_autoload_ptr;
3d879e81f0f9ed Hawking Zhang 2022-04-13  1259  
3d879e81f0f9ed Hawking Zhang 2022-04-13  1260  	if (id <= SOC21_FIRMWARE_ID_INVALID || id >= SOC21_FIRMWARE_ID_MAX)

SOC21_FIRMWARE_ID_MAX is 37 which is more than 31 so this but is real.

3d879e81f0f9ed Hawking Zhang 2022-04-13  1261  		return;
3d879e81f0f9ed Hawking Zhang 2022-04-13  1262  
3d879e81f0f9ed Hawking Zhang 2022-04-13  1263  	toc_offset = rlc_autoload_info[id].offset;
3d879e81f0f9ed Hawking Zhang 2022-04-13  1264  	toc_fw_size = rlc_autoload_info[id].size;
3d879e81f0f9ed Hawking Zhang 2022-04-13  1265  
3d879e81f0f9ed Hawking Zhang 2022-04-13  1266  	if (fw_size == 0)
3d879e81f0f9ed Hawking Zhang 2022-04-13  1267  		fw_size = toc_fw_size;
3d879e81f0f9ed Hawking Zhang 2022-04-13  1268  
3d879e81f0f9ed Hawking Zhang 2022-04-13  1269  	if (fw_size > toc_fw_size)
3d879e81f0f9ed Hawking Zhang 2022-04-13  1270  		fw_size = toc_fw_size;
3d879e81f0f9ed Hawking Zhang 2022-04-13  1271  
3d879e81f0f9ed Hawking Zhang 2022-04-13  1272  	memcpy(ptr + toc_offset, fw_data, fw_size);
3d879e81f0f9ed Hawking Zhang 2022-04-13  1273  
3d879e81f0f9ed Hawking Zhang 2022-04-13  1274  	if (fw_size < toc_fw_size)
3d879e81f0f9ed Hawking Zhang 2022-04-13  1275  		memset(ptr + toc_offset + fw_size, 0, toc_fw_size - fw_size);
3d879e81f0f9ed Hawking Zhang 2022-04-13  1276  
3d879e81f0f9ed Hawking Zhang 2022-04-13  1277  	if ((id != SOC21_FIRMWARE_ID_RS64_PFP) && (id != SOC21_FIRMWARE_ID_RS64_ME))
3d879e81f0f9ed Hawking Zhang 2022-04-13 @1278  		*(uint64_t *)fw_autoload_mask |= 1 << id;
                                                                                         ^^^^^^^^

This needs to be 1ULL < id.  Otherwise if id is >= 32 the shift will
wrap.

3d879e81f0f9ed Hawking Zhang 2022-04-13  1279  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

