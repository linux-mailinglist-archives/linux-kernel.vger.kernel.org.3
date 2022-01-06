Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF914864D6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 14:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239275AbiAFNCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 08:02:09 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:29326 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229478AbiAFNCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 08:02:08 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 206BI93i013470;
        Thu, 6 Jan 2022 13:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=bSEseeLqqR0mivN305W4idwK9l8zDUXfzUYkOkYYJF4=;
 b=AfoYBs/zDV40fKuK3bnyEjlooTCcx/UgLzTgTiHS+VZUa0/Yy4hvdE4+W8lBDlHwHBOI
 heF+U5m0Dqq5g4yNFa8znjmmN5lS0agVYi8o+qXRfBtyHrUWtHjCYec53NCv+NO0bTHK
 Vdc1AzkKglFkwJGd4k1XSDN8d4qhiuqgP6kDd+AEfpNYOEkg8ln0ku9O83wD48gR/qBl
 Wrr74JShRGfMiPPN39YyJsAKLMo1SZdjXNHqU8LmS4AyTvqdoL0zO22boKACyisF4ZVL
 QEsHgSLyChSVSrXY8ACWr/TV8y87A3LIiUsngC5qR/B/CVZGwGCLDx/t2jrv1+DNt7JO Yw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ddmpmhjqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 13:02:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 206D1pcY099846;
        Thu, 6 Jan 2022 13:01:59 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2042.outbound.protection.outlook.com [104.47.56.42])
        by userp3030.oracle.com with ESMTP id 3ddmqcrqje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 13:01:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWnmwdRVeH64X6UtHURUNmFJh4QDDWguWd98eu+xGIoAwi3SBoygLpoiS/XhR4iiM609QoeO243IsIISWEeD5oIengPCNIrMCIX1v2XuNUzMGqfTrzXTOIo5gdpZRsgI5DT29DwM5mLM6xN1xzuirriP6fR23UmeUS2Av93SGIWHfxJYYsfrDitDmZbhxXnntB8IxceXIdzUWTkRSEfvKMzyCPi0XKhMcTuWQXr7OaME8syUoRKjG030brdmneDPZeYgvwJvFCJwt4vR3TWmGo5yZTdfcm6F4Qaa+y3BmOUYVaq4hYGlR+cBJfTUbm8lkwxr4zUHhwyZCiNDDdGQNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSEseeLqqR0mivN305W4idwK9l8zDUXfzUYkOkYYJF4=;
 b=FKvEOuBydJlYQUySs+dvf86097aT4EHw6PeegQXmdUSJXw46yaxXDj2YlnKvvEf2m5EHvYQ/k2ebylirw0G4aufoMYn+yLk5k8G760KycU2HOci1ROKx0TiMWV5fojENKZdn2Rzq16O7gPfBMIb2iqrc3BubAt5KImLMVeSLFbCQeF29MKRxIeYkhGE/eLj7vAZJneFufBSiwEC4Ix3l80/mg/D6Fr90LTVEFSpGaGRiwTXfv4Kj+W5SciPTTY1SrQcOFVPH6hJftlhLnnoCq/X3sEXNsgmWZexUr7CiVFYwWhZBvzMQNVRBTnrN6foxJOKMaMf2Q/tx9AykAQfCYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSEseeLqqR0mivN305W4idwK9l8zDUXfzUYkOkYYJF4=;
 b=C3SE1IKSl5pO8NVyhChgprm9PwNC852Tvu2xODB7F2ubyuNnLzn3QuNXSALVsPGB3CbbOtdYqdXOgEGRaq8ZODkTIZK1lvlVZrzHbdd/KsPfdytres0P3KY9gCiJ+mfupmAauyISp5jFpgasWFOXQtV22Dj03tijje0MnvZevP4=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by CY4PR10MB1751.namprd10.prod.outlook.com
 (2603:10b6:910:b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Thu, 6 Jan
 2022 13:01:57 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::38cc:f6b:de96:1e0e]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::38cc:f6b:de96:1e0e%4]) with mapi id 15.20.4844.016; Thu, 6 Jan 2022
 13:01:56 +0000
Date:   Thu, 6 Jan 2022 16:01:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [goldwynr:iomap 27/33] fs/btrfs/file.c:1517
 btrfs_buffered_iomap_begin() error: dereferencing freed memory 'bi'
