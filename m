Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B15A538BEE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 09:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244489AbiEaHZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 03:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbiEaHZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 03:25:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EE492D09
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 00:25:50 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24UNv0We032624;
        Tue, 31 May 2022 07:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=X+YZ18uuhNdD9BNc6jCiFvj0BtDe/0JkIzRzaxWQLcw=;
 b=C1HlpY7sYC5JW8avHaEgNEWaegdJEiIMJ31K0tsXfD0iUj9YqDNehJyk6A6DPkix6aMA
 fXy1GxJPkDdOONNBsg8dQH1PVsUno+qZSXEYgPzRg14xS13mjqC277BYUVdw1S6ZB0Cg
 EEwVHiOYWaSHnNi59sVdqKeMaeVUXnPaMmnR/A46zClp8KHcnpzXHyHlCjOsPjiRHfbU
 Vm0rZwjOcgXWJXqey8O4LEc5UvifWZ6PiCkw9enwhp68IGaeH27xArKbNPIDyhpgL+m/
 +CtIhdD8lNyC/O9FT/8nC8c4OJ0pzAiI8MZxpuYCrCzKAuY+owY2JVyos18V6kVEsTZL VQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbcahm985-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 07:25:43 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24V7BVYh014586;
        Tue, 31 May 2022 07:25:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gc8kh04cs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 07:25:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S856WHRr9TSHY92cubBfJWSDYj58/6HL7EYbwCJ43EsINNYMN0jaYrkXVM4v+Z9MhQR89mTONtSSQyZj24qQj6Z88OD99LBM9uZP7J623PaQqhSBqtHvva7xAhXmyN7gWsVPLVr7iFqQNplj8JDfJLHWV8O3VxiTL/UIYjJgeM/MP4r/0aq0/a5ZyoH27Hv/zGbAgQaLrEnx357IlvTWsNF/8mSTkrhxCrA0uhLjLspClhHYR57I7KzVL5bUaLXunClKtq/pePYtnifHotZ7y9SBKSTc3+YkZfICQ7lZgTyCkZpcu5MUdWDG6kB1kk7T4baqbeRinGKLUgYgo02rJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+YZ18uuhNdD9BNc6jCiFvj0BtDe/0JkIzRzaxWQLcw=;
 b=YYgOfYY4k/ZcEo953a84YhEZzE+Aw4Ukj6Be51CD7SHQs1vdYnDSjBZNqNVnlsLB9SLFwOvTolAF1ka87CBna6hpP2tA9MQeHn1pi74cj6kJchUwmNfXKEu3mHl0Oi6ZImvXFG/oqKs0QJt0nFg0yFKRK4GeqY2ufVlFYwFabX3tvYNBmNACwNTMeJJZlHzxBcEuKBbwhDQngLlUdOneEIXRJRiOFQll4xlAaIxOa3pHWFois7o6k9DMH+0S+FJCT3QcjvkDgWCEcQ2hVoYwyiknCvOgWUXSlydOF3z0KkFQjTwCUHt6eK3CRNIY6nZQ+yxVqdJ4IzX3fD+k3xYN4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+YZ18uuhNdD9BNc6jCiFvj0BtDe/0JkIzRzaxWQLcw=;
 b=FTUYqkw+uOGraDZ+f+3Qp5gTEc4rI51jI2bLN5argirrGZtCXwjZ+N58SRp+M1ADB0N541suB447QhlZmwGkMtgs1p94kYINJk6evuanQVph3RcAOuZcbNg44CrmaQxroBjIzWhwKzpcs92HCznkAvrBvR2n7zjGgA+vYPoiO+Q=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR1001MB2293.namprd10.prod.outlook.com
 (2603:10b6:910:44::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Tue, 31 May
 2022 07:25:41 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 07:25:40 +0000
Date:   Tue, 31 May 2022 10:25:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     gregkh@linuxfoundation.org, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] staging: r8188eu: Fix undersized array in
 rtw_xmit.c
