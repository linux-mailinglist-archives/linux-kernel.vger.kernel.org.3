Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36B8588CFB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 15:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236060AbiHCNcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 09:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiHCNcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 09:32:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3031147A;
        Wed,  3 Aug 2022 06:32:12 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 273DDkaC012956;
        Wed, 3 Aug 2022 13:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=PR7EdPztvO7JuNaf4Z3R09S/CK5UY2reTGuRoSL5hCA=;
 b=g9bsrzGAIxCg4lRlJbuf6AtHGm6KClEqDZzJzjBXn9FveBOPiF1HV7/O12nqN9/DmHP6
 Fj9LgCZdmHkXfSsnHlEIIIxDFUuG9b9QUbr2Rz2y441hx05aDd7JiKfBDQVPMnCqtrhe
 vZz8FMvQ2PYAAzVFbCYbyPB7TAxnfpaLk2KIuQ97EgvQLYEfXca94rPpsEXLE+Y4tmwX
 ga1zElNnjvixOlsIUu9nn5wp7ZFehUE1leKu9d+EDm5tHu/q+4k8CqkFsE5/0vbUecoD
 6yXzvndQolZ2pa2HmkxqHboN1tL6gbbcm7W2EvjXyFvX/D9B2NgHgsvOL1mWs1RzNK5k kg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmue2t2uw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Aug 2022 13:31:32 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 273C0HOH000962;
        Wed, 3 Aug 2022 13:31:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hp57s6rex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Aug 2022 13:31:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRnfYjW/A3HdF4kO6fi+FEofmoZM5WIcEzZ6qwa62QC6TO8IurhhnnRBV0p37+awoImrKHkjaX8IVzn1BZiS6fr5c74Z666Wu8n+2f+543onZvc5Ia/Hy1w9J8a8L/8XYi1f2I37gBy6la1O51QT9PeHcvkuFmad7YOU+Lh+hm7+WFMj/Qi9pKWnpDiDHkbu0MVUklSzIfQfrgyJo+JiI7Qw1Rs/CxANxYkvYsYW6JDkgj9gASTVoW/7fIigsl/6Bsq8mA/iKY7goRPa0d4sKnLKyOgTn1n4m323yx3Ln/fpXPEOnOJIOVFL1ViUQijsROQ5vKS0xxux7DkvRAgvmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PR7EdPztvO7JuNaf4Z3R09S/CK5UY2reTGuRoSL5hCA=;
 b=GPCapNhdFSqF36SXmIKjDoUV2nBqiYgVrIUHj0V5oPFzbnABzF0nx0PB9pPn/XU9sryvhMALgycCCnQz0TJJ++cKpIlT3OSQgKC5MBmAZy/IHj7FutNyugCfVzQG258dsz6ihHdaD9ohxdq5Q+Qf3GwL+NuchlVHwJ8Jk30EbZeEnAvbGKQ5X8OQ+/IX8pYH9IhaloywYEfrjMsK18a2wRk7X0mhMw827UiDIm4Vb42EBbLXd8roglZKZeINr8PnNdO1B90NmfxiTkt65326bWW8EhgCiu/9nwE7BKWsg/WmSZ5gXmtO8xhMDsbgJYL616e+HP0x3gL1YKMF51mBow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PR7EdPztvO7JuNaf4Z3R09S/CK5UY2reTGuRoSL5hCA=;
 b=JC+qCbww/1q6obLjoG9ajexgRsqNCM5TXzXJ2hlw0WMCPk5mDOKSxaR4IYI2j6j+hpakREUT047hYp2BDAba0+TRN/qzcpU1iMM/O9laGoXh9B0EpghGH4ENB4IY/NBcq79RUysR6IXRVmOupofyax9Nym5SEjzqYju3QBr9p04=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB3280.namprd10.prod.outlook.com
 (2603:10b6:208:126::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 13:31:28 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 13:31:28 +0000
Date:   Wed, 3 Aug 2022 16:31:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Igor Grinberg <grinberg@compulab.co.il>,
        Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: pxa: Fix a memory leak in pxa310_otg_exit()
Message-ID: <20220803133109.GD3438@kadam>
References: <890e3e7329b020356206262e9c3ee57378648e1c.1659506415.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <890e3e7329b020356206262e9c3ee57378648e1c.1659506415.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0053.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::18)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f829da1f-0468-4d8b-03dd-08da7554785a
X-MS-TrafficTypeDiagnostic: MN2PR10MB3280:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NkQ97b+xKBsOnwFWKnetzEueAyVLezuHB+7ZVxXYNkN4Hs+A288auWx9Wb7eeZG+gWhFRPwrz16mLZA8CFB+/oMxBXJviRZl+vN46gTEAelMadjPq1LgZ5lvhlNngZziTxnOeEAmVr7R+nFN2PGSNg3/DWypet4VmzTmoDZ6roWD6jsEt3GGFrJsm/7+ksVBB3ZfhvBKJuWw+Pc7d9UhB0w3FCbBtKFdWzAd1iUF9mxilWYqSXwsE8yj99AWbj8NkpgOqvQYuLHPkaPrapqX0RZEwamjVleIw9Lk7TEzmJEERgUdD20W/t837mCeOvnz0YriG+F05STlzZVdXdulBlH4/ugZS41AlSipk7hh31lxV83DUV8zyCHGiutHd6xDLw5oraTDKd7Ys7CzOwQLsML4YL6zWSfXljL+HAECII8hW3qTsEJorE9sX3U0av1+Tyy5gxSe29bxUf+Kgp5FyXyUauG7s8JB7lX3DyieLI2IOoGYkoJ7l61yBOwCbVa7Pzv1uY6JNvJag2Y1VyBaQLiyTxQsakWfSM+u6Sn2LESKPF2MPo1SfMOm11otTdDalD2wB9HWS4sDodU9xqC89e4UCw6Wvv65wKuQYGDC/+Jf6G/LJt4un/wURXZDAKfeoMLQOjwusdUgA3gsdwMeWCQvp90zQtg2tUC373r1c0xKV3Yeb0Ov1VDv2/JNVFFBRpSH8jz9wajtEKsfg7gNYFXLbxkXKUxpOWtbHoQlird+VQr/XBbxWphaLgUCzrBNElNNGz1g2Zpn92BNmik5j+HiCM8ZbtG4qabmgo4LAtr587N1TE3MtAtS3o4HHOFPoDTDyFxLfubN25FoE4mHTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(396003)(39860400002)(376002)(136003)(366004)(6916009)(6512007)(9686003)(86362001)(54906003)(4326008)(6506007)(8676002)(52116002)(66556008)(66476007)(26005)(66946007)(5660300002)(7416002)(44832011)(33716001)(38350700002)(186003)(8936002)(38100700002)(316002)(83380400001)(2906002)(6486002)(478600001)(1076003)(33656002)(6666004)(41300700001)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t7Ozpa9WNSQuR7f3OwOQPGAcAUlPtaoiNleY84vKkOi2rBVZxx44rV7ZUmUV?=
 =?us-ascii?Q?BPFWqdgfL+JyvZEl3kdhxUimyRtVsZZ9B9UBfu3c10afD/esTbMrZ9fIqA4K?=
 =?us-ascii?Q?2gzKd3lF4MMHOg9hQCUaAJVOFKJuGP9u7xY5+Nnhs1YTkvbYlscPIyazo9k3?=
 =?us-ascii?Q?LCsOtzQsqWSl61UhNujq2FDcT88uebJTVMuUd/Fty/7AkqZ6/DNk9zIan1Es?=
 =?us-ascii?Q?WDnSUShVRxgfCU0nFrR567wrCMWidnqD25pzG7myCCZQkhPBttvdkJlK8l6O?=
 =?us-ascii?Q?fZ1rpjecxb3tnhNrL7PtLbIr9+V0Sd+f2LF18cDCg7P3x37JfhgRo/CCxLu/?=
 =?us-ascii?Q?Z53wQO169suJoFOtGDv86aoh/CymVLwCGRKJjGGpw2CkKzEmR168bl+zO/Mc?=
 =?us-ascii?Q?rQ9sWaDcVrFzUybeke+iU0IRIvAPvctgXBM8idyvC5eYD2AN/WItYJoKADu2?=
 =?us-ascii?Q?bw0JwxlDnUp0pqjX2Nw+bW1O7Dm+DbWg5/ilnr7InkFQtbv9+ixO1JThDu4q?=
 =?us-ascii?Q?8LRg4+R5rRyFSmMQoLDssmqT3SKe7ZOC9dO/FCPll4G+yNwYqb9sGcTRHG2h?=
 =?us-ascii?Q?8+omew4Yr0eIc4UVf6DDsnPoKCaa6MtgSc74ta9QOFdO0xGliLUiyM2b1S2W?=
 =?us-ascii?Q?HsxcrcVGKQdseWiX+IDKL3vluYtoa1u5I679P0ZROGuUrJHMHu1yUGvc1pKH?=
 =?us-ascii?Q?H9Q/lItJkU8pMhyLqytE0DIhRPvUTc0Id8+g/YsVPlJ5Nn8BzP32YjbLWFfq?=
 =?us-ascii?Q?v1j63rz22SBeVx81XFVAGwRpDXdsLtpjVo/21j6WGorQztYr+kfzKrgMr9IN?=
 =?us-ascii?Q?0AN8B1oIB+KvFVKcMmJ1StZ30Ewel4QyG3r30Jwag/fZvnZ1q8WLoFtO+LMR?=
 =?us-ascii?Q?31TmtZ/ffV8VQ8YwsFBjALqT60B+utBlWjqAVzeH+G9j48BCl2+RZ/emHhFw?=
 =?us-ascii?Q?hL4y3Bz5bCxSFfK2iBSTZsWgXF91xUXmogT+0eONgT4VB6JhIhPPP2VWYfGa?=
 =?us-ascii?Q?gSV5IJCSmgiXf2lotjMKkzesgcSYMAyYcl7Fy4g9hb6nissJZHJUn2PG+7us?=
 =?us-ascii?Q?FTJrKd0UOMbwyneiIryJsGHLzbH+9vrNND5dPQfDHsL4/HZROlsGlJ1VRigQ?=
 =?us-ascii?Q?YiZn7k608rouTCPm4aJpZ8nqLrRLOcWzhOkNYq9c6RY/faWXXCo1jrgTvjv1?=
 =?us-ascii?Q?eEO8rzKzMAMy6QvbO0x4alQ/ZfuBS+2i1YXGWTdhxv74dJ44Ln1e5BhMHJW3?=
 =?us-ascii?Q?tN+z1ky+J51Z9cUsB8OoUNUDdhdJ6c3zjhTiUU8X2Daj/9tI6M8cd1TWHFTr?=
 =?us-ascii?Q?qOtvkHMLcyO/GtQgiQ9I1N3tegD5TOvBCdMw/WKb2haakUVfpQ6DXvrqM2sY?=
 =?us-ascii?Q?+Mv59Lefveeg6SzMKh3Mgklp4h1TNpCwLjzBi7ESDXX62WRlB/x34MMzyqVb?=
 =?us-ascii?Q?6M9csMqMz3QBMfCYp8/laH+GATOTozecA4u62fCd7JVjp60KqUAOAAF5/Dyn?=
 =?us-ascii?Q?a4NgdQL3yv9ERCsdSKc5ZNckjXHYWtk4HtGxAi9D2iNBD04XKM0U+GmBEWQ0?=
 =?us-ascii?Q?ylpkAz8hZQi0IqrK+08axPU4IO5sVXh7th4RD47wcnkOauI2P41rofnBzXWF?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f829da1f-0468-4d8b-03dd-08da7554785a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 13:31:28.5557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LkZrZN3yYvXRGT0Wqh6PGGCjooLBBlLRdzXbJlHiCIR8bUl8zzjZ2S6fD4nxeedVVxcZunSF5s756Fq3EJt9QVBiIdbCBf0KECeNWi5Qf8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3280
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-03_03,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208030060
X-Proofpoint-ORIG-GUID: c7w_73XORuFReUrjzckdciRSnCxgOcbf
X-Proofpoint-GUID: c7w_73XORuFReUrjzckdciRSnCxgOcbf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 08:00:44AM +0200, Christophe JAILLET wrote:
>  arch/arm/mach-pxa/pxa3xx-ulpi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-pxa/pxa3xx-ulpi.c b/arch/arm/mach-pxa/pxa3xx-ulpi.c
> index c29a7f0fa1b0..82b4e2706f86 100644
> --- a/arch/arm/mach-pxa/pxa3xx-ulpi.c
> +++ b/arch/arm/mach-pxa/pxa3xx-ulpi.c
> @@ -229,6 +229,7 @@ static int pxa310_otg_init(struct pxa3xx_u2d_platform_data *pdata)
>  
>  static void pxa310_otg_exit(void)
>  {
> +	kfree(u2d->otg->otg);
>  	kfree(u2d->otg);

It's unfortunate that we kept the "otg" name when changed u2d->otg to
a phy.  A lot of the stuff was renamed...  I don't have a cross compile
system set up either so I can't patch it but looks reasonably simple to
rename the remaining instance to phy?

diff --git a/arch/arm/mach-pxa/pxa3xx-ulpi.c b/arch/arm/mach-pxa/pxa3xx-ulpi.c
index c29a7f0fa1b0..a002fe1e96a2 100644
--- a/arch/arm/mach-pxa/pxa3xx-ulpi.c
+++ b/arch/arm/mach-pxa/pxa3xx-ulpi.c
@@ -30,7 +30,7 @@ struct pxa3xx_u2d_ulpi {
 	struct clk		*clk;
 	void __iomem		*mmio_base;
 
-	struct usb_phy		*otg;
+	struct usb_phy		*phy;
 	unsigned int		ulpi_mode;
 };
 
@@ -76,7 +76,7 @@ static int pxa310_ulpi_poll(void)
 	return -ETIMEDOUT;
 }
 
