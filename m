Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52545100A6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351680AbiDZOn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiDZOnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:43:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFB613F14
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:40:42 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDSx06011324;
        Tue, 26 Apr 2022 14:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=aAjJ4EikgLoj4q5smAEEYHZhbl3ku6BMyewNDtjsp+M=;
 b=h58zTeBOzM+SKbaMc/rUt24yz9gW+I/HNsjF1smJjr4fzkHM2qYnAvF/elqSqb7k2Mjq
 qWn6uJsPCoeNKTIFI8gbK/GZK7284DJ8c2WAbgohIeCZOdSUodg1R2ZAUuKCe/YxJ7GX
 Bms7nAQSpBIjT08CJteXDHn+cn1x45qm3V70IcHsJ1fSTz4hgr5rHEuQ87fFL75SpaKs
 BhdvpR0wIM5f6vZmXodnjVxX4lC/tnb0ksTIuLOU8HLYImKu2TPkpP6nzZOfbqwUIion
 orzz43zbnSC+1zDITjSk2QwJKTf8elCRgGy1h/sndJdsk2OFueBIV8bjimWvEUzHz9DS Mw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmaw4ec75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 14:40:04 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QEah6I017455;
        Tue, 26 Apr 2022 14:40:03 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2043.outbound.protection.outlook.com [104.47.73.43])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yjk1n2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 14:40:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfWeWohE/eFDhDskJ6NRlWjpet6MrRJfzo8keKm556khde4mLMB7NWZpxd5MT0PtAjkg4yloEaKtfyPIU6soDK4BisbO46tiXSCtZv1gW5ypZxmShYvqHv+ZZNbxuuhnlDo7tpgjbq5QBBIWh1zC/iHEXumQV8tOWCMqsg2W1Th4uwZvL4tKZ1yJJisn+eztS8r7Z8dQHIaPbn8lYp+BVlkGP6FW6F3FWbBTGZScwAF1WF8rr7uNr5cU5kWwLQLQyAfLyhrv66Yi9mPhCOaxclOHSGpz0ih6nWWn7sNCOJYWriJh29Dnc4bKBZXlDIrdxdIJ7vYzx2EgQG2R9cdD8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAjJ4EikgLoj4q5smAEEYHZhbl3ku6BMyewNDtjsp+M=;
 b=illl3Tso4zN+sOJgjtSzaSBpNH8LSlLgdAkI/NSFTmOPc4FE4fCjr6q+53Mp0LqribfCkyXYN3H19uj7p2m6hddtZDkXmCavrwq19IcJRiBxlT3L80sQvqglZYU7ecwVACFFsymGCroOOd7AdyxWioiHvqLKwwcpVPKkBXB2i8TB3amXKuAI1+WBVz02ZOnif3hd7fbcjV5m0rj0AaYOTZqR0RNLTQGcg3nhex3pM2bruWAv1+ar0cNKhYVh+dAPWiycstOmyX4mI8K7sRzwoUtB1WVl/fv4FPqbD0YR/j+SX0E07DkJShVE027GRgapclDcD/vElQf6vqTqlKCtjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAjJ4EikgLoj4q5smAEEYHZhbl3ku6BMyewNDtjsp+M=;
 b=d9BdG0PxEqM9MC2aFPG2gOqBm7MR7HJDDWZXq71cfwke7oLpiYWEVgVgiGof6ddt6GubPEcu6Q2sppc0dB78mAjQS5M+ATM507cXbdPIS9bz4GUe93DcpeOrLtpvUO7ZxmbNZ7ewfRTOfNcsiaNfTh+0HRiI2qdVt434kJsEFe8=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS7PR10MB5069.namprd10.prod.outlook.com (2603:10b6:5:3a8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 14:40:01 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::c11a:5b2b:9659:7c42]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::c11a:5b2b:9659:7c42%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 14:40:01 +0000
Message-ID: <300a485c-4bc5-c58a-d34a-bacdb1fa4510@oracle.com>
Date:   Tue, 26 Apr 2022 09:39:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v7 2/8] x86/crash: Introduce new options to support cpu
 and memory hotplug
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
References: <20220413164237.20845-1-eric.devolder@oracle.com>
 <20220413164237.20845-3-eric.devolder@oracle.com>
 <d90f4299-e821-f5d5-957a-1e84f16816e0@linux.ibm.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <d90f4299-e821-f5d5-957a-1e84f16816e0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0183.namprd04.prod.outlook.com
 (2603:10b6:806:126::8) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ee4621c-8be4-4288-09ea-08da2792a4de
