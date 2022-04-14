Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DC8501E77
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 00:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347127AbiDNWc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 18:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347197AbiDNWcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 18:32:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08F7C4E35
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 15:30:25 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23EKYWWb028126;
        Thu, 14 Apr 2022 22:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fGmGBd3FXox5aoncahwgNeps9DGuzv34873c5VfeA58=;
 b=w/YiyntIjjHWciVZtUfFPWeRJxRIpVGKhItLhcwEdHsZB2gz/EY9bVs/jk2kZFoAnuw0
 V0F2I8i8G3jXkVBKfHOqvr658u7UMGusa7LSlALNzz5I9GCiRyliJt5WJZx6rt5W4xJb
 Jx0ejQJtFmLU4BI9WJomeArE+Mi2GWG50fu4okkUjkS+izxXvC5zzF2wJ1TaPvZARlQL
 W0jtVkSktXHO/VZVv+MJM6Fna/FGRBThT6j6IrRSVXzQzKHl3yIfdV1tqnzrtuVNydIn
 jKp4uLsYlR0n6YNwA+/MlL8jh/nXPs6fvX2rBTWdQOGuKF4hKPmw9zr43NaiaPoHtBZc DQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb21a5kye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 22:29:53 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23EMHP3L020892;
        Thu, 14 Apr 2022 22:29:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k57fhy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 22:29:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5AgMJ37fDS/liRQuV/y2a8SIIClVQRfpZIH/R4iztD3RZqF3p8FeJ+1rH6luXqDQlm5URrB6U/TXmj+0V5h1Pi3ROYORyvXqCtDQx7GF+EjujcEn4XN+mjSZz8FCPalT+AHpuADyEY4l7UPDv4bbaQoG3GOK3kdijTnj6jmkMan4HhqLQ86h6uap7L1/tgewzuYWy5iwfVW+jqE2NND3Czto/MvhrhSEOYkr2xW3NJDe3M1L+LJp7ZRMIrL7JPKixs3ppTQ6MkLa48bZNg+jD+fb7mHTXh+/+SIA57XXWHhOYNCu5iJc6LPY6LzVD4RqEPnqS/dFoN8RxpnAJjKpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGmGBd3FXox5aoncahwgNeps9DGuzv34873c5VfeA58=;
 b=DYDN5VNL3Ud+DztTRwY5oifHaoIIhJDheoXQizEs4JQKbostM+xBCHbRH43GZHq7T/GAKFShYGGMTlpEINoL3mHWaS6/B5PoAopcN0gJRNM3iuqFkjiNwoMrfWKGzcEpVYBcFSicVm62JIHwkcm4mKx69i40sKoGuuzwBXAIXdfxtP4c6dp017b84QVLJkPOdB7OiNnHN1HgkepBCFCR/6V70X+rN9YxeNtgDfEGWtwpweKmpYnfal8xgoRts1dIypYAnjgEGD9X4Or1LKdEs3oVxKA3RiLYnP4kJn4sah/dYud/VGfx9cLxrvC6RTetvzRD8bC+DSXBQL+bOul/sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGmGBd3FXox5aoncahwgNeps9DGuzv34873c5VfeA58=;
 b=W4lnZIQfdZV6gZHfdIHBK6j3+6FCMEo5jWb5+aK7oPx7+usbYpbUdQLQO0SpIk5vTWH3OTbmBxYZ6OtGZevJcB5Xa0bMxhJQllRr5NTFT6S4sbsIQQZbx/TazUC6G0Lmodh/7WEZsZ/AB6ozVtSlgyKxmoi7SxXUlsBqeROU+x4=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BY5PR10MB4131.namprd10.prod.outlook.com (2603:10b6:a03:206::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Thu, 14 Apr
 2022 22:29:49 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::65fa:78de:f4d:1a5c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::65fa:78de:f4d:1a5c%3]) with mapi id 15.20.5144.030; Thu, 14 Apr 2022
 22:29:49 +0000
Message-ID: <4eea2373-32f3-9960-cbec-21dc1a428807@oracle.com>
Date:   Thu, 14 Apr 2022 17:29:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v7 4/8] crash: add generic infrastructure for crash
 hotplug support
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220413164237.20845-1-eric.devolder@oracle.com>
 <20220413164237.20845-5-eric.devolder@oracle.com>
 <YleK3J/4HNuFioIh@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <YleK3J/4HNuFioIh@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::36) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2d0bd28-bd94-4f76-363a-08da1e664908
