Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273705312A0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237596AbiEWPGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 11:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236323AbiEWPG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 11:06:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB872BB3A
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:06:24 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NEn0x7005443;
        Mon, 23 May 2022 15:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ZjCHgMUDQ4UlnOYhdvse1LdtxVRNLCmY8VQBwQpWfUc=;
 b=Ag9BQXsEDU6pt89bxBdhMLNAZfHUZrLXXf9W0mWVryfxUbunsfcbxUezy4y1k+9o9J5d
 WWyzKj+5imRnB9M+h69HKGciSiaFC/vsZxBcGkzcy0X0XB6zkjrjUrHj0fxSsUtvvAdu
 +qgPAr5OdhIuq37AwA0jH0HKU+0w28N89DYeMUpNuToBT5mKlefODARnlV7CFERrioqb
 YdWN5JadhV9kYeiwdK9VyqRxMD6wI0rxhNFPTJc6c9C/75qQXvp2VDeUuUK+bYZRpDT8
 EmRqZnkb3C+rElstVGwnqDvQvsQqE/cRDByvCoJp+6oBglG7L4bc2yK2u3+TD4Db7oDl Vg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6pgbkpsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 15:05:01 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24NF0HjG011830;
        Mon, 23 May 2022 15:05:01 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2043.outbound.protection.outlook.com [104.47.74.43])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g6ph7cggt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 15:05:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hjahe/UFmk732mNfEjriXWt9WOYLV5MMMkMuZ1w4se/gIfwONR4THLehyj7KqF4M7Zxs4TcA2ikmc5y48ElPc9guufhoVMrI88TQEq7t9QmEWJv/zBgKLDODS0A22oUfQbc0WHuHjvhzoxrU+DqpJJBvds1Y1VtGaCgtmLIbWMtxtNJUgL1nd9ajJe2WZdxMZVDy75MpHKPyqXrm0SSS90a8bkmDTdOP1gSDxJO6W+XDU7jeyXCpkBUCM7B5o8ThYifadzB7ARe0l5aX3/jEvFSC1/D79YsoPnsNa1cA2utSGvP6PHShmMXItLCRo5WEoCkZ+QCZ/NbSVFUOI+/PFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjCHgMUDQ4UlnOYhdvse1LdtxVRNLCmY8VQBwQpWfUc=;
 b=eP+TeZarzM3vSjRwrknZXHzVinRCje7A799hdjFfulzpNk1MRbYYwQbImAPoj9rpxERnA1kzKA4CrRCZG9lGcrW9A5/scej1ukeCbrLsG6yKKONrC6RvVW/65kfFsItUJbkp0ZOtzENnSf+bf0b1hcH5R20Z66fSRMOjCY2KDW/FA0jHtMV8kAgHGSu0KlFmkPcjHRIZjznhxzLxqu4XvuiZ70exX0p5V3BI+QfAxb04Jb/LH1Y+ptQ4ObX8aAwTibsGm5PPWfe0IAt/Yvfl9zK1JLJrFnq6k1dSflLIVzcOiVMFGtpKJJfyWTd4oQT0eZVmzBn2Iefjr4OTdrsjvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjCHgMUDQ4UlnOYhdvse1LdtxVRNLCmY8VQBwQpWfUc=;
 b=lfh5SuhwqqLKUUVIYDcriwLM/fAathY0o95SH7Kli52owgIQBgkeOUiYyX+Y+Nkdn4wrj8Hb7qEAlhCRr1mhVQnWot7Ls5bK9ZDuhmGl4thAk0OtUJh35BUlun1FNWQQNz7E3WMZDITVipQCuuwignWkQcfqbWIAQmzXPx+jGY4=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DM5PR1001MB2140.namprd10.prod.outlook.com (2603:10b6:4:2b::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19; Mon, 23 May
 2022 15:04:59 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::bd49:f0ab:b476:860c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::bd49:f0ab:b476:860c%8]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 15:04:59 +0000
Message-ID: <a4b6b21a-f3f7-09cf-9d50-1706d8da7c97@oracle.com>
Date:   Mon, 23 May 2022 10:04:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v8 3/7] crash: add generic infrastructure for crash
 hotplug support
