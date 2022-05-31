Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B17539975
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 00:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348369AbiEaWXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 18:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235799AbiEaWXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 18:23:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99D62FE54
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 15:23:12 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24VKpfKp018920;
        Tue, 31 May 2022 22:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=wm+9zz8oaQVIxapWQoC5BGt++l8q+qIQRk1Al2t8a+s=;
 b=xdZXl/xy9vyTaGbo6KaovNFV2T/3C79UQSqdLeJIF+IVhYVMi9eNs151CRkdPUI6uR5k
 knj3AMV9dbt/epEyjV0iJERbPoI4Yse6w0yBzz8nfqci7csDhtaq9QNBttAmCLv4O7e4
 13Ak9UTvWVxz+mMvgKxcQVzIZfBxE8QZwoZqL5q5EBhe20dWPy2vkNA0757GWc2JnBtG
 NO3XFEcy2r5jxyxbLyTW5PmDkGqzAvrezfC58pUWomjlT/CfHmAhfNlYiDfmrXVfHXhy
 PdvudiRbQApTH+nmq12PHH/rzZ2FPTGS7lhFtqfpHH/skO4jlFJKNh/MyXr3k+U0bVgr fQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbc4xpcsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 22:22:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24VMFTqm011793;
        Tue, 31 May 2022 22:22:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gc8jy5un7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 22:22:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEy79O3VkBBaIF6M8imB8EcESQAJkPuy5RLHWY0lA0vAhTW29qLYcqiJUjxu2/rhk5s9mrZf+E7BpjBxcXDJRBTIdzA+QT6rdoJM2iU3zNkKSChJ6G+lVHk8HsDkXRGlS3CqsC9BgIHW88XIKFu2Tm8Yt27a2eDgHYkqBHRuqVJK0MX2oj/aDK9qXn+NxB3jskR5p/ga45HpkstkYhFobqoyrVaTAvHhnf90075PJBkyXmkNdVbim9RPjTsExuCUGyC3tQ7B8bm46Qf02LhGsP19AYbtJ7pdmCxFZ3rWWHd8S0ozYxbHgWzPs+ZAtGZzUQ4WFJpTHj/8CC0Lg/AHlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wm+9zz8oaQVIxapWQoC5BGt++l8q+qIQRk1Al2t8a+s=;
 b=CtOO/1XoX8kz0fWHqFEJzYCqwh1C+O+gaUiSaFo17b62ejnNns+06/wSOVGAHGN0Vd8v3u4Pk/kp6CFzUoDTYCUeFkd+Z+LGhfXcUCDpUOzyJpq07d7Ztyq0ZyRPw+73UixBjBg2faXaFNsrTo6/5A1v7MQDJp03cMATtUmAgd3/IGjr9BraFoEeVIl5bYcOFyUFHZ43d6GyJyMWpZCOxADcB/56x4GVvMzDpqLy4wxKsnwkwNSf9bY/XU+lt2S46d5PotKvz77Vky3DM710NUc6Dmh4z35xSbU3dIP/0QGd/AyU5DjKbkWnGon1kMlSW1oG3l7swK0/ie/dLdlZBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wm+9zz8oaQVIxapWQoC5BGt++l8q+qIQRk1Al2t8a+s=;
 b=AMrQYc6k+4nGBNUz0UH90jJRVZYuOk8D9asELbXnVSAUXmcMNcDBnbqDi745ldDETWznJvgZGE74vEXyBvUAaiz0RGa3iPzT+aepd4O4W9fCPsOmt/0NWT8CqMF9XlQyg/ZvDZCLpx6N/OQgfhD+9B6/C3zqlg389AkaiT4F7eI=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CY5PR10MB6118.namprd10.prod.outlook.com (2603:10b6:930:36::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Tue, 31 May
 2022 22:22:47 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::bd49:f0ab:b476:860c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::bd49:f0ab:b476:860c%8]) with mapi id 15.20.5314.012; Tue, 31 May 2022
 22:22:47 +0000
