Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656344FCC0A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 03:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238786AbiDLB6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 21:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237791AbiDLB6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 21:58:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F045C1CB24;
        Mon, 11 Apr 2022 18:55:57 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23BMg7dM001710;
        Tue, 12 Apr 2022 01:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=AvBPiGmyWT/nQdc1wHVAzo1FCC6tQab2/jSaRV5ZJbE=;
 b=LEmsvp8JfQsGa4s4UfYlJ37A2rUCx1q044cQv2soHwNpMqxs8XQbNjMmWJVafr3ARCDa
 NsjD1SlCjB6hW4TLpu6qR9rCU8goUUTeyQsikBEmFMSGE6iEp4UGhZeHcAp8HUZEkR3s
 KG+zpykMEfG13sw5nUn4tG/rkBm0obVGEZQsLJ5HaGuXGHuc/fb4JuE4J8NqWbSgQmHT
 WR/TYzzSLLKjW5eu67FT8Rhvm5fU+e5ud2otJ3wuuHnb8Oa7QG+qLlhJxGTv9BqiESbc
 JqtrM7qMV1faFzsTwU0i40d4qc/1Hr2u3YWG8edho+GWSVOgr/rshB8gww/fCBvnzzj6 vA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0x2dd1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 01:55:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23C1aNeY019361;
        Tue, 12 Apr 2022 01:55:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fck126869-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 01:55:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jc8myNq99E4ujmfY5BhH62fpS6nqvS9BgqZVq9ZtJCMuxfB08rX+Z1aHirgdnWtSTGWXQzbC5xfgX83T8euLeysCFc4u8NqhjayNZeSkOFQIrC2Wg/gyxTCuWjmtpvzH3dq+VFxOa/Pv/1Zi1QZfIaC12wrovepMA3E/dRZHPFjAaaK6JA5e9lJviqAuZSZAFMcGphAT4Yxf97SAS1iAXpYuewKfXllmIKDLWRTZMQbr6QCNjxTk3k3/1Cc+qYJXd80RQkoQLNjkLmx5MPVf5eYD/pO3ctSSI8RL3LLJJp8SLKC8byRmQmpothKGcs6zB+7l2OAhg/7f+Fsm4d9vsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvBPiGmyWT/nQdc1wHVAzo1FCC6tQab2/jSaRV5ZJbE=;
 b=Y7I6/SD2bvGahIzysvys+YObspRgbh5ax9pQ9O1NdQJHVE21yDOoKfBgxGPoTebFCFmHTiD2cxp89Jq+MfVqi0+QLB/7BWpnKJO2y4a6ikhe9RhpJflM2vnASLTJxWyVf+Whax1kw3+6C2sUeermf2SEmmdxIuMI8fJBDFnJ3hAl4XTgatwsA0HCW2vyQhcShVw19Vaf3oSae+P/tEsl/dR/gjoaSNgqxggawwKbwufDubdyxEqOMX/JmwFLBQCsvmY028Ns2bsplruoGNwChIOj/95FF8jzt3nioG4p5rsne3d+AqykCDiDb3ttO48XDQLHCdzer+Yntz1pxGgTyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvBPiGmyWT/nQdc1wHVAzo1FCC6tQab2/jSaRV5ZJbE=;
 b=DDvzp7Qt5TElRbJz+eR4nVQnqA6szi7PRnowg4Z5Uta6vd0zcCA7XH74YgM9D+9auruqrKWn7Td2NgRtZ05EvXzOEIf1Bc8wPoce0+K8HwaVjkzjT8ab2DGk4/SowlttG+4v67GJB5chCEpm/3LgYxmq+JeIQh9m53/nlNeUm7M=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM6PR10MB3947.namprd10.prod.outlook.com (2603:10b6:5:1d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 01:55:51 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed%4]) with mapi id 15.20.5144.030; Tue, 12 Apr 2022
 01:55:51 +0000
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: megaraid_sas: remove unnecessary memset
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1mtgrawv6.fsf@ca-mkp.ca.oracle.com>
References: <20220407072442.4137977-1-wanjiabing@vivo.com>
Date:   Mon, 11 Apr 2022 21:55:48 -0400
In-Reply-To: <20220407072442.4137977-1-wanjiabing@vivo.com> (Wan Jiabing's
        message of "Thu, 7 Apr 2022 15:24:42 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SA9P221CA0025.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::30) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f0d2b76-315a-4314-8e57-08da1c279269
X-MS-TrafficTypeDiagnostic: DM6PR10MB3947:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3947B9FE4675E157744030478EED9@DM6PR10MB3947.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yUT5PkG1w8ST+/jj4O/1iyUPBLZA3/YQ+SZgxR2Q3SKOXLjAv/8S7ps4B6RaT8kpJ63k1OQ/2aTQB7DDUxSFkkrM2ljvKM2f9ntXNh7lji9IInCB8qCs3+P3+ilFbcJf4AoR9AudQd4+OuesPhWG1n+wtEKz9MZbwix98HWsFfJa99aXIWZ0hWKa5AwVvp5oDa1757BNM7tkBaNjCv1Zjz6fFjS6RRCX2d6V2kyeBJMIgm5E35bpwJX7vZ6Wcw6+hc7YUhl4nJvaClM0oErf0g0GYYXHt130bNoeb1WavTysFfvzzOjs7gp8Bh5+nzdy44BBfVNVbHTQj9hzTkYm0lNYqe2pda6oUeAdQd2HEizru1DD7ige6UkDgpsfSBg46tetQSJUQ5GfvuLtMhlUIaOoE+WUT06h8l9eiP7Cl5DX94/+5mi8z3sATe3vUH87kerE9wwal+PGVvQ3QwC3ChBmIOaAVuDsal4HvnEajbGZWwvGI26iwe4PvueY5cb4lI4ROsAz7d1xgpYlgpnI4J80krQ0UCeS3s2qP6Fd0mfMOyMomeNVr4ZcwItCoAS1lYd8qFZa32+5SonLoM78STbcmtnXnySvHTvqnHAunEW0Ksc3nLAtJrk72nhWxqOBKz5KUzLcGDEzVWmOOhe7+U3B2m0EZbI2S0sgjSjpzcRASvX8pYzb2yaSe0w84d/B0ZxupH6c8S3X/TGovoteqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(66556008)(26005)(66476007)(66946007)(54906003)(38350700002)(38100700002)(2906002)(6506007)(8676002)(6512007)(6916009)(6486002)(508600001)(6666004)(86362001)(186003)(4326008)(558084003)(36916002)(5660300002)(52116002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JMGrcvyyFnHUA5RUqDGtrSPs9r0jpWzpsfNZYTlmaMHjZjs7jv8bA94X7CRd?=
 =?us-ascii?Q?5QpUOeL+JixselXRciGWOLhCRZN9OHujzBz7wetDhA8tjYctm4AGOle5Fk11?=
 =?us-ascii?Q?faN50Fx+xssKI0mjGthwozzhdKSCARt1JdaurG6+swY2PqTrWynjlVhJE08W?=
 =?us-ascii?Q?juH0tLWfr33cwHW1pA1NptDE3DBvJcSXGLSGHrsSNMSVuiNJOu4PpfPyZWZk?=
 =?us-ascii?Q?7H7wkGZ4Yl5NzY5zqFXd1xeBKXqPyu65YkW9wczGQMPMPg45R8npJzUu7cHo?=
 =?us-ascii?Q?Vnf9pejJSRJn8k2AvcqOg1Z2nhrIsdu9JBgRahNCQrawXxNlaZ7P/EHGgRYQ?=
 =?us-ascii?Q?eX0uAEVpqmE2s+WE2l0jM9DXIR0ThnZ4anXG7rt2+a/fHGE9U0EicuVUYIsy?=
 =?us-ascii?Q?75pKve0Ro3n0ga0rtIb9woK9iiiB7EViSrBlQrOTRVZnKwRVOf8nM2hLPSHx?=
 =?us-ascii?Q?RlQre0MkbufP2k+kUv89Wrc7FeWZyq2/hBL23HsXsC5VX6xrcWK4Q5oGUuCJ?=
 =?us-ascii?Q?/foXBkte87ayuY0PcGwOl7djudwQvlu5naJWXzip9Sjcl0qrcWPQLGZF4n3f?=
 =?us-ascii?Q?Mv5Fh2fwBb6+u53F03tjjl8bnnHLgMWhJvTo7wnHI0hE6FQNcijvfVQU9jKa?=
 =?us-ascii?Q?rd1wVKkIpl9KK2m8iI4JY7SlbXqEgt1QBHZ0MWInqxKmOdYMXUMpKd9YOitB?=
 =?us-ascii?Q?Mio4Ilv0dxxxMqckT6BYCIaIDOyPNdOZ66ijOaHVNsBTepqZ5j3LQ+aRUmno?=
 =?us-ascii?Q?P/yfCeIKpzfkNeHy3JZ1Jqjl42ijWq16TG89bctgxctVk62dWtgwBZZbwSka?=
 =?us-ascii?Q?yp0E33MsRP4PbhiHTiJyEW1R94TIHsW6o433R8sv1MXpUcb0so3Fyuv4MfAn?=
 =?us-ascii?Q?G1uE304zK1QcwMW7CFGFtxVkv1NiswVm7bw+03G8Gqj9Ev9T3xsAj1LEEP9b?=
 =?us-ascii?Q?8T8dG3skBDm/Oum6QagT8msUt5hyhki5l98QrG6W2SMOxwVesqyb5QvJ2KpN?=
 =?us-ascii?Q?foKCWVuJJ7SvvwVVw7pcKrpkoi6AMpD59LvKOWbbiFb+jFfh9JXIUW5H6ui7?=
 =?us-ascii?Q?rq9pm8hKrdYJg2xqDQmp+sTduam3IxVGuEft3/CYEc7ZzW+geUvIX0j4l/jB?=
 =?us-ascii?Q?zUZtOjw9kL2uMqsB06Wu7Czx4O0FrALLsgjfkebgZmejzW+7J5eQfrzWbKpt?=
 =?us-ascii?Q?8nCL4M54BOKHalxG8tAmDkIjPZdT2p3WUVavB2svleGtQNrQ42BYANy/gEvD?=
 =?us-ascii?Q?mMlpPFZtpmfIxrX2ETZWkFrWhJhtTsz/WlviR0mLj31ejGgMTfVDuN2E52JD?=
 =?us-ascii?Q?6g19zsPt8kj9gqBWQ4YBZdd3OXQTyRxnb8A132fJYVpPQCzBt11Q/7Ysz5XP?=
 =?us-ascii?Q?ovw3GBJu/DtMKQDCQrCB/zKdMYmtlskaik2WS1otDO6JzZkl3fyBTBS7tRXj?=
 =?us-ascii?Q?Ypnc6MTvXJYLYGqbG4yCTLPPBVDeuP1r73p0JLgfzSqWXNEDGYxFO8HPS998?=
 =?us-ascii?Q?/qR6te2hBswDmpBd2XNgFdeFIV6CFwQpT8+64oz7zFBG3Ib727W0Y6Ph3iwJ?=
 =?us-ascii?Q?YYq9PEa2zfKqpMcZYwd1Tj0wLlggnJx7fi1JFHmKkCoFdYXz864WkeauK80Z?=
 =?us-ascii?Q?xUr4TsHlp3FEQi4ij5f/uxGM6qDCwVRb8/iWxtdGWWxK1lqufX7lnsq1SgL1?=
 =?us-ascii?Q?0o+r5+jbhIocfzS2h9hBZY47OW5i0+QW1Iqkr6pycZzbSRD17Va8dGnMpSh9?=
 =?us-ascii?Q?z8S8D5jcRWQxY492FrtWPOVZ/2lZWG4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0d2b76-315a-4314-8e57-08da1c279269
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 01:55:51.2978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SRmiPMzYhzrjRrMzrF1vkbGeI716pkCSXq1LezuuoCgkcvEVbRJ+fCREKEkIIcokgcR37gQ8KhQP4twzjBr7mKpklWHGn0ygZjclN2uwOhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3947
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-11_09:2022-04-11,2022-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=861
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204120004
X-Proofpoint-ORIG-GUID: W2HfCJJxQjA-TJUfh2YxIelzU2k5pIZ0
X-Proofpoint-GUID: W2HfCJJxQjA-TJUfh2YxIelzU2k5pIZ0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Wan,

> instance->cmd_list is allocated by kcalloc(). The memory is set to
> zero.  It is unnecessary to call memset again.

Applied to 5.19/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
