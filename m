Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5FF4FCE79
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 07:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347533AbiDLFJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 01:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiDLFJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 01:09:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67041205FB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 22:07:07 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23C1TOXV012784;
        Tue, 12 Apr 2022 05:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=JAdAYvaxTwZy7BjMYnZ01Ukd85xP8zzhpOfwnHPsA18=;
 b=mT2CoyOQdafIRGM2thRRWf03KJN/foGsyYHXNzIE3V+3jfQ2u0UjEsAni3DExEj0aptZ
 VIGYSsir8DRyuSvJVGQMeCNR3/I/MMIIiqGVrOfcmGtsfH5b6QbD7C64bmodxDjOdcQu
 ZW317wlSeNYSlT/Szbg3zEzCleEYC1D1gDUnIUGNcAnG6hgfB6K9GHztR05h286blXoe
 +WBbKedk/Mmc/tSZOT0fRKiEG+EnbjJ4lts3UOU7/5u/mfICAHFamtM8tRiw6GXw/XQf
 zqnSAwUOqt23AHhh8lqf02nswft5pDOD8tYsHBrKcSMwS25ASC9Tb9sU2JGlavYBohud EQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb2ptwnc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 05:06:57 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23C52Og4010221;
        Tue, 12 Apr 2022 05:06:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fck1299gx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 05:06:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtyN+7O5cixE6g150oe56MLS8wZKxU8jHD+OnXh/O3IfEp/qEaoTPq8xk14maOJ6VBzgZo8Zad/Ho7GkVc7XWenYyYWIshggFWNubHEWCYgeB24PkeQpo66Yd+r73e5xs2/+Q7mIZLuPEcE+TXgtbrU0uwue6zreRZFnbFwCaey8wBiu1+qOtVnZWLDOn8T7pTAnxrl1W6cq0t1+pFRlqRxFNwGTUYpg6DojN5w0935uHVdDm2nkltCmKWMh1wtm4qYu+LfYDcktfkHgeQl1I8l0acSRQXvzhSth1KgQvss+PM8SRL0kpUINrVwKua0pqM94NLmXDzffii4GNr9Sdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIes5BwidSFvD+/y+GPtBZcNHKH5Ax18Q1eOykL2tys=;
 b=nfbDQwbVei1bcLO0Eef0HxL0uHt/cQW0Vt3WjDG84mDdWafWYEeLaNIKocUn91KevxUkmwvgq1a/kVZqUXuZd3BlHMJu/zzOgrETpu2ZZ8SKXmTF8dDJrJsKEDJ/E/P3qvUI2uxCsqCno/gP/R2UnHpP7aZJ+F/I5MdlkmxxzY/AapRHnGSgHT5XppYD2ktlNCnJKIHuzXii0Lmi/3/lsD+8Sp5HzATJoKdfeKP1MeD6b+6TER+REBqxQVSsGvXLwTdYkxo5necE0nB8ZPQUHA3osmrircYyGpu6/oF/imef/ezb74fYIq3zKyWAsBD4Hi3+qceYxLZhcnAx1+p7GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIes5BwidSFvD+/y+GPtBZcNHKH5Ax18Q1eOykL2tys=;
 b=sVVHnB6Bvgxx02bUqIzu7aRDMZIG9fGobEGUXZDiMXlsUpUzqlgnmD2J9pZb15IWcjswTye/Exh60KmJH6lGMuT1KUyRf1TMV/u65vagXME8Z/bFjRCJu/duCww16FA5s8uYuwfo3PuXsGVGSyMZex+PT8gpRT+4PFfugcQ0E3E=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB5742.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 05:06:54 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Tue, 12 Apr 2022
 05:06:54 +0000
