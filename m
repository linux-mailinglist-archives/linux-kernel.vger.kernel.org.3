Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212DD508CF5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355725AbiDTQQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiDTQQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:16:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E531AF32;
        Wed, 20 Apr 2022 09:14:07 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23KFV2Y5019231;
        Wed, 20 Apr 2022 16:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ooB2RxGWxeLyDbDD9GGB2TVmqG6+Hn1n/fSj2kAWyzo=;
 b=RdCy5JvJTjh+YeoBhNdi2Q7+JbqwrTO9dS8ggTN6OEgJA1BLu8BFaXJU5Rp9YzAYR8w5
 WmIEcIGYbM6j6cuL8nYCnQJxQ9jj32WCSo6MOeLgVZCfAyjP8iNt7xL0a9CvQBOfXxGO
 ppx5hZMMl56WQn/HySLPSnrRcK25110ZF2zlhF0S+nt4uHuul12v1bi4LQYqtdmiSC8j
 3j5m89ElRgETbcYmlzX7NqNlyQfRA4zdm2qgoVVkNmi96T0PGxBBirS7iVkdmYA2LZkQ
 QbAf6m4RQVIqGveJEROuZYDuX2E1SRAvxslUGRoWuMSO9prUUSDsfPUT0jTNfw4d3dnz wQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffmk2skds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 16:13:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23KGBnD6037506;
        Wed, 20 Apr 2022 16:13:57 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm86wyhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 16:13:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3D0nmy1RSKDalm8Wddrwu2EABiHObKIMhJCFvH/vPvkrSswH2MbyhdDvAxc3YwXw31TCQKLnnwu72B6BH+4/VdOYwUnbax3Zht7AYACbL8e181w630G4GsUapfMW1P7AbCQ1TiZwexD2WsYWUuK2YSz3IjCF6WyngN1uogqiejMascLOk3h4Zy91Vm3n290exTQmbe43OWLPIksQnaGbk/RALKj6mJemDnDiDTEXjy+EzH/XlMbshpvWFUQMSizu6Y7wZNbUO/mSDirQsx7pie+nXl5IGXsM0EOMRVr0rQgCG484FM9mWOVi0kSCK0/lyypnCuA4AcLuV1WMolCZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ooB2RxGWxeLyDbDD9GGB2TVmqG6+Hn1n/fSj2kAWyzo=;
 b=Noq3Ic9PSdUJCtLKrNs3ALx2uCOxFP+cU9oNUgjrRKtHy48J32e0kHSgaq5BCG7hcoxah8MMt5IcktE3FhFgpVY1fe0EspTbfC5Nhwqn4720aV13NTkPg2GuYm2YkNu9IuSuu/J6+8a7x+0pUVv/C7PYlbHXz3lz61+oIdaqtqCO2DDdpRnQMpBkiY52eEQw4FmDNLZYrUWCphvrgK2FNu1WoF4eMQ1t7u3jBrUgsxAhzeyh5RQeH7jVUOUp9N45knW3uUg6DykkYHYOydwUt7YI0uSP0Rxo3DBtPy35RevsHEP4TZrtBtqjqljz9Or+YdIndIF+KlwiurXgTSqvFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooB2RxGWxeLyDbDD9GGB2TVmqG6+Hn1n/fSj2kAWyzo=;
 b=N+3b33zh6ONqRzDbjvolbZ+Lrayq0/L0i3s0qJ8mL9X2xAWhOkydZkGPpa5lIXqNZ+D9v4V0cuy4+hsl8wDuF5JX1LJpnsLaF7mraES0wEuLHmZ3BUS+TPqRPRsrttwcL7EkZco8EIjrK3SE0kRY6bKmoIb8KYXZ1Em0U+ASUlc=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by CY4PR1001MB2280.namprd10.prod.outlook.com (2603:10b6:910:3f::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 20 Apr
 2022 16:13:54 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::4455:2c02:503:a182]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::4455:2c02:503:a182%8]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 16:13:54 +0000
