Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB6153E67C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236868AbiFFMZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 08:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236822AbiFFMZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 08:25:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510BC2A1D5C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 05:25:14 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256BIbA9011625;
        Mon, 6 Jun 2022 12:25:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=VOxxJgQQX1zhCENBQsYXA7qWlKov2OhLZ07kD/vyGnQ=;
 b=djP9+djAPsK6IZkq5cad9kdVW8qiL58nzdIFZs1fZV4/47ZA5cnBD7OpuUVTHcMUPJXw
 2SzqKebVlJq938BY0gLpGf3K7O23koRiCAdg3jaINVs6FtP7j7mC2VQsWRgPV82lvfv6
 0ZD1piqJgBiQhXa6upiIwYeYSlmadJHByJLfZ37QuYsc393dlrhuMuriLIdwbyzqksxx
 aNKVB5wZEBMIOclc+EAOKN4Vsj5W9raSBHjYItaptO56TxCTKfOjleMKH/sGzcYSIjwF
 BoRk/1Xss/XE7cEugGqXstq2ibX8lybTzPTse1o+IRx6TK7v69UNMQ9e4I65HiIeOBX/ 0g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gfydqjxm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 12:25:10 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 256CGORK001526;
        Mon, 6 Jun 2022 12:25:09 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwu1ksbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 12:25:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7rHnZUqDNz7Fe/Z1amVvu5oTrLfPNrt6GNp+hIRtJOiQsyZUU5HT+Wn7RxuMu2VN0rl0VEN100apzjaCfiSEctCiXtJaExXJ+9qcZ5yAx761X0tD99qn81NG1O0jrHfYO3JDGlYrz+VGvH7QdM74tKctvrugBJlscYc+AgBNDZ9+cyIxCRaCZcyTog6jFzvY1hpqQhkX0ayfxXaPc+Eh0h9R5vTWSzvYgAwfm+ByPLOU1YIWt0jkaUH6eNVKRpdgJNyO9rsTd3N1S1m9yUy+rNepluUtT11nWj9ofykrvSiYpcKgueD3xbrHoY1PgoMowCfyALiugV6Iku/SGwl2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOxxJgQQX1zhCENBQsYXA7qWlKov2OhLZ07kD/vyGnQ=;
 b=PrDzqqOTnqeskBrzNKLwJdFdAv1ehTzxw3w6tDK1TQZwbU4kqu1eLcb/j+fDRYn4pZeJVozv9xvjTGA0u8QCm/u7gY6LxxYBMeV6Iu3AbEfMn1DQTdvzai4SyAFa+fsIsxGAwQJwr1gaRkuynbJ0IiTO8cRYqYScU9siSLm8vEDtRa8Hl/yInqhzAn8R84f0IRTmOtExshNnvILynLie78lDUoRaRH+2A5uKiG2yujANiHTkJVL1KzxdjMioUhwb1eWHC6jslD1caikmzDQZeU1QeG+E+S8ix47AOVrvf/gftJpAWZpq39ucS0xZ6VDgZ7FeZpN5mIzuCK9txRvUCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOxxJgQQX1zhCENBQsYXA7qWlKov2OhLZ07kD/vyGnQ=;
 b=fpSCqvPSmDJmfp3/DXe29WJ24sSAvRjnkiWcdkk6sBcD88Upy3/Tt56KgiOy1IEWFETYOjzI6assMA+rno4prdN2ULiljVpxq1Djx2WN8omYymweq3oMGhQJKYM2kZIq8nABRfnqMMm4ASxFTmzPdzlvm1fkfswmH/5yJGQbpPM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BY5PR10MB4017.namprd10.prod.outlook.com
 (2603:10b6:a03:1ff::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.16; Mon, 6 Jun
 2022 12:25:07 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 12:25:07 +0000
Date:   Mon, 6 Jun 2022 15:24:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, David Howells <dhowells@redhat.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-linked-list 58/59]
 fs/netfs/buffered_flush.c:664 netfs_find_writeback_start() error:
 uninitialized symbol 'ret'.
