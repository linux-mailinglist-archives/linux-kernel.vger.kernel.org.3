Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313B15890ED
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 19:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236377AbiHCRDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 13:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235948AbiHCRDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:03:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399974C613
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 10:02:59 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 273H113i013518;
        Wed, 3 Aug 2022 17:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=x34N6MO9MUVC5xYJ8QeGIKsamqfvkde4+hTvtkbIJuw=;
 b=YLWVyvb8gDrPKfx6aq1LWLDe4q85nR/6zJEC4hRSPBqDd1ZavuBL7oifRuwopOb1CZx6
 1Bmpx75nBiLe+Z26epOMKgvCq7bJxzcEFsc7DYzgRjtQkyoqNCKtODjPUPWzjQd1tzaz
 su5RKeaLcIXONBiPgA5ebkbY+LJ3DYYxCrWTzoTSjTXQw4C6U2NUEUuRfMJv8WknE/Bi
 QC0oC9zZJA6y5XMDIq7py/z2FX1qx2M0bFg6/gbC5VUrwDB8nTKSMdbmcmmaz48TzWk4
 dS31bgDcNafFBS4EVQ9bDl1iIVCqHkH3VAwC22gVlhmi5SzFvzUG5+BOOaAYWsGFBiQc Sw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmv8samr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Aug 2022 17:02:44 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 273GhuaU030939;
        Wed, 3 Aug 2022 17:02:43 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu33h0ny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Aug 2022 17:02:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2BeRzyLm4hkjQ7cdudBZNP82kXJE3DNK28VBTB5UzVa1XF6auzrivJh8W7EiseEtBT69Ag0D7thZiw051Jc1TzAnJTf0jT1BYJ12wbPBU7KMHx94rTA9t2OvkZRyx9OMeePqghbG6IFJQdckgoVKFYOg1t3B4dVmYwM5pITBxL0cBqYOoW6uFoMy6JpZEDAAsTzoCwyjaw1/7N0UyFieNfsz3+YjTP0oTWldewaTWu5p+kMwC1FPdthl8ybY0DvjtalQIoxZ2RX/RZs30RT48JRgcoLfyYVpCmiBRTMUcXdrdZeRpAyyrZP9wEinQGqcse8m8LxWdESJSNm/r4ecg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x34N6MO9MUVC5xYJ8QeGIKsamqfvkde4+hTvtkbIJuw=;
 b=UPGjJ/Z7Co0xsPOUYBWF1zq5WCdBLl26qiHC8DmnjmIESx4w5N7QVdTwsy1X46FBfFvMoHTfk1+EH30NYsiGFV6fS7aI12pNNtq8TcVfU9yHbfXIRLCIpIWp2ql79mfA+GQwZtHJRtjNYNpGzPRdapVPdfUO+TAsxOqAR0QrHKDqo0qu4aoaFCL7kaHftSTURCxs0x7xxAX955zorz7z5SI+B53gGF8cXE9sx8SFp8RBUrS55O4Oiarz6qzc5gQbGCaEnEG+irOJER1R/bmPW40uYVzK0u2EFzMuGTjhLrEYOwgGLxz5J6XBfkH545S9pnVoG54GVsTHUPZuIHdwcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x34N6MO9MUVC5xYJ8QeGIKsamqfvkde4+hTvtkbIJuw=;
 b=DRsv/kSWgBzWO18cPQUKf+rXqrqnBiFt7tc1pNLsbpCPTUUay0htSl/KkXAcF59PlbLR0D+bqhO3sQuCqix71/k83QFzCWLfTHF+ZbbudpmKqw/YvLi+SVrVQSC/V+PHtO0am0XD9GnrjvcO2VEebPxWhmc39A7j+gopC+gkAPw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN8PR10MB3601.namprd10.prod.outlook.com (2603:10b6:408:b6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 17:02:40 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%6]) with mapi id 15.20.5482.016; Wed, 3 Aug 2022
 17:02:40 +0000
Date:   Wed, 3 Aug 2022 10:02:37 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     syzbot <syzbot+824e71311e757a9689ff@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, songmuchun@bytedance.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        Peter Xu <peterx@redhat.com>
Subject: Re: [syzbot] WARNING in hugetlb_change_protection
Message-ID: <YuqqLfu1E62PqnKS@monkey>
References: <000000000000098a0105e557f130@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000098a0105e557f130@google.com>
X-ClientProxiedBy: MW4PR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:303:16d::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f03654ca-9440-4656-13af-08da7571f928
X-MS-TrafficTypeDiagnostic: BN8PR10MB3601:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YBiqUxpUINgWbTo3vldi2gS3F6SajO58+7mB0Tfx9MnQHWRgdJPP5utTApslYVsisFmHgDBXRRoTAtb8d5knqgZwCnY4Bv7q6fV10mF3X/2AZhvitStetmMeb1uSrCR4cgJwr5fOPyFVa6Y2ag+kMCktRh2wPc7lYVK334mYgCQJ+engr35C0MJ4nrRTEVCYikSEnOuy0rallbs6pbxLGhO1Rv6XZ3SmmZdYcsdZiQgjAaOxkcrp0EbhbPQD9U8dtzy/eMLCEGIfKWJ2Cmc5J5njSA1pHN88qCeBjXcsSqiL4bSmCkrxsuE1qSl0ArzaqyUeDnxvtwDu3lq5l8GbaVr6QUrB2agjMjibRPJ4Q5AcyecCX7i0Lx2OBteR8GiqQRufkuwyg3bAX9CkrjIXNFwrDED41K6Ofcb3pHFaAT/zu1yM8rMk4L+ZvalCAsV7DqPpRdetzIYnn+LWq9PjgOjLNeoSrCLijFOWGmCBl0B84gOZKNLpzt7mJAyyZRMeNDWcdaXi1i4Kyr44dMucJ16+ueUiEFQGAdrGcKys8PoVkoFz4zT9yZTcRBAQeWq9xv/KA1BT9eO7YeAjQE/Bg+71Omd6G8JMAKqwB1hkZ1bi70miS+AV/SEBzVmqd/Jo9YVLJoH5ldAT6BCoKwy1MCvoS1cdkESWOrb+KYpT/CYGFeqZnb/ni05t3MRsit++y7MsLeNMF96GlwY+jzqPmlbgmDKT3YOFRYYOR15kx0PFZ5udaRNd2CaI9XL6E/pslfrkuJ5wLrDQ+M+aV38vMlk3VQoh10gXjdCOvMGZXaikAUEpv+mnoV7jd+13WdqqgIsE82I7+BRPbpc4FJ5kCNjTiKrm+K1fCrJu0L6BXkk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(366004)(136003)(376002)(39860400002)(346002)(86362001)(2906002)(66556008)(66476007)(316002)(8676002)(4326008)(66946007)(44832011)(8936002)(478600001)(5660300002)(6512007)(6486002)(966005)(45080400002)(7416002)(41300700001)(6666004)(9686003)(6506007)(26005)(33716001)(186003)(38100700002)(53546011)(83380400001)(99710200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EBPL3PLhpEtI/InBaBqFP07Nk9hcBFhQc0e1v3pec1EU0Hrr/uPu+AlCdWYs?=
 =?us-ascii?Q?PwkL6nLvpd6GRWjaLHUyfiF034eyGu8B3UV5CH3OAkfsLozZtjfO9AJ5jRju?=
 =?us-ascii?Q?vIVrO3r7FqQZuomAcPT9QzGYjAXl4lr9miSObX72V1GEUg9yxeQ82cxWI6Z9?=
 =?us-ascii?Q?dr+mftEk8OqRMH9T15Lj6wA9gUCeDmfaFNyn2s3DxcUn6a3OENS/JGICYhh+?=
 =?us-ascii?Q?ioY0DSUc3hOAPxIleJ/B4AgP3O9/udwRSpSaXLN2odw7RF96bwztnAQMF7mK?=
 =?us-ascii?Q?/la67DQaoYSse6verG57i5/5etylsUdIn4DPoTBEi2uDx6P5FgQUuFQ6HfRb?=
 =?us-ascii?Q?SCIQZwjedB0tT65Yfaik1KE68S4NiXdFjF5dUAHNSC0xprI08BReabSWj1CD?=
 =?us-ascii?Q?Hc5zihbAI4QXC2Rh+248qKNrHosiZq5cy5nRndAU46a3xcYEdWV446Q1EQ/o?=
 =?us-ascii?Q?do9NdDj/jg116YEt6S+ZR8ckHkzCPCryOxrTs2KbhOgqgD51f8pf9hzBtnoO?=
 =?us-ascii?Q?5Ks7JSVZizoLUmV9Pg2CftjjCmiXvb86ztJK2EjzC8AMwJXxtk2fjo0S7ZDN?=
 =?us-ascii?Q?kqfMl4dDI7NNoGvihPba7ia9VMFVP79CM9X5RfGMHdxvS/qW9ERkBIqsWVfJ?=
 =?us-ascii?Q?2u8FSz4T9Zrz0F1qxfWs2V6vGmFBAyNhKWvBHzBzNwI5mPxO5gccumB3/LFc?=
 =?us-ascii?Q?AzMqU0+nUESGPJZEnMgkYzIgNYxyRrO49rlFaII6qUNWXFw9Sd4J1D7g9FSa?=
 =?us-ascii?Q?tJlngcu76mZDztM6kLJB/ieuzB45O1GWew2jNanuARmWR93/0TkGTaehRNvQ?=
 =?us-ascii?Q?ycJD7aiyN7fhx39VqXiRTAaGqtQCSTC4lBSTSF3AXszR5hyPU/aFoQEk22hA?=
 =?us-ascii?Q?DSJQm0RcW99uCUi6pLp6jC3e9pHYaXAAXD1N/BPUGN5dHBsBLvSR2YdWtyp0?=
 =?us-ascii?Q?5FrR8fDRbSSDbADfxnN3KDQVePcEIrJ4HbOrqwSJmtFnZp+z2dTshDqXVdnC?=
 =?us-ascii?Q?TRt4FsW/RJowxVAz4D2WOUW/DNlhQKC7nV0NPGSzorfnS3NCiNgtaLHa4IWi?=
 =?us-ascii?Q?83ZhLgQ4xIp/dlUvPvT45CtMXhZfLqingP47RmjsxAeHHEg+09skoaXfvtLe?=
 =?us-ascii?Q?E1EyDdDcjXx6TBq0S/0rxWPH01AqHyHrZRU5zHmV3fX6yJb+AXOygQH2D+bK?=
 =?us-ascii?Q?8lO7xPvtJ7sga3ywBzPEkhkM8m3F2D/kOnM2bdFEq1hzXDja4Ecm1y7HEjjW?=
 =?us-ascii?Q?8Glp40vWbOHygVHvjhO5JuL+T2XKDM1Jww46qnoqhnu1C/eCFdM+qFPkTZEX?=
 =?us-ascii?Q?Xa1Pp+olYW9jzD+fyz7VRa/ci4sGKkvBAawW1ZmmMBOmiWgJnyyLosw9rYUi?=
 =?us-ascii?Q?5Fi4AN+2W5yEBYo88g/NPFEwgsct4g7cVfrHDpSoQu+kKF5BAYN7h9lltvAK?=
 =?us-ascii?Q?XgOAW+3H87ht9Vy8A8wd8t7gpM6tQSKubGpaGARwOPBd63prL/Os8IyJBanA?=
 =?us-ascii?Q?pWPNcOj0kCNmLEVgCOmBR7Ki9jZjnmGxRIGi9uYAJidx2N1Fk2xI/9jddeQH?=
 =?us-ascii?Q?7Y5Q77e6ZiYd3Zi3KtG7Y9rDI0tKxMI8zeijtJKDbBeFDL0PD+IWdOi9SYDj?=
 =?us-ascii?Q?Cg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f03654ca-9440-4656-13af-08da7571f928
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 17:02:40.1065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UMOk4qNCIKMRgOWKqWKXvfOcpFAi/w0TuZA2+ugwqhTWHd0BODin3F2F94KB4boe3H4Y6uuK7/Okv/ruJc5j/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3601
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-03_04,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208030075
X-Proofpoint-GUID: b11u5jiBexjF8xwF1Wb3OHQUFdU6so03
X-Proofpoint-ORIG-GUID: b11u5jiBexjF8xwF1Wb3OHQUFdU6so03
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'll start looking at this, but adding Peter this may be related to his
recent changes.
-- 
Mike Kravetz

On 08/03/22 08:32, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    e65c6a46df94 Merge tag 'drm-fixes-2022-07-30' of git://ano..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=139cc282080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=26034e6fe0075dad
> dashboard link: https://syzkaller.appspot.com/bug?extid=824e71311e757a9689ff
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+824e71311e757a9689ff@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 28745 at include/linux/swapops.h:319 make_pte_marker_entry include/linux/swapops.h:319 [inline]
> WARNING: CPU: 1 PID: 28745 at include/linux/swapops.h:319 make_pte_marker include/linux/swapops.h:342 [inline]
> WARNING: CPU: 1 PID: 28745 at include/linux/swapops.h:319 hugetlb_change_protection+0xf85/0x1610 mm/hugetlb.c:6392
> Modules linked in:
> CPU: 1 PID: 28745 Comm: syz-executor.3 Not tainted 5.19.0-rc8-syzkaller-00146-ge65c6a46df94 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
> RIP: 0010:make_pte_marker_entry include/linux/swapops.h:319 [inline]
> RIP: 0010:make_pte_marker include/linux/swapops.h:342 [inline]
> RIP: 0010:hugetlb_change_protection+0xf85/0x1610 mm/hugetlb.c:6392
> Code: e8 d0 5a b7 ff 0f b6 94 24 80 00 00 00 48 8b 84 24 98 00 00 00 84 d2 0f 84 ef 02 00 00 49 89 c4 e9 48 fb ff ff e8 ab 5e b7 ff <0f> 0b 48 b9 00 00 00 00 00 fc ff df 48 89 d8 48 c1 e8 03 80 3c 08
> RSP: 0018:ffffc90014cc7780 EFLAGS: 00010212
> RAX: 000000000000082a RBX: ffff88807750e820 RCX: ffffc90006723000
> RDX: 0000000000040000 RSI: ffffffff81c30c25 RDI: 0000000000000007
> RBP: ffff888074de5ea0 R08: 0000000000000007 R09: 0000000000000000
> R10: 0000000000000004 R11: 0000000000000001 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000004 R15: ffff88801fcc8e00
> FS:  0000000000000000(0000) GS:ffff8880b9b00000(0063) knlGS:00000000f7f06b40
> CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> CR2: 0000000020000040 CR3: 000000001b84c000 CR4: 00000000003526e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  change_protection+0x96b/0x3ad0 mm/mprotect.c:463
>  mwriteprotect_range+0x387/0x5c0 mm/userfaultfd.c:759
>  userfaultfd_writeprotect fs/userfaultfd.c:1823 [inline]
>  userfaultfd_ioctl+0x438/0x4340 fs/userfaultfd.c:1997
>  compat_ptr_ioctl+0x67/0x90 fs/ioctl.c:906
>  __do_compat_sys_ioctl+0x1c7/0x290 fs/ioctl.c:968
>  do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
>  __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
>  do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
>  entry_SYSENTER_compat_after_hwframe+0x70/0x82
> RIP: 0023:0xf7f0b549
> Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
> RSP: 002b:00000000f7f065cc EFLAGS: 00000296 ORIG_RAX: 0000000000000036
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000c018aa06
> RDX: 00000000200000c0 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> ----------------
> Code disassembly (best guess):
>    0:	03 74 c0 01          	add    0x1(%rax,%rax,8),%esi
>    4:	10 05 03 74 b8 01    	adc    %al,0x1b87403(%rip)        # 0x1b8740d
>    a:	10 06                	adc    %al,(%rsi)
>    c:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
>   10:	10 07                	adc    %al,(%rdi)
>   12:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
>   16:	10 08                	adc    %cl,(%rax)
>   18:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
>   1c:	00 00                	add    %al,(%rax)
>   1e:	00 00                	add    %al,(%rax)
>   20:	00 51 52             	add    %dl,0x52(%rcx)
>   23:	55                   	push   %rbp
>   24:	89 e5                	mov    %esp,%ebp
>   26:	0f 34                	sysenter
>   28:	cd 80                	int    $0x80
> * 2a:	5d                   	pop    %rbp <-- trapping instruction
>   2b:	5a                   	pop    %rdx
>   2c:	59                   	pop    %rcx
>   2d:	c3                   	retq
>   2e:	90                   	nop
>   2f:	90                   	nop
>   30:	90                   	nop
>   31:	90                   	nop
>   32:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
>   39:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
