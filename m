Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB8F50FD38
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350043AbiDZMmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 08:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350022AbiDZMly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:41:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649B916069E;
        Tue, 26 Apr 2022 05:38:45 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QAG8WV017776;
        Tue, 26 Apr 2022 12:38:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=rHgK2R4lCyQVsnmfwk9xl4ogA0phq/O4Mi/OxaVecKU=;
 b=FnUb1gX7Uo/F9aunrVehYRhnEKcspi0b1A8iQMN+0La3BKQqTFAm/BTnwNsiblrX93VT
 vrqC+Ei/G0NRwg9bmqUKMPNB2qgfBTJt889oXkxM1/1BSGcpaBdtDyFP7AIIolqNhSXc
 kQBtnxOL5njWC+eKBjJDr/DiL9sCOXndL1jM68VRJkWflgQRPm+v4Gw0INNWY62subVy
 FBDKyRKssTSX5Q+02NjPnl133uU/RFFK5hKr+xkDBNXtt3DFf7jAXMsA79T5DjVplkq0
 2Cwl0Exs6jEn5cRKtBcnZmsev/rGpFKjq6Eyp6OQw7F4DaV51evV34sGTFSDgbzkxemo 8A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmbb4nss7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 12:38:34 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QCV4AB015984;
        Tue, 26 Apr 2022 12:38:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w3b404-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 12:38:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lodPlknluiEWACAQv+HDuTcOVZrAb1tr7qxZfKEb+usoxlVktxwQLHyVB9md0wDaG6wqcoC0oESm5gkvQWKcGelKdfn3WF1HeCF3OsuY6drrLv+gc01AQr8/yEq5fw2sf6hWeIlliGkNJxdQZUELb0nc1MA5Kli8UimItCcKX+50AlyYnST3LZF7/rleAH0SNpKvzp9jE22ohsQYPJIbXRr5lNUT0cTHDEskSqh4jW0xGL58PPA81LtJ7vl2LcNX2Oih36PdbB9VJEKLG0rEWmfSnNtu3sM6HZZtLEAPWy7OesEi5/JFevJUyl72wz5YCBsBoNTA5OJFRAhlABYsRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHgK2R4lCyQVsnmfwk9xl4ogA0phq/O4Mi/OxaVecKU=;
 b=WL3TNIPfmDjdjKJBR+ayQNknOGZQFOxuWeYQ76LFsKuGmkjpwv/WRtQU1xmrugFb2imO31A85bjzhCxgs5Q8ZU0QehhLfVT1fFW5/gzJyXo2KEYhukwM03mwD64IdMqZkpcY6Cv0/zdFOyk4+i4X24dRL9BCXnLD+R2UH0SpiFsRuTU5gBfy9lPSfylg6HXgZIOVyPc9M6sixiFPjVE0d/+sDYnej221A7Sfzn/DBfZYyEbxe0WE8VOtmYknH2umdLd1xVbZx+MzTheURVSaFCGmRzzrWHk5xfJABLJrZDoHIBCqHVItj3OYudrMCkpypSfw3N3sEjvH/ASuWERbBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHgK2R4lCyQVsnmfwk9xl4ogA0phq/O4Mi/OxaVecKU=;
 b=XXKd9OYUCQpZzLqH7T8RLD4X1I5Mhmaxng4RUrZMVrMWTzcrl33I+/EZamtOaadkC7RoY2eOg8Zvl1lmsS2v684J1Vfqc3yr6EwcDIYYF7cxSYz4yRKLQHX3tWSXbP/jB58h0cohiSdiNk3CUukKE7hyRxkFBIP6j47xCwaHJDg=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA2PR10MB4764.namprd10.prod.outlook.com (2603:10b6:806:115::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 26 Apr
 2022 12:38:32 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192%9]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 12:38:32 +0000
