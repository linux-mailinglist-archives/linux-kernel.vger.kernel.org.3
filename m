Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF4A510EC0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 04:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357172AbiD0C2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 22:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357112AbiD0C2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 22:28:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F9314B671;
        Tue, 26 Apr 2022 19:24:57 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QNZGUP003693;
        Wed, 27 Apr 2022 02:24:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=+V9OP+C2nbuJSV4qGdICtnLH1a9timCuEG283+MY9Ws=;
 b=CLlduPNY9TWHGMtHhgPybqtfTpyZx0iuwxUV5nhk1smw/e43MfigJLHKLhXiX7OpSLPZ
 iXTKoCD3lahmXLL+8KyEUvdAkIk++TrQmsOMoWL6K5iVkcG+DVN9Zj2hjY96E9rb8u26
 aXfaE8UEBLl36glcbJGG84kCsGuKXQbVUghSIMg8Gkyx9n/ZUEr0spSC4RppWRhHWNan
 FTWuyfmBKxe/FwccvWDkYGvXs68WO8p7+V1ZvzdXYmidVNzdaEr+mGq+VqV+kFlpcIfJ
 x8PF7ckGWaCLW7K1O9BRX06F0UbKeMAmyaSfTaziFHE5TFd1pCUUCFkOQH0Il9FXZd4D DQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmbb4qfxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 02:24:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23R2B5p5006523;
        Wed, 27 Apr 2022 02:24:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w3yru5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 02:24:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxeZaINV5fWH1HEMFPSClA4XuWMbhI4UdEmwFcW4fIKqjUhMYUsfmIpLX2s7vZu4HYY9wvotjCN+FEZ0GubVkZpJMUj8dNa4N9OQLK4iNTP4RpsMqpCfAMTA/A+Fp15wpXa1szJ6fadXkUY4J5yNiy8tRnPLQKmrsKIYZyWeGHdzk55XJSvH2qf1t3uInftowT7DxoLA1W3UrZ7lGnL1MHngSFnbEZGVPW6UCWP2wwZuIsovyPvrlfVv1Gy3M1ECAcIgniSosqunQMI8VXK9qjq7h1zcFGjvmqEmKGEPTF+DFhC0AIoAaaZTWAsaODMULIHAeb6JI4Wdn1td38fq2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+V9OP+C2nbuJSV4qGdICtnLH1a9timCuEG283+MY9Ws=;
 b=AyHfj9MRXf3xOv/PwfDrlS1adOzar8VIoHqEaZyoCx/zjGeBQvqSnN0Ua8eL1TBczI3cmngrlI2K+s3HBNVwV/KmLbXGBJ57uFfOthtWUeDk7FRzMGgZiT+/WemgackXammTbBxvNpIzFYS5iShxtEUqtGlnkZWh0Wegijc33hkYtzozQzTe5SvlenB28DFBcLk0tuux+Cn8IR3B63pNHCEhAv6m+Zzl37eFLw4KolRlcqA4PSDg0d+obfl/rLJfLcedP3PaWIueZKTks7fvLG+wwQ52I0A4md7VQuigANqj2TLrf40lvl0rEmwp83OtZe6Xqu1EtruvBkj8Sk8xoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+V9OP+C2nbuJSV4qGdICtnLH1a9timCuEG283+MY9Ws=;
 b=NYag4Bi9/lrwjioJrPCtJwj9usrzjTrlAvX3kY83auw/hUxqm59leiz/OGUzY/7H+kx0/69ORGrlBLScLIyPeyqUjOWcYiZJYPlGO2Q3gRzVOcHyraTIoyjvSylvGKfoOFWdPTb19LgON7cFKFNOODJInpk1yYfJFFWG7rLKli8=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY4PR10MB1333.namprd10.prod.outlook.com (2603:10b6:903:2a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 27 Apr
 2022 02:24:52 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192%9]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 02:24:51 +0000
To:     cgel.zte@gmail.com
Cc:     martin.petersen@oracle.com, dick.kennedy@broadcom.com,
        james.smart@broadcom.com, jejb@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        lv.ruyi@zte.com.cn
Subject: Re: [PATCH] scsi: lpfc: fix error check return value of
 debugfs_create_file()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq15ymvntzu.fsf@ca-mkp.ca.oracle.com>
References: <yq1v8uwro3h.fsf@ca-mkp.ca.oracle.com>
        <20220427021614.3841074-1-lv.ruyi@zte.com.cn>