X-MS-TrafficTypeDiagnostic: DS7PR10MB5069:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB5069D144D5D46BF35B12E78897FB9@DS7PR10MB5069.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nok1/DPkxBxspreqdRngnDYlPgbT1p+P3vRYxRyAd6tK7Ugo8QGlLa/H42raDWghoQiKwVssAuWI5moX272IiZNOOW/CSjXtiiSsYXkHWrzZE9/nm+CjXcd34JDfhjQ7FogPRFE9klnk3nHBCFuKaBzMOU0lmsVWOdDFGORK2Zm1a3Y1Or7gXqEpzmxPlzz3mpWyLA2EuV8BIgT9VXJKaPYbtnkrO+/r1RAswFRcALmZ32fqk1j02WQ67r3JgogyPPMam+bz5epQJSSJ8zCdvRFM4OhA1Y0v1V3h6IGaQ6OVLmtAGrfOVijNNqGNwELZt9LXCfU6Y4VrgYh/1znSML5eFDeG3gwFmTz8JivtsNiu9BSjXCdxzYVpW1B+d8d193Shv2bbUu5piuyNlJGKpZ0NaTqWXhf7j+3y1NJL+cgckJyh8UUEmYqKaYn2cKMkUlf/rjBvOwH1ZfsSJSz8c1RQfNf55RZB/6JEf1arGtLIRDWGrUcjvp5jpnqkciNNc/Udv+IoyASw7bCP4FK6QENj6y97QjmdrZgjL3h/dX61rWyH/JLBDnNKU6hBJYMvzdTvPLU9PtFq84USVt64zt6jBGNt0WbsMRwJYAcc3UU8L9KGkwV0PbmhC8/GGzOhAcWu/wWbRfCZDPwlZSfIJwBkqaEeBY5kEBzpaW+OzfvBpgVLl9+3HDYbdLu5pxOAWhFQDyYNEp/PbYw4lsvhOJ7WkRu2tvU9KM3Zy6JYy/rzQuWScaw2uMg4NOUrRs+x
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(4326008)(2616005)(66556008)(66476007)(86362001)(7416002)(6506007)(316002)(6512007)(6666004)(53546011)(2906002)(6486002)(83380400001)(66946007)(5660300002)(8936002)(8676002)(508600001)(31696002)(31686004)(186003)(36756003)(107886003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUllUXZKcVZJcmVJRnZxU09GN2MxSFRkTUlCWGt4NmZtY2dacTVjdWdDUzU1?=
 =?utf-8?B?Yk5VRytnYXhDTDVRYmNxWlkwK0wvcXQraWJ0Yy9jVmtReE9hS1FuZU0wMnp4?=
 =?utf-8?B?bzFyOThBS3loSVJ5cDFacm5sREhqQnpKMFFOVFUyb2RhUjVCWTRzVlFzS0h3?=
 =?utf-8?B?RnV3dFkzMnFaMDUwNHQrMVZwQlhqY0s2WkJQYXZ1SE90b1Q4OXU1YkJtSEQw?=
 =?utf-8?B?VFRIL1NxeVRmaXdKYStMNDdFMGsySDNvQmh6MDd4azhZem1DUUdUSFZNOSt0?=
 =?utf-8?B?ZkNLSVViUUxIWngyMFpmVUx4NHhobVhMRlRtY0JkTVVSdE1Edy9jS3dQT3ht?=
 =?utf-8?B?UkJ1dXNHS0c2N2xFd0VaUkxaNFEzM04yQS9oQW5SMUFMOUFFK0t6b0V4Z2ZK?=
 =?utf-8?B?amtzVVNFYUlYSWxGM3g4VlExMW9odWZsdk1lcWNkOUExTU11SGpsMzQ2RG1V?=
 =?utf-8?B?S1RWWHppL3czVkU2aEVjeTM0R0xka2pPb3NsTCswekd1a1R2WEdvZmYzLzNW?=
 =?utf-8?B?UjZwdmN4TzBJTzcxdGRXbHR4K1NNaFRzTzhBWkJIdXA4YmMwZ2FoZk1MN0lT?=
 =?utf-8?B?aExFcVRnY3VNWFBVRmQ3anNUemFjRGFjVzVtUGttRGhab2VxMnF2aDBkbGk2?=
 =?utf-8?B?elRpY1c3MFpuUTN6ZXR3d0JVaVZxQkdVNC9vK0ZzMmJyRDdsTW01RUdGS2hi?=
 =?utf-8?B?MlRNaWt2U3dJTldvSk5jN01XaDVuclFMQm5relR5dXJaY1U2TmVtZTd0bEIw?=
 =?utf-8?B?ZldEOVp5N1lEc0N3ekVHWTlSQTJ3ZzA2QTRxRk9IemVYMEg2TjJ0U0IxMWtQ?=
 =?utf-8?B?N2hyOWdCSGQ5T1g2aThSWnVhUEJuQzlheWRrelJJQzU1Q0dlYk10dFJ3dUJO?=
 =?utf-8?B?R0VxWHJIcG8wT0lON3VLWnZsZ3FYZC9zbmhDS3dOSXQwUytvV08wL3kwV3ow?=
 =?utf-8?B?dmgzQTNkOEdSVDNlaDNiQmJoTEgxN3lhOGJlYUF2MEEzSlViMU5ydUxaNFk2?=
 =?utf-8?B?dThpMEFabGhTOXRwQWZUR1JSU2hzT05JeUdVaHFPazRNdHdncDIvUnpvTlpo?=
 =?utf-8?B?V2E3bTFxTEwzcmNoQXJYUW1PRzk4Mk40TWloREQwdTVwU2lpT1VqMzhncGpl?=
 =?utf-8?B?cjB4Y0JnZjRtNzBTMTBTcnN2b1pUTmxSWkFmcEpRTUVxU08rRWNBS1JnSkZH?=
 =?utf-8?B?elByUkdRL1I4MitmVkF3cnlGbzJaWmwyOXVSOE14NVUxQ2dwZ0ZweU1WUmdC?=
 =?utf-8?B?L3IweVArNWN4K3E3ZVkrWmFpb2FvSkU1SndMR3h5aEhEbTVIdXR0UGN6b3lQ?=
 =?utf-8?B?T2dueUhiNGc0ZjNVcnRlK0JWTVFvRHFOeG1MZXpoTFBqaVBQbWlzTGE2bDJv?=
 =?utf-8?B?Sms0bTZnMFZxZEtsN21Bbll0Mm5DSGtRZHJyN3JaOHNDRDZ0eWRDRzE1UmJ5?=
 =?utf-8?B?RVk4SEVjczlsM1ZEWVg4Wm1VZmNLRHJwNEcrVXRlYXF6R2VjU2FueTRDT3U4?=
 =?utf-8?B?R0N5QlhwR0hwNTNpRFo5WTFWSHV6N1VETFBBMDNmcTIrdjdBVWszK09BeUxi?=
 =?utf-8?B?T25mNWE3RytCMnN2Y0hzcW5Cb3hRTE9DaXhZTE1lWUdUb0FHcGxZMmxYVWUz?=
 =?utf-8?B?NHJUb2hKRmRUNFp4c25hVTVIWG5QOStITzVMSWhRL0RtRU03OUdpQ09HRURU?=
 =?utf-8?B?OXI1Znl3YWluUG5qN2Z0UnlTejcycC9McHI3WXZmTit4REs3d202aXBxaHND?=
 =?utf-8?B?OUllanRWWFdEcmpNdjI5L2tGMEIwRUtUNzQ5SjNTTWdlQkd3UTY1UGJkSUhT?=
 =?utf-8?B?dnRjVHFWMnEvZy9oNTZZeEJVWXFxdW1JZ0FVMElNNHMxNGJwZDIydEJ1QUNL?=
 =?utf-8?B?L0J6d2RXell6bG9IWFBoV2pnODVXb3ZlM0pteWRMbHBqU2dZTE1oMmhNeFNj?=
 =?utf-8?B?aWhXSmo4L0NwK2xxZDNhQjh4ZlNPU0xKbkIyd0Y3RytuVFFZWDlySjhscjd5?=
 =?utf-8?B?YlY3TWEzQmxyRUU4S0c2bGtTbEFQN01VN1RQbGFscDI4SUpJc0VNQXpmRTRO?=
 =?utf-8?B?OWExU0xNTlhwT1U4eVkwcDhNVjViWVVaTWlMOVc5TWpyOTR4YVFIbXJnRHdz?=
 =?utf-8?B?ZDVWQWxRdk40WG1hbW4xa3VSTGZvSjN4dDdSYzdsS2UxcWFIY2loWHcxQ1d3?=
 =?utf-8?B?R2VMTW8yZ2JiVjFLMXh6L2lWQisvQ1dWckdVeTA0RTBRRmY0NmxUWDRJcGdD?=
 =?utf-8?B?YkU5N1VQcjc0dzVOS1Y5UGZLbm5XUXlMMTk2Y2RwdFVVamo2MVM4RHZwUEFl?=
 =?utf-8?B?WUVrN1BJdG45MEJESVpsY09YbTRFV2FpQzV4RVAyMTM2eE81dVRpL01yODBw?=
 =?utf-8?Q?076fRCxaNdifdv9gX9DPrln00/AsBkBCsNipsKNsqhLzd?=
X-MS-Exchange-AntiSpam-MessageData-1: z0Hxwg7aRW2eIw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee4621c-8be4-4288-09ea-08da2792a4de
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 14:40:01.3725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mvSTcAYCXsFPt8AZxzRiN3MAfkMkc1sY/i4JM4w+KtWOrDcoYRiAEgAcu+XS5tQbdxg3Ul73BBZyUFvCGAE/M+qTYN/AfwOZIFj9ednuH6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5069
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260092
X-Proofpoint-GUID: Foy2yvD9KbZDlBtdknZGmUhFPnVkyhb2
X-Proofpoint-ORIG-GUID: Foy2yvD9KbZDlBtdknZGmUhFPnVkyhb2
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/25/22 23:21, Sourabh Jain wrote:
> 
> On 13/04/22 22:12, Eric DeVolder wrote:
>> CRASH_HOTPLUG is to enable cpu and memory hotplug support of crash.
>>
>> CRASH_HOTPLUG_ELFCOREHDR_SZ is used to specify the maximum size of
>> the elfcorehdr buffer/segment.
>>
>> This is a preparation for later usage.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> Acked-by: Baoquan He <bhe@redhat.com>
>> ---
>>   arch/x86/Kconfig | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index b0142e01002e..f7b92ee1bcc7 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -2072,6 +2072,32 @@ config CRASH_DUMP
>>         (CONFIG_RELOCATABLE=y).
>>         For more details see Documentation/admin-guide/kdump/kdump.rst
>> +config CRASH_HOTPLUG
>> +    bool "kernel updates of crash elfcorehdr"
>> +    depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG) && KEXEC_FILE
>> +    help
>> +      Enable the kernel to update the crash elfcorehdr (which contains
>> +      the list of CPUs and memory regions) directly when hot plug/unplug
>> +      of CPUs or memory. Otherwise userspace must monitor these hot
>> +      plug/unplug change notifications via udev in order to
>> +      unload-then-reload the crash kernel so that the list of CPUs and
>> +      memory regions is kept up-to-date. Note that the udev CPU and
>> +      memory change notifications still occur (however, userspace is not
>> +      required to monitor for crash dump purposes).
>> +
>> +config CRASH_HOTPLUG_ELFCOREHDR_SZ
>> +    depends on CRASH_HOTPLUG
>> +    int
>> +    default 131072
>> +    help
>> +      Specify the maximum size of the elfcorehdr buffer/segment.
>> +      The 128KiB default is sized so that it can accommodate 2048
>> +      Elf64_Phdr, where each Phdr represents either a CPU or a
>> +      region of memory.
>> +      For example, this size can accommodate a machine with up to 1024
>> +      CPUs and up to 1024 memory regions, eg. as represented by the
>> +      'System RAM' entries in /proc/iomem.
> 
> Is it possible to get rid of CRASH_HOTPLUG_ELFCOREHDR_SZ?
At the moment, I do not think so. The idea behind this value is to represent the largest number of 
CPUs and memory regions possible in the system. Today there is NR_CPUS which could be used for CPUs, 
but there isn't a similar value for memory. I also am not aware of a kernel variable that could be 
utilized to represent the maximum number of memory regions. If there is, please let me know!
> 
> How about finding the additional buffer space needed for future CPU and memory
> add during the kdump load? Not sure about the feasibility of doing this in
> kexec tool (userspace).

I may not understand what you are asking, but the x86 code, for kexec_file_load, does in fact 
allocate all the space needed (currently via CRASH_HOTPLUG_ELFCOREHDR_SZ) upon kdump load.

For kexec_load, I've had no problem asking the kexec tool to allocate a larger piece of memory for 
the elfcorehdr. But it is the same problem as CRASH_HOTPLUG_ELFCOREHDR_SZ; how big? In my workspace 
I tell kexec tool how big. If there are sysfs visible values for NR_CPU and memory, then we could 
have kexec pull those and compute.

I do think the important thing is that this allocation needs to happen once (for either kexec_load 
or kexec_file_load), so that the buffer is always in the same spot and thus the pointer to that 
buffer does not change; else boot_params cmdline would need to change. I once had this coded this 
way, but Baoquan pointed out this simpler way.

Regards,
eric

> 
> Thanks,
> Sourabh Jain
> 
> 
> 