Message-ID: <202112302317.OJzUYuIb-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0039.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::27)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf8ce86c-0c33-4d59-3a2a-08d9d114b7fa
X-MS-TrafficTypeDiagnostic: CY4PR10MB1751:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB17519B78F9CE69B513A03D478E4C9@CY4PR10MB1751.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6k2YiuSyvZdCpKytsY39oAe6z0jntn3bMqU0B3WkTY3PZNLvHDYe+330YIh4aKCyGBqHn8k4Vv+QWw8xd+et1aDp+fT2B4iSz1MbmCg3bJpiQ+9pj/CLTlTDgLhqiNaW/cpG5MWzua3V8Ic+jG+DPCPX5sQyuEHPdcjproEb0cykiouzEa5SmvuCCeTyvfy/nixDbg1Ncrg7xfoWo98dyJDWPI7N/0qM8qP+kJx51Qk9NAwObSrgcNNH9kQekyKV7ryN/HsvJW6YIte6roishgC16fMKjpa3p1BoqhumsbQaGKn3Lo5ikgIdm5pQqWHyISC6veFvCW2EnOOlQ766hJ7Ai8mqXe4MwZz5IV7hwWIGPdiWarDmckanuDzBAcYycv/ZiSi+41vpNSsmFygF+wIfSHy0y0mHqdKx/brys0KJSWt3LI7CDI2KTj6vJQQ839vficUjE/U+Doscoh8fL5gti/tCj2cBX5JoHpnlfECyDbH5Tios/3kDR9CVsR5i4DBmsLmWAuXdHXEdtid8ZNZjs/l7xbr4QYL4aScEV3o7aBT/FvgfGTEjOtqrxP4y9Hz4AtuF/7AH+mJU0FIOVC8yaadYByAVtuNAvNkV04MVPZBbwv6M4RRM7GB+rvVp8TjM2y7n3Yl4PCXmGmkOYQwn3mlpJtTB+QwmCu2/SQhJUPVEAKJnfF5ziyLtpiC5G5AhlV/dbntVdMJB97g+d0vuxDmCbliHl4P400O/527OUpzfrDi76ZsKNMp/9D7EdXhbNCqWWbEIJQIfyNby1u07s18HIG5XxDwtKFX6AhU5272H0wk1saMgDLAZXmzkCCuCqwgUo2fMV4vU17E6Uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(5660300002)(6666004)(26005)(38350700002)(66556008)(52116002)(66946007)(44832011)(316002)(6916009)(186003)(1076003)(83380400001)(8676002)(2906002)(38100700002)(36756003)(9686003)(6512007)(86362001)(8936002)(508600001)(6486002)(966005)(4326008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xeFP+Sp1gZWOONM0E4gZMilC++XLANk/Hex0a85ZPj9lEl3/LDhuOgAOFlin?=
 =?us-ascii?Q?bXrLIMjTwlSZ6tYSFhQL5DCh9noISJsyydab0dG65LpgqbBhJx5JZ0/RmfsV?=
 =?us-ascii?Q?KDU3AAxlTLGq3j5IxTAY3zYbhTZzUFuVyVNkfoi4Ri8QIgmgGWU2ufinDwon?=
 =?us-ascii?Q?UP+rYgNmS4cynIQH6aj27gfGychRIMCd41DLy24DpHA2LTpJLDW7iLfzySdi?=
 =?us-ascii?Q?f4/kjmez5QIGgqzXzAzgari3f7pH0i3rTspySeh8FpfmN+U+Rw9wuldbzbM+?=
 =?us-ascii?Q?wqee3gDSddiZse0Ck6hSNMsWlojx73oSnAitCgr+Om1Wdfs5IcGgAyZiEIbs?=
 =?us-ascii?Q?kIHF1NddZPFA1xv0Q/gEKnTI+W4w2h+gmPcea5TRruLD81Y+BHB4gfXgsldp?=
 =?us-ascii?Q?xJxtt0YKKtqyXOY/4cOyPAHh9rigsxnaUqVzl4A0GpqoZ5NKh3FKqAYx68Mj?=
 =?us-ascii?Q?CfO8V7Hmih1is8jYyE/UEVEaXKF/0IQJG1uU4HcYZSKr8xbSXrcUPZ+Skdpv?=
 =?us-ascii?Q?q/giIjLR9ySBf8MxlY0S6G2kjptZdFHHk/tsM1Va5W6e7WH7ZBag0iyhQIhP?=
 =?us-ascii?Q?Lik+4JycQiYNbvGX5GMRRloXQsdytm0Q7j7/kZ0pdIv0qpJOM6xrG3dEXMNA?=
 =?us-ascii?Q?FxcKiCjn7ciHsHVOqEiRqMJKcR6RklU0R1JFNiQjvRFwK8mUYV28CRcQvxkw?=
 =?us-ascii?Q?QJwQTcwm8ZyPdWU2Ypdl7njCkHbd6f/de3Xr2DzlYNYzJDAxNqVqKuwADJoY?=
 =?us-ascii?Q?8DEB/pUDtrkN3h/MZRLqC2JbCXoasz5wEOrBOLYCf2MFxELO6qfJsv2gz92J?=
 =?us-ascii?Q?72RdfLxmYK+k1BLX2VrJHhYyvkyzjf4D6jDfI2ysNg60pnWoyaG8G6EeUVec?=
 =?us-ascii?Q?WM9h6l5QXRD9SeVWKLbAYKhUV0Y1+kxWx17V3scMuhqW/BTnyA2t4g089xUZ?=
 =?us-ascii?Q?AZeWLqs/oO0k93wBStp9QyD/UC1hRI8kACQ/vTNsNR1DXxyauQGHa9K1LMRo?=
 =?us-ascii?Q?ozp/wSRKQ/4WCtd9MW5ajumRYUXD7GlKbBkjCWdI9CJMK3//ZMAqOK+gIdFP?=
 =?us-ascii?Q?0uLlPx9/cHsr2hjdnQXkgmE7KwPV3U+GufOkysFKK5rszim8t76MZWQ7rVKI?=
 =?us-ascii?Q?WJlcsq0sb7BmzHk4kGJRPgukLLkmSBRjnzdab7zSJCHalk6GEaymjvTlcDvA?=
 =?us-ascii?Q?DGGhTDsCnuWV9FS+dtIrlKACLe8aaUOV9iGuHd2HivOHBd4CuDc6pwkUHnZt?=
 =?us-ascii?Q?DkEQw89uMpReYqyTFSxZOr4rec4RnZuAuUdrSNjxENofNy33u6fcUpL1khuo?=
 =?us-ascii?Q?MvFY5okkEe33CW3QVCNrXsHw16kF8jw8xQwZjyoyp8keJE+bKkFCCgd7FlcE?=
 =?us-ascii?Q?5cDnb8v4Vml8CEAiSaFMoyWY5/dAwruYrHeVRe/vy83NyE5u0MlU2GRlBL1V?=
 =?us-ascii?Q?Del9AwVpUBX1WweTGtIoeEVKvfevyCrjXIG1dVx0prtTzk5+Dod7hAGuva6E?=
 =?us-ascii?Q?2wnTXMmaeDo6HxIadQB4n+L3PJSDXpeBBbwfBSeqzI05DnYPZu1tPcsTFO3n?=
 =?us-ascii?Q?IY6SFCP4bxNcWVh7Fv6yVLAo6JROMimyxtOUtc9vUsjvSNCn8B9a/a79XDl0?=
 =?us-ascii?Q?UKX0hzkir/lLWFDBrb6+dtZycMRQmqIVg5BDXs1XSUjN8MHn/ZXiQl8RCl4B?=
 =?us-ascii?Q?9uU0bvsiV+nUK5vL4ygD8pOkX5c=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf8ce86c-0c33-4d59-3a2a-08d9d114b7fa
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 13:01:56.7378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4FIMtDC66Ei7AYLRu5tcxE34Yn2elbWbz/miAGsNahsqK34e2wyTWQ24CKS9alwvGzQblrKwyXtvp9gyI4AQDbJEzIWLlFjUhQLnwhE8zrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1751
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10218 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2112160000
 definitions=main-2201060092
X-Proofpoint-GUID: 9PPBWB6vvQg2UgEkOTxl51G_eyxHKH_-
X-Proofpoint-ORIG-GUID: 9PPBWB6vvQg2UgEkOTxl51G_eyxHKH_-
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/goldwynr/linux iomap
head:   30c74a8c201365178cae26d0d7aefa120c3245ab
commit: f3623890897fee87c24f37ae01a2f1a5c35a39d9 [27/33] btrfs: use srcmap for read-before-write cases
config: i386-randconfig-m031-20211228 (https://download.01.org/0day-ci/archive/20211230/202112302317.OJzUYuIb-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
fs/btrfs/file.c:1517 btrfs_buffered_iomap_begin() error: dereferencing freed memory 'bi'

vim +/bi +1517 fs/btrfs/file.c

b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1490  static int btrfs_buffered_iomap_begin(struct inode *inode, loff_t pos,
f4ecee4435f363 Goldwyn Rodrigues 2021-04-21  1491  		loff_t length, unsigned flags, struct iomap *iomap,
f4ecee4435f363 Goldwyn Rodrigues 2021-04-21  1492  		struct iomap *srcmap)
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1493  {
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1494  	int ret;
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1495  	size_t write_bytes = length;
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1496  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1497  	size_t sector_offset = pos & (fs_info->sectorsize - 1);
f4ecee4435f363 Goldwyn Rodrigues 2021-04-21  1498  	struct btrfs_iomap *bi;
f3623890897fee Goldwyn Rodrigues 2021-04-21  1499  	loff_t end = pos + length;
f4ecee4435f363 Goldwyn Rodrigues 2021-04-21  1500  
f4ecee4435f363 Goldwyn Rodrigues 2021-04-21  1501  	bi = kzalloc(sizeof(struct btrfs_iomap), GFP_NOFS);
f4ecee4435f363 Goldwyn Rodrigues 2021-04-21  1502  	if (!bi)
f4ecee4435f363 Goldwyn Rodrigues 2021-04-21  1503  		return -ENOMEM;
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1504  
f3623890897fee Goldwyn Rodrigues 2021-04-21  1505  	if ((pos & (PAGE_SIZE - 1) || end & (PAGE_SIZE - 1))) {
f3623890897fee Goldwyn Rodrigues 2021-04-21  1506  		loff_t isize = i_size_read(inode);
f3623890897fee Goldwyn Rodrigues 2021-04-21  1507  		if (pos >= isize) {
f3623890897fee Goldwyn Rodrigues 2021-04-21  1508  			srcmap->addr = IOMAP_NULL_ADDR;
f3623890897fee Goldwyn Rodrigues 2021-04-21  1509  			srcmap->type = IOMAP_HOLE;
f3623890897fee Goldwyn Rodrigues 2021-04-21  1510  			srcmap->offset = isize;
f3623890897fee Goldwyn Rodrigues 2021-04-21  1511  			srcmap->length = end - isize;
f3623890897fee Goldwyn Rodrigues 2021-04-21  1512  		} else {
f3623890897fee Goldwyn Rodrigues 2021-04-21  1513  			bi->em = btrfs_get_extent(BTRFS_I(inode), NULL, 0,
f3623890897fee Goldwyn Rodrigues 2021-04-21  1514  					pos - sector_offset, length);
f3623890897fee Goldwyn Rodrigues 2021-04-21  1515  			if (IS_ERR(bi->em)) {
f3623890897fee Goldwyn Rodrigues 2021-04-21  1516  				kfree(bi);
                                                                                ^^^^^^^^^

f3623890897fee Goldwyn Rodrigues 2021-04-21 @1517  				return PTR_ERR(bi->em);
                                                                                               ^^^^^^

f3623890897fee Goldwyn Rodrigues 2021-04-21  1518  			}
f3623890897fee Goldwyn Rodrigues 2021-04-21  1519  			btrfs_em_to_iomap(inode, bi->em, srcmap,
f3623890897fee Goldwyn Rodrigues 2021-04-21  1520  					pos - sector_offset);
f3623890897fee Goldwyn Rodrigues 2021-04-21  1521  		}
f3623890897fee Goldwyn Rodrigues 2021-04-21  1522  	}
f3623890897fee Goldwyn Rodrigues 2021-04-21  1523  
f3623890897fee Goldwyn Rodrigues 2021-04-21  1524  	if ((srcmap->type != IOMAP_HOLE) &&
f3623890897fee Goldwyn Rodrigues 2021-04-21  1525  			(end > srcmap->offset + srcmap->length))
f3623890897fee Goldwyn Rodrigues 2021-04-21  1526  			write_bytes = srcmap->offset + srcmap->length - pos;

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

