Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996254ED81E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 13:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbiCaLDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 07:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbiCaLC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 07:02:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CFF205BC3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 04:01:11 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22V8fmTn030419;
        Thu, 31 Mar 2022 11:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=GRyX1tjSSAQaoq16nrx47KBmdaBr1sCKe8nOJjvKXxM=;
 b=RUnBUhyyFsXxbkzXTz4G/u7VpUUsiuCxgn0WW42KD9RkFt5zwhy+wwTRgNAzRlDpEqax
 l6qdv4hqw17BDtGzOlQrXIq4oTetVNv8n0J8NRfRXDqgC6ndHdq/2GqUAofx5a+AVV/O
 lWvt0ByyUONx4UfPW9WVHjJ8lbf6uwL25fGH3B1apAuUypD4vR/WVf3RkgJwvPjwY6NU
 XWtuxJAGTIs2LatLdJUxiL+FXy3MgkO+y+K23+Qnju16Wy1AF14MlEEVNF+QmewpCekd
 TBIsHU3IzHu7Bc36BicGypuh6UPe1+dvWp67LYftjDV9jVpFyMrrWG+MG41p2Db/RSxo lQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1se0m1h4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 11:01:02 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VAu6LG027648;
        Thu, 31 Mar 2022 11:01:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1tg7wfn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 11:01:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKMlgnksg1VWKLQKjQ61WroMjY1XNBnIwKea82e779td+cgD2PKA6OUu0c634puzNSboHZWWd8KCZMc+0wINhmvru60Qs4sGhHoRVZzbKcNiAYVYCcUlB/MFGN43twRnUfNpqhBwAmX0pb/Deux+y0+y4Z3UrxRyKfk35Y2IYuzQQNMgbmJgu8A/RiZQkyb39k/1SY7bW4Hd/IwZsMCinygJhdOIkLsRXJ5aQR7qx3spSBgVCr7qAobiEORvwv1Z0a+/+SkLrDKU1oTC40dKI52e6ffUPwjgro8F8mHwgZ8keULuM0KWSW7KniOvpMxVKAKPPZ7O/SK1LcoQVwftrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRyX1tjSSAQaoq16nrx47KBmdaBr1sCKe8nOJjvKXxM=;
 b=VjXFA8pHCH0VTpwRyEaf2xHY9Qm9DM9rcneVwgBaMUXPRfuOWPpDjAYyYXl6S42CDWVjTevZSMWWzDMG5DyjSgssT5CKrKk+/34WHI3+wjTnkzOgObMhiAynrQHj9wKiYZMV5SoDla2V0Ra5atzci9nYPr9qqHUlsaLn1smuG9MmXXhwIFQTOCjTnGxyuOHf4a9rr7B+gwBlELWlJLp272ImimKSFFHKLOLZUZtDSGZTNql14Ldw0pbgHYN/0dguiMyVxmrZrdzGPdm9aLluZkjsL+rlCBe5tP09rOPcPPba+BoixTWncZhDFOCEXCxfqHDyvavjSLrErWcDRCc3sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRyX1tjSSAQaoq16nrx47KBmdaBr1sCKe8nOJjvKXxM=;
 b=xOZdV0FU75P9htRAChgqoWQv8KLZoxlWBgbDQ9coO2Ysk2w69U7y+nLpuYkYp/PQcxkjWELDSZcgu677x/G7+oSu64KsBRS1+2gx0+cobhhyzHMbOzf+5Jmj4felGTctwTGq4fmE8FFJ9I9Cu2lylr3l2il4hf8wonZPNWFhdXo=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB2025.namprd10.prod.outlook.com
 (2603:10b6:3:10e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16; Thu, 31 Mar
 2022 11:01:00 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Thu, 31 Mar 2022
 11:00:59 +0000
Date:   Thu, 31 Mar 2022 14:00:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Alaa Mohamed' <eng.alaamohamedsoliman.am@gmail.com>,
        "outreachy@lists.linux.dev" <outreachy@lists.linux.dev>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: gdm724x: Fix Duplication of Side Effects
Message-ID: <20220331110048.GN3293@kadam>
References: <20220331101849.71046-1-eng.alaamohamedsoliman.am@gmail.com>
 <ebbc4a14c30f492f8553e6ef572bbcbe@AcuMS.aculab.com>
 <20220331104012.GM3293@kadam>
 <acde5b1e8495431dac05403c593d4679@AcuMS.aculab.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acde5b1e8495431dac05403c593d4679@AcuMS.aculab.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MRXP264CA0035.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:14::23) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec3967b8-20ee-4c93-517e-08da1305bd36
