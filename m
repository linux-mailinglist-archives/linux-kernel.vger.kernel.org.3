Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCF8540480
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 19:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345427AbiFGRPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 13:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345406AbiFGRPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 13:15:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF91C102779;
        Tue,  7 Jun 2022 10:15:15 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 257F98Ht014271;
        Tue, 7 Jun 2022 17:14:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jS9fEPx73JegoxubOGtNIRpS/Cx59q4kPhWlIscIha8=;
 b=FPvBJPzRhe/ZRPCqzCEyp8nOS82J8WanNgTIeJ1qwUxnTTqgS3jITXK+6JHd1y2UZBPk
 ScQXe6A4ECwNBoKmFInOmhoXBdcvZV/qc5Kku5EmHN1Z7ALf/iXM4GjQbKuefO5TLp0A
 PccPh6uMOwLW0phHIfCBDW/jqkC9TtyaqtvgdpFucn7zX6m21qhwqTtkAo5u778IDdM7
 5sRHkEBGDY7ncup8UIPJPVNgRoaId0gkVZNtPaS9DinhXCpQPP+aBCpLOV087fw5XSXy
 2fFnwyeBjWhk7h9bLDTraqpGJSNR6xNNORXNLGY+ZEg0RSRf/arpzmyMMUrblBxDDWlr zg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ggvxmvmu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jun 2022 17:14:57 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 257HBwVN012521;
        Tue, 7 Jun 2022 17:14:56 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwu2uynx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jun 2022 17:14:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECyjfdOZHYV4xcmHmkKAu3v2Oc0MuZwR6pjO3THtwlqz2ySv0i7PGA3YES3bCpHF5WCPF0wbhVVVSz+m9UTXMl28owDjwKkhdOjrvN3X1Lz0EWanbzyU6gv4sWaKUdOFdLN59+Ri7kPolBR2JkJUNnPwk36cj/QWxKVYf6LszENa8GtU/N0Tl/GssRyzbWWxCP8u5dIbjjz8ViirlGFQeyZWjMjsLdZ1KYQVe5Uyr9o1He6QONdaTEtJE1mB0A7vPPckeAFL16bP3b5ueN5BLroW/bXW2WZrqfGg5ybcszALkxOOTbb7Y7m44Pv045vzza9wWFq8kqRhOVD3clXYQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jS9fEPx73JegoxubOGtNIRpS/Cx59q4kPhWlIscIha8=;
 b=Xxe/4eBUgIM5FGqdDoEftmSmkIELd+lYRjNE/tUBsZ0B6TnJeyP0Ry4XZmYHs6e2D7a3Ybw7YELsmm1l9g4nvVwY8ZdLDdGLydawISuZyb2IvRx0W5SLiofG5Z2KuhRy2WNb1qUpnd9vx/7dvqNkxhvrP7N3Ia20wWB+P27sGvJPZ3ejzFCyNXm+ReO4fv9MS2jX6d8m3DuTjtjK3DwW4dQBid9zgf8G3bm7oe87K2lxHkXLsS3kD4wXNIuRLEvrpeSiv2PRSy1Yw0o38w1vofsLvWxkbY3XSyE6/zd/JDU4ac1m8VWtOrlZfzc3eWdeZzcFf/lFIBg5gaYQAiIXyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jS9fEPx73JegoxubOGtNIRpS/Cx59q4kPhWlIscIha8=;
 b=uPbBjmAfR7W56pMV6vj2WHGKW3YvZDOLMrDmNsDqFj7fvr/RgTkORooqoeRitlE+He1S3BIctCDFELqJ48nlvusAvKToqZy23MldnF5rKzSl6lsu9sNhXo2kK4NGhN+Gi1YJkMs4jIQ2nl3tm1S4sA4uoaSSh6vhUVhqPlRSPu8=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM4PR10MB6038.namprd10.prod.outlook.com (2603:10b6:8:b5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.19; Tue, 7 Jun 2022 17:14:54 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b%3]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 17:14:54 +0000
Message-ID: <84819d83-7e96-be79-649e-e367592ca05a@oracle.com>
Date:   Tue, 7 Jun 2022 12:14:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/1] cxgbit_target: Reject immediate data underflow larger
 than SCSI transfer length
