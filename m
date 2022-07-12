Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54447572752
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 22:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiGLUdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 16:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiGLUdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 16:33:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5D8B4A4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 13:33:46 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CKTSat003982;
        Tue, 12 Jul 2022 20:31:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=yvii7AsFKlHLHw7x4oCkw0zrJvp6OqeyJeG3nn7LKdk=;
 b=zRpgQth4ROPrETDlMYdIwe+ooKNAS9J8njvDtqOmQE8Xe1czvFm+MDPg+IQYu8DBYEIb
 pn47tyiA8KnWgiT+Rc7/sAVWoMtqLrHh/B2xfaF6dVHzCWvtjxNeuGpx+U18u3McD1GW
 Dy3ki+tWzbqjda6tH1+iAjRL07hQdebPoNEfvhsjGjxze91/MCsOkf2GJxphzH7zcwLW
 h7kSf4PzKJqlehcTeQzM335U7JvD6qX7TSdjBG6GFymzD+1uYYH7pWJK2a8iKJE5JHqL
 XcbNuEr5d4m/xccsvQ5EpyAi/G2HsnKQKOzSPA3xuVkYkCP38AzYTF56cahh/czPYQRR /Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71xrg884-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 20:31:22 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26CKBZFT013991;
        Tue, 12 Jul 2022 20:31:22 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h70440s88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 20:31:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YD9wBov/IUdL+Czw+7RTXwN5hHc9fmfO69wQQ+wwvp1ZYkmhZENeKHNtT5V20WaK/zRbEFBDhZFQ+9Wk0ORnu6rRB+o4Gz6UWxWZQEjMe+GaGg2BZ1wQ3Z9097yfsCb7sn4xAJCDqyIANVMGbiRfPiUvlCnoLDNJ3QIx1JvscBqhI3lStmNCiDLvuZqr/Tloq87y65RFGTRoaLlYMNeU4ni4StZppb4dFXM1E+1xzWtxeIii+pFgd2aJBgX1NRY/q3IDIZtbbRXbQa1me51FdXXj/cdUuT88s3HO0knxEKyX5Z8pSz929Z16ItskCzvM39uEBG5S5TJHMa2yjPZAsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvii7AsFKlHLHw7x4oCkw0zrJvp6OqeyJeG3nn7LKdk=;
 b=aidDdN5FJeBMLOU7t6Q8hRndGuwK+hqGXvvi5h7HGwEsZ6MaUz7C9fAWnW14V7I10245Ty9FWc/wLddOHKWAdctRU5KeIfSFK4BDY19BiqbbhBQ4+KmoRaL/ngQr3CyM07OgrPvaNMBfvmSEagD56Xbvev4vgvVteUdZ8dHbtAzovd2tAi7wMFUQQjx4l6wCehJICwYsaUX3ip+voGrtZtE1kPsLf6yUb9i7N4lhrLwaei1XQ5DncFzsJbJz8VAb0s7QWs0Smnyq6hb+dylqrxRkVEA5AW41Sa81qOB1O4NWgjcQ8FAVHn/puIEG2qExsdytBobGWmwUbr5ky3QwGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvii7AsFKlHLHw7x4oCkw0zrJvp6OqeyJeG3nn7LKdk=;
 b=dZZLXf9cfXtYFEzIR7dOICU6Fu6sgZRRlBsOZc0HWYQO4fzT2RFyyqe4mHrwi8+tjdO46rblHNTmtMDISXfaWTbw6jFwLltobtz9SfjQ2hts20YRfAM/bDYV9MIjks+H08xgdyBtXAlB3sGhnHtY+2L09y5GFKB3V3LrPdhN2Nc=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH7PR10MB6036.namprd10.prod.outlook.com (2603:10b6:510:1fc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Tue, 12 Jul
 2022 20:31:19 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::747b:31f7:db5e:9e0d]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::747b:31f7:db5e:9e0d%3]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 20:31:19 +0000
