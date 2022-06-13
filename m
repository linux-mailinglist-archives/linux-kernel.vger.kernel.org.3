Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8E9549B70
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244797AbiFMSYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344447AbiFMSYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:24:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B803613DE0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 07:30:45 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25DDZ2Zf010708;
        Mon, 13 Jun 2022 14:30:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=qVQ/ahnyNpxUBy+k1wMLC47ygFG61eOdvJKVUMHCJsg=;
 b=oL1mXY3XSA99TmjVsP80VIlI+Ekczhe5UPquXOIrYT/iuJiNMn6dNoAo/cFrHplkPazo
 tGWsFvrSZR7P0hMmy+1m+24Ieg/hDHSm5pqydcC/Ptpcd5BA5lGf0xikIe+r1nTtvR0J
 fAth0nH0lUChOFszHyk71nSdnTKMKAH4lPzzdCWkVbQoq4yP/3mnpqocs17oApeQc0lE
 avA0B2jgeWCcTTQUZmDOsXsaRgWoitt/B4NpbaZs6+kgWpgoGrtgiTepFArr9BCk/BFs
 alCGiQ63X2YtptcWDLmAQmvJz9QH9BuCVIVhHA/9HlhWeaHp3/tFeVo/XjbgmuTPyvAT UQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmkktb8cx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 14:30:40 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25DEM4hn034769;
        Mon, 13 Jun 2022 14:30:39 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gp6xf06b8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 14:30:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qh/apT+fFdkMQpO4Hg9UwEHww4GLbVKe576NZXz4W6FYyYsU1Bf80Gpg9QBMZ/jul0tHK1xOIj5dUeH9DQUUhQF1QTECRGBpr2ClDhAAE9NrTkSldBwPfo3ea5h19p+TxIvQiS4cS9avZ1wfSuxoM9LPsD5+QjT6xEj70Di6BD/xVEPH556Th/1P/E7Gi5kccnoCMU6IVNeF3vm0t3gsMMd8R2c4ioyW5S01pG/KWSX1zTiWgDItEAJZR2MlZDp1rv13lEUC7vfbnssBo5jXf5yZiZV7n48jGXOgW4Gk3rj5eLskaTT3zu0YZBlXgY92Jj3jozWUYoxlFylQW79bkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVQ/ahnyNpxUBy+k1wMLC47ygFG61eOdvJKVUMHCJsg=;
 b=Ji9niEHD+FZWAz3CA0SUr/uNut/c6MLSb/xpy8/R/tsFOJdxJvkq0h4F9YZMmDtiA/PyGcvT/tr79ZErrMax18QUuwMf1lTUeXZLd2SMdiNuo2gzPk9p7zpvJrbTC+DKRLPG48Ru04Ep2d0W735ckqBNXZFzfUiFPXoop/frZvlR/REapAaZVNa92aDGshpwDTWQwTeYvPmaPamSHe3InLDsfFed2Nfw4moe4tICCwMPTYS/RV85jiIo0mJkNpk06M6jEhqZXv/5kPHsA8bCjEatUwgquL1QmBIQ0KRb1v9oyNII3U1U3YEPvLTGzzkLjBGcLNBAYlZczjptqUduJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVQ/ahnyNpxUBy+k1wMLC47ygFG61eOdvJKVUMHCJsg=;
 b=Fx06MOUlvTONMeR2YiQdK6wnn16oav0sallW4z18nGJ57iqtCQS9vBFxAfUeAAmkakzZXGw3klpKTw0wSOW/BbqcOucvYI5ygGBj6tZpzYV8Vf6+V4Iu3pMk5nyiE4c2NeaJj9FcnG9rmFsi6C94RYbfi0FGCp0MeI6xCjY8VYw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB5794.namprd10.prod.outlook.com
 (2603:10b6:510:f4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Mon, 13 Jun
 2022 14:30:37 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 14:30:37 +0000
Date:   Mon, 13 Jun 2022 17:30:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nam Cao <namcaov@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, phil@philpotter.co.uk
Subject: Re: [PATCH v2 1/2] staging: r8188eu: replace LE_BITS_TO_1BYTE with
 clearer codes
Message-ID: <20220613143024.GE2146@kadam>
References: <cover.1655019752.git.namcaov@gmail.com>
 <4cdacd703158029c0b0f706e3cf1eb8daf4121c0.1655019752.git.namcaov@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cdacd703158029c0b0f706e3cf1eb8daf4121c0.1655019752.git.namcaov@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0118.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:33::34) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46ada9cd-6dc0-4030-7c48-08da4d49486e