X-MS-TrafficTypeDiagnostic: DM5PR10MB2025:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB2025968BC787A0FE99D80DC88EE19@DM5PR10MB2025.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tKBfkE7G9fYeX98B9vgPtFMEnrQiHsFmeY2W7/x9yZm2aQKBDc7W5ltv3GX7+36MU6ddk/C0mol8gqRI9a3ApNsso9l3REMkD54lNggJlYu04opE3DfEzMi7aufqWBzWaDjQaKLoV+/w7ySCe0Mh1QnaL77zyKfdfNln8tdbKuzK9X7Z0VhVpmMpYzFm0lKbfWcymFqNmUbKbX131ektdN84vCbQhopX6BT+IKVn9nggANjhAiEBh34o9LROZqC1EHV3K2m3IthBa0wz/S9Ty0iTpM9XP/Q2eyvslfYBzoALBvnDegcPzYD/wFxbN57SpVeFCmtRlmcH2kYljdq6x27RfgOQ5dYpNqyN21/RkoEYGV+TqS8SuXb4zlIYiOUkghpAZ/15yKR4hJpLaGV76IMTPuOUNDGqBKoKrJtgxZ9tl1ElHGl4uI76+uiEj8QBFy30+zIRwQRwIXuit3cJZAVcLnPDm1h2Ud2Ht4L0V/21wLIWmldsI5opsfm1JwwWBg0ekYmoPAZk9Q//rG/wNfWSZBsy8Ya2/PUIQ7QF+aa+pHpO9r996qyqFePZi/TLRw2f8EvWVpzwDx78mwRk5F9gJPd/iuFweJ3pNi/Iy0f5zByuV7sdq/p1PdWmAGdDi/kIXkeBkQv22oEUjv1dMPzULneSo7hmm4yS0D6Z530HOEZ+5SsVkZipCWAEWD5vNYuFJ6q2trJD2aX+URaPI8N8AJ4WAL5ydc+sUBI7GdQx6OvD73p+GbYynJxO0lF+0KbdbG6v5/KwlSoySCLgvzNt0a5v+O9keZX6lyoEm2iW2wWSr2o+vzpmLTFzs2eCORAbV0gL/NG8eKuH+sIJpFLOz4ARceP5YBzgTN1Kyjs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(33716001)(966005)(6486002)(508600001)(38100700002)(54906003)(186003)(26005)(6666004)(6512007)(6506007)(9686003)(52116002)(38350700002)(33656002)(2906002)(316002)(86362001)(1076003)(6916009)(8676002)(66946007)(5660300002)(66476007)(8936002)(66556008)(83380400001)(44832011)(4326008)(56340200001)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?obU5p09Ba2Ebfdsqg/3AuYqC30HHzFseZInnKd5AkJD6dAatVfthnQ1mJRYe?=
 =?us-ascii?Q?10Rbx2Lc8Xq5TvMCavr4dMaXjbEZIaDRI4h8VE6sBLuyrOiH0AlT48/hCEit?=
 =?us-ascii?Q?o8BJvjFOvy1EGuZDuHkzKi1UsH5akD3oi0OtmMvwzgUhRB1WlTdL1MEjBLUk?=
 =?us-ascii?Q?PDw68wwEDXZw0LyVjAdDb59oQlGU0QqGDystTC6LZWGVvcz1M0wa6sWftYuo?=
 =?us-ascii?Q?0Bon406hGik/LaxNJpN5d4aLACtLhjRaABw5lwoyQPPJapxvv3EBA2mGul7Z?=
 =?us-ascii?Q?ypePyCjJEwm4zK5jVAgBdE3W91s6YjwzB1Q75M5/CkQ2Qg3UnBh1EMdX0+S/?=
 =?us-ascii?Q?HAD727OoRIJAacIgwZax13lkfCXiAZjvf9pJ3A51KdfDcpuSQfVQeOgFvoej?=
 =?us-ascii?Q?BOu+567CGKocCIxTjYzy/cwV1Ayl7Dqc99g9f2REYJlmrjhqtMwuIkA9TuD9?=
 =?us-ascii?Q?kdOcbEiTfevrIs0XFZ++XY8wAOC9OkGejnK3/bH3kU7nr6I64Or1va4hE7Lr?=
 =?us-ascii?Q?NZS+3MruHsn8k8kg9kkEwWAJq6itpZvQSwAxhFNNJUTyYoSCTv1lHDiJXVyr?=
 =?us-ascii?Q?rAD0jDAZHA3UudT+FldSqyK5VL8Co664gxS6KdeAoGQ5sWvmgLSY3Vg/tDU+?=
 =?us-ascii?Q?JHZtP+wh18RKrmp7NHdTBuYdlY/LAsdUcH7PTpitecwx3bChlFKm/HmWNb0Z?=
 =?us-ascii?Q?qQNBMkmbQDNv+Mw0fqr4BKy6MbrMrzsZloz4X1qce2UjFSPeLF0PtMpwXabq?=
 =?us-ascii?Q?fhIUhzwrG9Q3wQ1lL+vB2+gFbU3mj7y9DG2fOKIjyGQuTzYNMJkD0CPcZS81?=
 =?us-ascii?Q?kCN4BbwBj67jQhl4AnUb0lksR0dcHpwdTgrgXVecyyP5xp9SBdWK7Gcvz/vU?=
 =?us-ascii?Q?K6+Lx9D8EwE5ZtPu5rK2A8dW+lKAfP6lhrD2mI8VDkjmyex5CySRC46Mb0qh?=
 =?us-ascii?Q?bpb9dMjypK42LOItUx8xgd+sG1PIqIfttQvHVc0Yz9PSeCBL/sPR54s9yOMb?=
 =?us-ascii?Q?eaNUZ0egxde9oGlnkN1Pl290WqCMNh1Q1A2qarGuIaZw+jU9+kIPMByYkIxD?=
 =?us-ascii?Q?Rev5x37iZf2KtzuEtvk76ZMOKyBAmn9nEhxlzuiQXNkChSeP+t5rn1SpFsRm?=
 =?us-ascii?Q?ggOAA+sZuMl8af1C9fOIiiqUlU4TdPuynWB0uxnY+6y655ZiUFdpuhjVyTuQ?=
 =?us-ascii?Q?0JBiR91XgI3rnQYDZ+lKqSDRT5CQbKb3q7cNKy6dKm4IUwfcB8mbdY7F12Yx?=
 =?us-ascii?Q?ZjvAcnrVpQxsfsKVtEyCjiGo+Dhvb+uHI2IEqJNoq1PKk0OuDdPWkSpwRv+b?=
 =?us-ascii?Q?kXkMDzaAxZwipLRZpNXRbrdfLATHX7YicGyQGy5eI2WUhgq57MgiqhzynP+l?=
 =?us-ascii?Q?3iSqIX52/KC9pU6TqY5aqQOMg7MguvKseJl0upjsmOQnFVxhSw+4ZTq17IZD?=
 =?us-ascii?Q?17Ihzq9wHpG39uohvgn20aHEC6AfibLJTZm++YQFwRiYZpoyyzqQ5buB5lmy?=
 =?us-ascii?Q?0F7QDsnrVxvAnNXuQDRdoElaehAlX1VWDmX1OFoq9mBkyGfsnNgt7HZInl4y?=
 =?us-ascii?Q?M5W2Osk0pY4Pg0YX3Aj1RMa1aFUvk5ISG5dIopQY93c7al/0GFtwhlQz5nIZ?=
 =?us-ascii?Q?eNT7DeBMkFAILRyzRhz7WSWjQxrVo+JL1XqQDarpfy6SZlQjvypbSSaphWkI?=
 =?us-ascii?Q?CdQGMnghn2VmRE08s42Vq/Xj3lYCkZVR1UMCji+tI6f3hvBeKSSSUE79q+TX?=
 =?us-ascii?Q?KHw+Uio4nG361WzftbqzlLepQljQkIA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3967b8-20ee-4c93-517e-08da1305bd36
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 11:00:59.8282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MnBx8cy5giWhjdG7KSP966fA73DkwUXqJ/HexFdqZP08ohDe2ODM3s/KW+LyIDBVbs/3rF1gtfWP7RoJW+9pA3P6IrMmnzXCKVgg3VTpUaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB2025
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_03:2022-03-30,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203310061
X-Proofpoint-ORIG-GUID: _q6dySWNascWOaEZcyv0EnYok2qt8RA_
X-Proofpoint-GUID: _q6dySWNascWOaEZcyv0EnYok2qt8RA_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 10:49:24AM +0000, David Laight wrote:
> From: Dan Carpenter
> > Sent: 31 March 2022 11:40
> > 
> > On Thu, Mar 31, 2022 at 10:29:04AM +0000, David Laight wrote:
> > > From: Alaa Mohamed
> > > > Sent: 31 March 2022 11:19
> > > >
> > > > Fix Duplication of Side Effects for GDM_TTY_READY(gdm) macro
> > > > reported by checkpatch
> > > > "CHECK: Macro argument reuse 'gdm' - possible side-effects?"
> > > >
> > > > Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
> > > > ---
> > > >  drivers/staging/gdm724x/gdm_tty.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
> > > > index 04df6f9f5403..6f0274470e69 100644
> > > > --- a/drivers/staging/gdm724x/gdm_tty.c
> > > > +++ b/drivers/staging/gdm724x/gdm_tty.c
> > > > @@ -27,7 +27,9 @@
> > > >
> > > >  #define MUX_TX_MAX_SIZE 2048
> > > >
> > > > -#define GDM_TTY_READY(gdm) (gdm && gdm->tty_dev && gdm->port.count)
> > > > +#define GDM_TTY_READY(_gdm) \
> > > > +	({ typeof(_gdm) (gdm) = (_gdm); \
> > > > +	(gdm && gdm->tty_dev && gdm->port.count); })
> > >
> > > Did you test this?
> > >
> > > see https://godbolt.org/z/cazPrrzPv
> > >
> > 
> > I don't understand the link.  The patch should work as far as I can see.
> 
> If you call GDM_TTY_READY(gdm) the first line ends up as:
> 	struct xxx *gdm = gdm;
> which shadows the parameter.
> There's probably a warning about an uninitialised variable as well.

Oh yeah.  You're right.  But you won't get any variable uninitialized
warnings because int foo = foo; was the traditional way to silence GCC's
uninitialized variable warnings.

Smatch copied the GCC code.  There are some static checkers which might
complain.  Sparse used to have a warning about shadow variables but it
didn't trigger on this code.  Not sure why.

regards,
dan carpenter