To:     Xiaomeng Tong <xiam0nd.tong@gmail.com>
Cc:     skashyap@marvell.com, jhasan@marvell.com,
        GR-QLogic-Storage-Upstream@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND][PATCH] qedf: remove an unneeded NULL check on list
 iterator
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1o80ot3yd.fsf@ca-mkp.ca.oracle.com>
References: <20220405004055.24312-1-xiam0nd.tong@gmail.com>
Date:   Tue, 26 Apr 2022 08:38:29 -0400
In-Reply-To: <20220405004055.24312-1-xiam0nd.tong@gmail.com> (Xiaomeng Tong's
        message of "Tue, 5 Apr 2022 08:40:55 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0099.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::14) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c746f366-857c-4488-1b09-08da2781ac4d
X-MS-TrafficTypeDiagnostic: SA2PR10MB4764:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB4764E6059472E9C2455B37F28EFB9@SA2PR10MB4764.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JJ8KpUJhNtxvkP+UrBar5zOzrmNQN+SmZEzExquHbZEVjkceRAPDdNxjxdex19qmgT9VQ63iX9oH9Qkwp5muKDXzQhGnqQ1S6mmbU5MjVSv+7Sm+4HSAB1FCz1AgtS++X5DNx+ixghXBKAh+XGx0zR9oPJi8JpVP8GjZiGZr1Na/7Cybwwkm/m1jfWXCi3n5tj8J346edR3c8FxTJ5Q2YhHUxm/BvuNKlorqSB0/wzVewHssV3V38I2wQqIrC8FtcS8y09TXnk6w4lSl1ae27NznNx8AyqEEKSK0AJgkzWePRVEPvoPZ8/exwFxqahjeXUflJxauTkd3hk2TJ4GhZc+ah53RbrN28hsEZIvgMG0KSNRfMLe8YdrvANEpYoNYqR70JCY9yjGkp/mFg4l84eR+hL3bGNsSaDY7hWpRrlVM9BE/7YQWw4EwiaK3eoM7t3HfZdE79oOMj1Nv686Ed/Co+nWABipv2je12ZYQZutPwh74grkM0zSiWyCemuWsDzGeg6RI/jHMselZRX8wttVMpqZWfZL1yVHDjSIMX75K1smpjirPZvCfp4Wadf05W67q/dn3ySLkIYQ6qJNpZ3CjV8dj1ZTib6FDQvr1QDwS7EgDn5tH6adzbGnJE99pU4iS+NfcLtfIBOrYErALwijq3od+WgknqpmY2jZtCl6i62uKXSW//5LZN0CWfhwCt0uxg5TXZsPolwhmk5JzkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(6916009)(38350700002)(316002)(36916002)(4326008)(8936002)(4744005)(508600001)(6486002)(2906002)(66476007)(52116002)(86362001)(66946007)(8676002)(66556008)(186003)(6666004)(5660300002)(26005)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wjk/YmkRqfDnOLLS164rOjvu5VKOusVGou18s1nz+fjNVp51+9JGer5nHXhm?=
 =?us-ascii?Q?qh1anRSE0vo2ItB0IDj8wRjAbVyKqFv1uHd+XhYlPqdiZDGnHud454yfEMN5?=
 =?us-ascii?Q?OzrcuIlex8cvEh/MRTGM/53IeHyS7VLUf09p0f40s2YLnFAKsrCB4w6zs2I5?=
 =?us-ascii?Q?FhilwX5SzO+L0dVW3hpKaqFMaAPkASoCHkjGyp2Lg4kCKQpqbqb5h/Pz+zAs?=
 =?us-ascii?Q?zS6ijwTPPK7LWG4ajxVMvBV2vlLZU1CanVll4vvf5OPLiZ8q/UFoYy03TJUx?=
 =?us-ascii?Q?FvhjYDwgWQlhLQM2zFX74YA/wIjWnpZV2QVNn59dVtyCHmo20vfuIbBzKuLz?=
 =?us-ascii?Q?fbXvSo5cBl8nwwPDIrGIs3ZX4h/MT40v3BOnQI9C/9aHu4ibd+o+4k6dzy4r?=
 =?us-ascii?Q?dXsSYJP/89W96/J0t8854UeetaUhuyn+gSEWi57M/DfAKq/tIXSn3V2blCdB?=
 =?us-ascii?Q?U5tZrvU45K5oOFAumqWs4koVdMRzYxzwDTwTID6iDtwfVOa+w8dA5mmTg2YP?=
 =?us-ascii?Q?STonn/b57jscgsK7rHNEJSzcWtZakT0fcdktnElU83UKaiZJGM/6hrqwVCpF?=
 =?us-ascii?Q?UKChxPqN0x7JN1btD/dAr67C5OO/Zc387vt3vwZiY/46/hTAVLJcYcXFTYqm?=
 =?us-ascii?Q?JG+Xy57krFK2YgmWOaL8CKHN0TlJ8raZb1UXMRCoSOxCmotIgLXyEUz2glyK?=
 =?us-ascii?Q?47mUrs3OXMgq73i3KdP59uZeJg5ZgbhYKLF32uBDi0Gw8n5a7IlXX1Fz1CJq?=
 =?us-ascii?Q?38SlnnoKIDQVI4oLOXIh+BfJ4KBCQCnkd/1tnF+HzS1QzmoKiE5pu9HQRNCe?=
 =?us-ascii?Q?ypbUJmFE06AO25fX+mMg75ZOOHT3xj6NFhZvvDLmqQHApU431YnuvyTCG2+U?=
 =?us-ascii?Q?eW7HuBJ46KiYbcrve5fhp2GIdoO3oB47+3f20kntUDV8grfOskJiouHCpQx5?=
 =?us-ascii?Q?6uHT1KLfUvs9NTsx4DnS5qSYjZcGIjQlAuohLtp65LF53SE+FYH2R0vhZkI7?=
 =?us-ascii?Q?hL+vYDfEE7LhIsXB/pvxY3VmelYbUtLK7ZvjzMlRWHUH63IJk7O6LxC6IghA?=
 =?us-ascii?Q?6xMQhmJTId+nNyJV2nauvY+d4rZGILNeOmt2o9hvsJNh4ubWPMaMjorfCXeJ?=
 =?us-ascii?Q?3lMBns9mxYNY6WAy8OlZy5jxGJNoUBpcIdZuCzDX2XP2xzvouAuLedKFdKt9?=
 =?us-ascii?Q?mWx99nlu8LwezcHRFysgG8AtY7KocMZhStyLpba0jHJOf27TytSti7wGOH12?=
 =?us-ascii?Q?QQj8f5x5/r5Ru1taFSs3AIeqF6XuwldD9KVCtb2NoOCBfjzZJLAPhVbFDHoI?=
 =?us-ascii?Q?1njGDss0Yu4rVcLE/Cfua2tV8mw60dNPigkC3hf5QYlyWMO6U1uap4fCc4+Y?=
 =?us-ascii?Q?fvklGVhfvH3hIbE4/nwFSIZOHWk74g5u6gDcxNBVGfuh3CgK42ZPYNy24LzX?=
 =?us-ascii?Q?moqGeKiBO7XdmAm52cwlpuJHAcjPvjXWcrmk9yYBOYP55FBScTG8ZNwp6i7o?=
 =?us-ascii?Q?a22VfgIsocTAfrqvWbYZ1jPXZb42OZQ7EdyJTCJf/YJhSRq5Mglyq8zA2yvL?=
 =?us-ascii?Q?vf1x3ygLNLN4BbAsQjZ3NmyN8ufCrMe4w6PFQa6EP7qB5rb8+9QiOESQlH3d?=
 =?us-ascii?Q?Y3be6LeWNvyRIu/LCziGvm0avC2QK25jeEwcuFABNaJmI8s5YhF4MQTDY4Rs?=
 =?us-ascii?Q?fl6hrVYC4vHHJ0I1/UNTRFLkOihSJQ7CVH/bmzbmOD/HdXh3ewnENx4nnxce?=
 =?us-ascii?Q?E73YQ4rQp/8wxgfCAK4MiaXK+Ch1O2A=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c746f366-857c-4488-1b09-08da2781ac4d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 12:38:32.3219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LyR8uTCUqXPUsuIMrN4Jd3iDqN9dSepiKBePj+bAXHji4UHtviWZLYUa51eALnmBP0WyADV/2WFDbMP9IlxslaeMJOehV+NYrrL+pyyDEfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4764
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_02:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=573
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260080
X-Proofpoint-ORIG-GUID: pSfk7pXKvMl0AY94FCXwkGCxgcFslz3Q
X-Proofpoint-GUID: pSfk7pXKvMl0AY94FCXwkGCxgcFslz3Q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Xiaomeng,

> The list iterator 'fcport' is always non-NULL so it doesn't need to be
> checked. Thus just remove the unnecessary NULL check. Also remove the
> unnecessary initializer because the list iterator is always initialized.
> And adjust the position of blank lines.

Applied to 5.19/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
