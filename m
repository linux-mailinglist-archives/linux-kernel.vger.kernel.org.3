Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E377571189
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 06:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbiGLEos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 00:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiGLEor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 00:44:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8A52B63D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 21:44:45 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BMYRNJ030525;
        Tue, 12 Jul 2022 04:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=YpOVHdnQ/s1+KhPMk7uzfzj+7s4GS6iRmc/FvHAkzws=;
 b=JI2dfSNb+RWfTIHV6t9IlQOgjRzkB+6Ezy+Q5UAfL9ItA9Xv0OZ5460irV/W20Zj9tvG
 lEc/7bCn1ZinEvcipHgb12tM78wtLVGJeNOwcOMzfsgiG9lGSUf3QKLb7zxr8tLTEyEz
 XRjKIgHSylf/u6U8eYryaV4U0mioJjEHpK01AsclVN+nr0a+DT1EOOrIxeAl43cGbrNv
 cIKhUgludnHbhxJUBAp2G6qg74KaA4XVKT1D2672fPUJ1gLYTSmT8tdxOYX8nwfIsMRj
 AI9edUQM0ueuES4jGGjC6hrNdC8hXymOM1BuekIiqK1dL3cw3YW66GbvGlsgybuOcKb8 Kg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71sgn6e4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 04:44:19 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26C4eZc5017350;
        Tue, 12 Jul 2022 04:44:18 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7042gyym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 04:44:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYMePCF28hrnu9WgMiY/6Wnqlo7qnY1Ulr9/Q2oXKW54dFjBGCPhSy7AAm8xcvF5Rg/+fKZmRD1sDPOMYbf3UuAXVYRIfOYeNE4/qb2by0uiTE5sPS8YoY9YI1nQ4CHw1I3fXQ7KAxNOAWAr/I/TEI59oh9o0OFWvZ4HnBU3NRrhhdXWp3lGvY27cmn5FvO3fp4hnsfSK31tWTCxpb81gEEU1QRexivsahclDzjguxngnvcOqy9IgxA8+iSFQsAcvG+qaGSSme61pL0bAKW64RQ6m20yiZO2yX5Yen9Z5huwJPWoFzBlW7DVs7WqhfL07VqEwMA/ZUyVSSe9frfQiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpOVHdnQ/s1+KhPMk7uzfzj+7s4GS6iRmc/FvHAkzws=;
 b=Udlic8p2iu9K3KOFJyLxdezsbK1FeesTbbw3JIdtIFHQnw36Mvs0tRshUaFD5iSnPqkfygwtU3/uL65vlgLZQgHtfSmefDF6rUzrh+egovJhuigI/jL0vSKbCUNEBI4t03IW8YtZhvQv5iLWe8OS+8CUecU1e/cYnumADbO5KA0ViwUfFwmFrR8iYZYqvqzcDGzE4N6z3PyCLN8838jiBK3ukfZGzaV7alKO4ys2DfhzQHc/NPGcuy1urFCIZW2hozloLgzTprULDR6lfGQhZeqNhFrxHCvgFpdp6V3jBb6gARvITJOatNVY5/1416U8EhExwZPaHgejKYm9TNKKCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpOVHdnQ/s1+KhPMk7uzfzj+7s4GS6iRmc/FvHAkzws=;
 b=lb5PyFWJIjrqfkmvhSYVEJiGpNUJmMVPkrampFgdrdSvWZ0hRvezYJdKuDud0NcFpcVqoDFC3y0eNELPSMKfmkiMOqjscyFwMvOTDERcsdASAo77E8O2/027jrSgfRj/KQtj7i2b2+HV2w6ayH+xCV7Rzot33RjSX6oD2oe3n2M=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM5PR10MB2041.namprd10.prod.outlook.com (2603:10b6:3:111::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.23; Tue, 12 Jul 2022 04:44:16 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::8dee:d667:f326:1d50]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::8dee:d667:f326:1d50%6]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 04:44:16 +0000
Message-ID: <319f1e21-6cf4-4502-ebc8-c808560fb48d@oracle.com>
Date:   Mon, 11 Jul 2022 23:44:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.1
Subject: Re: [PATCH v10 0/8] Use copy_process in vhost layer
From:   Mike Christie <michael.christie@oracle.com>
To:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
References: <20220620011357.10646-1-michael.christie@oracle.com>
Content-Language: en-US
In-Reply-To: <20220620011357.10646-1-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR19CA0007.namprd19.prod.outlook.com
 (2603:10b6:610:4d::17) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1d9d1bb-9799-4f3a-f410-08da63c12d1e
