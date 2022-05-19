Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2078852CB9D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 07:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbiESFqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 01:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbiESFqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 01:46:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFB4101F4
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 22:46:46 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IMImiK007814;
        Thu, 19 May 2022 05:46:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=TqjdaCZOb4lWpVsNnfQ/6xOy/2gqwj8DhfENbswVA3U=;
 b=TJ+uB2LhugRXzu9szx2kpR7pRlmQHCgbNDPgMqeKuwNRxuOjgHXsBqgpz5v5OEL3FzFY
 UKNs1sJvXrzk/K5KB04/4rv70zIPnJDXaeXUTW90ZrIB/GdjDewa5ghGxjaUIzOu9rD3
 dXC/K5YIGJZzOUqH7MAR0kvZXmc/Tf9KxtjlejpQV9TMpXA1QdO2fDnCdSyqaD99HTwa
 iPZGg89I/vSGB44tt3ncS/PFnA8Z09fcY/nS2hxOlHgPvqH6N4x99+XtSg7Wc9GbVcSy
 X87JGXKqWnzmWfKHyePmk1wg0ZtoUeQl0R7C8SXG8fPR8Sy2sNJELSDZ50sY6Pa2ngoD MA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g22ucawdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 05:46:40 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24J5Q2rf033350;
        Thu, 19 May 2022 05:46:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22vaeu6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 05:46:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKvjq8deANBBZphwc3WWOs8qbQgcDJ1W/KZMVnnprIaffvfQKRj2Et5eOZ24Ekv9C+UeVJ7tSxpdZoxm9GHQrJt3YjAShCetuU4f9jI1a8nHRsGERUFmPvQS8LtMVwZ3EUb2CF9gTHau1aVNMpIsk3ZqWY9mKY5eCtcIC9t9WL0NMO/nA5zDq96nhf515jiXhk1x36gb9roABnlYBSCe19HgGWUvOa2Ad21peLrTkJLDURFNJMmyuDNlj1San1UWafQDi0Mq2ZbfVYlObL6dxtsNfAuokqw56jjkeBsco4tPKz3WI7HF/pBrPtr8Cwf7Uh/ael9oVk1L8JFcqoBDtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TqjdaCZOb4lWpVsNnfQ/6xOy/2gqwj8DhfENbswVA3U=;
 b=LhDcLvq0bNVyva5sNmuyHvuTAxw3eRys+6Pd4RPQokHYdfaDkVKNwLfmfyA4NXXPMdQqC60dN52zfxofCxOszt924Lyp19U7uFurhjegbIpCCAX/2iCjPLU6BzgKVfNwG/k9n1lu05NNR76y0L2rmNj4Zd9UeYh1QiXOsJX6RK98SHNAwBUiZIkHphQBdSvuORTbhDfi3zWjDZCI267whF5WJD2CzmtRJ/FptinZzrnljunbWNXD1iQklu321q9HDpwWalfmtZdCjvUg0/y3dMNlEbYf21WfKpuUiMbt8KGV4GvO+HAI2w6wlmeIDsB9tcB1dK0lc7PSwBk7MFNpfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqjdaCZOb4lWpVsNnfQ/6xOy/2gqwj8DhfENbswVA3U=;
 b=Cjboe3oIBgnF5KDxzJarJQ2STA4oz03gkmeLTwEhsLo3O/ai3WqIg5gVjq+Rj/a1oYN46IkLVUuY37A+tgfQ1Rn3DIG/apUa+bahV2gRQo8QaSQafCJvEfGhXasjWAeUyoi/E/guPhA0DWa4bXy0yYS87w9ijI9CNJ0YbHWiTNY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR10MB1543.namprd10.prod.outlook.com
 (2603:10b6:903:2e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Thu, 19 May
 2022 05:46:37 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5273.014; Thu, 19 May 2022
 05:46:37 +0000
Date:   Thu, 19 May 2022 08:46:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 4/4] MAINTAINERS: add myself as r8188eu reviewer
Message-ID: <20220519054602.GV4009@kadam>
References: <cover.1652911343.git.paskripkin@gmail.com>
 <42559eab6dd1a69c3fb11ee6ed1f33337041817d.1652911343.git.paskripkin@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42559eab6dd1a69c3fb11ee6ed1f33337041817d.1652911343.git.paskripkin@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0018.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebb54a76-a12b-4ec5-3515-08da395aefe5