X-MS-TrafficTypeDiagnostic: PH0PR10MB5794:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB5794465C8C98EB40B43AE21F8EAB9@PH0PR10MB5794.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tqGEppUm450+l1uHKYntBaZUrBWY2WQ4Ys2QZ0c/hqTK4Xjx1EXi3XtJkyiUH0ca38Og3c2E5l72qB+mfrC1xnYiEetJHq/nQ3ClfHEkBzHZPxZyEmqZpoLL9YjKz9OYsDe5pibVFa9aArkLrJYtPF56XYx6OQpvQ4VU5HZFOxGeksUckKOsLvDrYjZxism3uGcAuXQ/xp0V75i6l2yvMe/g7u5r++0gY2NpHuNfvdM9Efqgcjg/IrVNb+nnF9lewF/Dr/jOnGQRwQZC29uzmP4xXF0JzyKfwDAbpQAok06RdZ3SxIKeaEUpufjz71bLaN0cLd2jY00e7roFx9l7AfFJb6lOwL1mAN0Tbs/0wnN1elr0mo2cH1UgWg8qI0bFp2KJfxXFSsYfThl5rXvvyPusB/swAOIIrA4QO9CIFIb0Nulc95eYoSMamF7OmdZF2L0PcWWFykxnZNcd8I3yi94XU2Xcr4kIjHE/gJImNLgVCHeiS645ZrWJtP+U03lVmrTsF+RKWh07ZxjVf1mONmo09SNERL3D+hH63uhOPc0WRSWRKQRZOz9dJeEkYIzePYaLS5KnT8f6cnH/0lTY5KInlzeq99xzZdL3HE3/siLqB+8HBrd/ea3fgYX61Q3Ea/BYSPkyHQpMfFjN4+uLT0CD5WkA5eAfsU+7GUfWucjP5EUPgjDGLPEVT6AMpvYMA9fqdT9k5SSlcEwIzF9x3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(6486002)(508600001)(8676002)(66946007)(2906002)(86362001)(8936002)(4326008)(9686003)(6916009)(316002)(1076003)(186003)(6512007)(26005)(66556008)(66476007)(6506007)(52116002)(38100700002)(6666004)(83380400001)(44832011)(5660300002)(33656002)(38350700002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IDYxz5cfHMG04gR5i23OyNe4iPOqxr5JUAbk6l2U9WphMdiR3woJo+9gKUZn?=
 =?us-ascii?Q?GEohN8i0JaIHMhfYwnrF1QpT12RNnAsO9SxQqcwy7q1otaAhALQcXCgGiHsF?=
 =?us-ascii?Q?shrLtn3v3aY6Z9Vt18YfjegG5p4F4AKE76MyNpalG6hb7Aen1EPJHZ2eIy81?=
 =?us-ascii?Q?HM3TevySwCRPJAxYi5HmNqxHVDVNyaZiGYNhClBu+4J04yKSMEnYKMcgg6Rr?=
 =?us-ascii?Q?IUyuLOdCYnnJWih4eKKyPwHdm7FoIzX36+6gXbc6UYkXgz2KiLd9KpPgJVmQ?=
 =?us-ascii?Q?fGL48dqmQhjfoBjUmgKpEsPFtsxXWbmIMm6hqzSHgeJCN+pMt99VZjPimFv/?=
 =?us-ascii?Q?ZJ+chxdqKaEkZtuaeD0o8bwI2AABUMdPgFyYvODCQL+gpKH5yI+ileMLDGFS?=
 =?us-ascii?Q?dQ+xsq42exuS4gSfpJSZl+um05x47yQMVM1cy+2AXJbd1qe2aVtesDDnUz7s?=
 =?us-ascii?Q?l3U24eMgI4a9xs+VVyfRK78abpVFxIbr/z2JyilK8zmFQdrnV429JnTTrsar?=
 =?us-ascii?Q?ruc8WTEROc0DXjZjYg+IhhfiOhGdFRZXIjIVzxhE6vRMF+wLiewthEcfZ09t?=
 =?us-ascii?Q?RCTyoH8X6GzrciKbAF1OolqNsXDvC0gD13LdGfpuxItLeU791HT/3C7rXCLZ?=
 =?us-ascii?Q?ulJZKTjWnp9/95BeeIZCB4ba/Fd2tC1BxBRHE/VngE+B0u10LQ2XZryhnowh?=
 =?us-ascii?Q?fm1slS8sBwwWe7wqpAHMH44fXVWQIyOkFY7LXgi9cxmMeC0uTJom8JDdbx7B?=
 =?us-ascii?Q?122osTiDLZHFfBBVzPAHKyKT82y8JiIcENyl7/kKbOV5l8KWdP1YmDQZM8JF?=
 =?us-ascii?Q?Q0r0efQE52c+Uv13Q/1Y2Qd+5SJbSn79QGbwp7aCeC6D5C6mOzGFqq847BFN?=
 =?us-ascii?Q?VLXj6pTiB9Fu+Kh+PWqtVALCWHFAaLBEQSuAzx49M9ObWis6VMFqc5bfrpeJ?=
 =?us-ascii?Q?wEHtPMEX6FRr3WYzbmveNK494Fsom0el3r1+GaOuJR6mtrkG6S+8m/qcSlhv?=
 =?us-ascii?Q?sWxrBae4vVm62aFpVNey0IORCm7Ke+p8grdAgFm/5l+Fw26/un4bHHEbzdka?=
 =?us-ascii?Q?QJxoubYuVJoXDV3DbuJhw8Yr4eUA00j/RmWZJv/Vt/XLuPCxqICornL9uyvy?=
 =?us-ascii?Q?01Gl8BGhaY7dEloAapzgSOYIQE5g17Jy4akhSFaPiBP5CaikvFGVrMqTzv/U?=
 =?us-ascii?Q?jOweV06O802gLw/s72d922TVSyzyGszkSXtJZ+iNpnf9bY8iReaDjA+n8jvn?=
 =?us-ascii?Q?kYFK8RVRHRv+hOYz+IBPwFk8tyFzNbf4vBRWhMR1Y6gi3KgAsmGNxlQSyCX0?=
 =?us-ascii?Q?47DeZClNEmrgHSqc392wk5CSp4FpM5uQRUdQDL/H081Gup7RcrI3XgiwAfdA?=
 =?us-ascii?Q?wXArxh3PdhJVJyp8ghvCcI0Z4ysHjn1JdrXgehDPO3vT8be19nOy3SOm9+gw?=
 =?us-ascii?Q?mg4+3y9PG5Sy1K8xh0oKxWmYiyGVM3Q9iPPSFlDpno016KzJ0sjx67GbSIcE?=
 =?us-ascii?Q?OYG/hRNVNHYKzg8y1ucYePofbP+t+IFVVrJ8B5xtNhYo+SyMx+K0eNCQaQqQ?=
 =?us-ascii?Q?vNEsGSl0UZb/oek+XOxGbc4ARM8J6houOoN4IqtVOqQgmr2x6CaTTttmN62K?=
 =?us-ascii?Q?U5MNBVH5UZ5JiIB5jmQgk/qGwHjgKfeXd+POv1/21b62r1KkZQfW15mLSf7y?=
 =?us-ascii?Q?ZHLsqTc0IgiBqwPnI1oRfiSm4vNa7YRGfkpnZh91wWFVO2nhJkNH6uCK/SLE?=
 =?us-ascii?Q?wb/BhyhHsjQy2icPoWHywxlpDOUJP/Y=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ada9cd-6dc0-4030-7c48-08da4d49486e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 14:30:37.4029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GpdP5g7+GFB3hib7hmHYDFW0pX7VUirawKhtJJl5IKG1wOOkTh2An9EXZbgCP37eoKQRQq5T6lxJxvU5WP+XomGcGvy7xPMhyjsaPS4wM4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5794
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-13_06:2022-06-13,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206130065
X-Proofpoint-GUID: bSudBfHd1Hz2yZ7Jgdwwoaq6R7QJrcPd
X-Proofpoint-ORIG-GUID: bSudBfHd1Hz2yZ7Jgdwwoaq6R7QJrcPd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2022 at 10:11:43AM +0200, Nam Cao wrote:
> The statement LE_BITS_TO_1BYTE(__paddr + n, 0, 8) is not obvious on
> what it is doing, while in truth it is simply reading one byte.
> Replace these with clearer codes.
> 
> Signed-off-by: Nam Cao <namcaov@gmail.com>
> ---
>  drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h b/drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h
> index 20d73ca781e8..79e4210c6b65 100644
> --- a/drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h
> +++ b/drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h
> @@ -26,15 +26,15 @@
>  #define GET_TX_REPORT_TYPE1_RERTY_0(__paddr)			\
>  	le16_get_bits(*(__le16 *)__paddr, GENMASK(15, 0))
>  #define GET_TX_REPORT_TYPE1_RERTY_1(__paddr)			\
> -	LE_BITS_TO_1BYTE(__paddr + 2, 0, 8)
> +	((u8 *)__paddr)[2]

Instead of doing this, I would prefer to just get rid of
GET_TX_REPORT_TYPE1_RERTY_[1234].

regards,
dan carpenter

