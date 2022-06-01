Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32CB53ACDB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 20:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbiFASfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 14:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbiFASe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 14:34:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4FEAFAE7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 11:34:53 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 251GNKCO021292;
        Wed, 1 Jun 2022 18:34:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=ttL6fL14rpHyXSqyGwSZ8tcJVHbvTjfL0T8A2KLU/jw=;
 b=HBnHl88Ko+lpH/GXOiYU+xlo+cz+jO76ObnGFWBQ1GEznmQMNsGlYu1KFN15uiWkoEGM
 eHjaNoaOQ5qFZ8rrquhGFdtE6F/9ZV2h5GGihAquBOS69UTah/cw6s+sIjFVfF9r4UT3
 DGN08Jl+Ka+DKg6fruSjxwhXaB0Mo9VkZTUDbzlF1RxINzs+v9qwnNoxiAqdrjZADJS+
 nRzgdUNxNaaiXgtRmndMJ8N4BFqWA//iZ8Vxm205b2sbwe250Fys4AQoWJR+UHQOHfkH
 kue0cTEVpT7N90HFnhVLDgU/BWyRcevPI/fHno5pA2hrFFrOIZHIx2qTuDrv+GOnj79f Sg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbgwm86wn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Jun 2022 18:34:48 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 251IVmwd014440;
        Wed, 1 Jun 2022 18:34:46 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gc8khb6u9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Jun 2022 18:34:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2pvq3iaeMDW31+Wsd0rsLGPeYbMm1bLIH/JURSYPZF//zANxnqymSSFv0pnsSYAhwL5RJ5eWn1mmfrmx7+lTmaA5sb5OJAOzK3g232kM76xI7jM5Y3vMzfYGHSPTDFDUF8Mzgi9+t+TDoixnzfh1T8ZwMfKPs/FZ/sTTcsMADVcieKORCFJFOBclj0tdWmo5wUZW9hMj70gQHGha+mILnigXwpc9C5EaexxKlJKY3TMg0dfbL/fLARf7AqzV5JssE35sX7zWDOffyi3JTbZI8MDEEaY1iY6YKjHoKOT+4FXXf8c7y8+zatGSDBicgCxPefyxKAl6wVR8kucRLVz7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttL6fL14rpHyXSqyGwSZ8tcJVHbvTjfL0T8A2KLU/jw=;
 b=LLzB5/MCzENm+TE2YhqacpwBQaw9lhSBOGYm6JeoGA3M34FyeJvVkgwJQrXVfeAqh2w/16tN1VHT9BI+9j2xQpVCrtadPitwSpP8pbkTzuDp8o8eX0HlO6eccbBWwSpU44NO7prK9dYjfwleJLYFHvRdiWM1NLINgGrvxqIdCG/hqXNDOprz+m3EoN0nVGlyCgxedC1iSYeZvcLyZk4Wp9cPAisfWFrMAE8itB819r64ki0QfWmSncJWLySYJ9Ax2LJa/KRKiIpPkvFol5S80/xKtXdudg932m5JMm0w9UgMMd27P52BqmhCySNjeCqji0H9yhDLXGiNzHhII3IvmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttL6fL14rpHyXSqyGwSZ8tcJVHbvTjfL0T8A2KLU/jw=;
 b=Y4Bzj2Ckzj4d9KJqldFWHxxxhZALYYiMa8ktD4NNW46qdanEdBc0dZ6YFr8OKT2bg3KNcCfXW131readogrDwfvnDRivRkFqZ06sQo/wSmu9Hnl+Z4fcEA2d3Wz4R8Vt/khkCYo2hK3ghbgvg9EJPzLnDYGKBGvPvT2Y2yxES40=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SN6PR10MB2718.namprd10.prod.outlook.com
 (2603:10b6:805:41::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 1 Jun
 2022 18:34:44 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 18:34:44 +0000
Date:   Wed, 1 Jun 2022 21:34:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     =?utf-8?B?5LiA5Y+q54uX?= <chennbnbnb@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: CVE-2022-1462: race condition vulnerability in
 drivers/tty/tty_buffers.c
Message-ID: <20220601183426.GD2168@kadam>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0008.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c01ff20d-8cd2-4269-8284-08da43fd65d6
X-MS-TrafficTypeDiagnostic: SN6PR10MB2718:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2718C82E2BB455E7E078EB958EDF9@SN6PR10MB2718.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pnXG5XrLqI1dExWK3PrXnwozqwOeP0zqk0OZUiKCVA/sYS+9uM7goW756smApWJrvA9pSoG82vphhoW0OG4LGjvahVnouyOsXO2QAPfm1HpjIsaaAdySesArEc6Fvi0LkcZWpVJ2sLIaTqMk7Z5dOUS+ch2nR7HYJc6prh1qPUbJl2V8Nbxdl8+wYdhWkLLcDjiAoaX5ZsQfOYERv6/hDarRAgKPWxkXI2x738ek+iiYSEMdmdRtOHoQaJEX7oHj7McJHdmIHZZvctUqEv28GuZZ5AN688p4xKyrRkXz7XHkMY3vXFQPC49bg/0gHsFl1X+Ldpf7kuumiT2eyZSKd+JSTX1mmEhVW1+BVaL6TpnN7tJ4olcpmosQ4Ycr/stsQHOzRM+mtdR9q1dObur683d4WQiZjB3n0/fdq0FufrE7VD+FVH87aVwuvIIimcMz0V8xSK01objVRK5A7TxQXoj1twZufn6FrmpA+Qyh6zT7Tz0gd54Dz+nX2BErub0GmxWmu5zFRPXraDAzFe9G0M8elhy9W+2pUMK9Or7Ivrlk6uNWxHEALr71k3U2J33s3benmUHTxy5ODbaBmn5veypnq6rOvAmLCGzOpXq1BGLwkVI4stJFCLCaZalN0QajK6u4NgJ5UZIH9OGAmp6toKxuLk5C5mbzv9rW6Qs6ITW+VYr1VUgbj95NoZxfIuc5O5FlGbsTWkIJghMHigEF3SEMWXaTBNlLUVmBU+klG/KTM2PZq7isOX0kedTBDWoBxg5V6UhMrMwbmzuLdI89aX+hzt0df+pPo43icf4P2hw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(4326008)(316002)(44832011)(4744005)(8676002)(66946007)(66556008)(66476007)(6666004)(83380400001)(38100700002)(33716001)(110136005)(86362001)(38350700002)(966005)(6486002)(8936002)(508600001)(186003)(1076003)(5660300002)(6506007)(26005)(52116002)(6512007)(33656002)(2906002)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uZI57c6T/a67vE0M48Pd5EtLoD8jxvfS7e1vzoN3ARYLngmmADlJis3pntfb?=
 =?us-ascii?Q?/BCNfQhFHIlsLoO4Nrq25qiT9bolVgMvlV0IiqxwbgGKQIbSBJxjGMyeuO/1?=
 =?us-ascii?Q?5sivsWruFoq8jnQZvs2XCOQ14gMrMWWkH/9i+mlI2gGzHYYigoVARxxSMRbZ?=
 =?us-ascii?Q?wE+UJ5ZNXSfiCAULKWpwsuaOW1VFWakAZFqKndjrMkxZeOk6n/YCtqIi9pj2?=
 =?us-ascii?Q?RptyIh0KB1cxEPMG7Vw65SkMXniIYVTOpeJOLf+lSdhMh5/Q+VQ206fXdpW8?=
 =?us-ascii?Q?IApKBTJihQhvp27o7TcytO4Te8EVmiVgM0LTTjO6YpaEvZAk2paFBnQ0Y5Lt?=
 =?us-ascii?Q?Hc6X0pPo8KA7XUymXdbwEw4cuuBfPqApddu9wdzhh7H+43EJHC9eB8yCASs7?=
 =?us-ascii?Q?6krc4BYOmRyL0fiQnqNZun9w3zZfYjeCwI28YmHUFQpgzgu+xHB37SzOxD8U?=
 =?us-ascii?Q?xbU6UHBCErI989ecrlTFOSvpVIGsd+vc3RewPsyyuFJ2O5kwM5OtyQBMS7+y?=
 =?us-ascii?Q?6dQnraSa20ylEroV8MdFyTCjspoZVjoQqJ+ZPlG3vrmaxe1nqAmxnvGxd+YC?=
 =?us-ascii?Q?Beg7+qkdg7ug6iScanU+0fnafX9OhvZHOBO5le9knJ4xl8+XIUmZQw4ZNL/u?=
 =?us-ascii?Q?MAdm6N5IY0G7z99bpm2nuyXxzETuKmMcmgjQQ2Qkl/+lNBblIrpu+dhX6vja?=
 =?us-ascii?Q?eHlkfNKpC45C1KhNGbdJRXkd9O3SZ+BeR/zP1xmZFVbDQZoVLY20+V2CKhL/?=
 =?us-ascii?Q?4BYkxXRI6ntqYFMV0t1NPe+Jn5vb3mJ8GKmu5wgUz5UtiCXLWALSzi6OzT4Q?=
 =?us-ascii?Q?2ekX04nt73rSrBxl5v6mksq54PZJW8omXiuLrBH1byqz2tOS9m5jdqRkzDnB?=
 =?us-ascii?Q?vwdR+RrHLePsKIUZVObTZO+7fpOZBhNuFr2609hsAFwXQnFdf0fksCQfa6Mw?=
 =?us-ascii?Q?w6VSoLihjyBIQdjCmGkVDRSkz8yTkQroPqVSu5HU3jLClRKpDrm85D+/VZyA?=
 =?us-ascii?Q?2qumMy68C01zUBWGQYWsPUEEtYsaMGzXLgG6XY5y3j6EJNIuoPzJg2wzMXLg?=
 =?us-ascii?Q?QzMN61eOXH3hTeQBhevELBgWIg9B9VImcfiM/aJ33y3lubRloEZpQVS3M7pP?=
 =?us-ascii?Q?YnjdeQyLAz6mHZgA9z6cGSiiIwSJfxKr3bw6oChKLMFM3iuZWcZfjbUZ9uA7?=
 =?us-ascii?Q?qNMrCimVKdZaMORXDgxWTpSoGTKZecuz3LFqz7KSU6BdTxpC8K/5fdqZrXcd?=
 =?us-ascii?Q?o73OoE9Sp82Pavwd3yxyugaSsbH1PhA9znaUANszIBKJ2DfvQMFU6lER07X9?=
 =?us-ascii?Q?LF4no3ANtbE+UB6LgXU7domyI1F3QXJejzbRPZiAgObgb4NE/lFOXcR3TzAU?=
 =?us-ascii?Q?DGYj5cv6Wb2xe7kd4jkddMKvU1RjDPl8DpOWMDYBMub5OXTsSLmvGYC5/lxM?=
 =?us-ascii?Q?WhkZlIJRDSxziBLhkNFQej0MsX6mzfPBF2RcjXJfPexyDUlnEgZmor082rfP?=
 =?us-ascii?Q?KsJi5j1LsMyWIy6pU9dtHJ1s/ucs/8Xq/sqbyfNnMSnk7xYxDo6P+yB49p54?=
 =?us-ascii?Q?NjbzrzpApJwpKa3GyIk54Guml7IP/j+QXOoZ66nyFfjnvuSvMMUW59EjYoTJ?=
 =?us-ascii?Q?sSx6dwO0YTEx29arZZLHWZOxAnGmLuYqDGO9ariQV14sDrdcmWg6s+piAyx4?=
 =?us-ascii?Q?XhvdE0e0wFkGDtpc8IVvD1j6HcVxeJ6I7Ktn/HGG1g8UPfsWDMDXkQmU9zIv?=
 =?us-ascii?Q?wNqfFMTpWAlbSY7Ge3Kh0kpYR4XaKyU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c01ff20d-8cd2-4269-8284-08da43fd65d6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 18:34:44.2408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MipUVUvEVjNgdwXJohkXuu5u3OnfKp5+V1vjvJY1+IOC0TlFamCg10jGqfpWvijqUoRcN8kO5EP0r3EeeGG32rX2z0ElQQvAiOiMrnFgHkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2718
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-01_07:2022-06-01,2022-06-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=702 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206010078
X-Proofpoint-GUID: rpsBY5vaLBl77Hr2VqX6iFr3yadIBKQ0
X-Proofpoint-ORIG-GUID: rpsBY5vaLBl77Hr2VqX6iFr3yadIBKQ0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, Jiri,

I searched lore.kernel.org and it seemed like CVE-2022-1462 might not
have ever been reported to you?  Here is the original email with the
syzkaller reproducer.

https://seclists.org/oss-sec/2022/q2/155

The reporter proposed a fix, but it won't work.  Smatch says that some
of the callers are already holding the port->lock.  For example,
sci_dma_rx_complete() will deadlock.

regards,
dan carpenter
