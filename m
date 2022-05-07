Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18D851E8EE
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 19:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386600AbiEGRgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 13:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbiEGRgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 13:36:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9D01F61D;
        Sat,  7 May 2022 10:33:05 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 247CUdLL024483;
        Sat, 7 May 2022 17:31:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=E5GrCMy0uDz2rPQGAMFc8in+9mcsdm9pUMC0x2EoLUo=;
 b=Zwv6lMEidXb14AK9233ujOoHqwABN27TK/PGXon8IJ/EWugIGbVYLR3HPxJ36RG8Gx6V
 jUUpLo/hLgwKIbS68oJ10z+QlUuQ+WK0Fhf2X5/fznZsJzwgYTVEBxKqS8xJADOz4AB6
 8wpk+Cy53TW0UNy7KFIJaGdbF/gOUSXrjB/7PRdQKcGEJrZtZ4GZaR04Omn50/MfXB72
 BUYVsNDyO6DjcmzDuLrkudBXNl5oc0vmitA9lcIbB8/vHoUC6XAG6eBHAq2vIDrxie+/
 za/04yB63NVRFhq/6avygw7+ujKSqKX8DQHrjkAQzBJqQtHK3bk3THJ3344PK0LtwjUh gQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwfj28qjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 May 2022 17:31:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 247HQnkx034248;
        Sat, 7 May 2022 17:31:52 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf76v9hf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 May 2022 17:31:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADoaXS2iTxetTcy/N7LayjJlJnxGAKJBPgHnSfAkaw/grggGVjKXC6AQ+1Z8v7CQMF0Z8BITWoGwm2cQCS1Y6r8Q4FfLyh1sLVd8sEAthG4ISTZQE7F4cogBSmqGwdutmLrNlmEYdauvzsv5g7RfyvQcpN2JKMQgHhC0+laQ4t1Tfgj3KDNPi3DDZdT+RrakOhEodUCivBxoWK49KesbrT7aI+LGgmfNlGHZYVIWIqp3eQSFAIx/O5Tb5pjRCXpwOnf1qp5yIqGlM/aYZ5aOoiIJ7yDuRBnTCC4G8olIJLEDXxjyNSx+Y7gvk8zqlRuBlIEVfHMaYMRRpldMxKWmAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5GrCMy0uDz2rPQGAMFc8in+9mcsdm9pUMC0x2EoLUo=;
 b=FIKjzwjOeL26GdCriGHcuWec5s1CsrhNpmLkO1mIjd1KxtHwU+cbhl84gAOS16zPhAhqu5DHi2SIJYJvXfpoQTnR4eBju9fhZREoDvTOGSx226dJaZvnsMNXDSZLquYAZP3A41Z9xy04qOCRVEyzuJ4xKnIEArkBoJvb+yaIC4N0wSVgqqkurI0+hU80NTmsiqpZdD/7ePQpTCRyJ5WSjmlDw84klK+c9zj2/8wy2yNEP7wgRnY/3jbo4Hb9mOaOgwUsZBmZZLAmvmQIfgXotKgF2TbvsJIHPKNWgiUO1rQdZhEfcF9CQJ1hzcC/B0uPBZJ9j5qOZxziCdgxIDAUDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5GrCMy0uDz2rPQGAMFc8in+9mcsdm9pUMC0x2EoLUo=;
 b=qHwv3EOS2BTpSVsjD00ifzqenGmjyEp8CgCpMcrxTxZQNfMluqIQGWsaDhju+TPgF7XPzSW9r6Vp/2J6mhdnCaweljxo7sOrVZe7W+0Lc8e+mrBI0yxn7n0nTAgsTiuGklW4TciLG75JwXf+xJoYTDAxFE5rYjH+TrAog1AFV8w=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by BLAPR10MB5011.namprd10.prod.outlook.com (2603:10b6:208:333::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Sat, 7 May
 2022 17:31:47 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::fd04:eeb:d7ba:3642]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::fd04:eeb:d7ba:3642%5]) with mapi id 15.20.5227.021; Sat, 7 May 2022
 17:31:47 +0000
