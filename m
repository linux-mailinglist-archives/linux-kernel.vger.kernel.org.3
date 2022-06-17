Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA65F54EF0F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 04:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379551AbiFQCCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 22:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379535AbiFQCCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 22:02:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1642863BEC;
        Thu, 16 Jun 2022 19:02:25 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25H0Xv6I026644;
        Fri, 17 Jun 2022 02:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=SBuh6gY9CRAaqHqjT5tk5DipCz8YtcIii7B3btVof2A=;
 b=JKIWparUDfYGkY+LRfSkwytEeHnD0wpFLim3UV275FlX7IG44d3ZgV3OBEhsYMmWxFM2
 2B4OcvH0k5uOpnHB7jqE0hK1J3kPTPefLK1z9qHib29VxA2pRnrPBXGjblA4IxYOcS+i
 7NcUnszAMODoKzahZH6VLNVcqsdYnmrWno1Q6vJCEFBrrK0wwkmFcJ7AqgBQvtb5YnMo
 BYf0ekI2VxjQ1MR6xtN59IFmAJ28XwmbXBMatzNVcYMBLwusT4dwwWVpN6LwxeqhH2vd
 LYRcacCiwCU5yz9lqY54oXGVltsUWNsNCHCWxucd0Jl1gDg2sod3cPboI8H10CTuwsTo Ug== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhn0mshc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jun 2022 02:02:05 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25H1u1Ud022600;
        Fri, 17 Jun 2022 02:02:04 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpr7qqae0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jun 2022 02:02:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HheykNQAeFme35hxyRASPlEoRj+kS+eKYmo18Uy8tll0liljb2/oh3/DoyRvAXnOIWOMKHiX00Eix37MvQNb3+LknexCqqeqEObfJ/vqUtD41X7eyS5CpREX20Mr/GFduJ2vzmAMAuj3aJ8HgyzrVnkpMyglWwxOShOYPk43YN+H7GKCXeL6RlKlvWN3JKjt0VPKttbZvIDWaEgOwFkvby+SZLNI0tv6FSmWpYw8Ns3Xk77mlXqkaBuwwsmUDP5JkkcbMw9u5h6853C8M9PEP/EuQg1879G8QPHvkGNrPm1sbCKh5Hz1K/FAb9BMEdUyUjjxRgq8yYMYzgf5WVUTgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBuh6gY9CRAaqHqjT5tk5DipCz8YtcIii7B3btVof2A=;
 b=QFLJeFjUxQki1d5pQw4X8nqtSMeI7nnIf3nqVWHlXRCi//fNfStoGzMvZ2KoV6/smk7ADD+y2UdmOjFsL/q8eQcpJwjsl5/la3eloWZpbSHtSb6hHkKmpbcwXhxVdXA5YklpNw/TC7UYkP67a0ufmbBr6AtkAEyllfDyWz6lXJPWQPgSZSNb36KtuivJTApysNEkbGd4kYeyDVNAl0ez8VlJ2e74IHWRhp2Ke4j1HL7TdfYkBp2lDyvpqUwvqgcIV4LLeCXHNncp85Hpgca5xqw6XaYNrCV9ZsBUiGWlE58TIsPi4i8R3UAFpJsRG8Uget1/xFw7t4/rDXjkr1/OZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBuh6gY9CRAaqHqjT5tk5DipCz8YtcIii7B3btVof2A=;
 b=Kf/4uQQtsfIWoCJNRL3eTIiD4YMC/rnSwkFqdDy18rxu8q4EPPu/drHHiC7baxPQDUCr1UhVA1Rdpo3kgwB4n4qpWBJ6DbtWeHIjdVqC0kKeEJDT+aDuBHeEPmMttiDHLKF6HUpevlU7hub0A5eH0XWoHGcZpA/esD4jyanyfko=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM5PR10MB2028.namprd10.prod.outlook.com (2603:10b6:3:111::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Fri, 17 Jun
 2022 02:02:02 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45%5]) with mapi id 15.20.5353.015; Fri, 17 Jun 2022
 02:02:02 +0000
To:     Chao Yu <chao@kernel.org>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, bvanassche@acm.org
Subject: Re: [PATCH v4] scsi: support packing multi-segment in UNMAP command
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1wndgnj4i.fsf@ca-mkp.ca.oracle.com>
References: <20220616013617.2284341-1-chao@kernel.org>
Date:   Thu, 16 Jun 2022 22:01:59 -0400
In-Reply-To: <20220616013617.2284341-1-chao@kernel.org> (Chao Yu's message of
        "Thu, 16 Jun 2022 09:36:17 +0800")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR02CA0136.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::38) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d08a1291-e117-483c-7f81-08da50055eb0
