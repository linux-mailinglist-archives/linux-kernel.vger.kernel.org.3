Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E925196A2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 06:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344619AbiEDErh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 00:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239660AbiEDErd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 00:47:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED262C114
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 21:43:58 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243MIwvl026114;
        Wed, 4 May 2022 04:43:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=z4F3lbGlYVnVy7b1haZjcmrwqae+GnZTsTfx/97gpNc=;
 b=z4KIN0yMBtR1Zavap6oKC84DoTQgSJU4lKPxaGedeWhKnAzG3dOalokdgfmMWv/a8Bbi
 r1AbWToya31y6mLiRJh1qu+ShgXu09/T5jEeCFmHdpZ9WWdaLvgNPC9osB17hU3Juirw
 CF9y6E6gV8ni8NFCmHySK6Gkg+5CXUCs+wYYN8caheJisrzi0OOLAQ7wzcgQ4N7ryXMC
 tNm6TEyItGIsaeb0y8lOVeJTBijlG/7kldz+As3O0Gd/TAOtBoE+gi+1SGyJbAw07nQk
 4UPsIejJwk/up/kxPDEm9Ps0MrKUdcqdxCwIQF25qeUqRus91DzH4Ylmr2Bx7ME1jyGr 0w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruhc7907-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 04:43:48 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2444es1e039701;
        Wed, 4 May 2022 04:43:48 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj953mh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 04:43:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3qzmyybnY09jBYVMqgUy/Xew09x1hJMQ1gWDnfZggFoqtazr1/JnGtfmZCzUC64oAfxoQbcHTOmAtgeMJTm6qHqKMApdg2QTF84wQ/2KI20fVphk9y4kpWVqEtfuYug7/S5TP6rWgPGr+sTALD1ksNBgEP1QvYgLPDvjj30IAXP3EuhuIFR5E2S2lYnQvRt31DlmAJR/Zh30KR7DmOqTO7PGiPGunKCTK6V3HM8ITTCbGDPEBgrzYL/ut4onK4EYDjxYaB/88qHLhAykCNBbYM5mGrIp0oQenbuQbEsdjHOTkNn34xQM+HNFSXxDwzvDczjrZtIZ84Sy72oR58RtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4F3lbGlYVnVy7b1haZjcmrwqae+GnZTsTfx/97gpNc=;
 b=McrYRkcOj1Ay1V2+bffu232eji46BZe+iqUVVUvU9NXOMxxM9NOXdWVZJeAA56OjWY11EDjpqhPF9Cg2hvDKkKh+XW4enSfXYWS739Ls+erWO0ihwB6btDeqLLDBoo4thP4t1VMK4qc/ASDX9+ILZTnh0tQFpl5bVuz3qXvUd8X44Qg2VTnpmSwSE9xQypniKOivc2Uo2dnvuMcfbx/eX2YOegtlLhRsukyVxzK/TMp9DO3Ma+2G72DqiMbPl8Ytxi83c15JfSC+RZNybhV76yHrBZbx9fBHp5+YZE6TuqFIrqBg9A3eCca8dekBVpqLlHENIV9ClMGB8QhCLyrueA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4F3lbGlYVnVy7b1haZjcmrwqae+GnZTsTfx/97gpNc=;
 b=w8X9BTm/80Wkz6Rkr/RV1BUwDGVpDx1tT25Xg3ua4xEfMmYGpniyv3TWzTrTKce7INFwK7j6DNCDicuun3GOGO4sM5PfgXwW+AZ9mzE1KTX0mKS8M3fkDD5QV/qJfswMBF2xUTKg+8QxMd87jxDMLCaxfBZFYO8j7wUNxphBmZo=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by SA1PR10MB5509.namprd10.prod.outlook.com (2603:10b6:806:1f5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 4 May
 2022 04:43:45 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c89:e3f5:ea4a:8d30]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c89:e3f5:ea4a:8d30%2]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 04:43:45 +0000
