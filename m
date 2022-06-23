Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6898F5577C0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiFWKX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiFWKXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:23:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D732BB0E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 03:23:19 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25N6g0vx009481;
        Thu, 23 Jun 2022 10:23:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=q2xPT9aYNv3n8ZfbCyQkPK3lG0v/KfOw17OG2y43ouA=;
 b=ogFjMWkgSgfJ5U2G3Ic3PdulQz1HuEa+/oSvr6TRLQePXV3hdxfSfujPnGM+/yBmVtJu
 hfo9spOKYMA0jOXwO5sQOVggo/3wtp7x3x+zTvbBgFzJGQOLCw9hI/vulVU1stK2DdEc
 /fW9DXLOhLWvSF4x67VJ6E3xtCeVuWAsaBxLD1/zy8qF9vgpXJtmXce9VRZjcvG8EK6O
 HxF9x648hHwkQ10ei7ylPsBPMJjPURW+IUZfwu3R0D5P4GFH/pMvrXpLN63dNPpREiWv
 zWnYkbDKfyKvqhqrYFsZCiCSNMNUTuRfYnBW2e0g8M4IGEjOnQMjAwIg46+QfcC2W3bc 1g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5g22uqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jun 2022 10:23:13 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25NAGvOM014412;
        Thu, 23 Jun 2022 10:23:12 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtf5egyuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jun 2022 10:23:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtQ2XYYidpJTLAd05SrqrOz+PeQxyjOeJMN6cnlGvDWyIYYX14Xvyt3ZJtfSi93lzxi4u81PzXMOXGqVMQ5CxbdCsw/0Nf7nptLOMA8LCTYG2Dnp1v8cH3VTkY0SzdH8c8zTqOmEelxN+tpuwD+fs+DgFE+3cC7+pLdRz77n1Nb2TnoFtrO1A2zBqvwZmflwGu/n3X84rgEKIzePgt+BpYxVgsvISVhoJgyJi4+IlEwhJhVVSkS6SEHnO23c9UuzE+571KzedBW3xt+DjakU8j1sRbjKEklVCGNNh3Bd9dWgXBnVxs/IgYKJuD1dIXPQzgkZlohFKgpvbE7Cu0dDyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2xPT9aYNv3n8ZfbCyQkPK3lG0v/KfOw17OG2y43ouA=;
 b=lIhk7uBxMCrpbfpFu51V+2PT/+UgCu344ND/2weRwrjVFI+0JzLXZzekzATd+JeO+5tKbgAhqQ+/a+MYiDbmN4BUswekbjRYntBdwsM+XbOI6WlCSr5k7qMZa0YZDTxXWfQntk6iw3n1kJF6Zr3Q2GMZsB1gF1li4OSjeJcReZ17418RjiCWteqRtJ5xYiY2rAJ8G7j1nW3BeWsihX790FMmCzUdqcG+t/kMcifmH1xcuTll7alsIwpJ1ubu59h6BnCQJA4mCognO9PblxKO8UYrbhJED5AO+7ndd4Tto5mJ/pCsK/MmBZFTf0sxay5beb2pqpTjGS0LgLey0WsSCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2xPT9aYNv3n8ZfbCyQkPK3lG0v/KfOw17OG2y43ouA=;
 b=QGQEQMGZRtwi5sVvmepJWZq4uBbKgnfsagwJ7gC1Yxt7gzHFDcQw4U/fRi35YYVI8H+VggX/iTQTtM0v6HN+/Yi0wxLbFR/jbyEOqQutBpzH6Z7054m8l+rTQ18TcCM3wG4rlX91MyBqsS1IRpGTsqT6GOzK4DAsyfgwP1wwC7Y=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH0PR10MB5228.namprd10.prod.outlook.com
 (2603:10b6:610:db::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 23 Jun
 2022 10:23:10 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5373.015; Thu, 23 Jun 2022
 10:23:09 +0000
Date:   Thu, 23 Jun 2022 13:22:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Felix Schlepper <f3sch.git@outlook.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Staging: rtl8192e: Safer allocation and cleaner
 error handling
Message-ID: <20220623102252.GR16517@kadam>
References: <AM9P190MB1299A41E3A9B2F9C0916A260A5B59@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9P190MB1299A41E3A9B2F9C0916A260A5B59@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0071.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::22)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03c6afe5-6f46-45d2-b747-08da55025eaf
X-MS-TrafficTypeDiagnostic: CH0PR10MB5228:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB522862A5BFDA65443947BAFD8EB59@CH0PR10MB5228.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LEOspOEfy2uW7Rem813Pv0EQX6wIKQNjAMOOingogO8pXQ8V8d5ELbxa6bkOV2MDPkLZrS2ZsbpGttlIKcEgMLXz+uKpMSFVxopL/hp4zBzR0zdoSwa6HRRDjG0tQ+qsUbVKxpJXGoCRBxs8sq3mqT4QVrHY36lNWxHy2iZPc9a8/4b0I9xesWeM1V3TNJjpJBoVUGXtt22G6kdg6DvjYgRNkcNRxypV+3d12xhrd2uophFZgKQWC1oKbHaT2vMw1+iW24pTvRj+gIZyeP7jZNvzH9B6rMWPkYPPEa3e8qA05nmt/8HWa2OtWLEW8EwoOqoD04zfEGxqgLN7Dorl6U3081PhC+KFfUeQW+5zU1ZJIVkAI/NT+gcWXY3MxvxAP/QNTUJDBvBvuMI7NFFKhlbdV/Aa4hua3ytKpwaiR9SDQS0eBnnI9J4N78uN/tYXF9iikG42tfu0xf/AfOWpy6AYzbxXKfD0K9WIJ4bXvLtHcJckgO/fS8A5XdCgHiA/fUzqk0TblO9pmP2rf73oyj7n61XIqZpb5ytp2OHwAwF67+JrSWuVqGWNra+frauhrZf6K47NeeUphwO2pGF147VGz6tyYd+3u4GpiPuSkfm2X/MRKNZVdTip4hFGCJvRnFOkHX/XWzvmBF8X8C2IoCYPQM0Tgf1/uOtGjiNXubnt5Obmtu8H+ChiGQPAzxj/PYCNUoT9EXVJa63DBUnIXUGzSIcDKI8rdoEjPi4TUHlCpoP3Fd0yzQq26x70B2BU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(39860400002)(366004)(136003)(346002)(376002)(33716001)(4270600006)(186003)(26005)(1076003)(9686003)(66556008)(558084003)(33656002)(41300700001)(6512007)(66946007)(6506007)(2906002)(6666004)(38100700002)(52116002)(44832011)(86362001)(6916009)(6486002)(8936002)(8676002)(38350700002)(4326008)(316002)(5660300002)(478600001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tjdna2gumW+8D/JzEfrDKss234rtt/QUa5wCxKbIIXnTo8Kh3PQfv2AtBpWn?=
 =?us-ascii?Q?Qi/xxWY3iVbu589b5TS6fv9svse/kA6p6o83SiwlVZzIuwX2+3nNjmTpNoA4?=
 =?us-ascii?Q?iXcIVeXDpoJCLyWdgNslAqIcVScJXU+jsKtKyc/x8oGmupAZoxRoPRAtMN86?=
 =?us-ascii?Q?wEMDbZDHQyfqhz3d1TT84QDXL2kR/n6JW8LJhj+28M+LFHFwu/rw3K02SxNM?=
 =?us-ascii?Q?Td/p0XpiZRsbK50UP5Cmk0I2MedRioJGMUUa5mZYq0w7cWmq0cpNdU6f6QEJ?=
 =?us-ascii?Q?aU8WuINXBeJFuUglpy/87gXhaeO7pjWsSPIBvs6SIRqTtm2ogtqhuk4SmgPI?=
 =?us-ascii?Q?ZZne6dxwOb2eITrVfVc6ktQypS2PpxxdWj6n2XM6vDmb+es9XP+k0emTuKF2?=
 =?us-ascii?Q?OPkwm5crqIyFG/0bQvReAs/5qFRXf/dfI9o7KSMj7Ud1M08V70V08ZIj4YtM?=
 =?us-ascii?Q?57VOYy1tC8U4iSa8qDzcrDXahIly7TlEaZtZqFolx4h1QneRB12A04i4GfHZ?=
 =?us-ascii?Q?4+x2nk/TXIECTRVCr85DTLDOnm1I7qXXpMHjXkFLTwp07twRXZHASmPLI9Sb?=
 =?us-ascii?Q?ntHgwp4W/OhT+xschz5OdsIbBak9BRvKdpYQoaDiQWlrA74It+DlZ0ZJRS/R?=
 =?us-ascii?Q?BLe4ey2Yn8vknibtEJB0rGfEC9wcjyA8WrT+cuUbcp41ZDgKBJVUWeX5/M0c?=
 =?us-ascii?Q?tl4sPWhKIAvHSn0fyXazOnIStkdaZTpbEIX5N0TzLBzwcXddieQ4mrz+bpze?=
 =?us-ascii?Q?L1kqAAlx+MtQlVGCXoRYmvaCkIk97QQAkbPj50aVeNF2DMMpb73ef7CpKyTB?=
 =?us-ascii?Q?ryBLxx3X9B/farc4/+lS5mKYMYzI/NOw0C4t4IcJVwYKtxzjwM43RiChkNtx?=
 =?us-ascii?Q?jJTvnrF7qdliHhS3rKhtLJTgNHdLA4BCsmZC1kAFsMtkIi+6+lmtFyBmq2vM?=
 =?us-ascii?Q?LS7P36Kf4jEiS82LxbEYGVDMsWVOwm4iBIyJcTknfkUSjxPc6W4vT34bj/Bh?=
 =?us-ascii?Q?v7x5mvO5fN8O5fSM40zzSj3OxlbJ1Fc7dy3d+sfjbDL+5+cu91ukhZ3tH8OA?=
 =?us-ascii?Q?MHAfbrTJquLmL9s5NLf2LMvarNlnmcc2Q+0KXpQTTPdxJgGXeNPpPH5YYcq2?=
 =?us-ascii?Q?xl/h4/H/Ho6WTgO+kr8srFLvdMioJeyHwieSsEJ7FplK/z/baN9cEmGI7oGp?=
 =?us-ascii?Q?CeJ/utvRw7yeNtPW4STce7G205FznpjNx78I7LaE/LSwh4NO2Yjl7gj/0/Q2?=
 =?us-ascii?Q?8xb80VvwdJgzfqJ+j/1naBXo34jmpAOX1bUZIDku4ZEQz21iPSCJ5uJ5lFAw?=
 =?us-ascii?Q?hY7viKkKk42pgi4KoQlRjvWOgLucCKARXHRYZIKK3ykbCnKMoAT9w/wlL5N0?=
 =?us-ascii?Q?3+O+EbNUunAYcpyL3iS6giAy/XVUYApEfenBOkmo3g39QSxlVFmNiRucTw5E?=
 =?us-ascii?Q?I4pfBkZeW2Fe+yQclMvu82i5uX6CCAQg8MyX8t5UKpvtlMc9a1jLJo6j5kcW?=
 =?us-ascii?Q?5HTGTFPqDV4c0CL8/2XVwIeli93tL3amj3nZjBViHexobWtD/tPJa0T44SKQ?=
 =?us-ascii?Q?/ScJ2alH2rGV72Pss/eIoMZ8xI0RICpOzlkwsxqVoFudSVS6ChUpw2WhgxPu?=
 =?us-ascii?Q?Ng=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c6afe5-6f46-45d2-b747-08da55025eaf
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 10:23:09.6653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sg+Bz0m5kEe8KX+ZB+U60Loltxgk1YbPX+iRKeHdcywDCximlP4ihRN4zsQItBDk8z1X7Apf+yWsHM/Org6Ceufn/56Y19JaAlD2vwodOjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5228
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-23_05:2022-06-23,2022-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206230042
X-Proofpoint-GUID: 6BJ5TuLvjk8EZjJcbN086tCLeNZdZht6
X-Proofpoint-ORIG-GUID: 6BJ5TuLvjk8EZjJcbN086tCLeNZdZht6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

