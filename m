Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1171E59CEF2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 05:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239299AbiHWDBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 23:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239482AbiHWDAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 23:00:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA17E5A834;
        Mon, 22 Aug 2022 20:00:29 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MNxDQ8012127;
        Tue, 23 Aug 2022 02:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=G6QoP39N9AU163l8+TbSQIhaYItMK38g6W1guDgoOR8=;
 b=J641maHPjNLN05seURnVXrz7yp85m2adVKEUDhZJw9vfP3zK+3b8+6QckqpoRX62lngR
 uRQ4QibenXGmBdgk+XbZtWjcUIpDPGZXkJJyrMRQNmOwB5tRb4E3y3jJ7y9wBkH3U+0o
 8aHhsY+Y3TfUXJyuTKOxTJrv0JdblJ0lgxZOjQzxbiMmPgLA/tkXthsBdZj6h4EnBoZ9
 GXtcWPTFeNKp5JlSx9NAhyBGFP7UoN7FvdwtWpL1JqO1xmCScmJPtxhQAiAW+HdsHdc4
 lbyxIuTZhC+wlsvSwFJNKYbSWi9NUlhl3n52LtULeIACfbdEN5BV+JechwmAh85hoVXc kQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4e8crxxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Aug 2022 02:59:48 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27N16YJY037826;
        Tue, 23 Aug 2022 02:59:47 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mkgncnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Aug 2022 02:59:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+XVi06j8mloulHuzOUet+Od7vRUFTBbCFal6PIPBuzVE5MV8g0niwrQA/d16wd7Xy88MpeXLO4SL5e6jT7atnnY11hH3gTf3Dc9RP3wVS/qKU3hsIWHrVX5fT5n1S0IaTPHndP5jlGJWrUiEfClxigUD5USE9NhUKSXbonex5JDH64QxdkQOdXdPmXpXF9ZU0/8GsYsh8EBCDigEnNLXlObV+sYbVtMKwi/Ly8DsZHG0usBIjqfzJABrEkUttaweOlrvajumjQq2dnZ/ghhUNJY99xHc4o6Y6XqVmncvJP9wWnn6M1V+YV+GGKuKGGZcupkL8pmx5tTHzGZQHoYVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6QoP39N9AU163l8+TbSQIhaYItMK38g6W1guDgoOR8=;
 b=iE0fpnXo3NbBrobsa66MxDP+ngXRaYIti1BMoxYfuCDtSw3AsmR0f6QbuPp/dq13PmoSYTlDmkjtLDGJpA6hYWTJLODXe1L0FU8sybDKUyio15EFKthQk32JaUGOq77Kjw6ScrrfhRJZIv07tY0tEAZn4uai7vP9XQbqVlFpZTXc8BQSSc5o1L3uS/hYNKCYMsUH32ImQutZDkUZCKR1DW85ZG+6G572shIYB537Znm5KEsy1IvqwbOvLa034DtmvvKxxt28tOSDI4lbZsf6hMsbSk03tpqFCfBxyq6AbktYu3uVKutSYAsiqE5Rk8n7BZDEL6ILWDc5CmeYCQUagw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6QoP39N9AU163l8+TbSQIhaYItMK38g6W1guDgoOR8=;
 b=VWsT7QI6pVgcv0/YR/L/WXDxY8BanFgZijMLp3y4uB7ccBpOkyGtOcJzUWqyIVHd732+Co9+6IwaC4uakb3uEiH8VnK3Sc9kNEN/hV2xc5nEIP+i8imECMl3Bf+asxjoZmKHOK+X0koxfQdhT4xskAytURvqno+te6+hcyAg6k8=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM5PR10MB1372.namprd10.prod.outlook.com (2603:10b6:3:10::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.18; Tue, 23 Aug 2022 02:59:44 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::89a7:ad8f:3077:f3c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::89a7:ad8f:3077:f3c0%8]) with mapi id 15.20.5546.023; Tue, 23 Aug 2022
 02:59:44 +0000
To:     Stanley Chu <stanley.chu@mediatek.com>
Cc:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <martin.petersen@oracle.com>, <avri.altman@wdc.com>,
        <alim.akhtar@samsung.com>, <jejb@linux.ibm.com>,
        <bvanassche@acm.org>, <peter.wang@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <alice.chao@mediatek.com>,
        <powen.kao@mediatek.com>, <mason.zhang@mediatek.com>,
        <qilin.tan@mediatek.com>, <lin.gui@mediatek.com>,
        <eddie.huang@mediatek.com>, <tun-yu.yu@mediatek.com>,
        <cc.chou@mediatek.com>, <chaotian.jing@mediatek.com>,
        <jiajie.hao@mediatek.com>
