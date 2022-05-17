Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495B65296C2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 03:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbiEQBdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 21:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiEQBc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 21:32:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898432E9C4;
        Mon, 16 May 2022 18:32:58 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24GKrKuI019530;
        Tue, 17 May 2022 01:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=LEiT3zi/5tJ5+lp3UT5vgVKImtkeMr3BmLA4Qsec8Cg=;
 b=qO6mu9vGatvtgtSb3vrfHmgMFIVB3r9EhqetSFfN1BOJT8WalHC01+gR5k8plhc1BMG4
 Nort+cNiP+njKAClRBo+0fN/vqm8UU9pjAUnsfmKcVAg/OSgn1ntTGmLcrna7EPeFdnG
 OcQWD3hs+0Y1LdPdFW897I1nAQ5DTKgcmmxuti81N2vYUtZBFbBkBuQQSnlsflVCj4PY
 mJxX+2/JLrrJAWBVufYVzPFwImhi7fJeUIOTTZjoKfgjO0qotWa0nk1mM5cXqkgelvd4
 CJzmdsBXvxiIms+WA42uhZDeC1S+2eOFu27ZjVfqWyyzBT1hg8D1Y74Eqi4kE633VBTs Kg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g241s4u9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 01:32:56 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24H1FwKq030647;
        Tue, 17 May 2022 01:32:55 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g22v2fesf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 01:32:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFnIg3uDXTjsUxMPVfyhreOCBahAtAzJztpsJ57R2tBogUYpQNHBxpvnRCS9D0Ot5Pl5Tycm5zwPmA+CoTc5KOn48ikA0fVD2kwPYyUXe+0kbKw17xZZwIWj73/gq/sGg0FwaJGgLUnYvhtsHqXSky4eVTSuxrDHBPPR+hqi8QuHNdvwlBgewr2qhmDT0iWu2bdIXJaxihfTzwLA/AWPy87uENcAYRKxa1WN1ffckAKaCeAW2jzV3PeuuWtk18QEZOI8LnlsbWFtPU1GNybL+pW8IlgxoVAYMGjoaNFvCDbb5z8xN/I7+rTSD0HLdxWLYaP0f35jvgZ5GSIgR9Dyfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEiT3zi/5tJ5+lp3UT5vgVKImtkeMr3BmLA4Qsec8Cg=;
 b=lWmR2f7sGP8CGqPPe+OgJS24niowMCyvDwXWpvLvweDl/SwCtthbhHKGXapc9AY/N55Lu/g56A51Eu2tDOnz85qgNE48YeeLQnLcdqu5GEzDHqYAoNVS+bnWqGslyYp726ddV5d/ef2hw+CTJVkBO6sJLNHwfqRGLwh7b55dZCURJNqEZSVrNcc3KheigsrNgU/8khqi9ePRRDAvdnrYuYnRSnH5glUbevz+beYPOnxXkwuIp+95izW5LrbR5K4ee5IF4WVsnzXTm6h3UPFrGT4f5butQ3QkQN7WK7vv6rEQUVv/SjkfA7nX6eDX+jsZfw2F4fznCgx62itV5xdVfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEiT3zi/5tJ5+lp3UT5vgVKImtkeMr3BmLA4Qsec8Cg=;
 b=bvoOJqHnLn/2sAc3SGa1U6H2vhaOOqFrFmVOOaayqUHvYKgimyXWjppzqiNWa98i4tXwA0cg2ovrmUTq20moxDiRL+EwA16YrLZXH1+k7ijNv4XLihG0xzqhlNnpDpZvmz/9QzqZqJbTvZbnjp/ato2MCnASGHUOyfOymy7kz7w=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS7PR10MB5054.namprd10.prod.outlook.com (2603:10b6:5:38e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Tue, 17 May
 2022 01:32:53 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192%9]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 01:32:53 +0000
To:     cgel.zte@gmail.com
Cc:     brking@us.ibm.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] [SCSI] ipr: use kobj_to_dev()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1bkvxrljc.fsf@ca-mkp.ca.oracle.com>
References: <20220510105113.1351891-1-chi.minghao@zte.com.cn>
Date:   Mon, 16 May 2022 21:32:51 -0400
In-Reply-To: <20220510105113.1351891-1-chi.minghao@zte.com.cn> (cgel zte's
        message of "Tue, 10 May 2022 10:51:13 +0000")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:a03:331::31) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c7482ca-78ee-49ea-9db2-08da37a529b5
