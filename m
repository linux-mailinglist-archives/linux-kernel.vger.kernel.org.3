Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E151A4EDBA2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 16:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237488AbiCaOZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 10:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235463AbiCaOZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 10:25:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695D74198A
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 07:23:54 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VBhu7s032355;
        Thu, 31 Mar 2022 14:23:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=B0534+qBMOvzBE0ox5Q2IuU7eTCJ/PIO2EvNW9HJMqI=;
 b=KavlXjhlejW2g5IbtzeLl14keSzqIwntQ7X1pqcKBd/k/2t8BsFvtGSyEoTrg9SU9Wu6
 zphxADYidzwVd4I54MsWFc5eVa+tyYpZeBOo/FPL03M+ZaHVCmrb5d+1eOoMLvsAPuTc
 MCOTQjU9z7tDEXTvCrhaZvrANHE7fUj9pkKxz6oV/pjkjPhvit3rWXwLsoNB/Hy387UH
 0Ew2qAw+DxLYS2cOtxHSzIoM29pae/dzWFvLKX7kR1fDtHqKWTO3Xf1H8PcDQWa778I1
 WHjRLQtD0aaLfZTOrBO3v3n+IQMUVHJjucdflx94q423LX1lx17jNM8xK2+6NHwhYrI1 ig== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1uctvqfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 14:23:46 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VEG8M0003436;
        Thu, 31 Mar 2022 14:23:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1tg84wk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 14:23:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjWMo0Ml8PHkWNhqm4kpQ0qPeaEIrjOjrPD77xWODHeDvuHlo0l4Lahoz7YcQZSFS/D8opfddptpCKh2TbJQzPFWOvzcRuK69dVi1wTDQ8iPLguVNwvQMY8euMnTiF7mIfhew7CitXRsWedhfIhftMjO02oSfpkEJgygNhuah4vocEXvxwN06GVcxvsQgixnK4nJy2EFXSoG2BZblAPGqnAPbAopGz9+LCL2nd/zUR/+0RdtNOIQnljNtSpU3d9Qi6XNS2ZW1ExN+Ai2A+kaGDnoUzbMic2eudxMaXsAuvsCLUm/3GzZhkP4dNuNJ5eioNOJ39N7m6jF2nWqDBybeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0534+qBMOvzBE0ox5Q2IuU7eTCJ/PIO2EvNW9HJMqI=;
 b=V/VxTwwY++8M310O5LjsfQgDTiZjTYjEisn4S4Kw2WhfF+aYDbiXJhJJX+ZVaGp6xUtn6DWF6QC0JL5QRPAStb/aeyG9rwzeDABGkuNg6HDKaSI/Oqj0OHKJ+u5QlXsxkpegQJVys9AdvrUwZ54w+fxvEN2/OhMUZ3a3K8PxhnrbBIpW3Gqej7g5GYN7z36Zb5sHy/EWrOf9bQNDUEYXh7M+TkU1/BF+gcu9jZF06YW7Z89RK5IDFonLuIQYEeMMIazS8EgjJxRPZGzPI78OSG1PKMWzzLm+qYTmmu/4WbqONySgQ/VTvad5zjs+p/PEhim9g9eOTJ+GD5CdauhodA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0534+qBMOvzBE0ox5Q2IuU7eTCJ/PIO2EvNW9HJMqI=;
 b=ddlvIvd047eCgPZvS+WRSfF68rjEHHU9pbT3xa2uvIeQcTAf61TX7XfaKb2TkkjhrqK7P3ZnKP6sR9zxwm73TFIvj8al90lN/blS2BqsW7EvqBYsNDk42xX7XBenodFftsuEWxmtO1S5G5Oq6QT7brUr1RhCAlaSRj9KppD1ppc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1632.namprd10.prod.outlook.com
 (2603:10b6:301:8::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.23; Thu, 31 Mar
 2022 14:23:43 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Thu, 31 Mar 2022
 14:23:43 +0000
Date:   Thu, 31 Mar 2022 17:23:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Bryan Brattlof <bb@ti.com>
Cc:     Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>,
        outreachy@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Fix No space before tabs
Message-ID: <20220331142323.GQ3293@kadam>
References: <20220331130948.74835-1-eng.alaamohamedsoliman.am@gmail.com>
 <20220331133744.lypehhmz2wxngvzl@bryanbrattlof.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331133744.lypehhmz2wxngvzl@bryanbrattlof.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0055.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::11)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b704d7e4-c39b-47ba-4251-08da13220f0b
