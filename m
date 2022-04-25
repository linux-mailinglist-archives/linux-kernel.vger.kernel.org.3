Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2E350E692
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243746AbiDYRMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237876AbiDYRMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:12:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EBB3F88C;
        Mon, 25 Apr 2022 10:09:04 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PFQPJJ031495;
        Mon, 25 Apr 2022 17:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=OWoAXkQ1o/co5i4I1ZOvPzjt5wD0lLqbeg22l1+W/F0=;
 b=CpH743ahCvfmxHPn+cHbQrxtQqW20E6rnxkMwwWKWemRHR1ycpXL5HNr65uHFuMRI0vr
 2+UIWTk0n/i5J8z5e4mKV8ZvABVo5glLe8oK0tP/N8rq6GUdaswqSL9kqGR6PXbHZFxa
 EuP/yaA9TsKsK+VOTqDNXYrDIss+iri3K4jcVwuMXLq8u6dFB/r+HrTCcv7qrbys7jw+
 dE6+DB+uvD6T+YCBbm1oGM1abJzH44yk7jwJgyr/W+19epaac+zcPtj7+1NvivloVUL4
 b9OpDRvvVNumO17W7BkwP9qum/np7HCa2GSd+SiEQpR1Xznk/gRuxoJipyDff8CCzFtV /g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb5juwsw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 17:08:50 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23PH0TZ8015011;
        Mon, 25 Apr 2022 17:08:49 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2173.outbound.protection.outlook.com [104.47.73.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fm7w1wmg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 17:08:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Keyi1HnAHYpqtZ2vOQwhqTmvGgc/Xx8uJCz4FJlfqyM/U9jOIGodSt1EWwKo39JsXCWSwQ1VQi8p2RHksNex0oD7JrZGHf+MOgZ9BkNGynqOnJBbZkJaN2qtDO1MHTtDjaBhudbj/qdrfUdp1+TCpPDKavfTNWe7sSO/OVYQ0URY1TYJ+ue8SQhKhlIni7FbEd4HWf48kfg3Mn7lvlxYnWjLoi6ajx5ahw6FZRUPm04TG1RhBO1PbpnKQ8uvKKE4FyvKraEbADVLg6RwQj7FAM/ZtCrag5EctVKIQmZi4zOKcPqSB0dvf4nTc17CCJnK0a48RR+JV7hjPumT0ekGJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWoAXkQ1o/co5i4I1ZOvPzjt5wD0lLqbeg22l1+W/F0=;
 b=C+LslsjK6V5UQN86ZXiCenttY6U0M42pBvRCp35oyRBd1LcPoTA56oaTIQaacTg/AtGfBy0BntqeBR9AK1/u1LCvXTQ4jb0ciUjOYGKPqCnEp53R7HQlTd3ffmc53z2JPY9l90ZQ3M9JGrKS1SxD/Y7MVncptfN4Coe0Z8P/AF7WpmNqUiVdQHAXSnT/EYGihdzKSjB+/Z8jn6hFF+9Ow8ThoBiuzgUc14LzoP1/5JqomIhAzZn7JiY/6xCGjAOUw7PF2nbL6zD23oiVXh/9Uj1f+ofxcub/5oHDlKe6KEjhNxIswVlYSQg3DQaGA5Zm1bNtF3qgKJnzCZGUHFinYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWoAXkQ1o/co5i4I1ZOvPzjt5wD0lLqbeg22l1+W/F0=;
 b=nxN5S3R6MzJ80FCGWigRLpHakru6tul8/POgvlcr+seSzttalcob/2zp4taQAjnXLmG0n5HkhWmaf6Ix1YkRte1SXR3I9FMGgm82VZh9l9s18zZqnTyfTOh9lkAnE5vPbamEiGsmYlWovK4AtgYhBMxXwMVvPvmSQnmX0XTcoFE=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by CO1PR10MB4611.namprd10.prod.outlook.com (2603:10b6:303:92::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Mon, 25 Apr
 2022 17:08:47 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::f481:9785:f002:1dad]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::f481:9785:f002:1dad%9]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 17:08:47 +0000
