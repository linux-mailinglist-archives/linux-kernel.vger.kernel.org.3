Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318EF4FBDE3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 15:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbiDKN5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 09:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346808AbiDKN52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:57:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5622613EA0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 06:55:14 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23BD2vTu029074;
        Mon, 11 Apr 2022 13:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3LONWzII33yBEXD08CrUokq1iYBaWyNYSJNWvWlHnf8=;
 b=uEQ7Z5+ABUTY1f+piyOAhIaJHWexXUb9DW3RdwiVcbRaUm9a5SqDpVPpMQVc4u0kthpN
 RuHyTQRHczlwibn/7O8rFqAj5cH5arDjxnTdrFOnZydUtlNWWA1d1TQod1yvviV9kAdS
 ADzMvVaRptq7PE9Olc9zQrTBA3obeQO9VORK/0+M/LjzlH5FAUdhF0BkMs3s4a0tXsIc
 qWU2VrlSztJNcb+hDZgPmKz4MedNgKNKYAZ2FbAesIZdOcId8EHB2+qcuihB8mbT9mEP
 D613s2ZGEq5E5/8pPruz6/tacq7SsNrfQiyA0Y3uVBAv8ezOC/3PvmqAn6UYGlTgxxHO DA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb1rs3quj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 13:54:38 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23BDjiPR030418;
        Mon, 11 Apr 2022 13:54:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k1uhrt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 13:54:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDTK+DkrHEvb6lb9xPE0WPZe85nHTvOcbr3Fl/wfkbnhGzUN8fWfJz/eVj1erdzfXfL3xLWtXr8fYRZPev/6iMX1hIrwCAVxLGzNoPv9fkgKhalyvw1LlAQ5m8XwxvNrUDViL/pls8gOtSOoB2cuda68v0J5bIw0iguwolDi8qkJY6xLR4ds53E3cLsgu7JJWMF0CrKmpVPE1u3VeKYwmQeVB0oBxcnFZuAuq35d+ABDbpeCAKY789zO9udoLHr3micDyvZe3LqhpAvZA3ARhDkH+9AU93UGaQteehDWuKIMazGTMXZ7MdBf7FmyII0gTse/wOQI8E2PghjyMPPh8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LONWzII33yBEXD08CrUokq1iYBaWyNYSJNWvWlHnf8=;
 b=L/ypFjVADOKUJbehcHjBUQ1NPoeKiF9BrapFH9PmjQ1oSaoZKKWny7tYqMkBpu4ra5H/q4neBxkb+mcKEUsrm1LDu8SKQsUCI3l8j2TqrD1zoxN4q2aURLzWck6QOXL4M9Zshsc6phVZ17LNF/W/MCufjHWVsBRPYW5fArR6IKo3aBDsoCX5qQokhC/HQ8TrtyjfB3YUC0GWp+apbGYM0Je1FKeuln4cPTMMnHa+8wssXq5pi/l68Q0OREavZBeys4iucb40tUdOqHsy94IlplkxQSyeDSFsP0BSfEnO0KcmuF2T4opOOAG+A7qlRtHEdh1pzPiM6upIl/JG6/P6CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LONWzII33yBEXD08CrUokq1iYBaWyNYSJNWvWlHnf8=;
 b=zqUHKT9oRxbsheLjvtSZuPLqPnvQyD9Ki4BRLIQiGQlB8xrNn+UdQqht+USAEj7PmowevSbSrmpbFTodcVc3XzTqFP2sN/QiSKe+VaPBAbZ6SS57ceZ4EMJudOasb9vmIk1lI4E4kU0PyaaoLIcwBl7QAq9EYLZf9sDjvrertT8=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BN6PR10MB1379.namprd10.prod.outlook.com (2603:10b6:404:41::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 13:54:35 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::65fa:78de:f4d:1a5c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::65fa:78de:f4d:1a5c%3]) with mapi id 15.20.5144.030; Mon, 11 Apr 2022
 13:54:35 +0000
Message-ID: <657edaae-cb56-9c01-383b-680a0e95f722@oracle.com>
Date:   Mon, 11 Apr 2022 08:54:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v6 2/8] x86/crash: Introduce new options to support cpu
 and memory hotplug
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        akpm@linux-foundation.org
References: <20220401183040.1624-1-eric.devolder@oracle.com>
 <20220401183040.1624-3-eric.devolder@oracle.com>
 <Yk/tMnoYN/p6vxxT@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <Yk/tMnoYN/p6vxxT@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR14CA0063.namprd14.prod.outlook.com
 (2603:10b6:5:18f::40) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e0ba774-c5d1-4f93-4a54-08da1bc2cfbc