Message-ID: <202206031529.CM5I3dvU-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0057.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:31::21) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5a3a033-13d5-4ed3-f3d7-08da47b797b2
X-MS-TrafficTypeDiagnostic: BY5PR10MB4017:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB401774F2E961D9AEF67BC56C8EA29@BY5PR10MB4017.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rUPYl5vVp3YbMWbECnU8WHhF5omFSYi3rJyqXDg8K3SlCNcfTiMNfkKZzw+YcCReg/+95/3i+uGcpzn9xAR1z1bk0Wk2gcJuGVV1JMo3Fb/l3D0jQxmvs8iH105cAw7POfxFPlaC1M0CrVf/wDIHW+FNqs8nmlor0L821p8FFKcqb6vJZfZM0t+36cu699egi8CHJhH1KYu8ywC4D7W3KJNvCUcMYjH7JRDef7xjyBMPxnqYZaZj9jH6N84Ue852/yxuBvDfQcJ1Fsb8tO2xPk0N6qq9vug6ScWUpgsactJO8FNm3AgKfbaUklEB46UTd7Wyo7ZxeAg0h0aVA9kw9D6s/YU4ly/6OV6oA40GcqhFmTadgLCHN6gkQg8FB+3TcIguLLel0l/p/TohDRjBhGtVx/Z4EqZzOuIDqDtZA63Hguq9R89hQOz11THgNccSlGJQfybsXnNPAQVK+Shf+yaojA60e9f5A0Nruq7sVyxQ7ngKYkTNEe+9JGwyAQY2KyPbnAvQSOsz++7s0vASGM7dpJOUvee1LZ5DESrj0wnvifwvrtD47wR0EcR4tNUIEqc33AXpHHKsUBqZI0dRa0Ss7KoK8bY4G+AO+T5FjUXOpsFPPWb/EB96C5qTULKyHKUlPOxqaxXe55ZiIsA6v4ctfYlgq5pokzQkGvOCJ5uF0Vkt+fZ/w8NxWZk3DzbAE4JmnFrrPZ9ye19DERcTsL67LnlqeLmx/xovxPxcHXFJ2HoiQsDS0sFpAveoieS1Kjdod5ue+NHdD4bHs3YEyKv1ezefmC00UJ8y5nMOm9PNScYxccNSJHuYiUEDAEj5B6ZrEge6IrQ4syZo3qyCVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(4326008)(6506007)(6512007)(2906002)(9686003)(26005)(38350700002)(52116002)(6916009)(966005)(86362001)(6486002)(316002)(508600001)(38100700002)(36756003)(44832011)(66946007)(66476007)(66556008)(186003)(8936002)(83380400001)(8676002)(1076003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aXHaTicM9G7zpHE/weaPHF9m8GOa2vK5jZo7qZAzL0pyvQ/maNJxOEXmyeAZ?=
 =?us-ascii?Q?w0tOpVqiO/rYcfjf9F8Atk1Z/5Sgw/BgGN64lL4Tdhj0nuPsa0HskQxygmEY?=
 =?us-ascii?Q?XtPqx0otH20ZpcFpr964nH1I1YsYm4cdl2BkQn6kF/zDNACjbRaRR4tuhf46?=
 =?us-ascii?Q?8wORSheyY/wTQeNH7HQa80l8B5BZSCJU5RizzHihT+987V7apRNAw5QYtqh3?=
 =?us-ascii?Q?ZsODiTJ1S6gtp1ihmLrjzo7c1i6EDzkYiqhLg8plkbpMB1m+GQQOySp646X2?=
 =?us-ascii?Q?+Otir/nGEaO8sIoZORbYeVCzNxtZDaszRrkh16Y/quGhm09Mi+JqITd3NlVq?=
 =?us-ascii?Q?ucfiRNJNIV8fjORQUAD4BATPoVqy3takirZZ61fd4WfyTA7ofHrbKueGSr24?=
 =?us-ascii?Q?zLdwdIHMIYl9ABAmID3CRM/vNVxethM1jgAo8ekp+Y95+NnXRoFbxDhzyN5R?=
 =?us-ascii?Q?0xOKnYOUuFs3DQYxO9K3eNYrRyXgq3jyR0Xks2vFiaRYvlLBUKXde488XXi7?=
 =?us-ascii?Q?6N66KJS7KHyuFJtbSa8gPT81DLu4Kq3gTTIZpOADWAKY28953oLnkePv0UAd?=
 =?us-ascii?Q?YTJnmtxAZ5aU9LeA0s9bayrSoU5at9gtRdRB/cHAINGOwIvpCztcEYEM/769?=
 =?us-ascii?Q?Cd1JGbEUVTejkYJowZCagSIjj2ZX7IRaHDOKt01sOcyiDYdDTwJ5YTECqcBy?=
 =?us-ascii?Q?x4ZQ0JGvv90gqpCGWYjGVVt3jSNFBt5CAkI0MMU8fbcswGfL7BodtyWXiVZ1?=
 =?us-ascii?Q?8TVzktPCIIVpJKpIxWOx8Nba1Tlf+DmLa67KViAy4H+5eHN9jYMznipN7ZJG?=
 =?us-ascii?Q?2XOJ6l0oCg3k+TVVWjuw9rDPgTvv5qLPmlIvf584nyi2SbZhZOioIAIDSGy1?=
 =?us-ascii?Q?sebtFsLZczq/bQXEex0QzBmTp74Jf+/cv9HM/bALLuq2//+ec5AbDsHDzWDQ?=
 =?us-ascii?Q?sgRJLDwM/MnrzYeTLkPQMbG+kVVTFG1VWPZPGGzzW6RpkhPs4AuZ4KVTmyfH?=
 =?us-ascii?Q?z4NUG1JsKTaskHSe6yHnL2PoAZkuMQUbbs0rSERrGLoi3I8bavUBDELtSsf8?=
 =?us-ascii?Q?LpDhJKhDcLc1UujavAffgsfj1VaIY7rJWyd/V5WX6duDkdbD0lQZbgMxRXsb?=
 =?us-ascii?Q?PjiU9/UxfPaQdOofTnyMhq66xbOLveQTyynd74UFrotkmXYbxbC/aWBhfE75?=
 =?us-ascii?Q?Z8m5xLOAt998Gg+L4mdq6xkl/MMJJpbsylGC3lRiLUA2wCRqRIyt+BBOvm5e?=
 =?us-ascii?Q?fF+GutnOWTgdIdun8KQ5CxuuvJYzUBeV9xUW5BXHTW9MgkCD6kNWKmv/1aBn?=
 =?us-ascii?Q?e9P2DpNusWRjWbiZx3Z6CgYTYXkS4Qc2GUC+vT1Cv6vu3Hho0+rOV34Pi1AF?=
 =?us-ascii?Q?faWSwNJZK9kyBPriBwkNn7RP4MQ423cK5EIbghb2loSXPEybzeeW2HKxE3VN?=
 =?us-ascii?Q?FAefIydSZw2f2zEtjBTXbpPu/CD0L8+sYo6+2rZDBMLFNoJ+GISjBZsojdSJ?=
 =?us-ascii?Q?7A/GgbgYIsJj2T3duQWwjBh4Tvmk6AUWWC3LjVftKlNBpnhktiHDD0M34oAl?=
 =?us-ascii?Q?sUELUN4Q5OODJfhJjK96dvtfcAb+rrr0O+e2/8qjWDrBsFu8berfvTtwxYZ9?=
 =?us-ascii?Q?BOeFTf93bfjIoS1yLmyzrTFAr8qJtUgu+imtTkPq88o5QpKzvCvkB8Ym5D/e?=
 =?us-ascii?Q?ingrn3EfPUwKbINxjBnXURO1CRWCQlqjtSSsf3JYd4XiRNntkR+38LPHXAv9?=
 =?us-ascii?Q?dlGZcO1fCgsjdAmBKmo5QPQwSLuHHR8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a3a033-13d5-4ed3-f3d7-08da47b797b2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 12:25:07.7427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 953OkJLYZNwumQm6RufdIJYlb1nR5MBK6ZBJHs4xBfYcOjbq+VVsfpHqQUE04eAfvyinH3r/1uNsylAHrCjbLN0FAGrvW+2eUHvj2OH8ScM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4017
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-06_04:2022-06-02,2022-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206060057
X-Proofpoint-GUID: Kb9wck89014WiwHcPGrJvFzeNJTSaPtf
X-Proofpoint-ORIG-GUID: Kb9wck89014WiwHcPGrJvFzeNJTSaPtf
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
head:   22ecc2fcdab4616e624408911ec1d54644e82030
commit: ff509dc49891f934a7a774e277b87729018db753 [58/59] netfs: Use flush from afs_writeback
config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220603/202206031529.CM5I3dvU-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
fs/netfs/buffered_flush.c:664 netfs_find_writeback_start() error: uninitialized symbol 'ret'.

vim +/ret +664 fs/netfs/buffered_flush.c

ff509dc49891f93 David Howells 2022-04-28  553  static int netfs_find_writeback_start(struct netfs_io_request *wreq,
ff509dc49891f93 David Howells 2022-04-28  554  				      struct writeback_control *wbc,
ff509dc49891f93 David Howells 2022-04-28  555  				      struct netfs_dirty_region *region,
ff509dc49891f93 David Howells 2022-04-28  556  				      pgoff_t *_first, pgoff_t last)
ff509dc49891f93 David Howells 2022-04-28  557  {
ff509dc49891f93 David Howells 2022-04-28  558  	struct folio *folio;
ff509dc49891f93 David Howells 2022-04-28  559  	ssize_t ret;
ff509dc49891f93 David Howells 2022-04-28  560  	bool dirty;
ff509dc49891f93 David Howells 2022-04-28  561  	int skips = 0;
c403641768e0a37 David Howells 2021-06-29  562  
ff509dc49891f93 David Howells 2022-04-28  563  	_enter("%lx,%lx,", *_first, last);
c403641768e0a37 David Howells 2021-06-29  564  
ff509dc49891f93 David Howells 2022-04-28  565  retry:
ff509dc49891f93 David Howells 2022-04-28  566  	folio = __filemap_get_folio(wreq->mapping, *_first, 0, 0);
ff509dc49891f93 David Howells 2022-04-28  567  	if (!folio) {
ff509dc49891f93 David Howells 2022-04-28  568  		pr_warn("Folio %lx in dirty region D=%x not present\n",
ff509dc49891f93 David Howells 2022-04-28  569  			*_first, region->debug_id);
ff509dc49891f93 David Howells 2022-04-28  570  		return 0;
c403641768e0a37 David Howells 2021-06-29  571  	}
c403641768e0a37 David Howells 2021-06-29  572  
ff509dc49891f93 David Howells 2022-04-28  573  	/* At this point we hold neither the i_pages lock nor the folio lock:
ff509dc49891f93 David Howells 2022-04-28  574  	 * the folio may be truncated or invalidated (changing folio->mapping to
ff509dc49891f93 David Howells 2022-04-28  575  	 * NULL), or even swizzled back from swapper_space to tmpfs file
ff509dc49891f93 David Howells 2022-04-28  576  	 * mapping
ff509dc49891f93 David Howells 2022-04-28  577  	 */
ff509dc49891f93 David Howells 2022-04-28  578  	if (wbc->sync_mode != WB_SYNC_NONE) {
ff509dc49891f93 David Howells 2022-04-28  579  		ret = folio_lock_killable(folio);
ff509dc49891f93 David Howells 2022-04-28  580  		if (ret < 0) {
ff509dc49891f93 David Howells 2022-04-28  581  			folio_put(folio);
ff509dc49891f93 David Howells 2022-04-28  582  			_leave(" = %zd [lock]", ret);
ff509dc49891f93 David Howells 2022-04-28  583  			return ret;
ff509dc49891f93 David Howells 2022-04-28  584  		}
ff509dc49891f93 David Howells 2022-04-28  585  	} else {
ff509dc49891f93 David Howells 2022-04-28  586  		if (!folio_trylock(folio)) {
ff509dc49891f93 David Howells 2022-04-28  587  			folio_put(folio);
ff509dc49891f93 David Howells 2022-04-28  588  			_leave(" = 0 [trylock]");
ff509dc49891f93 David Howells 2022-04-28  589  			return 0;
ff509dc49891f93 David Howells 2022-04-28  590  		}
ff509dc49891f93 David Howells 2022-04-28  591  	}
c403641768e0a37 David Howells 2021-06-29  592  
ff509dc49891f93 David Howells 2022-04-28  593  	/* A dirty region must fit exactly over a span of folios - there should
ff509dc49891f93 David Howells 2022-04-28  594  	 * be no partial folio coverage.
ff509dc49891f93 David Howells 2022-04-28  595  	 */
ff509dc49891f93 David Howells 2022-04-28  596  	if (*_first < folio->index) {
ff509dc49891f93 David Howells 2022-04-28  597  		pr_warn("Folio %lx extends before dirty region D=%x\n",
ff509dc49891f93 David Howells 2022-04-28  598  			*_first, region->debug_id);
ff509dc49891f93 David Howells 2022-04-28  599  		goto skip;
c403641768e0a37 David Howells 2021-06-29  600  	}
c403641768e0a37 David Howells 2021-06-29  601  
ff509dc49891f93 David Howells 2022-04-28  602  	if (folio_mapping(folio) != wreq->mapping) {
ff509dc49891f93 David Howells 2022-04-28  603  		pr_warn("Folio %lx in dirty region D=%x has no mapping set\n",
ff509dc49891f93 David Howells 2022-04-28  604  			*_first, region->debug_id);
ff509dc49891f93 David Howells 2022-04-28  605  		goto skip;
ff509dc49891f93 David Howells 2022-04-28  606  	}
c403641768e0a37 David Howells 2021-06-29  607  
ff509dc49891f93 David Howells 2022-04-28  608  	/* Any folio we have to include must not already have writeback in
ff509dc49891f93 David Howells 2022-04-28  609  	 * progress otherwise we may get a race against old data being written.
c403641768e0a37 David Howells 2021-06-29  610  	 */
ff509dc49891f93 David Howells 2022-04-28  611  	if (folio_test_writeback(folio)) {
ff509dc49891f93 David Howells 2022-04-28  612  		folio_unlock(folio);
ff509dc49891f93 David Howells 2022-04-28  613  		if (wbc->sync_mode != WB_SYNC_NONE)
ff509dc49891f93 David Howells 2022-04-28  614  			folio_wait_writeback(folio);
ff509dc49891f93 David Howells 2022-04-28  615  		else
ff509dc49891f93 David Howells 2022-04-28  616  			*_first = folio_next_index(folio);
ff509dc49891f93 David Howells 2022-04-28  617  		folio_put(folio);
ff509dc49891f93 David Howells 2022-04-28  618  		if (wbc->sync_mode == WB_SYNC_NONE) {
ff509dc49891f93 David Howells 2022-04-28  619  			if (skips >= 5 || need_resched())
ff509dc49891f93 David Howells 2022-04-28  620  				return 0;
ff509dc49891f93 David Howells 2022-04-28  621  			skips++;
ff509dc49891f93 David Howells 2022-04-28  622  		}
ff509dc49891f93 David Howells 2022-04-28  623  		goto retry;
ff509dc49891f93 David Howells 2022-04-28  624  	}
ff509dc49891f93 David Howells 2022-04-28  625  
ff509dc49891f93 David Howells 2022-04-28  626  	/* A dirty region may include a number of folios that are clean in order
ff509dc49891f93 David Howells 2022-04-28  627  	 * to make up a minimum-sized unit for writing, e.g. if we need to
ff509dc49891f93 David Howells 2022-04-28  628  	 * compress a large block or write a bigger unit to the cache, so we
ff509dc49891f93 David Howells 2022-04-28  629  	 * need to keep track of that in case the write op fails.
ff509dc49891f93 David Howells 2022-04-28  630  	 */
ff509dc49891f93 David Howells 2022-04-28  631  	dirty = folio_clear_dirty_for_io(folio);
ff509dc49891f93 David Howells 2022-04-28  632  	trace_netfs_folio_dirty(wreq->mapping, folio, netfs_folio_trace_store);
ff509dc49891f93 David Howells 2022-04-28  633  	trace_netfs_wb_page(wreq, folio);
ff509dc49891f93 David Howells 2022-04-28  634  	if (folio_start_writeback(folio)) {
ff509dc49891f93 David Howells 2022-04-28  635  		kdebug ("start wb failed");
ff509dc49891f93 David Howells 2022-04-28  636  		goto out_unlock;

"ret" uninitialized on this path.

ff509dc49891f93 David Howells 2022-04-28  637  	}
ff509dc49891f93 David Howells 2022-04-28  638  
ff509dc49891f93 David Howells 2022-04-28  639  	ret = netfs_xa_store_and_mark(&wreq->buffer, folio->index, folio,
ff509dc49891f93 David Howells 2022-04-28  640  				      true, true, dirty, GFP_NOFS);
ff509dc49891f93 David Howells 2022-04-28  641  	if (ret < 0) {
ff509dc49891f93 David Howells 2022-04-28  642  		kdebug("oom store");
ff509dc49891f93 David Howells 2022-04-28  643  		goto nomem;
ff509dc49891f93 David Howells 2022-04-28  644  	}
ff509dc49891f93 David Howells 2022-04-28  645  
ff509dc49891f93 David Howells 2022-04-28  646  	wreq->first = folio->index;
ff509dc49891f93 David Howells 2022-04-28  647  	wreq->last  = folio_next_index(folio) - 1;
ff509dc49891f93 David Howells 2022-04-28  648  	wreq->len   = folio_size(folio);
ff509dc49891f93 David Howells 2022-04-28  649  	wreq->start = folio_pos(folio);
ff509dc49891f93 David Howells 2022-04-28  650  	if (wreq->start >= wreq->i_size) {
ff509dc49891f93 David Howells 2022-04-28  651  		pr_err("wreq->start >= wreq->i_size\n");
ff509dc49891f93 David Howells 2022-04-28  652  		wreq->len = 0;
ff509dc49891f93 David Howells 2022-04-28  653  		ret = -EIO;
ff509dc49891f93 David Howells 2022-04-28  654  		goto out_unlock;
ff509dc49891f93 David Howells 2022-04-28  655  	}
ff509dc49891f93 David Howells 2022-04-28  656  	_debug("START %zx @%llx [%llx]", wreq->len, wreq->start, wreq->i_size);
ff509dc49891f93 David Howells 2022-04-28  657  	if (wreq->len > wreq->i_size - wreq->start)
ff509dc49891f93 David Howells 2022-04-28  658  		wreq->len = wreq->i_size - wreq->start;
ff509dc49891f93 David Howells 2022-04-28  659  	*_first = wreq->last + 1;
ff509dc49891f93 David Howells 2022-04-28  660  	ret = 1;
ff509dc49891f93 David Howells 2022-04-28  661  out_unlock:
ff509dc49891f93 David Howells 2022-04-28  662  	folio_unlock(folio);
ff509dc49891f93 David Howells 2022-04-28  663  	_leave(" = %zd [%lx]", ret, *_first);
ff509dc49891f93 David Howells 2022-04-28 @664  	return ret;
ff509dc49891f93 David Howells 2022-04-28  665  
ff509dc49891f93 David Howells 2022-04-28  666  nomem:
ff509dc49891f93 David Howells 2022-04-28  667  	if (dirty)
ff509dc49891f93 David Howells 2022-04-28  668  		folio_redirty_for_writepage(wbc, folio);
ff509dc49891f93 David Howells 2022-04-28  669  	folio_end_writeback(folio);
ff509dc49891f93 David Howells 2022-04-28  670  	goto out_unlock;
ff509dc49891f93 David Howells 2022-04-28  671  
ff509dc49891f93 David Howells 2022-04-28  672  skip:
ff509dc49891f93 David Howells 2022-04-28  673  	BUG();
ff509dc49891f93 David Howells 2022-04-28  674  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