Subject: Re: [PATCH v5 0/5] scsi: ufs-mediatek: Provide features and fixes
 in MediaTek platforms
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq15yijbr72.fsf@ca-mkp.ca.oracle.com>
References: <20220802235437.4547-1-stanley.chu@mediatek.com>
Date:   Mon, 22 Aug 2022 22:59:41 -0400
In-Reply-To: <20220802235437.4547-1-stanley.chu@mediatek.com> (Stanley Chu's
        message of "Wed, 3 Aug 2022 07:54:32 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0130.namprd05.prod.outlook.com
 (2603:10b6:803:42::47) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f41a037-b260-4c4f-ec1c-08da84b3883a
X-MS-TrafficTypeDiagnostic: DM5PR10MB1372:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gowL9FS0RRXWVkWI41BjmkHF34cqhXOtoAf8fCxn6NL4JU6yr+8g1+asa0DU14qwdwCFdTSqYdQkmQQtmtNNygU45WwEo818QJqQ0h6BQQWlsEBtb6GYA0bn1BVNdK8+Ht7GWrsk482dof4XeEJR6Rdg+c/UaJzQ/PaY2g7s8vqZpnJ48BKyggrRZZeGkBp+x/3mwSBJSF2A582VhGKug+YhtfQrmevwQSn59ZFy5gnb5kDgmb6v8GMZLEitUUdeFbyHBmGM9DGeF+zIa67WlBeAP+eOn+WZvkplzB/OeT7xKFjYOS5EP2jbQMnEcQlGCB7ysy9B8Pto4WrRm35wEhPNF5y8TikvwQYka/4aFWwxI0Zr15hIHHLvp40hzLXOGiFZ/6Ao+UsaZ7cyxRq6Gi2mfLjfGqCfvbKa3bpkXoJr3d+FpR9YJ3ldVJgqrWRUhVLE8fDVwUvTcZ5XQXQBZWTYBScV6xaXu0qpYfH7/6MC7fqM5BW1uQhdkQMGCMck5VNT3/2+MGF8gGEkGCUZHQhcQRuKeTSjsc+XXhllfmvq3byr/JIR8k4hFJiCc+NP54WkcSTlj2jBIRgEY1WMDlXNGUDyfTL0SBCa3YUxOVCqc29bZ40gLqqhNtdykrUIFMcqKYy6H+CVKDntuA7qp9UZgAfOpf5l1xtDVPC45BmR0eaArQoi31KvV/sIkvYVS+5dKLsSqeP1Hm5MYE50xG4rmYK3aY7OYwaDV9GHFjPBfiTgFJFZm2kNJCM7v4NDau3FkPhv5h+0+JlANxbYAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(396003)(376002)(346002)(136003)(36916002)(6506007)(6666004)(6486002)(478600001)(41300700001)(52116002)(186003)(6512007)(26005)(2906002)(8936002)(7416002)(5660300002)(316002)(54906003)(6916009)(66556008)(4326008)(8676002)(66946007)(558084003)(38350700002)(38100700002)(86362001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wIsY6S1LZjo1w1ymDDqNuzcZKW/5ALnIKUWRnEdJlD4v5DNA6n97w2+DCrr3?=
 =?us-ascii?Q?Po88ZltcVvC4kAfK+7ha+5iwie/Nsxy/3KqN7OGc9xrC6ma/4IommaiMUyd3?=
 =?us-ascii?Q?8qYOUtB3pfDMCA7yGE/F+9DMuCWRT8F+xxgQVamBAVvQLMBNHfc748a1eLEt?=
 =?us-ascii?Q?h7sVtWm0KqzsXh1NoFJ6wlPCubd2rpFRouGn37uCsoawuJCLMsIcm2RJaBZf?=
 =?us-ascii?Q?bFAkuqIBcsJDqinUOTYRbFiMamFzoMgHvF5/NG+M4YkTlG6ZRuvFqDNtHibr?=
 =?us-ascii?Q?+E18T26uLCySU/Zdhe0AnTV5ZtLzio+v4RnldXj8A1kS4BCCdsronuExIFmB?=
 =?us-ascii?Q?IeH7b71975FxAXQMZbYeTyXY0VCn4oC9sOe/dWTTflBGXeEfsqIrPhyH2B9P?=
 =?us-ascii?Q?kEg//HCjtUZ7OA6rBKxg25NIakosOARLMjVTL/QvbDHcs1KUD9TuCyBx+J7k?=
 =?us-ascii?Q?+MXkRCh9vAcI5l5Y1fSFws5tkoEl+8EasYbm0po06tAJBNODvy1v2uawqYCU?=
 =?us-ascii?Q?hYXPAPhCbbzXzuOMLR6oLqGS8I7t/OD7bNl5RWHQiBzR4Jx8Ggkt3tv1gM8c?=
 =?us-ascii?Q?qtqhbIsFsF6k/yyXXJw2p0lA8WWZWZU94UNp9VAIr/2TivftbpWt5/iU5E+O?=
 =?us-ascii?Q?RuiRaKqZ922MJAviLrE0edYLcWAsPE2AfUydYZHqWBjp01mnsL6X0k2lZwMT?=
 =?us-ascii?Q?cw22xr6nRGmLXHX86tRWQTeYlyLSSuIMutv+4SqdK3Dd61ft3A9uWSA9xj0p?=
 =?us-ascii?Q?z2fDFXRtS8vtGzVRrb0uFZ25G9roLoM40igj6fyh1RdJQ7m7VgF+sTVNEB+e?=
 =?us-ascii?Q?u5Bj5hlyotAaFIFljHoxsHURjg18nB7IuF+rIR43Qngi+GYii5IY1WyLKstF?=
 =?us-ascii?Q?RS5OVtrEq7MJ9uBfjTZdpltp5qsYzE0SxE61SlF8mcLGjtIDYkkh5dBZZiVH?=
 =?us-ascii?Q?HLIdrRzWhvZ1XWyO1L+g70JodPMcZMo/ajuYRX645Y9sHLGEp0H7T+E7NOL4?=
 =?us-ascii?Q?ScGSxAmtNcZAyvTU/0QYfzM/92S/FhyoM8D7zUudJYqd3Q7+Xx5NlM9G5eQb?=
 =?us-ascii?Q?QNMr8Kt8B9q8AcqiFGXb0YN41ltyHE9N4GQJSRbGemtEoZ1dfQ9wi2nBr36z?=
 =?us-ascii?Q?WkjwC7zawfO6+l9WI6a3kMJmNw0SpRNW1Vo8nDsQ7xZFxznDOVDE5dkQRpk4?=
 =?us-ascii?Q?NNAn5qIUo4QUvj/MN2YSCAl0/fZgAWOPxA0WZOgeXomNgd/aDiid9Q8fjLIh?=
 =?us-ascii?Q?jEjvJKZbjrgzrQPQ7erudsRWIpuXqeqdBd3lommjuGeyN+WZ/1WlvpErR99d?=
 =?us-ascii?Q?OQ9Etw0jiPYzBJ0b51nhLJHB0RFZv7W/uDWPmPSLJeTWuS7KA0wD9xn53bPH?=
 =?us-ascii?Q?nuk+GBktcSecW8NsBvfuaVyK+x4EzgUbOw1g5qOr+xf6HUos6WQxCjS91ikK?=
 =?us-ascii?Q?hkoNhY0NaDJu2dJ8+kNW1NdWOCe28jyhhFiCYpZIYmvvCgNogxnwufxjiLwn?=
 =?us-ascii?Q?gIr3+2E/xgFzk0L7MsqDTaO7KF7SkH0Drb6B1KGErrdhf3YtINsRUcy4HWX5?=
 =?us-ascii?Q?DRo/rjtjXMheJK9H3ZQ07chQ9K6sIpby1xLnCGY1I+97XlvUD5oplXQuFs/r?=
 =?us-ascii?Q?6Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f41a037-b260-4c4f-ec1c-08da84b3883a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 02:59:44.7796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: toPGfAOw/2uI8snFgTSeGs2Urws+OD0BT0dInjZKVne+0U5dkDMf6EB6cz6D4Xz+3zS67Xg/eXwRZPy6wksJ4et5Y14Alwr4qt+v98YegNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1372
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_16,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=767 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208230010
X-Proofpoint-GUID: swMvlV4-mau6dcEBMTB0Ir6H_0veb2fX
X-Proofpoint-ORIG-GUID: swMvlV4-mau6dcEBMTB0Ir6H_0veb2fX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Stanley,

> This series provides some features and fixes in MediaTek UFS
> platforms.

Applied to 6.1/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
