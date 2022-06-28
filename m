Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4698955CDCE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245426AbiF1CtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 22:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343843AbiF1CsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 22:48:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99508B99;
        Mon, 27 Jun 2022 19:45:50 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25S12tUl013227;
        Tue, 28 Jun 2022 02:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=Afju7h507uuFImYSwYAhmSDdpfDt+/zrV2pUAEPiAAs=;
 b=F1U33rFAHWEpkpoeS3i5Bi/KGj2KkB5VgtL1jokcYPfhB9br+z9kwYnooxj/UvSOpYff
 R/xk8v6LWA1ivJMiHzh2Lk19tYW+FtZIIJKQ8IgCM0hU7Wdt5aBqe7hn6vrxjTpVTjdE
 PAvYYduuejRJngyjlI/9yh+DzrfaJbZPGpt+76NfjI+YXH4CDB7i5ZkzbYDT+Z9HPSyG
 N63wuLILI4nXSvrfRDlIYs30WworcWUjo/1MwEclQZmyq6NeFBEg8d2z6yAilG1OYKP9
 LPtWckP34+9M5vu9Z8Z4WwvsiWadv31eDzMZkcnO/ooQevywEFb0dbqTXkAjHWKORoe2 Bg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwtwu4tst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 02:45:44 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25S2KM35018864;
        Tue, 28 Jun 2022 02:45:43 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt1tcrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 02:45:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DD/ZFMDXGo9fn5o3WZb+encJr/l6T7osMssMR688TZixION4GYW/WCMMrrkd5C1jXWbO8m9poNs48ztpPXLnfJKoS2ossKHknrdaQQRJJx/ut5rlf/UYNXtw448JOcVYpvZdH2SubbvHe78ffLHdZD4LmLyZOBf7LjsNTbSLaUCwletQy/QFqAoP4qUlSexyrbCOK3caqhCOhWrEomscCscN2j/ixP5IcX8WWvK7hBFhfPF0G1qSaopCc4hwVJKRDV4SUe9qSNlJ1g+0T+Y6Febj8ulVl4f7p5JHouzdNH0DbdhZIad6v9dm84B3JNJwompCbiBzshtA5VzAYGC4Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Afju7h507uuFImYSwYAhmSDdpfDt+/zrV2pUAEPiAAs=;
 b=ZZ2p+vqDkYnmgQoakXhimhQtE9WaQO+qDafS4my3okLpLbZZ+bhrx+yD0TokFRXNXF1S0lBefWRRuZlZAjjx6KPiyvX1QQ04k20c4GjBU0h1aKuwaqSaAPx02f05VuI1X9wrGZYTQOuDMrDC6dqNoFYOKx655rgPqQZp6nH6ZEcBS01a9QuJAAVIiGgQVafeSYSxBINQdlLZhP7bEh/GTLHbr1DdJclKY4w5XWtCLuSkcnC11wt4XUz7rR6djohudfA0yoOSIS9xgtkBrZe+kA09kWvKemuys6x4yNrEgSKrF9nJGmYQlCEI50nMX2Wq/5mPm7gl5G8hPOa+zvTwVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Afju7h507uuFImYSwYAhmSDdpfDt+/zrV2pUAEPiAAs=;
 b=nyHDZ2R3uivsCiILoXnEAfsMkF/4HBJr0RkyVqrpkj2WDVMAZYt5GCIcBvLLsjQlyAYjccRmSKes/rErXDBa0HuXeeBP8Q0Z0aFBv7yGoLW5r/7+zKglEoyHCrY5Xtjr486ww70fOnYvppMpr+1Gmduo/acZsUKF4hm3+0MqqOU=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MN2PR10MB3981.namprd10.prod.outlook.com (2603:10b6:208:183::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 02:45:40 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45%5]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 02:45:40 +0000
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: fcoe: remove redundant assignment to variable wlen
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1lethh5fc.fsf@ca-mkp.ca.oracle.com>
References: <20220623164710.76831-1-colin.i.king@gmail.com>
Date:   Mon, 27 Jun 2022 22:45:37 -0400
In-Reply-To: <20220623164710.76831-1-colin.i.king@gmail.com> (Colin Ian King's
        message of "Thu, 23 Jun 2022 17:47:10 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:806:f2::28) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15695d81-9fc3-4ff9-9905-08da58b049f4
X-MS-TrafficTypeDiagnostic: MN2PR10MB3981:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: METL9ZzEsV2BK3gyKvmDQMRzyLdQmI0qOmpnV8WJgUrrHHUs6AD7yPQ5Eiq1Auud48sT2r47X/cWnOMTpbBDDVXyWtOrg1Mk/78zSE1sgm9QT2DtHGRLiZASLc7NQiVZ70fDHpIWvonST7bogsyx0JWcn5cXpJtHtUneRXrXgAs5ocDXvcv37PLed3akP2FfFKpbSYJuJ5OOWJD6kFNgW3hvc7HZL1GQyX2M8Ki/CZZH5nJR4SLNtGBeNGAHbOTlIZIVFecO3zPo7WqkJw4AQdTm0tCE567XdC46XphRpibYa2XvHzWfzIh1+E8FA/+8y4jXBRfQFIkd3y7b+1+fN8zcmvq3s0CEA2Piruiqi5iz5KlTSeeoGKksC9vLU0eelkkm8yZ9koE+fQ2+oFg7Olktw2HyhGNO3IBjALcv4xFe1cdoGmUEYdh7loa24KX1StVeOvdL7t/FczPm9uSifTLPxPprY2A1v7XyaC4OgubDYHEJci9oVUpJr3lt1B6m+XB5Uqx8lSTFBfTdpFhfrXqLLjSr48suKSrlvfvIo7izStUHQurkXu4Og03emGXzMvaeTaARTT10+YwZMQSR/Z28Z6Ng9PoEwuNWwttg35TaCg68KvMRxjZMDOAiFcuF+8fwilgKGgJ9uoL0X0992qVqi1x4PqVbBJ3P3xqHuUSkvkbvLdLvBSKBGinDFP06x4t15J9dwJZCESRA47Iu8RvwjK1/jy9QH9XDtpEQkc40SjBgQZ3b8GDhlLU5Pxv6AsvkWUitM4PVuz2LVrdmkp3hTN35zGVS0aCe8AgIYF0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(366004)(376002)(396003)(39860400002)(558084003)(86362001)(66476007)(316002)(4326008)(8936002)(6486002)(5660300002)(38100700002)(2906002)(36916002)(52116002)(478600001)(66556008)(66946007)(8676002)(54906003)(6666004)(41300700001)(6916009)(6506007)(186003)(26005)(38350700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7Bvjsoi4aoHPHwYllm6wJYRKGMwH1nJvqnzMGhjDaTD2kXtukNu9N8tBMJUd?=
 =?us-ascii?Q?A3zUFqtySeDzlHIoCS1JchbWow2dwqL7VRh5fG1iS2JVCNdG2fAjWIicyqll?=
 =?us-ascii?Q?tRPYNrUrRBZDshN5+UCpvDLw0P+KLnrPhp0TkjZ8A+IbSEkjg5u6ApI5e4pm?=
 =?us-ascii?Q?qXj+LYNzmXv77szEt+wEW6mgO+5dHY74mFKJtIG5gXWcMPg9UMqTayIyCxT0?=
 =?us-ascii?Q?kGbCi3KmI7pSIeQ5EKeZPeR5hvm4kehI63unNlNbPBwDOa1igdfrJ7yYaoW9?=
 =?us-ascii?Q?qWK5ojvlNH+/GJTCS5zP0AvuJ9QTM+GSVPKknzJ+MlU05L/xss7YdpNi4Uq6?=
 =?us-ascii?Q?NGkGDyBFhBp8J0/jy9j7Zto1ZiSOELHts1h7Ao4ke9spjTgXSXrNYBzFEK6m?=
 =?us-ascii?Q?Il0wCadm5ylYeqMXvlOt5Ez9nK1hs49LBDRRmXk9/Sw4Nm7YawviioRDCUqt?=
 =?us-ascii?Q?pcMM723gsDQC9zQrlpL7KWzxQg+DP1Mrr8QDg1k9bGqjTPsHqbCDP8Xetwtu?=
 =?us-ascii?Q?QOuNO7yB2bulKNrwPzTGkIrRoCP/P+rK3m7oGN0612HHn5T+xdksZVXTGBan?=
 =?us-ascii?Q?ssbOaaKSkRd5UDLEUauK8ZPBATvSwdsVe2+ihsCanhEbLGbD7rY//l1vuKEf?=
 =?us-ascii?Q?pjD1DuJ/6IunhUKq7XhrLOsWp0sftLbxdi99yC2iIhTVCdQ+6re1Q1T7mjKa?=
 =?us-ascii?Q?dKfl5xZXQE8eNY/9ET5ASF5VmT7w+S92hkEIPBR8CEy4n2onoPsmCbCSOpO5?=
 =?us-ascii?Q?LUW7s55WtrdOhZPgvMkf8CDZCLBzPPq8l2p7RT04AXCOeWr93qbQTBFaa58z?=
 =?us-ascii?Q?haX0oSzIwP3H5ytuHhcFRaxBKhYMV72kTvTFNDJ6TRbTPS4Asa1FvItnn/IY?=
 =?us-ascii?Q?9v7g6xeUXl2FvCSt8ePEJny7otjcrsIesfn+I6g2gfqYZqyDpDsCaFhCr4KK?=
 =?us-ascii?Q?GQBHEwaQqzafVP3YqNeR36B9yQE0AxGXGrNt10nowcDwBq6dUPLHiUa15V21?=
 =?us-ascii?Q?LNYbMVW40xzP+i0Hfd1EcNrdTIslUa03od+kvH+PQA5IR2XrxSD4dEhJlrTL?=
 =?us-ascii?Q?dZOWEMK583dfHnwj8zRBnZUexAYvHo/rCzVWjnxjWtwutHm9u/mvB3CPKu0A?=
 =?us-ascii?Q?AiWrNXoCtEe4KskcUyoQGK8a3fOl7Tb4fzs0SHzbg6Phrp3v2+NU9jhI5ztQ?=
 =?us-ascii?Q?dH9r5PFIyVGFY1JbaKkXlhme8LZWV0tV32ZFn//wP8C2gQXD9dzClGtDBQXG?=
 =?us-ascii?Q?5RbDfb+/T7UxwNOMdVI6IZPxdiP8wrzADIjbIYpMjyFyIWYMjhcMEn9XkL+E?=
 =?us-ascii?Q?bX2/DKLsjmeo94Bqh5cqpkEJZy6DNA80XA+TEyZv0XgX0Q0yCmR7RynwGuLO?=
 =?us-ascii?Q?qQdZi83ozFyyu04zeJSpEN6PTcck9NZ1p61qEx8OfTSJXjW8hxduZGJooP4O?=
 =?us-ascii?Q?5Bxn1bM/XzI3CIaPvUBY9ZgycDf37g/UovfH5JtYkMtP+1PIHez+J9jJg5oN?=
 =?us-ascii?Q?QLlMg1iO2mPMR3CrlDmTzOmcgU1yX1N0Z79UHpjoXhLlEGiuND5FdmbC6gOV?=
 =?us-ascii?Q?il2qf26rZnEhgyFWYowwDwK6nyZ4P6Xlne5Hfomvk4bZ3L7W3oHLZnTVgLml?=
 =?us-ascii?Q?sA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15695d81-9fc3-4ff9-9905-08da58b049f4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 02:45:40.6163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sS0ijYXIaSbO2ljFqaUV4NLeKGjaOnH44JJvvT8ok/LxnLLxQBv9Io/qZ5ao0jQVhcXhba8vVPCcukVQ7l4IlIDNi8G6nIbX8x+1+mAQuNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3981
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-27_06:2022-06-24,2022-06-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 mlxlogscore=816 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206280009
X-Proofpoint-ORIG-GUID: n6DZTIsvIDn3ejwMuagjw6TtYtonH6X5
X-Proofpoint-GUID: n6DZTIsvIDn3ejwMuagjw6TtYtonH6X5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> Variable wlen is being assigned a value that is never read, it is
> being re-assigned with a different value later on. The assignment is
> redundant and can be removed.

Applied to 5.20/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
