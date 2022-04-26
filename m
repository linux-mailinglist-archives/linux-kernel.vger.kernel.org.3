Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB37250FE65
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350670AbiDZNM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346973AbiDZNMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:12:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F7755212;
        Tue, 26 Apr 2022 06:09:43 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23Q9JMIL027852;
        Tue, 26 Apr 2022 13:09:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=EUdBZ3j9JY9XPwphTKQr47plx1FTfo+GS3QIqWozjCI=;
 b=Bpe3XSKs+yREVaDOvanLPYvWkCbq2RLZ3DhuB8KPX5nVssTWXJFV3nUWJ7L2kV/c416u
 5PReN3mOgSNILWVfZx4dOvcAnBJ5UPnBpORrc2zkMqR4Kv38wGYUM14X2IyC/xbxpBnG
 TZn+GHaUtTJgtcRWTP1jGate3juGdJZo07Esn+xPHySRpRleKTeqWtp3ahSb29VHtyah
 +hQ7wvFHVnFsWznY9IHMisg8jjTazNH3nxoMu3MFR1i8gjPG+aWsOqo/fHUMHmhTSPMg
 qU1gU2yFWLHy3kChJ1n0keHgoFz1WImCwT+2cNDtbbhp0AA5YyjvWJmgtjlXlJnOFCKk vw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb9any8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 13:09:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QD5GtB029050;
        Tue, 26 Apr 2022 13:09:35 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2047.outbound.protection.outlook.com [104.47.51.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w3bwbj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 13:09:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CguRwp1omtydHyNuc9NhEJEeSDneb0IKSnvpR13RRie4cOdDsHzcwII+IFW2ZccdaH9FVU4OTg37kOhIOeVXzcju71/CrxTCiu3rXgKxxuPO/84RArHOeGg/xMF4R0HKeP2wP3GsvtTi6EMOZsx95WODlDwn58OT2O5O8Iu0slvBRfBZI9HcZRQ/tvfMeR6p0YVj/tC42w3I6MRT+yAHo6pSbJLt2mQxKXlUjVY/pfg4thlxQhSO/RV8ZzL+JJJwV9SUS+Xsa+VTx0LTbM93fYdpak32H+AWBLUSiNGHkZxOYwgx87bz4GDaLoxhQgmJX0e84yqyhnC1WfPhk7wneg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUdBZ3j9JY9XPwphTKQr47plx1FTfo+GS3QIqWozjCI=;
 b=hLwvC27nY2ESmPYbccUQwC6DvPPlOlPT21Y2exFvHUedYsGFir8v4v6ZTMzOZ+zWEfNkZtQya8hMcDc2j5vEJxH0yPtdHGaHpf7lHxcjgcEY91iJyH9WiRQPjCGdhiO8hsnuNClaYKkjp+xwzDVNmU0fzHbwk4PnGfI5FhC97EZVv+n0P6Ijzn4VySzpGe9M/ZgVC40b6tQtAszZeBm1AwbJVBg84M20h658SonnLmhR5FJLSVtBu3Zs48ztCmDybxgT6TilATinaob7QDdyF9rEdLrgl+owqxvnQaM3K/HaekEKfWUjIuqC5lkftviPPIVo+n6A7AVS0eJ0IsUU+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUdBZ3j9JY9XPwphTKQr47plx1FTfo+GS3QIqWozjCI=;
 b=TDfWeYyWtgRw+yW9of9j1YFVVEdiGDlFo4JrvDpI04/Kmz4XBYZGrKA6tVDWPfWFL0aftEWt1q397TsQhJtibpE3T/DaezdtP8pGH7sBIzwnbIH90aRAgOff78gkQFcSTXVwVXQ1GXBoXJriB3OxZpoStHqDhsDc3ZXrsvgfoL8=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY4PR10MB1943.namprd10.prod.outlook.com (2603:10b6:903:11a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 26 Apr
 2022 13:09:34 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192%9]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 13:09:34 +0000
To:     cgel.zte@gmail.com
Cc:     alim.akhtar@samsung.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] scsi: ufs: using pm_runtime_resume_and_get instead of
 pm_runtime_get_sync
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1pml4rny8.fsf@ca-mkp.ca.oracle.com>
References: <20220420090353.2588804-1-chi.minghao@zte.com.cn>
Date:   Tue, 26 Apr 2022 09:09:31 -0400
In-Reply-To: <20220420090353.2588804-1-chi.minghao@zte.com.cn> (cgel zte's
        message of "Wed, 20 Apr 2022 09:03:52 +0000")
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0055.namprd04.prod.outlook.com
 (2603:10b6:806:120::30) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9f56abb-b9e1-4c78-84ce-08da27860201
