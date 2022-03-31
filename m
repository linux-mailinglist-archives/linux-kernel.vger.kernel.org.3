Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3694ED7DE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 12:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbiCaKmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 06:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiCaKma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 06:42:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D94E1B9FFC
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 03:40:42 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22V8lOnG030433;
        Thu, 31 Mar 2022 10:40:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=iU/8WI27d+FGehMF7egr669BRUoFu5789BKeccDcNt4=;
 b=UTCdBUwfcTqbUDxqfUsS99u7kkSjogK6jdkOtg5Xy5HIl9zo7kTEBWA0/TIUARj7A/Ml
 kkX8t6bHlMwiqZqWgmgNWHZ8pWz+pGutLeOuUAK1p8BS2oz/FdOLoLEDNZyp/twjAyCC
 +KA70HhMSFyqmuQQoBDudOSoYSRyat5Q6rpT8aR8SguQJaz25QCVhM1QswMKPRyCSH8q
 +qf7/wjHwLXuGGclwDGM9bNYpqqwA+S1zwjoAai68P3aHHeONEhayzX1GnWswwgxms3f
 OS3QqZTLYGIai1/Y2kovwfG7vIW2CmBePTs30IlZ2fTOaCHOWSFdlYQQh8Rs4MTDCj3V 2Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1se0m08b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 10:40:34 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VAVKcO009525;
        Thu, 31 Mar 2022 10:40:34 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s94mrg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 10:40:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ceauAF/arQBiTwPBWcGv5yVhd5IP5USKWonfGXGvmKonmhmkY/3qo1MVhd1OjWvNtZ+GzJP6IZ5a/vk/Up3tZ5xa8TN/tySNV7hL01Zj0NAifecsjinJlHMyH1qRjWqVoueldwEVwEctvzh+D9KchUlcreuweMtEvOvkJ2ZDXNyV7tnlLrcMGY2h4YZVyccw0jstc0qhWzXwLqQSdeoPJsG2ma627u+s4O+3kveY/jWDDTW/4MtCoiQei+e/1fkJV6aRnL9hcBe5TpmCwQwH9bsIh1R5lqEl2nuaUDMz76m2KLN/jGafadKKnk8HJrQx7f38axk4t7A/goPVvUGFpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iU/8WI27d+FGehMF7egr669BRUoFu5789BKeccDcNt4=;
 b=dj2GbRX4zxSAaSj3ffTecySekSAzlF5Mt1roqTdZkq92pAFuEDImuS1S+7QEeBJK6eOUs81XGKbK2XSinLkuQmQTgUjICFGR3E5gVgv5QBa/yMmR0RToJeQxnOkr3szdnxnX8tDQDhj1OrmKdMdhSGqrQnpPrYh8KaL5V534OAMUXYj/IP1Y/ulNPhAwkCLtW5mV8OuPq5ksG0QqWECqQSst85eqru/ISPO7zGRGnoBCy8FYkMZauYYAcWtEyu6IrkQhfTASwqKdj8KtrWI3iIJxYMIU4Em4TlRf7SBxws2hz5gVhgGJjUaoj+oAr/dspNtctoxQvtn6GzdLZTMUqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iU/8WI27d+FGehMF7egr669BRUoFu5789BKeccDcNt4=;
 b=yY7wguvvPdVJX3Ghz8YRDRoUn7uIXmYOUXnleZe8ErzYU6gJHjPayXkgGJqj2wlWoa5D5EwbK+Q9QCSm8NZ+8BlD+SHHs1MM+1UyJNlXWWaa6R77nusv3xmkJa/4OtsHb6dVR3KaDqFSz03GPfgH/nFKBZ+hl90sg9MdAB7JKeg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB5042.namprd10.prod.outlook.com
 (2603:10b6:208:30c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 10:40:32 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Thu, 31 Mar 2022
 10:40:32 +0000
Date:   Thu, 31 Mar 2022 13:40:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Alaa Mohamed' <eng.alaamohamedsoliman.am@gmail.com>,
        "outreachy@lists.linux.dev" <outreachy@lists.linux.dev>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: gdm724x: Fix Duplication of Side Effects
Message-ID: <20220331104012.GM3293@kadam>
References: <20220331101849.71046-1-eng.alaamohamedsoliman.am@gmail.com>
 <ebbc4a14c30f492f8553e6ef572bbcbe@AcuMS.aculab.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebbc4a14c30f492f8553e6ef572bbcbe@AcuMS.aculab.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0026.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::14)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b0bc071-eac4-4353-6b27-08da1302e134