Message-ID: <f54e1450-bdd0-860c-5962-90f312234134@oracle.com>
Date:   Tue, 3 May 2022 21:43:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 1/2] vdpa: Add support for querying vendor statistics
Content-Language: en-US
To:     Eli Cohen <elic@nvidia.com>, "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
Cc:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220502102201.190357-1-elic@nvidia.com>
 <20220502102201.190357-2-elic@nvidia.com>
 <f279bbbb-6af2-95f4-08c3-97ba72deb6cb@oracle.com>
 <DM8PR12MB5400350099D5A2C932C32B07ABC09@DM8PR12MB5400.namprd12.prod.outlook.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <DM8PR12MB5400350099D5A2C932C32B07ABC09@DM8PR12MB5400.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0019.namprd21.prod.outlook.com
 (2603:10b6:a03:114::29) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cc1bf74-5007-4033-36a2-08da2d88abd5
X-MS-TrafficTypeDiagnostic: SA1PR10MB5509:EE_
X-Microsoft-Antispam-PRVS: <SA1PR10MB5509F963B59C62684192C84BB1C39@SA1PR10MB5509.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xYL/Jlb0lgSef4igxG7P9WQl3S8W/eCJQ/VeE9g7bmk1M7coOJBlMZvP08UuZ9JAwtrwd1XDCww7bdL/zSFLBdkbTF7hqDIQnMRIOk3QiwNymLnD4soeJPycYYw079WQufmZ4fv3xfx5MFLPZBDpLLPH9L/RrL/YoxyNLad2VarRxM7MbkmgAJUd+fmLAxa/eIZqVhC0TypMNdfqc+qt89dZtpzZmUivC1aXsokMN5aIHblQ0YXnpfoB7Qh2LdARR+X0jnpyfPwVDF9vgP+Ec7no0759CYLkKyFbheYjB306qV/2KZO0iXWnPT55CKTMStyqDESKaFDgDqYcC8cqN7IoIYI9Krz2K8e971ap9t+zranh/EILC6FbvVj65Bv11SCgRuyzSbxEtC9ZQICmB8VYbOlpMtILqlmDFWg49iMLog9f3GDa3jzL7LZZL+JUAgL+qafvpyiyMW/s72Ah8Hv3jeCmHlC3rkpxqkGEUIc1myvnFxuTPeLlmOKQosZLrJzhj6d3sxfpc7LIOL1KYmQwr2poRcMBN6jZfgOyzaADEUm/wQ8G3yKLff7NF4Zx1rGEddVepnQ8f8YvgXz0b3B6Tfd7Xb96FXmbzaQc7K+6cFk2gS0DoxyClka2HqvnQLGDMKjTGdHTEOSePMew4sKTWdr2gNO+VpwdDPmW9MazVpaQFE+E4iNyOYDS03W1BPrRZkCHoUTXYrFhz1KMGvvriNjMVvGMOnN6mhph9dY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3287.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6512007)(508600001)(31696002)(53546011)(6506007)(86362001)(36756003)(110136005)(186003)(54906003)(2616005)(38100700002)(6486002)(316002)(83380400001)(4326008)(66476007)(66946007)(66556008)(8676002)(2906002)(31686004)(30864003)(8936002)(6666004)(5660300002)(36916002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2svOWpDL2lKcmxJeEJNOHhabGFCbUN2T0ZpcHd6MVgzcVZXQWhEODhyYml3?=
 =?utf-8?B?aW44QnFGUzcxUThuNDJyb1Z5UHNKdVhxMjJwbHUxSU5FWUFUdUV1b1o0TXJp?=
 =?utf-8?B?YkdZMWdmMnpSWEZ2QXRQekhHUmtvUndKWmJhOVdxc25xTEplWmFoVHpxR0tZ?=
 =?utf-8?B?bzMzMXAramVVSnFZcndDa1dEWFFLMXRoY3ZhSjJrWjVsb1pONmgxT05GTXA3?=
 =?utf-8?B?WlNsQ3RwMVZhZ2U1L1NWcDB0UGZBQjVhSmFUMEtKRkJPWG83Qkg0VUJnWmhZ?=
 =?utf-8?B?aEdpMHRBR3JpK1ZVSC9YWEhSYnNYaWdIcnc3MHBUTnd6MStuS2JJQ2dIbVMw?=
 =?utf-8?B?R0hJYjRyU2hNbVU0ckhnMmNiSk40TnA5WlV0ZVhKUW9TZ1FHeXk3bGxkR1Fa?=
 =?utf-8?B?VTQrVHRiSm1JY25QTlJCbzhDWnp2WWYvV2VyL1gvVlJkdFhaaE45eDNSSUtU?=
 =?utf-8?B?dWNWSEpWb2JTa3ZpRWZoQVVsZ3RQbTlWazFMZUJld0RLU1NVaWFNYzBLaS96?=
 =?utf-8?B?NVdMRXBZMDN2L3NXdVVobXpTQU56N0FXZ0VyeUFiUmd3UVpsN1JGWVRjdVRy?=
 =?utf-8?B?Uzc2RjFDQUduVTVYWFF0OE5NNTd0QnZWT1BuSy9uZk8vdVNFWTZvMjg3VnF0?=
 =?utf-8?B?WHRkcXByLzhWbWI0bE1sUE5WNVRUV0MrS3d2V0VzRjVCUHplK24yVlp4bEs3?=
 =?utf-8?B?Q3pHWmhPTUc0QWVoWlB5WGhnanM1NittT3FlMlNHaWhaUFR6Z2dFdDRrbnk3?=
 =?utf-8?B?TEx6R0JhUTZva2tpaXc3TFBqZkZKSC85Vk9wV2pyVVhiOFpvVGlYYzI3SW1J?=
 =?utf-8?B?ZGNUdklWZ1p0Q0FGRTg3TGVPZThDNjE2NmVRU0ZVUkYxZzRNV0xvSW14L1pB?=
 =?utf-8?B?endkZ3l2cS9BWnVqaTFyRUIzaUI0V0VYbmlMY20zckZCZ2tGOTRGdHpWUFMz?=
 =?utf-8?B?TXhHTU1VRkZOR0hPNm14U0xQbVZ4VzB5MElmcmgvK0tXU3VKQTBvNkdWd0M5?=
 =?utf-8?B?RjlWdG52VFRTVTg5TXdMVzh0UEk2cVBpcmNNbUhPak9CZnI3MDdxL0MrR0hj?=
 =?utf-8?B?ME1ZYTAwRE5rN3o5QTdwbXdFUVdFSzhzN3BHNTVHQzIyeDFQVndZa2hsZkgv?=
 =?utf-8?B?dFZpcy9Uc0VnS0JTNW1DbDF2dytwcWY3eVl3VkM4VkZQSGR1R2NabTBiZWZX?=
 =?utf-8?B?VzJndzJLMGJZdkVkUkxkUWVNRG9Edm56MEtFY2VXTnp1M0p2ekp0L0UwUmYx?=
 =?utf-8?B?bkpBUEVxN0RmZVVWZzNBR3F5S1dwNjBwU2l6azVnVkM5bldUdE1kSWltV3dQ?=
 =?utf-8?B?VzdXRHlhVEtUNC9yWHpGMWpMbExTYWRxdzlBUWozRTFTRmgwZVBINGh6THhW?=
 =?utf-8?B?QUFaL09tTnNYUy9wbEp2VUpISkQ3emttQWpUWUxZeUh5ekUrTHhVL00xUFFt?=
 =?utf-8?B?SUdGZ2hhalRYemVML0ozQWl2V056a0w4WHlsRTRFcml5TGhXQzQzRTVGcmEr?=
 =?utf-8?B?dWtGKzBXaXRXZHphZTZCQzVXZGRxWTloNXRzdFJVQUJYVDQyZUU2eERGcE5m?=
 =?utf-8?B?VmQ4bzdXRWdQMGlxT0l2dmpaazBkWVpqbUphZWNUSEMvT21UTXdYSmZISXJs?=
 =?utf-8?B?Y1lXVFV0Vy9HOW5Wek9xUEExV2VPOUF2Z1lRWmUvMjJld3dmQVJxc216REg3?=
 =?utf-8?B?WUFlRnN0cjNYS3dIZk9WM3F0T3V3Rk1ib0R1VnNrMkIvbkRjY3hESmp4SG0v?=
 =?utf-8?B?Q3JDeG9kcENkczhmU1ZKSHNsTTM3Tks2ZVRsSDB6UU1TdjY2R24ySWVpSjhs?=
 =?utf-8?B?VDg1TG1JaVF2YmJvMDk0Tm84N2hFQmZCYllvWTdzMmMrV0ZnMUhxWWJoODVt?=
 =?utf-8?B?TXB3aGdhOG14WjlYcjQ5SkEvNlZWNmdNejhYditzdUd0Q29KNDcxaVpGb0to?=
 =?utf-8?B?bmNXRkE3cnFraHF5WXE3R2ZWUC9RNU83ZE1OQWFkaGtxeXhKeUJ1blZ6OFFx?=
 =?utf-8?B?WEx4cGhUbzFuTHYrZ3NXRkY2NW4xMThKc0NFVlRGSUkyS25mcTd5aDViK09s?=
 =?utf-8?B?OFV6R2l2YWp5d3RQSkZ1U2xabGdIV3BLa2t4R0wyNEU3NDRQZVZJVzNRVFdk?=
 =?utf-8?B?ZmhtTmtBMDNjRXFVZmdzRElpVjRqWnROTGUwZTluOFVVYXRjTXpNQktBOHZJ?=
 =?utf-8?B?UlVhK3BIQ3pyNUNTWEErYzVNd2cyN2YweENMdEdjamlLanFKbmc0M2doUWNp?=
 =?utf-8?B?Zk1iOEs1TjhjVGNPN0lRakpFNVlKUVJxVmVJZTZOTXQ2WjBJRVA3UjM5Lys0?=
 =?utf-8?B?RXJIUWJtTXR2cWlLTThzcWxmejdKa1ZCUkV1MzZWZVVlYjlGbWwzdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc1bf74-5007-4033-36a2-08da2d88abd5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 04:43:45.0681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sfb75qkkAjZiCkPSzwP/WBjdcjPEll8YWHZk7PZTXx1O0YbEr7pmK+iayLh1wlXm9q4i6oHo6TUeHuX9XQHmrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5509
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-04_01:2022-05-02,2022-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040029
X-Proofpoint-GUID: JfaQDXXxJNn-5sog0G6Mi4IxgDS9kT3m
X-Proofpoint-ORIG-GUID: JfaQDXXxJNn-5sog0G6Mi4IxgDS9kT3m
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/2/2022 10:13 PM, Eli Cohen wrote:
>
>> -----Original Message-----
>> From: Si-Wei Liu <si-wei.liu@oracle.com>
>> Sent: Tuesday, May 3, 2022 2:48 AM
>> To: Eli Cohen <elic@nvidia.com>; mst@redhat.com; jasowang@redhat.com
>> Cc: virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v3 1/2] vdpa: Add support for querying vendor statistics
>>
>>
>>
>> On 5/2/2022 3:22 AM, Eli Cohen wrote:
>>> Allows to read vendor statistics of a vdpa device. The specific
>>> statistics data are received from the upstream driver in the form of an
>>> (attribute name, attribute value) pairs.
>>>
>>> An example of statistics for mlx5_vdpa device are:
>>>
>>> received_desc - number of descriptors received by the virtqueue
>>> completed_desc - number of descriptors completed by the virtqueue
>>>
>>> A descriptor using indirect buffers is still counted as 1. In addition,
>>> N chained descriptors are counted correctly N times as one would expect.
>>>
>>> A new callback was added to vdpa_config_ops which provides the means for
>>> the vdpa driver to return statistics results.
>>>
>>> The interface allows for reading all the supported virtqueues, including
>>> the control virtqueue if it exists.
>>>
>>> Below are some examples taken from mlx5_vdpa which are introduced in the
>>> following patch:
>>>
>>> 1. Read statistics for the virtqueue at index 1
>>>
>>> $ vdpa dev vstats show vdpa-a qidx 1
>>> vdpa-a:
>>> queue_type tx queue_index 1 received_desc 3844836 completed_desc 3844836
>>>
>>> 2. Read statistics for the virtqueue at index 32
>>> $ vdpa dev vstats show vdpa-a qidx 32
>>> vdpa-a:
>>> queue_type control_vq queue_index 32 received_desc 62 completed_desc 62
>>>
>>> 3. Read statisitics for the virtqueue at index 0 with json output
>>> $ vdpa -j dev vstats show vdpa-a qidx 0
>>> {"vstats":{"vdpa-a":{
>>> "queue_type":"rx","queue_index":0,"name":"received_desc","value":417776,\
>>>    "name":"completed_desc","value":417548}}}
>>>
>>> 4. Read statistics for the virtqueue at index 0 with preety json output
>>> $ vdpa -jp dev vstats show vdpa-a qidx 0
>>> {
>>>       "vstats": {
>>>           "vdpa-a": {
>>>
>>>               "queue_type": "rx",
>>>               "queue_index": 0,
>>>               "name": "received_desc",
>>>               "value": 417776,
>>>               "name": "completed_desc",
>>>               "value": 417548
>>>           }
>>>       }
>>> }
>>>
>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>>> ---
>>>    drivers/vdpa/vdpa.c       | 129 ++++++++++++++++++++++++++++++++++++++
>>>    include/linux/vdpa.h      |   5 ++
>>>    include/uapi/linux/vdpa.h |   6 ++
>>>    3 files changed, 140 insertions(+)
>>>
>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>>> index 2b75c00b1005..933466f61ca8 100644
>>> --- a/drivers/vdpa/vdpa.c
>>> +++ b/drivers/vdpa/vdpa.c
>>> @@ -909,6 +909,74 @@ vdpa_dev_config_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid,
>>>    	return err;
>>>    }
>>>
>>> +static int vdpa_fill_stats_rec(struct vdpa_device *vdev, struct sk_buff *msg,
>>> +			       struct genl_info *info, u32 index)
>>> +{
>>> +	int err;
>>> +
>>> +	err = vdev->config->get_vendor_vq_stats(vdev, index, msg, info->extack);
>>> +	if (err)
>>> +		return err;
>>> +
>>> +	if (nla_put_u32(msg, VDPA_ATTR_DEV_QUEUE_INDEX, index))
>>> +		return -EMSGSIZE;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int vendor_stats_fill(struct vdpa_device *vdev, struct sk_buff *msg,
>>> +			     struct genl_info *info, u32 index)
>>> +{
>>> +	int err;
>>> +
>>> +	if (!vdev->config->get_vendor_vq_stats)
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	err = vdpa_fill_stats_rec(vdev, msg, info, index);
>>> +	if (err)
>>> +		return err;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int vdpa_dev_vendor_stats_fill(struct vdpa_device *vdev,
>>> +				      struct sk_buff *msg,
>>> +				      struct genl_info *info, u32 index)
>>> +{
>>> +	u32 device_id;
>>> +	void *hdr;
>>> +	int err;
>>> +	u32 portid = info->snd_portid;
>>> +	u32 seq = info->snd_seq;
>>> +	u32 flags = 0;
>>> +
>>> +	hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags,
>>> +			  VDPA_CMD_DEV_VSTATS_GET);
>>> +	if (!hdr)
>>> +		return -EMSGSIZE;
>>> +
>>> +	if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev->dev))) {
>>> +		err = -EMSGSIZE;
>>> +		goto undo_msg;
>>> +	}
>>> +
>>> +	device_id = vdev->config->get_device_id(vdev);
>>> +	if (nla_put_u32(msg, VDPA_ATTR_DEV_ID, device_id)) {
>>> +		err = -EMSGSIZE;
>>> +		goto undo_msg;
>>> +	}
>>> +
>> You seem to miss VDPA_ATTR_DEV_NEGOTIATED_FEATURES from this function,
>> otherwise I can't image how you can ensure the atomicity to infer
>> queue_type for control vq.
>> And should we make sure VIRTIO_CONFIG_S_FEATURES_OK is set before call
>> into vendor_stats_fill()?
> It is done in the hardware driver. In this case, in mlx5_vdpa.
OK... So you think this is not vdpa common code but rather individual 
vendor driver should deal with? Seems fine at the first glance, but with 
some thoughts this would complicate userspace code quite a lot to tell 
apart different cases - say if the VDPA_ATTR_DEV_NEGOTIATED_FEATURES 
attr is missing it would not be possible to display the queue type. On 
the other hand, the queue type itself shouldn't be vendor specific thing 
- only the vendor stats are, right?