Message-ID: <79ad6be3-a817-b6bf-b32b-74b80a512c14@oracle.com>
Date:   Tue, 31 May 2022 17:22:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v8 0/7] crash: Kernel handling of CPU and memory hot
 un/plug
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220505184603.1548-1-eric.devolder@oracle.com>
 <311b0834-c675-fd15-8184-82b122f4a9cc@linux.ibm.com>
 <bffb3d9e-1946-f4b6-d58c-9c44bc0bee26@oracle.com>
 <94fba107-a425-7cf6-2a7b-0562c2dcfce4@linux.ibm.com>
 <5358be66-e545-4482-bad6-00d3d53aac8a@redhat.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <5358be66-e545-4482-bad6-00d3d53aac8a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0097.namprd04.prod.outlook.com
 (2603:10b6:806:122::12) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 195d77cd-d9d6-4190-ef7f-08da4354170b
X-MS-TrafficTypeDiagnostic: CY5PR10MB6118:EE_
X-Microsoft-Antispam-PRVS: <CY5PR10MB61181EC0EBA7879D97AF14ED97DC9@CY5PR10MB6118.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lTGlSjY6kPgYsw+wW3P3uf9r6jmj//vtfu4edCwoVHazIx2nnxdrAPtUj7Tpg22eq/50ZKQy+h+Tx3Im+tpPhFezb5Plo8fefuz6P04iom9wuFfWix6GN8/b42ROUw3FUP37+N+1mkR8KwkkBKU36x6j4WhC2bVLPhTQ7hv0zcxbOXSH7R9BnT/wKgdX+QIJ3naU35krG9Xj5ttfOBeKTeevzov+k0Dtj1qt2xUjT5GDg7D1OSoBy6lZwaOL9K9BtRT/kipsQR8v3s8Bjg6aAEJZpM8KyNpzf7g8KKjC884ZOxUMGDgMCLn7S/qG3MAcc32qwLG5fVfUKoXfmrKmLzDmTW14VZLYv2z+5imbvOlgOjhx0hEVQJMaybYLhBqTBMd9X9kaEngkeKu4/LcpiO+UYJCfrrpAZH2duOOSvw0GhNa68VlFizxDEe39BpT5qZ6GnJrAUC66lV3ojdVwzaUPaycHVEPBvix5SJQ68u0DBWLSSw+kQXENdCh87twOFLA3lTrG9HT7BNjr0IFiK9KUQnzpINLv80Dd7LZCbcfZk+B1iJ0dKQCkpXaJC0f25jPlR1lZyHv0JsIMXrUYN6vcstQ853bnKfPj3iWL81kzphjmmmYVZTMl29sqPsFsHxB6RC0zd7X0iEfP9f5+sHBZ/0eTmtGHUOUs6jOeYx/iNBPFaNAB3hN+i/wZOgljTkbZ49efKcnePVrpdToo8YFLK0y1Xmjx2GXY5JOdwxE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(508600001)(110136005)(31696002)(66946007)(66556008)(186003)(36756003)(83380400001)(4326008)(86362001)(107886003)(38100700002)(2616005)(2906002)(31686004)(6506007)(6512007)(53546011)(6486002)(7416002)(5660300002)(8936002)(316002)(8676002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ry8vTEFzejhxWXhFQnlnalhjLzExWjJJSEpwMmRCUG9ySUJJcDdEUFdEYkVp?=
 =?utf-8?B?K2J6N1cyMnFKTHZ0NXBZajFLektSMEtUeVg4REpZSDBqTjNqQ0pZczJOU1FI?=
 =?utf-8?B?ZVkyMUEwa1ZVWjJoa1FRTHNBU3BIcVJNNjc1MFlmSC9QbE02Um5YTlFjZjdQ?=
 =?utf-8?B?WU1IZHNlSWNzejMreW1UUzUvaVVqK2dIZG5UV2VaYm95OEUwV2NOY1lLekYx?=
 =?utf-8?B?cXV1MmJ5czJRSDkrMXpMU2Fuc1Ezdm9jeG4xUGh6NlhlYUJlWGFxb0p6YVRI?=
 =?utf-8?B?WHVHdDdnZlhDRnVYNGd0MzF6eGZxODJtbC9FVkFNK1ByZWNFTXFkMVVXdXU5?=
 =?utf-8?B?Y2pFL25jbEMyQjUvbjhqKzIvS2ZveTFkTFZrblFUN1pRbEVuTnI1ZXV3d0pY?=
 =?utf-8?B?dkJDMTVORkpJMERXaU43VkVpbEJpUEs3RmxxMTlIQ0UvQzRadGpWTHJ5bWE3?=
 =?utf-8?B?NnFpZUJUUzVWaWdpWDhDMGlRQ2wyOGx3UzdaZElMeFBwUnlwd0dPaTlibHA2?=
 =?utf-8?B?SzlreTlvS3BPSVovdXNHSDROb0F0bS9OREVrZmwzMC9yb2lhWXdFRzBGMk9m?=
 =?utf-8?B?TWRzczhlN3p1c000UnpQdERtTVBWOGo1ZWdaQjI3bHVnRllQSG9keXNveE5Z?=
 =?utf-8?B?YU0yWHRGNkVTN2I0Smk2MEVySlNPODJHc1ZGZVVjNktpWSt4cFFXb3NaNHZi?=
 =?utf-8?B?OVQ5ZEx3QUVZMW1HZ1ExTXpxSy9aL3Q0ZWg3VmxwRWlxTzdKNzM3VkM4Yjh3?=
 =?utf-8?B?RGdqSWtrTG4wNzREcDVNWlNsa1oycitsZzFuVTB2MC9ra1RXQWlwZFNpSXpY?=
 =?utf-8?B?ZlgwMWtUdmdUdjhTb0ZSSnkvb25GeVNlOWdhT01RR0RmamxsKzBoTm9pN253?=
 =?utf-8?B?cEVNdFBBMVZycm51ajVXdlZ4RFlDMU1PRjlwdDkxZDBUSCtYRUV4ZjdpMGs1?=
 =?utf-8?B?bWdDWDlKcDJZSHZTT2hIZ0JtWWNqUEJ2NjJreGpRazNmaVhJTDFBK05FcE54?=
 =?utf-8?B?eG9SZ0Z5QjYxNHhVaXg3RDFOOGExdGNYYWJjOEdJUC9IanRicWNtM1VhbW5y?=
 =?utf-8?B?eEpXU0NVejl1dHJ3ckE4ZkszdkEvKzdvWW90d0dVSSs4aHVhZnRiNUV6SHFM?=
 =?utf-8?B?ZndZT3ZnTDl2ckwvSmZTWFdpMnRmUjVyQTdQNFoxbDc0RXFieGhBWk1xWDYv?=
 =?utf-8?B?UlBPd2YvUHRTY1d1K20xbkFSSlJ0RHNpdmtTT0ROSWpqMWxpNnVnWGU0QW9O?=
 =?utf-8?B?UGZOKzNMMTBOMm5aaFpwWVE2c0NiUzI1aFA5eFZRaU9qWXlHU3BjeFZFaTd1?=
 =?utf-8?B?UVFrRHFvQncwbGVoaWtuQlRUZG9XZWFyY3k2dDlsemM2bTB6ZzZXWkI5UnZT?=
 =?utf-8?B?UWdsTFJjbnVWMW0raThCYm91QWFCcURBRC9xRWI4ZWNFNW9ueVZBMzBJSGJp?=
 =?utf-8?B?cHdyUFVoS1RFUmpnby81Y0Y1RUFpbE5BV1h4NnFES01UMWNHOFUzc1NFZ2tq?=
 =?utf-8?B?dTYzekVDanMzL1JXVmxrNU9FSFBBdmt6NXcxcmN6WHAzMEhjdmxHSFJ5ZVFL?=
 =?utf-8?B?RkpPbzM3bkdrRXowdmRKSWs3RWhyZUdVVi9DYjFzKzZpY0Y3RHp3SGQxNjJq?=
 =?utf-8?B?OHJ4T1d2YVF1NXc2UmNKbWdDMGFrYlJuOUx5emRkeE9jSEpxNXhXMzRuMTda?=
 =?utf-8?B?S3BlM0UvK2pQVjhVZC8reVF6Sno5R2szcXgrenpnWXZNaXV6WkZqemNFeUxP?=
 =?utf-8?B?ait0ZGE0aGxyTnpDSXA0TlVxdVgxTzBUdWNJL1hzY0hrRklJRDN4Nm5mYWF4?=
 =?utf-8?B?NjVKOVNwK0VySVp3bVcxdWlzUFNaemtZenlwczliTFhkcHEyQ2VIU01BMTZC?=
 =?utf-8?B?SVNyUk5BTlM4ZzhSaGpTcWtNRWlXeW1RYzgxcGtYbDgwTFNic0FoYUExUkJI?=
 =?utf-8?B?VGtBZW5tUTdKR0VCMEFYODk4SjgwTkIzdmdER3oyUjZtekx2cWk2YllFRGtv?=
 =?utf-8?B?ZkJqanY2SXFMSERSTXJhOHhvQmlaTWp3K1pJSXowMTNFenJsVGNtTGt4TjN2?=
 =?utf-8?B?ZVdZaHJYNmxGTEw3MFgrTFNGNUVZOEZpcVVoVGt2UUh2WTByMXdleU55VllM?=
 =?utf-8?B?dExCYzk5Q2RKRDVmM2FuOGNpRCtiQkc5UHgrbnk2aWJWak4ybE5tZzVYRU45?=
 =?utf-8?B?aUo0cXM0REtzUy9HWXJ0Y3JKc1ZhSlNid1NYV0FnU1Iwc3JRbDkza1VoWkJ1?=
 =?utf-8?B?dEdCTzhnSE9zUXFHMFpzWlk3aHVySGxOUnBBcmpKZHdKWVhaaE5XNTU4V1Zj?=
 =?utf-8?B?ZE5FTHVBK2hZVnhoTk9pNVQwM0NKUFlHdktlUU0yTW9rNTZvSmpQU3ZZZ2ds?=
 =?utf-8?Q?ea6FSUiK3TychRGGHNYsuIxRfpn6YnDYsvCSK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 195d77cd-d9d6-4190-ef7f-08da4354170b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 22:22:47.1362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vqh4jSXyB1euh3WBY3r4fbfC+PR+5cJVwTJS7PkOlZiWVl4YXGMkahinWdRXMIjJTivD4gpDTwMDyWK/Ro6mdXoYbyeeraJSZIIJ9aVAeec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6118
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-05-31_08:2022-05-30,2022-05-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205310097
X-Proofpoint-GUID: g3AclTNAY4kSHlRsx85CWzGnn1XrWADO
X-Proofpoint-ORIG-GUID: g3AclTNAY4kSHlRsx85CWzGnn1XrWADO
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/31/22 08:18, David Hildenbrand wrote:
> On 26.05.22 15:39, Sourabh Jain wrote:
>> Hello Eric,
>>
>> On 26/05/22 18:46, Eric DeVolder wrote:
>>>
>>>
>>> On 5/25/22 10:13, Sourabh Jain wrote:
>>>> Hello Eric,
>>>>
>>>> On 06/05/22 00:15, Eric DeVolder wrote:
>>>>> When the kdump service is loaded, if a CPU or memory is hot
>>>>> un/plugged, the crash elfcorehdr (for x86), which describes the CPUs
>>>>> and memory in the system, must also be updated, else the resulting
>>>>> vmcore is inaccurate (eg. missing either CPU context or memory
>>>>> regions).
>>>>>
>>>>> The current solution utilizes udev to initiate an unload-then-reload
>>>>> of the kdump image (e. kernel, initrd, boot_params, puratory and
>>>>> elfcorehdr) by the userspace kexec utility. In previous posts I have
>>>>> outlined the significant performance problems related to offloading
>>>>> this activity to userspace.
>>>>>
>>>>> This patchset introduces a generic crash hot un/plug handler that
>>>>> registers with the CPU and memory notifiers. Upon CPU or memory
>>>>> changes, this generic handler is invoked and performs important
>>>>> housekeeping, for example obtaining the appropriate lock, and then
>>>>> invokes an architecture specific handler to do the appropriate
>>>>> updates.
>>>>>
>>>>> In the case of x86_64, the arch specific handler generates a new
>>>>> elfcorehdr, and overwrites the old one in memory. No involvement
>>>>> with userspace needed.
>>>>>
>>>>> To realize the benefits/test this patchset, one must make a couple
>>>>> of minor changes to userspace:
>>>>>
>>>>>    - Disable the udev rule for updating kdump on hot un/plug changes.
>>>>>      Add the following as the first two lines to the udev rule file
>>>>>      /usr/lib/udev/rules.d/98-kexec.rules:
>>>>
>>>> If we can have a sysfs attribute to advertise this feature then
>>>> userspace
>>>> utilities (kexec tool/udev rules) can take action accordingly. In
>>>> short, it will
>>>> help us maintain backward compatibility.
>>>>
>>>> kexec tool can use the new sysfs attribute and allocate additional
>>>> buffer space
>>>> for elfcorehdr accordingly. Similarly, the checksum-related changes
>>>> can come
>>>> under this check.
>>>>
>>>> Udev rule can use this sysfs file to decide kdump service reload is
>>>> required or not.
>>>
>>> Great idea. I've been working on the corresponding udev and
>>> kexec-tools changes and your input/idea here is quite timely.
>>>
>>> I have boolean "crash_hotplug" as a core_param(), so it will show up as:
>>>
>>> # cat /sys/module/kernel/parameters/crash_hotplug
>>> N
>>
>> How about using 0-1 instead Y/N?
>> 0 = crash hotplug not supported
>> 1 = crash hotplug supported
>>
>> Also how about keeping sysfs here instead?
>> /sys/kernel/kexec_crash_hotplug
> 
> It's not only about hotplug, though. And actually we care about
> onlining/offlining. Hmm, I wonder if there is a better name for this
> automatic handling of cpu and memory devices.
> 
In the upcoming v9, there is no /sys/kernel/crash/kexec_crash_hotplug; I have sysfs attributes for 
memory blocks and CPUs named 'crash_hotplug' that can be utilized directly in udev rule as 
ATTR{crash_hotplug} to determine if the kernel is handling this for crash kernel update purposes.

