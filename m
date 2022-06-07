Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2B9541AFB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 23:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381132AbiFGVjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 17:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377369AbiFGUui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 16:50:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8B71F89A3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 11:40:11 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 257F9Q7h010564;
        Tue, 7 Jun 2022 18:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=n0t/o05B8ULNOSmNZOVwHI54TDanTcDkem3xBt/a3GA=;
 b=B4uzPKjSuRaBRdishKtGbE/Cl25CEzpBxuwXOn7dZ5Ve2146cNT2XuWy+3+oc1UARUoV
 5aMOygajQ1Y9M5ELNNSCui4hhqCT/mlV+LMSUZEwojVegXsK9n5F3P3BbEfqlFqYsjO1
 W0JKcRc2BZLHwHFhvS2fBXYvwUHU3nSA0wWPgvy9LeGaUjh4x0+ESSqfG4MUi3VyO/Pp
 DBKeey7MARcAEQmCk381wy34sxT5jLfghGReZZNOVckp2alFWKTO70t0IZMpXIQZTcil
 dxZ3QPAGf4fMb4x0brcI1y8uF/TbJtU2y54IAZe0s5NJ0XupqPlngvaZjpUd2jhryNJS dg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ghvs3a1q7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jun 2022 18:39:40 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 257IGHLN031478;
        Tue, 7 Jun 2022 18:39:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gfwu3ah08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jun 2022 18:39:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8WwILqVadIXZomS/KygpvPJlzxP7zfqZ7JFLtOp48LvjX9X+C5OaS/mvsierGdqITskMoHayY1B0pK6cEKe6zTNzf+uhQCqblO4VsYRmu8DB4f8BVYa3LhLKFcCVC+evElTn2iMpm34gpoYa2uD5akY9mlqxeZxHaK9q3tkOzomr2nnv8H0CPlemrZ2yrCZ6ioI7yUELqe/VfhT+lJD+804kky3jGWXHLbeOdRpV30KSj3lbqk+PG+D32C1TnQAOmstlal9i+qviAHN3O9QeOeV3w20lGTbl0AKXaVa03XWFVCueVF91zzoEWFtM7osv9MtbaqBM3LD9zjZLUZqsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0t/o05B8ULNOSmNZOVwHI54TDanTcDkem3xBt/a3GA=;
 b=WHSHLkSi3CELw5nTILQ1VbgMuYgKxp7n7z/zP/QrVGCwM0r1A3hyWGadprYs4wco60tf3Sqm/38TFC498GB9Ih1qI+heIxF9w62ztDPGJZm74hdern90evGGSF0XS23eJM+mDsjC4LAL8S5h2qCwBLrlHau7hiZY3MMysCySx+0/zTYfhfSWea0FUhHFwJ9hjar1RR4uCPJvVBEMt/kcgG7MLs3MTj+XYx/gNLGaJgKKpvwW6Twz3OLf7ldUh5neY19vVwYrrCsm1DTC5iR3K5anORUhS4D0Q52l98sasfbOaDWtd/z1fnN/YlAKikJi3dlRynoioHBCvrlvHOXXNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0t/o05B8ULNOSmNZOVwHI54TDanTcDkem3xBt/a3GA=;
 b=YKJzbyI1jKYzZroZL6NzWGfqt1WLZmd9YuXrGZGUyyZwDIjkqZd0GcV2ZoO4qrXHWhJO1arR2UF5HRfdb0nEkIrNpx53jMCvdg22VQpcrCHNpCwjldvNuWM8p/0b7NMOrUS3Et2KYT85+0M3oeulMsDsRsafs69s6NJEKr1XxnU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR10MB1400.namprd10.prod.outlook.com
 (2603:10b6:903:22::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.17; Tue, 7 Jun
 2022 18:39:32 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 18:39:32 +0000
Date:   Tue, 7 Jun 2022 21:39:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jared Kangas <kangas.jd@gmail.com>
Cc:     vaibhav.sr@gmail.com, mgreer@animalcreek.com, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        johan@kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: greybus: audio: fix loop cursor use after
 iteration
Message-ID: <20220607183921.GQ2168@kadam>
References: <20220605231806.720085-1-kangas.jd@gmail.com>
 <20220606130626.GX2146@kadam>
 <Yp9/kqBUzpArfPdn@fedora>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yp9/kqBUzpArfPdn@fedora>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0097.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:33::13) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3c026ed-8758-4c98-c78f-08da48b51041
