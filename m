Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF89852E670
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 09:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346599AbiETHoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 03:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbiETHoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 03:44:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639B814AF66
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:44:04 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24K5TjgU029971;
        Fri, 20 May 2022 07:43:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=SRezQuOFrQ9mctEN1rSidiqhUuxmniK896656qtDmRY=;
 b=f10lOixIpw7HiHnxmQJKsLuJZHJbQiDTXKljkXF0O8KHxlFHH0shMJdQf7we/Wo5fwk/
 iwgBW1LzaVxekNdt7GW+6P3gpZr3T99cfJELxfm/nc22NhDlc+zlDLTXrn8fa9XccSLQ
 GRU4dQKood86a5Ba8XVCTX0G6nWr7a5BjiOTPrbP1sm0DWLGZvWW01sd1WGq5UUuBQTZ
 F+DC+34QoXg+Vv87c9T2LctplV4zQ0fqv6hwCKwLrTF3/Jx7dNjL2fsyAbTISIUdGkws
 nlzLZvUSwnqrNgfivJpsMM5VAAuBS6Yan2H1hA1XG8fWxR+GDQ4Ar/aXN1uLBVlfoiwq Zw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g2310xa13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 07:43:51 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24K7Z8mx006803;
        Fri, 20 May 2022 07:43:49 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v62dtd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 07:43:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F37t5SdR9sds723xrFALixVxDpDb5jBq6HGlLQLKWzwBAYFdyMxgqnksCSEoWt/h4euAhptO9fY1fSni9ixEdrbfMWa9q13sqx5r8m0mPw+ODPtlWnOhSwPXPb+nO59W0UiveHpzUF3QTXswhSggZV58mzmYRPchrjKuMSrKmZu5VhkVhMXfwfXQgHntCqu+nS+Q9CEXdxrqVbRSfX8OGC8jCxh/cmRslohnqKjAft5D99E+zRCUb13YXN+/OM0XG7kgo7B805jfcWCkSpV1rIqZpips5avXUk6oYMFUZiJ1tJ+Z6QMj+4Adp5GVkoFkVLvMUwXTzammxNFv6zmpGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRezQuOFrQ9mctEN1rSidiqhUuxmniK896656qtDmRY=;
 b=lia7Bddrk67Z3LYcZvZRywRXMrj3FfLSxJKtb1cR9bzZixmqTsCxVGFa+nFNEzTHx75Zl2QPb2czDaquhoXK5/7y8b2StQl2V0MCUU7EjZuKX5XSPxJ6UH36r89b5jlH3YVGQfTH0CTHgNxNY6Zce0Blh/uDI1bZreRS4m9yaDBubuwDQJ0FYoha8wri6aUw1PLZ3x8JcmTvbwZ1yChIrme+WBOllMegpfiVLVNsSTaoV3EYubnem7Z4oV3bjbXXDowAilYG0VOJ6eR/X0nXM0b4D0vY7z1kfjOAYnI8389xvofrh9xIG0nPZP6d0Sb3whaqJizVTukbEda2NYv3BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRezQuOFrQ9mctEN1rSidiqhUuxmniK896656qtDmRY=;
 b=Vkvx7uqtP0pbZCBBbTygIzEg2qPE3N6WLwVYWAIcD0w2VKBlQxaSWRQUMHkdZ7CmyeeD0pHRu7pkmjTsVF9FWke6YWI70nphGTlVVuEyaOpQtBvUWNXjaT8joxaB6LfXg5NaWFCmfRhxdEQua47oSOd2GSpaHetL0GeXE/HStRA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB4669.namprd10.prod.outlook.com
 (2603:10b6:a03:2ae::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Fri, 20 May
 2022 07:43:48 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5273.014; Fri, 20 May 2022
 07:43:47 +0000
Date:   Fri, 20 May 2022 10:43:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 0/4] staging: r8188eu: add error handling of usb read
 errors