X-MS-TrafficTypeDiagnostic: CY4PR10MB1543:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1543667255D23A133DCB99828ED09@CY4PR10MB1543.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cEst3TpsZMMOLIgQMbTZpMBptlh1cHnldxgHugwzkviTPWvSE99aSmSsWGyt9W73TSs6lJ4cRXmJ6QgE5OfHwB0+n3ld5camRCcVqueXK3nFyhRaQau3YWPQa3QkE24S6yF1NRZFHZ9hYcKvRzVyCyzvEfBv4E1wwqeeYYe3Z8nroqAXJzNBS13t5S1NNi6Pu2EpqNogkQSi2Rmu9XO5/uneaUDKi0N+c4JUPyKJU8SwJxtWGa+/ZwLZKIVnHeq7ouBgasCxyh/7rNPQF0LXfMPK97sGEBpBjGDLFZSLqmt0a22vBc0X3aVdoZ8TYOgr0gylfT+786mdscoqkKJSaz58dw3MBiNtdpBj+uZcBK/3XjB42MDZjxz8iuvZNJ2R6UMwSHD8wyUpLrlemogiTiKQxFCN1O8zj1yXhIq3nUUpuvFpiLydBhby26i+UvW2nsn2VamOVUBaho/Jn3w3x01/iuZpg0Sg6rVWtZ9oIZAHZtG280YGfDWTfVcxi/BhKc5lFTyG5eDduRflpDY612UbPVx1g0zNUHK7ppsQDdXZRWRejrO4LfhCoXexRQUZKnDJDtdS1y9+pVrinEQ1HHH0MjkWSmHdZ05satQKQjMD3gNrhidzDHPkVuqybB5n7CLHYFf4CHF+Ny5JyKgJ+ibaLr49bqfByw+q0SiVobhsvp4MvfeD+HyexZuMkI7mpNNSgNSQTn7iHcdq+phPqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6486002)(316002)(186003)(6512007)(52116002)(8936002)(33716001)(66476007)(8676002)(66556008)(4326008)(86362001)(4744005)(33656002)(1076003)(26005)(6916009)(6666004)(9686003)(508600001)(38100700002)(38350700002)(6506007)(5660300002)(2906002)(44832011)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2HtuIOqN073bsFp5XPAp36i7m3D18kmeWHIaprzpk/MdD8Emq4TbAHvbPEOb?=
 =?us-ascii?Q?GiIuUpKavBZsrvAVqzHCf9PAXLXtypy6dQP+XeKfrVLq4DfONez9c2VWbrH7?=
 =?us-ascii?Q?R0JhXC6oIKpQkp6zTwFqDfauCACsc9yVdwyGY7if0FyCFydQiuDMX1DEgHb7?=
 =?us-ascii?Q?FgelXFnhn2EJPDq+0Iwl5qDFZo30ZwwFUxbgCmwibzPmaNTQGH4ufesnddIR?=
 =?us-ascii?Q?APtbjcPUG9QgZhZWq32iVorddZsaOyo5d7QgPuzm9AKrxIkGS+R2XaFiJJ35?=
 =?us-ascii?Q?QuNGDHALp9ukI+T+80omVtJ3a9SiyqpoVNA8B699RAq2cRTisGcm0vN7qOj3?=
 =?us-ascii?Q?4HvCJpj37hffIuzjZ7DkE3L/Q+mDkVX4ycCgkEe/KLwxENQXU3kGtM+8Depv?=
 =?us-ascii?Q?lYM2NSE4pFvpf1FA3pTyk3TJvbTSO1dxx5g0ERUOHtVRXnPKUj5pOF5QvMoB?=
 =?us-ascii?Q?TlMjV2tBaXzTv8amoN7t0Um84mD6Nj+ZqeHBhPU6d3lYvBWlOOAffxK8tvtQ?=
 =?us-ascii?Q?TN/+PLlA1EJgsw+5BEaYvgjV8r/yttMthwPVFse3P163eO7LbtvjgvIlHpY4?=
 =?us-ascii?Q?eBzR1WSiGUs3cU0qkjQJtEshNGMk7jhkmSvZx5jckDS+RvdO39e2bgAhucRe?=
 =?us-ascii?Q?NaG1R6r8nntkTZhkDRohHNhhQWctLquTy011TCGdZheHDrXGVOiX0wzqWkp4?=
 =?us-ascii?Q?8HGu9XpLvOqGhNc/g6I4AB94qP19pXkCj2iR/NNF6FUm8MF/XY7uGUIrLRmp?=
 =?us-ascii?Q?cRC8nW/1KwtiitTrS141AsoVBlqzcl2TMzK3MTJCGI+d7dnASqt5frRnfduL?=
 =?us-ascii?Q?d5HZCXMBfSvgJV9ERo4Aic/d7s6SEHtazdMoeqdShXsEKh90h5HPLYZyGb1U?=
 =?us-ascii?Q?hsBtpujWarLjswZytYm6djX4j+hY3l6r5U7zSHLMDJUiNZHs1U1PbAuMpV0o?=
 =?us-ascii?Q?tOlFXZKOmkQDHY7QOakTNkppYYvIQyIzOJQc1IZTMY2QfldrEbxpRGXU7SHs?=
 =?us-ascii?Q?lYlnRsvhOjjEMhj+MoouwEBAl5Ti6rWKooQovJGU2diLfr86Yxusey8YTM1F?=
 =?us-ascii?Q?uiht+/ZRldDJlFcH+FXuA2Dn7p9K0j0eoBIzzDT+tHQAj7Lht45GS7MtVu68?=
 =?us-ascii?Q?ZbOd9vJJziWf8zwsC8jWRz5wDzYQGaXzikBsgXl5A6d9KAnLEWHdRze2eXNj?=
 =?us-ascii?Q?Ku8QY6D1/QDIufSXiKMe/JjJv/BS4h1ahAV7TG9cB+DLgjAAwqRGgE/jkHvP?=
 =?us-ascii?Q?N7asqZ7PzbTwBMGpzFb7pqRua5pS/Jpd8OSJJzzBjesyal/gqJcbHVuy5FQV?=
 =?us-ascii?Q?EhHGDzD+fpbjg9e/uQ/ytghSKkgJvx6OC/UrPXruLvKOhj1gOjLayOQtxI1b?=
 =?us-ascii?Q?cs7sU1ZEjidhYr29AtMfxvEuwg3Pa7Iyp98l2XJupFfD2DzJ3RYckK6QY4y6?=
 =?us-ascii?Q?wJPz4HM8kIVRt5L53NC+kZp6z383keJZxXJTcB3Iqyqs8+tzWGw/LzbmqTJ4?=
 =?us-ascii?Q?IQR4aPx9aBgy7d2iumrxoR072QcY6AvArF1R84PcBYGBzsKBNlRPCOHmpxnv?=
 =?us-ascii?Q?A+yCPPwCWbZQ5rtZ0lvy31Cdtx0dYaKz3hFIfph6dzaofL1VrQlGWI7X8yRc?=
 =?us-ascii?Q?iifJq2OM+s+OsC+z5Ub0jQW0fhgFr3PR7VNUGyOAHPd4b8DD/mBV0X83wXV7?=
 =?us-ascii?Q?SdxJf3It7ZWTaYUpp3AV/tcybNaks5+kMMmpwJb3RT74q8Hb77VJjc50wEcS?=
 =?us-ascii?Q?r/V8YiMQHpdoY1MyayHQbVxaS7t3Xx4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb54a76-a12b-4ec5-3515-08da395aefe5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 05:46:36.9086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2RobFCqA+HqMPa0FbJuBsIOYmhxcw/TEqgwWP+tDeAvDp4Ndx3xlcKMizBGzRHKFXl6N8VHGqqJDCGcaiLODUCbFFUDZwAdCh1QFV4UOXzk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1543
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-18_09:2022-05-17,2022-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205190035
X-Proofpoint-GUID: 9n0JKjeDm4AhWwQY1G3ay54qAtW6h-ga
X-Proofpoint-ORIG-GUID: 9n0JKjeDm4AhWwQY1G3ay54qAtW6h-ga
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 01:12:06AM +0300, Pavel Skripkin wrote:
> I was reviewing r8188eu patches for a while, but I am missing some of
> them, since I am not in CC list. I want to be CC'ed to help reviewing
> and testing more patches.
> 
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0a635f2ae5b9..bd38a2e465cc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18716,6 +18716,7 @@ F:	drivers/staging/olpc_dcon/
>  STAGING - REALTEK RTL8188EU DRIVERS
>  M:	Larry Finger <Larry.Finger@lwfinger.net>
>  M:	Phillip Potter <phil@philpotter.co.uk>
> +R:	Pavel Skripkin <paskripkin@gmail.com>
>  S:	Supported
>  F:	drivers/staging/r8188eu/

Acked-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter
