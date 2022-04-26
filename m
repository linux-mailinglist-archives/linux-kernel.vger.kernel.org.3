Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964B25109BD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354555AbiDZUMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354542AbiDZUMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:12:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F19C1738E5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:09:25 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QIIED1015475;
        Tue, 26 Apr 2022 20:08:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+ztRhjjrK3hhuT6ql9AqyIKZCQj1Ap3NokTlLYJmnFk=;
 b=eCckFWIr6v/SqkYobYYzDKoBVfC9TpR04Ip1hVTgjwVq17zU7r9hrZvSxkRf3xGUPML3
 O9lUJRWJ2Lh4hALWK6p4AHTHzbD3Q1Ju1drg7frePe/dMVlkPxApFA+QEP5pAZu11i3l
 ldMahdKwCSA5Neg9LB6MlbwRxHyWq+FcaB6ZIGXWQ+VVk4D30o496zXUw14PYUU/PqQg
 M3uUUDk1cnscu2bAsBUQ7rNzBvb/dmqzMFXCJxZ2t7/jBuAhj6cvKku9626E1F9O0C4i
 xQmmd4WpT50n6UQI/RfRXlbFawD+t9bdifJp93kUzqFjCpalkOO/TbVcxuV0cOOC086m Ug== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb9aq6a5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 20:08:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QK6WcA016942;
        Tue, 26 Apr 2022 20:08:36 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yjvptm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 20:08:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OI4/or+63dyaCKY7NKbYUmvvTffIC9f/Amg7Yq2UxgCEvOeFVciwxoBGh4Qbr2ecTXWZxfuJJtnaFmo0OomDH8engpGMnp0FUJ2cDrjkmcxkhAguIrkH7f5/bfCpjx656bQTAeC/PQmZ61IZIBorymfJtHqamwoEJzLsJYEu4xq5SaHpL1hJhl4H/bZN4i59ZsVujRug7smmrJO1tKfqUN0Xe7EZF9Yp0/gAmx09rDDsEZMYlmsTD7oKMvhfaI/sYwiYmf/IpEUaz+xQcZzuK8b/rDFfesPrQdrIbHb9vynk1EA6K6umY8savzGLF0lSk3/vdIvnAmhJ/GDoWrpeRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ztRhjjrK3hhuT6ql9AqyIKZCQj1Ap3NokTlLYJmnFk=;
 b=fy3WdCqYd86CO3OAoq3jx+s256cORdGAASA6IwZQO3mY6BVKLtkQN+sz30S/4Y1l0UpPGUlHGtgbFqB1Gz8wjYlbSuk8sy5zm35F8/b1WyNqtVJjv8AIsptCLatphze/DWlw8T/rBPH4u+Actun0WEIOVITDXBy3ak1k+Y79Tu5TtNqOzK7wsTonWpPYqNccI0xr8mSk+6EarE7Mic7rNTPf66FxhTaDYwEuSeSD0b9iaOmbv1t4Di2qBd3jVYKk4Q9elUtZ58ayBdlALsnneIfLhmUrZ8ZRo++HDO0BZEfxdLLO3BWUI2Orn+Q9VbVvolpqPHGk78tX41LVdqS9WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ztRhjjrK3hhuT6ql9AqyIKZCQj1Ap3NokTlLYJmnFk=;
 b=cqqn3bVTd0WI6MuLElpdBC7Vpv2KGaceWNyZaHNsxSCpSynEaAS/zgpsn36Qyg0LpgxmLgazEcGrRDFnwr+p/oMFGb9b1/s5dhE6poAHXFr6QIdlEPiQjgrpXrEwibCWFl96MmGFTpNuyusB+FscQoD3CMvR4XlEF8tsRq9SIIA=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DM5PR10MB1436.namprd10.prod.outlook.com (2603:10b6:3:f::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.21; Tue, 26 Apr 2022 20:08:34 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::c11a:5b2b:9659:7c42]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::c11a:5b2b:9659:7c42%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 20:08:34 +0000
Message-ID: <0aee5cd1-eb8c-f778-c6e5-7f5ca3624d15@oracle.com>
Date:   Tue, 26 Apr 2022 15:08:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v7 2/8] x86/crash: Introduce new options to support cpu
 and memory hotplug
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220413164237.20845-1-eric.devolder@oracle.com>
 <20220413164237.20845-3-eric.devolder@oracle.com> <Ylgot+LUDQl+G/5N@zn.tnic>
 <f3ea7ee0-1cb8-6928-d0af-4c2fc63a42a4@oracle.com> <Yl6PueNCZZeobMWr@zn.tnic>
 <cc7a6b5c-954c-54fe-be5f-324dc984ac51@oracle.com> <Ymb1tBJsch/TB2ph@zn.tnic>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <Ymb1tBJsch/TB2ph@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR08CA0002.namprd08.prod.outlook.com
 (2603:10b6:208:239::7) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55bd69ba-0fd9-4eea-f9e0-08da27c08ad3
X-MS-TrafficTypeDiagnostic: DM5PR10MB1436:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB14366B373612FDF90B88302D97FB9@DM5PR10MB1436.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7MDHIN/oC4yk3vj00QDh003Ja/S1kI45v6pTzSgWHe85N6+9esRFPPpaTZn58G3tHE6JNqTfLPd1w0oqvA5l4f/JFQiXnwQTXpUYo0SKnjcIWKQQkJ39jDmQGMIoyMmirSIpBN7Rkgj0CD58+q0srjY2/MWTXHc6eIrJwBAQMcxN4BJl3khyn4uV9cRDl+mzyRXOE00ZdFqpozGIG2h5cgn0EODi2z0+y5bO18giwAgKy6CMV7a2wgkmz/qZ4qbkUKgdFrvlT7movehOJhcVMxozkDUV1/3txnTPXOPDrMud2G6oeUXsDoAdP6vzaDx1bK2BfPB+i3Zrc7c+lmt1NpAfz1+uRC4Xekp0UV+2HD5xh6CNU5i8xRmUD1w2bGL45RsZHgxWMGBGTjuiqbNncnnQv4Lc39t8Mo/qG0/Px8sP+R1jw6lxun/29HxDZD3XBlKYm8BhofBIEZIgfZ3Y7yJI9LaDMHrjeeYdok5KYFb4aDBM+G7Rw+oC4W0atDdQzGQ9zKekX+ROv83XYv6Gza6Q6kPhsWlC0nL+cUc3GR9emkN3bs7GT+78ubfwycCb7vh7psqynL81OedEpctisGKumuLxPrs4jtiqwR9hr4He8gTUBvBG5M1djYphsZqn5XM0zxnJoU253Im6nozjAnxwpkEkPCbU6SAuiz1Melhja5zLN5W6w5zj3pKnTtC8IYkq5ZC4tunlPCnd25h+yTiJxVaZzNh1dQLCa/xuO3M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(8936002)(36756003)(31686004)(66946007)(6506007)(4326008)(6916009)(6666004)(2906002)(66476007)(66556008)(8676002)(316002)(53546011)(2616005)(83380400001)(186003)(31696002)(6512007)(38100700002)(107886003)(7416002)(508600001)(5660300002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXZSUUlZZWlWSXpibTNRak10WGIzWWJtVDFzQjdoN2JLTWV6R1ZTZWNlemNI?=
 =?utf-8?B?Szk5eFluTmdqanRwbUtqa25PdGV1T1VGeXFPRHQrbXNFTDJrL3V4alRENUZj?=
 =?utf-8?B?Z3VKTzZ1TkZSZm4yUU05SjRpbmN6WkNDU3ZFYkNudW1sWlVobHNDNmJPZjcr?=
 =?utf-8?B?Y3hDY20rbWRDdXcxUG5QWW5NMm44S1Rjc2JmWEF6eG1sTzZUSWxSZVpIdzZT?=
 =?utf-8?B?MG9zYUw3TXg1N1p5UURtYm5yeURsOVUreFdWbkE2WG10NnhLaU9KSUVpOFRl?=
 =?utf-8?B?MmtYRElyc0NTOGtmNWM0QjI1Mmx1dmp1TmVENThzRE9PQkcycmtmY2FGRUhj?=
 =?utf-8?B?SmlPNWRSZEk0dk5mTWh3Ujd1dGsxZUJaV2ErQWgvaXJMa254c2Y1ZUVremNm?=
 =?utf-8?B?OVBRV3Ewa0NBVXZKY21NWVp3VUJJRzlieU8zRzEzcmw5Ri94T0FUaFpHTTJP?=
 =?utf-8?B?NW9lRVJpc3ZId2hnNmpOQXZZRUFkU0NGRnBkSnZqQjBNdVhLS2ZaaU95TDJl?=
 =?utf-8?B?K3ptU2swZS9oT0NTYWE5cTgrVGJzdExUdFNUOGRoMmFaTWl4NzNKZG1uN04w?=
 =?utf-8?B?aitma1JVOXlnWU1SWkJqb1NaSytmbGQ0elhKTFoveXk4S3VyS09sYStnT1Fu?=
 =?utf-8?B?UlZ4RXI1a2RCd0drdTVRbHdxMzlrMk9EVFljOWdjdncrdkVPS09zNWxFNWVQ?=
 =?utf-8?B?eHE2VkpaN2pMTVIvM091blRPUjhkRkZLL2xZVzNMRllXK2JHWVRBS1p5V0Ew?=
 =?utf-8?B?KzE4L2t1aDVnbCtpSFBQUnVOL1VKYjlCY3FScmNNZzZoZGxtWkNBRDhWb2ty?=
 =?utf-8?B?TlNqd3RMbVJ2dEYrR1BJcWVWbnlPdVVVMzJzc1lySjVScFZzQmhoRUY4M0p0?=
 =?utf-8?B?ZU5uVm1nbmpGZW1KTVd3bms2eWd0Z1hCTllmVjdCeUVaVmZrelhNSkZlU3V6?=
 =?utf-8?B?T2krRmY2a3QvTjlSdkhtTVNBQW1MTWlOSWs1L3FnZjVObkZsZzZqbzllM3Nn?=
 =?utf-8?B?aXlzUmJORVA0YzIzV0lzQndVVGE4SE8yWEwxcXhkRWZud1ZtUkk4VGZjOWxO?=
 =?utf-8?B?U0pGS1RJelU4YUJMNFpabEpuUXRnbUlzY3c4QVRTcjVHZFp0RHRPd3Z5Zmdk?=
 =?utf-8?B?UFRPK2xNM0pxUmhpd3V1R3VTbktMY2VjdjJySG5DRHFWNlpxRTBCZ3VGa1Jm?=
 =?utf-8?B?ZnlxVFl2N09ONk9WOWxEdXpsWUZxZVZFZGlkL2o4VFdDc1hxd2RYMnJlRWZS?=
 =?utf-8?B?ZnVzOW9tRmw0TThuWUtQcFg0Z2FZMWJDdnRER2Z3ZkxFeFV6K29qSXlzdFJV?=
 =?utf-8?B?dFdydmtJbWtXOS9iZTlGVmtSSUg2QzlYd0Eyc0hpUFhjMFQxZWFRTGp5TDFD?=
 =?utf-8?B?TmtUdFJiOHNEUEdQcGRTTnF5eGJzU1A5eFpmQzhZYVZGSmJGS256bUFuck4z?=
 =?utf-8?B?ZVFiT0k0c0xXWW1ET25sSmlUY1RRTFA0VnZoRTViQWMvUS9zM0toQmFpTklY?=
 =?utf-8?B?RFlRN25rdmtoREFkTlBaa0VsUDM4TXhxTTNPK3lZNmx3YW5iUkVOMWRibC83?=
 =?utf-8?B?Y0dZTGwveklwbzF3TlZXMis1Qi9OaGc5MWQrM3ZhcGJyKzFnbUVVdHZSTnNC?=
 =?utf-8?B?QXZmL0xKdEsvU2t2aUFnbm9VOVY0WXNWMmt2aGNydGJFcmdoLys1QllpTEFy?=
 =?utf-8?B?d0t4RVhvdWx2V1Y5b1k0Qm5sQlpJK0FXMVE1dE4xQ0d3Y0xlS1M4Nnp0Z3pX?=
 =?utf-8?B?R0ZrNFVsdi9ieE9HOHpoUDIxVUE1YTFkQkxXUmlxaTBpKzR6TWV4dFBaNmg2?=
 =?utf-8?B?dU9pWDJPdjROVlUra2NrM2NKbFFnSDd0WERtdHU2TTV2YWUwOElvbVJpOW9s?=
 =?utf-8?B?bENhckMvNjRtN01vZ2UxN2VIVWo3ZGNhZmRkaGVQR1Z1R1Ayc1R6azRhWVc4?=
 =?utf-8?B?d0xTNDUwaFRFK3ZwcFUydXNXNlRvU0pkdnlTNDZNY3d6ckMxOU1UdW51ZnI3?=
 =?utf-8?B?TE5yVEtNdllwWTJvYnFOcDUrdnhGMVVEallodHZ3NHJwTUNiTUt5QU1abXl3?=
 =?utf-8?B?WHRZZHdOQ2Y4S1FmSHJuM1pFMDlrWGs4d1oySU1QWDhxYlhRbVpabjVDLzhY?=
 =?utf-8?B?a0RMVEUrRUxWb0ZRQlQ2U3c1dFRzOU1HcEQ4WHA3azhJejRXd1huWjdpd2pn?=
 =?utf-8?B?cE92bHZqdnBKMzU1R0cyWXRiQWF6a2N4dzFPQmQvUzBiQzFlTWk3cFRvNGNR?=
 =?utf-8?B?QVByOEJxVFRESFNIU3JaOW8xYmUwRzN5YmowcFVZRTZybUJHTmJkZksrSUpj?=
 =?utf-8?B?OEpGaGpMZzdmTDc4K0pXYWJWb2dOTFdnc1VTSkxUQ0dYd2VmS2lYQTJ0VVBx?=
 =?utf-8?Q?Q8PkMj5CdhQjjKhW1muxs7+kyoEeWA1fCC/iV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55bd69ba-0fd9-4eea-f9e0-08da27c08ad3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 20:08:34.5509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wgXtsK8molFgCIf0WnjD+zHIfITA/FzMQZ+f//nniZCB+5V3XrfmyYmg5lxFXocNUSUQOE99SlXbTBnahM8QzRor0EMTQokT3AhrnvULr1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1436
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_06:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260128
X-Proofpoint-ORIG-GUID: 1EsZaEBT2W-HgEv6pNVzM0AF_S1-FBIs
X-Proofpoint-GUID: 1EsZaEBT2W-HgEv6pNVzM0AF_S1-FBIs
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boris,
Many thanks for the time taken to illustrate for me!
I've one question below.
Eric

On 4/25/22 14:25, Borislav Petkov wrote:
> On Tue, Apr 19, 2022 at 04:58:47PM -0500, Eric DeVolder wrote:
>> So in taking this concept and looking at, in particular, patch 4/8
>> "crash: add generic infrastructure for crash hotplug support", I'm not
>> exactly sure how to apply this technique.
> 
> So I took your patch 4 and maimed into what I think it should look like,
> see below.
> 
> Now there's a single ifdef there and the registration routines are
> wrapped in IS_ENABLED() so that you register a callback only when the
> respective stuff - HOTPLUG_CPU or MEMORY_HOTPLUG - is enabled. Otherwise
> the couple of functions are unused but that's not that big of a deal.
> 
> I've also fixed up some other issues I've encountered along the way.
> 
> Holler if there are questions.
> 
> HTH.
> 
> ---
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index de62a722431e..b3c32e04d3f0 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -84,4 +84,12 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
>   int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
>   		unsigned long long *crash_size, unsigned long long *crash_base);
>   
> +#define KEXEC_CRASH_HP_REMOVE_CPU	0
> +#define KEXEC_CRASH_HP_ADD_CPU		1
> +#define KEXEC_CRASH_HP_REMOVE_MEMORY	2
> +#define KEXEC_CRASH_HP_ADD_MEMORY	3
> +
> +struct kimage;
> +void arch_crash_handle_hotplug_event(struct kimage *image, unsigned int hp_action,
> +				     unsigned int cpu);
>   #endif /* LINUX_CRASH_CORE_H */
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 02daff1f47dd..d907a1f0d3da 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -307,13 +307,11 @@ struct kimage {
>   	/* Information for loading purgatory */
>   	struct purgatory_info purgatory_info;
>   
> -#ifdef CONFIG_CRASH_HOTPLUG
>   	bool hotplug_event;
>   	unsigned int offlinecpu;
>   	bool elfcorehdr_index_valid;
>   	int elfcorehdr_index;
>   #endif
> -#endif
>   
>   #ifdef CONFIG_IMA_KEXEC
>   	/* Virtual address of IMA measurement buffer for kexec syscall */
> @@ -329,15 +327,6 @@ struct kimage {
>   	unsigned long elf_load_addr;
>   };
>   
> -#ifdef CONFIG_CRASH_HOTPLUG
> -void arch_crash_hotplug_handler(struct kimage *image,
> -	unsigned int hp_action, unsigned int cpu);
> -#define KEXEC_CRASH_HP_REMOVE_CPU   0
> -#define KEXEC_CRASH_HP_ADD_CPU      1
> -#define KEXEC_CRASH_HP_REMOVE_MEMORY 2
> -#define KEXEC_CRASH_HP_ADD_MEMORY   3
> -#endif /* CONFIG_CRASH_HOTPLUG */
> -
>   /* kexec interface functions */
>   extern void machine_kexec(struct kimage *image);
>   extern int machine_kexec_prepare(struct kimage *image);
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index ecf746243ab2..a6c4ee1d5c86 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -497,57 +497,50 @@ static int __init crash_save_vmcoreinfo_init(void)
>   
>   subsys_initcall(crash_save_vmcoreinfo_init);
>   
> -#ifdef CONFIG_CRASH_HOTPLUG
> -void __weak arch_crash_hotplug_handler(struct kimage *image,
> -	unsigned int hp_action, unsigned int cpu)
> +void __weak arch_crash_handle_hotplug_event(struct kimage *image, unsigned int hp_action,
> +					    unsigned int cpu)
>   {
> -	pr_warn("crash hp: %s not implemented", __func__);
> +	WARN(1, "crash hotplug handler not implemented");
>   }
>   
> -static void crash_hotplug_handler(unsigned int hp_action,
> -	unsigned int cpu)
> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
> +static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
>   {
> -	/* Obtain lock while changing crash information */
> -	if (!mutex_trylock(&kexec_mutex))
> +	if (!kexec_crash_image)
>   		return;
Why is it safe to examine kexec_crash_image outside the mutex? As I understand it, there is still 
the (very rare) opportunity for a kdump load/unload initiated via userland and this check to 
collide. (Similarly, I believe the mutex entry is almost always assured/likely.)

>   
> -	/* Check kdump is loaded */
> -	if (kexec_crash_image) {
> -		pr_debug("crash hp: hp_action %u, cpu %u", hp_action, cpu);
> +	mutex_lock(&kexec_mutex);
>   
> -		/* Needed in order for the segments to be updated */
> -		arch_kexec_unprotect_crashkres();
> +	pr_debug("crash hotplug: hp_action %u, cpu %u", hp_action, cpu);
>   
> -		/* Flag to differentiate between normal load and hotplug */
> -		kexec_crash_image->hotplug_event = true;
> +	/* Needed in order for the segments to be updated */
> +	arch_kexec_unprotect_crashkres();
>   
> -		/* Now invoke arch-specific update handler */
> -		arch_crash_hotplug_handler(kexec_crash_image, hp_action, cpu);
> +	/* Flag to differentiate between normal load and hotplug */
> +	kexec_crash_image->hotplug_event = true;
>   
> -		/* No longer handling a hotplug event */
> -		kexec_crash_image->hotplug_event = false;
> +	/* Now invoke arch-specific update handler */
> +	arch_crash_handle_hotplug_event(kexec_crash_image, hp_action, cpu);
>   
> -		/* Change back to read-only */
> -		arch_kexec_protect_crashkres();
> -	}
> +	/* No longer handling a hotplug event */
> +	kexec_crash_image->hotplug_event = false;
> +
> +	/* Change back to read-only */
> +	arch_kexec_protect_crashkres();
>   
>   	/* Release lock now that update complete */
>   	mutex_unlock(&kexec_mutex);
>   }
>   
> -#if defined(CONFIG_MEMORY_HOTPLUG)
> -static int crash_memhp_notifier(struct notifier_block *nb,
> -	unsigned long val, void *v)
> +static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
>   {
> -	struct memory_notify *mhp = v;
> -
>   	switch (val) {
>   	case MEM_ONLINE:
> -		crash_hotplug_handler(KEXEC_CRASH_HP_ADD_MEMORY, -1U);
> +		handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY, -1U);
>   		break;
>   
>   	case MEM_OFFLINE:
> -		crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_MEMORY, -1U);
> +		handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY, -1U);
>   		break;
>   	}
>   	return NOTIFY_OK;
> @@ -557,38 +550,33 @@ static struct notifier_block crash_memhp_nb = {
>   	.notifier_call = crash_memhp_notifier,
>   	.priority = 0
>   };
> -#endif
>   
> -#if defined(CONFIG_HOTPLUG_CPU)
>   static int crash_cpuhp_online(unsigned int cpu)
>   {
> -	crash_hotplug_handler(KEXEC_CRASH_HP_ADD_CPU, cpu);
> +	handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
>   	return 0;
>   }
>   
>   static int crash_cpuhp_offline(unsigned int cpu)
>   {
> -	crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
> +	handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
>   	return 0;
>   }
> -#endif
>   
>   static int __init crash_hotplug_init(void)
>   {
>   	int result = 0;
>   
> -#if defined(CONFIG_MEMORY_HOTPLUG)
> -	register_memory_notifier(&crash_memhp_nb);
> -#endif
> +	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
> +		register_memory_notifier(&crash_memhp_nb);
>   
> -#if defined(CONFIG_HOTPLUG_CPU)
> -	result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> -				"crash/cpuhp",
> -				crash_cpuhp_online, crash_cpuhp_offline);
> -#endif
> +	if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
> +		result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> +						   "crash/cpuhp",
> +						   crash_cpuhp_online,
> +						   crash_cpuhp_offline);
>   
>   	return result;
>   }
> -
>   subsys_initcall(crash_hotplug_init);
> -#endif /* CONFIG_CRASH_HOTPLUG */
> +#endif
> 
