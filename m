Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C31C4EF9E3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 20:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351167AbiDASe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 14:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347056AbiDASeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:34:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD1E1E3E09
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 11:32:30 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 231FivZA017622;
        Fri, 1 Apr 2022 18:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=OXUVH25Z4rc5s4LEnLfoYRzy2Jt5HANWyK6sOGoaL1Y=;
 b=BOSBozubbuD/RHFhrLRQExg2O9d0lSSOAaJ0poA7bvl9OPlMOh7kGMjSAm/tef0Xc0om
 IfMlZ5xhAt86WGb+YUmzirNvhg3p4CsRRRC3W/955BUjGLnvoAyqZKb/QLwW8h+cKLni
 tvCUwBm2ds1qNR4chtNOLbBM2Xe+qSwkGcACHcQKdB4GVMT7t6oypEg0zUKDF+Yk73l9
 b6cy58UEjECxe3AHhJ7H48vvTbprJjcsFZ2QHFEvHgYcexv6fJfpIncVJ8exDsTqBjhf
 TL5Rzck8IKb4Aw7ldCLzKXCf+TWm6iPtwUSoPSPQwKSZwQJycJ22LWclBgBWggmeBveG 1Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1ucu00u9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 18:32:01 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 231IVONK026441;
        Fri, 1 Apr 2022 18:32:01 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s9690xn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 18:32:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOT/CkhiE1AzZMX2lG9hWYVRqL/jVCvSgrzaDwUJuP+NY6Fk0Q+YIBmEtcMA1POAutTHYfxUYNsj/btnJ5RFUjB1OwdCKUHYncL5LD2dIt8ybnZN1HqW88lkZbCHm9vUdOcxnP7jYorjtOXZSSaDdkzqt4tvdLYfiVqPjWTlr0YBVYpgPP/MNhTtK96j9m++iYzI3b98QnxIhFf7iH+1TrG3S2azRbvJMX16W1Z89TCq054mKLFZFOtWhh/0K2EnmB8rufoFK6d4XRrx8PMHX+TFgiCioMHNOf/tLqwJ3k2fbwPwZDAvtbR/BvcSKnatRmoCuVRA0Vrk4TwKBHqMUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXUVH25Z4rc5s4LEnLfoYRzy2Jt5HANWyK6sOGoaL1Y=;
 b=HJbmfWS6HKOnGSr6FBmTq1HpCipn5EuOIBWQNAn+BMnbsk1pNrzAQJPKqFbsHq76fLXnkMwkMYQvDSDf0200eZdk1U26ISMhbWHe+R5AoAJh6W+qPN7UEa5gjAfKbbChniuUkta9o0pFQDYop21YURgnyl01VuH3ZdYC8gxSxbQ+R7HwLiNjbKTXTDni+S3lthKc4caPHi/Gp+gpSJTLz/MXDrWP+OhcHJJVfq0a0blu/iyU/HhbzlgrYt7nbVRqsqF8KA9SSysR12Thne3yhwFnbywSOTh4VX5fxcy2u3Nes2kr4ndXsutEo8op0DnvDmXXLsSUax7JIukfbZQm8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXUVH25Z4rc5s4LEnLfoYRzy2Jt5HANWyK6sOGoaL1Y=;
 b=AMAiRb4BLTs6/xMm6nJ8J9ZPjYA3qfPHbRKCMOc/nhtWjadSxGRanWDubzFGhO5nKhRnjhB85Kwgwdr2Sgu8WCq1OZDocH0GkcVEX3hybn2vYXnXM3i/r+E5lYF41IZEFRDJGdmWSHECIMs6zvDmdsGt4GAiWheZjvMfJRWIoq8=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BN8PR10MB3268.namprd10.prod.outlook.com (2603:10b6:408:d2::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.29; Fri, 1 Apr
 2022 18:31:58 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac%9]) with mapi id 15.20.5123.018; Fri, 1 Apr 2022
 18:31:58 +0000