X-MS-TrafficTypeDiagnostic: DM5PR10MB2028:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB202881B75B8C8041978945F08EAF9@DM5PR10MB2028.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z8EFoJJ+KQk2yT4msppNXOoYiAami0/0zmF2XcqfHFFbT8kbPBk1evoawGgipWMc8uo5z4hwNZ5zv0+yWa6zCcRfkeiXCqHpUXFhG58lqPYuzZUvazCHvRILje5OZXCLeb2k5keMWA+V8NNFPoHqn0p2l3vYmcXdZE4NC8IkCdw/J0ZHBidraNvb8haOwBUt6a3Jo+n7nd/24Q9bEWsmg6TUGwYl4H8ppK3k7HngiN2pYQNS6N2kTLzwJ9WWnv0zuYzxVwwe57KN7ekvdCNOCDBDskSu/IYUCLUB4aSvTXuq6aYrKObynhjsk1kM9I+RAo82+yBBvMIU3JoyN78DmIhSLfy+OW8YFdpU47xzD7EVTsmx5zjO6NAifqxhSlEpBCerOGlOAOfsehm/duch0tEu7o2XTE3Hl7WyA+sQC5u81Ap5N/1NumADK1BVp/lnECrpg5obGeRMptF5kiszAIvola9x0ap1f7q+XwusHlzthk36nBqaIM6gqq+L5yb/4VfmTyN58gDK4QR6Eqe59TzzKHLDkKrthvKZHvjgG2bvP4NmWOTcAkDNvJ9338/7CK/RVUDHymFTnRDx2QCPKQg3cXLLo77if1PCRWxnxhruSkJ0xjnVjLAKGC0VRXb4vjXP2AyzavbDIhIglN2lKEDRr2bHXxgcxLytSMfuNHNah2cIzPa9BDcn+zOwHOgnfVoSCuzRB7ued4DD+vYzNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(66556008)(186003)(38350700002)(5660300002)(8936002)(66476007)(66946007)(4744005)(83380400001)(498600001)(38100700002)(8676002)(316002)(2906002)(6916009)(36916002)(6512007)(26005)(6486002)(86362001)(6506007)(6666004)(4326008)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KvAfjj0cLS3ZwkYFtLUx3d8cm2vSJihEnIrAs/9E50aHlZ3opTaN/npDSVAO?=
 =?us-ascii?Q?O2L9eGaj6878R+sBNZHcUk3JiH4EfMpcY0KR4iqLT3zgY6AtDWBmkyi3zVbr?=
 =?us-ascii?Q?Hp6LyoqVsPsvUwPBcaSnTpdm8BJTb+VdFVhhSkBW/xU/XagGaqL8hwq9uUAr?=
 =?us-ascii?Q?fzjVk2hqh0i0lKnu3VeXc9NF+Gp2GLBHdfAnzIURcf6OG7bXSwr9jMeklVIo?=
 =?us-ascii?Q?V/+KQ4XTT+MoL5Ni21oT1hH/Ix6dLdrHoVWViXw1ZzgzU90J3hT2i5ORtNH/?=
 =?us-ascii?Q?umqt9D0psCl2qewZ9wnU8m1vXuzTexmqOVEKFZm1EeGwO9aZL/4c2+Sy3Mm9?=
 =?us-ascii?Q?hDqd+3Psk8Ql0lFT7H2tLqAbwFFV2y7CkTGJn9kBCxa/DFCHljPF9oAXW3Ua?=
 =?us-ascii?Q?gw8Q4FZfS1/F+0Nm4gBMwW2I2VuJHs79uXTANBzlI+98rNS0YeXMhq3DRo+D?=
 =?us-ascii?Q?3t5JH/hi5li6Ih4f16EEzwqNYc/GYO3XXtyCDG9fQTzhp+NElKAvhy4+w9uY?=
 =?us-ascii?Q?MCplJ3Jy100dyLKFTqDwJZoa6heTWIYxu/fewMHpVwLSsnOZwBdm4lJYjTLS?=
 =?us-ascii?Q?q/ZS7Ah/Y6+Y8js+wZd2aq6h/BY9uMg9vEMsSdXtrN2S009V6NC+ukwlxR56?=
 =?us-ascii?Q?JVIZ1O2Pj2MFspu184VtOo3FUKjeTX61V9crrlUCXZTwK9lhtyBMBWM01ijq?=
 =?us-ascii?Q?h5g2fcYwO2QEuhw5EardruwfVUoDHvYDBai1NoNKNAPLwII7jUcC/tWzN3Li?=
 =?us-ascii?Q?cwpUX/DTgiLsOl/kcz/GdyEVGZT9g3RkoyOPJxGYIi3lIctmvrImaaZ9Asxq?=
 =?us-ascii?Q?ImDWUum5EX8oYLfqCHs+d1HgfNArts0TkhsxBIUnUzfD2FYsIcKeax8At4g1?=
 =?us-ascii?Q?mzh2jJJBF/W+DceCdS94YXXBqXSwqBbF9Un3+rAczTnwVCjGsusBfa/0iEEz?=
 =?us-ascii?Q?DbN85p9mZ5OKg1b+MAf9d62TkEnUeZN0ZLAUz4XHepLiIEozUtgK4bPwLzQF?=
 =?us-ascii?Q?jVZoLXtg4Zj1Xdxws9tH2A99hQ3Eln4JDegijZjOMvoXsQbkImQ048ZYuMWm?=
 =?us-ascii?Q?fZS8kNbCjCaKwayYkdUwaY08xkhBWo0XaWwicXIuYe+8kiznQYXQ9vWmDW3n?=
 =?us-ascii?Q?dOlMxtf7nNcya73ZO5S/NtI7qyOf6F9LX+SnwIJoiVPv3WSrlHO+AGKfNvKK?=
 =?us-ascii?Q?nJu/lLmjxAJPoSPtlLkRVUnLJfmlm+REiyuOj7tLShuz0MZQwhPbD0U2FQC7?=
 =?us-ascii?Q?9b6jYByGvlulpr3RxgUK5YXGCXVnCGINh9Gj4rHrFihtdobnvoQW7/yKaguQ?=
 =?us-ascii?Q?AOaODJxOrpgmHYAmspR2Lq+Pq25fvsN/p0IwrBmb0bLYMSRDufIZBmtPHfmA?=
 =?us-ascii?Q?TKHvVHtpx7w85b/1er3nj0ArxdxGamNd1/Z8wMpUs8Nu81VvHTov96aO3IXF?=
 =?us-ascii?Q?ghk5EC5gt5JUqfaDpEqckWe0gP/67mhWNWlonjXgscARmq5qecVNBNCKPcB8?=
 =?us-ascii?Q?0o/tzdz+2V2/8JWhVSTyuX53UReqtCmNpq2UTtnMPm2CWkvnfcHQn9GcqKgd?=
 =?us-ascii?Q?aTpJaKFTmy3HlCwwsPlGMHSxqNf8W/M3VPNfzIxs7Wc+3a4rvIr2MjLv/vgU?=
 =?us-ascii?Q?f/HMrIWYSjRqjz718zbZQ1eE2modrSkTAG04r0C16jOngTr9gUae0WhfQ2fg?=
 =?us-ascii?Q?yo2+K3xTNYykUdwu6tO5eSN/kR1+Y/o/5tmBnkwR22Ndfedzd2i0Hy80JSJn?=
 =?us-ascii?Q?HAyoR517Cx5zUoNiHKbHp3BFqyeb+cw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d08a1291-e117-483c-7f81-08da50055eb0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 02:02:02.2217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q69gfPFghZ7sZQtS2O3ZIhjmPLLYi6Bo3O0jcT9TGLuK/Aw5UJ7/C//L8sKzS3aiJcvHzt3DdJo4oFhoeZlfMn5TT9fRPbNJ+K8qjRJeQkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB2028
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-16_18:2022-06-16,2022-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 mlxlogscore=850 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206170007
X-Proofpoint-GUID: T7HGnRwBOGbR05GDKJHV8IzBObB3wDkn
X-Proofpoint-ORIG-GUID: T7HGnRwBOGbR05GDKJHV8IzBObB3wDkn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Chao,

> As SCSI SBC4 specification section 5.30.2 describes that it can
> support unmapping one or more LBA range in single UNMAP command.
>
> However, previously we only pack one LBA range in UNMAP command by
> default no matter device gives the block limits that says it can
> support unmapping multiple LBA ranges with a single UNMAP command.
>
> This patch sets max_discard_segments config according to block limits
> of device, and supports unmapping multiple LBA ranges with a single
> UNMAP command.

This looks OK to me. Will test with a variety of targets.

-- 
Martin K. Petersen	Oracle Linux Engineering