Date:   Tue, 26 Apr 2022 22:24:49 -0400
In-Reply-To: <20220427021614.3841074-1-lv.ruyi@zte.com.cn> (cgel zte's message
        of "Wed, 27 Apr 2022 02:16:14 +0000")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0071.namprd08.prod.outlook.com
 (2603:10b6:a03:117::48) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abe889ea-20c3-4f32-3d55-08da27f51c0e
X-MS-TrafficTypeDiagnostic: CY4PR10MB1333:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1333146EC37ED4B145825FF78EFA9@CY4PR10MB1333.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VtIrxVSq6IZPxy1ZHllokx18ycB9CycaGrpX+esUhKWPJYbgiBq4uiShDnF8z+vmumNnMCHRHw/Qhvh5ELUp+pO4rzEuq6/zdeiiDVB08xPLLTcfnK1Hnl3Buwzd7Yy+aCl0jJLM+DXL1/Vfr5i0gkJUKAwDmgFHs1jdka/WkvMmL4NOV6CqEYMUb6S/6+1BA3r1F0UedQjnTk915ObZ5Te8wYMuMsYhR0i3Ee3T23EUCMQgzWqLc4wO3gX4rb5eZqcLq5sPOJwbNE1HkcWC9vo7qF8lZ/qaiBuwjaR5m0fDlzPNaAwB3eSppFajrVVYazhTKud/BqcC6DyUEVe1umLKq3mvIMF+TXhYihl1CY36CbaM2JrmdV5M2r++4aI/Mctn6lEp4G0j0GVyl07LcFMHvDneKcXZqsrpYggWWLcwgctBdWLaLD0UrEaV15fo8q9fRVRPqCulueG6Qi904iUJ5mPOLYL3gbgP+yGkV6WZg+wXZ0j/XQbLHFYIChKP/+AV+2n9bp+eKsEJnzxJkE8D3ylGpRs9C2R7/74HFNLe3oH7QVRJ04Zq0MDyFz8CDcAljqtovHOQD0jqX6qu5NjBwUzTeImAOXzHOHDRh02HF4qJMoiafw0rzEKen7OLB9dUbn0Qv2DZILuUIxoCI6fiPScEOQEZDx9LRWyMdnhqX1Bn6xeTbeX3xV5N5roEEs8PdGYCLMQyl774CgjwFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(52116002)(6512007)(6506007)(186003)(36916002)(316002)(6916009)(558084003)(86362001)(508600001)(6486002)(5660300002)(38350700002)(26005)(4326008)(66556008)(8936002)(38100700002)(66946007)(66476007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eetYFd1RodE6Ua4te6ZkXpO8JHdLydT86vjpKtI1vFcgIdL8Fvo9aHBwCNbS?=
 =?us-ascii?Q?VDb7NAmE1RczpH2adrXJse3cJANMLhfLOZyad0N866Kdh/M4MwxPBWs2Gyws?=
 =?us-ascii?Q?OdOsFsA73AM3zzpjc5/l25YO800z9bGnQc60UJHBqh8IU4QqtNi+0JL3xDnZ?=
 =?us-ascii?Q?zY31ukPqPtwx77sB3awfqvga+f3mephAuVfInb6wHzv1A8olVGadZJ6mCQil?=
 =?us-ascii?Q?3ACg1tfooYWTbi1i1EAUY+13MWhelH6yivHZPayaSMsgR3ZTJItkpCUiK0/A?=
 =?us-ascii?Q?FFlztrK6uQ+Wx0Y4NCoU02ST74i+SXHoilT04o+KhNQMIUrlQX6G1/ujTAHz?=
 =?us-ascii?Q?UZQJykCCyuSvGhBqZOMT5H+J/J8lCFrJ6lLeVqNA7fhNu7/133oE2+nj4HkO?=
 =?us-ascii?Q?Sfl+zG3mqOE42zvBiTca5Y7mWMokWimTxyRcjqj7LGjJ5fz8xWfITCNz40jF?=
 =?us-ascii?Q?XOAMQAf/284le5oHjyx2zZR3qMIOgcn3+iUSZwY27E0xSKi61F/L8QzO+4Yr?=
 =?us-ascii?Q?6ywypBm/i9B3GaRqUrXw8vw6/UoU0uOLYLfDbZC0XKC734KPOgb2X4oGXD4n?=
 =?us-ascii?Q?WVVnMqtrgNyEAhnK3BQ9ofM2EBL6FrDEZX99RPMzProB6dt4NJlDPzj77JLT?=
 =?us-ascii?Q?lqtOFWHJtC1Tc1JNPCFiWTvdEpVSzqmSZCki3LvgjsLMw0qZ9mlcBBpyHjlr?=
 =?us-ascii?Q?sY10lGasG1XSnTULLdCw0LC6QmWuhKkL63ejiaKgxDf+R7mKmDWXbK18kFV7?=
 =?us-ascii?Q?/ZCevV04hZ7EJNBOOuOFkX9AYrB5gLtiJdeD2H0pNLkmXGmvouk3kTGOY0vp?=
 =?us-ascii?Q?qhgBlYqiJB8ap+hTOeDclovk/lTwoFF5lxiSmsJj9WTE5Hevg3VXhpOsJCAV?=
 =?us-ascii?Q?CEQgwDSFHCdAKI2JAyWRt5cEUxfBALWEKw2tc7exh1bYOiSSZmeNJNYRNtbH?=
 =?us-ascii?Q?o8gGJLaCstj3mQi5SY2kt05rOYE1iHWi2J5JDkpwCDgZTaDfZ4ay8yGnxxf7?=
 =?us-ascii?Q?hA9hxUYXqPjPfTKGEgBSWj6+yNVussbErGc8IGgiHWyrQlcJN0qWmDxw2twL?=
 =?us-ascii?Q?yUhLO9XsGy1SpPpiJyxYJm66ML+0TQuv7gZahAIIJ+35ewoVdN4TDShsssfr?=
 =?us-ascii?Q?wXdrMTL8UBYMVQq+X9Zc/cx/dZy2DfTE7/tQchLzqSim87q1boI8mkusGwZv?=
 =?us-ascii?Q?Q8sTGODFpYrYQlndf3ZD5Knz6gVANbfzRFpYwg9rUuA5ClRq6Cqfnc4TfGWD?=
 =?us-ascii?Q?txOvWDJ0YNqmZcYL3PCPlv2qSeDnuZOfoiuhO4qyDRFbYlZq1RjQ4lxjxLb8?=
 =?us-ascii?Q?Yg2Ad3rlzf3Y5i01szN2YEJZUzQwXctWJQdVUeDe/WMTYe7KVYqkTkKa6Nij?=
 =?us-ascii?Q?YbwYmHYslGrUU3qqOvEbgo9CNoRxlyoHafUIEamfhiuP1trI+UvlAZ8/Pjix?=
 =?us-ascii?Q?pth2nKbYpy/+ZOZrru0yw1kMUajj6+srjIdEI7zVfsdsGJDYcrhgNja+SXTJ?=
 =?us-ascii?Q?6uED7vtzO+E8CMkK58Lm2hRVaIrfofCuY8Kwil3znEdZbRftwjc6R3ezZ6Eu?=
 =?us-ascii?Q?UL21RCiepUSAwrtI2z3TZKmEcIxbYD7kpgOXdrThos6csr8T9Fnl6wKTNy5Q?=
 =?us-ascii?Q?UcaE0c/FH2h3hrn+F0Wl7b07k2Z73Xm2zzVI5XGSHHbwiTdBUVFRgPbvELqt?=
 =?us-ascii?Q?YOozYFpY14ERbdOnXzKAQZSUlaZ7uItX1xUIwelGDZmYrXjys2hCRN++vagW?=
 =?us-ascii?Q?DjLb4TcN817dwL/ykg3gaMzJLz84YhI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abe889ea-20c3-4f32-3d55-08da27f51c0e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 02:24:51.8919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltHM7gm1QofRF9Ol0RCULhAoCnC4jGGkkKTv9GJvzJKWvvmhguyCk2k2gJaObCFACLzGqGwMFazylXbV9XMp0bHPYJNBs6EsYjUgz2ZsZo4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1333
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_06:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=623
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204270012
X-Proofpoint-ORIG-GUID: rCquWSY3P24mWC3ehgZ7O0kpwWYa0gfl
X-Proofpoint-GUID: rCquWSY3P24mWC3ehgZ7O0kpwWYa0gfl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> So sorry, please ignore this patch.

OK, dropped.

-- 
Martin K. Petersen	Oracle Linux Engineering
