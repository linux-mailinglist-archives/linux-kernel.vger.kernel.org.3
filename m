Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FBD553D80
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 23:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356028AbiFUVWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 17:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355761AbiFUVVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 17:21:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C019E3617E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 14:08:14 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJHFRL012606;
        Tue, 21 Jun 2022 21:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=3Z9uWa/qmgWsJ3DetqRRB7LTWSxHt7cKrPTuQXBZRxQ=;
 b=uKVe3ja72lswwLRAAjVMygciSqRmdcKasUN66wz8YdaUAxmeaevPVqUCqjrKT5DJVpUf
 n/JxPWEJYEOAX05v4tSuXkd0SUY+wWZ0bL83ozBMs9gKYBKgCXDFb5rYHgRDDA1pYfKF
 Jqf+2XfKlyjqq43GpOd+/g/3Be8hTVu23mALanAVXvCRhT+xKcMMXKDLJ3GfH0gsDKX7
 8ScCJxFtVZqtaMPMuVfIGTwJkq+xvGAONTZ/9+wai8vmvR3CC9GkjIXnDbBzKwFe/R+v
 Pf9l/OG01heAdHaHCqmRRm35pbueB5DHMUTHw75nmgoNNt9jwfPfZY1L+jiU7BqAMZeZ pw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6kf6mx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 21:07:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LL0Xft039328;
        Tue, 21 Jun 2022 21:07:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtd9ukfx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 21:07:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRrG5diKmjO9LhUlixK19nlZgm9rmGOaAqjVpQTilVj+rSz30+6pKYvonckPCt3KiXIZfrng0vls72W1R8V/ZDa9JSomVOj/xh2g2FPpUnGHFZ0GBRqH/KLMkC047EV9ewuK+Ty949IbWjlz0FK9Nzc6JjV9c6MFT04p09lvu32T5OYzgoLluq0E7Kwmo9H2KYIFXcUwXGjLz4WpCRd8VxjTqA646RwlAiqS1fO7o97g1z8VeG1PlK9MucvFO08g8mCnRyPXK2E0W35WH6nw0jBqD5D80fQN3UERtspdTuX2L1soBDp9B/GVjqeF2oviHZPnK7V4ek+kes+FMNfL9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Z9uWa/qmgWsJ3DetqRRB7LTWSxHt7cKrPTuQXBZRxQ=;
 b=NkCZSqcXdnFcKZAWeAZawMgu0HgdlNpwFZ8M3NLOEneyme5xVqSN8Qx2NC4XF6NMEFXEAnxTvqctY1kmdHkEeEGxeNf2cTbB+b+D7hNv4R+c1uzoQIUh9gxkE+62r4FrHpZhiW1o18b/nH0dl/c1ToA6x1jo/sgW/anUHEazXVTZKHfBatzYsOcKk+9bdS8L8uCWH20VYOz3sIMGodTO7y2aImsGA/y13gavNVxKcGK9MpVug9QzhaO9KXarf5OgdNAUR5C8aKx3DYHHkEEJh3/drTmsuMSTu8pEtXU/V/o4XjJa9CN/P0TxxZofW/Zn1fQjhr+g1YOaw1LM94pFQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Z9uWa/qmgWsJ3DetqRRB7LTWSxHt7cKrPTuQXBZRxQ=;
 b=Qi4nHgaehHDV1dzd4ks/PgDIw2T//rBPkfyoUb7adySbYusPPPABu55EIIWH49c6pH1f23z5wqxsiH+EnbUhgS7BfkIBRqbXW+V9HGwlJVLESDGGKAySTPk//SLspQVZHeUnZHGwh61NRBQ8zir2ovE4bhl2KzsvT3mpaHUbat4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BL0PR10MB2993.namprd10.prod.outlook.com (2603:10b6:208:7d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Tue, 21 Jun
 2022 21:07:32 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%8]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 21:07:32 +0000
Date:   Tue, 21 Jun 2022 14:07:29 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        willy@infradead.org, zokeefe@google.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [mm-unstable v5 PATCH 0/7] Cleanup transhuge_xxx helpers
Message-ID: <YrIzEZxuwQAi7VR1@monkey>
References: <20220616174840.1202070-1-shy828301@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616174840.1202070-1-shy828301@gmail.com>
X-ClientProxiedBy: MWHPR07CA0006.namprd07.prod.outlook.com
 (2603:10b6:300:116::16) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 438416cc-811d-40e8-b596-08da53ca0ebd