Here's the current commit message for that change:

====
crash: memory and CPU hotplug sysfs attributes

This introduces the crash_hotplug attribute for memory and CPUs
for use by userspace.  This change directly facilitates the udev
rule for managing userspace re-loading of the crash kernel.

For memory, this changeset introduces the crash_hotplug attribute
to the /sys/devices/system/memory directory. For example:

  # udevadm info --attribute-walk /sys/devices/system/memory/memory81
   looking at device '/devices/system/memory/memory81':
     KERNEL=="memory81"
     SUBSYSTEM=="memory"
     DRIVER==""
     ATTR{online}=="1"
     ATTR{phys_device}=="0"
     ATTR{phys_index}=="00000051"
     ATTR{removable}=="1"
     ATTR{state}=="online"
     ATTR{valid_zones}=="Movable"

   looking at parent device '/devices/system/memory':
     KERNELS=="memory"
     SUBSYSTEMS==""
     DRIVERS==""
     ATTRS{auto_online_blocks}=="offline"
     ATTRS{block_size_bytes}=="8000000"
     ATTRS{crash_hotplug}=="1"

For CPUs, this changeset introduces the crash_hotplug attribute
to the /sys/devices/system/cpu directory. For example:

  # udevadm info --attribute-walk /sys/devices/system/cpu/cpu0
   looking at device '/devices/system/cpu/cpu0':
     KERNEL=="cpu0"
     SUBSYSTEM=="cpu"
     DRIVER=="processor"
     ATTR{crash_notes}=="277c38600"
     ATTR{crash_notes_size}=="368"
     ATTR{online}=="1"

   looking at parent device '/devices/system/cpu':
     KERNELS=="cpu"
     SUBSYSTEMS==""
     DRIVERS==""
     ATTRS{crash_hotplug}=="1"
     ATTRS{isolated}==""
     ATTRS{kernel_max}=="8191"
     ATTRS{nohz_full}=="  (null)"
     ATTRS{offline}=="4-7"
     ATTRS{online}=="0-3"
     ATTRS{possible}=="0-7"
     ATTRS{present}=="0-3"

With these changes in place, and by using the same attribute
crash_hotplug name, it is possible to efficiently instruct the
udev rule to skip crash kernel reloading.

For example, the following is the proposed udev rule change for RHEL
system 98-kexec.rules (as the first two lines of the rule file):

  # The kernel handles updates to crash elfcorehdr
  ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"

When examined in the context of 98-kexec.rules, the above change
tests if crash_hotplug is set, and if so, it skips the userspace
initiated unload-then-reload of the crash kernel.
=====

Does that work for you?
Eric
