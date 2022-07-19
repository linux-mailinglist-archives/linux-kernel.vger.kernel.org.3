Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C2E5794D4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 10:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbiGSIFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 04:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235828AbiGSIFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 04:05:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719A03AB2E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 01:05:01 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26J3i3Jd026655;
        Tue, 19 Jul 2022 08:04:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=u/PAcPBvVomy4dGAWej/bk3CoGv3m3Q2tSAIY1KFluI=;
 b=xP0sfHae5Y7aJb/pl955DtOPh/qx+IQ80CE+jSWzBcfq591Q582Q0uWu9+9K5Dzxuchd
 u+Q8zsa+9Xzr6W/SNSizcKNn+oUJLJl31QAy24AOw0KTxViS8TWk1slCikKqyxVMsPtu
 MzKRMGsQ96xSfBUM6Nd6EczrxCSAzS402Uu/VOn+pqU1jtqxQrHitQ+YRlGhMH4vd2oZ
 fQNEe+aMyzRGwPx84NKxUn+hRQZlDy+kg7XP0cf0Tzod6ZUgGRourCCE2RDXfReEvxyl
 o0Fgoahs5skQIR8I2WD19WZjlQfBo10GTBcYqz6ak59SCXsAUrs3M7x+Y6oHQIOFV882 7g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a5cq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 08:04:53 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26J60rbH001331;
        Tue, 19 Jul 2022 08:04:52 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k34xq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 08:04:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDcC4EHcZaO2jgAq6ae3zq8Si91W20hui6roUd65+L60Z82QRrmhHGqsruKhdRxat9wckqDAaUEmCC2RkIsys9b11slsvxr2yzI634qPbISg04W+cOYgvsZ53k22JWwjtOahX/T75uPG0D5rF8rziKU1fItCkiO9Pf0+JBMXNWbwoQuEFGcWyfH0DsgqPToWNvXkr6E7ArkEanGwN0elByUBni3j/eZJZBG9f5e08nLiULIFpQJ1HkW+c747lZqloBhbi/Oz3d1NZQ92/M2ejnGPGzr4kk7lrWkotbAgQBB/SA+ot6r8ekYDeuVN9WoVK9AcLPKJuQOcfEyfvx0s4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/PAcPBvVomy4dGAWej/bk3CoGv3m3Q2tSAIY1KFluI=;
 b=a+J11wrk2k7zwzD1dpNLKoTJ4NordpW7zSyTWIrYlC1GWgZNXqFTKWESLisrXt8h1tpxxWv2vpzlxjWMj0Ez8TMyyLdzTEftB8nfCz//cRZx983rds0JCTydP1XFjT5siR8wiD7u/ONByVn7rERszvU/9zO92uE8/oQiKEYKcZlGnjzhQ4VcHd/hVoU/3UDJrplqpNTwWb0+Yi67amweWJ4JpkeFj+cC0+921ZRai0oGChg+r4ZTZuddFQBdJ/InlaPY6oWD6N+tXHlEdi/ole1dCfuZ1LezT4gllPyukZhUMm8jAPXsuRNKRa8HV88pwrs0ZrChMjz8wVkNkt+A6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/PAcPBvVomy4dGAWej/bk3CoGv3m3Q2tSAIY1KFluI=;
 b=bDauIAW7ttrAYF7ep9PHsVEI7AYNu2KdRrCt2uGVHgnvJiXsEqOo5HkT/DgUdHODdClUmLRBzPdeXEWkjDcNqGkvbqnr844Dt8s6OhHppVqQtbn1U1r8ZTaNxoOV38PqYvSwl87O/vgXrcLPSa5SXpN4tc1+Jh9hvMwDm1LnZZw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB3946.namprd10.prod.outlook.com
 (2603:10b6:5:1d2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Tue, 19 Jul
 2022 08:04:50 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 08:04:50 +0000
Date:   Tue, 19 Jul 2022 11:04:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, Zheyu Ma <zheyuma97@gmail.com>
Subject: Re: [PATCH v2 0/3] staging: rtl8192u: fix rmmod warn when wlan0 is
 renamed
Message-ID: <20220719080431.GY2316@kadam>
References: <20220718120149.GD2338@kadam>
 <20220719055047.322355-1-ztong0001@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719055047.322355-1-ztong0001@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0043.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::31)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69c21fb3-64ea-41a5-2a9e-08da695d5aa1
X-MS-TrafficTypeDiagnostic: DM6PR10MB3946:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uIsd3Rl736PJUoNYK7w7ApBy2V7nawJsc0vZFPsosXptUlmlt7cAuft3noc+wMm4lUvum2Ta3ZCSW6dZzE7daDHPzoTtblOqcVLuVjAyDa0pGaAaiH6l9YmPgyyEUbo2OtoZksdsh4X7JrqO6T/0ZMeWo2u0NnWLBiANtp2+TU2ZWQPuG+UjYh8QVV73BXv4zKhsyB2HDGSv+RhQl4yd8oMmybxE8Pu0iVKiq8x56dkoP7S0RSnwyaWW7A2Qcj/5n9M7UIdosvFpPlD/Ly0GXOGMQ8hY/PNnUt3Y1xThZoMjSPlQrQOJ7eaHMtEL4+Xwy/RWx3D+i4SqbM+ihCxobQdT7kUKuL64h1TGaFgugeVRoIxB+lOTasfkGWPCDrjLNs1vORNEPCLD82qDv8O2/YNIeO220i2oxBsUhmDF2lgzBQR/qtYhu1Yk/IIwpY0ivz/hO1zirwNvNpabP5K0MlAli9xUjUydXM9GeMf3yHTH5s4XzGWfIiK7Cyw7ASQCn7nxAI3NPw7UP9zQaCTSCw1UG5z4PaqNMEgxLnKDNHreQLHmWHKaq33TlAahvJPjxUtKxmPsUGL6p8fpmzSUFlkmHFmskZIYsZ/49UYdGJK2mNwnwPfqPHZXOo30W7XG82rT3KsNk7L15NNtVMFBzQAzXlyCgIUe0qHOJ/O02P3Eg6r5Wl5NnpR7bfxzXsKKxFqBPzJPuzsu2U2Qs+mMI8sFiKxthU64LaqCDEXHxJNWyVGYhWW5zDy4Oj8CMzYLipxMQ8ySxLiqfCutMGdfSl/GCyp7M73nP0E4yKxBslY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(136003)(366004)(346002)(39860400002)(396003)(6916009)(4326008)(54906003)(5660300002)(7416002)(66476007)(316002)(66556008)(66946007)(33716001)(8936002)(8676002)(2906002)(44832011)(33656002)(38350700002)(38100700002)(86362001)(1076003)(9686003)(6512007)(6506007)(52116002)(186003)(6486002)(41300700001)(6666004)(478600001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F93Z3L9b1RTLXcIipDglMkyMNsk7sHCXZHMMghSdJQmGOYWYTXig7RzxGu+t?=
 =?us-ascii?Q?quqk7bJleXLHiOCJwbUUxZ4CObQEZZVt1A4sKeBhUD3om2L5s5ikIiVJqAFk?=
 =?us-ascii?Q?P9kphHFPX4YRSUFMEmu+1ne8zen/4YtnV0af6g5tWBRhfjd7fEolGUzXupYv?=
 =?us-ascii?Q?qog2WIHzoFYo4+IWrCA06cf2LnR2rw4lCy0zsX9uXi+/CLQXSz2ibQRxWV1O?=
 =?us-ascii?Q?PxWPTGbEbXt/OxMRWDayxza9odlvy4APCP299rG+kvnR4V5LeD8reM/VT3vy?=
 =?us-ascii?Q?vH7qwq2c+cRPYjuQtAz9xFjoGIyXSlyw9OaDUs7RE0Lq8VIAjjSDyCMIqWDq?=
 =?us-ascii?Q?lX4dv1Ud+wNXTN19lMB9gO7LYB19gikProEU+EbfhuMN19w27YI6ywP/MddE?=
 =?us-ascii?Q?rff988yMmjbP/T7KBB5B/g/EjSjsXtSfQ3gvcHLErE1QkbMpihX4QGd0Ujpc?=
 =?us-ascii?Q?WHwowZ1okTarICrUl6wfAtJ+i2ylqbH2yukma6C//UrsRoqWXC+EUyuSjpuz?=
 =?us-ascii?Q?p5qIcHZxLD7WX9ElQ/RgnWH+GM7PtSjZD7QS/3buPM4+H2w1rJ2I8bqPW7eC?=
 =?us-ascii?Q?mKCSIqJYrTHC5pgvOqiJuaftoQmbasMOl44cwPghagdWGR4gzQhXPk/K8BeL?=
 =?us-ascii?Q?07MWjSc6fZ8hXty5RzWfmiX/tMqqc7iGhzU4X8LkfBKEwMVJZZ0tRTLVMg/m?=
 =?us-ascii?Q?GcypUyYHaNuICDzvFokWzTKZoQbtNyRe814ejf5WtwMRUbySUcjAUCScpSNV?=
 =?us-ascii?Q?we2LEOeayat/yCSBQPXLbrsKtuCfIU3jkO5cJtRYGeDd3LGVWDMHH2ZyspVi?=
 =?us-ascii?Q?Vs+ljKwvC9XDkJD8e3H+4qgqOMek84+M0x1lfuIWEKwwasa3pMV52UfcHV6O?=
 =?us-ascii?Q?HT9bjkvGNA+feFY5i8xibLAkC6qeo0EP+lhyIGhbcBDHKwgL7pix3+Of5oA9?=
 =?us-ascii?Q?NN2nXz9DJFzrbocPFKs2xZq2JJD38dNuKm4OkAYW7HT8NVYnn+biuDIMub+4?=
 =?us-ascii?Q?ZPT2D5IKiItZywLMqfwNNQjdK3mR/YsMeujJgZqzLZ/FXSBcPFyJFV+wdHp3?=
 =?us-ascii?Q?2ZE0Gg1HJWut6qhbG3DjTmjKOSDV6mg8kokXNNZIz3VUpuAgeAM3BUxB5NG9?=
 =?us-ascii?Q?tsjXCIeX/OgW/+OARXfWof1aNaRjlugDKaXjVMSQcTmzJiFWZXcRUj/R6C84?=
 =?us-ascii?Q?atHZ9iI8OSVjqICglOEdim+HuGFsO63RivEPxbFT+EIsWTdrjj4hna6uwJhi?=
 =?us-ascii?Q?xx0rZKEO/xS+aSBEmvJMjlgOKsFonfU+0yHiVQPtQN9HNMmHSTlsAgWqduk4?=
 =?us-ascii?Q?LDYfUgSwHqOkL4KtweksqRjnDWCpYZbsjrIdZmIv9deD+YjoN+JxQNPi2HNp?=
 =?us-ascii?Q?0jgzF1X6rMwk/lSG7+qfQyKJkjpy+HkciB/IpIaxom8S/wkQgR10GZtmMMV9?=
 =?us-ascii?Q?RjegI+TqCGFVKGaj82lz0wXUku1WZ+/KUIcRugE5UaAOTz2F3uehfAraHAxS?=
 =?us-ascii?Q?mq1lWspgCI5ckdOQ74ooy4dMDCtSPJO1hy9brLs31kl4OWivRhJSe9D1dZ1+?=
 =?us-ascii?Q?OG/yqihIwWgCEHyWZT/q2N9KCw1/F977IeKlYSepQoOHZZHioRjR7UQzLzZg?=
 =?us-ascii?Q?Mw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c21fb3-64ea-41a5-2a9e-08da695d5aa1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 08:04:50.2232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VP6caeVbJD2Pe6BL+o+dl0OYAYBDSqrGaW0GEZHOnimVPyJY28AoomgZB2QmYrchIHE+HS7QVU7MQ/IV1Qli/Y9KEktnjHu1zNQXYhPpc24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3946
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190034
X-Proofpoint-ORIG-GUID: nWW5rN5K0NoOozUWuXrzKqMBSB6EMOfW
X-Proofpoint-GUID: nWW5rN5K0NoOozUWuXrzKqMBSB6EMOfW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 10:50:35PM -0700, Tong Zhang wrote:
> There are 4 debug files created under /proc/net/[Devname]. Devname could
> be wlan0 initially, however it could be renamed later to e.g. enx00e04c000002.
> This will cause problem during debug file teardown since it uses
> netdev->name which is no longer wlan0. To solve this problem, add a
> notifier to handle device renaming.
> 
> Also, due to this is purely for debuging as files are created read only,
> move this to debugfs like other NIC drivers do instead of using procfs.
> 
> Reported-by: Zheyu Ma <zheyuma97@gmail.com>
> Tested-by: Zheyu Ma <zheyuma97@gmail.com>
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> 
> v2: break down patch and fix pointer check
> 
> Tong Zhang (3):
>   staging: rtl8192u: move debug stuff to its own file
>   staging: rtl8192u: move debug files to debugfs
>   staging: rtl8192u: fix rmmod warn when wlan0 is renamed

Thanks!  This is much better.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