X-MS-TrafficTypeDiagnostic: BL0PR10MB2993:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB2993A57682FA9FE8CB6C85C4E2B39@BL0PR10MB2993.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9PJav0Kr0W5X/vYfJL59s0z5ZVSUs2AN2eev+Ct1O2LoN71WI+lNnul2T9Pc5NMInItLpKZq8wWezNwFgyByPjkWpIlqhEMEBOOzTco08pKRPzZNGmBTTR0eOJy7fNpjlP+HRL6QHITtXumZWqVnNSyFy/fYmcEHZ/dsiBv70eawL5dknQ9cZ9pR+iXOiAZscMb0hqNy1Ry4bjSBXqEs5fH+1wYVYdqVpz5nviTC2vmkZwK6+1HtpdbyI2J6gifusb3210jSPt5nHqmnBxZrRXSp9J2BD5XBZUGZpD1R2prgn33SMgONhfzYZV6F2qHDS8Z/ikoknffsMw5QrZFVY+f85upOz12ZTRcnPBFDKeSK0b+H/BYukeKAUoOGRWYxseE2lYbBdGZb2Y9u4nF54fBSUbXNHVMNhlCBbmBsp86zCJJZX0PQhNBxYSz/ulUOszwLQS/gakOg3uYLqt0te3Hc0M3qmhXjnNNji+d+gWYbS+mAkHC5KJGp5cI8lpf6XGxc2xoyDKqX68H4IsY4qhPI9GIOvwHdFweWEiuFqRG3VaN6UQZF3GjoIkK8j96OpSdRaHllIZF5x92Ce7jQI7WmMrwMjyNV4DK5jsjaC/m+ugxgcSm2WP19aZO/Lrlh+QunfrwKBBfW/EBu5KQtta6pQrZTJctnTFXetQUhYYS+61VbyPmknQtdUO1jdtopmE4mvxnZQ0ci7hnx41w5LAEgy2FrsIZ1zvgPe938vbrCdWgV4EOOmZLk6TKVCowHW22QUe3rpRT8PG1J6NRpmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(396003)(136003)(346002)(366004)(376002)(6506007)(2906002)(966005)(9686003)(41300700001)(53546011)(478600001)(6666004)(45080400002)(186003)(26005)(6512007)(44832011)(6486002)(8936002)(38100700002)(66946007)(316002)(5660300002)(8676002)(66476007)(66556008)(4326008)(86362001)(83380400001)(6916009)(33716001)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VGowboRvKdlYcBLWsDA0n77JvXQBmrRUQrcdffpY5p+SgPg3HXwxpaaCtMVt?=
 =?us-ascii?Q?nSABde5A6OghwZi7t8aeHQQURYaEM1Att21hXREDw1hfgSowkJ+DfpcnBuTr?=
 =?us-ascii?Q?1/zoiewJWLDqyN44mWdzwUHgEh1ZWjnlhaE9e4uX9yD/Fw3AyzUDzqW6rHeU?=
 =?us-ascii?Q?GQLK9Hnl98s/b6kaMYJwpRizcdpRNJaXfIBi3l8ize1cFvdyqIPDLoLR6BG0?=
 =?us-ascii?Q?uTAJ3k2QZt1RRe1W+dcs5BD8cqsVZnLHOwHrwsIAy61Y0TVj9PE6qvX4ESz6?=
 =?us-ascii?Q?K1vOWyjLP5TGeDxudeLtlt8yQlLyHHjMBkUBDfB5KFgJsE06jws7WT/fPAcH?=
 =?us-ascii?Q?CISFn16nKDUqBcWapmIEMVUVEFsV8cEQtSnW9VMEXx7V2M2OrcPO09Htj+i+?=
 =?us-ascii?Q?JIB0QXDmj6UEDNJhrp1uZSKvdAUMxknRgwQ8NbZRip8vkEbvQWdC7EToWURz?=
 =?us-ascii?Q?daC7ir9ClnppP+ApamMFYUWflO+tuzaVVsS7M19gqbAz9LUQxr4n5KW2Uofi?=
 =?us-ascii?Q?75djC7YNOnWhbiRJWF2GqJqvdv3fL4fjyWqVkS0if+SH3yE8Gc1NjXhiwfVr?=
 =?us-ascii?Q?nelefK1lSepzNcvn0YdsLPvjYEZgJ1aIaulJVJpExtpl4/qIaGq8Uva1rYGy?=
 =?us-ascii?Q?6R2Wsi2Mnzw0HAQqfjFXfuv+oAMlGPgJK/QztGT6JHNjuDXPq5i/pliIiGKB?=
 =?us-ascii?Q?6eEWSPibHSikLLrSqR9laoBJUYHBbpPsB5YHYyxIUPBewect3w6QyKejQ9D6?=
 =?us-ascii?Q?FvpUayobBNooUGfBCqON8h6FtKqD40IKCyHSc85Tc0da1CLYcuEM1WEg0JY8?=
 =?us-ascii?Q?u52I9IrG/pY580vejXo5trJurGShoHY8q0Yv4m3cH8MUHH/RXI3+3X3FRjBx?=
 =?us-ascii?Q?2G5yK2tNPsHmqg750pQ/phiipgj9RKTzY87yt4UHQHgQ2YW59pEztUnx16uN?=
 =?us-ascii?Q?r6RwyyM+Boo+f2sOemchQLIfjTDAU+UhH5qbXFJVXAXqCB2E8elx1k30duxo?=
 =?us-ascii?Q?nrQ9kw4dM+fu+FlaWkHBv8y7jXtKy+ux12kkQDUb9cExBYMWzpQqbMyb0HPM?=
 =?us-ascii?Q?/HK5wDfw7IjabA0U+f94//VoUJmp8T0wIFrM+gbkK+GH7OagsahZ/1U62Fqf?=
 =?us-ascii?Q?f91r4ShNTKM3AqNNQbUB/Wc38BlrQsVLvZm/si3XWiKW8RXYBgk+l+1E8U8z?=
 =?us-ascii?Q?x98gJnug8cgGXNZcTNMIAlZ30H7YS1Kjbh0BEFIVTh3Yfa64EtReBGhJq3tB?=
 =?us-ascii?Q?iThZmiYuA5Ve5a2HmK7SqWNQVRIEN0ximnU/Z3QwqPviSXxzuSgj3JdH6zfQ?=
 =?us-ascii?Q?kcunuhU7OtYqOnO2xYpm8474uc+EPQyr/i03a8z/3Vx0EyQZu8FF34bUrKXI?=
 =?us-ascii?Q?hrnIq49ZivFI0unRdJ2awXncG/6O78B/78E2LykERACHhtIhyrLZnp/qflnU?=
 =?us-ascii?Q?uEqkPLadxd7S4opy1h6UET2b8LSfAihJGdpmoo9m1UpCAUMr6ECqNjceNFCu?=
 =?us-ascii?Q?9DQaNXjO8lns7yq3M5a5O7BL++z7UZMQe7FzJkkPQ2plJA9IlHu4Mp0c4ry5?=
 =?us-ascii?Q?el7XfjZMAoyLZJg13cOoGp4J0FXVQQMqqfRTfS+Hr2fwJQ+ADEPEdKOdNAES?=
 =?us-ascii?Q?9qPNNVH6IdhVt0J9aqID+jiF43jSZS/RqBxfuc6s3mYhBbjeAX9AeSGbq7GW?=
 =?us-ascii?Q?lc7NCqA1LBKA7GBe2m9FSurJKf6dXIc9a5ugbV3W4PpIzk1eTyYujAJXfH0q?=
 =?us-ascii?Q?G8RqUxnzdNVlwJREUvxKLNJsvTuqjcM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 438416cc-811d-40e8-b596-08da53ca0ebd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 21:07:32.4346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eLCC7Ib5T1ES8tjU1VxYCNdamnNt6NCaGaMUs0qCtCTSFOVPrIe4n3wsYCPfNYlLqUOPFoDQgJdSPEzvsd5tlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2993
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=735 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210089
X-Proofpoint-ORIG-GUID: PovzVBhBlTM2e_31mgOFCD-0y57NUPpC
X-Proofpoint-GUID: PovzVBhBlTM2e_31mgOFCD-0y57NUPpC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/16/22 10:48, Yang Shi wrote:
> This series is the follow-up of the discussion about cleaning up transhuge_xxx
> helpers at https://lore.kernel.org/linux-mm/627a71f8-e879-69a5-ceb3-fc8d29d2f7f1@suse.cz/.
> 
> THP has a bunch of helpers that do VMA sanity check for different paths, they
> do the similar checks for the most callsites and have a lot duplicate codes.
> And it is confusing what helpers should be used at what conditions.
> 
> This series reorganized and cleaned up the code so that we could consolidate
> all the checks into hugepage_vma_check().
> 
> The transhuge_vma_enabled(), transparent_hugepage_active() and
> __transparent_hugepage_enabled() are killed by this series.