Content-Language: en-US
To:     Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Varun Prakash <varun@chelsio.com>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220607143035.29541-1-xiaohuizhang@ruc.edu.cn>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20220607143035.29541-1-xiaohuizhang@ruc.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0157.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::12) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37f434ea-cbf7-4005-dba2-08da48a93d6a
X-MS-TrafficTypeDiagnostic: DM4PR10MB6038:EE_
X-Microsoft-Antispam-PRVS: <DM4PR10MB60382F5DF5F6CE263E0BADC1F1A59@DM4PR10MB6038.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QOWcR2DZXpEx7BLjmKb3T609iLn8DzkAuTytr/c5wmFP8aRebmXh0PtEN4Hmy1qyvH0ZdpbblOC/X84+mQ8o7p4OLbaRm8BEub6yiEXmI8FVTTxnTpBhdb7yKqpDifG0NLPtmjQCmxyfVl/FIFEndVJL7C6Yj7hZ8BaWkU22Gj++aWKRJZ1a5dB/l89X/Qp5ZEUGY+1lsjMvl4IqhVzvfnh1DIqVVDVU25VCAertxbA8mGMGXR0+qQUSqh6+zB6ElCbzgIXiYgLJdkGygjiWLnKbhfcoE2dk8T7rrHZe5Mc2AA5NULienHqLie3FmTOI0mr+/Lvk51vX2Zud5aCmVMyoYJjJQJeExVTZMAmmeEd3ErtB/N4PQQv3H9Oawczi/rIRlFvjwev0d6gtLRRKe2/s7fRcbBtenUPm8eB3FHyJRPjxJlr4wyBxyAZgPNBvvfEFHhslkhLorJKXrJUKEtR4WLRIAK6TZOnzZ1YyOMsKA3UBHmnBVj5w1jUwl81FupGwjvFrXHqU5Eg73aYS2PIke6grsTlJaJ0K6BII1mdmaMEs89bsr+80Q84l34i6PPDUX35I/gmNdS1/Hh36IcZGHBlpN/TiuwWPp1KzKhpglNPmIdOHEJ9E8ssXIk2IJoTTTQyq4OUVd92MSdz2Fx22RmGW2vnd3H3bka9+Ve3SldYys/CsSQ246IbrVEdP33o2U2/742XtnevVA6rBqy4Jj10K3CppxLuZvz1yPVqI2fBJzzbV1COEpIg0cKyzUP5f/ePegEXpkpWEkIPcAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(86362001)(316002)(8936002)(186003)(6506007)(110136005)(66946007)(8676002)(66476007)(66556008)(31696002)(508600001)(6486002)(2616005)(2906002)(6512007)(26005)(5660300002)(38100700002)(83380400001)(31686004)(36756003)(14773001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTFORzkvampQUjZmeXRvbml1ajZDOUhFZXQ0cXFpS1dZS3R0ZzQ3aFRpbFFM?=
 =?utf-8?B?RUZyTk0rTHFlTTlNSGc5R0Z1bXBmY1lnQ21QKzBVWmtCRi9YampNUlptUldk?=
 =?utf-8?B?UlNDZkJIdnZrZjJyK3hDN2k4L3BZMXliTUZ6Mk9YTWZNM2l1RzZZbVB6N3lq?=
 =?utf-8?B?UEk5c291Q0dwNmFRYktoc2xlelY1ZFUxRitITXdEYmdES3ZTaU1lNVlZLzBk?=
 =?utf-8?B?VjQ1S283ZkZsZk45MEpYQm01emM5OU1XZUlIeFU5dC9udmVMN0twVzdXOWdh?=
 =?utf-8?B?MTA3NXQ2bG42dHBPV081Rm50bGxVL0tkQ2VHR0tpNnhlRHI4Y1duRjlrSTNI?=
 =?utf-8?B?UGovTnJRWHZha2trRmRSZFBGaEI5cXRLOG9vM09vOWN6VHQwUllITTQ3cnNi?=
 =?utf-8?B?Ny8xTVd0eVhMVFA4SXBBcUR1UjRZSGtvZE1iOVE1Mk1tZGpYRWFKQW5ZWjA4?=
 =?utf-8?B?cjRWMlJlQW9wdHY1YkM5NnYxSkRMWmxiVDMvYk1xeTBaSW9pNmpIUmFKMWZy?=
 =?utf-8?B?UlozOHd6MFNZaHI1dlR1dTVnaTNpRnJXR1MvMnlDSjlaUmovTlJlTUdVaFQ1?=
 =?utf-8?B?T0hRN0JiUHh2K1hFWmIvbFFxNGxDMTJvK2gxcHd6SUFIc1Q1RzZwZmdzaVlG?=
 =?utf-8?B?NHpMd2I5QUhoVGx5Z0QwbHZWVjliUVZJN3I1ejJGclg5N3BvdWRwdmF1TCtI?=
 =?utf-8?B?cFJsdjNxT0Z4bE9DUGRCcWVJL1FMYVkyYWs4OVcxdVRRZit0TXd4MHdBUUJu?=
 =?utf-8?B?SEpJeFVERGZMS2RyaFRPMGV0N0RCU25yNHZoeXlpalRjK21wenBCNC93cklC?=
 =?utf-8?B?ZlYydGZxQXowczZFcGdqMWlXaUxVNDVyK2taVDBvaVBnbTRSbGdPUzQyVGhK?=
 =?utf-8?B?OG9HUTM4bC90OXpVNGhHVENPczBTcHJxS252bU9NN0cxelpEbUZ2UDI5MFJo?=
 =?utf-8?B?YlhXOFZpUlhxQ240aHpKOHN0clBLOGtWcnRSTVJkYmc2QldjWWczZnlxMzFN?=
 =?utf-8?B?dXpBZHV6WXNtSzgwQmo5UFlaYVV3RjJKYUxoaDRqWWgzazExN2YvckJHVjlq?=
 =?utf-8?B?TnVhOUY1Ry9XbDA5VU8vUlEyaFF2MkRFd3Y5NWNWUVRQV2pBRWx1NHNkZXlv?=
 =?utf-8?B?S2JVYllYWlpXNlJYY29hK2hRcERWbTgrdHJhc1M3b0xESkdDY2hSL1dndGpB?=
 =?utf-8?B?YXdyL2VEam94QzgzRUNHbXJ4QUtuR0IzakpiRjk2WWxBcmtxbE9kTTVYVGxv?=
 =?utf-8?B?VE9HbENtZVZoc1B1dS91U25jdldMQ0d3WXdTYmdpV1ExNUp5M2ZycWhOa0Z6?=
 =?utf-8?B?N09GZmFlRFlwcVRSVGxncElvQkIvcS9acHNxc2pIVjMrMDZKZWhFcEVSMUpq?=
 =?utf-8?B?UE5QWkZUR1NmNHRQNjBTVno3NGxjNHBPRzhNUnAwWmxDbVA0L0owSDJXQnNo?=
 =?utf-8?B?S2RXcE9aYmxwd01oL1pFRVpiMUhYaTU0dmpHK2ppVjhIK0lVT1ZXSDgrUlJQ?=
 =?utf-8?B?YVpDQU1uOWtYcVY5S2xQbUFDSndGNlhWaWMxbktINVhLcTVzcWJ6YjNxcldk?=
 =?utf-8?B?bXdsOS9JQ3g5cXFaaEF2R3gyWU14OUZaTVgvcmFOU0xjZUwyQkZNblB1d0Fz?=
 =?utf-8?B?U1hVZGtBS0xTbVpwaEVWQUVlOTF2TVpNTlcvTXBsdlJycEFkQTVNZzE2cUpV?=
 =?utf-8?B?T3F4bVFXWkI0TTFuM0p2TzVRTnZhZ0N2V1Z2Qk1KTTdSd0daL1MxS1FTeUNE?=
 =?utf-8?B?VFZCdjJVcTZRL1dVcXJyTXM1emZUSG5TR0h2eUhKSktKYzJLTUJvYi85VnJZ?=
 =?utf-8?B?RmhUcXdDeDlVSGYyS2NqY1lnSU5SS0RpUDJ3emRCcWVseWxQdVgxQkJpSnpJ?=
 =?utf-8?B?VGdYUFFGTUlkelNrWlpTUmR1a2FsNUxXNkhUYlVya0RDa1Z1UTdjdHFUYlZv?=
 =?utf-8?B?Ukw2SkNKNXdCR0hNVnc1aEI0MG9FWlVXOW15RjNqTkZaSXAvbWc5Qlp4MFl0?=
 =?utf-8?B?QnEvZ3loZnovY2VQT0R2ZlRBRGI0NHk1NzlMYXl6NmQ3V2VTUDJ4L2I3WGVp?=
 =?utf-8?B?c1ZhY3RTcVo4Z3hZKytZZUlIYnhNNFVHbzJNb2ZmZGZvMTJmazJFekJPSFc1?=
 =?utf-8?B?aFpTVDhaeWdxM1VxWlZRYVV6ZmVjU244L2lINityWm14OWRKb3hRUzkwZk4r?=
 =?utf-8?B?VUFGTnUrSDY2ZkM4U0RvWmRVSUhxTmd0eXAyZDBJTFczZ3YwUXJySy9Zc3Js?=
 =?utf-8?B?VHc4NW5CalE1YUxMOWFJU0w3UHhsbnk2ZnBXTzFady80OHJqZHdOazlHNWRx?=
 =?utf-8?B?K3NEZDJNb01HeW4xY0lLQ3hCNWMyN2xZRDRNM3BvdHY3bWcyK3dwSkZhRW1Z?=
 =?utf-8?Q?M9gEsri87dZleIlM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f434ea-cbf7-4005-dba2-08da48a93d6a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 17:14:54.4526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MTkAluzxEbPP/jMHS+5GGdVzYIk5EXtKaDM0Bb7WlZGZpayqQoGLQgMQPZmN4X38obUUXctv5vKOgr5cI2j1jAeVBNras6XLA/Jwv6ciHbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6038
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-07_07:2022-06-07,2022-06-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206070071
X-Proofpoint-GUID: YkuZ6NT2E-Ok2bySaftjjuqlPmD1Y6li
X-Proofpoint-ORIG-GUID: YkuZ6NT2E-Ok2bySaftjjuqlPmD1Y6li
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/22 9:30 AM, Xiaohui Zhang wrote:
> Similar to the handling of iscsit_get_immediate_data in commit abb85a9b512e
> ("iscsi-target: Reject immediate data underflow larger than SCSI transfer length"),
> we thought a patch might be needed here as well.
> 
> Signed-off-by: Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>
> ---
>  drivers/target/iscsi/cxgbit/cxgbit_target.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/target/iscsi/cxgbit/cxgbit_target.c b/drivers/target/iscsi/cxgbit/cxgbit_target.c
> index acfc39683c87..800bec4b1e88 100644
> --- a/drivers/target/iscsi/cxgbit/cxgbit_target.c
> +++ b/drivers/target/iscsi/cxgbit/cxgbit_target.c
> @@ -920,6 +920,18 @@ cxgbit_get_immediate_data(struct iscsit_cmd *cmd, struct iscsi_scsi_req *hdr,
>  	 */
>  	if (dump_payload)
>  		goto after_immediate_data;
> +	/*
> +	 * Check for underflow case where both EDTL and immediate data payload
> +	 * exceeds what is presented by CDB's TRANSFER LENGTH, and what has
> +	 * already been set in target_cmd_size_check() as se_cmd->data_length.
> +	 *
> +	 * For this special case, fail the command and dump the immediate data
> +	 * payload.
> +	 */
> +	if (cmd->first_burst_len > cmd->se_cmd.data_length) {
> +		cmd->sense_reason = TCM_INVALID_CDB_FIELD;
> +		goto after_immediate_data;
> +	}
>  

Do you need something like Bart's patch:

commit 4b3766ec0e1840f45bc9238e7e749922bdcb7016
Author: Bart Van Assche <bvanassche@acm.org>
Date:   Tue Apr 2 12:58:15 2019 -0700

    scsi: target/iscsi: Make sure PDU processing continues if parsing a command fails

with your patch or does cxgb avoid that somehow?