Message-ID: <48ee5a1f-8e2b-d61d-3ab3-6730f662e8b7@oracle.com>
Date:   Fri, 1 Apr 2022 13:31:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v5 2/8] x86/crash hp: Introduce CRASH_HOTPLUG
 configuration options
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220303162725.49640-1-eric.devolder@oracle.com>
 <20220303162725.49640-3-eric.devolder@oracle.com>
 <20220321115940.GA354864@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <20220321115940.GA354864@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0196.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::21) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fec2126-fa8b-4fa6-a0d1-08da140de7bc
X-MS-TrafficTypeDiagnostic: BN8PR10MB3268:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB3268CDDDC89677B6ACF9227797E09@BN8PR10MB3268.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GZiK42XEBDx4CM7mZEGl+spKw5i4K9mOcQyInTGCoeXjLuvxpV/wgkAYcf4PO8qaXlE8fGOa7507poCE19a3A76V1JYb5adLsx5Tf4wEtXqEcR4hm87/sqO9GsHGa46Jxhd/2JM4D30BOn3Y7u0GLqNHcCy1Xl6lFni4T7u1rduGXR2q0UPsghmmzYZSJak0lBNb72edjguS39tcIjtcZng9JUDSLEuuWTaezl1AACmDfvS1Q3sQyxrtVly4Jbydd2FtH9I75mvqKrbuchzc4l9b4n5NIG1c3jJrzaEPsYNUyILMJfbl14pYin49ouOtrj2tBalUrs3yFnKvIVl9X0vtzOhOJOYB5I/7OFFiUaQ6uT58os5/PUuF14g/yuZBx3n3ZdxDcCRGpgHc5eEDV/Ok8i1HUE1vCsTjNajD3H3dQyy48UbDRErSFhuVejnCf3VJDIkGVmdS6b0H1ZHXLp/p6phq0cViBjBp2XJSyRA/1IiN7jWG4C3t6FVFZCs6YuG/LKxg84wnBTcl/dQruUxZLv8KAEFKbXGjKaB6SyMfCMqMR77V4zGZytHLJI47c5osNaegcEfZijgZxcbEdVTTzLG7K+a1XH0xQcxIIMXYTv269HNu0/0zF2FeX4zXD8Hwi+Zvugj/J9Mc9raA9K0VEIO9WMs9OtNWYMtYa15Dq173yFZUd/SA/pzWB1U0TdiByWl9SNrU266/9+xQtSizxvu+sXWIO2clJ58fncA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(186003)(66556008)(83380400001)(107886003)(31696002)(316002)(8676002)(6916009)(66946007)(4326008)(66476007)(36756003)(31686004)(6512007)(6486002)(508600001)(7416002)(38100700002)(6506007)(53546011)(2616005)(2906002)(5660300002)(6666004)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1laNjFjRHJEY2ZnTVQ1L3c0TFlveG5PNTZTWEh6emtyN3RjQUl6Qm05TlhL?=
 =?utf-8?B?TVpSZEhMeFdOUWhRY1VoRFFBR0xXYlk1em0zQUZGV0E3S3ZWVmdYS0REbk9s?=
 =?utf-8?B?bHo3SHZrd2VIdE5xSWFsNUw3dlFodGVoYVRENW04bXIydlpJeHliL1JhSFBU?=
 =?utf-8?B?R3I4ZzRNL0xWcGhvU2JBK0N2djBuSXg2RlRCZDllWWlmQ1d0eGhsZ3lTdjIy?=
 =?utf-8?B?a0FaT0Y0c2p6SFJxL1NpUWxOejk0RjhQYW1URFFBV1VTc0lGRjRuK3Q5cFl3?=
 =?utf-8?B?STVOWWZxb0NlUXZpbXVEWFFOb2xmZFgyZ1N1RXFDbVU3T2FTWWJSVHkwLzVk?=
 =?utf-8?B?RmljMXM0UU12N05NVWVBcmsrQkhMblpyUElBenoyL2lkRTNCbEJEdmdGb0hH?=
 =?utf-8?B?YVkzWWs4Z0RaM0JzQkRYaFVDNXRzMFNaTExZRk1ic05qUzlWRXVFVWFnTEdC?=
 =?utf-8?B?Z2RMMU1BWmtHblQ5S3lFSXhkSzN3Vm9jeDJZR3JJY2pudTdjQzRmcUhsK0xZ?=
 =?utf-8?B?RFdiT1d4d2wzdDlCVmpvM01Mb3RIVXk3UGZWRnlIUWtIS2swaURPb3pPVlQ1?=
 =?utf-8?B?MXUvRE41MU1pcEkrd3VEbkl5ZHkwd1k2Rk9ydDl2azhvaXRtMFpBZ0V4UXhi?=
 =?utf-8?B?eWpqa1dYNVA4Vk1rdnhwRHgrQ29EaXR5dVdKSzFpOER5NkhkSmxOdnBJZ2Vw?=
 =?utf-8?B?a0hNVjJhNmcxMlBRSkkvMzBiSnExY08zM1BKZGVoNFk5dU0wVWs0eDRyRlF3?=
 =?utf-8?B?anFZWnRvbzBOTERmNlNzcyt6TUJpbXBodWtieUo5L2E1UVp0cXFzN2s1Zmcv?=
 =?utf-8?B?UHFzZUc3T3cveHVMUjR4emQvS3NQR2ROOWlVbmxBSVJneVZzd3F2akI4Tkc3?=
 =?utf-8?B?L09YZmdUM3NNU1JVWlFqSG1iT01LUW5OYWU2cC9PNTEzL1VleDdvTWZ4bUhC?=
 =?utf-8?B?YkJ2YmtGRitZNm1HTVdaVWhYdVdFbmdxNUI0ZGIrYTlGRWR0Nnl0MkZnVE9F?=
 =?utf-8?B?WXNQWDVIaUlBbERyQ3NDVjEwM2JiMytSKzk5YjlWWE5YSFBpUUZ5aGxIanFn?=
 =?utf-8?B?aFJTVDB1YmxUY3B3aDNtYkxlUVZwUmlYTmZxN0ZSUnNJMm5iUFMyYms4cFpo?=
 =?utf-8?B?ZUlSZmEyRktuYzllVDE4TDhCWnhBK0ZydnZOdTh2cTAzbllTeGg4T2gwMG9a?=
 =?utf-8?B?YXJTSEt3bC9jbkM5STNsV3I1RU1qNk9rZElJWU9wdDZFbGw0bUJjczdIUEdM?=
 =?utf-8?B?NFFsdEtlVHlDVVh0emhjdUZDQnN3bS9tN2dCbFlESkp4SWVvRWkvM3JaK3Nk?=
 =?utf-8?B?U2NKVW5lb0dHd2FIeVRGbkNCMG1mRVZhdEZ1Q0lBVnBnSWxMenlFRTluMEtj?=
 =?utf-8?B?bHJSRDE3T1pzbWdGbnhxSnNockM1WnhaZmJCQ0RuenRBRXZxcGxqQXRNQ01s?=
 =?utf-8?B?T2w5eENSWWxVam96RGZvQlBIWUpvNThVdEFQbUlpT0ZJZ2V2MVhheHo1UVdB?=
 =?utf-8?B?eklqZldiK1AwSXdYN2JEUXkyaFNxdFhRNnRHbzNEbzRSNDNhMFlPOEI5cy92?=
 =?utf-8?B?N3RIdVN3bHRnVStmMW83OW1nV0Nxb0dyU1I5UE9XaVIwWHFIUWhobHNjM09R?=
 =?utf-8?B?U1NyQmsrMlI2N0VKTzBvWnJIYTdHMUtjditrNHl3R093ak41cTR2RFZLWkJa?=
 =?utf-8?B?WEtlc0MxNEpSRG1vYk9TcDNVcVN4QXZpSlBrODJOMzF6TkY1YzZIbWdOYjBm?=
 =?utf-8?B?RVBJSDU0ekxYcVRXaENkcWlBcmdCbnlGN3BsbTF6RC9aWHBEVktUVE9JQWkv?=
 =?utf-8?B?Tm1HSUJsTnJJb0ZiZm1TZi9jZERvL3dSbXUwQ0pXdTk1djdMM3VBbFM2Q1Fw?=
 =?utf-8?B?R2tVc2lwR1UvRlBFZ1E2S2ErY2ZQU0Z5KzBGN1MwWWdKVlVHcm53VEcvSWJW?=
 =?utf-8?B?WmdBcEJsbkovcTloa1BBaUNtdEVGMnAxdC9ZWmRQZXhCUVVqYjYvRVBqbmRQ?=
 =?utf-8?B?SG1Jb01JditjcFFCK0szb1ZNSWxQY2lUZXh2V0dEUmhrUUtyNWJMbi92R0dJ?=
 =?utf-8?B?NUhSdTkwOXpVbW9GRkYrRTU0TmNFVTQ2RGxhUndXbklFcmw5ZWI1d0N1TUU2?=
 =?utf-8?B?YmRidk5LakorVEh5K2Y4QmV0Z24yUmY1Y3dWUzVIaTVXdE9wTllKRERJRXFq?=
 =?utf-8?B?blcwS1JZalhQM1RJbVJYZHBPNHZQN3p0QTJWdnZndSs5VnBvTE40dy9OeTBC?=
 =?utf-8?B?Yk50c0xBbC9JTGdKUy9tdCtNS0UweDhNSmltMlVSdkgxazdMWjVBQlNLWGpI?=
 =?utf-8?B?Tmo1dEZMQ3VhNEIvNkVBNXVJODAvRVFLRVlUalA2QUhnYWl6ck9EWGNhdDdn?=
 =?utf-8?Q?dRe1PxUlEwab3i91Hrknb8YfYbQs/qZtamTBO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fec2126-fa8b-4fa6-a0d1-08da140de7bc
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 18:31:58.3094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqkdkjwH5uiKEAfbLb/kBhqUd2TzLac3IF9sxbdMvknwMK2cfClAKRn20elwLOdHE3TRjPIjC3izd1iKhUzEncNG0ueRxzFq0wZdx7ENXug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3268
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-01_05:2022-03-30,2022-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204010088
X-Proofpoint-ORIG-GUID: s9otLUUn60M7zPG0pcLnvmtgTKvyI_78
X-Proofpoint-GUID: s9otLUUn60M7zPG0pcLnvmtgTKvyI_78
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/21/22 06:59, Baoquan He wrote:
> On 03/03/22 at 11:27am, Eric DeVolder wrote:
>> Support for CPU and memory hotplug for crash is controlled by the
>> CRASH_HOTPLUG configuration option, introduced by this patch.
>>
>> The CRASH_HOTPLUG_ELFCOREHDR_SZ related configuration option is
>> also introduced with this patch.
> 
> Maybe can rephrase it as:
> 
> x86/crash: Introduce new options to support cpu and memory hotplug of crash
>   
> CRASH_HOTPLUG is to enable cpu and memory hotplug of crash.
> 
> CRASH_HOTPLUG_ELFCOREHDR_SZ is used to Specify the maximum size of
> the elfcorehdr buffer/segment.
>   
> This is a preparation for later usage.
> 
> Otherwise, this looks good to me.
Commit message updated.
eric

> 
> 
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
>>   arch/x86/Kconfig | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 9f5bd41bf660..37eb26563f07 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -2061,6 +2061,32 @@ config CRASH_DUMP
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