Message-ID: <00c1cd38-5164-edfa-6c47-606803629dcf@oracle.com>
Date:   Wed, 20 Apr 2022 12:13:50 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH 4/4] xen/scsifront: harden driver against malicious
 backend
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20220420092503.11123-1-jgross@suse.com>
 <20220420092503.11123-5-jgross@suse.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <20220420092503.11123-5-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR08CA0016.namprd08.prod.outlook.com
 (2603:10b6:5:80::29) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93297cad-a2bd-45ea-b52b-08da22e8c428
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2280:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1001MB22801B29BE9CCD03D3063BD58AF59@CY4PR1001MB2280.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UnKnIN4sN9OHsN+J1rLH6eA1YJeqUBIph0BPAr5j5W9lstEPoQST3wks0ykq4cD/TPqkpp2hteUEs4Kn5MuUvtWwrZocpoYcttnAu0sH6beIwVDI3QzihVhFdMzZkEPGRWNY9qPWIQu6sK7KRk6I5WA/l+e2xIesFn9Zyq3ltWKXOfTeEARfh4+8ZsfDqgvlDBqumsVV+Wv4rpQtDkK46q7/Vnvbewx85INHGcv6ZBa7JCJccRFzxKMz7smrPFSE7nWiHcInlYuJiQEwUeqFE/1eM5pL8DhKzWoLzOWMnCUZAsrnU+bJQpHLvEo884ofqFiJtXm4J/envlADWy37CITlOg6vDyZTFJhbSTmsCXylVpmhNFhsev+E6N+ovI3nQkz4UFdA4YEmflvjP54pGtM8JFzL0tUOkSWfxN/3Z0R/2nIyHIjM3E1hrDnuP/CvbwYAOB20+vkjhbYw3LX1la57M4nUDUS94t9cU/wC8uRg1LvUDylyYW6NNz7IQ3igTeB88isjnVaL+UsEOtXJqnPYTT6HrE53rnEgTIOrbfTq4v9KhXGc4IDKue6luKFWhibjfZRIRTzo7Os9oyudHO3FBGcnHY/cE4XZ9tAk2Yz7/PNyf4S77Rt/bRQzgIFIEQEU/dla+hRowZItJaFhRRVB3dkGtQvdCY355906Lo0gkI2y1etyUeR+PfmVZIHKRgAblxeWMQsEi1tfmE1oPJ8qnjHakCdy/2A7r0V/n8kc2W2ytL4O9WUIJMt//NVT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(4326008)(6666004)(83380400001)(6512007)(6506007)(53546011)(5660300002)(316002)(8936002)(8676002)(44832011)(38100700002)(31686004)(26005)(66556008)(508600001)(54906003)(107886003)(66946007)(31696002)(86362001)(2616005)(36756003)(6486002)(66476007)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YitVZUszQWxGdFBibUFsVzFqK21BQ1dJT0gyZjJwTjRHTVBYeWhmdFYxdlJ3?=
 =?utf-8?B?cnlCRXlXOUlPdlhGYm9NcGoveWtFVHM2N0lsRE5lMEV3M3JTdllvODYzV2wr?=
 =?utf-8?B?eUJ5ZVpjS3hHOERmTG5UY2dRQjlMN3c1UnhZWmhoOS9rQ3d2NXlVdG1ZNnNH?=
 =?utf-8?B?aEdNdnBjcThEUWRiVHE3bW5KclRkTks2VXVobVZKVHNNek9wYVB3SDZuaGg1?=
 =?utf-8?B?OFEzK09qL3c2bTlyejFtZk5YdDQrUm9XOGt3endsa1diakFZQVowemRRQ3JE?=
 =?utf-8?B?eFBmK0NXUU9zRTFTc3pvM2lDL1Rvakw0aitRellPOTJsaTZjQ1NFd1hFNHRj?=
 =?utf-8?B?d3dwQnh6eUwyK0lLRkJhaDF6Rm00bTJrcnFXWUpMSHJRRTJBalFJR0phUVFh?=
 =?utf-8?B?NlhnRXRQNlo4RzZsV3dHQ1lHTlR2dmVzZHVNV09CeXZKUkFrdFJzL1FycDJk?=
 =?utf-8?B?d0ZMOGN5SzB6bDVMUXR5VGEwQTdBT1pqVUQzWlYwd3JubzF0Q3d3WlY2MXJE?=
 =?utf-8?B?cTlTdEplZGlUUVY5SnQvSWhzTFBkWmRZNnMzSmFnVVhzbFRSenJNUG5WeGJF?=
 =?utf-8?B?WlI0TGl2dGlkWWQ2OGM3ekNycHZBWDY3bzBuenRaeGtqVUQ4UEVsWXpzYmcr?=
 =?utf-8?B?YmlVQ2l1RkFpQ0NvZHNLM1IvNnJXRHJDNHRPNllleVQyTUNqaTByQzBnd0VV?=
 =?utf-8?B?OG82dUxwTmVyejlrL0RKVDVIaWROMzZMZEhQekhjcVhsenZ2TldmZlk5U1hr?=
 =?utf-8?B?THFxbGVWTzNubU1JNVo4YWI4emo3bHZuemxPOEl0QUFOdWxYaS85RWkyWGNu?=
 =?utf-8?B?S3pTUXR0SEJTVTNQUEJLckVKWmJDcXZ0VVc1OEVaR1Q5enFrQmVtdGg4RmR3?=
 =?utf-8?B?YU0vZHQ4K2l5cU8vOWZNNGxTbFplRUFKUDBTVGR2ME94VzU1S0w0eWlVT1J0?=
 =?utf-8?B?cmZyWENxaUlIVzVFYU5aWUwwSWNTOEFxalBwbDU5cGVPRFlCcDNoVDQvbDBQ?=
 =?utf-8?B?VTlsVDFaRDE5OUd5VnRraGE4WnNYUEtXMXBXVUtzNDFsdVY4SzViSWRaM2U1?=
 =?utf-8?B?a3Z3NDlPMXg1eWJMd1liUW5kY0M0eFJPM1hRb01ubS9tSTVObVNVeXRJSDZq?=
 =?utf-8?B?UnIzMXlsUlc3VjJxOWlnbjRrV1JmaWFsOWVIdGxtWHljbHhaWjZvNnlCZ3Bn?=
 =?utf-8?B?SjZYTk94QnIyTkpjV0piTHNOdjhEMHZqQjdlakxCYWQveW1nMGRpWmI5RUdi?=
 =?utf-8?B?clhRMm9nVG1WRWhTWHFwVllyQWhaNittamJkWENxanEvL0xqWmhpR253Nndk?=
 =?utf-8?B?QmdwSTRwRmhCZjZ1K2tMM0VYVGZTNnc3SU5hbVJyRlljL3UyWWpwb01HRHlV?=
 =?utf-8?B?ZEpmWHQ0ZVY0S1FhZlRWVU1pYXR2aVNwU2JlRzJudVZwSGZzMktGVVFSRVND?=
 =?utf-8?B?enpseXY4YXJ0RllKelJnT0JpM0FUUkZadVdub3V2V3dhbzY5SWVRNS9OSExs?=
 =?utf-8?B?Q1dWVFJaNVlKQ1Y5akp5L0g0c3d6OVF6UlVIRXhINWVINEpyVG5WeTE1M3V1?=
 =?utf-8?B?RkRVVUU4L1FJeHNXekJ1TnYxanZRZElWQTludndXOFFQNHdUWlNycHFNTTY2?=
 =?utf-8?B?L0lOYmRaNGM4eFZpUVNSUGxETExpNTBMbHNhTnFQU29PRjEvS2FUNjhzMU5D?=
 =?utf-8?B?V1lDb3lvZzhjcFpxdnlQWGlJaUxRU0puTnhnTnhmNS85TlpTRmoyWVNOYTNN?=
 =?utf-8?B?aWhRd2g0Sm94dzM0aWhnWjVQcHFsL0gxYUxNam8xem9GVXVNU2tST3JFR1FD?=
 =?utf-8?B?K055RDB0OE1oZlY3eTFUa2oxazhVMzJnZUdTbWk5L0NSS0U3ck43YTVLKzBY?=
 =?utf-8?B?U2hqTlZ5YWtnMEF4SVU1T2syS0Z0eVBnNFR2QkN1RGUwdHdIeHFwZlZBbmdV?=
 =?utf-8?B?bkdnOFRRbWFGL082SGJUOU54b2QvMnNXaGNHbkVXY0lHaFpkMjR2OVpZYThT?=
 =?utf-8?B?VUJTdXMxSHJaU1BBOUk1QjZ1MXNrVS9SNGJSK1lmYkdiWTFKaGduUmZaQkl1?=
 =?utf-8?B?YVJRNlM2MEY4VXdUWDdaVGxTZmNVZm5qR0ozQ3RnNHp4MjVYMHhNZlZscFBt?=
 =?utf-8?B?L3BmeXM5cklCdHpBOXpIUi9BN3duZ3NZbFB6b05Gb3pmYVc3eDBMMWhTQTNu?=
 =?utf-8?B?S1RqWjBLNm9teU5jNUY1REduNlFJb0pvaDAza3N5eU1lYlBCK2JSbUl1ZG1Z?=
 =?utf-8?B?SWs3U3JnNlF1VE56VzNnZ1dnTFJxMmZiUEloTmZaQ3VYT1VVY3ZHU2Zmcml4?=
 =?utf-8?B?Z1g0L2xMTWtMZTNQelloTitCZ3pzdWtCcU5MeGRYOVEzYjMwZmYwSHFuQy9u?=
 =?utf-8?Q?UpQFlkVdTII62WuU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93297cad-a2bd-45ea-b52b-08da22e8c428
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 16:13:54.6199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ja2wW0udeLSZSj/0MDSGYw0Dn5coA43XcPww7sB+bvvEWIVAAx93MJMfE/TT8lgRQr0G4mWuLs4bd4Swd9UKjRmX+vCrT/15ckZ6RqWpjRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2280
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-20_04:2022-04-20,2022-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204200097
X-Proofpoint-GUID: ci7Wv1xx3pzIbiV1hcxAvsA6Hu_Dne3e
X-Proofpoint-ORIG-GUID: ci7Wv1xx3pzIbiV1hcxAvsA6Hu_Dne3e
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a couple of nits.