Message-ID: <20220531072523.GR2146@kadam>
References: <20220531013103.2175-1-Larry.Finger@lwfinger.net>
 <20220531013103.2175-2-Larry.Finger@lwfinger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531013103.2175-2-Larry.Finger@lwfinger.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0020.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::32)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bfaea5e-9c27-4e3c-6896-08da42d6c41e
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2293:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1001MB2293B4882191FF09361DACE78EDC9@CY4PR1001MB2293.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pL7puhbfNMMUPjt7fiSRSSuqWK9Mcw4ValD6pJ7Lt2dSuBL1bpLnF7cPAPKRVc+WZRNl3z42p5zePAUWi5x2bYCQ5uI3ko2QuI2gB46VFsf56QieaotKPnEmpvtc3xZmCq/Q2sqfu8G80RCnrfInl22DjNcbpErYqWUr/akK5NRHdeVbeXqKU1zFT2r0xfi4KMiw05tozVuvF7PHBLltxhFucq788DV7evnUn+G/j/+pP2eXBJcNUNYwE1K178xGGnotV5Map32v3W3aKf8PbWQTrExdgw7zGJm3JmAKU+MyN31VQ8UzBVj6S7r8NvTdRJeLrlvTSM8cK3urxryzBB/2IywyBz5DREJBLcX18O9VIwmFWGZFs4OiswCeaXzwZPCQVUCwH5XMeUn8sMbueIAAs7nAFvb99JAYTjYWP/g0hUaphafpVQ3enmm2+Cr3MU7YHn0QFNVXP63P3Y/jN5XJjhp8WG5VLilNfuAHhbp2u2EotoEbBW03z7XB0YYGP7c8mVx8razwLexqFXb37GCk5GFqRtHqdCGCrDR+KL70IwbIdLbZTBNZjY/EkiDqw1pThL9uXCUUEzY3qRwKAUhMX7/bJwopd2HSR6dt+LR5KUnahf9zhFiAZi11TomgTdt5WgjnU5DDzuZ1ti8HYicJOUn3scdAKtLl4TfJxG6IYkKAdau/6s/4vxM7GeL5J1l5upBbw0W0xU3MRYVYsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(8936002)(33716001)(86362001)(1076003)(9686003)(26005)(6512007)(508600001)(6486002)(5660300002)(6666004)(38350700002)(33656002)(2906002)(52116002)(186003)(6506007)(558084003)(44832011)(4326008)(66476007)(8676002)(66556008)(66946007)(38100700002)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iTqw2knOtuuBV4I+HNjqeZhX7R0ZiAxbEpK9ZMhCyTI4zus120hgnzyDuhMx?=
 =?us-ascii?Q?wMx8HV/qBiV6aPmfgWSuh6WPOfYWp1uLUT/lNx9hFg8r5XfWmba5J8mZ8zmJ?=
 =?us-ascii?Q?LAtfaqXbObmp44is0RcAmZOsExv5PkknsZ//azSlbZC8FIaVsNJArPc+CfWH?=
 =?us-ascii?Q?pn53lnDjkmfrhpONb67l3cZVBe6rHYpNCDcBAXHNRdk6y/7S4KEhpKLT2E8d?=
 =?us-ascii?Q?VU3Er6S96c8HRIJLs/5e9C2ObZvY5dF+t4AUd6iU6qnw6kodMKIf2QhknoU6?=
 =?us-ascii?Q?9E0P01pCinp2glOYzHciJw1ufeGIKGEnr3v4LmWmD8vfZVg8H0w70kX3DAKZ?=
 =?us-ascii?Q?eExZ9tAb3EPY9TtJTHRcU7sn8lbFhUhFy5NzCEg9lw+0+GW/0+mi3Z0jNSYE?=
 =?us-ascii?Q?BCY92q646ymyUtfR5/VzQul08INKqEYbIQlNVWUqtM2OK8Mbsk4qEyOBK68e?=
 =?us-ascii?Q?EZyHoFQQBM1j4whE4Zf5PtmJ3ZDE9CRqcZPxh5vJhfX2zXnzS0RWaMctkQEO?=
 =?us-ascii?Q?TijR/WL144f5pQ0G7JD1ocANI1foi0kPcd5Jz4dZ4c5l1AQmFFptNQRgWbtb?=
 =?us-ascii?Q?qVz8EjLD/df2uuFOW7TaeccTtjSYqwShHapI2O1YSZNiy2NOU/7Lf4PFfYP0?=
 =?us-ascii?Q?gexP+UTuYqpYK4y2sHXZtMmegHmRgjDz73wsPInwKmnjBp8xDnL11FdfWkk3?=
 =?us-ascii?Q?33CJWBpcReFqT8cT7UH99O3eb/GY8Ehh8qw6D7gvJPEtPiKGsDALCl7pIh9P?=
 =?us-ascii?Q?fpP5VMhC+2sbo3aVvBi63SHUzviEjbMdNXp+I/SMSz9a6S+hj01M25UzBaAa?=
 =?us-ascii?Q?4AGWWzA85n+ukIXpJIgjlGQw+ED7o/KcjEzWJl3u5oi0avA7R4kSDheJcsQl?=
 =?us-ascii?Q?YNEp8AmJmMS1DQ4/DqhulLt0AaZNB0Gx4Nk0XajS7VhXnAOFxHWL+UsYrgCI?=
 =?us-ascii?Q?5xAID0t7h2jxt8s6l5HeBnQfKuzRHqM6ZByCHbUL5LVkMgqjA7Uur8HSx57p?=
 =?us-ascii?Q?saXRY5u050nzeDWnSlX/lVlNLpG/7LL0gigtIhTqv7tUFg4X4/Sp0yvqx5xK?=
 =?us-ascii?Q?1HMHVXD5c8YBxrls4E7HQTbQK2lUSNrgTFh5uvpynSt81bVsowkDR7rsL4R0?=
 =?us-ascii?Q?8JbwCbAYv7rg4zaO64K1CKCFWM6kvTWjDzvQVTbw3M46fZNcSLbjBwNoWdZ0?=
 =?us-ascii?Q?dCOAeMWZ1zxWABtE6JMoANOsaFTLnufA+7+r5A0VsgJcUDU1IRaub+VntUmV?=
 =?us-ascii?Q?LtIH+1mJG8qqf+iUkeieeX4Zc0eo272nq1EyxLOMQEA/qmQK8ddPd5wP86au?=
 =?us-ascii?Q?R5qeufpsiat1g3ie0oy0/JKrwLuJRZMzSEqCYOsTsFqASMDrdgh4ymqRujaQ?=
 =?us-ascii?Q?xKs2JCioFM1f2O4TAuXj0VcgH2QaWJAS+MlY5p9WrtrKzOWiIgYOGSSHX5zG?=
 =?us-ascii?Q?uXXX56VDZyLcMtJ0506voULKvdxdv6crP/et9kyNTDPL0dI8xgKI8BD6jpN8?=
 =?us-ascii?Q?21gO4wGPw3aQGauromj31I/hFv1xG6hFDMxhG6oDO5k9CpgOATkE73yHk/mn?=
 =?us-ascii?Q?FvKehWjjeuEBVcLhZkVyEYgD7VCyaQUrm60QhdgypU6u05lC0G781lmeP8Ib?=
 =?us-ascii?Q?lkoR5kbcseQa8RyfHgIy6aUpAfuIM8Msohx68tzznFgls5Y7ICY0To8vArC1?=
 =?us-ascii?Q?vb8LDRlD82dtlk4SeCidtSkaOGLpCEZuVfwy0jl2mUC7VZF5KjE+Dm0bbull?=
 =?us-ascii?Q?q2Pg9Vo8D5BuGYAxgKDVy0g27RmX2eU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bfaea5e-9c27-4e3c-6896-08da42d6c41e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 07:25:40.8670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dooeCrgBSUkRK+RsYjpHGjMf3RQZx0t6TBSjq8+ZQZh17n1l5SIjRGxQ/bn37uT5QQ4SzUQl2T6v4VcbGTvCD53nRvjc6NdDpPR4UrXJcOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2293
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-05-31_02:2022-05-30,2022-05-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205310037
X-Proofpoint-ORIG-GUID: ncmQYSl3pICADk2UuDoGdJPBzxI2f5x3
X-Proofpoint-GUID: ncmQYSl3pICADk2UuDoGdJPBzxI2f5x3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 08:31:02PM -0500, Larry Finger wrote:
> --
> v2 - get proper To and Cc
> v3 - Use Dan Carpenter's suggestion for correct fix

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