Message-ID: <b399d57a-3773-a78e-94f7-aa6829568080@oracle.com>
Date:   Sat, 7 May 2022 12:30:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v24 3/6] arm64: kdump: Reimplement crashkernel=X
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, Zhen Lei <thunder.leizhen@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        John Donnelly <john.p.donnelly@oracle.com>
References: <20220506114402.365-1-thunder.leizhen@huawei.com>
 <20220506114402.365-4-thunder.leizhen@huawei.com>
 <20220506231032.GA122876@MiWiFi-R3L-srv>
From:   John Donnelly <John.p.donnelly@oracle.com>
In-Reply-To: <20220506231032.GA122876@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0088.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::21) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecbe7baf-3eeb-4908-715c-08da304f7619
X-MS-TrafficTypeDiagnostic: BLAPR10MB5011:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB5011887259FE77C26D033AA5C7C49@BLAPR10MB5011.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tnKUNCcaLU7H08IPvxh6oiGb9BZ9zb94cHVgPxk+/pMzy9T5VdN717gm6JB/g1RjVGeXDyGWGIGpATsB/QodM1LTQ84Vh9L9XKMR36y4KQ4I+kv+cA5viaCIaZx4dLmDmOjtCQb6ATaSHYNAfLZ4jTiPfLg7/a9UHy/p/XbKIVt0Br+Epuxp6xwxaWpZieGndOhbxvPt8VAQtxOqSbu+AQo1QLHibvb+J0VrIeru7sEq0DuGoyf+IwhxNTnHdveTCB5CmGxs0pnOgu401ocqgYdw4qSZzLHoXJpgQR30CRKpxmkkb1f/GDO/CXUT97iXaxmI4xl0nNsK9X2JBxU1nlnrlJBc/KUNKwMJUENPlamOQOyORz8vpVwKCDleUxwI/qaoocGzb/9PVMyK+gDR5y5LqpIygu/PDM9mnYgVlFW0TbBNWrfZ88XgBprzuSfoh/dU+l/uP8JtY4Kn/91PXrwHjzYpkrtK0z5PlzjRQXLT0lzh4lrbwgBuMwCu+izdeZoJaZvbhiDoQ99jgufH4+jVVrm0eD42RgslR1CWX7SSUY7fGjBSHCsc79oDwAbFPqdF2saS0NFp7yHJ13sffmHc13BY4f71i2BfpIpbarLPARwrSDCGMfS2VPhDp0z1I458RU4JQ6G2eCUCkhsinrv3ySd3B0KAbD2TMINM1GtodxVmr8qFBIU/U025WLjJQxowbHceGW7PTJJycRLV1fzNZWBpE3WAyzB6a1XgqCY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(4326008)(66556008)(6512007)(26005)(66476007)(53546011)(66946007)(38100700002)(6506007)(31696002)(86362001)(8936002)(6486002)(5660300002)(7416002)(508600001)(2906002)(6666004)(54906003)(110136005)(2616005)(316002)(36756003)(107886003)(83380400001)(186003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REV3RkhIUVk0RWdTSVVFbGFaNlFPRVQ0YVY5YVh6NVJlYlcwQlQyYWJoblhH?=
 =?utf-8?B?VUN4U2szVHc5OXpSNllTVGt0RnFJcXNYNHVjbGR2d3JTa2xKZDN4K3hvc0Fq?=
 =?utf-8?B?cHY4RWpCSThKckZSbHpjV1lwZUwwUWJpbnU4WFl5WXdSTlMrMlAzckk5Zi96?=
 =?utf-8?B?QmtidjV2SFZKbW9hUWhOV3ErbEVTQUw1T2RWQXNUcCtLRk8vbDRlaUlNOERU?=
 =?utf-8?B?UmRXZ2xLdlRWUVFPUHhsQ3YybURtblN3OE1mWjMyamJqNEdxZXJLc1VSbzl6?=
 =?utf-8?B?Zitxa0hZQk5FYjFJdzgvWm5rSzN1U3JyaTFSNm1wZnpxNThELzRKYit0b0Jx?=
 =?utf-8?B?bzVXOHFLRlZDUnoxaXFPYUE3VmhRdXVIWFFlV1JoVlJqaUk1RVFPTUg1UjNE?=
 =?utf-8?B?SEVsMU1tcXZwc0pqTE9CQWhqVXlsUzhQK2ZaRDB1UTlKQzdqN2dXdFhoS2M2?=
 =?utf-8?B?RnJLSkhKdklHN242RlZVVDRaczBXQmFXcXdDWDVTR3RjZlNpelRXVFN5UXZW?=
 =?utf-8?B?eFJYVWRsSTJBdGZ1TysvMjR4Tm5TV1NFQ0hNbUQwVTZ2amwyTk1Da2RPaW4z?=
 =?utf-8?B?aVNDbWU3c3I2M2NFMkI4anpha2laWC84VXVNT0lyQ1MvdXU2ZGpUdWs3Y0hq?=
 =?utf-8?B?Rlo0MDg3bVdrS050THpZVUVqZTN1WmltbXRHOGxBL09kenZXTDEwNXF0eWdZ?=
 =?utf-8?B?RFdBazdMQXUvUzF4QW9jdTUzS0drTlFFV3R4dXp4Z2E4ZXB4VlFCODVqaHJu?=
 =?utf-8?B?TTltT1VmVkNQN1JtSE0vWkFWMHM5RnorTm1kZzFxSDNlOWdrdXREaUY4TEZF?=
 =?utf-8?B?VWxiK3NpRGJIL1R6Rk9nZFg3S0VweFJ2SThJa25tV1MybUQvY3c5S29oSEhw?=
 =?utf-8?B?OTEzV0NlZ1BrWlFkRWYxa29EZlpyd3hlYXVsb0JoT2RCR0dEMjJ1ekhMcU1B?=
 =?utf-8?B?VnZPVldRMnJJbUx0anZJdW8zK2t2eXQ2SUZ1QjNvNGJ0NlZlaUJad0pnNG50?=
 =?utf-8?B?NFhDQ1owR2dOY1V2bS90d3ZYNW11VHFneGlYVVdrMVZXejhrN0xKZEtJVDVO?=
 =?utf-8?B?SU0wUFpNbmVGSjlwcTRheURJUjFBc0JxSWFXSktIYUsyQjc1ZGhHUlNqK1Iy?=
 =?utf-8?B?SlFTZlBFdVlJcmZqcjR3QkVHa3haaWY4aHkrY1Q4VlNPY2thZ3IvWENKUUtv?=
 =?utf-8?B?MGplQ3YvVDdkbmplTGRJdG4vaFJXNmM4Z1V2SWxTVWViay9QbUt6WlpiZUJt?=
 =?utf-8?B?OGVKSkZjUGprMUp5N3hqNGw0bllOb1VzZ3dSNXNraU1id1d2WWVIV3laNHdE?=
 =?utf-8?B?VWd4N0RFenVvcmNhNk9Gd2ppaEx1VlQ3VXZIZkhKUXRGWWtCMzJXWXpHbXh1?=
 =?utf-8?B?U2FuSWZEWGQ4cE1FYlVSVEFaaWF0ZG9JeENYblpRb3oveU5VNG5LZ2xydmlF?=
 =?utf-8?B?M25GR09ibjEwSWIrcnRaOHg5UElJZk51SjRXdCtxSzJUU2pmUVlRTWI2YnpU?=
 =?utf-8?B?UDZqR0FDRG9LaG0xeUdmSjdYdmp2dEcraTdZVEdQK3JMOGZCVlVoaTUvZi9D?=
 =?utf-8?B?VnR2ampnSUczUGZmSHJNZGVMNzVEZjcxbGx2WDUwdGhrT3N4Q1VwWm9xUitr?=
 =?utf-8?B?bG1RekFhWk1pYmlkdHBuQ0lRcHFWNGRJMUdSWjluVFYwTlk5TkFPV3dTYUdK?=
 =?utf-8?B?YXhoWmVuNWw2bzFFNlo2Z0xjdUE0VElZY21TemdWamEwbFVsTG0yZ1FYejlK?=
 =?utf-8?B?MlJLbERiVjE0Z1lXeDRjTCt0YXdtbG9XNENVOE9tNzhvVFdydWhPODZXYld0?=
 =?utf-8?B?TGtRRVpUaVBXWkNLSzdGL295bUZ3bmhaelNBa0p1WldLM242elIwalZEVlZL?=
 =?utf-8?B?OUp3Z2Rwd0JyWVpOaVgvTkl0eDQ4S2h2bFVlQzVTUWRWYU9iVnJPZi9aN09U?=
 =?utf-8?B?azFSY3RuaTlKaXBnRytST293TFdOL1hkSWVtaGpZZUtZNDcxbGxReklsNDBX?=
 =?utf-8?B?VXlaWjc3WEl1YXVEWmNiQkdXRkJWcU9acDUzdms4eWhRY2FRTUw4SWNVSGcx?=
 =?utf-8?B?UTdiNzlZRjhrTWliL0xnOWFOTTRtZlhCOXJudWVjeFdDbktueDZDK3F1RFpI?=
 =?utf-8?B?VHpMNE1lbXNZRmtNWTRYQkdCdm1PY0puNDh2MFRYVHcwN2JGc3oyWGYwYk56?=
 =?utf-8?B?aCt5a2ZkTjdVMU5kMG1RTzlFWS9ZL0c1R0NIV2dNTXNJa3ZoWVJaNWNoSFIx?=
 =?utf-8?B?bDNVMnYwSUo5Q2UyM0dObHlRTVgwdExXVExCaU4yRVFsUXlrTVJXaDRmN0Vv?=
 =?utf-8?B?ZHdxYW4yTUtmZkxLMHhKVnc2VnBKcWpzSW5xU3pVUXU0R25Vck9XOTBRUGtF?=
 =?utf-8?Q?hhZk9Nt8H0Mlq1v8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecbe7baf-3eeb-4908-715c-08da304f7619
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2022 17:31:47.1086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XVOc4a9F05fBt8BPqaLod7yyGnfO5K0a8LlrG67p3dfzutEBMH9MU1R5SID03VBSyI8oKEDwgNWcMOA1CjJUHYoe1+RYU4S1CHVTVf0qJPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5011
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-07_05:2022-05-05,2022-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205070121
X-Proofpoint-ORIG-GUID: HZ2M05t3WgIk8YuD32CRZ9fz7cYltURN
X-Proofpoint-GUID: HZ2M05t3WgIk8YuD32CRZ9fz7cYltURN
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/22 6:10 PM, Baoquan He wrote:
> On 05/06/22 at 07:43pm, Zhen Lei wrote:
> ......
>> @@ -118,8 +162,7 @@ static void __init reserve_crashkernel(void)
>>   	if (crash_base)
>>   		crash_max = crash_base + crash_size;
>>   
>> -	/* Current arm64 boot protocol requires 2MB alignment */
>> -	crash_base = memblock_phys_alloc_range(crash_size, SZ_2M,
>> +	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
>>   					       crash_base, crash_max);
>>   	if (!crash_base) {
>>   		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
>> @@ -127,6 +170,11 @@ static void __init reserve_crashkernel(void)
>>   		return;
>>   	}
>>   
> 
> There's corner case missed, e.g
> 1) ,high and ,low are specified, CONFIG_ZONE_DMA|DMA32 is not enabled;
> 2) ,high and ,low are specified, the whole system memory is under 4G.
> 
> Below judgement can filter them away:
>          
> 	if (crash_base > arm64_dma_phys_limit && crash_low_size &&
> 	    reserve_crashkernel_low(crash_low_size)) {
> 
> What's your opinion? Leave it and add document to notice user, or fix it
> with code change >
> I would suggest merging this series, Lei can add this corner case
> handling on top. Since this is a newly added support, we don't have
> to make it one step. Doing step by step can make reviewing easier.

Lets get this added and tested with a broader audience. It has been in 
review since March, 4th 2019 - 3+ years. I applaud Zhen for his 
endurance and patience in carrying this for so long.


> 
>> +	if (crash_low_size && reserve_crashkernel_low(crash_low_size)) {
>> +		memblock_phys_free(crash_base, crash_size);
>> +		return;
>> +	}
>> +
>>   	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
>>   		crash_base, crash_base + crash_size, crash_size >> 20);
>>   
>> @@ -135,6 +183,9 @@ static void __init reserve_crashkernel(void)
>>   	 * map. Inform kmemleak so that it won't try to access it.
>>   	 */
>>   	kmemleak_ignore_phys(crash_base);
>> +	if (crashk_low_res.end)
>> +		kmemleak_ignore_phys(crashk_low_res.start);
>> +
>>   	crashk_res.start = crash_base;
>>   	crashk_res.end = crash_base + crash_size - 1;
>>   	insert_resource(&iomem_resource, &crashk_res);
>> -- 
>> 2.25.1
>>
> 

