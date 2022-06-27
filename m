Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C12255CC1C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbiF0L0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 07:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbiF0LZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:25:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF4465DD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 04:25:23 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25R8iLoh024252;
        Mon, 27 Jun 2022 11:25:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=9XgNuveo9SJuD9H4UKozHI5c/U8DG2hciQK1ezrsYIw=;
 b=KfRY6mY0jLRWNc2/CdKxCXa3AQPeQy/qsdfHw287juZbOrcIhlw6PP8o7c6ChlAuUrZq
 FeUD7/quFSp0u29fAT5jWySmEGc5Ku/m2J3CZEKmWIdXTQiloSdiwME9j6xm52ZJoXQh
 h3TDS+HFQwtEhaP/caocaBkUP8ytpqJVjpu5DNJcawMy77/aAfS1adzw3XoEgvJ3IYR7
 hX8qlLMoAApDJOHNoIOvQWZtiRkByBMgPdlr6umpKBeHIVbHPxnk3nJ/g/ny5et4QXD6
 sHZxp/WSTprgfGQDuCB6zWXlmJBJ0gd3ZRs7AGGK9ZwhdgsHDNAX3aG76kiIJKB5F+q2 ug== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gws52axt8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jun 2022 11:25:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25RBEnl5039407;
        Mon, 27 Jun 2022 11:25:16 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt77ktc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jun 2022 11:25:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=So8n++u/Oo3YcltCHHBbJoEIJjzZQRnzb5IkQz2Ia+ivbLy/n0KtxFiBY5YGqlZUVNSZwuWOhHpxyF9CUEutmdfpjscM6wNIwCnCiqQifBQ3TfHDIWEqyHyJ7mt5ZOPFUlEiISHLT0gPyzjrOd1kmwHDnfd6BCVW3Fk1n+P62ezj+6QbnoGzUXBWrhyqA04/XmlZOGv3VC82HmTwqdfnfzWYF3wzxFJbCHXK3eg9yUoLnEO0VJghTm7nC+TL/j0YLW/NATLcqR+5xBVpgsu/Z5uNpEM6ahCmjMbachHUT90VEokjnpreflKQTomWAoatSmiQnoKszVRAfLTM60tvdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XgNuveo9SJuD9H4UKozHI5c/U8DG2hciQK1ezrsYIw=;
 b=CEJYccGeQfbGDZJ1WyAEAM6WFNp8OxZBK3lmKpSMKojJZAe8Ago4uIo0Gh66ik5gUB6/5XWXedfV02r5yoC6a78CgKF8TXruYQZPxuREkmpxVBPX2Zo4gZ6AKUisnQnwMjST7tmk1YMeuqajmXnCsTdrdelDsT/QXMtXL0La4VORudsJKcWzaCyW+0ul0pKFZO4ZWPBc6PTjMX/+men5QOeWWk0F98ly/oUpbcN/A/wU8WVyOngeybnG1ws0G5UVms1+4KM8NJPLoFxuE2Q6Tq7p4LdhLjH4nfyEhB9AmZwO6E8eILrbhT9M6ODUgGbaWw0v6zL1/LSN+tqc6HwW/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XgNuveo9SJuD9H4UKozHI5c/U8DG2hciQK1ezrsYIw=;
 b=WyexiutZd5+d8nX+yN9cwA4b6l6ALIUt1DfSb4xDzSNCeKFqfgBDhqe5W+aIHn0+EceK4nMG2mOHIMO22cqanCz8g6UZftlqeAMb2G86G5mAlPbM3B5N3bucoh5YXDj8joEJLi3apsK8LRFuRO3ZKnqf44e9XL8j8h4RlYxO+cU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BY5PR10MB4274.namprd10.prod.outlook.com
 (2603:10b6:a03:206::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Mon, 27 Jun
 2022 11:25:14 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5373.015; Mon, 27 Jun 2022
 11:25:14 +0000
Date:   Mon, 27 Jun 2022 14:24:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+ce3408364c4a234dd90c@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING: locking bug in hfa384x_usbctlx_completion_task
Message-ID: <20220627112441.GV16517@kadam>
References: <000000000000e3fc8905e2608d4f@google.com>
 <20220627105336.990-1-hdanton@sina.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627105336.990-1-hdanton@sina.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0035.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd735584-7d7f-4862-097f-08da582fb426
X-MS-TrafficTypeDiagnostic: BY5PR10MB4274:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UKFwzMhTVY608CMymapFK6KDEMLAjvhYZvPv1EHq949hXuGYY5nrPQfRS5t8Q+WSxhIXRWgGNfB1XaZFo0uUp/vWiaR5anM+E9+1m1vs5Iiq2qNnXp14UU87/VvUwkUNbtYwCIICXZweGRQvEaHGjoXFvttRQtj+UntIZEc9cexXhQiMPG9HGpghG2PK12EophW7sze9oMOt+3sERl20s+btmawN2DdigJXsuzNG55AzG1NkflNGj8jjBtLHPGcLgJGCQYF6xXjS7a2ZTjeEvgmaQfnBgesOuSNlRdL4axEtZ3IA1zNE1Rxwyb1/Z+fzf6Hgdg/BBdqYSxiPQ2S4CZOt3P0vYA7LapPBvEKzXCY7krrWYGC/MQTK+2IDYTJyTC55ZUyt4p04hGbYCubgNB0HFG3XTDWkuPG/2ahNlRYO15GUUS+3D3kNIHDedLjRqU5QPCtQ+DN6J2GmiZHz6cqOfmP77jTT32AHXarGUJtGUl8Sdewn7iRZGpV+7GYkJe2Ieghr3C7aRMHwTtiug9aMsWkrBfLRdWQUDMv4E9HrwduGL2IBBYUk2qCf2iF5O2CeLxUNxuitgecEgm1p8VhcCGPdy9ENnyNdLRdF+z9olguu0g3JQ9vG2ZJqMhVw2YfTA46UulVblWWG2U6wgTn5hm93Mmbjt9q3cP1NJP2gDssqpa0XbVcId7rC7IHerUgTFjaoULS6Rhzbj0AmN7yxCjy9/K5TbUbsqlhgBk0/fJXI/HXbd0jCCb9GX6zv9+F8R8LAByvLJSJ9lgIJBDmc3VA+sNahqTLnGIDxH7teH0poZntTvGP4pM/P5IfRC+Rc16LD6yvARY+EEvHSXH+ODtQrcXeO3eWabnt89jndVXI6U+MULBDvM/KWXewq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(396003)(366004)(346002)(376002)(136003)(86362001)(33716001)(38350700002)(52116002)(316002)(1076003)(2906002)(6666004)(6916009)(26005)(9686003)(6506007)(6512007)(33656002)(5660300002)(38100700002)(66556008)(66946007)(966005)(8676002)(66476007)(83380400001)(6486002)(4326008)(186003)(45080400002)(41300700001)(44832011)(478600001)(8936002)(99710200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/N+ZsHSclGTJwGIxa9kOKWPXdylg2lDcqafftec2TSDIgyGNPBkvLrDP12Ea?=
 =?us-ascii?Q?WtCrA5ahxXYwIkIrGtHxKY5ol6Yuw5SMscdFXu9iWb5qCaqT7yHIc0YAcOqH?=
 =?us-ascii?Q?EGF4mJBuOiRbO2M4bCQxJoy1qti/8EkBI1nSsIeyH0kfcj7w+jt1R9R8Jg9w?=
 =?us-ascii?Q?erOh5WCqClYXK6hSkoUWdWxGw7032rcbVjvCcoEtr9FJnL+PtTFp+o6RxDbR?=
 =?us-ascii?Q?DQMTTpFssT8dwQIoVO1dkDWsKwo1FjGYgRJa8qI50MFy7GIKcAO8yZ03gYk8?=
 =?us-ascii?Q?Vd5X0/WZiyeLSaUPRuil/BcrIQCi53N0/O9sJUf4wrescKdN7eE/HC+56tnf?=
 =?us-ascii?Q?nHpMw5W7cMWpvGjVeOij/5ev50CryWSSNZXhdV0TXmFG2hKSJdgBzwmILipC?=
 =?us-ascii?Q?s5uW5XQPBMjFrn2ADbAly4ddyJa3ZciqqBLVRpoGRPxbptgw88WxfMzxvoaY?=
 =?us-ascii?Q?vWJXi0OCK3hZmIQIEdQDt5MP/5j3tm5n3RamvVrCJM9fgDULKP4axXIvABid?=
 =?us-ascii?Q?k6+gMoDt9s/OFFanvxqNtdqlQDhT16GSIYd/3khUFiFIy//u6VhJUELIHJB4?=
 =?us-ascii?Q?vGPiO5nTPqsMfe1jKFHHY+dKiLrwb3pbH0igSf3HrJwq5hQ2ZXZ1oo5yJwfG?=
 =?us-ascii?Q?SVNj7QU/Vbn1TUjKxj5Hw3OLSSTciILrOyK72dIjpI4Hp8Eo6hzaV+Z6BTUH?=
 =?us-ascii?Q?or5SrHpRYboroxGsK2msZl2dZIp3cJ5wroD64Hc6zGnUdityMBlOpvNgAyg8?=
 =?us-ascii?Q?meh3hJYylCL6fen9QqsIfynS7CYJsTu0zoKV5zpwWqO2XZOW/VUGlW09dOx/?=
 =?us-ascii?Q?m28TyAicAGMG9gUm6DF2eWmiSzerjOlfKaREwcIOFSq2/LrtsNHMvsf2arju?=
 =?us-ascii?Q?svE+xdb9oserEeIgcvi9Ob0iOu4UeErSRleY/OoZnSBwnJow1mAx6y0SyYjT?=
 =?us-ascii?Q?AguCvBAuwaX1yrjUDKrihoNKSXbwHtbZ7VY0sTaPx1/Zzi5YcyO2zAEJwDhQ?=
 =?us-ascii?Q?AjQkBT+3StdE+kPyYUVRywz7MPvQ8/4ACgLhwUCdHf3WcCQ3g6R0er3Yuk4U?=
 =?us-ascii?Q?seM3BBss7D+poCagmTrp3on2cNwO70L52jQPDFM8fpThvRzxIbwuBdfm5mbp?=
 =?us-ascii?Q?EbZLy+r3HBDY+uOeTBA3cPqrt9GNcBgKiZ8s9zhmTpz9uczSHYCEbu4oVJAE?=
 =?us-ascii?Q?MT9JcV/1kgcpy7JzuEOg96l/y+1Vy1LYGeVSe1HogKI+XKxdQEWOcV6WEV+y?=
 =?us-ascii?Q?7QUY9a45yYtvCLt/0pwU+pfmIIK7DhHDNddI8Gd9JKDt2tona5Ggyo7m6HDu?=
 =?us-ascii?Q?xVGGbCgz78743KrFgxN+ait4aG56x6O2EbvYIGzT1aLj1FjdwuySlMmHzH8R?=
 =?us-ascii?Q?VjDCtfi2WvstaYMhAwMrRSlk9DEdhuIsPepGD309OJ/Tqt957B/TkMUHZovo?=
 =?us-ascii?Q?xbtiQsa+g6RmxUCr2qbgslKco1PboUmJ76I/12eXTwtRjwG3VYtdrteXerar?=
 =?us-ascii?Q?yU2Xz+z+wEujWO9X4K/xg3wmfcetGN0/dAtFg4aXOj5qgmAVher+f8OiR0Qx?=
 =?us-ascii?Q?H8Zn6o7uCnCCdlekFBtX/msOdEKOaoVGrsKRJ9AV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd735584-7d7f-4862-097f-08da582fb426
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 11:25:14.6382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f2uotd4dUnxgD1czpbm1acwb9BSuxY94jPuE2ei8L0sNlH9yc0ZR7HJYJf7WIboIcbBTjEULKGkSKzxgu2zXo9GpSt7rqnE3d6B77rcMLgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4274
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-27_06:2022-06-24,2022-06-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206270050
X-Proofpoint-ORIG-GUID: jrTIZdWPDXkw7WothXi4LUPV2_PbWkRr
X-Proofpoint-GUID: jrTIZdWPDXkw7WothXi4LUPV2_PbWkRr
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GB_FAKE_RF_SHORT,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 06:53:36PM +0800, Hillf Danton wrote:
> On Sun, 26 Jun 2022 14:33:28 -0700
> > syzbot found the following issue on:
> > 
> > HEAD commit:    105f3fd2f789 Merge branch 'staging-octeon' of gitolite.ker..
> > git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> > console output: https://syzkaller.appspot.com/x/log.txt?x=129a824bf00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=a352a56bc8822d0c
> > dashboard link: https://syzkaller.appspot.com/bug?extid=ce3408364c4a234dd90c
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10a97af8080000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1031ec4bf00000
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+ce3408364c4a234dd90c@syzkaller.appspotmail.com
> > 
> > ------------[ cut here ]------------
> > DEBUG_LOCKS_WARN_ON(1)
> > WARNING: CPU: 1 PID: 21 at kernel/locking/lockdep.c:231 hlock_class kernel/locking/lockdep.c:231 [inline]
> > WARNING: CPU: 1 PID: 21 at kernel/locking/lockdep.c:231 hlock_class kernel/locking/lockdep.c:220 [inline]
> > WARNING: CPU: 1 PID: 21 at kernel/locking/lockdep.c:231 check_wait_context kernel/locking/lockdep.c:4727 [inline]
> > WARNING: CPU: 1 PID: 21 at kernel/locking/lockdep.c:231 __lock_acquire+0x1356/0x5660 kernel/locking/lockdep.c:5003
> > Modules linked in:
> > CPU: 1 PID: 21 Comm: kworker/1:0 Not tainted 5.19.0-rc3-syzkaller-00071-g105f3fd2f789 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Workqueue: events hfa384x_usbctlx_completion_task
> > RIP: 0010:hlock_class kernel/locking/lockdep.c:231 [inline]
> > RIP: 0010:hlock_class kernel/locking/lockdep.c:220 [inline]
> > RIP: 0010:check_wait_context kernel/locking/lockdep.c:4727 [inline]
> > RIP: 0010:__lock_acquire+0x1356/0x5660 kernel/locking/lockdep.c:5003
> > Code: 08 84 d2 0f 85 0e 30 00 00 8b 35 7d ec b3 07 85 f6 0f 85 f4 fd ff ff 48 c7 c6 e0 97 47 86 48 c7 c7 20 92 47 86 e8 9a 5b 96 04 <0f> 0b 31 ed e9 aa f0 ff ff e8 fc f1 e8 00 85 c0 0f 84 12 fe ff ff
> > RSP: 0018:ffffc9000016fa28 EFLAGS: 00010082
> > RAX: 0000000000000000 RBX: ffff888109450be0 RCX: 0000000000000000
> > RDX: ffff888100371c80 RSI: ffffffff812c1d98 RDI: fffff5200002df37
> > RBP: 0000000000000edc R08: 0000000000000005 R09: 0000000000000000
> > R10: 0000000080000001 R11: 0000000000000001 R12: ffff8881003726c8
> > R13: ffff888100371c80 R14: 0000000000040000 R15: 00000000000c0edc
> > FS:  0000000000000000(0000) GS:ffff8881f6900000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 000055fb59fac7c0 CR3: 0000000109e53000 CR4: 00000000003506e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  lock_acquire kernel/locking/lockdep.c:5665 [inline]
> >  lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5630
> >  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> >  _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
> >  hfa384x_usbctlx_completion_task+0x35/0x510 drivers/staging/wlan-ng/hfa384x_usb.c:2641
> >  process_one_work+0x996/0x1610 kernel/workqueue.c:2289
> >  worker_thread+0x665/0x1080 kernel/workqueue.c:2436
> >  kthread+0x2ef/0x3a0 kernel/kthread.c:376
> >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
> >  </TASK>
> > 
> > 
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > 
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > syzbot can test patches for this issue, for details see:
> > https://goo.gl/tpsmEJ#testing-patches
> 
> See if it is due to a typo.
> 
> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git  105f3fd2f789
> 
> --- y/drivers/staging/wlan-ng/hfa384x_usb.c
> +++ h/drivers/staging/wlan-ng/hfa384x_usb.c
> @@ -2632,7 +2632,7 @@ static void hfa384x_usbctlx_reaper_task(
>   */
>  static void hfa384x_usbctlx_completion_task(struct work_struct *work)
>  {
> -	struct hfa384x *hw = container_of(work, struct hfa384x, reaper_bh);
> +	struct hfa384x *hw = container_of(work, struct hfa384x, completion_bh);

Looks good.  This could easily be detected with static analysis.  I will
add it to my todo list.

regards,
dan carpenter