Message-ID: <cd0f60ef-9c1a-69c4-2971-df5b2c43cc21@oracle.com>
Date:   Tue, 12 Jul 2022 15:31:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v9 7/7] x86/crash: Add x86 crash hotplug support
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     Sourabh Jain <sourabhjain@linux.ibm.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220613224240.79400-1-eric.devolder@oracle.com>
 <20220613224240.79400-8-eric.devolder@oracle.com>
 <94f5e036-770d-4ca5-c386-9a43e7333b43@linux.ibm.com>
 <e96c42ee-7a14-3565-16cd-dbf7cf163c21@oracle.com>
 <Ysv0BEMOmN/WnhVg@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <Ysv0BEMOmN/WnhVg@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR03CA0072.namprd03.prod.outlook.com
 (2603:10b6:5:100::49) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c429e62-b8aa-4ad6-f3d2-08da644579f1
X-MS-TrafficTypeDiagnostic: PH7PR10MB6036:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IjsnCB0dq4M6bPuQ3LuDgnkBRrHcwNtsn6a7VO8etPznbfNKYPStrbd9cMTRtrToc97u/3iAKKrBCrv4wdYGExs4Mzi4wF+OS0+TDPz3BlRBNSRSPGQgJb7Bhmot2Yeu2VdVxz8xBDy0oawGb8Hu1/8uC4gOsN45VsHhdSkpI0g2eKGQx5L2qRoxFwgFB6PRzGOzxUP2YEplqj3eQy7qepCOnkGj1d752aWnlaAJG1jD7c31ODErWucVttwGYYAEvZcjNyuUn+yDxwwVLoNsB/8g2H7BgbfoWZCAKYJCGasRYjPpqLneS7w5w9JbeHIO0q5wSCrEO0JyzUbiLBVFBVqveLGH0zaWq+LeLY56xDPJZqu164Ysy9CZJKfGXI+OmPEVcM7fOFif4iNW4JFWZUcZqntfDONMp0/X38XECAwtDoNM3B2MdDKk35pqUTIfOjtohCqvyykBrHfr+rfHkgiVBMal39voQP+13Lbb/iVbkacOEs+PMAcdKxrFPqtWwdmjJLj2XZf1mQxqxjri4WX6Mp8wuszibqD/F8xtjg+sGJnCkLcGYJp3g1JXZ0ixjuq0g4JgdsoOqJqlFQlc55drsDAdcNKMi3i4rs3U9QzMcum0qH70yQ63MgwXUW8g5fXezAB2Jg1IW41qmRvt+0nK6O9fw8fNGtXzAiT1yDFfNCiBhnOLyBTB5+zP8YV9Yg6Bp+zp4yG7hw0vcwvyn8+sIDORJGea1nmVIOcHqxDpIFEmz3FMOiHT8erDlTt1OqYUtyDoBHqGaspn1cVfCwdNBzk3kGwBhim4yO+XbmaRI3yToWR27Crg+Hk75CsNAASzr/Wcr5sKdE+dLVY44w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(346002)(39860400002)(366004)(376002)(6666004)(6506007)(41300700001)(66946007)(478600001)(66476007)(316002)(6486002)(53546011)(6916009)(31686004)(8936002)(8676002)(2906002)(66556008)(7416002)(4326008)(5660300002)(107886003)(36756003)(86362001)(186003)(31696002)(6512007)(2616005)(38100700002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUE4QWZpeGtiUm0vczh6NElnYllweiswZk9mdEF3QUpxNDJ6RWZSQjFUZHFs?=
 =?utf-8?B?OU43blNmdmJFaU1NZHJTb2xXaUpHbEVMamJmcnl3SjV2QXdNRlluU2hvODRZ?=
 =?utf-8?B?Y3BKSStEeDU2M0ZZQXduVVpRL1dYSGhqYm5OaXhualByVlBFbS9TREx4eFdZ?=
 =?utf-8?B?UlZjcXhESUZxVDdlNUptSG1qd0txR05kZlFXN0tTOVJHeXQ4eTNMUTBNdW00?=
 =?utf-8?B?Q2VQMWRZekVwK2tqTkZORThXR1FPR1NXRUFkUlgzQWExbFJkNkNuQUlYRDlM?=
 =?utf-8?B?RWdDZXZJWTVjOHVHeVlBWnBEZkc0WjNiTENaMEVnT1dTZWhuMHZyOER0eDZq?=
 =?utf-8?B?bVFGY3BqWUJrRmsrV0RxSDBycEhHcTVSQStwNjV5V0RPaFlhK3JQbUZKcEQy?=
 =?utf-8?B?M3FObkUxUEJmR0xKSDdiYTVQQjZJZkVQaGpXbStteTVpbUhOSWNiMDhVdjlJ?=
 =?utf-8?B?RFgxVkUwaWlaMWU5OThIRURMZjc0L2M1Vm5sUmJOTTBObVpkQWVYY1NyUm1r?=
 =?utf-8?B?Mmhqd1YxNXZ0R2xaSTNnVk9BZ3AwaklRSnEzUllSMHkvUi9LbWREcjB6aFpN?=
 =?utf-8?B?U3NPNEVnRE41RTU5KzdiK2l6cjczNUdiQ3g3UzdqTjZ4OU1hYlovSWs5RUxa?=
 =?utf-8?B?THVnTEEyNjMvMmhSVG9Oc3lpZCs5L0lBczR3UEw5M2ZLNEM3YWJQUVgrWXlr?=
 =?utf-8?B?aUJQdUx1ZTNiT2JOaThOd20vSW1pTkl2aUNNRWZLYS9oUlRuM0tiUmh3SnIr?=
 =?utf-8?B?NFdHR1FiZENzOTZMZFUxekd0ODZlbDhlUGJSbC9RbVJHSWM4OXgxMkM2bDVE?=
 =?utf-8?B?N2FqWm1KVk9KeFhpUWpkbmZMRjBUckNqSEpqaUJreGVhcmRqdG4yZTVqUGhB?=
 =?utf-8?B?Y1R2Ym1sRWpWRjRBb3NkSGxTMWZITDk1RkR4N0pnQ2Q0YTJqbURtUXAySHV2?=
 =?utf-8?B?WlBCRWpoT3c4MjF1a0dseU80dnNaZjJ1MFhscGxpMlRJNHlTTWliZysyaHBJ?=
 =?utf-8?B?QnR2cVBjUUFkUmlITnhaTkNGeXZhT2ppZmcvQmx3RU45dHgyMXd5ekxpREpD?=
 =?utf-8?B?alZ3cXlNK2l1NHFuMmE4eENHMENFTjVnMUVUWWZoUklqTkI0T0kzM0F1dXZ4?=
 =?utf-8?B?NjllSGs0RWVQazdVem53VEZtM1JIVGtodjU0a0pBY2xPSXhuMVc2OFpGa3RZ?=
 =?utf-8?B?TlhBWHo3MGFYNTRqUFpWZTIzK2d6VC9TUm1TVmdDOURRZm9lMGV3Uk1CNUQ5?=
 =?utf-8?B?MFJVcmNPRlFQT0Z6MDBSdjNBZzRUeWtSaUdhRUpKSTA1bjlVVUhFVG5lQWlm?=
 =?utf-8?B?Vyt0ZmlXVTlaRHVCUmpYa1FZajFIY3QrT3VHZjJFVEttN3FTYjg0blZGRitK?=
 =?utf-8?B?bWJleklvOVU5NTBUN1RleTNXVS8vU2lJbkxEQ053K2x2aTZXNzN0QkptR2VD?=
 =?utf-8?B?bW1QaEpmQ0NGU0xmVmZaWVc3K0VHS1VjSG5nalJ1bXJoSlBteXBQaC8wWDVr?=
 =?utf-8?B?Sy85NVhNTW9zVkwrVzF0alNvRkFzV0padjJxMFFmMXhsYVNuRnNSczk0Q2U4?=
 =?utf-8?B?dmY2bE1NRmM4UERXY0pacVk2VGRnWUM4M0ZScU5WSjJCMmZzdUtyWXcwaGYz?=
 =?utf-8?B?WUhMNUFMZzFucDRuRHV5TGNrWkVNdEdXcXlWVVErc2dlajYzZFFLcThUTDNP?=
 =?utf-8?B?WmNkZGhrSkszVmJJREhPV0w2ZEJ5NDMrUGNMQzBtU3l3OWNFeEpRTjdnM3RZ?=
 =?utf-8?B?TnVROC9vbm5JeGZKYjY5ait2c2RjVlkzaWhJL29jSlVNaG0walVtQ29pbERh?=
 =?utf-8?B?bjVVN2FXM0VXek53WWpDRjNOT2xYY2dNOE5DKzE1YjlJdjhQQW5QbS9YVkFK?=
 =?utf-8?B?SFN6ZTBQSFBxamVYOU9KaGdsVVlxQi9WOGRka0RsVDRqWWJQQjBvMGxoQXB4?=
 =?utf-8?B?M0d4dGZPSk85WUtmQmxFdWpNRDhkcTNQODgrRDhRVnFDUVZUSjVtMG9XcU5w?=
 =?utf-8?B?UTdRNTZNcXZUc2dPNzh0WmJsYlc5cHV0bVNnN21JLzZHY3oyOURNaUFzWkQ4?=
 =?utf-8?B?SDVDM3MrcHArVkwvNHZvT2g4S1l0TEIwMlc1L0lmcHRXbWhCUTc3Zy85TnNH?=
 =?utf-8?B?NEc0REViK3lqMWdjS2hwK2tqaFk1SzZtNnllY09pd09SZEdkKzdJUUVkMFlG?=
 =?utf-8?Q?k8InSFyXgJIXBprP7lMO5ek=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c429e62-b8aa-4ad6-f3d2-08da644579f1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 20:31:19.1516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OS4UjpIWAdApcFol1eQRadWJlGSZBKnm/AEdfShrK2dRXcL3bSxqSEa7CLuuv8LXAsu5mETS2/vFs/v5cVvZ5szL0HqeVN0nWDYl5Q2p74s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6036
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-12_12:2022-07-12,2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207120082
X-Proofpoint-GUID: NABIIOeQtep1iKYOm2ZBCSLLYrd89BBI
X-Proofpoint-ORIG-GUID: NABIIOeQtep1iKYOm2ZBCSLLYrd89BBI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/11/22 04:57, Baoquan He wrote:
> On 07/07/22 at 07:55am, Eric DeVolder wrote:
>>
>>
>> On 6/20/22 00:06, Sourabh Jain wrote:
>>> Hello Eric,
>>>
>>> On 14/06/22 04:12, Eric DeVolder wrote:
>>>> For x86_64, when CPU or memory is hot un/plugged, the crash
>>>> elfcorehdr, which describes the CPUs and memory in the system,
>>>> must also be updated.
>>>>
>>>> When loading the crash kernel via kexec_load or kexec_file_load,
>>>> the elfcorehdr is identified at run time in
>>>> crash_core:handle_hotplug_event().
>>>>
>>>> To update the elfcorehdr for x86_64, a new elfcorehdr must be
>>>> generated from the available CPUs and memory. The new elfcorehdr
>>>> is prepared into a buffer, and then installed over the top of
>>>> the existing elfcorehdr.
>>>>
>>>> In the patch 'kexec: exclude elfcorehdr from the segment digest'
>>>> the need to update purgatory due to the change in elfcorehdr was
>>>> eliminated.  As a result, no changes to purgatory or boot_params
>>>> (as the elfcorehdr= kernel command line parameter pointer
>>>> remains unchanged and correct) are needed, just elfcorehdr.
>>>>
>>>> To accommodate a growing number of resources via hotplug, the
>>>> elfcorehdr segment must be sufficiently large enough to accommodate
>>>> changes, see the CRASH_MAX_MEMORY_RANGES configure item.
>>>>
>>>> With this change, crash hotplug for kexec_file_load syscall
>>>> is supported. The kexec_load is also supported, but also
>>>> requires a corresponding change to userspace kexec-tools.
>>>>
>>>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>>>> ---
>>>>    arch/x86/Kconfig        |  11 ++++
>>>>    arch/x86/kernel/crash.c | 116 ++++++++++++++++++++++++++++++++++++++++
>>>>    2 files changed, 127 insertions(+)
>>>>
>>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>>>> index 762a0b6ab8b6..e9eecff3b97d 100644
>>>> --- a/arch/x86/Kconfig
>>>> +++ b/arch/x86/Kconfig
>>>> @@ -2082,6 +2082,17 @@ config CRASH_DUMP
>>>>          (CONFIG_RELOCATABLE=y).
>>>>          For more details see Documentation/admin-guide/kdump/kdump.rst
>>>> +config CRASH_MAX_MEMORY_RANGES
>>>> +    depends on CRASH_DUMP && KEXEC_FILE && (HOTPLUG_CPU || MEMORY_HOTPLUG)
>>>> +    int
>>>> +    default 32768
>>>> +    help
>>>> +      For the kexec_file_load path, specify the maximum number of
>>>> +      memory regions, eg. as represented by the 'System RAM' entries
>>>> +      in /proc/iomem, that the elfcorehdr buffer/segment can accommodate.
>>>> +      This value is combined with NR_CPUS and multiplied by Elf64_Phdr
>>>> +      size to determine the final buffer size.
>>>> +
>>>>    config KEXEC_JUMP
>>>>        bool "kexec jump"
>>>>        depends on KEXEC && HIBERNATION
>>>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>>>> index 9db41cce8d97..b9cdf7a0d868 100644
>>>> --- a/arch/x86/kernel/crash.c
>>>> +++ b/arch/x86/kernel/crash.c
>>>> @@ -25,6 +25,7 @@
>>>>    #include <linux/slab.h>
>>>>    #include <linux/vmalloc.h>
>>>>    #include <linux/memblock.h>
>>>> +#include <linux/highmem.h>
>>>>    #include <asm/processor.h>
>>>>    #include <asm/hardirq.h>
>>>> @@ -398,7 +399,17 @@ int crash_load_segments(struct kimage *image)
>>>>        image->elf_headers = kbuf.buffer;
>>>>        image->elf_headers_sz = kbuf.bufsz;
>>>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>>>> +    /* Ensure elfcorehdr segment large enough for hotplug changes */
>>>> +    kbuf.memsz = (CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES) * sizeof(Elf64_Phdr);
>>>> +    /* For marking as usable to crash kernel */
>>>> +    image->elf_headers_sz = kbuf.memsz;
>>>> +    /* Record the index of the elfcorehdr segment */
>>>> +    image->elfcorehdr_index = image->nr_segments;
>>>> +    image->elfcorehdr_index_valid = true;
>>>> +#else
>>>>        kbuf.memsz = kbuf.bufsz;
>>>> +#endif
>>>>        kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>>>>        kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>>>>        ret = kexec_add_buffer(&kbuf);
>>>> @@ -413,3 +424,108 @@ int crash_load_segments(struct kimage *image)
>>>>        return ret;
>>>>    }
>>>>    #endif /* CONFIG_KEXEC_FILE */
>>>> +
>>>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>>>> +int crash_hotplug_support(void) { return 1; }
>>>> +void *arch_map_crash_pages(unsigned long paddr, unsigned long size)
>>>> +{
>>>> +    /*
>>>> +     * NOTE: The addresses and sizes passed to this routine have
>>>> +     * already been fully aligned on page boundaries. There is no
>>>> +     * need for massaging the address or size.
>>>> +     */
>>>> +    void *ptr = NULL;
>>>> +
>>>> +    /* NOTE: requires arch_kexec_[un]protect_crashkres() for write access */
>>>> +    if (size > 0) {
>>>> +        struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
>>>> +
>>>> +        ptr = kmap(page);
>>>> +    }
>>>> +
>>>> +    return ptr;
>>>> +}
>>>> +
>>>> +void arch_unmap_crash_pages(void **ptr)
>>>> +{
>>>> +    if (ptr) {
>>>> +        if (*ptr)
>>>> +            kunmap(*ptr);
>>>> +        *ptr = NULL;
>>>> +    }
>>>> +}
>>>
>>> Aren't arch will have build issue if arch_[un]map_crash_pages methods are not defined?
>> Sourabh,
>> Yes, you are correct. I'll add __weak versions of each in crash_core.c in the next patch.
> 
> Just a reminder, __weak is deprecated and has been cleaned up in
> kernel/kexec*.c in below patch.
> 
> [PATCH 0/2] kexec: Drop __weak attributes from functions
> 
Baoquan,
Thanks for the pointer! I have corrected this code to do away with __weak and use the style 
presented in the kexec patch.
Eric