X-MS-TrafficTypeDiagnostic: BN6PR10MB1379:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB13794BF005F01CA54C8A85D197EA9@BN6PR10MB1379.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P+5e7Y2DFDhklUTb6bnyAg0LYOYFSVvTCx6jf2sBis3BF7xJCaqQwLi9gRaFkFmRRfj1XDszHwkzk6MM/Mj1SwehBM9fc97EY2WX+50uzsvTPkWdp7m2mBvmgTaGsUejlxYrfVM6KxpbTkpVz/0Dk7XH7GGf5CSdE7OeWB2U4Ottu/X+lIxziZXm6wcOL0H0kt6WfFR7DMsrThGIdlHzxQsKSAnIanjqIyUY8mCOJQ6hq1r4xCkh8R1bf/NsF7JuNGbIAXCtUsdfYp2W0F0RBrQbz7VtuHzhMECmdQLf8YOR2+EcX6ZhFoWhu5aX1T+OXRrp3oidke1YbxJMu8J8fAFa1uhrCD30jhAlkcttL3ZxbZVFovK0juYQd6FU34bwjItnz7Euxt3ysBNVt90+TfWm5xR87PrmdXD/QSSUUhqnk8SPAW6Dbw6JfTkcBAlwyYNaToIOnSIFs4NB0lXH9idOgutIux4HgAQ9JUK53KdrJoQDv8Zv81yFb9grLiVnPOOIU6xzj9La+YBXvmqPfihjnCCHYHux/Cj8JQDlA8vo43FXR/w4IF/1PF1RjFucfZhRKt1/XxcL3G9ihWA+sx4wxbqJ4/b4Mof4WQrl/86XWKNoZsB0gz2g2yX0cYj734QD4w+LkUbDFXgoQ+3l9cMTAFRbuAyTcCifRUcfGtSiFyXzDM1s5G2ImOGtvoPlu2puhdRxKmlHiv3HpW4c78tFC906rbFuur7InG82XNgcLkcqrzShA42xTZGxCgZa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(38100700002)(6486002)(8676002)(86362001)(66946007)(2616005)(508600001)(8936002)(66476007)(66556008)(6916009)(316002)(53546011)(6666004)(2906002)(6506007)(6512007)(83380400001)(31696002)(186003)(7416002)(5660300002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHRDY2gxeGJTTW4vUERZNW9wd1VTNGhXK3RIdlVyWGtDSG9lZGh4enJRVEJE?=
 =?utf-8?B?YkxDWUVLZm5RMDd3Mkg5MFhSZSsrVU83UEt6dm9qK1VsUlhGVzRzU3l4N2k0?=
 =?utf-8?B?bVZrUk1SOERoUEJEWGIvOEZYakk1RmJOdVNtNmJVTmVGSWdwdmFqTW45OHFD?=
 =?utf-8?B?aG44YTMrRjJJUWg1eEI3eE0wREkrVGhQSjBBVHgvRUQzZVRMWlI2cXNvVyt0?=
 =?utf-8?B?NnlhWXljRDcyRytJWi9BZDloaTY2RytkTVBxRnhLN3hnNlRISUs5RmpsWWtp?=
 =?utf-8?B?K1cxV1RRd0xkTDVFd0szcitHRG5UZkVrNEJEaVJVSDJiWHVMbWFFcFptbXR0?=
 =?utf-8?B?K3BTQnFRVUVrWmVUVzFkVFU2a2lEMXFUdUQ4TFYvbnJUY0pZc2Y3S1JsenNM?=
 =?utf-8?B?bXhzVnVETG9uVmpLREVCdTdQYjFVRDBFbUhBS20zZm9UNmdoU1F0SzJhNDc1?=
 =?utf-8?B?RU5YTktQc2RSV3FxTkw4QWJ5UTdSdnZzUDI0dCt6Q1JYbm5LUzRGV2pHcWlJ?=
 =?utf-8?B?dmd3cDJGKy82WGJUalJsWGFYa09QQ3p0eUdSTGdrMG1meDVRYS82bytnWUhQ?=
 =?utf-8?B?RFczM2xRWFRNN2JoRVR6ekQ2am8zN1oxZVVUN0crcnY2eGd6am9kZXRKcHgr?=
 =?utf-8?B?WEZkYkdMSWRxSVAvbkJuZzVzZUtNMUdiNlNXdmpwYWh1bjhsOVpDVEpKMFA5?=
 =?utf-8?B?QnNjMjdxUG80T3lqQmlGNGRxNzBpVU9LNVB5ajZwdDRFNW9STTVWUk45VXlG?=
 =?utf-8?B?OVZjMlZWUjlVR2FZTjFxcGZFUnNoWmoyTy9pNEpTSGN3UlllWThXUmxKOTdT?=
 =?utf-8?B?dVM4cUpJVGJEMXVaL0hrTWM5OVlVWVJCYk9PVUdkdGRtVkI5eXlGWGkvTFlN?=
 =?utf-8?B?WEJUNnVvYW5PWFlNdkh1ZWNRZkNMQlBQMnByN05CMUhpT1d1TWpNNDFtZExL?=
 =?utf-8?B?NXRPckg3T3gxb0VCd3oxOHpHVVE5Y1RnZUtWMEN0aU13UEM0b0JtTmErUk04?=
 =?utf-8?B?d25TazI3OHgvS2hsTFl1WkNZTzh4czNCMXNmSlhxTEQyaWMxMVFkM0laSlNP?=
 =?utf-8?B?S3dwTVE3UTl0alJwV2ZGQ09vUEQ3MThFMENMWUwzZEhlRGpxcmJHRmowRWVC?=
 =?utf-8?B?MjM5RlQ3d0hrRGtTN1RiV2J4eDlHSGtKaXNqNFN3UFg4Qk1Oem90NDEzbkNa?=
 =?utf-8?B?WjRad2dMdlZaeVRxRC8yQzVLY3NRblM2RmM0c0FyUmhyMFRpVkw0bDFYZ0xF?=
 =?utf-8?B?c255dFBsSlNLR280VUVQck0vSG9WQVE3blp5WDdnSXl5WldiYzExeFYwY1pO?=
 =?utf-8?B?T1padnlMYkRiMnZUVHg5eS9qcHl0ZWNiZlZZL3BxOGFjQTllV1RIalBkV3dh?=
 =?utf-8?B?RjRTUGVlaE5XUWxaajlLYy9jRldHTko5QjdpTGtvV3RQTmJNcHgvSXNuTnhw?=
 =?utf-8?B?QmFWTEZ4WVRSNUIyM2ZhbXYyb1lLaW56MFpsbW53MENtUHZBRXNwSXRjOTlF?=
 =?utf-8?B?Mlg3UWVHRTQvalAvVEkvUzBBMmp5K2RGNVYxOEJtWS92V0dpTFpkc001VzJZ?=
 =?utf-8?B?TmdvWkRscVJyZC9VaUFGTU5VTHFhV2RHNkVKeDQ5aFdEQldYQVJ2OEtqTEt6?=
 =?utf-8?B?UjlBYXZ2bWR2Y1lZSXZmbmJ5bkQ5Y0YzNjgrNlJ1YmZSOWZYNExYRmdpc0lw?=
 =?utf-8?B?MEsrR3JHV29nQjlaS1BTbkVjbDlDRmErUER1bU5yQnVXWVIzR2w0WHNwRm8w?=
 =?utf-8?B?MXQ0RldYeStuYmdMZ0IrUmk1QkxZYUZpU09VczVEMFU3ZU04RTBkVlZJU2JM?=
 =?utf-8?B?MkxBS083OUQ5K1V3KzlEcEpFdWc3MmVSV3JPMWRUd2d3R2k5N0wyMUhGOUpr?=
 =?utf-8?B?RUpZeStIeDNOMkZHb3V6dXcvR1d1QzVZNHNFRkhWZk1lRDc0WEQzdjVqTHhK?=
 =?utf-8?B?eVBScHp1SCtvTFRFOWp0Rml1QXJsMnVXWjJOeXVpRFRDU1RWeW5BNURiQ01D?=
 =?utf-8?B?ZXlnMzd5SlhMZnBrQ0IxTFA0ZHFabDAyKzN0d0F1R2FlSWFieTI2a2Z0d0VM?=
 =?utf-8?B?RTcvdllzWDlEVmgvYS9Jc1ZVTnlnV2JCdjUwMk5KTGpOUGF5YXdHUlJWSjdp?=
 =?utf-8?B?RENWRGh1MkZYNFlpbmZaNENPUjdHSWI2Y3VJZkU1ZXJzb1J3U1l1SDJleVNm?=
 =?utf-8?B?alF3NFBXRERCYU42a20rU3F4aHZkR1BIQjZwWUQwcW9GL3pVQ3RxcHhqcVF5?=
 =?utf-8?B?WXdHclBSSGQxcVBLWFlYb1NKdGRvRVh2S1FyNC8zUUt5YWJxMWt3NnNGVHlm?=
 =?utf-8?B?S0pRL0x4QS9rRC9EU2lJTTRzbDZMamV0Ni9GcTR5cUs0d2pickFVSjA4Zi9U?=
 =?utf-8?Q?d8X0WrozuyFw8Ljww+fRY+5bkTNxv7Vjc4is9A29QtqSo?=
X-MS-Exchange-AntiSpam-MessageData-1: H+eq+mDQJIAQ7g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e0ba774-c5d1-4f93-4a54-08da1bc2cfbc
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 13:54:35.1206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FpAMdNZiArX/7/rmKak6ND5BnjMK3vRHixPrZhGZ3pVbuy81jv80CJEKjxOchmOfJOIMU4ihY7MpycyNRAH60lyEMK3AlTpUkMKuQz5BUL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1379
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-11_05:2022-04-11,2022-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204110076
X-Proofpoint-ORIG-GUID: h6a6yPmPDJU6iLO1fZ-97RgumwQRz4hn
X-Proofpoint-GUID: h6a6yPmPDJU6iLO1fZ-97RgumwQRz4hn
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/8/22 03:07, Baoquan He wrote:
> On 04/01/22 at 02:30pm, Eric DeVolder wrote:
>> CRASH_HOTPLUG is to enable cpu and memory hotplug support of crash.
>>
>> CRASH_HOTPLUG_ELFCOREHDR_SZ is used to specify the maximum size of
>> the elfcorehdr buffer/segment.
>>
>> This is a preparation for later usage.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> 
> LGTM,
> 
> Acked-by: Baoquan He <bhe@redhat.com>

Excellent, thanks!
eric

> 
>> ---
>>   arch/x86/Kconfig | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 7340d9f01b62..8b51d3196b82 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -2072,6 +2072,32 @@ config CRASH_DUMP
>>   	  (CONFIG_RELOCATABLE=y).
>>   	  For more details see Documentation/admin-guide/kdump/kdump.rst
>>   
>> +config CRASH_HOTPLUG
>> +	bool "kernel updates of crash elfcorehdr"
>> +	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG) && KEXEC_FILE
>> +	help
>> +	  Enable the kernel to update the crash elfcorehdr (which contains
>> +	  the list of CPUs and memory regions) directly when hot plug/unplug
>> +	  of CPUs or memory. Otherwise userspace must monitor these hot
>> +	  plug/unplug change notifications via udev in order to
>> +	  unload-then-reload the crash kernel so that the list of CPUs and
>> +	  memory regions is kept up-to-date. Note that the udev CPU and
>> +	  memory change notifications still occur (however, userspace is not
>> +	  required to monitor for crash dump purposes).
>> +
>> +config CRASH_HOTPLUG_ELFCOREHDR_SZ
>> +	depends on CRASH_HOTPLUG
>> +	int
>> +	default 131072
>> +	help
>> +	  Specify the maximum size of the elfcorehdr buffer/segment.
>> +	  The 128KiB default is sized so that it can accommodate 2048
>> +	  Elf64_Phdr, where each Phdr represents either a CPU or a
>> +	  region of memory.
>> +	  For example, this size can accommodate a machine with up to 1024
>> +	  CPUs and up to 1024 memory regions, eg. as represented by the
>> +	  'System RAM' entries in /proc/iomem.
>> +
>>   config KEXEC_JUMP
>>   	bool "kexec jump"
>>   	depends on KEXEC && HIBERNATION
>> -- 
>> 2.27.0
>>
> 
