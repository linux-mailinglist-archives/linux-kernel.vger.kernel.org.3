Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D8F4F7269
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 05:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbiDGDCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 23:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiDGDCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 23:02:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE676317;
        Wed,  6 Apr 2022 20:00:13 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236LH0Lp004957;
        Thu, 7 Apr 2022 03:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=Egdx2QPumMEnO2c8JeWR5nMNJv8myOeGlnmRCkLnYO4=;
 b=RwViZjMEDdVW1fehFURMEMyZ43kuVwzp+DjWvEfCsZcCvupNJ5io4TuSa7YJJoAzzi7l
 oYY1Vb+IsVF5jrJM1ibfO75VyroMR6O1FRxSgdvZSTYZWMJhQ0WRvLV/GQxs6jA8eL4g
 N5ZW2flNxAxi16TmjbPOCYmjglb7vj43gR5HUN14CfcLN+ivQsSfIpSeHH+Ss6Ls6Icm
 W6selc9dqlg/pMITqswSuz5v5lHoAJzLTafB3pnkJbajDFcvo2uwcNXh3X2yYOqZuaMr
 YlHxW/mHyVcLYK58wDti1lEJSlPWXjB5BorVT9fTqpNlu/UyFf9dT1Jeghi35mBmmnOb kQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d932kyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 03:00:07 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2372qR5w005425;
        Thu, 7 Apr 2022 03:00:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f97wqsajv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 03:00:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABPfKpspbBtaMABnbSO88ERh8fXnHsg1J6D85E6CaP9RwosaIDH/SBqhDVBmA21WsMbf6n9Ce/4KFjSqVlYtl+rt/pxoJxeFTjJgbcBZuCBdzRV0bsIwS8S8I2wOVonNl9YBPokk5iRGYQJKJXCImb0n1uc7v5yan0mxU42JUgiqfdIjq3EUr96n7SlouuTSSUXkklIqtJNGwbmpGriOFAbuW7mtutPzyTMYQV9Xq9qFFXnlvgzbur4rPi20Kdslz9RKEfrBrNgJ6/VaeIEU0iYKfbhcVjQ77R20yCvYTGy8iuoE1Bca8NwyEyDeK2alphnB6a1LFBdWCKRv9GzcNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Egdx2QPumMEnO2c8JeWR5nMNJv8myOeGlnmRCkLnYO4=;
 b=f7VZOF7ZaiXnBYy/SX/KLG7caGHoXQhP5bB/+CF68WXGQZishpTQVDtXX+yqz+9BSGygLEw45gCFzEXrkG54u/4bZq0ehug5UQbWYZsMxMSzo3RjTJpCxXCMSuv/Xwx+dGj53SHxOR1GaR0tjKO2VkZzEy6keS626bcWhHAt7XDPHmiFt/LCBlJAPISo27AVPrjU7baRqN0Lamd4bfvpHtfmGAvy2B6LfleFTkVRkIsqe3gQQuOTwY8d9FLdwBGdoaIafSTceA/MqVoXu5kN0KKdcRwTEgFXo5RdfIdG6UXxi4sMT4jpDsaXpqlyS0AW1wSupSe9kZ9hirVAnBiSNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Egdx2QPumMEnO2c8JeWR5nMNJv8myOeGlnmRCkLnYO4=;
 b=slyKqpo2yuSUkHfK2mVDfeJx7j910CLSmkv7XFZRuL/w2vOtevDhpBXXKzCDqa/NoLersjkLYOojTI/o8nfdxSPR9k7GDTS3bhaRHpSu1hmyU0bgAbIpTHxqn21Cwi+7BW84c1scab791+PoKkDLYTwuZO7YjOehL8PytBU3/D4=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY4PR1001MB2152.namprd10.prod.outlook.com (2603:10b6:910:4a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Thu, 7 Apr
 2022 03:00:04 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed%4]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 03:00:04 +0000
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: ufs: ufshcd-pltfrm: simplify usages of pdev->dev
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1czhtlhsl.fsf@ca-mkp.ca.oracle.com>
References: <20220401085050.119323-1-krzysztof.kozlowski@linaro.org>
Date:   Wed, 06 Apr 2022 23:00:01 -0400
In-Reply-To: <20220401085050.119323-1-krzysztof.kozlowski@linaro.org>
        (Krzysztof Kozlowski's message of "Fri, 1 Apr 2022 10:50:50 +0200")
Content-Type: text/plain
X-ClientProxiedBy: DS7PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:8:2f::21) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4782bba-2e08-4bd5-ee13-08da1842b71c
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2152:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1001MB215223B7FB9E5F11120C2CF28EE69@CY4PR1001MB2152.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ott+YZQnyQvX/YlD0Ds2/NTPNhxMu3AcPtObJpa70zbaQuiHlIZ4uu3hofD25HgUWB5Mh+Otbjig/i6abieAEmWlHDTRSvpNpVvDGnSczaSswef1x4Q2BtYgqcxy2uvhpT6BhTc/sfzgYLmXtq18XtOhvPRDmZ5LxJOI1TAuqHrhZat+yteJ/Mx33JlIMB5BYbJ5JeuqPVhqMh0vqF429Uyxtw5lItyqFLm23mQPMZULmYYm5vULEXJBu5cJZi0e5UZbnYPDUw51k5aNPZN8QrKHSLVbZx14dTb7ZqOaiMTr46E33DH8yCVnKw0r8cqLP10QeoxNsehB17pHELUIBcJw7en8sZ8NSnGxnedysv7fmKI7cFD+eJ1qeHXr53oqpab3aIS0uOSz4VU194k4q/LlSGhuSm/Ig3rTEsDomCukm8cF9TF4Lb6ChCncyUEWeBsPzCKyoIR9dO7+2w279MngZrioBqDeo5X7q4vWikDKkTXKn2kRS1LaKxZFM2999dgR9ZSqCgyg82RYdSSCU06BnuyMRaMQyfRoLLP4h2qqJqODVuzdDkMHBIHOMJIlP9UbPvJsEMxJoZEw4Kt8g6pZkLX3UfnWeiHrkwMssgLnpdQtKRc3wAKe+4d/BqMgZar5ygZ1JHTc3Xj/w9ohYFb8w6mS7ulX/984Awyixf2Sdoxy+KsGoiGxthY7dHZ2/GHnddBD1eoUjoBUUxLQoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(38100700002)(26005)(54906003)(6916009)(316002)(186003)(52116002)(2906002)(6506007)(6666004)(66556008)(86362001)(508600001)(558084003)(66946007)(8676002)(8936002)(66476007)(5660300002)(6486002)(4326008)(36916002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ifH4S10A//OX4hMjKKzEBhfQgP4YoJrq2D+KFCZbTEG4OvQ1eo+TeU7dLDU2?=
 =?us-ascii?Q?k+kK+zphuOQY5WL+JAV13qx5pcmkeJIj4vOjhEdK5nXeSMb+RxTu07UqkfNv?=
 =?us-ascii?Q?oOgzKtSjuUsXEGjKiYukvzej2AN3rbzmeBssjMPJEtO0e1H9Doav5WEU5qwZ?=
 =?us-ascii?Q?juf3X9rT/31BNRo0vm2Qb8v0KP+uwlm+XqTaUJh5JZ0F3AkWb+Hjhe3Hyfe2?=
 =?us-ascii?Q?Wp5ZeSzmhOU4hLXEd2t9eo9lxUTh2NQWuJJFeL//ygZNXDcucKW5ENunwnVC?=
 =?us-ascii?Q?T8tsso4FN5kwfwwZfNV3Yv88lJ5oc9SrKhaCDFE4pB0Mx46VKq8cjex8ZuMy?=
 =?us-ascii?Q?IHTiTEt71UAK6lrBo7w6vp0gJhzbsU219S8CuxZCXkOxwHdPriUmANKitQBb?=
 =?us-ascii?Q?nzM8dY7FP/RwxskqrxEI+h8esSdl6XPW5kW2IpbGEYkSaWxRVDgmuKQV+sBj?=
 =?us-ascii?Q?xM9eIntSNmFxUhBgjy3gFfrq8NTz0ZXE5m7c0UFO+BbUWHvvxRxodF8NEJdt?=
 =?us-ascii?Q?DgLfFBxGtjUNjBLFrczfPE1DL+EEa1kekxLdehUvHeDgN8f7R7OMJhrTelie?=
 =?us-ascii?Q?6P0ZaqVZXbOc6VBxK4nSWozVjcsWAKoiaC1MWqskResHZ7wNacrCsZT153nL?=
 =?us-ascii?Q?y/idynMPs016rHJTQBay+NuBeqqUcxWpnsVZ1+AHuwRkfwKZk1NslCqyy3jK?=
 =?us-ascii?Q?zEaUHEaB1gUXoeahuBH9B2oub1xnqzrvNXAOl3G/yMqazpEq3lvhTi3ZP/Wh?=
 =?us-ascii?Q?b2uopZP83GeoZen6FRzS4lrhwaHNUU/PaYHo82DueK8hi0suOzJ/1fPtdv+A?=
 =?us-ascii?Q?8EbG/t1DRvP7qgnttRfCs7p5dhR1HrVgDz4SJxAijMwAUEjlAfLQmWG7yAWW?=
 =?us-ascii?Q?85Ec2G3/vA5CHwbyqa4OzHF/dz82sAgQeJGPXMVeFD2dNnd49xLilh40my0m?=
 =?us-ascii?Q?P01vIL5c4rrZo2WAGpJ91ftUYy54svtzwBiuETC6+qyICwKq5NI0lid9K9BK?=
 =?us-ascii?Q?KImY6fNB5xkZeukYPBqRjfJHhmQYJMYezpk2K2RQVgMOjrKq/J3Z4kDVQL2s?=
 =?us-ascii?Q?4zkmGm2cWVN13cT/XEmd5jYFVcm688zBac4hrCWX49LgNwgkYimKAeGyoWcA?=
 =?us-ascii?Q?CCnGgjWWFzWjOfvkcZIh6mGv5MKhhlqIBZeO/LfbX1wPh3VyXtfsErojUCAn?=
 =?us-ascii?Q?q51vhK0Wpc+5AmRUXooJKCKASp71M8OExp8gQQcSOUcPLTwJZjIc4CDSYAyz?=
 =?us-ascii?Q?fDi1PKM8mKbuf4muf8HHiIEYmVpAu1NZetn1bd2/Tp0X0kQO6qK0QcSJ9cZ/?=
 =?us-ascii?Q?LRVXZ0DnNm43t9isYdbw54BEt3TN6koasiMUgXfedJYfD61uaOsTzbiXsRJT?=
 =?us-ascii?Q?avSf4yRNfD/fulhRBe88nuhDe/6vbiQPWJ+ICHgLJprhVDD2fztnyLyDX+yH?=
 =?us-ascii?Q?lCQGrU/fkpVMOwqOkMu051wiXZlthGtmX2BhO+eto/yO6W2okHgaI62VF+In?=
 =?us-ascii?Q?neF6+/whJf5GWj3qFByLVWNnko1V1Swy8SwgCYYEQdxc1ec304t7lzDdojTM?=
 =?us-ascii?Q?zN867Iq0uXpGrPzemcxqxDX1v3KnqwOOkCRDAd1nvVuEaqlwME6bq9nT5IM3?=
 =?us-ascii?Q?ANhxlJkc0PAYpGnjY/bBobz86BXkl7tTNA2X8cWN9qOfJ7gYD/03xgbvCScz?=
 =?us-ascii?Q?/GerR/2NZMw/ldhkpMA0ms9nx0Qsz8UMh1jxRIoBGyZXN5c9Rnil33Jr/8Ow?=
 =?us-ascii?Q?Aw3+ee+lX80ay6yXaSeyoDEO4w++VYg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4782bba-2e08-4bd5-ee13-08da1842b71c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 03:00:04.6630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k8r+D8KaTkABF9kEmbSJdMU7jMgjUjU+KC4zuScnduMAZvsfUKrAB8vhow2BzBHMoSgvFj92tIjrjPLYUbTFtgpntedZSOsnqJSunodLa0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2152
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-06_13:2022-04-06,2022-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxscore=0 mlxlogscore=723 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204070014
X-Proofpoint-ORIG-GUID: p04x-vDcjrA5Zghdaq808JA6jhkk9_lH
X-Proofpoint-GUID: p04x-vDcjrA5Zghdaq808JA6jhkk9_lH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Krzysztof,

> The 'struct device' pointer is already cached as local variable in
> ufshcd_pltfrm_init(), so use it.

Applied to 5.19/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