X-MS-TrafficTypeDiagnostic: DM5PR10MB2041:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YK1wPtEvJTelEqJeWz79tqUjr5MgukaXg9EIk+Zhik+amuzNKaD77H5lh4qN6cCA2U2SsnJZ0xf2/iJIJv0dyxyEnsjLZNXh3lIXJ9fTwmig3GiOSWfLJVd+rBybRotcMBiNJYxayItWr/9DhDQmLTQSL3JQWOt8szCZzMjM3QKoFOrIDl/4cxDfKwEHkgFkCsh27zzyVq8oOr7tySBWXaUyduGzAcs8tuX6WvMQr0dz1rbf/0uMMb9eeweyv8GWg3M69TGCqHLlk96NNjvYP0bJ3E2YqK3IM3NKlkatdC9ACSJ9CkGW808Gcsu1i4qu8xHzoKdQLTF6z2NfYlDv1YcFpUQ3b9AwBB0WGrKn0MRfAvXiN1DniyXsVcdqRSQPrU5JJc7W57PeMalBXsEzq75liDvLX7+42TvBRJnCyvXNVHnRKDscB22Dp+t8YWqq3vpsZbJDzYbaWravuzoojVbtvhnxEYQ+1iw0JYsAnMk7rQlMCtHNVSnagAJ3Bqj57u3ifHstNaoOiEcKzREmzBRdFUyE4sfLOs/gII+q6YbP3lhkbHgSLbM5f4UvxgKJJw6qZgb0xRxTS6lKevIwS9zjb70KGC5jA2PmZJ2pqORzlFHoC2HmysyIRIboUWyNXnjgAZvd496XoSf4G3ESZevNOg9G6L3DSFzTPtg/L8qU+RG1bkrc5mSxpISWYABftIwXtR+mh9OR8n1d4TlbRjLuzrK0R0YezyVS4NN3B1+hvaakH6jx278aI7pSBKbP4GHzjMuB0NO95NxWoaU5vc6RO3YKMeZb8ktIc167GJKu5c37wjQ4cpLPpvOTJJvXX5oiL3+t9jGnNXBetts2Z1SU1mWmDo6e0sFlFQYPMKz498KRhF7ZjgCTSOBXKM5DbETFQrqnUe6Tz9iZVRTqmRSAUlBWgpq0QSVAA+bYIYE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(396003)(366004)(346002)(136003)(86362001)(6512007)(478600001)(6506007)(26005)(2906002)(41300700001)(6486002)(966005)(31696002)(8936002)(38100700002)(53546011)(2616005)(5660300002)(186003)(36756003)(83380400001)(66946007)(316002)(66556008)(66476007)(8676002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2ZJMm5OTitGWlRadmdldHZQSnVQUEd3YlFJYWtsYUgzSGhocE5kL0luZktx?=
 =?utf-8?B?dFp1NkY4THIwOUN0MjZYOWd0WkljYXRldVRRUDBSR3lJdityd25yK2ZpUTV5?=
 =?utf-8?B?MmN3RCtqL05aYlU5cGFueDNXRUY2N1ljczRtVDc3aXV4V2t2cmh4MmhQYURG?=
 =?utf-8?B?NVU4c2NmOVJ2VEltNTRXTTNVQVNzSTd4SHA4Qll5N0dLWUZ2L1o2K25BcThI?=
 =?utf-8?B?SzVEclVvc2NjcG40Umk1ekRXV0xTakZ6OE1BVlY2L3YvcEFoYXFtdWplZitH?=
 =?utf-8?B?NXhrT2RiWXJxeHBUZ3BBbkozTExqME42M1gycjJod0RURTVrNUt1dFRXNjg5?=
 =?utf-8?B?aDR2T1poTXBKdjEyMXlVV1N6ZlduWVE4Wm5veWpBL0xNbVZqa0lackJWRDQ3?=
 =?utf-8?B?My8wcWhzUVpITFQ2ZHN2a2ZBeXVtNFRnc3ZpV2haQlU0Zm1vMllidlVwb2FY?=
 =?utf-8?B?dVFqRFZGenNpajNCNHJBRVU5cldIcHBYQnBIYlNGYmJCbVArQnV2YlZPaE9u?=
 =?utf-8?B?eW5rSU9qc3RmWGg1WEc5ZkVXdUZjU1I0UVVyWlI2STBaVytRKzdiSkxlWmVN?=
 =?utf-8?B?YUphMHYzbjZLN0pONGZpV01YM2IwWjhkNVByQWsyVVhXNnhVMXlCOHkwbllK?=
 =?utf-8?B?NFpHcWlCT3cyYjk2amxGOGIvd20wMS90cG9qU1Ird01IUEVIV2xudWhmTU52?=
 =?utf-8?B?UVh6cGpMa1JWWmkvVUtuSU9JQzliSyt3TCsvS1NtU1MzQmRaRk84ZmVnYzFm?=
 =?utf-8?B?VndFOStiRFZENnNTRk5kY2hPRWR4OTM3NnNYbko3a2ZWOWFEUzBuQU10SDJG?=
 =?utf-8?B?Zk1UZFVHekROdlVLbXRzVGlTSnpaL25KU2phbTZFeCt0Z2p5S3RqYTFoaXF5?=
 =?utf-8?B?VzBkblg5ci9ReW1PQXg1bGdhb2VJMEx6M0hHQUlOeVVFWlJ1TXJYRWxNVFVx?=
 =?utf-8?B?N2Jhc0FLMGV2VXNiUDB4YXdxSEFxQzVQNmJWVjRFNWI1L3RjdzFlTXdHSFdH?=
 =?utf-8?B?ZGR5eDlsSHc2UXYwNm9pWEIvbkhOSENOc3cxcXZUNEpLb0h6OWxRUDNmeXow?=
 =?utf-8?B?NEJKMk9LMGhQYmlFcGN6UU5vL3AzL1F5U1Q3cFlRT3FYNWV1RWF0Ymx5THpx?=
 =?utf-8?B?S3FkSnpxVHdnZm9MbkpPcDBxTDNoemYwN0NjdDJPSUtoZlB4VFpYVXNpanhF?=
 =?utf-8?B?dFREZXloSzZsRkZXK2pRUlh5cVFkWVFWKzE5ZGd1TkNIbXJKMjB1K3h2bXg5?=
 =?utf-8?B?U3pWWm1uQ3dMSktwbk9ZQmRwRmxtVUpBTk9VWitPalRaUHpWNlJReUZReTJl?=
 =?utf-8?B?UG82bjZpM05lOWt0VXNiK2U2Um1ZUEtOOWRuUVpOZVc5a3lVNEdENUhadE1Z?=
 =?utf-8?B?aVdzVkdpM3YyV09HTWNzZXlBb2dyY1R1K0I0UVlVZUtnZUZnZC9ndllCdGxx?=
 =?utf-8?B?VW0rSkVQZ1pHR0hGR0hvelA4aUhHSG5jNVpjb3dOR2Rsb1B2U0ZzWndHRWFZ?=
 =?utf-8?B?SXBScUprSGU3R0k2V29iNzQ2YTdpdEZDejVCL3ZJUHd5enZUVGVpcGhFWVQ2?=
 =?utf-8?B?cStDL3VxNXBRWDdJclM0OGoyN0dMU1hSOUwvQWRLTkhMOEdaMXE2dXRxU3Vp?=
 =?utf-8?B?emhxMUN1ZE9jUlVyZ3FtSmRyVGt5dEkrZUU2WHBGOWVqSndlNGxCbnpEMHl4?=
 =?utf-8?B?cTZycXpJcWw5M3hRc3BMQ3dpbndiN1p1QWp6NmZoQzZ2cGNCb3BEWGNSMDZu?=
 =?utf-8?B?VURhaHRWMUdYeG5XNDZMMU4wZGRpOFNwdjFyTlZlVnNVOWxiUDFlUEVnbXE5?=
 =?utf-8?B?Y2ROdGdQQldkQ0VTT2xiM0VUWkpORmpBMElBbkZKYUh5U08xMDNwcVU5cUps?=
 =?utf-8?B?QmptR1Vvc3JoUk9KaExmODBYd2ZJaWdVYWcrdC9WUjQreUxsd3dHVTFGNmdj?=
 =?utf-8?B?a1ZXNGtxQS9OUWNlMkZMamZ4L0ZqaHUzRHhJVmFlODljU2dPU1ZQWWNvYzAz?=
 =?utf-8?B?RmZvQWlERXVSRWRVUURxb3lqTSt6YVhGdElPdVVobWdYNTdOdUlObXc0cU45?=
 =?utf-8?B?anUvb0lOOUZYeGN6VGdRR3dMRnB0Ky9BYldHUjZnZ2tpVmh3RS9zWDV5SUFD?=
 =?utf-8?B?dE1VSExvbmJhZG1CNTNXREhwVEs4YUh2Y3hCZ1E5MDI5R2xaU28vTStlMUw0?=
 =?utf-8?B?N1E9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d9d1bb-9799-4f3a-f410-08da63c12d1e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 04:44:16.4906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ZjUiPv+p83jVTbXQOhlm1lfUWsSA3JvvRgPr01AIrQrdaaWLlpBMptp2nCxexag6PFr5JNy55HbmrfNzNbuYddhrvoN4MUaAb1frPolgdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB2041
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-12_03:2022-07-08,2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207120018
X-Proofpoint-GUID: gcfhJxxy9o3kY66xfzxf2SAzR_cety7B
X-Proofpoint-ORIG-GUID: gcfhJxxy9o3kY66xfzxf2SAzR_cety7B
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric and Christian, Ping?

If you guys don't like these patches anymore what about something
simple like just exporting some helpers to update and check a task's
nproc limit. Something like this:


diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 81cab4b01edc..71b5946be792 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -98,6 +98,10 @@ int kernel_wait(pid_t pid, int *stat);
 
 extern void free_task(struct task_struct *tsk);
 
+extern bool task_is_over_nproc_limit(struct task_struct *tsk);
+extern void task_inc_nproc(struct task_struct *tsk);
+extern void task_dec_nproc(struct task_struct *tsk);
+
 /* sched_exec is called by processes performing an exec */
 #ifdef CONFIG_SMP
 extern void sched_exec(void);
diff --git a/kernel/cred.c b/kernel/cred.c
index e10c15f51c1f..c15e7b926013 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -358,7 +358,7 @@ int copy_creds(struct task_struct *p, unsigned long clone_flags)
 		kdebug("share_creds(%p{%d,%d})",
 		       p->cred, atomic_read(&p->cred->usage),
 		       read_cred_subscribers(p->cred));
-		inc_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
+		task_inc_nproc(p);
 		return 0;
 	}
 
