Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46D0565770
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbiGDNdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbiGDNcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:32:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E515DC68
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 06:30:43 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 264D20uf001698;
        Mon, 4 Jul 2022 13:30:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=6d0SZnpxa7aO6JQZO7NxbuFxnupgXVroc/aQ6bcVY4I=;
 b=RppynvIECL44DgByDRMuD0LTklsSbkMi0azw7wKtzo9AY0Asd2MHDqwcLML1vsqqln1z
 ocJr0w8mfPHGwJVoHKwcS5DmnreAltlyphlWNYhXLBZPWFW/1qphnULJL9JlyqRRsiyv
 T3lNVEJjceVtPTA+oJGvma/6dbr0HZCLd+aAAoijpIu74f0iVf45iG9XMe0OU4nzv2XS
 SxB6fs0tIolLU0xj/X7uKzpUUdu9hduIRcz12Rk4UI3vtXywbK0IeU7lPdl9jwykakv0
 vmN3K+qVd9uuykg/ftqOxwF8tObozX/odEea0qhtUnwchYQwS1QgZUCRiKuy6PP9ugLB bQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h2eju3fas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jul 2022 13:30:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 264DFCdf032918;
        Mon, 4 Jul 2022 13:30:39 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h2cf1m61y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jul 2022 13:30:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XogiAAsk45EowuyHJjKy322oRif4YGts6lL46+F6SQ2SyDudbOFcUT29M+qKVlf+2tRvESihtI/wisAYeho0MkG3mBLFhrgf7r6ZiT8BiLPlwLGcUZjcKkEv/mU8hFV1hh5JGT2dZkPIxwEQv3vni93x7+JaYCuc2mR7sKYTumXlzoCkWzRdIeDSiODZpgePzvd8IkKkYFF+kMTjV1NN3AhZoZfIbOc0XY/jF/VZ2k2d2rJ2hhHkeHaIsXiy3MJUBWDGJa5lqJCcCeoObqfgDN46abmFlaYggJ8foEbchdex/LNswye0s/04uelq/ohuJGduiFjWZO+kmzf+JsWjpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6d0SZnpxa7aO6JQZO7NxbuFxnupgXVroc/aQ6bcVY4I=;
 b=n/w8kVs4+ZP/8uWa34GREmFumo9eIgGuxwU7CgTyqBl6lPU8kuWgRZE5bmo4XbCh0/gJMB/uY0eeP5ozXO9svKh+HuBCCqPEhiETA1xnyghDmnFjxcbZSUlW/51l+U6jz91sURfQDpeCEpJqu8QtNz++jb+2UDJ/tlx9GqSQ/IY/wmxfOouImQLiLbRtcxyVci/ciZkpFCBkLObYIaqMcGWZnjvGXoIWCbSWnhbIFO+rhLGGJroD/CphTT1GjmqKdBMDHvzI6HggmIsdS5h0iO7IH19ZMmDVDaDmTVmzKod/zNLHEsmF0lR2HGRO8siOdQJxmOS+Jjm0BBGJEEXOWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6d0SZnpxa7aO6JQZO7NxbuFxnupgXVroc/aQ6bcVY4I=;
 b=Yzd08ed6OjpETHMhVsiVw6a15AkoubnkIAB0Kk9OqFK6g5UXzx5e7aHhKy4XdJKCh6olGC1ffaqJmEhXJPk8lQobZqsfdheHAr5pmApbW8dmeRGEmKoYkMmhhb/3/oD7zQL5dWOostSnDyk4iqCGiQjlY1xTJBxc8TyRr6Dx8gw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BL3PR10MB6020.namprd10.prod.outlook.com
 (2603:10b6:208:3b3::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Mon, 4 Jul
 2022 13:30:37 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5395.021; Mon, 4 Jul 2022
 13:30:37 +0000
Date:   Mon, 4 Jul 2022 16:30:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, David Howells <dhowells@redhat.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-linked-list 61/61]
 fs/netfs/buffered_flush.c:1072 netfs_select_dirty() warn: inconsistent
 returns '&ctx->dirty_lock'.
