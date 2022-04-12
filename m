Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02304FD0A5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 08:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242048AbiDLGtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 02:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351332AbiDLGog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 02:44:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612BB18E2A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 23:38:03 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23C5iwQO001710;
        Tue, 12 Apr 2022 06:37:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=29pyZwbt2cmTUV4WEBjPEFqcpjMZjj33APjVFuNaGes=;
 b=RszeBHMG9Qvs1j7jR9y8D+gCDcUx2seg90ecMM8i1/qupj8nbeysHDhnwxN7BJ8zoyot
 rTSeTlnpTA7dR1miuV3XtIgLki+nx9PqvhE53fUx3eD2Qypyi/5jec6zRFOnWxLwKCqq
 tttAiqtQky5ttzA4aJAf4yGJ886zfdLRG5eqzy7UFQ1qB7Q0pG2IR6yMEvs5R1BWfW74
 nUszOkb8qBtjJl/z0vaSCdAUm9Y9TLwZCzYpcy2+X7swR26VCrBHF/VKxstsn9Uc+beg
 HNZwijzWk/s85MV+aPIgCZejG/kQ/ERkzpwnZWPFZzADKaXRACzEKlzjp1B5ZjxMnQS0 sQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0x2dsdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 06:37:57 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23C6WEaU040467;
        Tue, 12 Apr 2022 06:37:56 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2045.outbound.protection.outlook.com [104.47.73.45])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fcg9h25s0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 06:37:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nok9sG1axLu+Vu5utw1PAmfHw44dSrafnvpnSE6r4W+4GiaC/vBewDfBkxowh/RMHsD5kSfTQ8amFbeZ5wrcwcCeK6qo+TAqTlixSziZgJEj+CvO2voTbvMhcnQcMlVC5xjas/fQV1LDwirdQ+IDbY+sMxPp6Rb2ff6HO/DSrDHLQfM1q5rnCRWVb4Szv3ncEW8Sr8HNXRS/ffzlweFg+AGGZ1R5FSY5SypjCEOw17EYyW1XFbiQt0wdeP9O+GX5uCJEr7tTcJEUK/3bJOvNHvu+b39p6qtp3KjsvpHCeFK3sSSQfSXjCstOSxBIMGFPi/tdXT7GdTlwToqcvrl5Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29pyZwbt2cmTUV4WEBjPEFqcpjMZjj33APjVFuNaGes=;
 b=AKOuwIG7bbYyF+QgBuNepeIS9GDDMqKATQknxog5rUz+h6MiCrmT8IoHQn3tE30soYOASk/mZShBBHi8OSBzlcz+0HBIdIWYung2heZS87rQVHnn4viXiwbpfkGJj22afI3OT+ri9DHqutZnCHpsf5xmyDcM7A4okRJxGlqLg2sQDLwKPEuLabUNRTEYlvr4O5yrl6If7DAL4oDQ71IiyC8mFw2qL7FsnpMgdVuGcr1SUsaAut9DhnKqomL+jHM1ySZz9an6928pWSOL9xDJckfkP5IDxGx2hOcKpNfruo24OQZ2zoqagNz7jhRkQyNq3kLC/bUGRzl2GgWbjeWh5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29pyZwbt2cmTUV4WEBjPEFqcpjMZjj33APjVFuNaGes=;
 b=uWmTxgZskCAcEmOZepPd9idJIPxyw3F/9lbh3rsHadKuqkggn07fezBNdlNpIYyPNOvq5Zt6MM6uWRe/scDYxvLx+B5J3M0G1xxgjjBzqaswwDuRkShv+DKg7xQr4fHaQmNRKAvPAjrDN6n/WOiWHqAGuHpcZK8QUqPMrITZIQM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB1451.namprd10.prod.outlook.com
 (2603:10b6:3:f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 06:37:54 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Tue, 12 Apr 2022
 06:37:54 +0000
Date:   Tue, 12 Apr 2022 09:37:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] staging: vt6655: Replace VNSvOutPortB with
 iowrite8
Message-ID: <20220412063731.GA3293@kadam>
References: <cover.1649706687.git.philipp.g.hortmann@gmail.com>
 <3cac1ca7000a56e82b390ea0ddbab5aa549ee7ec.1649706687.git.philipp.g.hortmann@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cac1ca7000a56e82b390ea0ddbab5aa549ee7ec.1649706687.git.philipp.g.hortmann@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0016.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::28)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 109825cd-f8b3-461a-0b4c-08da1c4ef92b
