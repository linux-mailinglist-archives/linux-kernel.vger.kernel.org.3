Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660F750DF97
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 13:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239527AbiDYMBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241137AbiDYMBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:01:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB0313D4F;
        Mon, 25 Apr 2022 04:58:00 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23P9sMeT027770;
        Mon, 25 Apr 2022 11:57:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=iUO50IJiUOc7Eo7Kcg0pe2DZSqsa+gebygCG1uzA0Ck=;
 b=wg5SSra4nRjVhJ720iRotjO2aVC2y2jhorPYLYCnHsyB0+70gsnwWMa24sp/U6y8iLom
 MDyw6hzjge1e4ZBIpQPYoeG5KDpxT7gWFKVIrq3r5chavPvfE4WSP7AVrlNnZxhvK82/
 jFT+/2sHnXAEQrnLINvjJ5odGTJPdXaCJKXOnVqXFm8gweuQY6PCeHYAyzzEP996/HA9
 e8mRjXQ+JX8ru8NrKHnQgJI9HlQqB68gAtyQUyp3s6SLOjkvXpoeW8fv0rwt1PoBldbp
 ZeDbZ4KkpeJ2Cx7HW5bG7njgUDOm5lnNqFlqfovfQbZda+F6XTLCPvhDPphQYrYdY7yw ew== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb9ajxb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 11:57:56 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23PBuOiv037978;
        Mon, 25 Apr 2022 11:57:56 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2045.outbound.protection.outlook.com [104.47.74.45])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fm7w1mn7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 11:57:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTBQukJLlxHvONS0c+pTcV6Z53uIuTM92Cxk+J8Bn1om+LD9nymn7s8+vGQFRhrrXqduwRNdoiI9vk4Kaf1GM67PstW2Y/sBBEGwWbvCJMZs6EeXvBNEabYhYvNkbFMQud1hq4cUC+4iFA+fVngyAKrB0WQ8JTngovwxj6QSbZwGkdp8x+NsdIpWl9dAAEIADRaweyhE8AmJzEWuX7nK9vCvgHxuhgRJm4js0NOekLXfXmapqAtg8M6egFgVniTh+KmZmzWCHvcU7zuK0Fwyx2F+d5HcLkLhpuCxacFGHSLZ1w0GDy/v5Zco+fsj76oqbnG9YZ7WS0nyKpAPsyL7Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUO50IJiUOc7Eo7Kcg0pe2DZSqsa+gebygCG1uzA0Ck=;
 b=k7hXCzkSopAj9QQEWmD7BqDuja5rY77yQXJ8euVL8Z6LT9TvpsbSMhvHUdDBGgg+/mH275HHxfstArkpzZ+PkALtUcRCb78oO66u085J0Eva4cw0NyuEOlj2TmSjuesZ648/ubvjnsOSFSr2g4WGjhwjfjp/8j3BRlTWvighpo7ehpxkNFIMUck7kpTgoV4pcxqmmSuN/CUHrxZcc5zQnK8/eAoriYGiocTDzsaDRKMJDlO+DYkrS+CwBMdbHSWPRWXs6JWobFslUImmxPfrtfi4qabYxRrVtHggUdTTnWyzFYh4Lq44AFTrfn9/99Kip3aHrNc6NLHqNsBQesMVBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUO50IJiUOc7Eo7Kcg0pe2DZSqsa+gebygCG1uzA0Ck=;
 b=vCktv60Y+8FRoPOSwe7KATLbayMifuDDE74JUrG/Y1S/EUKTmnV7gJaXFN9BS4hYI8b9z9YaQESCzQpMzt6YLT/izcyWduUvuda0BI6w1Mysjyk3rMCkYFwaRi5KVnTIAuyoj7i+ZtMegtkN0YgKrBGWI1IJLKFsNuCJDWqFCGw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN0PR10MB5126.namprd10.prod.outlook.com
 (2603:10b6:408:129::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Mon, 25 Apr
 2022 11:57:54 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Mon, 25 Apr 2022
 11:57:53 +0000
Date:   Mon, 25 Apr 2022 14:57:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: dvbdev: remove redundant initialization of
 variable ret
Message-ID: <20220425115743.GN2462@kadam>
References: <20220424154720.1356873-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220424154720.1356873-1-colin.i.king@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0154.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:1::17) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcd32a78-9660-4585-ffdc-08da26b2d445
X-MS-TrafficTypeDiagnostic: BN0PR10MB5126:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB5126B0D1F0F8A1A95911F4778EF89@BN0PR10MB5126.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9KaeIHzKK3sKQBcPCAvixWvl4hytjVB2V1Vi25fDE0cdzIGyl0X0EIgqiNJtaieTA0p+oQ30CWv5722oIpUw1f5eeqn+wAup1a9GQDxO9wOPOWSqnr4WFefSBSsN+4uUb7P7JGf35rpnCYQend+oVmC0MDqKHjshitS6vmxJadWKHb2DXkZcWd/xwV/IWOaIC6Z2TnBZuZ+PNZ42M4aIT3Yy6dIZrpL9qEkuEyG0ROTqyHPYF6/mP/JXi3Mjkiefv81OX+9KnPDHb/zSzsCWmbKIumXDD/KHWajD6/ihilPRgw10XALlnc3o7/KbBo4IEntQZFo3ioGvSk6t4cUJjn5lgvPY3MIR5uzi3exuI0+ampcTAskSwbJwyiYOtgXD1AVZcWkVKb9ic7v7Nm99jaOaf3yU22gGQ/X7cnMLX54BFLVrvC9w0KKd8cYjVykL2zH7fuXHZaYbJGZ1I5EH7ELBRIzG+X1aL4KgJTvfI9NhjgSKLvABl7DG4jMW0QLSX6jT16zGUpI8VvbKodsmwghQBkCMpp2qapqIUhTly1t7Vr7Tl1vRrg3NcMJ16ehnfJ70/fccB7Zzk0mZKiZza9wE0vkY4YkgCMHGKHB42s0yTSXbAV7cH3dM2z2U2akAPd7fFnn9LFPohrhe7wbsH3roVF/kmHF9m8WOLb79N/+VOJmf+fD66kFTyjB/p2VFbcdj1j94SqsmwUuABuwxCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6506007)(1076003)(66476007)(4744005)(9686003)(6666004)(6512007)(33656002)(2906002)(38100700002)(33716001)(38350700002)(8676002)(52116002)(316002)(4326008)(6916009)(66556008)(44832011)(86362001)(66946007)(186003)(83380400001)(26005)(6486002)(508600001)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SFbHoiPJlru2NYH/43bBGCUVE9gHK4YRUo7m9GzY5lzF3KqdPszk4w7bsj+Z?=
 =?us-ascii?Q?sSlkftQXLxPzDNs8lBHfXcJefy/B6pb0tlMxIFF4jRc1R4SpgIapTMjXq7zC?=
 =?us-ascii?Q?FDb/LJuOFQo9ucpDG1O7yhCs+HnjNkEFPjbbzgGBvPuo74wBiLg7rHIzwN5F?=
 =?us-ascii?Q?+HLyvAL9i5PsdRRzNZDwoGYY8IOzOt8IPZS0xCH+lzZfllzZLgevlVUD5Uor?=
 =?us-ascii?Q?94FEEK1sDiR8rOsdmiFz2Wi5EEkCOq5izO5FVB6a/sYetj2sQr5A1T+Vfe1J?=
 =?us-ascii?Q?LAUhrLSzIzvnxafuPQ0N00ZnPRcncSMJ/HycxYMolX20uZrTQJ/+GBgnew4H?=
 =?us-ascii?Q?cWjrZMY7+ktamSiseVDz0zC+C5H/iVjZHEOQ7i7gNpA+neoH/wlpPim/GJ3/?=
 =?us-ascii?Q?frXVx4Sr7t+UgDH1acsflHqwLmiZ5STEo6kj9BAgwSq+tOG6M2k2sKk2Sz2T?=
 =?us-ascii?Q?HEV2tliCs86NCdulLNt/n/rd5SY5c+fHHpfLt8EIVS0K9U+ruCJSizti5ltj?=
 =?us-ascii?Q?r691c2jmR8dMpKtYCnPFYx4uA70QR2UbnzZpEwsyAffM7bLdteYyKiSEAxIZ?=
 =?us-ascii?Q?EjVplDsYxLBKzzzP7Jjg9f2dzTaNurambREtJHvjhS3PesjirBpqSz0SFti6?=
 =?us-ascii?Q?Pf2BDXLQ/CzpI+xg4mybGVqGSDNsHCIsd0jVcijhfK8qbNxp9MrlRnSA1YjF?=
 =?us-ascii?Q?riiSQHATT6NIch7UwN9TAjH+c82bm4PADP0OrauxV6M+Oj8rqDcLwAYCQvp1?=
 =?us-ascii?Q?iP5793Was2pNRgbmN953zj5hDxu55pySbzZv4X84CiiTcbWxvZC372HdvMJX?=
 =?us-ascii?Q?/Zo0tan7UVcUzmkfHKqsz3wDcXBIB8ByQCZnl5FFiFZfbes1lr0RAvg8DoEU?=
 =?us-ascii?Q?qKfQ9hfHpjFtAm/nhqKcaDizznsKMEjGYHYoInHUsvByNdQi7qHhD8JWrauY?=
 =?us-ascii?Q?SFrt1K+zJx9+RuYWFWhLCdVtXgi6LzWAlGPenkaEydsVL57Tzyc7NjvA3ZHm?=
 =?us-ascii?Q?3P16zxPCg75du+z0ANx129pzs9uh9olvuDiXCC8qrXc38qEHO2/FXu0sveKN?=
 =?us-ascii?Q?8L7HLqThXNkzo+LqHtDMRKU4NCCJmVIfXYaiaqoY8pnkfNTPHvyRjtT34fQ+?=
 =?us-ascii?Q?jL5wFJtTaBoScLx9BmXOH1BjHOZr/cV6vCSdoYdiDfC622gKsOqbSEQGCJRt?=
 =?us-ascii?Q?v34IK++7YQYqoCCLkcFim3r4Cglbps/V0kUW5exAVeCC6RV+s9t6resRAiBR?=
 =?us-ascii?Q?Xud/VsDSfthcom5t0TXs3xNyF+1QRAWDNl4O3YyEIKqxr5nzzOyrthzgGVcf?=
 =?us-ascii?Q?8B86PrsU7lh9vt//pRxflwtVH/hUA7ID8LqdSYJ/Qjcp185fIGDMzBKIdDR/?=
 =?us-ascii?Q?FcaCXkjnbZJOG6gnvHMSCxypgesbJBGglc1nmzqLmFV1mITetK+OnQLvaJea?=
 =?us-ascii?Q?hsF177Zw39LJ3UZgO5FJ8XYJd7IQEnbeinEzLu1kGNH7Dtw6Z0FUJrV1smGl?=
 =?us-ascii?Q?yc/6xDZ3AQmTBwONNymBjHQnFZGW2qFoPS20/pKCbHfTgzBLP3cpxeNYC6Ky?=
 =?us-ascii?Q?9CUdYxwbMF97FnC+6sVWWbr9yZjeunSZAIWghkC6anZs1VK4EzzCMuE/k6xv?=
 =?us-ascii?Q?dRq0Vdtoc1glamNk0j1cipYLfMYrHGiAF0MhAAD+7u2v1kFxvvJXR0lrPsgg?=
 =?us-ascii?Q?V7gskepMKTx0rBuBOGE6ai5OYO+kqM0qp7cFS2zVXOlIzeQKUlJgfnEdYWmU?=
 =?us-ascii?Q?D2dp3Cy5e/4D0M1ngxgCu9hWesK9hOI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd32a78-9660-4585-ffdc-08da26b2d445
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:57:53.8893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gmVQcyAjhhrLwHVsu3HnKc9872N5vOt8vTQDoeJQVibecUEHfIZe4+EbHwMs1a7U6HTt9MVinWdq4Olhlar5XVGKMu0/xCJZeUXO4OpmPvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5126
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-25_06:2022-04-25,2022-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204250053
X-Proofpoint-ORIG-GUID: gN1pfaj79-8TyrWkajUdNBqdEBXk27fR
X-Proofpoint-GUID: gN1pfaj79-8TyrWkajUdNBqdEBXk27fR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 04:47:20PM +0100, Colin Ian King wrote:
> Variable ret is being ininitialized with a value that is never read.
> The ininitializtion is redundant and can be removed. Move the variable
> to the scope it is required.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/media/dvb-core/dvbdev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
> index 675d877a67b2..d5a142ef9876 100644
> --- a/drivers/media/dvb-core/dvbdev.c
> +++ b/drivers/media/dvb-core/dvbdev.c
> @@ -243,7 +243,7 @@ static void dvb_media_device_free(struct dvb_device *dvbdev)
>  static int dvb_create_tsout_entity(struct dvb_device *dvbdev,
>  				    const char *name, int npads)
>  {
> -	int i, ret = 0;
> +	int i;

It's better when "ret" has function scope.  Otherwise in the future
when someone adds a "ret" you're going to end up with two "ret"
variables.

regards,
dan carpenter

