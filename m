Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460F35089DC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379245AbiDTN6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379236AbiDTN6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:58:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7293BBDD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 06:55:51 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23KAuWqU013493;
        Wed, 20 Apr 2022 13:55:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=7kwKpgznuRC8oyppDQs5LBEz0IHnRIX4LkKuVEFCPOA=;
 b=rgjk4zt7YS711m0yQnyPHxj49qFcOfL/qbuDZBemBOjmHSJhBoyMopj3OYqVyjDC05Zy
 1AUoX7ZPAfnmMXucaIKHS9Xle9iiUIYP+UHwNH5GoIv9k7o3zv5BlRosIHsMmz7R584x
 FX42LtjqJb7/hSe6p8I7IlGv/aXM8Cbko3DKWsR83k2puBcL7kJl/7k5s9udBo+AE4vo
 rA54tveQ6sJsJT4VPlcec5/yk2m0NdS4lNscBVYOqVvmGt0jLWFSjIfrVsnm4pY4uSfc
 MLuB/CGeaD2HtggsXimkjSxQ6nfV9C6mq235CnUqTTbbTpqIhyE+aot4iba87rmS6hTG kQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffndth5mg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 13:55:22 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23KDq1r1010497;
        Wed, 20 Apr 2022 13:55:21 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm86g4gh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 13:55:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqNdzKoR0psbRrdcqBfxIE7EldWpxWJViKcXFG4tFghYKHdy0OkhtXSye7HRODO1G42gerIa4A4qFvhZR1lWR0eSyEXn+HAYt9q3ESV08QfcCub1Zv5Xk6rHJ1shCjkre3PQh4W/nvgRiF8+dk5QkGHtqpAoqc/czLK6t+OMISPtUi2/iIi40PFiG4dLk9nrpRt3WILBdY2ytBZgVdf7ZSyqPENBd5ehWgXTS+t45LFwZzsilTmrRClAGLYkQxyZex/9jeVBmabdT5U5KKvWs7g8ZNhUjsdfSYYt4nL7Kx7U0zcwUgSqdh1y0fwMAE5k242zGmu1/Tx39TjebUgoZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kwKpgznuRC8oyppDQs5LBEz0IHnRIX4LkKuVEFCPOA=;
 b=a9V9+uS8PFFdXlPnUEd3b3rYZISVvxoSmkyzXsFNdqnmwBl5Q5Ae95CbHRiPui5CdKbU4aqN4T2j/WGNX3cutMLwVhDZFXWWL8V4sIroWEPMVrNYbR0Gmy78WCk9Pu8CVnSpN8TAG8qfS7xaYPCyTVd/2njyxtXLD00awIRw/pxSWFGfXZVUByGk3KDGm2O6VyvT4I29ToJMRtbRUOo/5CFG916EP5pNm7TGKJUM9OweEXQTl5mOVvDezvuU4vTr6+9YEbb6aNtww3tpGiinEQvYF0CUGgf96CVpNECeKom7CkmwFBSp8wHV67SlEHZX/S/61ENPXtzPYspxPEQusw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kwKpgznuRC8oyppDQs5LBEz0IHnRIX4LkKuVEFCPOA=;
 b=PYmOM69apJv59veVhHRka7r9K1rwN/7rAine53qn30brMhVbsxC1vnJv0ABMS2BfnZQRXH0AQzahJVFoSURzmTD7KUdIhcL+vek9T3Gikk16uxqp1v791hL81Xsq9GXLpgAgCYb8a2O682T3Tcl2A9bYeOmlDwEnis0JVSXaLkY=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by BN6PR10MB1491.namprd10.prod.outlook.com (2603:10b6:404:44::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 20 Apr
 2022 13:55:18 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::4427:92a2:50a5:50b6]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::4427:92a2:50a5:50b6%6]) with mapi id 15.20.5164.026; Wed, 20 Apr 2022
 13:55:18 +0000
Message-ID: <eae41639-cbca-4ea6-417f-f9b34a7138ea@oracle.com>
Date:   Wed, 20 Apr 2022 08:55:12 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH v5] locking/rwsem: Make handoff bit handling more
 consistent