X-MS-TrafficTypeDiagnostic: BY5PR10MB4131:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB41313DAFA7D24534FC36025097EF9@BY5PR10MB4131.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kf3zBj0svjIA+QFOu1D6IyqFR6mv1HYKJCKKLKBZGD7j5tLECeYZV6/hYVqVT77RUFNf/SvB6v37BX0jIvnKqVkhnpakZp8lGWU750i2hkEWdDRukaSRMyYv9Ztj2xJ4EppsYmcXoZuMqu+/Wmk/VIaI3DwbvXS7pf6Yz5ZfKX1JQ3jpuW2+gkimewdYIRqqHpgUwd8CnQFIbtj3/RzPlEEGZIBa0bDm995TNYLFMbcUK2kAPFz5mlg5W3fw2zmkc5NqfThI22gfdhTcZ3M2Py1mPSuXNm2vvinvFe9PWg3F71aXim58GSJesM0yhnYPOUelwRDqZebVE3X+sTao/OXdhva4dgmi50aSVvg+e9syZT57DuNQvf8AhRPtgIhMEcpwuBotaWab+ZhWQV7aYNqGYeDxiCizm6SzfCgGLbkcvZdIRvKSPUFJfpdrFaawA3QNtBpbLPt/990Oln5z+jYfsT232V78gVeSlUinCQFBmZ87HVt3jgzSXMfIWa8jEOjX3AMvdgz9YSFenE8mTROWJH9AlgN4Kp7Eoq8WY6QEXigslBkV5fbFbVX+t8hK18CDJxodaDUwpPNymOJilwkuaE32FLbdZNNbsLrlDxKLYXIkJb3evSBgpBqbAp7b0k1GuBwOWFkff55QQpwaDkpXgGEnnFz8NcvEkn80dqtJ6Yrz1jIY+juoPiyhuFDXGbvj2C3nfMXBKDTfTf8olWG5Sj6aVZVtdYa3cw+qR/2dXHv7Tktf+GH7yC5DaVYM4VQnWIJ1HPR2KfEe+cP6OQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(83380400001)(316002)(53546011)(6506007)(107886003)(38100700002)(2616005)(31686004)(86362001)(6666004)(186003)(2906002)(6512007)(508600001)(66556008)(66476007)(66946007)(6486002)(8936002)(7416002)(4326008)(6916009)(8676002)(31696002)(36756003)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmIydE1PKzdqTk1vM2wzeDRGRnZoQndJQjg2dWpMcEtsdUxjUnJkZzFRQzBG?=
 =?utf-8?B?UVZ2a0ErZHdwcjBxcWtYTVRnNDRTSzZhN0Z4MkU2dDdKc1Q5QU1ZQ25vM2N0?=
 =?utf-8?B?MUVXUHQ1WkNWRVY5aFZ2MUM2NTJtUC85ZUYzUWZlekhUK05oMkU0MkxIZzRW?=
 =?utf-8?B?ay9MR0cybU1ZWm5VdUxJNlFXRTAxcVAvVER3TmNvWUgycXFueTdTNnM4SDJG?=
 =?utf-8?B?WTF3aGc4OThBOWtpQmtxWUJNSCs0S1VaVHBHQkluOWNCWk1kbnd6Ty9SQm9B?=
 =?utf-8?B?ViswMDVFTDl6WWpmRXc3UG9IaTZ6cElvNDBFeDhxQTZ3R1hYZHFORFg2OVdD?=
 =?utf-8?B?Nk1vMXVMQ3VzZEh5ay9LY2NvTzAyZ01WQTBWZUt0dElRSGF3dU9FN3FFVVlC?=
 =?utf-8?B?OXdHM2RraUo2dHRtSkFCYllGNnRvSVZsR0l3eGZCY0ZSaUtZVFB2Um9iK25v?=
 =?utf-8?B?azFyT0ovNmJ2V2JLUGhSdXV5T1k3NmlpTzNjYXViYlBENVNveW4wYk1jT3ZT?=
 =?utf-8?B?S1FvUFpsaDZ1ZGk0MUJsOXg1bXJkYUJhYWVxYmRSTjJONHVyY0poZTBCR3A4?=
 =?utf-8?B?R0RER3h5M25IZjZZTXFQOW1uL0dPbloyRHVkSzdqYVlIS1RHSkd2NldpZVFJ?=
 =?utf-8?B?RHNlU3FCRlV6bm53cjdiVUlaTzVrN3lPSTRqYWJObWluK1JlZWVyNkpqaU9u?=
 =?utf-8?B?cFA1UTlRS1d1K1JqQzhRQkNkREtiS3NQTTEwUWVuSy9wY2xRbDY5dzZDNklM?=
 =?utf-8?B?dUxNYTNuZEttbmk0MmgwTitPZ3lvNkpKSzcrRElUNnB6SVpoRVZPSHJocmU0?=
 =?utf-8?B?S2dqMlJXQzd2ZktKRmxScFRubk9mdkhmR2k2dG1ZOVVTcktpem43NW14NitR?=
 =?utf-8?B?cWhIMWpJNWxPa2w5RUVFSFFFUnh2d25tVEpyRVNVbGh6L1p1bUlWQ2RtN3JX?=
 =?utf-8?B?MkJyNG8xOUhTRFdCcDlyNFBNK2h2RzRxNmE1ck9mcklFMzMvWHZXQURaSjRX?=
 =?utf-8?B?VXR2b1htR3VRajVTTlZRemVjek1POHFQNkhhU3NsUE04U0dLamJ2QVlQR1Nq?=
 =?utf-8?B?aGljbkwwTzQ5ZDRzY0NWWC9VMXhDQjQ4d0dRYlk0cHA0STNPTjZVTXdmckc5?=
 =?utf-8?B?VkdIV05nMEtuYlc5N05hZXliK0YxS0d5eUs4Qk5CVEpXUUhVcy9JYVpJNWtl?=
 =?utf-8?B?QWlXR04yVFVBU01EVy8wNUZkd21TQTlreXhJUHhURTFSbUh5WHBLdFRJNUFt?=
 =?utf-8?B?N3l4bGZ0MFJranNCcWEzMWUzZHdPWEJodEM3dEJaRUZ1NlIxRVk5dUEvcTZE?=
 =?utf-8?B?MXRreWxXTk1wT21PZXcwK1prZUJSd1FZeGRrcktjOUk1eDBENXB0NXBLZWVr?=
 =?utf-8?B?QVRXRDZuU0R1UUlMSDNYSW5zNEVYd3J5OStZWXNwTVJta2lNTU9zOVAvU05x?=
 =?utf-8?B?V05uWEF1MWhPSmplZHU3MWt5ZHNlaWNLMnA4ampYZStBSFZIa0xobFd1Qjl5?=
 =?utf-8?B?Q0hBbXZkbnpLcWFhU0NIVFR5UjFFZjllRkRDZ1BjMlNDUzdteFlHU0l2NW8x?=
 =?utf-8?B?WDVWK09nTmJrc0NYL1JWLy9BRXBtc2UyVUpVdG1VODhkdVFEUHp2UlRTaC9S?=
 =?utf-8?B?U1VoRHRoK2VqNmJoN3hFZ0VLaXFjTFpZd1Z4MjVBRGg3ZU04am9rY1ZuNlp3?=
 =?utf-8?B?UHVHQm5QSnRTSlhIRDdBRjRnQno1RXlvTXp2anVxWGE0NmhkMHZqbHFEUEV2?=
 =?utf-8?B?UzZKVHFiU3UycU5kNDhMdytZc2FFODByVnh3aUdkZGJHK3dCVktsRWNjbjlG?=
 =?utf-8?B?aEVrZ0h1L0dhM1pjbjd4QkFzUGxXMmRQNnBoM0VBQ09PR0tDQ0tOdlkxN2w0?=
 =?utf-8?B?S1Z5RFVqWmhwdGd0OC95MWIyeTNoY2JicEVmTWptTkJmWVlaalZXSlZiamtq?=
 =?utf-8?B?NEF6ZWlGTm5KMUtNVkFnejNLVUtlcUhFbVV6cWo2UDdMWUpnK00vWlhCOTcx?=
 =?utf-8?B?WmpRejRUU0NoWGd1VkExQWZsMENWKy9Ta0xrS3dtZDlpZVlQZWh5S21pbXN2?=
 =?utf-8?B?OVBiMXhaYjNKMU5waWJwcERNRXgzQktCaTVwS3F4d3pzbFdwY2hhMDFlZEJB?=
 =?utf-8?B?dzJPNEdONDhqRFdYREpyVVR2WHBmek1SWHNpRjRUOW1rbFQveHhWbTNMZ29T?=
 =?utf-8?B?UEVLMTBEN3RGK3paT3Y1OUZ0dmd3ek1Qcy84MGp5bjZxSDJYQkE5Y05pamVB?=
 =?utf-8?B?ZkM3cFIveDFESm90SUdmc2VjOFEzY2lvV1hiV3orcUZDMUhrME9nT3c0YkpC?=
 =?utf-8?B?OGZudnhhMnlnN0cwZzNDWER3Qzk0TTNTMmFScDdaYm84aXIyY2FYdXVyVTha?=
 =?utf-8?Q?7yVS1JEFRa9nhevUkvWrNOzETL19TRkVyU3E7?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d0bd28-bd94-4f76-363a-08da1e664908
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 22:29:48.9306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TdRCEP9M7K3fiM2IpSzdSNsnwlYE+zLFu9aDxakID1mBz7ikOM7Wm90ROWXXn3jJ6I8kZ3HKq4xDXKOfxslIVDBByrXYU5fdZklX9IeJX68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4131
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-14_07:2022-04-14,2022-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204140116
X-Proofpoint-GUID: 3fPDlLtyD_v0HOW2UvKMctrSiANHwTrT
X-Proofpoint-ORIG-GUID: 3fPDlLtyD_v0HOW2UvKMctrSiANHwTrT
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baoquan,
Inline comments below.
Thanks!
eric