Furthermore, without FEATURES_OK the stats returned for a specific queue 
might not be stable/reliable/reasonable at all, not sure how the tool 
can infer such complex state (e.g. negotiation is in progress) if 
somehow the vendor driver doesn't provide the corresponding attribute? 
Should vendor driver expect to fail with explicit message to indicate 
the reason, or it'd be fine to just display zero stats there? Looking at 
mlx5_vdpa implementation it seems to be the former case, but in case of 
device being negotiating, depending on which queue, the vstat query 
might end up with a confusing message of, either

"virtqueue index is not valid"

or,

"failed to query hardware"

but none is helpful for user to indicate what's going on... I wonder if 
mandating presence of FEATURES_OK would simplify userspace tool's 
implementation in this case?


Thanks,
-Siwei

>
>>> +	err = vendor_stats_fill(vdev, msg, info, index);
>>> +
>>> +	genlmsg_end(msg, hdr);
>>> +
>>> +	return err;
>>> +
>>> +undo_msg:
>>> +	genlmsg_cancel(msg, hdr);
>>> +	return err;
>>> +}
>>> +
>>>    static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info *info)
>>>    {
>>>    	struct vdpa_device *vdev;
>>> @@ -990,6 +1058,60 @@ vdpa_nl_cmd_dev_config_get_dumpit(struct sk_buff *msg, struct netlink_callback *
>>>    	return msg->len;
>>>    }
>>>
>>> +static int vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,
>>> +					  struct genl_info *info)
>>> +{
>>> +	struct vdpa_device *vdev;
>>> +	struct sk_buff *msg;
>>> +	const char *devname;
>>> +	struct device *dev;
>>> +	u32 index;
>>> +	int err;
>>> +
>>> +	if (!info->attrs[VDPA_ATTR_DEV_NAME])
>>> +		return -EINVAL;
>>> +
>>> +	if (!info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX])
>>> +		return -EINVAL;
>>> +
>>> +	devname = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
>>> +	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
>>> +	if (!msg)
>>> +		return -ENOMEM;
>>> +
>>> +	index = nla_get_u32(info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX]);
>>> +	mutex_lock(&vdpa_dev_mutex);
>> Given that stats_get() is a read-only operation that might happen quite
>> often from time to time, I wonder if it is now a good timing to convert
>> vdpa_dev_mutex to a semaphore?
>>
>>> +	dev = bus_find_device(&vdpa_bus, NULL, devname, vdpa_name_match);
>>> +	if (!dev) {
>>> +		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
>>> +		err = -ENODEV;
>>> +		goto dev_err;
>> Missing nlmsg_free().
>>> +	}
>>> +	vdev = container_of(dev, struct vdpa_device, dev);
>>> +	if (!vdev->mdev) {
>>> +		NL_SET_ERR_MSG_MOD(info->extack, "unmanaged vdpa device");
>>> +		err = -EINVAL;
>>> +		goto mdev_err;
>> Missing nlmsg_free().
>>
>> Otherwise looks fine.
>>
>> Acked-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>
>>
>> -Siwei
>>> +	}
>>> +	err = vdpa_dev_vendor_stats_fill(vdev, msg, info, index);
>>> +	if (!err)
>>> +		err = genlmsg_reply(msg, info);
>>> +
>>> +	put_device(dev);
>>> +	mutex_unlock(&vdpa_dev_mutex);
>>> +
>>> +	if (err)
>>> +		nlmsg_free(msg);
>>> +
>>> +	return err;
>>> +
>>> +mdev_err:
>>> +	put_device(dev);
>>> +dev_err:
>>> +	mutex_unlock(&vdpa_dev_mutex);
>>> +	return err;
>>> +}
>>> +
>>>    static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
>>>    	[VDPA_ATTR_MGMTDEV_BUS_NAME] = { .type = NLA_NUL_STRING },
>>>    	[VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING },
>>> @@ -997,6 +1119,7 @@ static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
>>>    	[VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
>>>    	/* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
>>>    	[VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
>>> +	[VDPA_ATTR_DEV_QUEUE_INDEX] = NLA_POLICY_RANGE(NLA_U32, 0, 65535),
>>>    };
>>>
>>>    static const struct genl_ops vdpa_nl_ops[] = {
>>> @@ -1030,6 +1153,12 @@ static const struct genl_ops vdpa_nl_ops[] = {
>>>    		.doit = vdpa_nl_cmd_dev_config_get_doit,
>>>    		.dumpit = vdpa_nl_cmd_dev_config_get_dumpit,
>>>    	},
>>> +	{
>>> +		.cmd = VDPA_CMD_DEV_VSTATS_GET,
>>> +		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
>>> +		.doit = vdpa_nl_cmd_dev_stats_get_doit,
>>> +		.flags = GENL_ADMIN_PERM,
>>> +	},
>>>    };
>>>
>>>    static struct genl_family vdpa_nl_family __ro_after_init = {
>>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>>> index 8943a209202e..48ed1fc00830 100644
>>> --- a/include/linux/vdpa.h
>>> +++ b/include/linux/vdpa.h
>>> @@ -276,6 +276,9 @@ struct vdpa_config_ops {
>>>    			    const struct vdpa_vq_state *state);
>>>    	int (*get_vq_state)(struct vdpa_device *vdev, u16 idx,
>>>    			    struct vdpa_vq_state *state);
>>> +	int (*get_vendor_vq_stats)(struct vdpa_device *vdev, u16 idx,
>>> +				   struct sk_buff *msg,
>>> +				   struct netlink_ext_ack *extack);
>>>    	struct vdpa_notification_area
>>>    	(*get_vq_notification)(struct vdpa_device *vdev, u16 idx);
>>>    	/* vq irq is not expected to be changed once DRIVER_OK is set */
>>> @@ -473,4 +476,6 @@ struct vdpa_mgmt_dev {
>>>    int vdpa_mgmtdev_register(struct vdpa_mgmt_dev *mdev);
>>>    void vdpa_mgmtdev_unregister(struct vdpa_mgmt_dev *mdev);
>>>
>>> +#define VDPA_INVAL_QUEUE_INDEX 0xffff
>>> +
>>>    #endif /* _LINUX_VDPA_H */
>>> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
>>> index 1061d8d2d09d..25c55cab3d7c 100644
>>> --- a/include/uapi/linux/vdpa.h
>>> +++ b/include/uapi/linux/vdpa.h
>>> @@ -18,6 +18,7 @@ enum vdpa_command {
>>>    	VDPA_CMD_DEV_DEL,
>>>    	VDPA_CMD_DEV_GET,		/* can dump */
>>>    	VDPA_CMD_DEV_CONFIG_GET,	/* can dump */
>>> +	VDPA_CMD_DEV_VSTATS_GET,
>>>    };
>>>
>>>    enum vdpa_attr {
>>> @@ -46,6 +47,11 @@ enum vdpa_attr {
>>>    	VDPA_ATTR_DEV_NEGOTIATED_FEATURES,	/* u64 */
>>>    	VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,		/* u32 */
>>>    	VDPA_ATTR_DEV_SUPPORTED_FEATURES,	/* u64 */
>>> +
>>> +	VDPA_ATTR_DEV_QUEUE_INDEX,              /* u32 */
>>> +	VDPA_ATTR_DEV_VENDOR_ATTR_NAME,		/* string */
>>> +	VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,        /* u64 */
>>> +
>>>    	/* new attributes must be added above here */
>>>    	VDPA_ATTR_MAX,
>>>    };