X-MS-TrafficTypeDiagnostic: DS7PR10MB5054:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB5054B26968F8CB9C8AB6424A8ECE9@DS7PR10MB5054.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v27+UPaBC+gijCKCmiz3v7z7OaTzwigsh1ePcQFLIji342h2EWw3janqSk4j67Lf3LBZktubGLuwkz2z/Yd/xhurNk8hhMx+DQEYSQ/5IderwvMk9mZDBzJQoMIq4lyCoex0vvVQBH5ZoVVKdTY5eJ2hzU+2eRUSyxS0mp4Kew//TfA3H/TKeXIivkMgFzfnmh3ilE3CScnwXSJ1M5LFGffg8mHU72QeXeFOCs1oIUyeJkmw0lnOELDKx2oLU+aug1oj0JMkIZtMhRdQ8mvvxc1rJFurdAoQAEaDBng455l0BHgEERmPNAFqUZG3YrYICvkcUL4oFUE5///ufjySd5F/1aAHd7sbGxnVCMUaRQZTzKfv2QjW1L51VS4jXWJXMhZjHr/2WBvW3DR1P74Ud6FhkeGD+4xBqlWaWk4cLgus/dylmePDGqg5SNywSqFnyuY/RMQCyz2JMfDuMq5Ea6d0dTC6QJ4bA73dE/I9yNSxurez70cqldfQA+HJKfaTrKmHlhRURNb7LtVqcUvYTbCL0vFCnB8sxOZ/nUYSjPvmQzgfIIP/T/zaHCvnDw7oK/vSSgial0ZERyhivt10pxYbiRrtMTD2o+aKC+hnrFmiqBgk29R+rmFlbrBsHnJFzluXaNnL376XwGcg4Idiatv/OzJTIPwF480BXsGRtrL1o5ksWxNc0fDEbobB4cs5nKZDxLRuDArQ5hVTGIhoFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(186003)(558084003)(508600001)(6916009)(54906003)(316002)(6486002)(26005)(6512007)(36916002)(52116002)(2906002)(38350700002)(38100700002)(66946007)(8676002)(4326008)(66556008)(66476007)(8936002)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oZ+8jXunQriZeOmZ8Ub3GYkSKTDvGBYytHIL4jCtdJ58BSdFdMTaPXYfYqER?=
 =?us-ascii?Q?/En4fm7KGYL33xfM2+cQGS41lfdmy0OHqy856ohDGZGDGD2RmxqfyW5+tKdh?=
 =?us-ascii?Q?WfTzPlf52kpsAi6XhRHNtN9NYsftABpYRhzdxL3JOjIPeW5O1v42EcUHJJVG?=
 =?us-ascii?Q?t1IBuaKZw9EkLEDUKCm11K3NfgifHwCloK+nDYmfqZaeRNk2puKj9gtGCgnr?=
 =?us-ascii?Q?/rVfjvIOmPSoOzgIhhWRwyJQeo3IdXEdLtihAItJMqBVFSNtBRJzX0G4y/ct?=
 =?us-ascii?Q?+tyxVSCMlr+VSmUqfVc1eHKYP0xdMZFiH3Hd1RBM1l4vNEyI4vwEOA8uzyzR?=
 =?us-ascii?Q?yr7Afqps/y1p7BfblrMUFrxS4sGRPeSjTOLJlS9BVtld95f6KXhDsBindewR?=
 =?us-ascii?Q?acvqPORU+vY/rbvTRYrOY+Zj1JCXB5F4BjYG3o76ymeJCxuS9uQqvxo+F3GY?=
 =?us-ascii?Q?YBz3+4h+0exjmUcqTpc5XC6RL6uhphch0vSs337a0tCByiDp2LLKphOThe8H?=
 =?us-ascii?Q?pBAkhcH5GaGrDzkGw8L/dmMnoFK6jvnctuZPd0qd9VVp2ne3xYq8m/sW50rB?=
 =?us-ascii?Q?t8zzPsSrOq1h2MvYRDH3BeB/+VjGH/phkPV90+bPU05BhD/6vrBdIOXyivjr?=
 =?us-ascii?Q?I+1+SQp3qjOA9QYITJpUQ/+qwl5GFEJGJZ398daZEckX4gsKkZ2ZbSprC2H+?=
 =?us-ascii?Q?e61xgpRYGh3k8XQiwy1gB8lPCRXkuaC/Rhr5PtaKlQkqI0uAoWeae6l46Rx+?=
 =?us-ascii?Q?202i+DYIg560U5vfOxVEjODzbWI9ttxlb1wYlTLYHpHyq6QD2LoDUvK1cp62?=
 =?us-ascii?Q?tzb/ZL4kZRZ3ibR7GaIVxc6wbl+lRi7cRMoKZef52MDB4adan8uVKR0gqG4L?=
 =?us-ascii?Q?PsDEu6dB4k6FobLLUkC+5q82lTgG/k/2pgxcEkhO2fFtPmn45ocgj2p1SXiq?=
 =?us-ascii?Q?FE9zQk7t9SB7Bf05UDjJqATZ3MGdTgmtk8ffLIqapwbrbin5b7kMgd3wyAyC?=
 =?us-ascii?Q?Y8rFNesWOFrXhJ2XyIy94YRT1yU5QYtDAJs8X39GDiKBZylS2JmfRMrXEk8D?=
 =?us-ascii?Q?AGQaCRwGKCJVzVq8Ni/91kHt1yyOPYmfg3xcpY8zZ6qYOM2JcSpspL3zfEv/?=
 =?us-ascii?Q?Cm1YVV6+TPkB9Psxbgc512ZFuf7p15RdCExc/B9I840nFnJzBPZlz2sUWjPP?=
 =?us-ascii?Q?7tfHqFSblrU0S3vy3HHnb8FD+7ObjOjCFgNMRnbynKrv71Q4s41nP5ppxHur?=
 =?us-ascii?Q?IX++B2JAwwjtMzJxUTratfQzWmwgMprPgXyP9fUeBKUc4cBGuEUIZ6IilPqe?=
 =?us-ascii?Q?1CbN06mY6rvkr6eFQ4f6AMurs+Yhidh6TpbVQQ94W04SjQXjn/PD9+YN3gqp?=
 =?us-ascii?Q?idcyb7501FG1zMTFyKmDJ1yCHWVVbDEi9Z24ekO6ycX0t4zDf/c/NfyOui4Z?=
 =?us-ascii?Q?mNCe1cVSzrMMqWz/5BvrfLyyCDjbHLASiK7VCw6/9m633Qab0U3geYvpDPia?=
 =?us-ascii?Q?QTcLryrfZ9fcdHk7u4E1zAKFRPI8AWJK/6oZoKxX+7g08tc+dQrMeBMtzLXi?=
 =?us-ascii?Q?UZaBbLbz6u4CT15PYup+UFB+Pu4oFyv4g2waCu5n/9O79X/hq6j5Ntn8hM57?=
 =?us-ascii?Q?+OP4aF244Batyax4H6y3/LoPxuo/tv7hCcHsgeUSH1xEs03NBRQD32M+OScO?=
 =?us-ascii?Q?jkdBB3FPVYrCOU50xiiRGw6DLtAbB6iGuzZpySje6onkB5mnAJqHMwEF3YJZ?=
 =?us-ascii?Q?kPH+w0ccRkjIw5HWDiQY54M1YohtDLI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7482ca-78ee-49ea-9db2-08da37a529b5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 01:32:53.7433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Sw3QVP9WZlX4x0cRwoOj/ny+0IqV6I+vneFI2bboQ6m00+1WWW6dTUZUMyBIP07tqoGrSZgCNfITMXK56Y8lc9pOVS7JL+5jpku8aoD7j8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5054
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-16_16:2022-05-16,2022-05-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=546 spamscore=0
 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205170005
X-Proofpoint-GUID: 0OawUm9SM3fF2f7C4AzoTgZCShGlSJ6L
X-Proofpoint-ORIG-GUID: 0OawUm9SM3fF2f7C4AzoTgZCShGlSJ6L
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Use kobj_to_dev() instead of open-coding it.

Applied to 5.19/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