On 4/13/22 21:45, Baoquan He wrote:
> On 04/13/22 at 12:42pm, Eric DeVolder wrote:
>> Upon CPU and memory changes, a generic crash_hotplug_handler()
>> dispatches the hot plug/unplug event to the architecture specific
>> arch_crash_hotplug_handler(). During the process, the kexec_mutex
>> is held.
>>
>> To support cpu hotplug, a callback is registered to capture the
>> CPUHP_AP_ONLINE_DYN online and ofline events via
>> cpuhp_setup_state_nocalls().
>>
>> To support memory hotplug, a notifier is registered to capture the
>> MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().
>>
>> The cpu callback and memory notifier then call crash_hotplug_handler()
>> to handle the hot plug/unplug event.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
>>   include/linux/kexec.h |  16 +++++++
>>   kernel/crash_core.c   | 101 ++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 117 insertions(+)
>>
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index f93f2591fc1e..02daff1f47dd 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -306,6 +306,13 @@ struct kimage {
>>   
>>   	/* Information for loading purgatory */
>>   	struct purgatory_info purgatory_info;
>> +
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +	bool hotplug_event;
>> +	unsigned int offlinecpu;
>> +	bool elfcorehdr_index_valid;
>> +	int elfcorehdr_index;
>> +#endif
>>   #endif
>>   
>>   #ifdef CONFIG_IMA_KEXEC
>> @@ -322,6 +329,15 @@ struct kimage {
>>   	unsigned long elf_load_addr;
>>   };
>>   
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +void arch_crash_hotplug_handler(struct kimage *image,
>> +	unsigned int hp_action, unsigned int cpu);
>> +#define KEXEC_CRASH_HP_REMOVE_CPU   0
>> +#define KEXEC_CRASH_HP_ADD_CPU      1
>> +#define KEXEC_CRASH_HP_REMOVE_MEMORY 2
>> +#define KEXEC_CRASH_HP_ADD_MEMORY   3
>> +#endif /* CONFIG_CRASH_HOTPLUG */
>> +
>>   /* kexec interface functions */
>>   extern void machine_kexec(struct kimage *image);
>>   extern int machine_kexec_prepare(struct kimage *image);
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index 256cf6db573c..ecf746243ab2 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -9,12 +9,17 @@
>>   #include <linux/init.h>
>>   #include <linux/utsname.h>
>>   #include <linux/vmalloc.h>
>> +#include <linux/highmem.h>
>> +#include <linux/memory.h>
>> +#include <linux/cpuhotplug.h>
>>   
>>   #include <asm/page.h>
>>   #include <asm/sections.h>
>>   
>>   #include <crypto/sha1.h>
>>   
>> +#include "kexec_internal.h"
>> +
>>   /* vmcoreinfo stuff */
>>   unsigned char *vmcoreinfo_data;
>>   size_t vmcoreinfo_size;
>> @@ -491,3 +496,99 @@ static int __init crash_save_vmcoreinfo_init(void)
>>   }
>>   
>>   subsys_initcall(crash_save_vmcoreinfo_init);
>> +
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +void __weak arch_crash_hotplug_handler(struct kimage *image,
>> +	unsigned int hp_action, unsigned int cpu)
>> +{
>> +	pr_warn("crash hp: %s not implemented", __func__);
>> +}
>> +
>> +static void crash_hotplug_handler(unsigned int hp_action,
>> +	unsigned int cpu)
>> +{
>> +	/* Obtain lock while changing crash information */
>> +	if (!mutex_trylock(&kexec_mutex))
>> +		return;
>> +
>> +	/* Check kdump is loaded */
>> +	if (kexec_crash_image) {
>> +		pr_debug("crash hp: hp_action %u, cpu %u", hp_action, cpu);
>> +
>> +		/* Needed in order for the segments to be updated */
>> +		arch_kexec_unprotect_crashkres();
>> +
>> +		/* Flag to differentiate between normal load and hotplug */
>> +		kexec_crash_image->hotplug_event = true;
>> +
>> +		/* Now invoke arch-specific update handler */
>> +		arch_crash_hotplug_handler(kexec_crash_image, hp_action, cpu);
>> +
>> +		/* No longer handling a hotplug event */
>> +		kexec_crash_image->hotplug_event = false;
>> +
>> +		/* Change back to read-only */
>> +		arch_kexec_protect_crashkres();
>> +	}
>> +
>> +	/* Release lock now that update complete */
>> +	mutex_unlock(&kexec_mutex);
>> +}
>> +
>> +#if defined(CONFIG_MEMORY_HOTPLUG)
>> +static int crash_memhp_notifier(struct notifier_block *nb,
>> +	unsigned long val, void *v)
>> +{
>> +	struct memory_notify *mhp = v;
>> +
>> +	switch (val) {
>> +	case MEM_ONLINE:
>> +		crash_hotplug_handler(KEXEC_CRASH_HP_ADD_MEMORY, -1U);
> We don't differentiate the memory add/remove, cpu add, except of cpu
> remove. Means the hp_action only differentiate cpu remove from the other
> action. Maybe only making two types?
> 
> #define KEXEC_CRASH_HP_REMOVE_CPU   0
> #define KEXEC_CRASH_HP_UPDATE_OTHER      1
> 
Sourabh Jain's work with PPC uses REMOVE_CPU, REMOVE_MEMORY, and ADD_MEMORY.
Do you still want to consolidate these?

> And define a new macro to replace the magic number?
Yes, I will do this.

> 
> #define KEXEC_CRASH_HP_INVALID_CPU   -1U
>> +		break;
>> +
>> +	case MEM_OFFLINE:
>> +		crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_MEMORY, -1U);
>> +		break;
>> +	}
>> +	return NOTIFY_OK;
>> +}
>> +
>> +static struct notifier_block crash_memhp_nb = {
>> +	.notifier_call = crash_memhp_notifier,
>> +	.priority = 0
>> +};
>> +#endif
>> +
>> +#if defined(CONFIG_HOTPLUG_CPU)
>> +static int crash_cpuhp_online(unsigned int cpu)
>> +{
>> +	crash_hotplug_handler(KEXEC_CRASH_HP_ADD_CPU, cpu);
>   Should making the cpu as -1U?
Well, the cpu would be correct/valid cpu. Is there harm in reporting it?

>   	crash_hotplug_handler(KEXEC_CRASH_HP_ADD_CPU, -1U);
>> +	return 0;
>> +}
>> +
>> +static int crash_cpuhp_offline(unsigned int cpu)
>> +{
>> +	crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
>> +	return 0;
>> +}
>> +#endif
>> +
>> +static int __init crash_hotplug_init(void)
>> +{
>> +	int result = 0;
>> +
>> +#if defined(CONFIG_MEMORY_HOTPLUG)
>> +	register_memory_notifier(&crash_memhp_nb);
>> +#endif
>> +
>> +#if defined(CONFIG_HOTPLUG_CPU)
>> +	result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
>> +				"crash/cpuhp",
>> +				crash_cpuhp_online, crash_cpuhp_offline);
>> +#endif
>> +
>> +	return result;
>> +}
>> +
>> +subsys_initcall(crash_hotplug_init);
>> +#endif /* CONFIG_CRASH_HOTPLUG */
>> -- 
>> 2.27.0
>>
> 