X-MS-TrafficTypeDiagnostic: MWHPR10MB1632:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1632A8346E05A29AE4A8ABBF8EE19@MWHPR10MB1632.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1VNqU0DAdU8lQIbbqDDHaDl4IoctCgyQNb5dAZEnzG+HUmUQ1g8FxwFV9Be0yue7cY6Lw4/4qPv7hcI3SrpMRkvmmw2Z/1atRbWy+k3FUx3CDm6+VgKsIR5Orurkbgp1bVfTRiXvv+6QnEZ7sWUSGk/FjVc+ksZZZ2jsuJe/dJ6jJFEazGnWlkXV6mqk+SP0Ix/UJZ82/yA2CL+JVM+XQIXC2Q+Qz068mn9Ot2PU/qk5/xt6fSNvF1R/e9hSL9UmYlkbG1UcxaQl0atHXjBBXndwHyChpdOOD6Mxkty2JRFsS6YCHXGkX2t3PNwQuB41mgQf1Q/BqK3z/D+9+9HfBgiGbawz6huIQdZUDfPvJsNunrrMRuihmNGIXdIFJdqLC9PuB3hhwR1RE5bQV/Fyp44I3K/JrsqSs4/dQqs7JeLJty6a6A6Fy0x33lENKDIo2XAGiB0GBnpPytc5xhbJr9R+ZTyyb2CWKbSQmLU1cYJDtUo0dE8XV2F00r9XfwILQT84PxNoc8LMFFHWDAV11gCSSuh1/cqPDjhwlcd+oaBM4ByChcHteT7BTSX9pWuzJIVHS7vFBzvNBIzySzjHchR8QgBPqVdWatowfXO0Jcce/KKJ4qzJBXDbVYLHRdjO/GQlbgXy/xW1Uvl+KOGpUTNNzEtfLpRp0lJ6MNgiHIv3+iVyyxcRtgo6IEtOZFXmcXKQyyb0RVZ1xnwtSzUNRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(44832011)(4744005)(33656002)(6486002)(33716001)(38100700002)(38350700002)(508600001)(5660300002)(6916009)(66556008)(66946007)(66476007)(316002)(8936002)(86362001)(8676002)(4326008)(6506007)(1076003)(186003)(2906002)(83380400001)(52116002)(26005)(6512007)(9686003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gbJdadM1wY1dWFgrlN9Doo1YKkt5Q0gVBITW8JEsg+I3H+tu2ao1WonOOXTJ?=
 =?us-ascii?Q?arBBL6JQ94qyq0ko4To1gh4FdwBrKKh79iALd/uk7Ca+OycShtSeZmZ5fxfJ?=
 =?us-ascii?Q?IsU4Eag3gzdXSDIbvfM6SrT0BOnzl5zHFQfxu7qNZeJY566i3LemKtutAir2?=
 =?us-ascii?Q?nykTvB2sgmvakpC/OaRYS16AbV7zXcmFbm6Al2gS8AY8bBSfzDOirU88hZKH?=
 =?us-ascii?Q?ec5q2p06E98lWF2KnCClnExKqFwtb4K/hrAoqgaFZhjZAANnpFY0aKZIHpfh?=
 =?us-ascii?Q?51wZp5D5rY6PJFEHg4hviGLTvRHFy0Z2EKMgSeo4b5XcJY2qZfmKOZ7qobQ5?=
 =?us-ascii?Q?mqXfy3acjw6157D3OJ8weUcSxpLwV9c/alO6sHeo2EJ3B9HMNtyJFilPzDgI?=
 =?us-ascii?Q?12LA2982cDSLdQXwPkVrwt6KIaQCtm63IigRRX9VDYEGaGepW1gKYJ2LRpVR?=
 =?us-ascii?Q?UCc2Dy5REwguY8cId7hBxywrZA4R6CNhFOf9+0gnr8gr0/cw2YxbkU5g3ga3?=
 =?us-ascii?Q?p818s8S5QgQw3PfkVzDxcaTUqQMJWBRajecbbLN21eTYBExMibls1kTL6yET?=
 =?us-ascii?Q?8sHabiGXk2vy0KmVD6jrwIG2HCdOZuAe/o/yaT4dftgi99N/O4fgIVNr8fOX?=
 =?us-ascii?Q?638c3tPph7LI2FiO2wLgchOKBL5I5a/MkGbnbM9YHCjajfiaTAw/0kkef0SJ?=
 =?us-ascii?Q?TMTEukHPTsr1eZwwh/6ybeerfqwBiqJ/AokiXcDN7fP8dCFvxZ0X2cKg0549?=
 =?us-ascii?Q?HeDebzn6a95QINm9yPoPUDMR6C4u3IGlU61NFY/tBaU5EBuIm5hL3Bz/yWMl?=
 =?us-ascii?Q?NbEcgqinuAr/qgnruq0s4B2g7Yy+2UlVhcPrNiKiwcLJ8EVjDargzZq72kRj?=
 =?us-ascii?Q?7znJ3g8nHXXx8fe/oJ8K4rSmU26f93stCU2JOmM+Cm88dg7VU1fryG+nm/PE?=
 =?us-ascii?Q?yugMVdTPgOZcP2Aun1g1DYW1HoaKHEw86xhvC4ncpdTY7/TKnxcU3rstfWRu?=
 =?us-ascii?Q?fd6lh/Ssob/vxCVzYY+5LgZg1L1GZpxHD7JKefXU4ZDBiyvgRol9HZAztmDA?=
 =?us-ascii?Q?kPs6ddppekl0aJ0Ftv00FccMoWHrCiWFYZejLsdtO1QsEVUTAS9Kjn3+pM7A?=
 =?us-ascii?Q?hJPX+u/pv9UBKI2EFeJZw8KsMXL9BB8Cn07jGORFwNW+3o7P+kEiWNUG8zCT?=
 =?us-ascii?Q?D6Y9imEiwbX80TNqQkp7Rr6FuccV4DQ13IEkEfofmOiB7EutBEGO4P7pKB8C?=
 =?us-ascii?Q?rigV7fctJ98jIYRpkRWC38jwhq4UFLvIfwQ5h1HAA8KoKTMXFqjJrokGTkhc?=
 =?us-ascii?Q?KFi1TzDSaAW6qkl/s8fn1r8x4Rb63TBcnhpTKQ0cXyFlWb/ppUOz8J3wfmzx?=
 =?us-ascii?Q?j2Fwd3Nrqy3MCeBjSe7qk65dfeutKuzwdm/AWIXiNY9/HeA8SHRKAiPE5sHh?=
 =?us-ascii?Q?av1d7Zr7qrn6zrqD9JyP6WLJz9KtoY7wsuVMhhvGA7kL+h52nyZJMSHzNble?=
 =?us-ascii?Q?bJDTTMzPEh5Dd2g+AjzYoCxTqHrW4sjWrp1jj54aTbc4F8I/M+uc6kyXcyW9?=
 =?us-ascii?Q?kMZdNz8jx1p8xca3AWwE6Y6kuW7DeSEVQ2/L1MhRKgl67Gx6AjtwhdXMDhL5?=
 =?us-ascii?Q?v1XhgbcdxmODmU9ZENZrHNl/3in38sdzj2A6mOFqM6/Ew46hCVK3wXpwZYPa?=
 =?us-ascii?Q?ukjpuzBzkV5AvFvV7qXqFPeg1wv14/Nr/5aBKVUZojiuUjrY3OjUFNmfg4l6?=
 =?us-ascii?Q?hXEAPQZfcnIb2IhXqP72NNINcdLhczw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b704d7e4-c39b-47ba-4251-08da13220f0b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 14:23:43.4339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PYc0EFmY6Q0bram9ScrgtyfGaqaoSfVnCRqBtnTrvj5qUtYJTisFGsNJC0ME8W7yTRiZrkIGkQgKkX4uPLkU0vNXCyVn++KlCJmoVB2ZD58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1632
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_05:2022-03-30,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxlogscore=934
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203310080
X-Proofpoint-ORIG-GUID: b-eNULgfwr2VOYXGCMgv_7htkxGhZkdQ
X-Proofpoint-GUID: b-eNULgfwr2VOYXGCMgv_7htkxGhZkdQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 08:37:44AM -0500, Bryan Brattlof wrote:
> > -/* 	Created by Roger, 2008.10.21. */
> > +/* Created by Roger, 2008.10.21. */
> >  /*  */
> > -/* 	2008/12/12 MH	1. Reorganize code flow and reserve bytes. and add description. */
> > -/* 					2. Add efuse utilization collect. */
> > -/* 	2008/12/22 MH	Read Efuse must check if we write section 1 data again!!! Sec1 */
> > -/* 					write addr must be after sec5. */
> > +/* 2008/12/12 MH	1. Reorganize code flow and reserve bytes. and add description. */
> > +/*					2. Add efuse utilization collect. */
> > +/* 2008/12/22 MH	Read Efuse must check if we write section 1 data again!!! Sec1 */
> > +/*					write addr must be after sec5. */
> >  /*  */
> >
> 
> I'm wondering if it would be OK if we removed the change history and
> tried to align the indentation a little. (This may need to be multiple
> patches depending on how everyone else feels)

Yep.  Feel free to delete the historical info.

regards,
dan carpenter