@@ -395,7 +395,7 @@ int copy_creds(struct task_struct *p, unsigned long clone_flags)
 #endif
 
 	p->cred = p->real_cred = get_cred(new);
-	inc_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
+	task_inc_nproc(p);
 	alter_cred_subscribers(new, 2);
 	validate_creds(new);
 	return 0;
diff --git a/kernel/fork.c b/kernel/fork.c
index 9d44f2d46c69..88dbe3458d7d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1964,6 +1964,32 @@ static void copy_oom_score_adj(u64 clone_flags, struct task_struct *tsk)
 	mutex_unlock(&oom_adj_mutex);
 }
 
+bool task_is_over_nproc_limit(struct task_struct *tsk)
+{
+	if (!is_ucounts_overlimit(task_ucounts(tsk), UCOUNT_RLIMIT_NPROC,
+	    task_rlimit(tsk, RLIMIT_NPROC)))
+		return false;
+
+	if (tsk->real_cred->user != INIT_USER && !capable(CAP_SYS_RESOURCE) &&
+	    !capable(CAP_SYS_ADMIN))
+		return true;
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(task_is_over_nproc_limit);
+
+void task_inc_nproc(struct task_struct *tsk)
+{
+	inc_rlimit_ucounts(task_ucounts(tsk), UCOUNT_RLIMIT_NPROC, 1);
+}
+EXPORT_SYMBOL_GPL(task_inc_nproc);
+
+void task_dec_nproc(struct task_struct *tsk)
+{
+	dec_rlimit_ucounts(task_ucounts(tsk), UCOUNT_RLIMIT_NPROC, 1);
+}
+EXPORT_SYMBOL_GPL(task_dec_nproc);
+
 /*
  * This creates a new process as a copy of the old one,
  * but does not actually start it yet.
@@ -2102,11 +2128,8 @@ static __latent_entropy struct task_struct *copy_process(
 		goto bad_fork_free;
 
 	retval = -EAGAIN;
-	if (is_ucounts_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
-		if (p->real_cred->user != INIT_USER &&
-		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
-			goto bad_fork_cleanup_count;
-	}
+	if (task_is_over_nproc_limit(p))
+		goto bad_fork_cleanup_count;
 	current->flags &= ~PF_NPROC_EXCEEDED;
 
 	/*
@@ -2526,7 +2549,7 @@ static __latent_entropy struct task_struct *copy_process(
 bad_fork_cleanup_delayacct:
 	delayacct_tsk_free(p);
 bad_fork_cleanup_count:
-	dec_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
+	task_dec_nproc(p);
 	exit_creds(p);
 bad_fork_free:
 	WRITE_ONCE(p->__state, TASK_DEAD);


On 6/19/22 8:13 PM, Mike Christie wrote:
> The following patches were made over Linus's tree.
> 
> Eric and Christian, the vhost maintainer, Michael Tsirkin has ACK'd the
> patches. I haven't got any more comments from you guys for a couple
> postings now (Jan 8 was the last reply). Are you guys ok to merge them?
> 
> For everyone else that hasn't see this before, the patches allow the
> vhost layer to do a copy_process on the thread that does the
> VHOST_SET_OWNER ioctl like how io_uring does a copy_process against its
> userspace app. This allows the vhost layer's worker threads to inherit
> cgroups, namespaces, address space, etc and this worker thread will also
> be accounted for against that owner/parent process's RLIMIT_NPROC limit.
> 
> If you are not familiar with qemu and vhost here is more detailed
> problem description:
> 
> Qemu will create vhost devices in the kernel which perform network, SCSI,
> etc IO and management operations from worker threads created by the
> kthread API. Because the kthread API does a copy_process on the kthreadd
> thread, the vhost layer has to use kthread_use_mm to access the Qemu
> thread's memory and cgroup_attach_task_all to add itself to the Qemu
> thread's cgroups.
> 
> The problem with this approach is that we then have to add new functions/
> args/functionality for every thing we want to inherit. I started doing
> that here:
> 
> https://lkml.org/lkml/2021/6/23/1233
> 
> for the RLIMIT_NPROC check, but it seems it might be easier to just
> inherit everything from the beginning, becuase I'd need to do something
> like that patch several times.
> 
> V10:
> - Eric's cleanup patches my vhost flush cleanup patches are merged
> upstream, so rebase against Linus's tree which has everything.
> V9:
> - Rebase against Eric's kthread-cleanups-for-v5.19 branch. Drop patches
> no longer needed due to kernel clone arg and pf io worker patches in that
> branch.
> V8:
> - Fix kzalloc GFP use.
> - Fix email subject version number.
> V7:
> - Drop generic user_worker_* helpers and replace with vhost_task specific
>   ones.
> - Drop autoreap patch. Use kernel_wait4 instead.
> - Fix issue where vhost.ko could be removed while the worker function is
>   still running.
> V6:
> - Rename kernel_worker to user_worker and fix prefixes.
> - Add better patch descriptions.
> V5:
> - Handle kbuild errors by building patchset against current kernel that
>   has all deps merged. Also add patch to remove create_io_thread code as
>   it's not used anymore.
> - Rebase patchset against current kernel and handle a new vm PF_IO_WORKER
>   case added in 5.16-rc1.
> - Add PF_USER_WORKER flag so we can check it later after the initial
>   thread creation for the wake up, vm and singal cses.
> - Added patch to auto reap the worker thread.
> V4:
> - Drop NO_SIG patch and replaced with Christian's SIG_IGN patch.
> - Merged Christian's kernel_worker_flags_valid helpers into patch 5 that
>   added the new kernel worker functions.
> - Fixed extra "i" issue.
> - Added PF_USER_WORKER flag and added check that kernel_worker_start users
>   had that flag set. Also dropped patches that passed worker flags to
>   copy_thread and replaced with PF_USER_WORKER check.
> V3:
> - Add parentheses in p->flag and work_flags check in copy_thread.
> - Fix check in arm/arm64 which was doing the reverse of other archs
>   where it did likely(!flags) instead of unlikely(flags).
> V2:
> - Rename kernel_copy_process to kernel_worker.
> - Instead of exporting functions, make kernel_worker() a proper
>   function/API that does common work for the caller.
> - Instead of adding new fields to kernel_clone_args for each option
>   make it flag based similar to CLONE_*.
> - Drop unused completion struct in vhost.
> - Fix compile warnings by merging vhost cgroup cleanup patch and
>   vhost conversion patch.
> 
> 
> 
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization

