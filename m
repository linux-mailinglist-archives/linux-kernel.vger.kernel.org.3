Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB93555C745
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbiF1DSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 23:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiF1DSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 23:18:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9F71D0C5;
        Mon, 27 Jun 2022 20:18:31 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25S2CXMg026396;
        Tue, 28 Jun 2022 03:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=7kJOnk/4jZU/evg3jtiehjP5W6pEeBEq8Q3+tKhsEg0=;
 b=F99W9DWFL49WTKooxi7Wac/ISQicx6THnAlD6hozI3XFQubPJ/gr2BruEVDNn3Y6rHcH
 k37y+b/WvYcpt1O3J8x4wkvcf/Pg+768L4AwIx41ZwJcI2pW1MtrAWkTzXUOEHhSXTyJ
 1+fnRs7eimSnHoRjznMruKuEjXxB3T1D01UpU/hNijCzvMFN6LU3Zv2PR7AGq2Ub1wop
 VDWR/Mjz98gwR+cSwfyXuBbQp59uGlISxq3B+Dbu94hKpAZim8wZkM/QKdIfp1V8IMwP
 2ngV4/ZodcbAojfskB0nYmJT+sqXX8rX5Sr0TDOhPGpIswNRNKEIdO7ymMmVH2kzNxbt iA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwsyscrjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 03:18:20 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25S3F7Ci020060;
        Tue, 28 Jun 2022 03:18:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt25q8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 03:18:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfCMAB8jzf1IRG8iLd6UOcA5RQhZ/+BEhLMNrlSFrDO7PLQn5Vx5xE316J+yysPpxhxDx3DFRHZv0ApKhmhzoWJ/yhFqylKgixQHGdEZ6ENDNBhbkVdgMi2QVHd9gbEUW6QjHAZe4Fj2m8glQENj9N/15QScvZxqh03nBH8VIQjzkGB+crOG0+70SobKv6iXWd6KIl8Hfjb8oDF5IyXb+helGOFBSWic4Hq7Rs3kQY8Mr56xq/jNjYpYLyLNUOYBdca7lpWSNoS6Z25177IIxeW1ZIXiqopOdQItN+v7tPFXy1w1ObAsh9GmUkuyOwHXNLuvLj2yqSIaqcIfNBAU2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kJOnk/4jZU/evg3jtiehjP5W6pEeBEq8Q3+tKhsEg0=;
 b=NmrGuCDBfAVlPVrXn8jlQ8B5OcxjzfOuPMzwbffHiMlRydCAEL5apSnHo/DZ07wWYNb7LOkl6bbE9kwsYF8I76QOauHV2vfy3jPPn82Vy55VfEpqsCUg4/qDuDRyGPNZloaQJz2atymMRmo3pD0Ag6+24OyGo95FEvMuKAa8bR+ZIND/4AtDhXn7Rgz3H5ndUZvQtxkRnJi7LPj8YdEVKngf4UE0v2xWyxfX3m8Dp/FRlCKBSzc+nutXJAun0F1OWZK9GzUYpKEdhXGuWlI1JpiRvmtZheTvWcPL8I417grnzcAbtPuLfC3UZkTIJ+MhgFeBXBLxjgfkexfNCeFsgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kJOnk/4jZU/evg3jtiehjP5W6pEeBEq8Q3+tKhsEg0=;
 b=Url0+yh1BOPPTqDoWUmYxw+x4yl9C14BMaTVqWnX2k7aTo3g+Nn5HoVjn2SPTqsWpdzd8RSWgduM2EEpCF490kLbAEJWKiK4jGkW93v2L/ZSxFJCNy/80xGxlx+3v+uKwbErv9W6vYr7Qq4H8jeRjDSrsXm7nD2aJuaOdvjdm4Y=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BL0PR10MB2914.namprd10.prod.outlook.com (2603:10b6:208:79::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Tue, 28 Jun
 2022 03:18:17 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45%5]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 03:18:17 +0000
To:     Stanley Chu <stanley.chu@mediatek.com>
Cc:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <martin.petersen@oracle.com>, <avri.altman@wdc.com>,
        <alim.akhtar@samsung.com>, <jejb@linux.ibm.com>,
        <bvanassche@acm.org>, <peter.wang@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <alice.chao@mediatek.com>,
        <powen.kao@mediatek.com>, <mason.zhang@mediatek.com>,
        <qilin.tan@mediatek.com>, <lin.gui@mediatek.com>,
        <eddie.huang@mediatek.com>, <tun-yu.yu@mediatek.com>,
        <cc.chou@mediatek.com>, <chaotian.jing@mediatek.com>,
        <jiajie.hao@mediatek.com>