X-MS-TrafficTypeDiagnostic: CY4PR10MB1943:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB19430F0603FC44D8E43E5EF88EFB9@CY4PR10MB1943.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vdjh/HYrr+gIZet27/1Bou7X1IsH5alJvtsW8wTeDf0ppDekcTKFo2KmHOvy+dxgp73dUxhBIyyYrCOOpiDh8KgCDZpm9tRtXVInH8oYZZiH06FufAwF2cnCmVBGzHPDieGY1oQMijRV1HPnamOQauHG+8mSjNux/MvKU49TsaMUjlfaNf9xDyUUlqV7twPywJbsoUVrVwrMYSDYtrx0mJ8otqe2BSsgWiSXPTYCHbMP1cmd7AppddOAVvntrJoOy7AZacEMCMUJ1pE/5qC4Ks6FZ59Csg9xXY5qu5rvMV/5QLZv7pSKEJNhuwDAWiDrPnH+L2Czmk51IY3uG/o8FULuDIAAZHz2+JQqmx0OY0i5px+fBVAX+wVN284W159nLSVbRzxXjOItrnlcaXhDWjjBMM+xiit2vjp+FCDQrjeIvfYmwnnPRFxB08FDL8Lrqr6H1toAudkKRvNCr8ztozTr4wBHq+ifijN89EX9DJ03TaQQ/J8VKIknRD8CyNI+K2cvzb5jZuLvxYABH5idQ3T2bR5cQAT7sDvJfZYS2nskpOxFKx+YPHfYkBrgsYzmzjU0TvgEEBqyx6RJ+ss5ZhDvBhoaOKhXqlZ1/0nnAmXXSferLfS5b/j1r4X0otqubEAZttxkjL9kq1WtA3OenDuKauTb5pja7blyFcGYfZNdGUC/zPe+vLfNuS8O8SmULIa0He46jRnrdpO1Hzs1mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(38350700002)(38100700002)(66946007)(54906003)(36916002)(52116002)(2906002)(508600001)(316002)(6916009)(6486002)(558084003)(8676002)(86362001)(26005)(6506007)(6512007)(6666004)(8936002)(66556008)(4326008)(66476007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RYDHA+bXx1GF8sZj3tky1UrqRMELY8IhZ0vYf8KmdWgsq9t3uR5FQoBEag1m?=
 =?us-ascii?Q?D4Zmk31aDYRtAFPasgMtqxoKuETbdZZO2f0o6x6Z+txLiMsV7rx3kJhNqtIz?=
 =?us-ascii?Q?SWYUDW0FYcGsyn1TmtC/qmP4K59AK/IPxdmlh2emnCvMgsAARFHelYe7hFf4?=
 =?us-ascii?Q?F6C86rx/TShGhn3eW3POwwmuaeVWNfkPPiS54Cwf5BMx9qNHTrZG5Jt/dbnl?=
 =?us-ascii?Q?TBny72XJnqZiJT34F54bTBDNYz+aOa8iCSA8iql4CacRCPLMEE96JGyWUYfZ?=
 =?us-ascii?Q?VDZDm0c0CbGcLERDlB9qo5XgHCgWFku7cGoiZwDhlABdhGhHuPBiw708ShEH?=
 =?us-ascii?Q?ofqszkQP0p9PQaxMcZb57TdwSoOdLBFksyO3Nx3qpLTnrptXoraXffqxK0MJ?=
 =?us-ascii?Q?thw4FLj9WlurRVPiW7oTvDGeZTSsD+h475VW3iWdrrfpuAKJEmcFXNeU7Q0Q?=
 =?us-ascii?Q?Qqopsh2ssaVa7x771BnxVpUTrfwaCKBYXDg9FsMJH1kyUWOo+pGET49I92V8?=
 =?us-ascii?Q?TSRQyLcB8M8aSyNqHBMPxZnFHxhYpIICmX3Pm85tLMv8f2ynphrx8QMD0Pjy?=
 =?us-ascii?Q?2Bna1rqvB9PNj2NoLl7qcmhe0skizf+eOhcrbjzuaCnEOr26bzL2ufEtErW3?=
 =?us-ascii?Q?SlJnH67MuQews4R0paRcKgSgg0i7048i2c2BxGLGje4sw71uEvt9UsMOAlRX?=
 =?us-ascii?Q?9YUkhdKqQ/hZ4060JbLTmmpCe2CCgFzowCfCV3xrMp8OqqOicK544TtY1xUe?=
 =?us-ascii?Q?NKyQtGtaRnRIQhwcLxhGWiz/fqA2KGZ997OOO3TT2kmSVqMswYAX2Au1KFCU?=
 =?us-ascii?Q?hFWkE0emnzbTdPahEiuG1MwijfVBvG//5UpCY/5pkdTof8OkO9RZQDMAZuVv?=
 =?us-ascii?Q?pI0ORN09M4x6C58lQMMVPZJ3NpC4PI2KTE5mSzUJkG/+vYkRpn08qZjHKbTs?=
 =?us-ascii?Q?53Wyn5rWsjZfiAl+unS3mPMj3+brhuWvDU4ksaL1tlA4WL1h6KqBulouDrU7?=
 =?us-ascii?Q?/vIdz6+6xpjyijFPFoLObPKx3TJ4X45TTqxYBl+4oxp1N557hn/O/TC1GudA?=
 =?us-ascii?Q?HrpXoQmO3ZaiQnoQIJ8SAazuJeIfgbfVleDgXyxbafRP4/TjK3QnFdHMOFKw?=
 =?us-ascii?Q?md9op7TWHs5r5w2nVEwQB20UxfeRz9OzUAKKoPqreEVHP5GVRDirK0vgb9l5?=
 =?us-ascii?Q?Mk56w01K7KsnTTir2usp+Ufj1f+ejemGWooX/sDOo8FCqCk06B6Fxb3Jc0aG?=
 =?us-ascii?Q?egQQ4yTNrxH8wk1jQMuv3NVXx3ykJy+jd3TMjEJ/XvQbB07qBAq/ep9ejJ22?=
 =?us-ascii?Q?MvLxlarv9pY4K44tygX3zea4p1DC3sk9J6ANzkkckzbDNv2wlvrotpPRErIy?=
 =?us-ascii?Q?+0s28LJIa24F4e7BTtZw/znUBV5wlYsuA6NI4pTjJZgCtS/sX79Hb0/znRiw?=
 =?us-ascii?Q?4iXAErJslmtc89f3gX1dyoWqnqyddDAqedDJLi0rizsoneZb8/9EmOHAjUnw?=
 =?us-ascii?Q?376ZoH0pC586ls/jtMUENBdGyeSOpe6GCpJrESpv2tel6n9knWXWQ5xBnU49?=
 =?us-ascii?Q?uCUVuvbbun/3Ne7gzmiMVDKWCcwP7vuexksQOHnRpfVT0vdUZcO69Z1TEp+8?=
 =?us-ascii?Q?bfWye3yJNw8nCffwWLi3vh2xXdWFlsUcgf/Z7AWu589kSrKuo2VD6b4wnO3J?=
 =?us-ascii?Q?xe3QvQ7OvdhdVhvDAfDPZcs9gRa0GowpvNK7Ll3+juDY08iqvKIr4H1K4AXN?=
 =?us-ascii?Q?mM1xIY2I649wM3/0zm16j93mXkhIYDs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f56abb-b9e1-4c78-84ce-08da27860201
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 13:09:34.1301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DBPUeybwS+tzgilmBPY/if7K7M7ONAJWsxLftXbQGPmAojB2AfmWAA87PkBIhmAr4OgH1MxI0weeeIM5RXy2/6CRD2rGmo4ILBYxXqlIKZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1943
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_02:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=829
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260083
X-Proofpoint-ORIG-GUID: HrlgWTRKt-Vn96xSIqjzQUmdG0eiT2UG
X-Proofpoint-GUID: HrlgWTRKt-Vn96xSIqjzQUmdG0eiT2UG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
> pm_runtime_put_noidle. This change is just to simplify the code, no
> actual functional changes.

Applied to 5.19/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