Content-Language: en-US
From:   john.p.donnelly@oracle.com
To:     Waiman Long <longman@redhat.com>,
        chenguanyou <chenguanyou9338@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     dave@stgolabs.net, hdanton@sina.com, linux-kernel@vger.kernel.org,
        mazhenhua@xiaomi.com, mingo@redhat.com, peterz@infradead.org,
        quic_aiquny@quicinc.com, will@kernel.org, sashal@kernel.org
References: <20211116012912.723980-1-longman@redhat.com>
 <20220214154741.12399-1-chenguanyou@xiaomi.com>
 <3f02975c-1a9d-be20-32cf-f1d8e3dfafcc@oracle.com>
 <e873727e-22db-3330-015d-bd6581a2937a@redhat.com>
 <31178c33-e25c-c3e8-35e2-776b5211200c@oracle.com>
 <161c2e25-3d26-4dd7-d378-d1741f7bcca8@redhat.com>
 <2b6ed542-b3e0-1a87-33ac-d52fc0e0339c@oracle.com>
In-Reply-To: <2b6ed542-b3e0-1a87-33ac-d52fc0e0339c@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P223CA0016.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::21) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3f776b1-9059-4b03-df3b-08da22d56753
X-MS-TrafficTypeDiagnostic: BN6PR10MB1491:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB14910D47536B7973E6D82CEAC7F59@BN6PR10MB1491.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vUbQ1SxNb0gRJcORlcAlF9rID8H30dNvTA4pM5Bmnyk72DxHOLx68aByrwzTLycU0gUGyzj1T78NlzPWbyzCu33VHNzsuoerx3aS5A0lXk8wL9nDifIGKTUIc8EKrTi8rxUHFnTEVbxeZhHBJYsDRpfBOJXHLFFtNO/VlyAVmNZMtgrimIoP//m/ukDNv1tRvMfbYN2nMsU+rjcfJO2aecdYaSE/B+9ePzEllS3dKK4NIBNPoGZRHQmfRt0WiMyejYSLO8zfsMGOEyBE7rtflOaMWs/TXtCW3XNfJ4Mr/f6FjT37MBq7AOhWqwr/ELG517qAvviPGpyv6KxYwKbQa4+eBnq1oINWZJhEt4r4OKBojxgGbQU+3VbB6HAd8j9W8I3TKQFwrUwQFStOA8Jn8ZvGJ5jlH+yGxBHV0KA5DuMS5oWiUrIjvuLhu2IbtyA1WUgJCxp+Ku5eZFl31gOt1k+WnuvUVNqGEASK8nqvdkjvjuKbRTP6VapddLLv5ILCQog7N3x+3JZ7P2EWhcui1CwGPjYCQzlE5QtU5L6PuAVH6oC4N669vCThsGGDgyLxVpO+8K1uBPiCBjV9t0FcYs24vrM9jVAW0yrATIvTYMaox+dsFzqREjScw+q4nRXQIV3YqFYWRG2rfJl44usPfZqq4x5/cNkKLjRhvoS6UxSx5ZKK39OdoWIK3qvWP956SCV0ANouH1DUERBZXo6YQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(110136005)(38100700002)(36756003)(83380400001)(31686004)(316002)(2616005)(8936002)(53546011)(5660300002)(508600001)(7416002)(6506007)(2906002)(6486002)(66946007)(6666004)(186003)(26005)(66476007)(66556008)(9686003)(6512007)(31696002)(86362001)(8676002)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vlc1NUg5QVo4dkNvV09DV082a1lXN2pEV0U5VjhVN1grbmtCb0xLbENlVDVi?=
 =?utf-8?B?WitKb3c5RXFTM2VBanlJVG1KWWpDdXRJM1pZNkJHOGZEN2txV3pGSUowMkhN?=
 =?utf-8?B?ZUlNUDkvK0wrNmdGK3lYMlN3cXNMMVFkdENjWFhudjhHS2VnSTdNZnZxSnpV?=
 =?utf-8?B?OW1ZTTJaS3FNY3lMV1krNk5iRytkbndGS2ppcU8wVmhCRnlGSDJUVGpQYytw?=
 =?utf-8?B?M2RLbDQ3TVE0cDQvaWlib293WkpNdGMrRitoeU8rWFovN3BiNVpHRFNtcld1?=
 =?utf-8?B?alVDUG0rMG45V3FmWGRncCtZSDU0UVJOdTNpZWFiQ1FieTFLTFoyT1Nlc1dQ?=
 =?utf-8?B?S1BTd3B0enlJSDJRTGYyS3lSVk1DVzJhTmlXN2syaEcrU05aRkJYQ3RnNHVG?=
 =?utf-8?B?ZnlZeUd5cUp6STNscERSRHNLbmJhUjAyaDlxUkJWN3YycGpqalduQktVRExJ?=
 =?utf-8?B?LytTbDRjcWJjWVRSZUM5L3A2YStJM2doYkpFV3FOQXFwYnhJQUN5MjFVZDVV?=
 =?utf-8?B?T3J6TzRaeGZ4TWVLK3ltZXVIaW5JSkpXTnpsQjFrK3VYM3hzSHptOVNRbHpx?=
 =?utf-8?B?UnFia1p2Nm50OG9tOUxDQzJDTi9TM3VnMUR0UC9TOSthMHQxM1V1NW1GZ3Vk?=
 =?utf-8?B?YWs5V1k4VjA3SUEyTnpuUEM5cWdWU2kyUXIzOVF5MjNFdWJHR0dHK1I1cDlC?=
 =?utf-8?B?V25HeWJzV0cvNjhnd1ptTHFuNitad1oxcG0vRWJyMVhXWUc2a2E1K3hqVXl5?=
 =?utf-8?B?Y0c3VHAwVzZueHYwWkxWNDhRS21semYwYTJkczZYTkQ2d09ZcDJvSnFuM1g5?=
 =?utf-8?B?TTBUamVLL205cnlvL3diRWpTODFXNlZ2bVRhVGtGVUE5Z3FJRXhGVU9MSzZO?=
 =?utf-8?B?M2hhZW9NM1hxZnhBSU5Nd3c0Y0owM2kyZUl2WWxjV3lvazgrOXFCTC84eDUv?=
 =?utf-8?B?U1ZRVk1tV1lGd28rdWR2dU05S0JyYlVDYzR2VTN4WVBFRFV0aEFFVXZZNVFx?=
 =?utf-8?B?TzNHa0pKTngxK1luQnlZVTByY0hSK21wVFpZOStPVE9UY2FaZ3lLSGF0Rkgx?=
 =?utf-8?B?YWEwM25yVGZqYjY2LzN4VUFTV3h2YWM5TUgyL090M0hBV1lUNC9QTmtjaFo0?=
 =?utf-8?B?MXQ1ZGVZUk80bzQxWm9VVTdrNWVpSk5relhKWmVYS1MvelViWUdjQVJuYWF4?=
 =?utf-8?B?SGpqUkpYMkZ6ZE9OK1hwZ3lEQWRwb0xqRFJRSlEwbS83cDhkdWtSN3VTZTEv?=
 =?utf-8?B?eFBRQWF2dTExeWEyM0p2R1VibVRoZ2k1Q0xBQXpDODlQNk1QMENaekJKOXR4?=
 =?utf-8?B?ci9WS09ZaitlNDBtYkhLb0o3MDVGV3pEbWlDa1g4NE9DT1E4S1lyQUlCc2Fz?=
 =?utf-8?B?REZUS3oxTkdteUZVcFljQk45ZFJkeDlMN21ibUEwdTMrdlh6ckpLQWVlZ0JS?=
 =?utf-8?B?OVlseVlBR3FndHovakZnTWxlZldXdWQ2dVRNK3EzMnZFTExPZ3F6RCtWSWtn?=
 =?utf-8?B?alYzekdZc01RcEdEYU5vK09XZkdUY2JyUU1jbnJWZFY3azczazFuK3hFQmRX?=
 =?utf-8?B?dUdWTHFLeFo2VHVlY0VuZDdwTGRRSmxBNzZBWnEyTWl5WkVmOXhNM3pXaDIy?=
 =?utf-8?B?NTlzd3VtU0IwSWwyMi9rWUppMG9nMWdBZmo5TmZ5dWxGOWNicU1pcHdoY3lC?=
 =?utf-8?B?Y1Q5K0lWWnc4dEhOVUc0OFZYMHRYNEphRnBZbTdsa2RNRTE1NzQ5b2VSVVFm?=
 =?utf-8?B?dGNsYnAyblhYd09wZ0p1NzVTTUoyY2p6d1dTVHNpNjgyL255Z0pXaVRPaW1x?=
 =?utf-8?B?TFRYM1M3cWVRVTBIUXN5ZFhjMXlpUVdqd1BxdStubHhaWVEwZjY3L3cxNWgz?=
 =?utf-8?B?RjVFZnJ6YTY4YnpHZTFFMmdGZmR0eWdtSHRSV0dvSU9zejVQeU9GT0NqVURU?=
 =?utf-8?B?SVJ3V1VjSmYyRW56WnVWUUV3bWs2VnFsVUdUazlhWmVwcG5RSnFKTU5pM1U5?=
 =?utf-8?B?Qmt5eVU4amxnNjBwbTc4RnNpNFBnTWRNbzFXZlRwa1NSZFoxeUc0ODJhdHVO?=
 =?utf-8?B?NUJTMmNiQmJLVENxd3BObFJneWRMbDIvUTJOekp2R2I2TFo0VVRaTTBveUN4?=
 =?utf-8?B?NFM0L1FxSWtzRlpnT0dtWEV2eWxtNWhZeXZLZE5DVVpRT3ZXVGJqSDJlMG9P?=
 =?utf-8?B?SkMrTXk5YjdXNFNpVGVPdGlqYkNFeUFXdkFFWXR2cWlKRCtHR1UxSFdrb09w?=
 =?utf-8?B?UHpIcDBDNm1oT3B1Mm50b2RTRHcwWE85ZGszS3dkTW83a3V2WUNkUWVWZUtW?=
 =?utf-8?B?QkFQRHJXN1A0NmlqQ2lIU29Sa0xDVEZBVmkwWnUrdEM2RHBHZGJEeDlmc1Fv?=
 =?utf-8?Q?fq5sHK27MZ1phHQc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f776b1-9059-4b03-df3b-08da22d56753
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 13:55:18.4212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: miGhvmYjhQnNT9yshs310F44bDVDKEks/1iLK6eVT+SHgXELRWVln6wU49EIa/k2ijGHYS+K8Woe/MtR3l8YYgZNmmvzPAllVbNjJ+k4N68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1491
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-20_04:2022-04-20,2022-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204200083
X-Proofpoint-ORIG-GUID: Wq2SWGLR22e_013YbWxZD7TTS51MA_pB
X-Proofpoint-GUID: Wq2SWGLR22e_013YbWxZD7TTS51MA_pB
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/22 11:28 AM, john.p.donnelly@oracle.com wrote:
> On 4/11/22 4:07 PM, Waiman Long wrote:
>>
>> On 4/11/22 17:03, john.p.donnelly@oracle.com wrote:
>>>
>>>>>
>>>>> I have reached out to Waiman and he suggested this for our next 
>>>>> test pass:
>>>>>
>>>>>
>>>>> 1ee326196c6658 locking/rwsem: Always try to wake waiters in 
>>>>> out_nolock path
>>>>
>>>> Does this commit help to avoid the lockup problem?
>>>>
>>>> Commit 1ee326196c6658 fixes a potential missed wakeup problem when a 
>>>> reader first in the wait queue is interrupted out without acquiring 
>>>> the lock. It is actually not a fix for commit d257cc8cb8d5. However, 
>>>> this commit changes the out_nolock path behavior of writers by 
>>>> leaving the handoff bit set when the wait queue isn't empty. That 
>>>> likely makes the missed wakeup problem easier to reproduce.
>>>>
>>>> Cheers,
>>>> Longman
>>>>
>>>
>>> Hi,
>>>
>>>
>>> We are testing now
>>>
>>> ETA for fio soak test completion is  ~15hr from now.
>>>
>>> I wanted to share the stack traces for future reference + occurrences.
>>>
>> I am looking forward to your testing results tomorrow.
>>
>> Cheers,
>> Longman
>>
> Hi
> 
>   Our 24hr fio soak test with :
> 
>   1ee326196c6658 locking/rwsem: Always try to wake waiters in out_nolock 
> path
> 
> 
>   applied to 5.15.30  passed.
> 
>   I suggest you append  1ee326196c6658 with :
> 
> 
>   cc: stable
> 
>    Fixes: d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more 
> consistent")
> 
> 
> I'll leave the implementation details up to the core maintainers how to 
> do that ;-)
> 
> ...
> 
> Thank you
> 
> John.

Hi ,


  We have observed another panic with :

  1ee326196c6658 locking/rwsem: Always try to wake waiters in out_nolock
  path

  Applied to 5.15.30 :


PID: 3789   TASK: ffff900fc409b300  CPU: 29  COMMAND: "dio/dm-0"
  #0 [fffffe00006bce50] crash_nmi_callback at ffffffff97c772c3
  #1 [fffffe00006bce58] nmi_handle at ffffffff97c40778
  #2 [fffffe00006bcea0] default_do_nmi at ffffffff988161e2
  #3 [fffffe00006bcec8] exc_nmi at ffffffff9881648d
  #4 [fffffe00006bcef0] end_repeat_nmi at ffffffff98a0153b
     [exception RIP: _raw_spin_lock_irq+35]
     RIP: ffffffff98827333  RSP: ffffa9320917fc78  RFLAGS: 00000046
     RAX: 0000000000000000  RBX: ffff900fc409b300  RCX: 0000000000000000
     RDX: 0000000000000000  RSI: 0000000000000000  RDI: 0000000000000000
     RBP: ffffa9320917fd20   R8: 0000000000000000   R9: 0000000000000000
     R10: 0000000000000000  R11: 0000000000000000  R12: ffff90006259546c
     R13: ffffa9320917fcb0  R14: ffff900062595458  R15: 0000000000000000
     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
