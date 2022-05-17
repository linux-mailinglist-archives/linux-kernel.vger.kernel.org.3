Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B09529733
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 04:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbiEQCNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 22:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiEQCNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 22:13:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF2C46170;
        Mon, 16 May 2022 19:13:39 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24GKnXcC019520;
        Tue, 17 May 2022 02:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=jmZsZT2VeLu6dQLjAcDF/apkqWa3wJ4XgpXYT+acZjE=;
 b=siGgF/AuP4+bVzeB6EcMvaVy18GVMZmx0yvuleE2z/wS6nszHjwf6HGJ9UvoNCQkPTg1
 FjUWg3/3RH1Df+Cv5ep8iV50iX8nKCzgdRxkX+MXthFDJepzqsRckGR48Sow2J1QFcHy
 o5xeiPsyH5sf4kRKPVCXrf+UaXxWZYB7EQ+eDHX0yqxYknmorMMrJ7zxjupWO6tmXTBx
 8AYlGWagyEikC4uBL3sZaDDHb8feqqkCsY7MxXz4pbFzIUAF8GpxRUNSXlFGuoxpwEl3
 Bo1TvSWppxEStIaYKRaGqTRL/y738FQd9/MLH+27PnomYENVarSwgWfrg+0bEVysa75y 8A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g241s4vs0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 02:13:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24H29lBG004890;
        Tue, 17 May 2022 02:13:25 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2168.outbound.protection.outlook.com [104.47.73.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g22v2j8da-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 02:13:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5uJFslCMLTmdSnlFLgH85rs/rXtfV3tz3eRl6wZE1suV78G3Czyrx2ow/oI51WFhZjSWXB8fURpCsPJABABPBQk3hmrk9w4x92ox7Q5jnd8vR79TpqALUbPfG2j9aqAfsNAH7aqHPbtklRoeyTUIsI4GCi2mz/QiMqfvwxbKDWkC1LDi6lJ2QRAfDgqzoHFnmEqRDKGnrzmoJwQyzLj/qk6SzpcBNU382ZLTz369hf7OXhvHMcw9hmJyCnZ5B6p+LIDaRgFUXnvfdUgTp1P3mGgEfZkJAfXd7KC+zGAz1+9iZSkY4zgu9DDRfXRkHRQUd9WArVzOkX3LscNau0qnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmZsZT2VeLu6dQLjAcDF/apkqWa3wJ4XgpXYT+acZjE=;
 b=ZK4p1t+bvcmQEzbSK460E1wMucxjEL2hJu6j/c6LkQn785EmmCGIb5ic45WYnpNEWGJgdmFUUnYG1GMF0kAsgAm/mvCJ9F0EgGgxXf5zDbtnuVXZPGkEQjK18i96+poFBXJjMVoJF6t923ICCjlRgi0na2ZcSioFCNcjANsTDTpUX957DT7+isjCWeZmOBeYwLAqkWHCbHKXfqyWuFs1PW67ee0bNW+DCsjzdu55dd+Pw7dFcxg8k1Plaeu2s4lEssTeRLG1sq4TGTrT4YkrBXxNbUPZwHfw00xNcZeRnVAa6qA/ovYGAqQZ/oAuncmBewq6zUF4mVxz80ZP7I1xOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmZsZT2VeLu6dQLjAcDF/apkqWa3wJ4XgpXYT+acZjE=;
 b=vRSXRgtIj8mevBTlKi4Ohn8njdENx+oQ9nJqpc/NhLnUoWTUjIW9Vda8KvMdKoukmFLGNg/YqDOowFVN888EqbbeWArTBQTPqvDi2Wxe5E5hUMJmP8eSopZR/7oy1gdInJah6vkwedMtwNq+VkUjnEjrIBVddquf90FuTxs0bVM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BN6PR1001MB2291.namprd10.prod.outlook.com (2603:10b6:405:31::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Tue, 17 May
 2022 02:13:23 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192%9]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 02:13:23 +0000
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     dan.carpenter@oracle.com, James Smart <james.smart@broadcom.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daniel Wagner <dwagner@suse.de>,
        Hannes Reinecke <hare@suse.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: elx: efct: Remove redundant memset statement
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1wnekq53f.fsf@ca-mkp.ca.oracle.com>
References: <20220505143703.45441-1-harshit.m.mogalapalli@oracle.com>
Date:   Mon, 16 May 2022 22:13:20 -0400
In-Reply-To: <20220505143703.45441-1-harshit.m.mogalapalli@oracle.com>
        (Harshit Mogalapalli's message of "Thu, 5 May 2022 07:36:57 -0700")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::16) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7cfd7d3-e24e-434f-384f-08da37aad1d3
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2291:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1001MB2291AB4EFC40C00A213376158ECE9@BN6PR1001MB2291.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rOoRbmHRD0G9sAdlBb4WTXF1I5hOwzX54s5W0TeMHWGX/pAlO7Z9RWJJ8FYqGD769UnBnQxg2ow1Hl7kdl78ZBaFvvOq9lHMSEv4OfgWBSww/biaIoJxwDM1G0yGTGBCmasnb3gR3XJzskFLFuN6VKkh/y/c8tsdLtu2TvqzieRrENk0eOhlixczEXk/PqG//u0TwBVUWz+3aPNXnvKV11bBMPqupNS/cIpcEcLA4YisjOp0WwzllaNqG6BIh9htvycHdhRJee0VhdRO4OeUJ4Z+tGPTgQp5qqoolhdXE6ka87evowrUcSXwT/eaN4PspCFsv8+GOoMyhVn1h1FnEAQ+V14snKWs8E+kXSXlZ9hWlfJfjGcep0F7+oQL0g1Xa2VuKGxbpHx6Ys2WpoAK3l9Lk+FnpZMlVoMdko1nbUG0d7itW0aOVZXaGqC5bqqNW9+JgI7tjdxSxqMEGKZgBMO8ot8AmYIZcEPuJ0N1rU9zLwZHoMOvCuSPfF7BzLMgCRSkkz0pinGtnXfapbEL+rHSzkmGMY9PFSQ+BcGpeJ+i7kucju0zRx92GWcopkQtrsahUlBqxydsoTulhcd3cz9eUcXRR0qJKTLedbtHav5B4JWMo4QNYXezz8Oa4cBrV0R0cSW8gTUQJPJGMoj3Brh1fXWpZmHgzxygwf6EdAHyUhpt/ygXR0KSrBnFNw3Xy1itSlXc8jLHuid7eRBtXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(54906003)(7416002)(186003)(4326008)(6862004)(316002)(6506007)(5660300002)(66946007)(66556008)(66476007)(6486002)(26005)(558084003)(2906002)(38100700002)(38350700002)(6512007)(52116002)(36916002)(6636002)(8936002)(83380400001)(86362001)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UMWJRSDcM1P6ggz0dZhL+rpk2yt6XPjQoWL+GtNsuWhE82waNT8eT8drZibA?=
 =?us-ascii?Q?Gnp9GY4frZ3dOtd5D0MqMRLastOTTmVOtUAYDS0WXdH91frfI+IHdQPaOySZ?=
 =?us-ascii?Q?UcWkZ8MQqMKN8u+WvqWAKxHG7iprg2wPsmefnQJCYjKlZCVfS316w9LmLpNf?=
 =?us-ascii?Q?KULY32FxHaaf0I98LFd7zxnnrUkCH6QngU19HQJdTeXmWDJk+6MV6TWi7duL?=
 =?us-ascii?Q?tsBpwHhWj4VXL/ixEmI4cq+/y8I73Hx6wD5JDObGaxMYD8p5eWqLEo9diD8P?=
 =?us-ascii?Q?OSANW++3cDB0BrY1nWgDgur1Ba5CZjqJ1DS9gi5ewhy/pxskTZBDUoXPdagH?=
 =?us-ascii?Q?2199UoYzQJAGAZnytkLsrg88X0BtknCyH7moNDlwD2NTDGuvHQ9Sb/ktD5DY?=
 =?us-ascii?Q?PyGH4ZDNnxESZT2/nH4y6ne5kyggEspAM7uN7TNMPIU74K0mDdgPc7mLFn5d?=
 =?us-ascii?Q?EI88+/yYppaZUijUNsIJ4/NT5O8GTCeox8c01aedEVEBh3Vp49H8VhYhPD5W?=
 =?us-ascii?Q?OYuCGhr3ApcyIp7/BipXowLt/nOjCGAInmLvOGpi+cw0ZnHeQ1FdDstfIytJ?=
 =?us-ascii?Q?RYuO5zAnZPAu87B04RJjlM9pMqZYOD3LlX5ZsSGryQC7O3x0GkkVSbV38Wv5?=
 =?us-ascii?Q?eZKm3oB8xX6kuKUhBY7lMEBKVYYfTploPiqsXdTAu6HxnBvr8i9m+sMhUOQz?=
 =?us-ascii?Q?XqhTRCRc3yqxtG9q/yngHrXr9WRZQC6FrfhRSsgxUACRP+VoYNN26FMoyx0g?=
 =?us-ascii?Q?iXcjrmXsQhtj2L5UKymE+VaXjfp0fFeu/M0nO9xoc9R4ZKewhTxHj1iUgJBi?=
 =?us-ascii?Q?5sSi2M2Ie9GVTp+MqCd7Vom62s+hlQg8UCdihc1kXt4fikdux1GThk7Z8eNv?=
 =?us-ascii?Q?6RTTrjhsHCtIE4d1q9pBxSako4oBVdiczLuuRE9QBxYthpjKLtVeL8YhVHs4?=
 =?us-ascii?Q?GNuJIK6ou6x+TODpDGf3AcYdEvawWD3v5J6h6EJLn0Dc92nqmYbhR99x+1AZ?=
 =?us-ascii?Q?0bHv2E+P4M7Yu+VhoCVDzbfC38olmMYxAtEbUM+Y5f5FEqt5s8yrXKcbWhI2?=
 =?us-ascii?Q?WzoPdWbLWqIQ47C5jxvltJIqoSuH0W41bSxFb2mBtcY2hGymPmmzb3Y1/T6N?=
 =?us-ascii?Q?e4SDhruIWzrHlYxA4SCFjZ1gYlh75Ft3d7VJ8l/2RGXoSQN76j28Z+UO7O+d?=
 =?us-ascii?Q?OQCPVAnCkjwmaBun8eOIqPpbAUfK3bmEo82V5E9Yn4J65SjEBhfsvHHirr9Y?=
 =?us-ascii?Q?xRLwGrgh5OhHb9ZGnrPkpEWM5kf1eRFbhSw3fjtQSwx5n9FJJDOmwWEO33Do?=
 =?us-ascii?Q?w0C3boiO7iD0ZEGnnK41lrI98QmaXDc3aVuISpkXvcmCGdrlQSoY7qGkZWut?=
 =?us-ascii?Q?HQjbmCMLoZlW9GXsKrKbZnvkslRevMuvjRaPJ9aArf+2zp+qN4Q2Mo+VWM2p?=
 =?us-ascii?Q?o57e9mWqytnPovqdVVkCmGIMtfJs2dzGUk9F2t3e0yS8W6DYlLnxneMUwf6s?=
 =?us-ascii?Q?fL0QFS2KXwfro7VTntzB9m5TN6zld7x00o3ZX6uc8ms/lM2W0TrIz2QYF/iI?=
 =?us-ascii?Q?dHiBh7jIxddV3OLYCS7Ft4so0r52XYGJPg3qnZd+1hfR/gDpLWVn/+Na80lz?=
 =?us-ascii?Q?OijwlsrFS6Esv5C9Z808XJkBPNKoCGSoaYsAlMqW595zvgwzw5DwjSruC8pk?=
 =?us-ascii?Q?7sa2TFSx27KxwQ/SMVHZb32cRXtIykF/aduWdP8tH2XCiux/ETrqnjHLEfdU?=
 =?us-ascii?Q?Zc1kY73rWUq4VciQ3lW7GCy5r2dx+fg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7cfd7d3-e24e-434f-384f-08da37aad1d3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 02:13:23.2157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZKpN8Zkfk9BFMZYjI+oHT2qbwQ3OkcntWqqIql09sbipiyHMdqBz2WBV89nzzFtQOkOhM3MI55/Cy0mIBgEv6QdD9rMyDoToUSuFVchsyN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2291
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-16_16:2022-05-16,2022-05-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=805 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205170010
X-Proofpoint-GUID: YH3Yem_9puyAIS4w_IwuMsQMnrXhhmDo
X-Proofpoint-ORIG-GUID: YH3Yem_9puyAIS4w_IwuMsQMnrXhhmDo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Harshit,

> As memset of 'bmbx' is immediately followed by a memcpy where 'bmbx'
> is the destination, memset is redundant.

Applied to 5.19/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