-static int pxa310_ulpi_read(struct usb_phy *otg, u32 reg)
+static int pxa310_ulpi_read(struct usb_phy *phy, u32 reg)
 {
 	int err;
 
@@ -95,7 +95,7 @@ static int pxa310_ulpi_read(struct usb_phy *otg, u32 reg)
 	return u2d_readl(U2DOTGUCR) & U2DOTGUCR_RDATA;
 }
 
-static int pxa310_ulpi_write(struct usb_phy *otg, u32 val, u32 reg)
+static int pxa310_ulpi_write(struct usb_phy *phy, u32 val, u32 reg)
 {
 	if (pxa310_ulpi_get_phymode() != SYNCH) {
 		pr_warn("%s: PHY is not in SYNCH mode!\n", __func__);
@@ -136,19 +136,19 @@ static int pxa310_start_otg_host_transcvr(struct usb_bus *host)
 
 	pxa310_otg_transceiver_rtsm();
 
-	err = usb_phy_init(u2d->otg);
+	err = usb_phy_init(u2d->phy);
 	if (err) {
 		pr_err("OTG transceiver init failed");
 		return err;
 	}
 
-	err = otg_set_vbus(u2d->otg->otg, 1);
+	err = otg_set_vbus(u2d->phy->otg, 1);
 	if (err) {
 		pr_err("OTG transceiver VBUS set failed");
 		return err;
 	}
 
-	err = otg_set_host(u2d->otg->otg, host);
+	err = otg_set_host(u2d->phy->otg, host);
 	if (err)
 		pr_err("OTG transceiver Host mode set failed");
 
@@ -186,9 +186,9 @@ static void pxa310_stop_otg_hc(void)
 {
 	pxa310_otg_transceiver_rtsm();
 
-	otg_set_host(u2d->otg->otg, NULL);
-	otg_set_vbus(u2d->otg->otg, 0);
-	usb_phy_shutdown(u2d->otg);
+	otg_set_host(u2d->phy->otg, NULL);
+	otg_set_vbus(u2d->phy->otg, 0);
+	usb_phy_shutdown(u2d->phy);
 }
 
 static void pxa310_u2d_setup_otg_hc(void)
@@ -218,18 +218,18 @@ static int pxa310_otg_init(struct pxa3xx_u2d_platform_data *pdata)
 
 	u2d->ulpi_mode = ulpi_mode;
 
-	u2d->otg = otg_ulpi_create(&pxa310_ulpi_access_ops, ulpi_mode);
-	if (!u2d->otg)
+	u2d->phy = otg_ulpi_create(&pxa310_ulpi_access_ops, ulpi_mode);
+	if (!u2d->phy)
 		return -ENOMEM;
 
-	u2d->otg->io_priv = u2d->mmio_base;
+	u2d->phy->io_priv = u2d->mmio_base;
 
 	return 0;
 }
 
 static void pxa310_otg_exit(void)
 {
-	kfree(u2d->otg);
+	kfree(u2d->phy);
 }
 #else
 static inline void pxa310_u2d_setup_otg_hc(void) {}