Subject: Re: [PATCH v2 0/8] Provide features and fixes in MediaTek UFS platform
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1zghxfpch.fsf@ca-mkp.ca.oracle.com>
References: <20220623035052.18802-1-stanley.chu@mediatek.com>
Date:   Mon, 27 Jun 2022 23:18:14 -0400
In-Reply-To: <20220623035052.18802-1-stanley.chu@mediatek.com> (Stanley Chu's
        message of "Thu, 23 Jun 2022 11:50:44 +0800")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR07CA0046.namprd07.prod.outlook.com
 (2603:10b6:5:74::23) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b391ae03-2b01-4ebf-21f7-08da58b4d86b
X-MS-TrafficTypeDiagnostic: BL0PR10MB2914:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /o1x4K0eLFpWkTa1wXE+g4tJCURbHvhGARDEgnyjFiXVurYMv121h1aIW4RSzjZ229i3lya1VVYZEwzgJFluw16aklDw+GwwG9a+Z5pDWTC5+4+L2MIcFsFG858z6h/RjZDrOLgiPujlXm8MvEQpPSOW0X1kHTboqHpfJP7XV7NZLTBC6bHfjoyI8sMDYO2hDue6lgPv6OllAzO7mW3AknIDeDWGzG/wlG71EbmBoyFkPqEkgcZ8YhziWLHggbGdGHz/x9F66w0myrN1BcSuustGFj2XpZ2KuH/Wo0RpL0D7lk5XtAOregeJrYn+naUHNF2eQhEEqD2ICw1O7JemMX3sDVXa5fUF/Uqid2AIjdZl1xrZgQR58p+0sUTtbt9YGk/y37+ImoOttGhvH4Ai/j3Sksp+ffXEWgnBDundxy2Ru6XX8bQcVyNxbklNih+uLBc6Xk5Wztq57j1pdSR0SOiD+T5tqX/f9ydCZibPr+VAK/hU+mB6CUg5aAkB0gM4yXXJPpd0LTdYTAFEf9J5k7sf8OiNxFZiO0RbrdVC5sWOBvcYubLrFyqmHP2SxS04iRkSC6Uv48ChsmRPyKTUZixWOueMI4ANWYyQq6zPY7LrCk/kJCd/rIYN6tZ48fsVw0rUDAgvndg2kOra1gGixe6/f9dOcrMZK2Xv+jhUWrq56gzQFil/3tgScJAk/L+/SV1X4GJ2F4hAraxAn2UuYmWWpNV10FV1ydQMDmZYKjGEmVkqXKf1CMeMnps7J53aATTcWgYMlDOYKhsEapsJAOH+bgc9cZuSsm7lUghhDjs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(39860400002)(376002)(136003)(346002)(478600001)(6486002)(52116002)(558084003)(186003)(6666004)(41300700001)(36916002)(316002)(2906002)(66476007)(38350700002)(54906003)(6916009)(4326008)(8676002)(66556008)(38100700002)(66946007)(6512007)(6506007)(86362001)(8936002)(26005)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0z9eoWuHD1bhwTRKjCdY3HOq+bjiUWFAQvESh3mT51vdb6FzLJDFJ7Vq6yVU?=
 =?us-ascii?Q?RA5Uy8acgCJowSDxjgWHylHEPcH3Yi6rqdGnDrPI6PbEqOMekebmjuRJf5c4?=
 =?us-ascii?Q?OxamKfjv2CiwGoXCikI8yct07ucXCdyKL2odF/TPAmsBpkE8I8Zdmltvijbh?=
 =?us-ascii?Q?P9DlqkO7UIHwOGtzLnWtdlHWt4bZcCYC41ED8FA956bXJxhqmUaAf//ySyMA?=
 =?us-ascii?Q?eJru+CwoRXdYzMrgcjGz57TpFCE5wl1jZueWNCKGSOhex3oM9JG582fWL/fQ?=
 =?us-ascii?Q?8HOdleb0rRzEkL3q11txqyWhf7QfZl7LpsGbDbXUc+AXGQKUR/t75AubB7Gf?=
 =?us-ascii?Q?jMJ4Szy74M4aupweMrS3E7XjZ4PGsuHm7ibwF9YkfacRL976hrgIZkP3uxu5?=
 =?us-ascii?Q?gmznhcZgl51GmMH+C0481ohsCLBI3rWSLfDrDWQrP/aOdasMEYwXz4pjHOB2?=
 =?us-ascii?Q?alMv1hmAne6iIj4AT/AIrvRWaJejin4vAtpIabI8ExYOWHHk1Rf5aHnGk3dB?=
 =?us-ascii?Q?fiDz3I48i0iGt0Jzr7Tsp0Hb8lR12pVYGMyG0/TCzPxIJcjACc6QNWNhWPWb?=
 =?us-ascii?Q?IOZFZKX3m6cz30qgyppA+vQUOKmaoDC/ipj14jQe5b7VDxfTL/fmnswFCM7y?=
 =?us-ascii?Q?Lr8U21I8+25jfw6mXl23Jp+RyBuYCFLowx6iktEoHvKzI7G7Ph9RTdAhhxFn?=
 =?us-ascii?Q?gUATJLsnVsxeRZ4Sxb1Lf3mt/nTxrUZrKaBlJZ0N0trEaj7avDFQ9lcUREFl?=
 =?us-ascii?Q?2X2E1rGBxVcj/m2Oxite2/EWVmjKpau4iwdCZICQ7KBKMHKw3jMwt3o56SPl?=
 =?us-ascii?Q?6uFkqkvAUH/kA8oMgQCxehAHGfgHulHF4k3VdyQL8dGPJEiXuW51TpgNSOfY?=
 =?us-ascii?Q?ouwtp/C5+xIyasOVtgmiqqXvXrNHiI9Qq7p6mzfX3XoUtI5ofQndivSzCYEU?=
 =?us-ascii?Q?HYenhZVmiiSVLuYWxzj6P+2P0OCPek7z7X+0Azt8lNPlgqDI3ct0Nlc4AxYB?=
 =?us-ascii?Q?uEEbBAgtZQv+egLWmTRmVBYg+H/tI1o9rtzRxwXqbZNXa2vAY21fi2csgiLn?=
 =?us-ascii?Q?/Zd66NS6QU2bD60Th9wCE08kFPxdcfdUuRz8YJCIYTcLEcZW+mswwIQ0REw7?=
 =?us-ascii?Q?CaVBJBRl+xNCrlLfumRIpY3HZaVnedFxWI19xhJkLDEGs+81anaFdA1PvKML?=
 =?us-ascii?Q?0SknUW4mV7raQpjg5//5N/46HYw8ciJZPtbtBw7/AFyZ/SIMJDaPGKlTHALc?=
 =?us-ascii?Q?X9qSP6Jxs7eln0vh3kHvAilRDJY+f38Jzh67cRIdNK0LRFPfqsgJbByR7Bxp?=
 =?us-ascii?Q?hYL0sDarxeHdgdqi7y553FBAywkz2q3UiNydT6myu6brzI3m11v4wOJgN5FX?=
 =?us-ascii?Q?7Q9eirX1CAafYYe47sLxp+uKQAYdKyv4oFKPFvaf+ASyF9iHe5ckun5zLaFi?=
 =?us-ascii?Q?RGXbLfZTUDuimDEJM1W3WRYIjh/fem0czUH/7UMr0nAW9e6zqteeXCYfgm2+?=
 =?us-ascii?Q?X5qUXQTiAsalPRjIx7B8XIImRlR4jTnPzlT8s380LBbl1J/vcl8mpEYswP0Y?=
 =?us-ascii?Q?2WY1Y3F4lQduCTyKSAAUf7jIQc8fLEuPgWUrS+MzQUqK06EoUF5lU6suicE8?=
 =?us-ascii?Q?Sw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b391ae03-2b01-4ebf-21f7-08da58b4d86b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 03:18:17.6237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CiyR5flzZ7S//so60p8egtM/fyLbAalVA0a3e8uyGhoLyeo6gGZL4n5H4nzq04CSqM0FlIpP+B+rciZCBpJAp8W6YbGZRMlpr6wZbgxcxkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2914
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-27_06:2022-06-24,2022-06-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=609 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206280013
X-Proofpoint-ORIG-GUID: sMiSOPSV5TAeEtlndf2wENocR2ryTof7
X-Proofpoint-GUID: sMiSOPSV5TAeEtlndf2wENocR2ryTof7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Stanley,

> This series provides some fixes and features in MediaTek UFS platform.
> Please consider this patch series for kernel v5.20.

Applied to 5.20/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
