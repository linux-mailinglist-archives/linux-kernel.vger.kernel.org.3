Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC814A4770
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 13:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358915AbiAaMp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 07:45:28 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:4822 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230446AbiAaMp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 07:45:26 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20VATkFh007212;
        Mon, 31 Jan 2022 12:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=taDZ+9t555xDuSntUVAjqXmVNqTluVNtctyks6IvUro=;
 b=wwLLp1mY6tRqFow/hyDQ21fcHJTL/fcatAUiVVzL80pev02mGsQj31lPXP860cbNEXZD
 k008u1iFLgxxR04bReepVSrveHO5A+ydVk3xbbwKh9N81Z+N7xDu8knn1CifEE3hTZzm
 hawN5tedhn8kDVHDVQ0UWD7oTNTLh/XheSj8A2b7rc7Zyuwcow2/jPdvGSsftviVX3N1
 /LDiDkIQ8+FaVnkOTyeHCPPOTlynIVnTm6NshFzhsxSehDDSOuMU7A9ivRBUN2zSEBKV
 lQFCgABPUHhK8R6uStVs8iik01X4rCYnkiNMLZnCXXOf2TyTDsfd+22yHS+YRMuFJlNr /w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dvx4uux2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 12:45:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20VCjIRA193240;
        Mon, 31 Jan 2022 12:45:20 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by userp3030.oracle.com with ESMTP id 3dvtpwv95f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 12:45:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvnX3n2z2YUU050hiQ6fHsba0cQTNSAEUUdx+aGZ29h53wp/3JEz+LtcpWkLlzMldayxwpgp0kze2uTJ5Unli0t6isKTQiYxg2TQhMQlW3mKjLuAWXiMAeCpSjC55wQMCtIVEde8z2vnoPmGdPUhNoBvq3zugvRziJABbduYew5acj+pljr5+/jFIfREEjZl3ZrwcZ61VdYXsGfnAxjigvwifOeU1gfD4v6gpEyB6wHA3qqhYeQs93j4Pe+OhUqGs/oT/G0zHwLUWxEF51I5URHayfxPEhJlCL2fXxDGeQ1RmVemCP26+0xrJVdbBU8KhwDXvFXaYuPqfBM8WyQzzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taDZ+9t555xDuSntUVAjqXmVNqTluVNtctyks6IvUro=;
 b=KoIrGiMoFst9SuxQmEsv/M/OiY2yM7gasb08BiavW+r6mDpO+dQEmk4zYCO8q/Yxw9h17SoIwIlxEmCUN9jPubBlWkGYqX465nCMLsjogQIlUBfHvBryDJy62mA5hRrLb2KhQFVb7DaPuIWrfcrx9FB/kXswi5mnd0TWYb4jFYU4ljiNA79qD9uNAvDOqj2VcO8BPjSC2SjKaDJ327pUZ8a6kaH9+FAMi5tnXGqU2dSDStrbpqB3YLIRONQy8E/rcDK+bO3AgzZGwhW9MlGnPCDAufECfNmYHwiegxzQsLm37KbVfUV8cwkAacux0LnRh30hlhjAIg5a8Fl8ejzAuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taDZ+9t555xDuSntUVAjqXmVNqTluVNtctyks6IvUro=;
 b=qhvVnAj51z0ER85yu2GlTV0wCZmFT3QqzF7Xk8rFwAK0OxNvUUBP0qhnhtCRQ+2xqG3n3L1bvIfJgN+2G5KWWiOcqNnU5Tr6blhYsal8IRVosguPFX42jTUi5tSlCdslZCXJMc//IFDG9l2yfv85P1tiEi791JX8Q2GumeHMcvE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR1001MB2140.namprd10.prod.outlook.com
 (2603:10b6:4:2b::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Mon, 31 Jan
 2022 12:45:11 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4930.021; Mon, 31 Jan 2022
 12:45:11 +0000
Date:   Mon, 31 Jan 2022 15:44:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Qu Wenruo <wqu@suse.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: [kdave:for-next 54/72] fs/btrfs/volumes.c:7404
 btrfs_read_sys_array() warn: passing zero to 'PTR_ERR'
Message-ID: <202201291928.NthcMZR8-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0003.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::8)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95a99e7b-cacc-45a2-c9d4-08d9e4b784f8
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2140:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1001MB2140A2DBFA1303EAE8A297F48E259@DM5PR1001MB2140.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rRfjzrWtUDZwJdHAqhiYkhmsavtiOQRGlH4GlymVBW6/DRV9nNhay0x8nkD+Ut9c3loBWvoBiRMeFwlsYCzeAewgT47kJLnIhQgI6yiVwMicHdN64UatmASRwkdd3q7Z8Kx4sAOyPHwYW4ppKsW8qycKRuSx2U0Ar4U+5j+5TqL/t9kwQbVU5dwK2tzHRjv6r2TFxl4hf7KbP88DRTMQQKcgLGF7R3UTymEMe+24jJNe8sypuhVoVmrxdZWdW6zrYIL20w76XmxdpB3zl4kZyk7+Heplyp/8BeCsK1flYpL1X0mB83HKv1l0tSUZWjbC0UyU4UCLDiyppcY1uPw3Tqs2bgDPc9N4duD+wqqZpyl+3Oz4HFmv47zTkq6/ghiKX6SDmF4SsZhETHgmAL4Kx4zQVHvSjn5ShsMlNxqvYeRcDradRxvn+16BfebH/VWMIdw/EdU2te5Plw08Zolw2w9eiq95e2wme5UiXaZ/dAnWPZlGUszDDUcmnswUNaSqTg3408xMu+Xz+dENF22o+VUFtNH5KNuaaVz4KsGSgJd9OdXqBRwVmS863OjVkwS+ZRyGD04OIxVfTU84j2s77gwIL7aJtDXaRfyDAGbIQCm+Rg+W0sHR19yKVywoaKREBD8Noy9e/Ey1/IMkl/hle5K0VC3ap7HMKcnPi6E6N52gwUZRxzUt3FYfs0Usf3Np5Mf5RghUReMgtF12ITmcUjMTOTGd2tFlH1uTYMdEfhd/B9kMebgCyh4cN9a+pecqH0+aKe02aLc04To2xxF2BSW+1FHGbmb6E8HUjqo3YybMPBZiYlmu+9UETBoq2BzLopWjbBm2nU4lU674s+yS+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(86362001)(6506007)(52116002)(966005)(6486002)(6666004)(6512007)(508600001)(9686003)(44832011)(4001150100001)(66476007)(36756003)(4326008)(83380400001)(8676002)(8936002)(66556008)(66946007)(6916009)(316002)(186003)(26005)(1076003)(2906002)(38350700002)(38100700002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cu5S5i6UZxwtKgd0qdJ92CeH65wM5IKkBI9oaNu3ORl4xKvImQZeategBgPy?=
 =?us-ascii?Q?GUvuKXMX6Tx1UVoGCf/CI2dVohIfJTuQwNm4wMlB3D3kHJhfXAqvYOF634bR?=
 =?us-ascii?Q?KpPblb6jaq3DZYcIN4yahv8V4NCqN+t99do5SfRkpAbdG8wF2WJFH3jAYw7M?=
 =?us-ascii?Q?kdBFLMC6ZNVha/0MQeU91Kku6sF+nPkzmSEkyLz79sphc2McQPAXfXVrQSSx?=
 =?us-ascii?Q?NeMhQeh2uLYqoFtCZeBwIz+FH7WbZcr+U5CHuHyRwtX5ZT8ymWsDZAV+ipHC?=
 =?us-ascii?Q?ngErRMOAib97siGBZLBW+68Bruhx1fxaZ93fK+1T6c5reC2nAjca7cIxtJbp?=
 =?us-ascii?Q?oFwdUqJTkE9F4OurrgTSVLPI4XBLq6GO8mbw16qlTlkiwCa7sWfRrtW/i1fV?=
 =?us-ascii?Q?yWsSoAp36gQTj9vpse7ECuHckG1EaNzNom0JCnxyqgmRsG4d5ApG13BU4q1r?=
 =?us-ascii?Q?WFyjNEQHX3EAV4KFomNj0A9BMTispIcn0jhIweVG/HcbqXy9NgR+EicERTah?=
 =?us-ascii?Q?8yXFizcky85KqlKd3+3fOxvTNgeHEVTOCVtIRHy6q1TojgIO3jWFCZEQaoJh?=
 =?us-ascii?Q?2rqQOxJpSFcm7b2kOpJWoMM4kCjw9BkxgJUk9eggZfwfRZSlGKWlgVovCnoo?=
 =?us-ascii?Q?FSEVTd1q8i7Rk+bsMc9e3gka0ySIB7F7gNU3glHb9ppWfg1ydbIVxiC2cGwx?=
 =?us-ascii?Q?F+Hmx5TvuiILwwZQryF5RDzZACv1Ygx8Ug0APzkTGCglqZ8IjswMyI35rGnR?=
 =?us-ascii?Q?Wdan3Bx0tXuE0ZKf9DH39fO2e620NuIY2LGfUdE3/SbR/4+b7eLOdF/RTFT8?=
 =?us-ascii?Q?KXizKbCVdVoR9rXHfeN37zKFtoDo7nj0elFUDvjGPuD7yPMnAvcPJylhhrI7?=
 =?us-ascii?Q?FELd4zd7OcxeTb84GZYnrp6ijTgZNovVKVgm1nwG+6znqT4bBXRoR5WChlK8?=
 =?us-ascii?Q?4h18sf3wWwIEZautqvu+nDZKFWlT/dsbVTsWRU4Qdpqccyf6hGiMwfYW919c?=
 =?us-ascii?Q?3RI0HuAsxBFy3fLJ40UIAlCJ/tagU3sbGcFlssx/c2XfDOaSy0+L8Mx40b2M?=
 =?us-ascii?Q?NcWr/diNu34RWCPHC5YimvZLAqc9RKf+o2ZrUD/sKTAT/8cqfLwha8VWpf0q?=
 =?us-ascii?Q?Hi3O7ClMKAIotZrXTukrjW77JMuKi0yj2XMxZIOnRrYM2lnpxeNi4+j/lnAS?=
 =?us-ascii?Q?UDMvpe2NWKGGVVcdIluixY2Tl2u6pmHs+HL3EAco1kMl+jMtNTEtN4pe2dgf?=
 =?us-ascii?Q?1V5w0czwMhTP3DPWNN913pb2Etg60SaivYDNjn1NaIXYvSXHrn1gqh5dixZ9?=
 =?us-ascii?Q?Qft/Bs+I+7Y0ky0lmby34CKXTVZJrjDRHEZOPW5GTpGWkNRLUteWxgygBZrk?=
 =?us-ascii?Q?DS2ZMGl81sURmy1jJ+8NBMcaYxhGL+l4OM8O8N0rPXdtfVbgtcFBedocCZln?=
 =?us-ascii?Q?cSTg3P9VPPI8pH8VTCqH3byqkxG6oBPQu9asxcrODAwrUM6z6Eun+TnFno4U?=
 =?us-ascii?Q?tXH3YVT4wAahJ54+ulyL5yWo4uSERAOpnvWnkdOhUAuT7nH49CdcLzKDrajM?=
 =?us-ascii?Q?bJmH7SIxF+9lq7vJMoZpqokZ1Edg4BlMu8s6q5jhWNMwSDsmJv0j9IAbeTLe?=
 =?us-ascii?Q?F6E/SErt6TX26Wi8S31oU6ruSOJ2qZI39m275iyAP36/RsQ1Y7EDmIgp4SIe?=
 =?us-ascii?Q?P8J0TCr9eKAEsLQ7qpO0hxPC6pA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a99e7b-cacc-45a2-c9d4-08d9e4b784f8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 12:45:11.3962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: azMIRTKStnsvZilpEWN4Ho7y/QDvWNrz3qH/P2NsZ3RqQ+Mew7Xr0vjqy/3HRhox8sLK9ZI1wTE6uyAHx3qLVvLlhxjokYJKcp9VMQFQ3SY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2140
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10243 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201310085
X-Proofpoint-ORIG-GUID: 4E-CeF1iA_KhcPeY-l0ahUiBU6-2b0pc
X-Proofpoint-GUID: 4E-CeF1iA_KhcPeY-l0ahUiBU6-2b0pc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
head:   d98f768106353f72c66948a22e4cd0aa29d7ed5c
commit: e9795fb3fbcde13580e04a3f5a520a99f98f4a93 [54/72] btrfs: use dummy extent buffer for super block sys chunk array read
config: openrisc-randconfig-m031-20220124 (https://download.01.org/0day-ci/archive/20220129/202201291928.NthcMZR8-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
fs/btrfs/volumes.c:7404 btrfs_read_sys_array() warn: passing zero to 'PTR_ERR'

Old smatch warnings:
fs/btrfs/volumes.h:212 btrfs_device_set_total_bytes() warn: statement has no effect 31
fs/btrfs/volumes.h:213 btrfs_device_set_disk_total_bytes() warn: statement has no effect 31
fs/btrfs/volumes.h:214 btrfs_device_set_bytes_used() warn: statement has no effect 31
fs/btrfs/volumes.c:6431 __btrfs_map_block() error: 'em' dereferencing possible ERR_PTR()

vim +/PTR_ERR +7404 fs/btrfs/volumes.c

6bccf3ab1e1f09 Jeff Mahoney       2016-06-21  7379  int btrfs_read_sys_array(struct btrfs_fs_info *fs_info)
0b86a832a1f38a Chris Mason        2008-03-24  7380  {
ab8d0fc48dba09 Jeff Mahoney       2016-09-20  7381  	struct btrfs_super_block *super_copy = fs_info->super_copy;
a061fc8da7b990 Chris Mason        2008-05-07  7382  	struct extent_buffer *sb;
0b86a832a1f38a Chris Mason        2008-03-24  7383  	struct btrfs_disk_key *disk_key;
0b86a832a1f38a Chris Mason        2008-03-24  7384  	struct btrfs_chunk *chunk;
1ffb22cf8c322b David Sterba       2014-10-31  7385  	u8 *array_ptr;
1ffb22cf8c322b David Sterba       2014-10-31  7386  	unsigned long sb_array_offset;
84eed90fac1b92 Chris Mason        2008-04-25  7387  	int ret = 0;
0b86a832a1f38a Chris Mason        2008-03-24  7388  	u32 num_stripes;
0b86a832a1f38a Chris Mason        2008-03-24  7389  	u32 array_size;
0b86a832a1f38a Chris Mason        2008-03-24  7390  	u32 len = 0;
1ffb22cf8c322b David Sterba       2014-10-31  7391  	u32 cur_offset;
e06cd3dd7cea50 Liu Bo             2016-06-03  7392  	u64 type;
84eed90fac1b92 Chris Mason        2008-04-25  7393  	struct btrfs_key key;
0b86a832a1f38a Chris Mason        2008-03-24  7394  
0b246afa62b0cf Jeff Mahoney       2016-06-22  7395  	ASSERT(BTRFS_SUPER_INFO_SIZE <= fs_info->nodesize);
e9795fb3fbcde1 Qu Wenruo          2022-01-13  7396  
a83fffb75d09cd David Sterba       2014-06-15  7397  	/*
e9795fb3fbcde1 Qu Wenruo          2022-01-13  7398  	 * We allocated a dummy extent, just to use extent buffer accessors.
e9795fb3fbcde1 Qu Wenruo          2022-01-13  7399  	 * There will be unused space after BTRFS_SUPER_INFO_SIZE, but
e9795fb3fbcde1 Qu Wenruo          2022-01-13  7400  	 * that's fine, we will not go beyond system chunk array anyway.
a83fffb75d09cd David Sterba       2014-06-15  7401  	 */
e9795fb3fbcde1 Qu Wenruo          2022-01-13  7402  	sb = alloc_dummy_extent_buffer(fs_info, BTRFS_SUPER_INFO_OFFSET);
e9795fb3fbcde1 Qu Wenruo          2022-01-13  7403  	if (!sb)
c871b0f2fd27e7 Liu Bo             2016-06-06 @7404  		return PTR_ERR(sb);

Return -ENOMEM;  The current return PTR_ERR(NULL) means success.

4db8c528cdccb4 David Sterba       2015-12-03  7405  	set_extent_buffer_uptodate(sb);
4008c04a07c73e Chris Mason        2009-02-12  7406  
a061fc8da7b990 Chris Mason        2008-05-07  7407  	write_extent_buffer(sb, super_copy, 0, BTRFS_SUPER_INFO_SIZE);
0b86a832a1f38a Chris Mason        2008-03-24  7408  	array_size = btrfs_super_sys_array_size(super_copy);
0b86a832a1f38a Chris Mason        2008-03-24  7409  
1ffb22cf8c322b David Sterba       2014-10-31  7410  	array_ptr = super_copy->sys_chunk_array;
1ffb22cf8c322b David Sterba       2014-10-31  7411  	sb_array_offset = offsetof(struct btrfs_super_block, sys_chunk_array);
1ffb22cf8c322b David Sterba       2014-10-31  7412  	cur_offset = 0;

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