X-MS-TrafficTypeDiagnostic: BLAPR10MB5042:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB50429899732787F8B53A49C98EE19@BLAPR10MB5042.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7RApBep/xvqHyjdtBNAAEMb5wHpLiymPWQ0vEcgca4QZJX2h1ndISJgadchdPIdJguh4PFVlaA4DQUWb4NXsLbXAe2IAC9GL/x8mdTZJxj8ETccDa90I6FF4LsL9PBouiEPP0UktudUdTcCOkY1lBWOAB941a1qlrtePesq6R9lv1D8QuxulMilzsD9sZACU5tcAWQeAV71/CIM8S3eIK4Ajf1XLtmQ1RVMK+YDZ3Auqunm5QslydHYJRm1TSl2dK1O7XSr5CsFSQiPCDQ4uAuzpF1t9jVlz5DENBn3JU3S99GGvkmyMtom3Z2rZ/2NR/B3w+GIwhh9zMCNwnwJdKaFM49Osb3p9tjg3i+JPRTeSJ5HyZLc3hU/6FsLLEyxpZUYlVxx16NC7rGu9aB3GnIyazvSiSckABA27EE94JJqHEnwUekiv7lVbjkeh22/NiziquU1DgW+4d6BoSgRfivEGmPmoqiZ+fELvzCXbljPaPGBDC+NFKJTvdIzYFzAlRL/7VHmraQ4KfRWrk6cx/AvmNGZ6BH3RiMPrfHDihDyUMTxdJtKEnVyeqZIwy0z3ZOpwuyIe3OJeNyNsaFSF4NpD/dEuuYiLX2U0xoRDvGleSBu2Gha6aQB9iSkZhTKxauN4l9MgJy1wwuuUgwmh5RH40tdQBF8iFbFIA1Xs6pqN1X6wAF3wvcB8N8zISZsRhu7Z6SF7h553evdmQnIz0ba5kqiFm4YkV7FT/LrM86dpLZJvQgDrMg/hDRSEwO1LMJAxQJr/tWFr2XvofH0aBthluCArTANFpsMik0xgShlo1vsTKnn3kqE63nkpqRv5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66476007)(2906002)(66946007)(44832011)(8936002)(66556008)(966005)(508600001)(38350700002)(38100700002)(33716001)(54906003)(316002)(6916009)(6486002)(52116002)(9686003)(86362001)(186003)(26005)(1076003)(6506007)(6666004)(6512007)(33656002)(4326008)(83380400001)(8676002)(5660300002)(56340200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FZxdK7BtJL6ix3nvROCQ3bCdBbvO8n5LGqE/d5ICk9M52tlmndDyE8NGlXPF?=
 =?us-ascii?Q?XZO3sK1bHDu920pfX8GppvJUh3xwY8nUjCBybL6DVBWfYqtbwhoIkP99SWH7?=
 =?us-ascii?Q?xKVot7Eh9Yz+CzKoWHmXnPjIroOHH6Nmocg+oAOiXMJ/g26NUnDqQUOAE8vn?=
 =?us-ascii?Q?KOq3GnzCeILfc3Ns5wxEdzNJnuH3V2TTJFH+K9BjAIJgvDg5Lh+DW10gI8zo?=
 =?us-ascii?Q?NtNneuh6/F1uloJSC86q6nvvlbpD76EHbTrioiHt4KRc6VCzP3nfbV1BF9hP?=
 =?us-ascii?Q?W5PZ/wTf1y/YXLXY0v0pruaPkATl5kvAhzonNdjuKbSQ89eqERMUY2+8rVEJ?=
 =?us-ascii?Q?3JZKbu1MD0T16E3pUh0ZHVhEufR1Nd5jOBh+bHM/o83xvVHQ95ZQWzIKfOc7?=
 =?us-ascii?Q?yGH4ac3//LAlMgmXsjbU5q502q+YQ86kqXAGDJwdfpiLRwxFjdJhfgv7fZyQ?=
 =?us-ascii?Q?pQvtLhJ+6p3rmtLAYqR4B/DS+U2+qibrcMPt2BDU6w1C0GtOjT45sJPPzioA?=
 =?us-ascii?Q?+XsuHccfvphPWAhq073GJEn5GSkTiHXBntVPXhbblJIHq9xxUpZfodEc57Yj?=
 =?us-ascii?Q?fM+27ngTgVlc+WeaoC+wJgLkc/DVgzHfMBFvWlu/X8mygsMRJKT8frtDTG9Z?=
 =?us-ascii?Q?r1KnEfHj9J0e1M3E2d4GHR4uJ7/RAAkZVbaPX2sDztVbDiGogtD3XpCUFVtu?=
 =?us-ascii?Q?jCnK7Ke7ANCk2B3iXsPdEwWjPgBIfq/HrNo9/E0v75JWa67r49mCQI9LduGW?=
 =?us-ascii?Q?y2Y/Q+QGvZ05WYEn9u1GfJ1k4LytZhd2ctWICIk5VL41yFNE8HTuuHS4i0CI?=
 =?us-ascii?Q?4rl1iAQDTN5Cosj0sucAta9ywDG9De16FkcWqbZPL2Zk9PwGOHKN2qQLHHcB?=
 =?us-ascii?Q?aGyPQPJwxfbY0K6bxdcNZfzqP9YrMvwpIStMSraubM1wHkcBSuzUT1v6CH2e?=
 =?us-ascii?Q?m47WHBwlsgpRqJC8OHz4qZ1guejKOYx0Is9/+CtDadwpF+GiALBFDnpbqKok?=
 =?us-ascii?Q?MRWo7YHFuezaq2RFnKpkz/sMA4MAsaD4HDrgK78q3X9JduLSiJYEVpYG3n97?=
 =?us-ascii?Q?RW7WrQJYCMce7OhHe0Oolzi1meYQTTkUPODEWQOilCaB07d7+c7Cpm8eXUEq?=
 =?us-ascii?Q?euOfmQzN+zQT7KMOpKLoq1pOqyl2if731+0JbQiZawQ3u54FOR4j8Y8nZorV?=
 =?us-ascii?Q?+WpJi/s5ZM9D4U1vjXr1j6Owb6VujHFUJqyFhWImYXbOPh3hYkLiB21M2uDn?=
 =?us-ascii?Q?OFyT0CxZDm25LZEUtPK4v3rgtr87MT2EOSiB4zsRbgLZkJVeH/4G6V9neOj+?=
 =?us-ascii?Q?QVXxRr+FNzpy9jSeRSzrRBjP26CH17/5H19mG15yXWkoPq9HIxgapEblnvuD?=
 =?us-ascii?Q?7PpturPe2nuFCt6IF8x7RPKxJu3etlwPfIX3QavzvuL/P0U2ghAWwgsyYhdH?=
 =?us-ascii?Q?qqSqZZYY7qRY5gdjxSCU95RVeZEluN2PtXlQ7JVTpiUj0lazISdq9xCzFCDP?=
 =?us-ascii?Q?ZEwr+X5Qpfam0uMtWk8nYjlS/g8lT5SONAqEKCc83kMOex88b8EEvbsZkXbF?=
 =?us-ascii?Q?qkZNf7gs5K98r1kNO1MynOxeqKUUkvUX+5ckOvUyKFoQwpHNHY+F2AGmgIXR?=
 =?us-ascii?Q?2CTHldPeBNpDCaDUkFBYNer8bNQUA1sSM9nkx4IBDsuR0PpBI34gZR5Sl2/e?=
 =?us-ascii?Q?1Nhyx3G0rms+hwbMwbDDzwJzJ/G4yUBXdCE+nmUv+T/z48iuv7P2dOgPIqh+?=
 =?us-ascii?Q?lMZH31pIscp0Cj7yfhwhRGyKxG+MXHs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0bc071-eac4-4353-6b27-08da1302e134
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 10:40:32.0829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HAMuDSnAsVqu51ze9Obzjq8PGkqUd6Vf1MxL276NPj1QJ+TTWCBj1wzeZ/6xMCGFwz3IR+NP3THRSx6XP+hkyAOqBYS9tOheegzpdFYhxj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5042
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_03:2022-03-30,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203310058
X-Proofpoint-ORIG-GUID: G8AXzcOZekZlHTJvks1SBSG1z7tuaeRe
X-Proofpoint-GUID: G8AXzcOZekZlHTJvks1SBSG1z7tuaeRe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 10:29:04AM +0000, David Laight wrote:
> From: Alaa Mohamed
> > Sent: 31 March 2022 11:19
> > 
> > Fix Duplication of Side Effects for GDM_TTY_READY(gdm) macro
> > reported by checkpatch
> > "CHECK: Macro argument reuse 'gdm' - possible side-effects?"
> > 
> > Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
> > ---
> >  drivers/staging/gdm724x/gdm_tty.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
> > index 04df6f9f5403..6f0274470e69 100644
> > --- a/drivers/staging/gdm724x/gdm_tty.c
> > +++ b/drivers/staging/gdm724x/gdm_tty.c
> > @@ -27,7 +27,9 @@
> > 
> >  #define MUX_TX_MAX_SIZE 2048
> > 
> > -#define GDM_TTY_READY(gdm) (gdm && gdm->tty_dev && gdm->port.count)
> > +#define GDM_TTY_READY(_gdm) \
> > +	({ typeof(_gdm) (gdm) = (_gdm); \
> > +	(gdm && gdm->tty_dev && gdm->port.count); })
> 
> Did you test this?
> 
> see https://godbolt.org/z/cazPrrzPv
> 

I don't understand the link.  The patch should work as far as I can see.

regards,
dan carpenter

