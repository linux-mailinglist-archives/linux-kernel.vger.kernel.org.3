Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1C25027C7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 11:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347786AbiDOKAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 06:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351950AbiDOKAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 06:00:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AAFBB0AB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 02:57:53 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23F53Ipk003034;
        Fri, 15 Apr 2022 09:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=DJJVMoBTq5pWArJSMgVs/pNWQUi6+IXOH9jDtWhipOI=;
 b=s5UIqm8eEUdIDAVtwP7K68cxCBthYdc1HaJeumAlv8aiDeDYAIqQWDvlekW+H1dYcirK
 CndDidEx2kJp3WHxwgTnbp2A6V5Mvslh/Fh+jL5Dxh3ivZ++DD/CY48H2N6EMViSVfxK
 J8LjhacwqEeY4OqpC2TSaNxN0LQo52avTNhOfmSdinH9TTRcJxW/xrY9lSJjBBLJNuum
 b6hhE8AVt/nFDI+8TR7rmOLJMRFzKf8aDVaAj1+KeJNN9SgCKaXZE/CyeMtw2Yrww021
 vKc07QDte7xb0nl1uwt68NSwSIWzDW3xCdGupYl+TCntIymhABMszfU+DrXWspqKWehN 9w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0x2pwdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 09:57:46 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23F9pRup021772;
        Fri, 15 Apr 2022 09:57:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k5kbt9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 09:57:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkwO9Gqng6anNDRJCQGJmmohAVAAqn67DLANjFWBiZzlukVW5UsNEGI7HgYqGp4IhUjUwMt4CC1GNuSMXLkUWl9Kdw9KtLgnT0Yk/vsYQQ2Srb9SGoibMjLYHHTPpT0X/zVD/Tbfpxo0K78ayOQe5fWc5CQMm+otIlbGb2gvSbHJyMqeKmib8hIVYSD6S/Bf6PDCDoXyFqG5Dc2cEnKdu0zySyhjau4IvRzkqat+1hy5huMWzcHghhLdc7c4kMECG3BHlDKC2qwsfzFsj7VhICscT+cOKrEWZmivNtq8vtwlPwJXWGBDVAbcVvuFtTkawPQlndiWDqnYjU9DvRFHbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJJVMoBTq5pWArJSMgVs/pNWQUi6+IXOH9jDtWhipOI=;
 b=bbEIE3kFcdIkcORJP423v2AxvbblrguOLwyPNgBzQJ44Qn/tJ9h7/N4f30rdTgvPx87jlVdLhh+1V9qfhJrZRg67PnXZJbf6ofxGhJk82UA7WkErZh+5L4IJ6VmhYHNDCxEAsC7PNQvPkV7IZHwPax+rKYJFdG/Bs2AByylvKiHq1w7HIKTEJzRR18ke2geB+F7eqFVmvKEjQxHYL+BryMb7txwaWog7jYeE+zm/eDAlgBtM63m3AIEPnM7bIaBtiBLKLffSX70wHjGdyZfrc/kW9rO7yALMVV5XOdVsVXEOuKRypg/VNeSfO95YmsSEsUBN4fCJ1NWo9GpG22yXjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJJVMoBTq5pWArJSMgVs/pNWQUi6+IXOH9jDtWhipOI=;
 b=yRfSqySLrS5oI34JeT4Vqm5l5SEUrHGDcViTuNZqZVkIbAImmzjR7T77MWMg524bRaKQSM9+bFWpp9JwYCQxk0jDWaEs7FfxbfF1bgB0QKEEKuBl0zHLakE8Bnkvug6jG6v+SA1FoqRNv+9+rSWILIQWKW6dEfNrpwka0juSexc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB5418.namprd10.prod.outlook.com
 (2603:10b6:510:e5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Fri, 15 Apr
 2022 09:57:43 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Fri, 15 Apr 2022
 09:57:43 +0000
Date:   Fri, 15 Apr 2022 12:57:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Wang Cheng <wanngchenng@gmail.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: fix uninit-value "data" and "mac"
Message-ID: <20220415095721.GR3293@kadam>
References: <20220414141223.qwiznrwgjyywngfg@ppc.localdomain>
 <20220414154215.GL3293@kadam>
 <20220415094705.aibh3jr4wzhddmud@ppc.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415094705.aibh3jr4wzhddmud@ppc.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0013.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::25)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20dce9b7-4e4a-4d04-f757-08da1ec66216