X-MS-TrafficTypeDiagnostic: CY4PR10MB1400:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB14000D734CF4E959A4CF50918EA59@CY4PR10MB1400.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Io7+VLBZ/OE4PVEsn5T3lZndzSjcBCFMK0RelDAndj91iKjtNv7p7dvaGYCJo/1jUkHUm0Xrte4Xvuq54+fC+Vkr8/GK/69QnYEBscUYNkU/d+QYsxKwyoZC03EZJdsIDJFWxKu7Yl+/WElRxZiS1om/iJMMeQP+N7jpXshpd8oP/C5UvCnfgVIDC2FDZBNFIKYyQrMcWOBp4SyGZ+MApcLm7BCyvabmyv/qnFaQ9VFxEVeZxbKVumabycEm84CvQpA/tbKWhnc/t+3HGkft2qNVsrbzkN05bcZED3zCqOvOLJwuAkPohjYv/FPMPDbbY23h403hYYLLyUXWPZtfHGov/IvL+1MTbleKkB17bw1Q36Z5SrfgZm2l0wLoGrYbZZUzH0pU2L23Q8/qiX/IFvJaI8kHw9hkbgDX2RuhQwT19PpFUzQUnCYy1Sf7Kdr1oRgqK9XP55zBh099JJ3D96sxyFzl7Vs/X5Ox+dSyL0WTp4WhnqOO43khsKMPQyRMo0CP8hZ+TitQ7BrK/3/lvQp4F/UTLLGDjXDs8lM3UtBFnqs4XpNmgSqMYUMsTI2n7DFhCXXTAJGejJxwnVeFGyy08VMsaUqBaHxCEARxskzqCond0rDjcEgi+HTn9QRLFokt7ApmKtCgER90z9MUuiDvYLQU2/YT7b3gKy7m5060YtWJWwaVGrpx/aYHLon2FLahzj0OFMceJdYAQhoomg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(86362001)(2906002)(38350700002)(508600001)(38100700002)(4744005)(8936002)(9686003)(52116002)(6512007)(5660300002)(26005)(316002)(6506007)(6486002)(1076003)(44832011)(6666004)(6916009)(8676002)(66556008)(66946007)(66476007)(4326008)(186003)(33716001)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YbtHq6W6ODYP75zMx7kj1gEON3/QTjv0Amvpj0c4kjSbcEe1sDu2gWzm/Q85?=
 =?us-ascii?Q?pcS2Y7A7j9sEYR86fMvNmKrP1wb8/umJ18bkr0tF1Yx0ft5SpalQsvFcVija?=
 =?us-ascii?Q?aOezUvSts3hcngWdl7E/Ncr+22hUPWbwGRFbWm/fodyY5f0GxxhpNXOIQN1g?=
 =?us-ascii?Q?PAe5I2pmpDqdzbk98hIlt9b1e8yCykj5gNPJMSx+BjURzv1D+VnanU6pYkf7?=
 =?us-ascii?Q?ghJHsFKFLm0bukOGeLzHQgwDXfbKSU50p8BCpZ775nWOJrULuGmnzV1tKmnm?=
 =?us-ascii?Q?3QV8tpqtkjcRvksW3ggaTIkcJENGJFV2wE/KYjsdNb7jgNib+z2x9bzuL0DS?=
 =?us-ascii?Q?Xc1KmDkLTL4Hvai4KQ7Uey4lcQXfNXC//TWN6q0DZ2tJX8KLUrIwvUo1x7fL?=
 =?us-ascii?Q?Irivdgjc5SGIOXeuNATYTE/Rz/rgHAgk1jwkd9QBxzrSvQ+GRt+9f36386ih?=
 =?us-ascii?Q?F4THf64wSLu6vbLIxPkTqMfsQTwg0Y7x8ro1Uu1UW1X1A/aRa1EpuASsvsxF?=
 =?us-ascii?Q?Z+Ja3jOO5OAI1bZGo9hISyvEOGVIUBXb1NxyIA6IiDGSzuCfxA0/WH3qH7TH?=
 =?us-ascii?Q?SwCsEp3XUrSlIVR/7xhoxrgshPMh15KQR0Ia1MVZjyrghd2ONYAl37H4vWK1?=
 =?us-ascii?Q?gm7DLnIgGU19XB74K74bmibXm6YysoXrAFvSW92B8Q2qWj8Bj1EMIaYDXt6F?=
 =?us-ascii?Q?6qOhGlX/7bXls/kOlqmjCx16xsrob66YxVkwr/DCvVbg4Qp911n7KU4U+zpg?=
 =?us-ascii?Q?3g2nBOl2+KqwS58kNc+bRr5kTXN4wYUUVKFsuFeheqb8Q4l9Oay2EXkT/WqH?=
 =?us-ascii?Q?OkJkTFfyEtQ3tfnTlZDhAFshuD27LmLySybvuG3hVL28ONzS5lWqOZpnL2Ff?=
 =?us-ascii?Q?jP5DvN42+U9nti8sXxvCbwjFS0E4csFEFzuycLk+e8jQa9hwQViKQFT962+q?=
 =?us-ascii?Q?gn3RlMezsK9lM0COGNh3f3Emeh4/Pnj63sFm/PELUSnM/svtDpeWg52S53wD?=
 =?us-ascii?Q?v1uiKW4jHr4JTEgvF5Kim1lVCfCMNa5xDEmEe8UWI3j3+snRN2k3SmY+FJbl?=
 =?us-ascii?Q?AgERP40ExeOm+PBmLGQmoVdZ9pqsi8/tbtHGm8PB8faYlAXfcN1sDIdDPyN2?=
 =?us-ascii?Q?s4oRIUZ2ep9bBsNN+huiYip+dchArXDmJXKp+alI9JpY0YtzankDOKO52iDV?=
 =?us-ascii?Q?N1tBMS+FOW5dIxd+iDU5ChrVrLpELJoiAp6Q+h/QbdImAy0EujgxBX3/16CY?=
 =?us-ascii?Q?ssOCFYobzSpNA1Oxad1bKL4fyeG5Zix4ijf3/Pjvsh0jzuYzUWaeLzuCsElo?=
 =?us-ascii?Q?fEBOWSbdBkIqHM5b5A1JeP8/bhD22lClU8tF+tbLJ/vn1JjTm68K2dRyBfiQ?=
 =?us-ascii?Q?4m5mP35qRi8O9KF1liEiUJkhIW3BTM3qF0wIKt9ykGYF9+7G9AaSFHYZg5bR?=
 =?us-ascii?Q?XAnBUd/VL70OfrfylJ7iUdcrrWUnh+qS4tHzBMZuV4whSC1dSLhxLAfGMtQ9?=
 =?us-ascii?Q?DBlTHIhrJdytLug2C+0VOu/UR02rRJiCP7rK1IGLmSNehSsqGVAHw9NumA7l?=
 =?us-ascii?Q?Spe6kPR6PnlW0v8pxs7CeaXA0rlSc8RLAIkNL9UFbumEtqLw+Ea+sZ0HzaHR?=
 =?us-ascii?Q?FSz8nNq/EDVKCTdADkCKfJrARgiwAZSLEm5LJXJCglc+N2Yq1lAD2ffOpnCM?=
 =?us-ascii?Q?0VSpeOfb91WBiEIR8A7Cs8P4rEairprWznYy78nuxhrHxWUwlTYSSlyN+uZK?=
 =?us-ascii?Q?21PsfJazOVr1Y/K3cmTZp1xERtqjp44=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c026ed-8758-4c98-c78f-08da48b51041
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 18:39:32.7248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lr450dseS3rjOeZfc/ac9RpihGjCyYygmnICqihLf3oE4DXtGQnsNmA6fcShs8a44bk/iTj7b9FTzCQJjQy1ciZcujlCpu/y308FL+D5RnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1400
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-07_08:2022-06-07,2022-06-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=519
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206070076
X-Proofpoint-ORIG-GUID: Xw2o78V-rqyT5R0TJEUBMl8M6d6_a3vK
X-Proofpoint-GUID: Xw2o78V-rqyT5R0TJEUBMl8M6d6_a3vK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 09:40:50AM -0700, Jared Kangas wrote:
> Thanks for catching that! Is there anything I need to do to add the
> 'Fixes:' tag to the patch? From my understanding, adding tags is done by
> a maintainer later on, but I'm new to the patch submission process so I
> want to make sure I'm not missing anything.

No, it's up to the person sending the patch to add the fixes tag.

regards,
dan carpenter

