Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9BA4EDC89
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 17:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238079AbiCaPSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 11:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238016AbiCaPSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:18:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E609B165AA1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 08:16:12 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VD23LO029832;
        Thu, 31 Mar 2022 15:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=8jYC/oWfzJJtSVbQmFg7kWPWVkf+yx0ygZvEXQfg7hE=;
 b=xALQuAx64N7k3/K6QpBXJcnYmqj4NjVF6U6Cae9HfDmQGcr45J/izVwC/5aOFiJBw+uO
 FEYX+Q0G1NH0ZDv1HpuqizNiXFD+j0ABLf+xvrpKaLi5iX+aE6lpKwSBTLz8Xk8kSo4S
 KwFMicDWRY3pbQIxriJ+ZB5AjUFMupyHNeGz1D9yjFQbjHg4HMHJd6kArZgpqFoe31MK
 WW6/1Rf3QvP4u0vBq+ceGgR5G1kKSuPechSudJnArpD/dbqE9/VXGjqtB3yXm8k8s7Tw
 lKfPHBe38cl5n6GguhtuWJfriUOLdpzg5moyTYmBnExjCxHZwrdSyHmKGfQRrBatrn7v Pw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1tqbceta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 15:16:06 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VFAT1m026139;
        Thu, 31 Mar 2022 15:16:05 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f1s981dr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 15:16:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5yw49zZYekRAHFUDVwu2T1t2HnD34zmGP76uRl66AMlBk3u8jUyD5DpZfBPX0nwFnrTyJNZhnI9k0+KeK8uGXksX6zNkbqTdiua30PkU+t+OykSy8NcHegx2EFDBEAyAMr/UXbrOlxAaiqCcwd4otmMg/wVHSpESWQlInGzmlbhwCH+AxJov1VL+wg2cnzqzMA0gw6EU8pxCqxXYDUykvnEpI84zPD5L+YCfVMQHaF6kDg5Ni2o3dJhHYiSqoSSfbaaW+ERlknbrXZ+l6ebt6Ko3DcOfwyE3NznGRiySgkPw6pQ/Dp198vrNvO6GGfjKjn/S+XfqhOzzodMogPJWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jYC/oWfzJJtSVbQmFg7kWPWVkf+yx0ygZvEXQfg7hE=;
 b=lkxrh3l2QeIUBdaAr5hGT5yBCgpLEcwlOgVsrvLddySKA1M2CyuCQ3RT8uQLWXeqk84SQ5ZHUYKDoZOic43VK7I5yeujO2qhqeYe2dsmde7F6JHOlX7nqSc5PQXzFCffEjphh9O8c5HnCsIvwWyU2zgbVjeYdPoMGrjbJEK2KL1vIN1lmP2g/b0T4y5sEFO0sDJLJ5/048knuoMZbGl9v4qP+LZftihrMWnw/DFhSw0BFaWPKMk/iEBGnl4QOJmrVJxLhJzGez77mp8xafZYbhHcdWKwYaRr3g4MOAtK6XeH6/rrqsfkrXXI5WQAID8lYHhhuw58mnxMcDcJ5P0RRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jYC/oWfzJJtSVbQmFg7kWPWVkf+yx0ygZvEXQfg7hE=;
 b=ugNbY45C7Dw+Mb/hYHTh2vky/HoPunRh1/UG5mbng4VepJSXrfgQIhZ4wTMBiAlX0tKVn34zrrEdOeOuvMwZitx0UTEJLGde1IMInT7NQpAfzmnDDtkxqym5oVZuWILerBRMMtdkY1USlEVjHlrPr+ifOi+PY54Mnn/rLQ4hBCE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1807.namprd10.prod.outlook.com
 (2603:10b6:300:109::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Thu, 31 Mar
 2022 15:16:03 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Thu, 31 Mar 2022
 15:16:03 +0000
Date:   Thu, 31 Mar 2022 18:15:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH v2] staging: rtl8723bs: place constants on the right side
 of tests
Message-ID: <20220331151551.GR3293@kadam>
References: <20220331122618.GA434796@euclid>
 <20220331141456.GP3293@kadam>
 <CAMWRUK5q8tadCVD-AbFCjQs2qvnvZG8Pyg+W+jt52g=sVDB5bw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMWRUK5q8tadCVD-AbFCjQs2qvnvZG8Pyg+W+jt52g=sVDB5bw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MRXP264CA0024.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:15::36) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2633583-2161-4915-6191-08da13295e72