Message-ID: <64ef5a2f-4421-3509-4919-b9c2173a5f17@oracle.com>
Date:   Mon, 25 Apr 2022 12:08:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] jfs: remove unused pointer tblk
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.i.king@gmail.com>
Cc:     jfs-discussion@lists.sourceforge.net,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220424161330.1360068-1-colin.i.king@gmail.com>
 <20220425144804.GP2462@kadam>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20220425144804.GP2462@kadam>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0167.namprd04.prod.outlook.com
 (2603:10b6:806:125::22) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb7fcd84-7172-43b5-269c-08da26de42e4
X-MS-TrafficTypeDiagnostic: CO1PR10MB4611:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB46113F44BD3DD2B8D5F4239C87F89@CO1PR10MB4611.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NT8E/IrB0nZiJoV1FZT/kFb8ijRXutsN86jPUh3SopfW3PZzeFO0/8Qmgc6n+VuZQB+k7I6Igprv8Za1R05C9zELH7HivkLXg9+Ageil+kIJzqKvWyZnsBYVZFSDeisZJOe9hwHKpMDNxgCigS2Ya6gSQLa0yP1Y2zsbRNiU30+lOj9o1IOaJ2TCNTkuqEE84wCTeCJiHRV9WkZhx6FE83ts8+hG8ptalBneUXGKcfQOItpWDB6cmVIFap+fdW2/T+4iZbPTFWKs7YDDVuxYkMDLF2NSqH3yu/IjLIQopPWByz1o/XhE7c0Qiu4fiBqq0CVZlP8Dd8c18jX0eWuN4pp3nmFAdgBg6iGyLf8wTdpP+KqXvJfi1dYBbNyAcCvW02QmmVDAt42YJfwC9PIZ6aR6g5qE0H9Fz8DOkiCby56cmG4/MY98gBdSxg6zbGYu4B0qs0KyldJNfPBlsfqrmbKkUnh89qpUJNylTcjO2Tl9HTjUdDs61dTsbPzMbqdMpgiCjSOpbEWPUqIS7Q040W9M675pEXF6hoxZ+Na1oYiY9Tzljkpt2V61jY2B969B+eKsehDrNIN5BHCbcfODgy3uOehn5KrFoNiGAuo/Yr8E6WvU9UmKXv3mwN1s/JVr0n9TYUKPIAEEAHbIvJNSneLGCY6zRo8I1u4UmsGb8vv/YUhCAvOGMPoEUNfYjd52DzCpVa1kH1LSeZ1hw/YKzA6JFC2mVfQmJrXPW5bBk+8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(2616005)(31696002)(83380400001)(44832011)(86362001)(6506007)(2906002)(8676002)(110136005)(4326008)(316002)(26005)(66946007)(66476007)(6512007)(8936002)(186003)(508600001)(6486002)(5660300002)(36756003)(31686004)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eitsS09laHlYS0lwMklic0RZN1JGTHN4bzRZRG5wNDFHUXR3QitORGVjYlZn?=
 =?utf-8?B?TlBPanpha0I4RHVBcFFBRTJnQVhyK053Z0I3all6VkxhM0U2WURMcmRXVTdp?=
 =?utf-8?B?dlZyQVM3NTNkZDRQV2Qrd05ZZ1Eyc0RTdGQ5eXd6ZWtHcjVlQUQrWkExWk51?=
 =?utf-8?B?SzF5dStlRnFYdGl0S2I1VTIvNlNDTW43R3RkeDdvTCtnOGlOYUZ3WlV3eHhk?=
 =?utf-8?B?VnhJNURTZnliZ2hhSzM2eUVyRVZzOTFqcE51VEkvei91SFpjMmR3bUViZEJP?=
 =?utf-8?B?MFpMUksvcnFIUXhyMlFNNWNoVnYrd2UxVnRnaEtkNEYyN1hUd3FPMFdjWENN?=
 =?utf-8?B?RDJXU21Ka25DcExaeVZCQU9kKzdWSDlqRDJWQ3NoYXA1NXE4V1JGMlMrMFN2?=
 =?utf-8?B?RnZoTnFzMHcwQTd2U1VBM3A3NW12bFFOKzdQMm53TVV6UzFUMThxN1ZkWGNU?=
 =?utf-8?B?RmZvZE42RDQ2aXdJQ0QvSEZ6RTNhL3B3NGR5VTV0WWNmMHRXZ1A4K2NWTXZ6?=
 =?utf-8?B?cGcxS01MTTRiK3NxQ2VZS1NBM1dZemNpRGwrdTBhL1B3cHM4MlJwd3JvNCtz?=
 =?utf-8?B?K3FwSzdZUWtTR0dQQm92dW1palFqdVB4VFJlbWduUU9CRVMweFhZOWZFVTl0?=
 =?utf-8?B?L255a2o2eG9sSmRXcHo5ejExWTRhVjJSeU1UMkpjeHFHOHhIeitIMDM5K1R3?=
 =?utf-8?B?M1RtUVNMdlZ1STYrdGh2cFIzN1hmSkhxVWxYRHJnblhyTU43czFzbDQ4eHZj?=
 =?utf-8?B?N2owL2NRY3hhR1hEUWNZN2QzMVE0dlN6bjdyZ2lHQm1UVlh2UFR2SGlsL2Zq?=
 =?utf-8?B?NlNZYTgrWk8zaDBvakE3cUtUelhPOUQ3Zk5yODRiUzRMbjRwcFpZRXVYbi9n?=
 =?utf-8?B?cFBDak0xMzFjUk9GMjZtditPUUt4MGV6Z2tsZnh2aUlaR2phbXp2ZFVTcXJZ?=
 =?utf-8?B?Nm9teXVpYXd4VmhuRGczM0Zna0lVUU45cjVmaTZ0L0QybUhKUDcyOHFnSnJi?=
 =?utf-8?B?WUdUR1lRZHdnRGUvK2Nxa1dJNEh2OHFNRFZnaG00UzBicGhOTzhVU09TUVlj?=
 =?utf-8?B?dnBtdWJDVms1c1ZUNzl5TUMrZDZzUzhmN3hEV1JYRkk4Wms2YWtsWDdWaUE0?=
 =?utf-8?B?SXUxTitoRnBDblVpd0xYWTZwd1JUbW5BeWtnbG9sdS9aUUQ2T0dtWE9EdHVq?=
 =?utf-8?B?Y0R0YUtGRkhNK0RNZEFBU1g2aWlud2d0UWd6TlJ1bnFKSkhwWDdRREpJZ25o?=
 =?utf-8?B?c1JqNW5XWXY2K2Y4K1VMbllRQ3ZYWFlHc29pMkJaaS9tMlloNjVvYVpZMHdR?=
 =?utf-8?B?Q09LSm1JZWwrRXU0VXBCNzRWY3FkRld4UGd0blFnSXpud3RkVDJmV2VtSEhP?=
 =?utf-8?B?Sitnc2d3b1ozSmVYS0lWMHpubnFTc2lMRTNKNkRpeVdpMlpVTmpYNlFQRm1k?=
 =?utf-8?B?bSsycDZKZDF4czdCSGM0ZVlZM1Vxc1dVenZOVXlQRHNlUzNTdFNJU0huU0JV?=
 =?utf-8?B?bVM5d0owU3RSdlRnd2ZWQWkxOUNBWXVPYitlTlVFQ1FuV09GMVpHQ09JSVVs?=
 =?utf-8?B?b05QSGRSdFIxaGd3aG11K1p6d05ncS9XTldud2NZQ2MrWWp0Y2dXWVpRa2dX?=
 =?utf-8?B?eWo3TmZ5cmRyUXpKRkZnQk5FcWtrMTdTcTBFM3FJQllmbno4L2lPb29zUGQ1?=
 =?utf-8?B?eFVmb2oxcjdxM0JncUZLaHpCdjRnNmxvODRhYVhabE1SaGZGK25sRWNJR2FT?=
 =?utf-8?B?WUJDTnM2UjVvcU1Ma1NRVnVZQ0dsc2RzdmtLY2s4Nkp4SDhrUVh6cm5SdUxU?=
 =?utf-8?B?Ykh5blVFeHM3cUJCdmswQVdHblkzVm9hS3RZZEJrWU1tbzlIYVhyd3RJRXR0?=
 =?utf-8?B?bFB6OTlGTU9SZkh0L2RicmVMY24ydnR1K3QxTHo3MUdJZkV2cHBaSmUxMmw4?=
 =?utf-8?B?aURNRXE2SWVRaGNEbVBnUGRFbUEydTAxTmtKS2NFeW05QVRpcmlDbjNHclda?=
 =?utf-8?B?Z0xIZEdFOHJLMU9tV3BGTnZFcnZVZGx0VWxQU3lndGw0anh2RnZWWld2dzJj?=
 =?utf-8?B?WVYrTUxDT3VTZUV6bFB4QlRmV1ZLTFJFL1NranFaUEw0L2hHY1F5R0JoczJM?=
 =?utf-8?B?bFppbkZWNW5LUHVIazVHQXpsa2Q1bHRzS2RJSGs1VkkyRDJJb2xmVWRiaFJQ?=
 =?utf-8?B?VTJGbWZRQk5VNzRnQVhnTFg2aTVuLzJpcHNoQU9ZMjYyVm9zazJhWkVNaVVC?=
 =?utf-8?B?QThJVktRd3VXRG8zRFNLL2FiUFI3VFJTckIzQnMxMUhReEdXVExvM2U4eGNv?=
 =?utf-8?B?cU9xOE81S0hlcnJRbFpNRGxoSCtwRXVCc2JsQjVwMG1kbXhJL3c5aXE5a2Ez?=
 =?utf-8?Q?uMSfks5gYWRZPIpY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7fcd84-7172-43b5-269c-08da26de42e4
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 17:08:47.5532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dX/AHr5XhjfZq2r+aK8sY/T61c/tKrqA2IcdT7B80hb3rY1yve+Dz2nt5kGKNkiJANC+/83yvAyTHeIOi8CITJG+ZO6Wd1j7aBkhSvOMKNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4611
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-25_07:2022-04-25,2022-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=848
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204250076
X-Proofpoint-GUID: jocHWTm0M1Znzx0NJzdUnLy9rvatDSps
X-Proofpoint-ORIG-GUID: jocHWTm0M1Znzx0NJzdUnLy9rvatDSps
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/22 9:48AM, Dan Carpenter wrote:
> On Sun, Apr 24, 2022 at 05:13:30PM +0100, Colin Ian King wrote:
>> The pointer tlbk is not used, it is redundant and can be removed.
>> Cleans up cppcheck warning:
>>
>> linux/fs/jfs/jfs_xtree.c:2551:17: style: Unused variable: tblk [unusedVariable]
>>
>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>> ---
>>   fs/jfs/jfs_xtree.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/fs/jfs/jfs_xtree.c b/fs/jfs/jfs_xtree.c
>> index 3148e9b35f3b..d29979d0a6aa 100644
>> --- a/fs/jfs/jfs_xtree.c
>> +++ b/fs/jfs/jfs_xtree.c
>> @@ -2548,7 +2548,6 @@ xtRelocate(tid_t tid, struct inode * ip, xad_t * oxad,	/* old XAD */
>>   	   int xtype)
>>   {				/* extent type: XTPAGE or DATAEXT */
>>   	int rc = 0;
>> -	struct tblock *tblk;
> 
> This would have caused a build error if it weren't ifdeffed out.
> 
> #ifdef _STILL_TO_PORT
> 
> JFS is an IBM filesystem from OS/2.  Apparently, this stuff never got
> ported?  Probably we could just delete the dead code.

Yeah. Once, long ago, I had dreams of enhancing JFS with shiny new 
function like defragmentation. I think it's safe to say that isn't going 
to happen.

Shaggy

> 
> regards,
> dan carpenter
> 