Message-ID: <202207032252.h0jjY5dH-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0022.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::34)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 216b81d4-d8a4-4b32-9bab-08da5dc1614d
X-MS-TrafficTypeDiagnostic: BL3PR10MB6020:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yAJqvGrmu8nLEq7mOC/ZDc7pkYvy5dX6MNq2b3yOTE4q6NsIr3ongxGY9DDb8XlTMV/pBJTpvmVJQ20DsZVQX+R5VL3sLwLrhDs3DkVLT1w23guDnVD8wkaVl7GojXDEqxupMktgMfBVPBi+t9y7tx8Bjev+J0pJzlw/P1qNWUlwfAyTlMUCfHVKQLIuDs3d69gaeJfaSNXN2kwkM3xlHNEACb4fVHlXb0N18vR6vbX1dCL1/ViHnYw7KfrsSkZ9ndQG2/vBMbJuRDPAwCJw73huMXFfsoaQrJs13Bgodept/2eEF0iCDuaThqdIaa2Ycl+hdtjIncPhQL5lU7EBIJvc0VwT9CIXrAJVekZhoyoDd0GhdPny4xywkYULYAWPm+f/+Of46pX8bU9cgyjxdPmx3AjRboUsz6U6UgF5SW10RA1yFPs8IpKKXQq+/wddEe58ecnFvthanwauP9ODvPh7onVU/ATS10UMNcjeD/T7jWhQLSUyLAfJoJ3e77+/WN4S07/llYRhXUxVaRTDxT5inytqzSn0rG2oY6OFkYS90CIaNvwM/eyp/vj8oEiiDMJ9f7psU7Kn8vxKphtdvMZIRcOIz5t7POxNohxPgWQYG2bkwnIlZkr0GPDM5yFgvXHElco00lEvX4BCXSLqyEFpmcWyhBM1Gb7MRdAcCGA/zGsP7exoyLT1dArmbnSKbOQaNDxZ2mb14Igks3eGRsZMnMYL1qs2k0ZxraE+96L2fzP9UjSge63e2vchketsOZNcQG89czL1kEsdqnjS/Vv5rQhMiJ1fWwBnxkfuzgtd764HQmqLqg8fLakxpINEgowJHctO9lfETzihfFsjXb6GTqDpqoaPwQ+OWtni7rUKZhf6IfBsGDdmeA2/f9K85DziN0NYfQFNUaw6PeLVsZu/pnY5dG/GkByIEBK+WAg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(396003)(376002)(39860400002)(366004)(36756003)(66946007)(478600001)(8676002)(38350700002)(38100700002)(66476007)(66556008)(316002)(4326008)(6916009)(86362001)(9686003)(5660300002)(6506007)(6512007)(41300700001)(52116002)(2906002)(6666004)(26005)(8936002)(1076003)(6486002)(966005)(83380400001)(44832011)(186003)(14143004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n6neJQp2KZE/sQvqT/o3n3oHlwSlXtYEMRvctWbbXN7mzKuaYZL9inK7CicS?=
 =?us-ascii?Q?Xl/LGq0o0d9DWDezHyWXi/tJ/8NRwoVTUx2Y95gvuHOC/28L98Viy8r9VMr1?=
 =?us-ascii?Q?FmsXy8JfZZXyRKdB/basGmlhkvOY4rP1yN8cAJ+ZVORlfQ1JaXraABniiYy4?=
 =?us-ascii?Q?bxCWpXwxdQ0aGDhFrxaoE/cARs8grOwbsmoYmgclD3OmJdqw0XjMqJTjRCHT?=
 =?us-ascii?Q?EUt7yH5U4qxs1piEQ0QPl+K72CMo/5oi1sP0Ry5bK2eZ/k6D3W2OGXZLUS3s?=
 =?us-ascii?Q?uKqIeDg3DGpLDdiBnKMBS77OFErVoxX98ZRC9tK9nQMVftCpO4puYCfTF2I/?=
 =?us-ascii?Q?x70xIr/2cWQGvU64ePOEoyj4pwGx1qdWl2Ih/GpgFHh6v5GzgDx22GQ3o7H1?=
 =?us-ascii?Q?ug/DnilFuJ+zxliruNCTwXmIbOnn/lF9RxQ5pG2/CzFA17W1qabxm5hd2Zl9?=
 =?us-ascii?Q?K5ZKb1Mv3MicvIYKzugocYNYWQ8hdrCzILXkMYDdNqrUtd4475EOgRhuLVEW?=
 =?us-ascii?Q?WJlDZ3ksUD/vp3mVWoyBvVFKELsjhTmEPVtuRacOfuk93damwYpR+SHcVYWs?=
 =?us-ascii?Q?r/VX58A2rbDBnM3nmrNy00uRJgSMEDmwOq0I/RfOoReVW6BEy2S3Klj+hAqJ?=
 =?us-ascii?Q?V0FX0axEX7eHo4zcw8IVh0r7S7v26yUBHl3oXWY6LEb/WEeam4e3J6cCyCD3?=
 =?us-ascii?Q?ymaV+xaCVXyuR6HN3bMK0ZxNMoHB2sXx7h56snpRbB7mi0OAoP2viNp8XURX?=
 =?us-ascii?Q?kFmy23RfEWEiopizM+Emam+t67SmpS+Qjl/y2Yb0fV8F4mUIW5oo0g9b71Sd?=
 =?us-ascii?Q?1xK4ty9skyd2ljK9kOoC7xu5fY7QQaUkvFnuMnZEPWGulhCty1V3fPYcmPFS?=
 =?us-ascii?Q?tnXko6FqhnM+f66TbDgTKodPb1QsXBFYcWHrhPdAOxU6tOnQRfjFSdpv+OHG?=
 =?us-ascii?Q?S0URRfTn7mVMItkFJOJ2J1XW0BGcz5/WTddWBZlhr59F3AeMf269ziBTCa7j?=
 =?us-ascii?Q?ZXH8ZAVS4rPpuCQUgIkizt2AcuGKgNGVgdbKWuPA9UI63iXMCmBfm26e1ZYr?=
 =?us-ascii?Q?8c26O1gZaqCCDeajKYGtN081/oA2vK/LtRk3CLshUnpE1ZM9xS3zcmxMD2SB?=
 =?us-ascii?Q?2yf4Tf3EFq4EMmOPr2yO3YFG/keuhObCJvRjvFR6qkoI8xBZe9A6rzwf4zxo?=
 =?us-ascii?Q?5Kgi0X4A6WzQqAjFWt5qw85ZhhUSEv7NQlcZ0nYKvVb/74sfFmvf6k/g92o9?=
 =?us-ascii?Q?TrCALvxKaagnQms2Tm+1/gxzdzqlx1ZAf3SM7oEI0YwErtDE+8Dxpowio0y3?=
 =?us-ascii?Q?teitJBmRz0Yy1ZJPFlEg6A+e/bso3RmPmaGiodayEGhb9Oj9CIcLLQ+F8oQ/?=
 =?us-ascii?Q?D+RS/5RL38erIPL2kkazS6q5vNqN3Ly1Sov6QN+4Vs//7/r0DdrFj2EsQUkd?=
 =?us-ascii?Q?7C5sJhm+cxAl0rMzreuIJFZrY0VRwD7R1y4c/onaVg9sexuPa8Iw4e+Ns18C?=
 =?us-ascii?Q?hfPMuy+VecNxjtVvoumXa4y8H55eVGP50zxYmhV7EqoHK/5xCH8VE2MZyzHt?=
 =?us-ascii?Q?4G6NUQHbdGz76ICxz6bZkAAUPwa7GBzvt3Mjih0jrwzMsmHG0aPCH1NBy0jr?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 216b81d4-d8a4-4b32-9bab-08da5dc1614d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 13:30:37.2174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F23fjFX1WgNv+AEQg3S5t8rnST9kU6YhCiprNnkvKKIo90uodpEYihAK2/lvCcCsupSCHBa31viNnRZG2RAphtaXTfN0wXdgKMdK23sv0sA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6020
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-04_12:2022-06-28,2022-07-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2207040058
X-Proofpoint-GUID: uckTPcbgstndsvyaT-VipxjukCxFAb6C
X-Proofpoint-ORIG-GUID: uckTPcbgstndsvyaT-VipxjukCxFAb6C
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-linked-list
head:   ce4670495468b797b0c5927fcb661bc0da48b9ab
commit: ce4670495468b797b0c5927fcb661bc0da48b9ab [61/61] netfs: Add a struct to group modifications together and flushed in order
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220703/202207032252.h0jjY5dH-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
fs/netfs/buffered_flush.c:1072 netfs_select_dirty() warn: inconsistent returns '&ctx->dirty_lock'.

vim +1072 fs/netfs/buffered_flush.c

2dc27084e13c291 David Howells 2021-06-29   980  static int netfs_select_dirty(struct netfs_io_request *wreq,
2dc27084e13c291 David Howells 2021-06-29   981  			      struct writeback_control *wbc,
2dc27084e13c291 David Howells 2021-06-29   982  			      struct netfs_inode *ctx,
2dc27084e13c291 David Howells 2021-06-29   983  			      pgoff_t *_first, pgoff_t last)
2dc27084e13c291 David Howells 2021-06-29   984  {
2dc27084e13c291 David Howells 2021-06-29   985  	struct netfs_dirty_region *region;
ce4670495468b79 David Howells 2022-02-07   986  	struct netfs_flush_group *group;
2dc27084e13c291 David Howells 2021-06-29   987  	pgoff_t first = *_first;
2dc27084e13c291 David Howells 2021-06-29   988  	pgoff_t csize = 1UL << ctx->cache_order;
ce4670495468b79 David Howells 2022-02-07   989  	bool advance = true;
2dc27084e13c291 David Howells 2021-06-29   990  	int ret;
2dc27084e13c291 David Howells 2021-06-29   991  
2dc27084e13c291 David Howells 2021-06-29   992  	/* Round out the range we're looking through to accommodate whole cache
2dc27084e13c291 David Howells 2021-06-29   993  	 * blocks.  The cache may only be able to store blocks of that size, in
2dc27084e13c291 David Howells 2021-06-29   994  	 * which case we may need to add non-dirty pages to the buffer too.
2dc27084e13c291 David Howells 2021-06-29   995  	 */
2dc27084e13c291 David Howells 2021-06-29   996  	if (ctx->cache_order) {
2dc27084e13c291 David Howells 2021-06-29   997  		first = round_down(first, csize);
2dc27084e13c291 David Howells 2021-06-29   998  		last = round_up_incl(last, csize);
2dc27084e13c291 David Howells 2021-06-29   999  	}
2dc27084e13c291 David Howells 2021-06-29  1000  
2dc27084e13c291 David Howells 2021-06-29  1001  	_enter("%lx-%lx", first, last);
2dc27084e13c291 David Howells 2021-06-29  1002  
2dc27084e13c291 David Howells 2021-06-29  1003  	if (wbc->sync_mode == WB_SYNC_NONE) {
2dc27084e13c291 David Howells 2021-06-29  1004  		if (!mutex_trylock(&ctx->wb_mutex))
2dc27084e13c291 David Howells 2021-06-29  1005  			return 0;
2dc27084e13c291 David Howells 2021-06-29  1006  	} else {
2dc27084e13c291 David Howells 2021-06-29  1007  		mutex_lock(&ctx->wb_mutex);
2dc27084e13c291 David Howells 2021-06-29  1008  	}
2dc27084e13c291 David Howells 2021-06-29  1009  
2dc27084e13c291 David Howells 2021-06-29  1010  	/* Find the first dirty region that overlaps the requested range */
2dc27084e13c291 David Howells 2021-06-29  1011  	spin_lock(&ctx->dirty_lock);
ce4670495468b79 David Howells 2022-02-07  1012  
2dc27084e13c291 David Howells 2021-06-29  1013  	region = netfs_scan_for_region(ctx, first, last);
ce4670495468b79 David Howells 2022-02-07  1014  	if (region)
ce4670495468b79 David Howells 2022-02-07  1015  		kdebug("scan got D=%08x", region->debug_id);
ce4670495468b79 David Howells 2022-02-07  1016  
ce4670495468b79 David Howells 2022-02-07  1017  	/* If the region selected is not in the bottommost flush group, we need
ce4670495468b79 David Howells 2022-02-07  1018  	 * to flush prerequisites first.
ce4670495468b79 David Howells 2022-02-07  1019  	 */
ce4670495468b79 David Howells 2022-02-07  1020  	if (region && region->group) {
ce4670495468b79 David Howells 2022-02-07  1021  		group = list_first_entry(&ctx->flush_groups,
ce4670495468b79 David Howells 2022-02-07  1022  					 struct netfs_flush_group, group_link);
ce4670495468b79 David Howells 2022-02-07  1023  		if (region->group != group) {
ce4670495468b79 David Howells 2022-02-07  1024  			kdebug("flush prereq");
ce4670495468b79 David Howells 2022-02-07  1025  			region = netfs_select_from_flush_group(wbc, ctx, group);
ce4670495468b79 David Howells 2022-02-07  1026  			if (IS_ERR(region)) {
ce4670495468b79 David Howells 2022-02-07  1027  				ret = PTR_ERR(region);
ce4670495468b79 David Howells 2022-02-07  1028  				goto unlock;

spin_unlock(&ctx->dirty_lock);

ce4670495468b79 David Howells 2022-02-07  1029  			}
ce4670495468b79 David Howells 2022-02-07  1030  			advance = false;
ce4670495468b79 David Howells 2022-02-07  1031  		}
2dc27084e13c291 David Howells 2021-06-29  1032  	}
ce4670495468b79 David Howells 2022-02-07  1033  
ce4670495468b79 David Howells 2022-02-07  1034  	if (region)
ce4670495468b79 David Howells 2022-02-07  1035  		netfs_get_dirty_region(ctx, region, netfs_region_trace_get_wback);
ce4670495468b79 David Howells 2022-02-07  1036  
2dc27084e13c291 David Howells 2021-06-29  1037  	spin_unlock(&ctx->dirty_lock);
2dc27084e13c291 David Howells 2021-06-29  1038  	if (!region) {
2dc27084e13c291 David Howells 2021-06-29  1039  		_debug("scan failed");
2dc27084e13c291 David Howells 2021-06-29  1040  		*_first = last;
2dc27084e13c291 David Howells 2021-06-29  1041  		ret = 0;
2dc27084e13c291 David Howells 2021-06-29  1042  		goto unlock;
2dc27084e13c291 David Howells 2021-06-29  1043  	}
2dc27084e13c291 David Howells 2021-06-29  1044  
2dc27084e13c291 David Howells 2021-06-29  1045  	/* Try to grab the first folio of the requested range within that
2dc27084e13c291 David Howells 2021-06-29  1046  	 * region.
2dc27084e13c291 David Howells 2021-06-29  1047  	 */
2dc27084e13c291 David Howells 2021-06-29  1048  	if (*_first < region->first)
2dc27084e13c291 David Howells 2021-06-29  1049  		*_first = region->first;
ce4670495468b79 David Howells 2022-02-07  1050  
2dc27084e13c291 David Howells 2021-06-29  1051  	ret = netfs_find_writeback_start(wreq, wbc, region, _first, last);
2dc27084e13c291 David Howells 2021-06-29  1052  	if (ret <= 0)
ce4670495468b79 David Howells 2022-02-07  1053  		goto put_region;
2dc27084e13c291 David Howells 2021-06-29  1054  
2dc27084e13c291 David Howells 2021-06-29  1055  	netfs_extend_writeback(wreq, wbc, ctx, region);
ce4670495468b79 David Howells 2022-02-07  1056  	if (advance)
2dc27084e13c291 David Howells 2021-06-29  1057  		*_first = wreq->last + 1;
2dc27084e13c291 David Howells 2021-06-29  1058  
2dc27084e13c291 David Howells 2021-06-29  1059  	netfs_split_out_regions(wreq, ctx, region);
2dc27084e13c291 David Howells 2021-06-29  1060  
2dc27084e13c291 David Howells 2021-06-29  1061  	/* The assembled write request gets placed on the list to prevent
2dc27084e13c291 David Howells 2021-06-29  1062  	 * conflicting write requests happening simultaneously.
2dc27084e13c291 David Howells 2021-06-29  1063  	 */
2dc27084e13c291 David Howells 2021-06-29  1064  	netfs_add_wback_to_list(ctx, wreq);
2dc27084e13c291 David Howells 2021-06-29  1065  	ret = 1;
2dc27084e13c291 David Howells 2021-06-29  1066  
ce4670495468b79 David Howells 2022-02-07  1067  put_region:
ce4670495468b79 David Howells 2022-02-07  1068  	netfs_put_dirty_region(ctx, region, netfs_region_trace_put_wback);
2dc27084e13c291 David Howells 2021-06-29  1069  unlock:
2dc27084e13c291 David Howells 2021-06-29  1070  	mutex_unlock(&ctx->wb_mutex);
2dc27084e13c291 David Howells 2021-06-29  1071  	_leave(" = %d [%lx]", ret, *_first);
2dc27084e13c291 David Howells 2021-06-29 @1072  	return ret;
2dc27084e13c291 David Howells 2021-06-29  1073  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

