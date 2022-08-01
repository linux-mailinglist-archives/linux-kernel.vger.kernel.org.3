Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FF058747C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 01:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbiHAXiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 19:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbiHAXiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 19:38:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C10C42ACE;
        Mon,  1 Aug 2022 16:38:45 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271NZV8C020543;
        Mon, 1 Aug 2022 23:38:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=FTKXPljcev3ntvN0X3lJ0pgzU8FWOYlw/8puGXH98vU=;
 b=XXBU2z2lwF0Yr8cqDwIjIsdcPCy6WOy4QsgxghXnMo18MIN471fs2ci75j0WR875FETF
 gtqALOC/vlWCJsZPxPENCF9/aBJdD3TpAnQrkH7LcCQae9yRcINu2+zdoSPrT7An1G32
 ynoP1a7M86lbBAIZ0d0IJ7gxxguf0JHHWjoq0nZLsG2kwNX7hEbpp5uliOeM2MlKaqYY
 xkFNItpWmy9kbG7w14ZnmWWu395ZBwWSOhcUID9PLCtVqoe1zsaqcUt4C4iePr5XWPrh
 FIOKZP7zXSjLFqWN5CfrnfVqNqEdWy4Cw23cFos+K6fGwLf8FAbpND7fGJ4i2xToYilT +w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmw6td75j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 23:38:39 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 271KqdZa010697;
        Mon, 1 Aug 2022 23:38:38 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu31qr8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 23:38:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VO/qCJ9N+ddI9kbcOZWqCwFbQNgFDtOWdoMWOsMSiQrrSMVd/m+i8GOhZgRNQo3+Xs8wDKGh8bZS6RSFb40KUgOc6ASBXaB0Ahw07OLG34iHbzn2x+p3oxRjB1J6FV50aG+cGBrbgk/LhtlXqH92VNypPAXU0v2h/DKdgp93jBCuRgNBdOwcuwHEARkeUFRW1UFfQ19kdNxRx8+gBnKpoTBAXITgMYY3k2VwpykOp2K1aq0LFGVTLmfYSFU5V99posoCbhb8cikmolClKJFmo2yL1PY6pYyaqX+B/KMLSnXDy0aWqtl6eOTY98QynsETddz46gk0IuAsjMWH8PDa1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTKXPljcev3ntvN0X3lJ0pgzU8FWOYlw/8puGXH98vU=;
 b=kM9Wh1Ytoz+gdkrYkNt6X29fy4fJFQI1GqzBaTg6I/FR6lMiqQxossdANJdOI6m3r6HEgxYQt+LLzxtLJk/sAelNy9NawdbH+SK9eKTbxdSkLBAGpPh4eQyoFQAp7T2rbdoZyAbPXnrbNQ63VPoGpzTYXCGWZ0V3L/XzAtnszh/LClIDY+HPPoPLTNkvnm2CZFpsq8jiyOP8FQx24VWTwfFFxFtnU9cTX/+jBIOM6GY/4aY5qTnaUC9OTSLmIEaEyFurKMyaNhl2jCad8rU9HL1cXQfL/aKk5gLNSXUt57LQPAPREhNktsnjYVleCmqdLSv1t9hhbLl8y+5zfD0rTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTKXPljcev3ntvN0X3lJ0pgzU8FWOYlw/8puGXH98vU=;
 b=wSk9BNIcj/oevj3XPhOniFrMzybziJc47qtPXyavEjX7sBlbYesdRGKd0b06TwIRczLOoFX+jRUnzZz7iua/W8byLl6YSWXKtFzk68cs3U9i4UOL+/9bZguPIJ4iQxuWLCAD+bE+miHCHyhTl4r0T0TQvNzQI+3ElAgKi3jTZlc=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BYAPR10MB3383.namprd10.prod.outlook.com (2603:10b6:a03:15c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Mon, 1 Aug
 2022 23:38:34 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45%5]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 23:38:34 +0000
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v3] scsi: ufs: ufs-pci: Correct check for RESET DSM
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1czdj4jrl.fsf@ca-mkp.ca.oracle.com>
References: <20220728111748.v3.1.I22460c4f4a9ccf2c96c3f9bb392b409926d80b2f@changeid>
Date:   Mon, 01 Aug 2022 19:38:30 -0400
In-Reply-To: <20220728111748.v3.1.I22460c4f4a9ccf2c96c3f9bb392b409926d80b2f@changeid>
        (Daniil Lunev's message of "Thu, 28 Jul 2022 11:18:21 +1000")
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0115.namprd03.prod.outlook.com
 (2603:10b6:5:3b7::30) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc986e51-775b-42b7-3376-08da7416f2f7
X-MS-TrafficTypeDiagnostic: BYAPR10MB3383:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EVlHyRKmcyl1R8Fmm7VmbA6hV7Uzd65Clj8TcddQGUzyFhtPQnMCRkSEDKMpo+D4nobUP+tBxpaA4N9Mfewh5OF3Q9acz+HImlRzFLpAXKgj2M3zFa62+AtTGNNTDgvRJDsr3rjShXSbUN3VYUctSQ0ueTogTGewXU/qw+DVjWPNQF+rnF9z7wQcAyGgjGvGekmfTFObIas0+we+c94s0dhsYRh/0GIqOL8+f4yWyxsF8b0wd5orpXgWWnSKZ9gRj5VXADpkyYJ+KzLIT6y4t9l/wXr0Fj+TDhQb3xuHEFVokqlZfS00F4ziDPgCKl3p+ADy9wnkOoJnBtpbLJSMxsBUVmcy+gnwfzyUv4+4GU8lJX5cZOw0k0ha0bcsjR5ZZI1/22uLGbP4PKaBqxvOUPUh2qgPS1Y1STatDFFCs9Ia9Gm2xaOTeVy9+mDcDbLj/wJL5+cElTM6k2nTgmDeC0vjOPLttgSxpKYp8TyGdBnDADTEQ5AjWVgU8x7lK5M/5Z5muFPh4LAYEpQaFmNBdgL+h9Halw2tFrXLOhpeSXH47RzPq2hI/Sq5i9apnjtIZNKZFQrNT6LOsIB3CC19Yl/cBANk6tTEdvWuPyolzSM476ry5BUHn5UXAB/22dCyQ9TTpZ/nAl2E8+JwmHqx6oXEdxcvDCWOYykv4N4oA86h/PCB6U09bAmUV6h1Bo4RHfQmrdSSEBodDmMdp0/eiIdQ9HOmwj0tuB4F1wDQ0Pj6SpoxlwcA2jihXaZVH6gwY3jIYeRjR1d8EHyfR1Cui7Qf3kw2S3TUAaTUZT4aD/Qcz1Vr0t5qn18sfMdvL7ov
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(39860400002)(396003)(366004)(376002)(52116002)(36916002)(6666004)(26005)(6506007)(6512007)(86362001)(38100700002)(38350700002)(186003)(316002)(478600001)(6486002)(4744005)(8936002)(5660300002)(6916009)(4326008)(66476007)(8676002)(2906002)(54906003)(41300700001)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?npRor503iLChvfvNcJ05+tlkKUx4FGCeoALCSr36KOYOGCEdXX9g0inUWTCz?=
 =?us-ascii?Q?EvtmjrVHp0J5hi76D0qKlH6SbkbMZ7dXkXxq7/ls/yhR7G4J/v0Rz7cyxEea?=
 =?us-ascii?Q?0jcmqWypfq2k4mP9XyFnKEGLuVuyCNoLchmBRk6DDo9iknDbqr6t3KmA7LSm?=
 =?us-ascii?Q?39ve3v0fPxniUUOCoxob4QrSi0CE882IbeDbdcpxtV4IWSPodglMqRScGXl+?=
 =?us-ascii?Q?j7DuGJLdcJqScReXWrrCtkN87fJXIYZGmsTA1j5Qp/Ix/aXPruFv+By65uLN?=
 =?us-ascii?Q?2M5zPmxrFUsJiTC2czDkLdPRNYa1g8t9Oi4hAAkDGTNx7Cqut9KGRBblx+cu?=
 =?us-ascii?Q?rTz8zE7xTX1QXySlNHhb7IcFKke311YF8v+g2PYeKKfvnWdBfQJwWY6Qi4eh?=
 =?us-ascii?Q?UWLON4nVDvE4zCP6lJVyhoTCxrHxRDDnszswoUSEK1KoRbH49QC1djpAjaxU?=
 =?us-ascii?Q?rzGBCUklqr5Q46wnjCDomogKrMHOejB0xcMfuWw9UK+BVlbtDUT2JPoE+scq?=
 =?us-ascii?Q?k0u1YN8PM7D98XXEeJc5IP41IQOqmRLV+hLPycfxIcZ/m2U6XG+8EyS8p1zb?=
 =?us-ascii?Q?YGgwFK4fIe94drN95hyZo4KqBdcvCkPLKChwdFoFZ5PwL1EGCrfHNsXl9pCA?=
 =?us-ascii?Q?5nviKlc67QNnj3EiPAFbaCDXZLGBu37UsIU8s9yqWTctUbw9bnVhMOdA4I5o?=
 =?us-ascii?Q?Jnh7RGJvP/prRPq8v+7dTvLWAKNtYUUu7Q0pM5hPtSdec4z/QpPGvC71lE+x?=
 =?us-ascii?Q?KOk3XZ0iRoVY87MYH5LwEIpqwJu6+gCl3gtS8rzwsP506uF9a+baY/+y0Qna?=
 =?us-ascii?Q?5/XAUJuQOCNzrEkat3PyEOHQTL9BfuDQssN0hc/1zmCr0d/RCoJbYeUNzNg3?=
 =?us-ascii?Q?voaczAr4LoOqZP/hpAZdTBm7gbT8sJr3hyoJ2fayvkzQl0TlqBYmnr8g5Lw7?=
 =?us-ascii?Q?nnB98xr+YFFlYNnnNq19d6QSQdhDfD/0GnTalYbwbhVEV06nh74BulnInoUw?=
 =?us-ascii?Q?MSBeEtmNPlh1st9MRgCb78ueLKZ/zig3x15e623yQafOBIyr3T38/zH5XMxp?=
 =?us-ascii?Q?9hwhhjH5HwC91zV0LohfeJ4a1YmbibkJA5nmMZCQUIkEAIO3dwrgZtU/6gte?=
 =?us-ascii?Q?fAyYWShd7p3NjJGXrBwn59IsXCPF/32zK6aZdLmMSqqxq9KdG2ZvUc4f6hB8?=
 =?us-ascii?Q?nuzewU6WpdgBGN1RYfdF10Di7MOkS2erJvtkGvNZRanwGd7xoJG+7T2sm2jK?=
 =?us-ascii?Q?SPHVk+osRphInIeLrNeOeJuE4Uk+g3P/FLcmz8yO7bc/fSghhAW8KaqFg7y8?=
 =?us-ascii?Q?wNwhwPS08TcZbT1+c06XwWsldodsAjnMprM8+++Ec+jjXoWlc8Z+bhcRG5Kf?=
 =?us-ascii?Q?LwiTsiL+k77vLJRdn5yFUvIY5z4fuTklV9g0H6YLB4vT8Ga4KFXIV4RfJV1z?=
 =?us-ascii?Q?7IKKoZAUci6y7arCSw83xwsb2j4iQXWLis4G/7XHPyBoMsimpySIJXFYtd3r?=
 =?us-ascii?Q?P+NByDyUbbuyZ+cAJsQgfHNj4i5kFhh5UZ6e93w+UzX4z/WLnESyNJvSxK1a?=
 =?us-ascii?Q?7yYoWBQjGkaHrzjm9iK5880u3XHsaiYfdWRiKK7w0Ra2AM/B4eLYlqbkLBfi?=
 =?us-ascii?Q?XA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc986e51-775b-42b7-3376-08da7416f2f7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 23:38:34.1985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q5ovdefKUXNP05BiKM/i12KkS83JT7kaRalBf/sISookGAi/zsJWYBOjI0EGLANQ75eMhS/PNGfVIgt52H/iQk7PvO6usErf4+dWey8rY+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3383
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_12,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=830
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208010118
X-Proofpoint-GUID: F_owRWidSACKY7h3efg0pgHyrGbgV-wF
X-Proofpoint-ORIG-GUID: F_owRWidSACKY7h3efg0pgHyrGbgV-wF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Daniil,

> dsm_fns is a bitmap, and it is 0-indexed according to the check in
> __intel_dsm function. But common initialization was checking it as if
> it was 1-indexed. This patch corrects the discrepancy. This change
> won't break any existing calls to the function, since before the
> change both bits 0 and 1 were checked and needed to be set.

Applied to 5.20/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