Content-Language: en-US
To:     Sourabh Jain <sourabhjain@linux.ibm.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220505184603.1548-1-eric.devolder@oracle.com>
 <20220505184603.1548-4-eric.devolder@oracle.com>
 <88ec248e-e00f-a84e-c652-97e49fbf2674@linux.ibm.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <88ec248e-e00f-a84e-c652-97e49fbf2674@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR08CA0059.namprd08.prod.outlook.com
 (2603:10b6:a03:117::36) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e81d56b0-b77a-4764-31d8-08da3ccd9ab6
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2140:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1001MB2140B8919FFDBF6A088A821297D49@DM5PR1001MB2140.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1vi0kDNYQJ44qFITKm10bApM9f4ZnLSsCbs7ZYjBBSwmEyYqdE3xCUag1WysXFV3PVuGCwBo2IWG0tIU/e2iLTsuJQ3Aju+Jd2+0hpnI7kChK1jSQzW9utqtkeQKe1t4CGK4+miZzFZfoMlGQ9y4LWUXEY2t+i4dXDQNx56mLuuFVSp2bGpXjk8hFpe5Kz0gO9o2FztRp1HWSAm8HkgZuH7QR/bUp6cFdaMIIhTdmlp/BXF86GecFT6l58P8nI9tw7Wk5sbGxtrk4f+DczTmIt1FCOUolov2m52yEG3KZhmo9OLMdyPTVJEIJOKKmeEwFMPycR1/pJObNBb2DCwFj4z4VQbkZekPP15lbwT+pL0NDgQd3fgUrHCp41K1r0Ugtvi/fGW3tvaUpDlqi9arGaEIOKVaGaHzelD8o9GCof8bvh5YTiP3JQy75XeU0tPORtjGKbdvR/ajtuQ2yXHb/vOkh/BMV/Noos9lXWq1diRJl5GbYCU3vyDpjzRliwERvlZO3gDWqjmWsinK8rYHoiN0EGJ8YwtXyRks6RzNR+JiCg8MrPUxrdDLohhkbDdU6iBrJASWqhc5P0eueU5gnGHz+pkZvYvSXchQwvcl+JJo3V/h9i0dAqQUc6JhzkVEVOKADzkwehlBO75ssDTHNKnd3PkGzDq2jY7tkpk2xs3OdAKTuTo/fAqZ7D84TOKYfg/TJvRKRzzx4KVTaHraiMaGZSwpoqWY7WpkpgDXl4Kq63GVaidB9Y38/hWKYC6SDjl82x4UZuGzgZNVaKIGEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(4326008)(6512007)(8676002)(66946007)(66476007)(2906002)(66556008)(36756003)(31686004)(6486002)(6666004)(5660300002)(508600001)(2616005)(83380400001)(107886003)(7416002)(86362001)(8936002)(38100700002)(186003)(53546011)(6506007)(31696002)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGJQeWYzVmszT0g2dFFRYzd2N3dLbENvcEtoN2JGeHdTeTF5elZjKzhLQ3JF?=
 =?utf-8?B?RHZsUWZST3VJRWh6NXdVeUZHSjNrOGxtdk4xYzFacTFBS2ZMQzlWZzAxNlky?=
 =?utf-8?B?ZFU2WXUwampEUlAySFVkOW1OL0tLNURZaWZiNS8vclVTSTh3N0VXOWkwWG1m?=
 =?utf-8?B?VGlUNlo4MEo3a2s1a3R4ZGRvZk5adGFOdkdpYjhKWGx3bGxUY2JuL1ZibkMr?=
 =?utf-8?B?MWhUMkdvTUpJOU4xQ1o4RTRMTTVEN2tzOW9iSHIvdWRnWWRMdFNZOG1HUU80?=
 =?utf-8?B?eTlLbUVnZmJFV01EVWtSd1FEdW5FdzduV3YwUVRWdnRqWmdCUWZ3WVlQWlVx?=
 =?utf-8?B?dHRDeXNZMDRBRDY2bCtJZk5vK2t5ZHhWTlVod01ObmNPVHBMclJwbTJ2OWtB?=
 =?utf-8?B?anRNZVpIK3lEeW4wK0xmSGFxd0JFOUJRanZNaDNhdG5sL0pFbFVKUHNBRlZp?=
 =?utf-8?B?bTA4WExydFppNzh3Rmw4aDhEVFphSkR1L3I0UDBkWk1McWFyYUtWVFZMdnpt?=
 =?utf-8?B?R0F3QTNXM2hLWVhSS1p5cG5tWVZsdUZWSHhKY2FjRnhrRzlrTU5SbVZieUZO?=
 =?utf-8?B?YXpaRFp2TXA4NHBhRHRqTFJwYlBVOUdSTW00N2NyeFlDZDZqNXpuaWlhS2hF?=
 =?utf-8?B?R0pSZEJWeHppRDFqRkRQTHpldEVLSzR1d3NobWRBUUxGWmladFE0dUV5MzdW?=
 =?utf-8?B?dFlnT0ZCUEJOUzZIdFN4UEd2TDZYaXZyM2ZsbnZUaUNIUGpvelBaYTNXUkc5?=
 =?utf-8?B?WTFFeGp6c1RRbmhYQmZnd0dxOFpIbmcySXpwL1VUZG5HZnRwRlZvRndWK2dl?=
 =?utf-8?B?cEVRaTRCck0xaTZQSjNPdWNHd0hXSzZnSC84Rm1QRVlFWFVVWmJDTStqd1g2?=
 =?utf-8?B?M1E1b3NwOUZFNDhseFIxd1RDRTRiZDluMTIyQWxTd1Btb1I3OWo0K29iR2Y5?=
 =?utf-8?B?bmg0ZlpLKzZjUFZuNXZ6MnBmeGM4aXpXdG9UbExEZGlWQytXQmZKajl1emM0?=
 =?utf-8?B?NWh4blowTXY2UFE1SG13dERubW5QT3k5UjlkRnE1OVpuM3A0bmYvOXBXMXlK?=
 =?utf-8?B?aTMzNE51b3BwRGpFVTBxalZqeWlyM1FPUmFLNzd4UGlEMldRaTZlZG1yZ3R5?=
 =?utf-8?B?V0QwRW0vMEZpOExCSHJ6cURPRkZmUVRSa1JQQ0VlcythUWhNckpJM3dMMzJL?=
 =?utf-8?B?UUV0R3EzYVJJOFF1TDk1MzJCTWRxK1g0NGF6Z2o1M1lLemtsbC84bkFkeGRU?=
 =?utf-8?B?K0d6R3hWSldIM25YY1FMNzdQS09TWnZyRHVZc1dOSzhHNlRYSGdCRXgzVldY?=
 =?utf-8?B?NlFnRDRHcStEeXMrMkMyeTV1STJIRHJDN0JBS3ZmK0xYNjBOdFU2RGkrOEJw?=
 =?utf-8?B?MVdpTFVYYU9aVUJNL0xEc0h4ZHFHQk9HL2Y5a2lmVzNndHJkaDdGTkhXTUQ1?=
 =?utf-8?B?cytBaC9nRS9NYTZnUGNEWVB1eVlPMmw1N2ZTeGdBeHdycWlTYWQvWXlJNjJO?=
 =?utf-8?B?TE14cXpDR3I2UGttMzUzdXQwQkNvZVRpSnp4R2hZOHlmSzNTMmpVM3ppdTdD?=
 =?utf-8?B?b0JNdTFpYU9CdjlxRkR5NTlpelMrZEVJL0xUaTFSdnNwSFdDSnJRYUd4TE9L?=
 =?utf-8?B?WXFMNUJaY3Z6dHh0NEZ4TGFMVlV5VGpIOEFQdzhnMm5YY2I2a09PQkVDQm5Y?=
 =?utf-8?B?RFB2UjJuTlU3UmltcGtXQzBCVzBpenJEb0NBd0J3dmVrWUEzai8ydm5sRFox?=
 =?utf-8?B?ZzlIS1FjOE9jMlk4WUtNcHFxM1dsdjU4bldpMUpFR0o5YkRtNG5vYUk5U080?=
 =?utf-8?B?Mm1YSFNlV2Nmd2YwMXFXZ2RWL1ByZDk2S0dZNFNKckNDaVp4UldTT3k4M1BI?=
 =?utf-8?B?L0M2a2dDVm9NazFmMGhBdWNDL1VHK0VSaTJRY1VaamY1a2JwdXBVNS9OZzdJ?=
 =?utf-8?B?L3FSWU9yRytsMWx4ZEQ3SEZRdXVOVk9WQVoyNkRmY2dGZzJNMCt4RVA2Mzh6?=
 =?utf-8?B?SkJ4L3p0WDhPZis1dndLaW1kRUdhRk9ZWElwcjVoWHZjWnVhUmd1am1oR0RU?=
 =?utf-8?B?NWhoNVRKQWdVVGdYVXFERmVSMDJrc21oYlZlRjNXRm5iVUpST0NydG5WUWZt?=
 =?utf-8?B?SXdOUjRHSEhOalJ0S2FTTkpzOHQvejd3QVRlWnJ3TE5BZkZiZVl3eTdNQ3l1?=
 =?utf-8?B?OVBhRmtQS1IyU0NYTUpnNFZKUlRzb1VmL3Z0MWFvTTlmMTZHQk1NVnRPQ0w1?=
 =?utf-8?B?eUlGenNROVpyWUw4SklNSHFRMGpNYjBSWllvRWZpQ2JJN09BcTk0V0RqNWov?=
 =?utf-8?B?cWVmWnU1RTRPeWZrSjNQZGtTS3B5TUx0OXlsWlB1aThvWWpoRjZVbFpSQW5v?=
 =?utf-8?Q?1p48ZjNScfBWA/+6rbM8mUb1W+W4tDi3ISghs?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e81d56b0-b77a-4764-31d8-08da3ccd9ab6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 15:04:59.2158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hle/ZJfG88TJI4N4OYMy5ZLM/Ph6GEixeshEH0wjEAwckATCSnC/URb1lB+t3qym3TcTNmm+Kl8zdfiCxzUDoCQdHcDFJ8zUeT5h2vgvw4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2140
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-23_06:2022-05-23,2022-05-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205230085
X-Proofpoint-ORIG-GUID: x0yMoed2CLBf2je4RGa6OkWpjakhNpLT
X-Proofpoint-GUID: x0yMoed2CLBf2je4RGa6OkWpjakhNpLT
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/23/22 03:36, Sourabh Jain wrote:
> Hello Eric,
> 
> On 06/05/22 00:15, Eric DeVolder wrote:
>> CPU and memory change notifications are received in order to
>> regenerate the elfcorehdr.
>>
>> To support cpu hotplug, a callback is registered to capture the
>> CPUHP_AP_ONLINE_DYN online and offline events via
>> cpuhp_setup_state_nocalls().
>>
>> To support memory hotplug, a notifier is registered to capture the
>> MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().
>>
>> The cpu callback and memory notifiers call handle_hotplug_event()
>> to handle the hot plug/unplug event. Then handle_hotplug_event()
>> dispatches the event to the architecture specific
>> arch_crash_handle_hotplug_event(). During the process, the
>> kexec_mutex is held.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
>>   include/linux/crash_core.h | 10 +++++
>>   include/linux/kexec.h      |  5 +++
>>   kernel/crash_core.c        | 92 ++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 107 insertions(+)
>>
>> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
>> index de62a722431e..a240f84348aa 100644
>> --- a/include/linux/crash_core.h
>> +++ b/include/linux/crash_core.h
>> @@ -84,4 +84,14 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
>>   int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
>>           unsigned long long *crash_size, unsigned long long *crash_base);
>> +#define KEXEC_CRASH_HP_REMOVE_CPU        0
>> +#define KEXEC_CRASH_HP_ADD_CPU            1
>> +#define KEXEC_CRASH_HP_REMOVE_MEMORY    2
>> +#define KEXEC_CRASH_HP_ADD_MEMORY        3
>> +#define KEXEC_CRASH_HP_INVALID_CPU        -1U
>> +
>> +struct kimage;
>> +void arch_crash_handle_hotplug_event(struct kimage *image, unsigned int hp_action,
>> +                                    unsigned int cpu);
>> +
>>   #endif /* LINUX_CRASH_CORE_H */
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index f93f2591fc1e..5935bc78ed7f 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -308,6 +308,11 @@ struct kimage {
>>       struct purgatory_info purgatory_info;
>>   #endif
>> +    bool hotplug_event;
>> +    unsigned int offlinecpu;
>> +    bool elfcorehdr_index_valid;
>> +    int elfcorehdr_index;
> How about keeping above kimage elements under below config?
> #if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
> 
> Thanks,
> Sourabh Jain

Yes, of course.
Eric