Running libhugetlbfs tests on next-20220621 produces the following:

[   77.436038] BUG: kernel NULL pointer dereference, address: 0000000000000378
[   77.437278] #PF: supervisor read access in kernel mode
[   77.438211] #PF: error_code(0x0000) - not-present page
[   77.439097] PGD 800000017a1a6067 P4D 800000017a1a6067 PUD 17f3b9067 PMD 0 
[   77.440021] Oops: 0000 [#7] PREEMPT SMP PTI
[   77.440635] CPU: 1 PID: 2720 Comm: get_huge_pages Tainted: G      D           5.19.0-rc3-next-20220621+ #22
[   77.441973] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1.fc35 04/01/2014
[   77.443115] RIP: 0010:hugepage_vma_check+0x15/0x170
[   77.444021] Code: 01 e9 84 fd ff ff 48 89 d8 e9 14 ff ff ff 0f 1f 80 00 00 00 00 0f 1f 44 00 00 f7 c6 00 00 00 40 0f 85 fe 00 00 00 48 8b 47 10 <48> 8b 80 78 03 00 00 48 c1 e8 18 83 e0 01 0f 85 e6 00 00 00 4c 8b
[   77.447327] RSP: 0018:ffffc900039dfd20 EFLAGS: 00010246
[   77.448317] RAX: 0000000000000000 RBX: ffff88817e4b27a0 RCX: 0000000000000000
[   77.449681] RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffffffff823f2000
[   77.451040] RBP: ffffffff823f2000 R08: 0000000000000008 R09: ffff8881a3c042e6
[   77.452353] R10: 00007ffe8b341000 R11: ffff8881a3c04526 R12: ffff88817e4b27a0
[   77.453677] R13: ffffc900039dfd28 R14: ffff88817e4b27c8 R15: ffffffff823f2000
[   77.455046] FS:  00007f0edc9880c0(0000) GS:ffff888277d00000(0000) knlGS:0000000000000000
[   77.456625] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   77.457745] CR2: 0000000000000378 CR3: 0000000179394006 CR4: 0000000000370ee0
[   77.459936] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   77.461308] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   77.462477] Call Trace:
[   77.462950]  <TASK>
[   77.463402]  show_smap+0xed/0x1c0
[   77.464019]  seq_read_iter+0x2af/0x480
[   77.464674]  seq_read+0xeb/0x120
[   77.465286]  vfs_read+0x97/0x190
[   77.465880]  ksys_read+0x5f/0xe0
[   77.466488]  do_syscall_64+0x3b/0x90
[   77.467155]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[   77.468023] RIP: 0033:0x7f0edca7ade2
[   77.468609] Code: c0 e9 b2 fe ff ff 50 48 8d 3d b2 3f 0a 00 e8 05 f0 01 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24
[   77.471492] RSP: 002b:00007ffe8b324c28 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[   77.472845] RAX: ffffffffffffffda RBX: 00000000022f82a0 RCX: 00007f0edca7ade2
[   77.474017] RDX: 0000000000000400 RSI: 00000000022f8480 RDI: 0000000000000003
[   77.475184] RBP: 00007f0edcb4f320 R08: 0000000000000003 R09: 0000000000000000
[   77.476379] R10: 00007f0edcaffac0 R11: 0000000000000246 R12: 00000000022f82a0
[   77.477517] R13: 0000000000000d68 R14: 00007f0edcb4e720 R15: 0000000000000d68
[   77.478590]  </TASK>
[   77.479012] Modules linked in: rfkill ip6table_filter ip6_tables sunrpc snd_hda_codec_generic snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hwdep snd_hda_core snd_seq snd_seq_device snd_pcm joydev snd_timer 9p netfs 9pnet_virtio snd soundcore virtio_balloon 9pnet virtio_console virtio_blk virtio_net net_failover failover crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel serio_raw virtio_pci virtio virtio_ring virtio_pci_legacy_dev virtio_pci_modern_dev fuse
[   77.484573] CR2: 0000000000000378
[   77.485123] ---[ end trace 0000000000000000 ]---


Looks to be related to this series.  I'll start debugging unless someone
knows what the issue may be.
-- 
Mike Kravetz