Message-ID: <20220520074335.GZ4009@kadam>
References: <cover.1652994483.git.paskripkin@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1652994483.git.paskripkin@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0020.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:1::32) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed860909-a40f-420a-5dfe-08da3a347942
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4669:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB46698D091E640B1825E8DDC48ED39@SJ0PR10MB4669.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VLzMhC9jHUNIruKyqOG1GOxRnQjGCRtVDaSO4ZeBRgGucwGIPYdOxpHITUfPjpiIxy0HKissjHPeyY94rFqyWmOHCy4spf4ErGcsfIS6Nq/81iUX/lXxfvLvQrnRERBooh4zo0YlVQ20eehDyRAEJwlJIbKNhKP+o/b8SrQEoV/53K1m+rma2Lu+YeTNHqt3jI88kWj2yg0yp70kgUpLH/E9lR+El/a0mKn03MfAqSO+xRr3xaLk91OzIJ0dOA5aNfGylgul6JOn4tBcUCso38/RG8kmOUeBQ4CLvb9gr2k2MCRtbvaXnu5yXjdkl3xUq+LLstZ8qC7XZA/t+OEHklgap7tLVsxwkbYF1qZ6yYphoBDlRs/UOElXjY7Q/S0JmOKk3W5IXhVLT4JYwbvzHmWAQtSfbqJ+qGyhAIRx6OQV9bUDOvQBHGhMbzTOxTyJFO3t/nLAMMgKKWeQvSq4CWFsVd+9H0ZYi0tsEGKYX2NldYBQx42tnTb9Nt0WDaMuf7pjZEtF48LCcCjXuN8Dd8Ec/gFUwMxghhzN/FKXGjgjw7gAu+kJVDiZUJnCEQPyMkTkKK7qYce706baA8oragxEu7KKN9dPnCERsOmf/TRu2VlWQxVibJEMZgLGTA3F1l+vAkuRzoYvSsb1fQkaqIFiSGkjJjd8TCrfYC+m8ANH+kgQcZg5dnhsXScxzsNW75Gyla/XKEV5rs6oiFJW2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66556008)(66476007)(186003)(6916009)(66946007)(4326008)(8676002)(8936002)(5660300002)(1076003)(316002)(9686003)(6512007)(6506007)(86362001)(2906002)(38100700002)(558084003)(38350700002)(6486002)(33656002)(33716001)(6666004)(44832011)(52116002)(26005)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nzc6H+CVIzEy1FF0tKLuMUH12XBD+iA5d/gbXidNpyUCdBzBOvHWaqRsGAoA?=
 =?us-ascii?Q?UB2duPO8r0iVp5VkZeV2AazSqS/4i8u577Og+uC3FxJGBtQhYnFi70bQiE1K?=
 =?us-ascii?Q?FGY8KW5fIsp17Xh4942+EmcoXK8a5cN07b7zkAXwEJkdRdzEAgC0bTFEb8h4?=
 =?us-ascii?Q?yE2vAF1aykZrT3M3RYSimQkXiKesqxVUOrT3Rh8T61mhTKQ8wj94YMhLML8e?=
 =?us-ascii?Q?K6UNgqYkXAOK1hzox0CgwzUcE/C7UKF1I+gBwiuk/8kvzO0M6Ps2K5uSYNdI?=
 =?us-ascii?Q?C5AYEhgoGPyAcc2UB86t4mRf6vvLvFnjlsMqWNw5TgsFweSbYvAT8ygJEOIs?=
 =?us-ascii?Q?xhhadqDDXMWQWLYnDdQAEmM41JLTdhTJq0Fy81BGaQVy7EdWSvodzoYYhIb1?=
 =?us-ascii?Q?8054BwhUVjnDWSaC9CEmzWaSSWgHoRTRhTdyHD+a1peYBQt/1kFTflYQAG9v?=
 =?us-ascii?Q?Kjk8I3TzeNWG/m3G+03fgy3zJr3ZtljdgOiPE7JO0LDnneGkoboc0fU1Rbud?=
 =?us-ascii?Q?/Ky3AXnzE+PxKRmkrqTIEgrV3cVB8J/E/SXmQI0KxlEnBm1N0JGyv6JVvzjb?=
 =?us-ascii?Q?iC/rY8b30Xp9oW3p3AUIBFpBbGT3ol0Yo/CYxQA/Bqj0i0Q2VOz6tnHj1DUX?=
 =?us-ascii?Q?m3yKqxKldJpparxn5sw5ZrJSbbhyMpppeHFW6h8UQHGCuTQ3hvfofH2E3APN?=
 =?us-ascii?Q?5A4o2COv68EvbBKYm6MAkE8nKqqO2aTC550DiXkCEvYbxAkNc9oJ0ZZTtbFC?=
 =?us-ascii?Q?OioCwhP9tIGaFuHMmIUheDRGEBDvDn0LNkYsm4Wztk9yNFlFUDyeuFapaMK3?=
 =?us-ascii?Q?EnzGxqqJO2H5gBvLsrCEJxcbM2zSmp9/7IoJwWJA3WvXzFLM7dMcKEUZIZ3P?=
 =?us-ascii?Q?GOlHRATdV6Ox28yiMwxM7APEM89MEEKTUxVj5xMB2YS+RiAwaGKnd2YFPD3a?=
 =?us-ascii?Q?5Yx3Up1ZLhNm6qjJC9CeXARGTsICJqYdPD65+UBxRh9a7lCLHaKRtq+14lBf?=
 =?us-ascii?Q?KNfojAIoxL6TiEYUt5muCcv2dZosQaD9spKI1OHLHgcOIB60aWaFLWPZvQfl?=
 =?us-ascii?Q?Ohj6aYxqmpHRXU/XoHQdXFO07eDyH7TVxN12aR3sAXn6gZtAI9zsc8/JDcwW?=
 =?us-ascii?Q?etY7Io+2mRyykkEdxNjgGoM/nx/be8g9DzWgj0AHy9T9d5108a5zkaVuIMvv?=
 =?us-ascii?Q?sTP0gYspTobIiY7JeQauGMVJDiDnhyiw8dcDTy1PgXjkfYyGoRREwEKPO3SL?=
 =?us-ascii?Q?q2P+7efVaoR6MZB5Sc7QYUZ7UIDV8i5BdjPfmeFGGwrbX/uAPRR57+EhHZ7U?=
 =?us-ascii?Q?dNxMW5z3fJPWVFq4MVrQYmhqc5Mc5zSyv28EOJxUM/c3wCsUAOvzxCVhJPBE?=
 =?us-ascii?Q?yiLI0iqBGHbCjBN07KF8XFNQRsW4hS0lOJmyhC7inRNqcu14J5qmHnhBVQVI?=
 =?us-ascii?Q?UDLTA6T/nxXFTXsSBc/273khqzudYmW1I+sVwkn9HfXyjkMlwCiG+wa/MLLq?=
 =?us-ascii?Q?sk5OP482KPgl/4TAwjna2SytTGSkTmfVYDdHzwONrsTzLNuQS2vHga0pA9Sn?=
 =?us-ascii?Q?ln/Tbfnw11IlnF/uABe9gvlAWo7wIYFI+qsxoDVjDW3D81pIqxDKJGRkaGko?=
 =?us-ascii?Q?dzV18gFGmrDDDmnqNGXrX+gc11ot2geCKcmxPyzFGWo5GiHClpHkDpPhsiQf?=
 =?us-ascii?Q?YoQlADPGyJX3k+JKcd7yf66hO1PwznhLAjIIMuaCjHXmQ8wQEOCQCAb5He21?=
 =?us-ascii?Q?WV5wrVI6JHlyoSWXhOyVIMDy21wahdk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed860909-a40f-420a-5dfe-08da3a347942
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 07:43:47.8292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OHdUEoyem0AJEY7dlbX01B+euOPdNMBabnOEXUhyjJbvvhN4jv+ExAP3cBOcy+G6JubX4pT7ec6nFip0m8qqFyoUpnhdmOHS9L2EgQdv6jk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4669
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-20_02:2022-05-19,2022-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205200056
X-Proofpoint-ORIG-GUID: ZTv8hZ-pI3TbJUGYz8DLqNTYeh_1SaoB
X-Proofpoint-GUID: ZTv8hZ-pI3TbJUGYz8DLqNTYeh_1SaoB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This looks okay to me now.  Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