X-MS-TrafficTypeDiagnostic: MWHPR10MB1807:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB18074C8454D0564E85D3BBD08EE19@MWHPR10MB1807.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kF7OgbUMg+UOzCMDlMlqgtnGLCb2PqyKP7nhMDMB2WA+F7xnhESLB1E7qBbboPO6oceLQUdlbXvelGlJLbSW0JOZ4NZwEiO3Twzdc2bK6rU+GfOPqW4BpSKT7KRAMThTufJ6EiNrj/NvaVFzh9G4gj8GifrxgHVAvOIY8D65bv01W/BWzvKMkqXIU2MQNvH0UwAzXATqZwMJX82RKxGshez6yQn5LhqZNTe3WvQddzgDSGjnMOFIBFvStchMX8DPR90G7QAtpLW8CgQNru42TpEM58i3D08lSzDcxu8FsZjsTY5zTcQZPk3oYXw6yZJdCPeZEFCvkpY17REnASTbIM+3ebYs8LqW39UcHdIJ75qgmCT51CwNBcCKutoN3+aLgimF1DmzrMiZ7HPdcMGSt+1C5Fvwb0nmQr/zaNog1P6z1LhN+pDl7V7iL5d4r6MLinggxtTyfrT/Jr39gXMlzBGd3M09xK3PSyM5v3YHve3np2iUdHwH10BxASG4MpDU3ww6y+e2MpXdWcTxp9ZJTjgwy+wWwCxkAmfjcyfvJbPH0uQRfawwP3FyzSOOA3UpSiBnUprW14lRm69eD7ExyTvGmSnZQCyLSDUABkubBd/gFbdUR8SyPZxoNHnmX4eC2Xt849g3yxoeVndssy1p/rJ1rOtYqe73gxKVdSkTc1n4EJSqT33EbwyKlnHYBiH60ILJ0rxQKFmfmz39M1zpLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(5660300002)(8936002)(1076003)(6916009)(316002)(38100700002)(33716001)(38350700002)(33656002)(6486002)(8676002)(186003)(26005)(4326008)(66946007)(66556008)(66476007)(86362001)(6666004)(4744005)(508600001)(6512007)(53546011)(6506007)(83380400001)(44832011)(9686003)(2906002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UXyiMppe9dkQvdVqCTW8EmnAkXZ3AV5NW0SK8gAjrTAqqEwVtryPVIE1NpmC?=
 =?us-ascii?Q?V8vLYhe7qhqUp30AVu2DbyCJ0RF35tjsEfkxR5FbYhjWNLSBYFvZxDUoHK0T?=
 =?us-ascii?Q?N7/Pkz+h9fc2rpok83Q5XgvHuuk7LhwDNpi++ev6pVkD9Z7ZxDysqZnQUVzX?=
 =?us-ascii?Q?UyyOSiySfNNy2GzCdOZbZadWMEhv1S0cpWpTswnv+/vGg9cElEejj7iFLjYt?=
 =?us-ascii?Q?dQA6G+MjpV8Lt/4zgGV5KACktojUGpQxObLJ+UmrbSZeFly3oC3Hc3913W6p?=
 =?us-ascii?Q?LlY5h/CQtUjb9bYGRXlAElkyDrbrvhHXYPbbG5zBdcz/YCGxgufoxNIMq8Pq?=
 =?us-ascii?Q?BIAbPItXBXXjQoBJ19qDIAoFfdAJxXpG1IHeTQnFNpncA+rR6mFCgafxRasX?=
 =?us-ascii?Q?+GvCqgfTYNs+jFNjLDKZ2sNezHzjMg02GftUZi8NrmnTMLiMdD0WdamMJ0TJ?=
 =?us-ascii?Q?mE9PXaIBhbYb3LVey5Pm9nexygTfcOkXAC9VBgbs0x9VV6ZU2e5I7ZxYUfiH?=
 =?us-ascii?Q?5aZirmhlHRehxc806B2zz4h+4TFgfD44Igqqysm2ptbup2OrBXu67sfNsFV0?=
 =?us-ascii?Q?9s+3ttKpvcsotBfzpDjUmMc+hl79xJ0OFLAsb95qRSwygXgd5qUxmT6tdnaG?=
 =?us-ascii?Q?J1DZaWqRlNdhhLNSTxN6u4sBB/Bu5tU1IbaSVVLv4OgJlC6DEF5AnqvPthst?=
 =?us-ascii?Q?5RS18VB7HLTVyPie8k9REzwvyvuYdjkSrqC3NVQ6yXrfYC1EfX9HVFlBmjN+?=
 =?us-ascii?Q?nvnWXppSGJHd5oN1Sfc0bXuMlYW6rtBHL9bRACe4lFADJId4jL5MHRKk8so5?=
 =?us-ascii?Q?jLWf8Gtjw5O6Fa0jtUMIZpbvKD/HrjILcMVd/Q0yvEo0IzJVHZPIKHwlR7R3?=
 =?us-ascii?Q?58AJziXf403PoembD4fSSHPT38GKA1prZyfInpY9njrYzkoSMqYG6H9T+vfD?=
 =?us-ascii?Q?C0H2npspxrlX2zp2vTuX5fviwIAzpjxuUln79nJ9hIyNVf7fEz8P0SVXUUCq?=
 =?us-ascii?Q?urgbM07xk3jgSNCGFzCyffJnVOCX8RMjJy9Bt1XHgduwy9jWkD9GgmWM8+G3?=
 =?us-ascii?Q?8tL/G4C3RzJQ3U3Qqw41CuNb2jKvAddbJXe8RZqs0dSI7Ec8wmTW/xg94vv3?=
 =?us-ascii?Q?9Vb0hR7+fnsTYUM+iHe16fnfKOwxJoRNYqbgk17pWUgAYOX9eys8FNcwNxT+?=
 =?us-ascii?Q?HCAxcpyYyYKQ0/c2EcOSU2F1Mk8aPld3FRO8aRtwda2xfv2Of6ByAXMb9tv0?=
 =?us-ascii?Q?n22vNdjV40Xfi26r44HZLIEsrLVhvzBgW5+UMH3TKpvF8WKurlr4TPNUUP3T?=
 =?us-ascii?Q?EwkHx+4ZLM87v1es67+Psl+LlhHaNw1g/yndltqnmbwCc7yzgJwNNRsHvxjd?=
 =?us-ascii?Q?UN+AUH6cupD5FhHtdANbDcPL7x9ZhNLpY+mbnjszr6cd5tExzU9WRjNkuR2L?=
 =?us-ascii?Q?J4DXYE8Rfdn8n9n/YeK5xo/FzWS+gHAf7jdBiOMw1Eb6i6lD8cBrMse7cemd?=
 =?us-ascii?Q?iwNvmxGFRwqBmqwGQWpAKAhZrble4cCOL43i3vt90DFO1X6BKM6wQWthAw2n?=
 =?us-ascii?Q?9htrESfi0Xa3vLZZvNtWRMpo6Yx8/8FL9/FQ896c89WZOKrCUaMSX9585chV?=
 =?us-ascii?Q?/CfyELt4ldd6HF30QLR66qXBS3s1dySy43ch8oc84Sp8OFq3b5XgQjCH0r3G?=
 =?us-ascii?Q?02RkJe4wuNOTKWl6LuPycEvnlNDTwn1EIXIzUnTd55W7FwxFB+jLrQQP3rFA?=
 =?us-ascii?Q?LbjYM19JmIHH+xEe/1wtETAl8Ly7DiE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2633583-2161-4915-6191-08da13295e72
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 15:16:02.8612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QiS65ENGUibFgRQvDMXkbvydIux8vN2CLwhlwSz/VNHiuREw766ZTTXd4k0lJX5sr0ZSwgRohq1KmSgQ4JRSFTjbNlQcPEdVfs7r6cvBrYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1807
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_05:2022-03-30,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203310085
X-Proofpoint-GUID: gsSdXIJhyM5FoYcdo6rbhSV2r4ZQux6N
X-Proofpoint-ORIG-GUID: gsSdXIJhyM5FoYcdo6rbhSV2r4ZQux6N
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 10:27:43AM -0400, Sevinj Aghayeva wrote:
> On Thu, Mar 31, 2022 at 10:15 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > On Thu, Mar 31, 2022 at 08:26:18AM -0400, Sevinj Aghayeva wrote:
> > > Adhere to Linux kernel coding style.
> > >
> > > Reported by checkpatch:
> > >
> > > WARNING: Comparisons should place the constant on the right side of the test
> > >
> > > Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
> > > ---
> > >
> > > v1 -> v2: Missed one case of constant being placed on the left. Now
> > > checkpath reports no such warnings for this file.
> >
> > You need to send a reply to the original email "Hi, please ignore this
> > one, I spotted another line I want to clean up" so that Greg does not
> > apply it first before reading this one.
> 
> Got it, thanks! Will do so in the future.
> 

No problem, I will handle this one for you.

regards,
dan carpenter