--- <NMI exception stack> ---
  #5 [ffffa9320917fc78] _raw_spin_lock_irq at ffffffff98827333
  #6 [ffffa9320917fc78] rwsem_down_write_slowpath at ffffffff97d25d49
  #7 [ffffa9320917fd28] ext4_map_blocks at ffffffffc104b6dc [ext4]
  #8 [ffffa9320917fd98] ext4_convert_unwritten_extents at 
ffffffffc10369e0 [ext4]
  #9 [ffffa9320917fdf0] ext4_dio_write_end_io at ffffffffc103b2aa [ext4]
#10 [ffffa9320917fe18] iomap_dio_complete at ffffffff98013f45
#11 [ffffa9320917fe48] iomap_dio_complete_work at ffffffff98014047
#12 [ffffa9320917fe60] process_one_work at ffffffff97cd9191
#13 [ffffa9320917fea8] rescuer_thread at ffffffff97cd991b
#14 [ffffa9320917ff10] kthread at ffffffff97ce11f7
#15 [ffffa9320917ff50] ret_from_fork at ffffffff97c04cf2
crash>


The failure is observed running "fio test suite"  as a 24 hour soak test 
  on an LVM composed of four NVME devices, Intel 72 core server. The 
test cycles through a variety of file-system types.


This kernel has these commits

1ee326196c6658 locking/rwsem: Always try to wake waiters in out_nolock  path

d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more consistent")

In earlier testing I had reverted d257cc8cb8d5 and did not observe said 
panics.  I still feel d257cc8cb8d5 is  still the root cause.


Thank you,
John.