Date:   Tue, 12 Apr 2022 08:06:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH v2 0/7] drop some unnecessary wrappers
Message-ID: <20220412050630.GY3293@kadam>
References: <20220411102136.14937-1-makvihas@gmail.com>
 <37499399.10thIPus4b@leap>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37499399.10thIPus4b@leap>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0002.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::7)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e143e56c-a822-4b73-39d4-08da1c4242cd
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5742:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB57423CB632EE818CF1C5E4118EED9@SJ0PR10MB5742.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sIHL0RopPL0yB86FwtRJiwOyjs+W6IppYhQENePl47s+rAvDmCFmaKtIh3Kv+syxj/3kstNXd1BddD/5VCp+jeDSCdFyT4x8at6Oj3Wa8rgSXRdcDuzutJRiyfnURkl+2pGmNSQ0e77Vd987vU+8uoPr2AqsSws7Ra0P4FHCyfM8xe62NkYFhcrPucHtEDQQVNo3ikvd86zA+TiYdStEMq0WWneCTvdo88Lf3E+kJBvh5mtQU8g2KfENaYRSIAvQw3hnS2UyBYkM6A1UdiEVbh7EEfcUVox/hnz3zvWw3dHjAj3VAgH07GE+yCsQTEktuAjzxr2YaJy8dbCLaQUyntca0AUQnB8iEtY+olmftnkPcC244qZjdQjid66zpQ/ZuXy5jFXmIMlAE5fUqQrjYQ+dyyVv/nDvXcvsASeva94G1RhSTNljaWn0i6grnIoZePGwMGvwuhCoDrRpIFTGuhRD4o31plV4+SYOgpU3+WWcbkc9dD/434Qlq+2VeKMKUWTvBURraa8Xm0/VqAbGJl7puLbSqr0joFT32zYSD8Nmq9HCaea2OzTy8g/SWJcsd5F7hdwZKQxvRzZGHr1+o+aVO/ZlYL7SOi7arPcYduGJsPzJF+7sZJODX3KPu0Hxrg1s80o0J9BLo0F6YcmCmxwgSxFGyaIAdDVQVEFy1GXQoJIfdF+CMTYeZwDkP9wFNiutg3/iQqEIjrHNNYNkQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(54906003)(6916009)(9686003)(6486002)(508600001)(6666004)(4326008)(66476007)(8676002)(66946007)(66556008)(316002)(86362001)(5660300002)(83380400001)(6506007)(33656002)(52116002)(44832011)(2906002)(1076003)(8936002)(33716001)(38100700002)(38350700002)(186003)(26005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?QYnB7fy7kZ1urDzSiAQIrKdDQLCJYIYeJa/+MEHh11kEoFRkXxwNWfdGtT?=
 =?iso-8859-1?Q?NdU2JwEtM8NCW8iOaxRFCJwxBIkC+uuoB3gxSzZHB8WVAioOOTlMezVTsa?=
 =?iso-8859-1?Q?uuVKszh9bcA6TiyGkJngEfGrAqCIuC70yM7X1p69m9HvdRsW5hwyR7LzFh?=
 =?iso-8859-1?Q?OulfOh3/vrmmLrnB4/z+445QKrSveHdaE3xEdbVf1OXwSE12jYzhF0G5Ne?=
 =?iso-8859-1?Q?CuLHLRhrjHZRCcsUZGMf9CBR34Vk7jlS6bCNczD1+hmBX5tw11xODsw4R6?=
 =?iso-8859-1?Q?2c9Sisl3sGu28f6Fq+i7IkZjwThc11dkpC7w6zENpL6u3dA3UC6X3Y3tLS?=
 =?iso-8859-1?Q?TJFjdIl+bkJ0QU3M+PgPhfiRLb5tJOXtNXrvc28u6yi1Ky427iU/HSDP/u?=
 =?iso-8859-1?Q?z87kFxDAhb4OHyUcN7xAebVUrVIaxThMwJFGuJHmY2BhfZBWMrtMJ49fyv?=
 =?iso-8859-1?Q?irZYu2Km9Pk0pHjy1QOyb1vQ9aT5SIQlRjAqjKNYqgcqo081I/gA2ewkry?=
 =?iso-8859-1?Q?Q27Gkt3tBs3zfZVK9IhExZL9oFzjhQdI3yCHXJ/b0da76HHVihp7+AljCR?=
 =?iso-8859-1?Q?P0DFyjqiP0ckbq25fgyu/peo0Zx1kq1lIWNxYwddF1BNZOAN7SpB9h4MjI?=
 =?iso-8859-1?Q?nzIl+0B8qqW3xQ6C6lPsNxs6Hfz03aL2t3tYpV5MiU+5QLNk/RkYZQ4iT5?=
 =?iso-8859-1?Q?G2ALcH0zLB6Bep9itrMkBRKXiCraMaLaiUuCfr4R46bRG0A6zGSsVa5V6T?=
 =?iso-8859-1?Q?DGOySGTnQ+F6hSj1ZjcKZVgwlC/1HYh53mjiraScvijQN6yT25aaEKzcYQ?=
 =?iso-8859-1?Q?DZ2UCjMMfx1bAB5K/9ofjKyW9PPollUI5mfC2qsekbCqQM/bXuO2IZZrcc?=
 =?iso-8859-1?Q?uQn24mBZi7tpLYnyfDy1dcBNRUB8eHJu8rsh1Q5jp1lwowDR6Faej/gk1A?=
 =?iso-8859-1?Q?zTiN1GVXYc3irGfy1ZL8a8W1x33aC8+OkPW63QMMxMYR+v0b0wd3eLU1Ix?=
 =?iso-8859-1?Q?0ErCApvUR43GJggPPX7ftS3byp/5+hnXE4ptmM/j1pAmjyJprSx5cd1Z8p?=
 =?iso-8859-1?Q?ZI3ibOrgEIgJCY5Onhl+tsNrtptrt63ivDVNM4QloMmiM6dniSeAm+8MXT?=
 =?iso-8859-1?Q?oAX/HUWzergWDnl8N3DSoAb/VylYvJKH/WB4xbWzvo6o71n1Z4Evd7dLLp?=
 =?iso-8859-1?Q?0zx+xo2lycT0bRRDdqJFTvZNeczD28V+ILe4IUi9gDNeJqa80oCSxSranj?=
 =?iso-8859-1?Q?c6DIZYBhxnlc4+xLACvjY447EPw1dEBGQd0BCuTYba4ojaGFGUROVcF6Ay?=
 =?iso-8859-1?Q?awy3xGKNyItjZJuzZNfQP/1ZFkQ+z6tICvILYEzG4Qrv/jhpvtFEkV6d17?=
 =?iso-8859-1?Q?46EOjD0MDd+VGdZGbE2WgP/K6TljBYYxS0eWaOMv0RvwysTalvdBeO4e1e?=
 =?iso-8859-1?Q?lx7uNYaQAyWJx85NVCknfAivXlvnJscPcp5+snioWHFGpfjCLO2Op8sDc8?=
 =?iso-8859-1?Q?R6FHwiqmeobpZ4RFDU8uVxr1AXY0/pyO1xnk/AHCjg+YQL/EY13giqBD4i?=
 =?iso-8859-1?Q?HngvOqWWyIxA25Bm8jpazPfHN8aDpDpyGwFHgz5oM5/o9nBuzPFm3pHwYS?=
 =?iso-8859-1?Q?4dXD5jEULzV2nBXeCEAg3iDsMkGXgTBG/CaxbNjqcxus6TmWKulX8HPnjX?=
 =?iso-8859-1?Q?9P73oli5moSOgwQLkH1/kmVcoDSGQ7uFx0/ifBdDI8z+38DgQULUrYwRJx?=
 =?iso-8859-1?Q?ey8Vg72PRyM/+j4Bzbe/zFYJILdstOnOCU9q/EiHV+JfAvV+bdjR93lC2G?=
 =?iso-8859-1?Q?JBOkxuW3rCyrbddbyTziXPh44mpKaaw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e143e56c-a822-4b73-39d4-08da1c4242cd
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 05:06:54.3323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CpL3A68irj8FHtBugJM+5F6Z3GWK3P7Eed2CdATy5s/RD/VNBZ+5OvT4uX0K0FAYkdvgtTGDOdNaJp+GUgH64+veAnxAL4MK0pOR9PCnC90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5742
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-12_01:2022-04-11,2022-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=812
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204120022
X-Proofpoint-ORIG-GUID: wbVdRRe6lAOuwQIgP4Gd8qVe10-YHY2c
X-Proofpoint-GUID: wbVdRRe6lAOuwQIgP4Gd8qVe10-YHY2c
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 10:34:44PM +0200, Fabio M. De Francesco wrote:
> On lunedì 11 aprile 2022 12:21:29 CEST Vihas Makwana wrote:
> > Drop some unnecessary wrappers and update all the references
> > accordingly.
> > Tested on Comfast CF-WU810N RTL8188EUS wireless adapter.
> > 
> > v1 -> v2:
> > Drop the wrapper functions with underscores prefixed.
> > 
> > Vihas Makwana (7):
> >   staging: r8188eu: drop unnecessary wrapper _rtw_free_cmd_priv
> >   staging: r8188eu: drop unnecessary wrapper _rtw_init_cmd_priv
> >   staging: r8188eu: drop unnecessary wrapper _rtw_init_evt_priv
> >   staging: r8188eu: drop unnecessary wrapper _rtw_init_mlme_priv
> >   staging: r8188eu: drop unnecessary wrapper _rtw_free_mlme_priv
> >   staging: r8188eu: drop unnecessary wrapper _rtw_alloc_network
> >   staging: r8188eu: drop unnecessary wrapper _rtw_dequeue_cmd
> > 
> >  drivers/staging/r8188eu/core/rtw_cmd.c     | 145 +++++++----------
> >  drivers/staging/r8188eu/core/rtw_mlme.c    | 179 +++++++++------------
> >  drivers/staging/r8188eu/include/rtw_mlme.h |   4 +-
> >  3 files changed, 135 insertions(+), 193 deletions(-)
> > 
> > -- 
> > 2.30.2
> > 
> Formally, you are removing the wrapped functions (or helpers, if you 
> prefer) by moving their code into the wrappers. To say that you are 
> removing the wrappers is not correct.

I once had someone make me re-write a commit message four time just as a
kind of bullying and then at the end he was like, "You said NULL
dereference instead of NULL pointer dereference so I had to re-write the
commit message and I added some comment to the kernel git log explaining
how you suck."  So these days I have made it a rule that if you're going
to complain about commit messages then you have to write your own for
people to cut and paste.  Otherwise people are like, "You're too stupid
to read my mind.  LOL.  Do it again."

But in this case the commit message is fine.  The key things with a
commit message are:

1) What's the motivation
2) What's the effect for the user
3) Are all the surprising aspects are explained.  Do I have enough
   information to review it quickly.

Removing wrappers is the motivation.  No need to explain that further.
No effects for the user.
There were no surprising bits.

It's fine.

regards,
dan carpenter

