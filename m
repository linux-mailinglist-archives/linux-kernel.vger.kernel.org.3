Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CC352AFDC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 03:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbiERBUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 21:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbiERBUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 21:20:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDECC59;
        Tue, 17 May 2022 18:20:42 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HKiIbi031641;
        Wed, 18 May 2022 01:20:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=kX8U7Q3ytZTeKlRplHYtmVL+rCh9WoYqeRzjDgU829o=;
 b=rdCcDxx+76AiWkIkpDnoV6VUy+WzuNtL19ePutnHr/1kYvwq1mLyLwg70OHP4nO/kcec
 IFKguBE8aMa9UJ7e7n85wadFd9/LuC37HU5iB8p24QI8p+DqQxh1TbDU/Z4xxpDi7r0a
 Ak2+QYcXc6Igu5OPrKgkoLmThiTbWm6DPxiwCtbBf8KUi4/uqP8ZwHXSdJ1OrviKkpur
 VTX5bPqd38KS2t4NfL/DlGdD8ZsS1DgsqI3/qUZe8ZqgGm9CVRSTQTF9AFCmmUftUXd0
 RCZ6Kf/JpPHDUaltU70qWqkSEZRLDOrlE8QtJmiMMbFDoWKzt2uosLnsDs3z866n9Tgw JA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24aafs9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 01:20:31 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24I1B1Zb033830;
        Wed, 18 May 2022 01:20:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v3qcyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 01:20:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Km/QbUs8kTRO/IzSJBlVEQzlj5TR6KNvDcQQ4GoIsk+iWfroBZljmFRNmYbrsLcoodQZyjk4u/tMTFJc6dSXZdnNTPaywjRKKWc7N36aczFoiVNkU13PP39j782cx2FgpFiDH82SJnEFf+0LrVM3psOyqxW/XdEKbZgl85/gz4/JOFcy6W2DlVU5FdnUrm5nbiiED1BalreD8h+UG3ZIpV2ROwV5sy/9V6Cj6MjJUftbtYYKn0xA6CIOqNfKSmaVpcbgqbDBAOq6Ae/CrAYpxyS/cUqM4rKfc0TZwupVGl718Ru3qDcBZlKvC7UrHtu5Ey4htfq3Atl6c3kKseS1Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kX8U7Q3ytZTeKlRplHYtmVL+rCh9WoYqeRzjDgU829o=;
 b=S2Sh1Yn1WlmqeoR3bkKzifnmJagRKCuMRmgek4oN3RFEjqyQtr56/Ixjs6h/rbYfkMmkyILdvlmpEkTzx74qclNrBHydmhh5OUUrzf/qazUuXfM6FX08mhrJsXmW9hIyq4Hn9MV8B4hbLtbtWFfsVx36kdZmMY+8lsLLG2MoId+F6zduNkz5CN6gGVEsoRS6QTsQAvvaehdMaoNemrkVNWknIftwYAcXVYG2FrLiwQmQ7SUeBmVtMj4QtMnZU2hu6tPxmy1/FL0363swtuNB3HxZrfXRAytd4PFfCTx4nah2mLDmNyJg+oDsljeoZYdebjGHg6WtWum0tUAj3BV75w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kX8U7Q3ytZTeKlRplHYtmVL+rCh9WoYqeRzjDgU829o=;
 b=tJ9N/HiBBPmjoh6heKbOxqq8zYKO+WW0F+xNgT/WeTi14MU8fmCD3GtnHcntiCXzlSxNrf//0MOtGqS+2vgHjkHDmI4oTEta/YNbkxbVpqArG8XoZ4OWiAqYmrhZmtf57tP0KVrnZ2eEMcIWWTErlv2UQoJyED+Mlhwxgx1M4LY=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB6203.namprd10.prod.outlook.com (2603:10b6:510:1f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 01:20:28 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192%9]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 01:20:28 +0000
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Saurav Kashyap <skashyap@marvell.com>,
        Javed Hasan <jhasan@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: qedf: remove redundant variable op
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1wnejmyb1.fsf@ca-mkp.ca.oracle.com>
References: <20220517092518.93159-1-colin.i.king@gmail.com>
Date:   Tue, 17 May 2022 21:20:26 -0400
In-Reply-To: <20220517092518.93159-1-colin.i.king@gmail.com> (Colin Ian King's
        message of "Tue, 17 May 2022 10:25:18 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0170.namprd03.prod.outlook.com
 (2603:10b6:a03:338::25) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc8d1d34-a8d3-454a-5158-08da386c980d
X-MS-TrafficTypeDiagnostic: PH7PR10MB6203:EE_
X-Microsoft-Antispam-PRVS: <PH7PR10MB620328C12E3C6CF249B89EE68ED19@PH7PR10MB6203.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T1hyMNUFqBGwX6CEdGDPfe+DqzN5V29mDyoEYGoy/fu5djKAJ6eNkS/MUKIi+q7Zrk2Bz27aGNc+MTbI0elw0sctA0GmTqz6d3u4TBSNcdFjR+NwmZTM66+uVKlLf9lpwODgow6fUSqTjDVc5XkWW6RjuvOofXeM4LMDuNJhphLPpz1E8aAQyt5c6v9KSHlis3Hb0hq2fErhxTnoicmjEt9ZBg4y44gr0GV1np9HSyxJqTtKqAmpja35Ya02uQiV8hRg11wo8Jzz2ugvHDg+EfD25LrIpBosDo2LP9b6IOF9q/oNAzVQAc4bPc7N+gB+lmoei2DXnBoe9F1d0uZ5SHqCyhIZgQbeTCZeCKUJJ2AM2i3voOvjmV5tC2AwLBYX3xGw2TNo6FFMHcANkGiDNCYtaKf0jF3MqjP8gsP/JmGj5SuvoVhikrT6ArF0M6mBN509DEIjBYbgAqThjcmu2YL6+cOH/V6+p3fnDY0Sp7yqbBhVK/Yeic2OP2tnS8aJnpym7OLjvWlvk4q6dpXuofUlEr5FzofWKl4Xv8xCrdXnt1yVqthnFrvNLfdLwsI59z7GH0as+GN5X9gOu8ZG0k2t2NisWpBMyDYSypdYuI+463RyGTKF1qiI7cGCvE49Rq25bqkMG4UlGGHIQfUJzeYA4iDRPYcmqkdg+z6QzowbGm4Cut8AFZUI6N5hFUMpp3h2U93HgkoTpwA92GFVVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(36916002)(6486002)(52116002)(66476007)(6506007)(8936002)(5660300002)(38100700002)(26005)(2906002)(6512007)(54906003)(6916009)(8676002)(316002)(558084003)(66946007)(86362001)(66556008)(186003)(4326008)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?quuqkgVWMpPGIwXd5HGqzW6vApwilIIu5AzrAJRMRxEAxj4IMDmX8lVWHsUE?=
 =?us-ascii?Q?aJytcCm0vIv9Wc6eZYspzoQObImr/iHmrGQVYJspZcOkBzz2mOMry8apmVWS?=
 =?us-ascii?Q?jm1KBfPl64eSryfNP+7reGXjxpXn3udY9mW6RfDEyJht29mml3Gqp+c91m6H?=
 =?us-ascii?Q?+5+2idGr4G1k3pTQRQIw0wggUqPg6KJvQUUFZbg3HZJw19dE4XUESoKqnUbT?=
 =?us-ascii?Q?Cgnc+/AonngnBtKK9z/OOBjWeBKgwBNIj6ptbn76JsUrF0bBHf5YC99B5H45?=
 =?us-ascii?Q?71dvZBanUFz/dJm/JTgItE2uUj+C+lYM4hEuUSxO7KR+ivpbJNwVTOOBecHC?=
 =?us-ascii?Q?AkTHtybOYE3FIADHZsGESNc/O0YqXE46HzA1i+gRoXD4MvGNjX2d+k823JWj?=
 =?us-ascii?Q?S7QR4qAxwXQs27oa8BrSvpkOsyGFhbQp5yUjojNdrhbVjh5bcEmTE2l+D0C8?=
 =?us-ascii?Q?CsgS0J1ti/blTAuVLUogVqDhzN3mveLNf6Vxlo+QRZrYFmlGYBOXBXw2nxGC?=
 =?us-ascii?Q?B8mc/nKHM8dsngUiT6S4JgghcoRSEVm3xJpAs/+3i+eYLfGVGiMgGoNqQc9Y?=
 =?us-ascii?Q?ChIQiVG7KQ02kaFg9Zp+9BFtL4iPnALQky4Fregad69j6H21Zf9j41xi/MPB?=
 =?us-ascii?Q?MoHtNQQGP51QoxpkFKAB5PcX0HsOqj+yr2Sg8l2/leWmDEieACqbBOXgF+yS?=
 =?us-ascii?Q?fmAYCRCUFkMgWSUmfds0vzICOwRJTR7hY003+iYJhdk8otD0tafrrt6YOQhC?=
 =?us-ascii?Q?4ozCewdWP9k7NI1R3lkaowZ8BODRKpzVgwStVBlg4Tj1Fgc20mZqradcau46?=
 =?us-ascii?Q?5J+1TxjQrdIXTBmC6J7ZLSePbO4Up1lA3eL3z2SECcYGJUWFIVcNUDiX+v/N?=
 =?us-ascii?Q?e/wZ61QqsqAYGMF7bfajYTwCVxf+CDUM/V38JmS4qOKzHimmjmx4xBzBZE1s?=
 =?us-ascii?Q?pu+WgOEYFJ7Foszz9vBgHzklrlqed/9GLOtiLkeZ9sb5FEaJJHeJX3LuKZGF?=
 =?us-ascii?Q?uv0FBMz9SHErO83CWO6zdOcqMZyfrS3Gki7fWshSGk96XRhqFKyPmw1ndqwz?=
 =?us-ascii?Q?WQr/G+MhOkgY3uC0m7EtBr/Rq6mf/znsccNQpRKJcyg9TpxehloT47nPBWwy?=
 =?us-ascii?Q?iPT9D4nIKhx4X9I+BLeUIxsUQpl8O5HZc74g86fwzW0tKcVlu70ZwURwW+5m?=
 =?us-ascii?Q?4jhJyFyIo/Tz/gYxg7eiqAY85f6Z8gU3p5sGerer3tQ1tbhQWVouwe413Ale?=
 =?us-ascii?Q?2xl3D0JirWLvBVyhE/Teh4kUG0cyVQnTVtZnpZO9WVmU/dg2CSmn5CO7UZdk?=
 =?us-ascii?Q?upfrPVjSDbhPCokfoq3KdEm6fg2YgUCelrSQ+u76irbnvKdq9+6ayB2FR+38?=
 =?us-ascii?Q?uSEjm1xMac4b9pG1a5QYW0rpagFtUo2KvTL3h9igZBv8gQYXq7UQNYOa+TDU?=
 =?us-ascii?Q?Q07s92AGUwc0OO5wM8UxCH7c4AgGJ41Gycz1DFPTgE36y6eqEGzleyv6IHA0?=
 =?us-ascii?Q?gB+z0mivdwX9/4GtGZYbxIHp9gsAaKzILyUC0W4PuAELIUb5Ms2yvm6XZ6Kx?=
 =?us-ascii?Q?ku0ELY2c6SromzLpDL8xLmgR0YE/RmRcD1gSjlUt/JDILasNZfwe6PQfX7eb?=
 =?us-ascii?Q?1GK3m4tPH0nhnA3NDKpo2hIgmC2pHLZSnx8ODmzrEt6V++nQQfc6Pym/gJRm?=
 =?us-ascii?Q?t5eQ6p58ODcpfqD85bAbXRBp5XNvsvYXMoQkxxwpkFng8SKGYwLagGJN2HhJ?=
 =?us-ascii?Q?PwCyD15nFBmSqtWu7WCfFnvW1ck8bhI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc8d1d34-a8d3-454a-5158-08da386c980d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 01:20:28.6229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iaE6F/H0JOq9nV4pSxzH3g2dy6pX2p7GTEytLSLMJTj8cV2Y5CKpaWgt/fflL8feOSqf2oMmcqBh9R4KAh7dqUZa+QkX0OdCDi0BM1Zwl4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6203
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-17_03:2022-05-17,2022-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=735 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205180006
X-Proofpoint-ORIG-GUID: G2qdhpFaO4pPkHyAYYIwNaujrn_3sZYD
X-Proofpoint-GUID: G2qdhpFaO4pPkHyAYYIwNaujrn_3sZYD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> The variable op is assigned a value and is never read. The variable
> is not used and is redundant, remove it.

Applied to 5.19/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