X-MS-TrafficTypeDiagnostic: PH0PR10MB5418:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB5418DF6DC6385F5D16C6674B8EEE9@PH0PR10MB5418.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d5vmjRIWGgrX+PxLAnVbUyzD04pUirieD4RTut1VoerqIkP8bdYu2taB/y9rYu/jhclxZkw852SHrOJzgp151mGKDyAQnjepB6DKDK2k+gBw+Kd0TGLfBHhUz40D2cbXGlOFYz3i5Db7SsL/hkqNajP7slwaOefXFrhQTVq1pFnxVmnSkFO3EueG1lnvwUBs7fZR04h5VXq8zfekG/FjWiJVfCdejsKBcxGDXwRSBzzcgnOZM7r/51XE0lVMFF+217f2lvD67cArd5DypzQ91eCXD36gqdguUWGuLFlnzeo6gAOLnNm2xLoykn6I8tXGhskmoqpm0a89xlg6Ef4Z9tLKxvzpAlzpBcrevYKHMz7gALo7ZGp8RPW/lfSTYpwsdUo9HFg9M5typJ/ZLb2+rHxoUABOuVzlG8XnCxEv/LacPrGw1e1aEuTEY36puM29d1nXrtknSAO6YsnKXVRBSfmhy/HDgspNomvL33cV8v+rugHE8G6C8VM3M2wOCUD5+f7w0NrpXwjHuo0rBs1+9mEEO4JPc2nAsKBdHSYCreitM1RwpN79zuIPcCipXww7WxtqNpragSGHIqGSAehVEgAdZ98FEdT2ObPXOZQIpa3S8pjRG2P+cNKYPgM/TnMQdaD3/OKjFz6Gdo64qiprYS6M2tGpcagsvBAQ3uj0p/cTFEt9l0280PSzIwWFbJNAbYBArGdZN2k157DgceK3Vf1N9uAdOb4yG3nyzryKQeRh718EAL7e2IYkjiX6I50dTZoq5hRKJzj0HxLNxCBIUEHz2s7c7imw6bm7IpYXcMt8nctKm2+1FQZ4ze1ElYykaXV9zGNVrN5k5E1IrpQK1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(6506007)(6486002)(86362001)(33656002)(966005)(1076003)(316002)(6666004)(83380400001)(44832011)(186003)(26005)(38350700002)(38100700002)(5660300002)(4326008)(8936002)(508600001)(66946007)(9686003)(66556008)(6512007)(66476007)(52116002)(6916009)(33716001)(8676002)(334744004)(99710200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?db+khoLGwIZjwkrJoSn4EDVQEFEZvg3ySuQwXABUD/V4Aelvb3s9/ESWruoY?=
 =?us-ascii?Q?SSjoAi0YNO8WTqoX4lxIvtPT+YcUOLhFzMERTiA0ns23dt5R2MEEc5GqUjQK?=
 =?us-ascii?Q?VdXR7sc4t1h+FKAjeU/a1YcD9gK6cckCDPefrzPTXAlDsZhoJE0r4cJWKxPG?=
 =?us-ascii?Q?BdxckILz2tJtCt6TWEGMG8S/FicMGOHlYhB15w7BzU873yAhWuQSLj4DJ65u?=
 =?us-ascii?Q?mPQp5KsR0KqVu57J833TJML36TLeU1HzRSrs0Q/uf9i31chrPIPr2GUHlgTP?=
 =?us-ascii?Q?1GI8FAT1qc6PBmpQJSecmMlG0pYR0TLx163Dcp3kSh5XNlj5MxpX6tvM8AvM?=
 =?us-ascii?Q?bGbd0r6h+0/iUK8Ae8R/K+yLwcaXdgKpFLU/3Fb2a1bM5QqXbQHWlTyMyr9S?=
 =?us-ascii?Q?JYncpG7IkEfnojnpC5HePYo+i+KEbeo0YKsOw9EJNoFBZ60AHNyIqHVCGqhQ?=
 =?us-ascii?Q?mCE7H3wlFajaFOCcB/SbLmwjbmEKiiUx6zF4qydWkWkyKnL9JXTYPH+XgSbs?=
 =?us-ascii?Q?SLGvbxjOvBWuuJg6IBYvxrt7PIENacOHs5iEaYMW6xRZtIiOFdXPWh5X8zbg?=
 =?us-ascii?Q?7Cg3SwCs8uRtGrbtTU/S1f4r4F4iBQxrapcnbjCD5jj18kck6TQElHIQN4k1?=
 =?us-ascii?Q?R/Cq5qrnZROCEQVFf4h+bY3a4iu6WO2+3+RBJxqzefy2Je8GZ7N91mcHq6yC?=
 =?us-ascii?Q?stgC/zvZZIMYSY/a43JqgXg1JsdDqucYb4/i27o9r+ruHMwDfwLWNexYbUhw?=
 =?us-ascii?Q?ZJvQXS+upVmooxWIvxTWac01SbolmjQbTo9YiplX9Kr+mNpVGL//6EsKsu1O?=
 =?us-ascii?Q?crSkbKu1N/GgwFDv2U63/zYaketjRqS17CCinBfI8CCfhtSDIxZZEkEzP2ku?=
 =?us-ascii?Q?tPmeYnH9MKl8SNYBe3Uf+m7GbwLzUcSxEOM7dkgvJQm3o4OoFPsYWyW/F6Ei?=
 =?us-ascii?Q?Qc+YYtIVN776vBoRUcwM/LDIRbwpVG0g0LXITyDWqIxKiRMUkZ9vXXVNrRKl?=
 =?us-ascii?Q?QFgOpKYHEsxYxTl4esQtw09ZEWi2o+0bW/gIKXaRK+k/Vkn50ht5iKkQQh+N?=
 =?us-ascii?Q?ib0al+wwYJWOpnMnLEIx62ypAKRZ2VWBszFZY1oGyeUZs4m/8xz6suGiXtgu?=
 =?us-ascii?Q?I7c/uqSXk3jgTzBytsGz4c/0T60N75vDmzE0boeSpHsPEff+7JATeQR6z2Z+?=
 =?us-ascii?Q?BkoNJRr/nfgIxGNytwAd7GxLH+P0aC4BAR0tMhk7G1XF9JWJ5qbuOZmNBZg+?=
 =?us-ascii?Q?NZeoCtFQUMiNjMXcqHO+ba5K8swAuvBRqS58c2Ok9PvyLHxiKo9qZtnWBNKw?=
 =?us-ascii?Q?ZbZhinvKgY32yYGrQlOyAjBT6BUPX6OHhOiS81uXE6qbcdzohiMVuoV7SAln?=
 =?us-ascii?Q?VsUvdzA413lp8WWFp4T5WrhByWmJfff+Fo1uMsmVOWfTr48Z6+EQ4IgtfVID?=
 =?us-ascii?Q?wGZwWTYdcHODOPAYe+H4KQk0Zowg9cUb4RUVCu7+z8rIvW4xbNwLbR0zQurJ?=
 =?us-ascii?Q?YeTNp0+qwl7BKNTPYxP0AXlueIEQlpXPWj8ZrRXlL7SKq1+wK6nQe0zg4O5z?=
 =?us-ascii?Q?U3DwTGUbGptq7OJHyKfzZFOSqrMaxxptNudRKS/M2MXAy3uyzJamviXyAnHi?=
 =?us-ascii?Q?Sdc6mFzGis81EaPpyF0K9RxexWWGM93SUIQGk4jO3hL/2VBTU6HN6ihrYm4w?=
 =?us-ascii?Q?wu0Z3CZzVJRhGyTaWy9V464bBhCdIXeAwJCDER5rwgL5BAJWD2fNJTe6nT+G?=
 =?us-ascii?Q?DoXpT5/29C6MWkt2pVlhRUPDc1thhmU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20dce9b7-4e4a-4d04-f757-08da1ec66216
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 09:57:42.9063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bhHVBzv+isvF8s2wjwXfteUCe3pcF/WwncNWvMt6zT5+FtbApuR/BynF7ersYdhHLg/gSstvRQCRYk5hQouyxQmoy2LuDiuxQWlGNKi/+oU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5418
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-15_01:2022-04-14,2022-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204150058
X-Proofpoint-ORIG-GUID: vI7iQ5URih91Tu-hiIeO4DaFocb44kRK
X-Proofpoint-GUID: vI7iQ5URih91Tu-hiIeO4DaFocb44kRK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 05:47:05PM +0800, Wang Cheng wrote:
> Hi Dan, thx for your review.
> 
> On 22/04/14 06:42PM, Dan Carpenter wrote:
> > On Thu, Apr 14, 2022 at 10:12:23PM +0800, Wang Cheng wrote:
> > > Due to the case that "requesttype == 0x01 && status <= 0"
> > > isn't handled in r8712_usbctrl_vendorreq(),
> > > "data" (drivers/staging/rtl8712/usb_ops.c:32)
> > > will be returned without initialization.
> > > 
> > > When "tmpU1b" (drivers/staging/rtl8712/usb_intf.c:395)
> > > is 0, mac[6] (usb_intf.c:394) won't be initialized,
> > > which leads to accessing uninit-value on usb_intf.c:541.
> > 
> > These line numbers are sort of useless because everyone is on a
> > different git hash.
> 
> I will correct this.
> 
> >
> > > 
> > > Reported-and-tested-by: syzbot+6f5ecd144854c0d8580b@syzkaller.appspotmail.com
> > > Signed-off-by: Wang Cheng <wanngchenng@gmail.com>
> > > ---
> > >  drivers/staging/rtl8712/usb_intf.c      |  6 +++---
> > >  drivers/staging/rtl8712/usb_ops_linux.c | 14 ++++++++------
> > >  2 files changed, 11 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
> > > index ee4c61f85a07..50dcd3ecb685 100644
> > > --- a/drivers/staging/rtl8712/usb_intf.c
> > > +++ b/drivers/staging/rtl8712/usb_intf.c
> > > @@ -538,13 +538,13 @@ static int r871xu_drv_init(struct usb_interface *pusb_intf,
> > >  		} else {
> > >  			AutoloadFail = false;
> > >  		}
> > > -		if (((mac[0] == 0xff) && (mac[1] == 0xff) &&
> > > +		if ((!AutoloadFail) ||
> > > +		    ((mac[0] == 0xff) && (mac[1] == 0xff) &&
> > >  		     (mac[2] == 0xff) && (mac[3] == 0xff) &&
> > >  		     (mac[4] == 0xff) && (mac[5] == 0xff)) ||
> > >  		    ((mac[0] == 0x00) && (mac[1] == 0x00) &&
> > >  		     (mac[2] == 0x00) && (mac[3] == 0x00) &&
> > > -		     (mac[4] == 0x00) && (mac[5] == 0x00)) ||
> > > -		     (!AutoloadFail)) {
> > > +		     (mac[4] == 0x00) && (mac[5] == 0x00))) {
> > >  			mac[0] = 0x00;
> > >  			mac[1] = 0xe0;
> > >  			mac[2] = 0x4c;
> > 
> > This is a separate fix from the rest of the patch.  Send it by itself.
> 
> Ah, thought to send a patch series.
> 

Yes, please.  Send two patches.

> > 
> > 
> > > diff --git a/drivers/staging/rtl8712/usb_ops_linux.c b/drivers/staging/rtl8712/usb_ops_linux.c
> > > index f984a5ab2c6f..e321ca4453ca 100644
> > > --- a/drivers/staging/rtl8712/usb_ops_linux.c
> > > +++ b/drivers/staging/rtl8712/usb_ops_linux.c
> > > @@ -495,12 +495,14 @@ int r8712_usbctrl_vendorreq(struct intf_priv *pintfpriv, u8 request, u16 value,
> > >  	}
> > >  	status = usb_control_msg(udev, pipe, request, reqtype, value, index,
> > >  				 pIo_buf, len, 500);
> > > -	if (status > 0) {  /* Success this control transfer. */
> > > -		if (requesttype == 0x01) {
> > > -			/* For Control read transfer, we have to copy the read
> > > -			 * data from pIo_buf to pdata.
> > > -			 */
> > > -			memcpy(pdata, pIo_buf,  status);
> > > +	/* For Control read transfer, copy the read data from pIo_buf to pdata
> > > +	 * when control transfer success; otherwise init *pdata with 0.
> > > +	 */
> > > +	if (requesttype == 0x01) {
> > > +		if (status > 0)
> > > +			memcpy(pdata, pIo_buf, status);
> > > +		else
> > > +			*(u32 *)pdata = 0;
> > >  		}
> > 
> > This isn't really correct.  In many cases status is "len" is less than 4.
> > I'm slightly surprised that nothing complains about that as an
> > uninitialized access.  But then another problem is that "status" can be
> > less than "len".
> 
> Sorry, I should explain it clearly. If I did right, watching "status"
> with gdb while running syzkaller reproducer, "status" returns from
> usb_control_msg() is -71. In which case, *pdata won't be touched in
> r8712_usbctrl_vendorreq(). As a result, "data" in
> usb_read8()/usb_read16()/usb_read32() will be returned without
> initialization. I think that is why kmsan reports:
> Local variable data created at:
>  usb_read8+0x5d/0x130 drivers/staging/rtl8712/usb_ops.c:33
>  r8712_read8+0xa5/0xd0 drivers/staging/rtl8712/rtl8712_io.c:29

Yes.  I understood that.

> 
> > 
> > A better fix instead of setting pdata to zero would be to add error
> > checking in the callers and then change this code to use
> > usb_control_msg_send/recv().  Probably just initialize "data" in the
> > callers as well.
> 
> I tried something similar which also works fine, but I think this patch
> does't fix it at root.
> https://syzkaller.appspot.com/text?tag=Patch&x=15be2970f00000
> 

Ugh...  Sorry, I had not looked closely at usb_read8() and friends.
(This code is all so terrible).  Ideally they would have some way to
return errors.  Oh well.  Anyway, I guess do like this:

	status = r8712_usbctrl_vendorreq(intfpriv, request, wvalue, index,
					 &data, len, requesttype);
	if (status < 0)
		return 0;
	return (u8)(le32_to_cpu(data) & 0x0ff);

But in r8712_usbctrl_vendorreq() you really need to make the other
changes I mentioned as well.  If you want to do it as a separate patch
that's fine too.

	if (status < 0)
		return status;
	if (status != len)
		return -EREMOTEIO;

	if (reqtype == 0x1)
		memcpy();

	return 0;

regards,
dan carpenter