X-MS-TrafficTypeDiagnostic: DM5PR10MB1451:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB145153682EF8E5BD98C10E198EED9@DM5PR10MB1451.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DErmNwhvpJ3nR0HJEZ5bIE1MIhZqrmz8rY+IJv59XZAXay5zdPPNyxZUyXYNlEcmVRqQK4jiMowcYs6xi7DhoXOR3XVwd3lT8gZ60bWWNT33+feaytXp7kt+jnDQEReEDCw8+/E8jI1/A2Ea+xa35W4UyW/VKzabkBWLAei4yUbCpGWMPnOSJh+oXSEMuym4RTiDESKap3Q0buHMouMzvrmbYwgFD6m3iDjF816JcrycH94GMvOiEuBoAJNTHfolbKPuhueGq5M6QKxXXucdJuC73b4o2qJMlJQT0TxKGZkHjNUMSsjS57tUBcmC4FQCIIcyGYsbuBIerswkGTY6lSF4zyCmHiDClCBBPEitxOqyCHwogp5+/JuwCTFvThzVYfGBQdnDj2QOjRbzQujMhAZ8fQSNLJ3Kyfkq3/o3dJZoTiWqDH/HKFr/wQIqThJypkvrRNTv9D0HEqKaCQgt4/MvOZsocklWPTEJU8prbNdbPZ5DC6Ky2XmVkO5Zld0kGT0TSR5A6JqthIw7SFzMJXtHFF5Hv0nzZj4vouYQWMBvS6FS1aI3Id9zPrZ8nBvV1rHqRh4qs1s0TSzdAU3W2DE2B2lyRtcswRk0+dR6qwybZHmyHtZ7bVqvCZDwC7EPun0tZS6G/it8O8DgHCnMTEbaKjwUgnKY3PYJ4OwpgKMu9mYPttuNGhZqv8RFRB9IIXejdrvSDVIJsbh2jp5pGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(6029001)(7916004)(366004)(186003)(44832011)(33656002)(8936002)(6666004)(2906002)(6916009)(6506007)(316002)(9686003)(6512007)(52116002)(4326008)(1076003)(83380400001)(8676002)(66556008)(66476007)(66946007)(5660300002)(508600001)(38350700002)(54906003)(6486002)(38100700002)(26005)(86362001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VtMN7+EmZi5KZF97GfBLyunjhCkCbty+GdI12MKsmGS5tqkOPcPyquwgreTd?=
 =?us-ascii?Q?fJPPGv+hgRXara7gvKL+mahKE/jW90I0zCEix5n1NZkjTiIvGHZnBca7acUA?=
 =?us-ascii?Q?ynywa8MIE2zVuHJRXQ0Ljywr79fNm2pnBVkqr9+pQzWcRYr6u1UU8aVD+l30?=
 =?us-ascii?Q?5aqrlW1q1HIeawZAku1IP8eK/8p7//Lo8wQxJ656eUuHWBm7RNwEOCPy6rtP?=
 =?us-ascii?Q?xZhThcQByWJYbZFJISulvnP9XZIQ6zv29uEEgT8wSAqf2kwSX4aLNoJ3vhKG?=
 =?us-ascii?Q?ucMhfl7ibn4SSiimBIceyF8NELNW9XKmDSRQA52qUMgvXcXDuTpgRyJvR/RK?=
 =?us-ascii?Q?2zLN8CMPq856EF/ZzXq/oEqEIYLyMv2zz6uypiOm0Owetg9zE44e3LcgifWM?=
 =?us-ascii?Q?7DB6O6DJDULTYYkvdnS7FQq4zw0XXxlZd34W0TaaK1gHqaq0ZOgfGRf3G2yS?=
 =?us-ascii?Q?WrEAkikd7tsYq1yaZ8msRPKQGAvB0f104FMejffjg3i2ZkdBMXmtt9wiooZA?=
 =?us-ascii?Q?s8bBsHx0h2ClnRBWKZKOoSjAELKCMqwQmSaFwadhqnyMfcBMmcFN2F03k9O6?=
 =?us-ascii?Q?S7dC4B8jkPg9ZMrrKtZyUyu4S2NtrRVo5Of9Fsgmqz3UIaxWTaF4S2U0GoyZ?=
 =?us-ascii?Q?tmvh+E29z1byvx2nMwFu4rSl0qpa53HNNEaFfxKi5f70Foo8oMJSKwQBFrH0?=
 =?us-ascii?Q?ht+zJWlu1RIbpzxvH6/WUlyX4dYkgmIYYlFMjFXpFvU4OGx5xP5J5P2bgqGI?=
 =?us-ascii?Q?wJu3dVYzlr/H/q3JOHO52TTI8Fo0fE1hEspWZB8CK48JpmIwbGO6VihUnUy6?=
 =?us-ascii?Q?8tL6C6o6SWaKzPONKjzsUpek/0Ju1zcH4Gj2q8RYAr4piRKISXTwW/rWdaII?=
 =?us-ascii?Q?/2v4vFx2qBQM5PmqgWEkcT2MQF9M5s/TyZyYQlPbJKMGr5bAWODI/cM3DYOA?=
 =?us-ascii?Q?9qxEIgGeo2Znnq/QxRvO3yqp6QBogsAaNSRNgmbaYtJmBf5op1+Mm0gDYYxO?=
 =?us-ascii?Q?EJTk64157IbAp3OYob5TBOl5aAMT/uzHSfM5FhgZmvBTz/46TdN28llNnrwV?=
 =?us-ascii?Q?bpzeFn9F2pXCz1VAE4nXrTkhI9A9xK63HzA4Dfv8quP8YZgxvV4vT3w4s8+C?=
 =?us-ascii?Q?g6hQ7L0PinKBbUVOqrCYnnZfGn5q8VoZlWwrXxIntPApgKhD4HCVCALk2aQe?=
 =?us-ascii?Q?qdQTyETclKk30cMcM5UhFE76dQVMX3vSBH9quW8lQVyNJMsOg2w7naMCawx5?=
 =?us-ascii?Q?421mAmUu8QX3FqhZcEPgCqOjGUmMJ3wKWQOr02LFj5Cx9hSA0ACFralkRO2V?=
 =?us-ascii?Q?jPZ7760egHNnqA/mMOopDHE0/4vTBC4IpU9MDLfZuukGi+PGHf552VMAspRO?=
 =?us-ascii?Q?AzLuv5vqvyjaYc7ILwwIUIZGYqom17Kqjtij0dv99l1ErHMAMrD99BZabOUw?=
 =?us-ascii?Q?FVF6z/SIzh1E1mKORGQfVw9syFD3It+GFO6J4M9QbgIOPzeFSeboPOiT6CJF?=
 =?us-ascii?Q?QbQIGUMtmvdXtxHs/BvwyBeJ4tdiqAqxOf9TrM23Z84hjgdOplxuAWBbzRSJ?=
 =?us-ascii?Q?IHXxxzX42WTgv1hMDIOIAEE4NNAyCGMuj3VoQomqct30/SSuvkc3iC54nes/?=
 =?us-ascii?Q?PpXfAXxnev8z7W8+DEbVkO9cgN7eokG0mGbLmTQVySi/47Zen/rvxsTv7jty?=
 =?us-ascii?Q?u1pH5YdVrum/6lwJLFq5zUTEMKqPOHe+TLoUxtVubLB1vQ9J3KUtwuCgRRXz?=
 =?us-ascii?Q?QQdZmosmAcRA4u9LQbtpfP7tUtkJwXQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 109825cd-f8b3-461a-0b4c-08da1c4ef92b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 06:37:54.5658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PG2D3XPjCasXjARq7yPv3ebLe02pgB6LPV5HE7jVTL+jHIq/OEvMmF+SLCW2LOCQItldus2VYGqei7zRiEH8GSXM+22/PBUUIrUrUMij4fE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1451
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-12_02:2022-04-11,2022-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204120030
X-Proofpoint-ORIG-GUID: jIMRyyTk67U9FwqIM_-XpWRQZ6zUWSjO
X-Proofpoint-GUID: jIMRyyTk67U9FwqIM_-XpWRQZ6zUWSjO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 10:49:39PM +0200, Philipp Hortmann wrote:
> Replace macro VNSvOutPortB with iowrite8.
> The name of macro and the arguments use CamelCase which
> is not accepted by checkpatch.pl
> 
> For constants from 0 to below 0x80 the u8 cast was omitted.
> For variables which are defined as unsigned char the u8 is omitted.

I hate that GCC prints warnings for this.  Useless.  Horrible.  But I
understand that GCC does and we haven't figured out how to disable it
or who needs to approve that.

But even then I still don't understand the casting in this patch.

Shouldn't the rule be to do the minimum work arounds to silence GCC?
My understand is that the the casting is only needed when you're dealing
with a bitwise negated constant.  These are macros so the parameters
might be constant so basically any bitwise negate gets a cast.

>  #define MACvWordRegBitsOff(iobase, byRegOfs, wBits)			\
> @@ -578,37 +578,30 @@ do {									\
>  
>  #define MACvWriteBSSIDAddress(iobase, pbyEtherAddr)		\
>  do {								\
> -	VNSvOutPortB(iobase + MAC_REG_PAGE1SEL, 1);		\
> -	VNSvOutPortB(iobase + MAC_REG_BSSID0,			\
> -		     *(pbyEtherAddr));				\
> -	VNSvOutPortB(iobase + MAC_REG_BSSID0 + 1,		\
> -		     *(pbyEtherAddr + 1));			\
> -	VNSvOutPortB(iobase + MAC_REG_BSSID0 + 2,		\
> -		     *(pbyEtherAddr + 2));			\
> -	VNSvOutPortB(iobase + MAC_REG_BSSID0 + 3,		\
> -		     *(pbyEtherAddr + 3));			\
> -	VNSvOutPortB(iobase + MAC_REG_BSSID0 + 4,		\
> -		     *(pbyEtherAddr + 4));			\
> -	VNSvOutPortB(iobase + MAC_REG_BSSID0 + 5,		\
> -		     *(pbyEtherAddr + 5));			\
> -	VNSvOutPortB(iobase + MAC_REG_PAGE1SEL, 0);		\
> +	iowrite8(1, iobase + MAC_REG_PAGE1SEL);		\
> +	iowrite8((u8)*(pbyEtherAddr), iobase + MAC_REG_BSSID0);				\
> +	iowrite8((u8)*(pbyEtherAddr + 1), iobase + MAC_REG_BSSID0 + 1);			\
> +	iowrite8((u8)*(pbyEtherAddr + 2), iobase + MAC_REG_BSSID0 + 2);			\
> +	iowrite8((u8)*(pbyEtherAddr + 3), iobase + MAC_REG_BSSID0 + 3);			\
> +	iowrite8((u8)*(pbyEtherAddr + 4), iobase + MAC_REG_BSSID0 + 4);			\
> +	iowrite8((u8)*(pbyEtherAddr + 5), iobase + MAC_REG_BSSID0 + 5);			\
> +	iowrite8(0, iobase + MAC_REG_PAGE1SEL);		\
>  } while (0)


If these casts are required then the pointer math is wrong.  #SeriousBug
I looked at the caller and these casts are not required.  Just remove
the casts.

>  #define MACvClearStckDS(iobase)					\
>  do {									\
>  	unsigned char byOrgValue;					\
>  	byOrgValue = ioread8(iobase + MAC_REG_STICKHW);		\
>  	byOrgValue = byOrgValue & 0xFC;					\
> -	VNSvOutPortB(iobase + MAC_REG_STICKHW, byOrgValue);		\
> +	iowrite8((u8)byOrgValue, iobase + MAC_REG_STICKHW);		\
>  } while (0)

This cast is definitely not required.  byOrgValue is declared as local
to the block so we know it's unsigned char.

> diff --git a/drivers/staging/vt6655/srom.c b/drivers/staging/vt6655/srom.c
> index a0432bacb6a0..7feaa5138de0 100644
> --- a/drivers/staging/vt6655/srom.c
> +++ b/drivers/staging/vt6655/srom.c
> @@ -68,13 +68,13 @@ unsigned char SROMbyReadEmbedded(void __iomem *iobase,
>  	byData = 0xFF;
>  	byOrg = ioread8(iobase + MAC_REG_I2MCFG);
>  	/* turn off hardware retry for getting NACK */
> -	VNSvOutPortB(iobase + MAC_REG_I2MCFG, (byOrg & (~I2MCFG_NORETRY)));
> +	iowrite8((u8)(byOrg & (~I2MCFG_NORETRY)), iobase + MAC_REG_I2MCFG);

In this case we have a bitwise negate but it's ANDed with a u8 so there
is no cast required (hopefully 0_0).

regards,
dan carpenter