On 4/20/22 5:25 AM, Juergen Gross wrote:
>   
> -static int scsifront_ring_drain(struct vscsifrnt_info *info)
> +static int scsifront_ring_drain(struct vscsifrnt_info *info,
> +				unsigned int *eoiflag)
>   {
> -	struct vscsiif_response *ring_rsp;
> +	struct vscsiif_response ring_rsp;
>   	RING_IDX i, rp;
>   	int more_to_do = 0;
>   
> -	rp = info->ring.sring->rsp_prod;
> -	rmb();	/* ordering required respective to dom0 */
> +	rp = READ_ONCE(info->ring.sring->rsp_prod);
> +	virt_rmb();	/* ordering required respective to backend */
> +	if (RING_RESPONSE_PROD_OVERFLOW(&info->ring, rp)) {
> +		scsifront_set_error(info, "illegal number of responses");


In net and block drivers we report number of such responses. (But not in usb)


> +		return 0;
> +	}
>   	for (i = info->ring.rsp_cons; i != rp; i++) {
> -		ring_rsp = RING_GET_RESPONSE(&info->ring, i);
> -		scsifront_do_response(info, ring_rsp);
> +		RING_COPY_RESPONSE(&info->ring, i, &ring_rsp);
> +		scsifront_do_response(info, &ring_rsp);
> +		if (info->host_active == STATE_ERROR)
> +			return 0;
> +		*eoiflag = 0;


*eoiflags &= ~XEN_EOI_FLAG_SPURIOUS; ?


We also use eoi_flags name in other instances in this file.


-boris
