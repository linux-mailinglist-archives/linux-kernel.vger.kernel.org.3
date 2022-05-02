Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F72517AF0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 01:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiEBXv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 19:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbiEBXvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 19:51:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA6930557
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 16:48:08 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242MQh3e013665;
        Mon, 2 May 2022 23:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=J6gKn3AdvevaK89tV7sY8JQ9JoaFRmUQusNbuDG4SOA=;
 b=u1mU6jERFjNm8Fyd5qfA0l9B/ASHCAU3nF/dSSM7wx/M22b0uIEC47BZi/bRl/3+a3sb
 JXglY8cMxDnXTes67o6wzO3GpsBTA8SZSPdT1JgIj+tDEnqix/VZUMCSvvZ0l83vD0wf
 3kvTNJhqcOFfTi3r7ApsxVFJZWQgDVtMz7upFyWAFDBZq46gcmNI0uV/aNwK/nGjaFRw
 vkBGw5AsO3m4W7bkpFedqS3uH8N5xeeFgHWHYwu2JIwURQPuYDFX5WY9dQNdBp1w39V4
 IA9BIYY8tE7tqAqkW5Th/+jf0YS+PHDvEhpTi6TmUsdtTQWGD7m+TZEXecGIPKSeemEH ZA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frvqsckfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 May 2022 23:48:03 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 242NV2TC031261;
        Mon, 2 May 2022 23:48:03 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2044.outbound.protection.outlook.com [104.47.51.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj82wfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 May 2022 23:48:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXMLDs8oG2M9cvShTV0T91VKenG3XHFnAUSvsCXZ7FxE6o+YEhVzz71XgxD7OwMFsj1sSKVkPTCHaNMQ71zy3cIQ5B3Lm5B+eirJ67ePcvKDvUshn9wR77pWv0Ljc3u3vnI3XB8RfypP05gwExL4hlUxB5urteLeXDCBqhqX8rygPtvywNFKYMrDXKYwOWXtgoQAC4e4whkjzoJVhln8d2YJkEd0WobqLSFMP6mk4f8L5gqKN4cIriIfHZklvRTXWsy0Dad7bFdSPajH1E+wE0EaUY7y4mWlzo50gOsPgFT0dnt4/wdsYg7V3suRpU8HhjBOx0MhFglkuviwMqbgjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6gKn3AdvevaK89tV7sY8JQ9JoaFRmUQusNbuDG4SOA=;
 b=HyVLeUkQpfGBl218JD4gGqcCnOed24zQ25OTq1Jf2cxQHm9xy2PIxKxOic9mqQwZvOKcBMk4gzBA8/g/AJmkF+lt+eDxbaZDEnLg8z807SXL7w1Df5d2FIJXh1kMQnJn532JfLa9oWQVnGNspfvinMk1aYPJIBeWeKyqlemUY9qejiIz/6YHsyiDP2RbhfxNRNDoYlZ032ZiWJBPC0A2iKl61byvBpuqynoIB+fZbHYIOmfSdy+nr4J+2RQwZYOpNxQLZPjZQisb/M8m7YCLY/QnA1CnvcD7hbwUwW+zZ+IINpw+xOsvwILdEDXe8FiThVjygDwNezAFLw9JDStSKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6gKn3AdvevaK89tV7sY8JQ9JoaFRmUQusNbuDG4SOA=;
 b=SW1FH6zq/oX+pzn5vQ2YkhqIGKCSo9/jaTtU/N62zBnTVcl+qcSbi3EH1OgirF5Ai5A6WLsgohX1jEFSpgQqDoCU7BkIqXqYXHLoUCG10POhimMamsuArfV5VmishCp+FtmQVAY9k4h8XctmUINiT6HVwbX21EfkPKMz2mHgqh0=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by DM5PR10MB1881.namprd10.prod.outlook.com (2603:10b6:3:10c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 2 May
 2022 23:48:00 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c89:e3f5:ea4a:8d30]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c89:e3f5:ea4a:8d30%2]) with mapi id 15.20.5206.024; Mon, 2 May 2022
 23:48:00 +0000
Message-ID: <f279bbbb-6af2-95f4-08c3-97ba72deb6cb@oracle.com>
Date:   Mon, 2 May 2022 16:47:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 1/2] vdpa: Add support for querying vendor statistics
Content-Language: en-US
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20220502102201.190357-1-elic@nvidia.com>
 <20220502102201.190357-2-elic@nvidia.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220502102201.190357-2-elic@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0059.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::34) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bed43a7e-de18-4a56-ac25-08da2c9630c9
X-MS-TrafficTypeDiagnostic: DM5PR10MB1881:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB18811AFEF1DA8C181CA7D89BB1C19@DM5PR10MB1881.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s/xN5A65m1I5ikXkSdmcEsSrosJRjzgKFB7QwE1F3EwAft6jT0FmgsUps8zKYWZchqTwFH6EMCApAfpv8004OvQl2I7gVUg+3Oj3Z/e3AasV1M/S7+sky3zO3PstzByCV3mnrYR33C7YZqQjSgCDcqPFbnzXoveX7PgV6Tjwzyxlc8eeAZ+s+x8tpCOF8cO9tSCQlkpQLBppmUykZB0vMdRBI30z+hyxJFmpGdot9xSCcfmQUizX0ybr34XyOt9g4UchJatQ1IqM0koKrV4tUcybm5rJCB9PG0eRRib871euW4lsavQQcr0aPv1+QH8YVxYdc5qierNr7B90ZfekxRelw0ZXAejpkuEJKUm90yXvEgEr4QzQ0WdhEElAQHKodoJ/0z67+GWKaM0KspZLsWuDytzp4AGcY8cfLaPVnkxKwJPOHiYO6xosGGV/eoU71p3SH8xOiVVDJYLCtPZ2Pew3oJ7Lm6RJYrz4/GzkF/j5l4iFjym5fTooeQfYlTd6rnALUfSQN8+1/QhpuZWXq5vF9xCl5Zwlitwtr2NlNmtSvUyX2q5ejZUnd/rTia8eaMpXs3x9DXZ3QXMBb49sgpEy+UGjClz/5z1ZO8vWtCeqxkAxg4rW76brxlnLP4+ClHSMbbJ1T1qgdH9Oat5zE7JF9bW9ijZDG8WNkPbHx+h9WSSQ3Dms3PMfr2wXydPFjOhnCVQS3OvhtbGn0zZ9eqJwepRbiak29eo2Y6eRH2JUvWiNFCPqQZypHBPG/34Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3287.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(508600001)(6486002)(6506007)(6512007)(36916002)(53546011)(83380400001)(186003)(66476007)(66556008)(66946007)(36756003)(31696002)(4326008)(8676002)(2906002)(5660300002)(8936002)(38100700002)(6666004)(316002)(26005)(31686004)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVZDNXVzWndTd3VEL1JnTXZFS0JiNFo0WDhVOHBaRDZsalhPaUFmV3VXV05J?=
 =?utf-8?B?d0Q0QW1vWmp4UkpFcW9FUnNrWi9rU0w1OHp0UmpaM1lXMW5COXRBeUF5RFRa?=
 =?utf-8?B?Z2hxcTA4UTI5V1ArWmVkTzBMeUlSUXlqb0NIaFZXRStJUmVHMUhGMEdZajNU?=
 =?utf-8?B?dnM1MXAwNU85Zk1zSU1FenhOZ3Z4OTkxVW9KNi81dm5HUWNGYzhBTzB5a3g4?=
 =?utf-8?B?d1dDeDRCdXBzVEJISDUrOHNvUmw3RkhoOTQvNjRxNUl5dTZ5RkthUFJZaWZ5?=
 =?utf-8?B?TTJLOTJuK240U1NCTm1mSXBORURDdVZEWFkvbE1tTmJwTk5Wb1oxazQxbm5R?=
 =?utf-8?B?cU01Kyt6NUFqOXlWd2VEcU1XTUNZZjRMSFRJVEMwaXA2YXRLeW5obS93VTRw?=
 =?utf-8?B?MVYxcldvNnY2OEhBVERLZEE2ZGs1blNHZWJnUmVxUDBnb3lSMWc4Y2JGN2J4?=
 =?utf-8?B?eGdKR2x3SUx0MW0yWngrcSt6Y0UxUkExNzlFa2xnR3BuNm1FQnIvRGNvcjhG?=
 =?utf-8?B?Mk5QOTllTWtKbXpteHVIZTdzUXd2T0tvTEh3WGEyclUwQlNKV203VGMrK1lM?=
 =?utf-8?B?bmk0TlJyQUhPeXZrbXMvVkFkM2RCblBsczZuVHk5UmZRNy92MGxZMWRzZXVD?=
 =?utf-8?B?ZU5yYllpZ01taHFHdDhXV1ZieU03YXM1Wmt4VldDWGlIOW55Q1N4eTJ3Rzk2?=
 =?utf-8?B?b0RVZFNoYnRjY1poOEwvUnRCSkZSSlVRb2dmVzBFajgwQlI3R21tMHlXb21B?=
 =?utf-8?B?VnI2elJlaDJDQ0taNVZROWlaWENxaXFnYTlPeFlRVDhHem9VK29tTnhSZElV?=
 =?utf-8?B?cG00czl5TDhnOGEwdk9NT2w3K05kTTNCKzlTdEg0cEJ1Y1NQRDN2Y3pSOUFO?=
 =?utf-8?B?UE00d2hqaU1UQXNEd2pkUjFtL2pvQlpWc2IzQWwyQU1VbU81TnVaRzg4WGl2?=
 =?utf-8?B?aFdnb0hvbkQ5MVNxTFNVYmJvOEdUVG1TT2FNQjdQaGxSei8vNGI2UGY3TGMw?=
 =?utf-8?B?SXJMNjM4WXhqWDN2WldBRGRmOGdYU0RGSC9xZS9QZnp6aGFlcEZEUVM1bWZi?=
 =?utf-8?B?WkdCdmt6RkZzbmxJTlI3RFRuWFZQMk0xWWlBajRnTHd0amxQbHBZb04ybjFM?=
 =?utf-8?B?YlFObjRhK3Q3R0ZUTWdZWUI2MnJuUDRNVFNuSWRoaUdmR0NkSnlNbThUMTBR?=
 =?utf-8?B?VmhIUlp4UENGYzV1U1JITVZVNldmOENyT3R3V3I4MHpVWGNRa0ZJSThqU0FL?=
 =?utf-8?B?c29HcEE0ckYvL2hWeXVTSklTclJoNEtPOXJ5ODl2SzhBWjA3OGlFcEo0dHFj?=
 =?utf-8?B?aGZZRzdjUXRSVGQwY0w3TlBwU0VaVExobDZwOTFJSjJ0Nko1TWIrcldxOXBy?=
 =?utf-8?B?Sk9uYW1aT2haVFpyTlhQanV6S0FFME12KzRrdy9SdzY2OHpldjExdzJmMnpy?=
 =?utf-8?B?b1Rab2xYRi9FZGIxWjVTd29Yc2ZaWEFaa1B4cWw4UzAyNVpnby9ib0lLcytp?=
 =?utf-8?B?dUw5Tk1wZEY1bm9TUkJONjl1bkVsN2RrR3BTTzJXSDljc2c4US9XRFVaNVpr?=
 =?utf-8?B?LzRFcng5bWpwZmUwSHJKRUZMY2lNQTlYQi80dG4xQS91Zy8vSmljZmRXRys3?=
 =?utf-8?B?ZkRnajhqUVJNNHV5QjVyQnF3UFR6S0FtT3RTenV2ZzRBS0pmb0JNdmNnZG9q?=
 =?utf-8?B?RDFXZ2xUQk1GQkhkYlZJU0xrMEx5TEptUXkvdVlManlHcWc2N2QrMGJGWmxh?=
 =?utf-8?B?TVVYbUd0UzRSbkw5Z0tRczlOL3Q5Q1NUeW9HSTNvRW5CRkQrUm16OGRSM2M3?=
 =?utf-8?B?dzJJWXprL2ltcVdZWE5FWXZlRHZDbjVQUGdtS2dPSGR2KzJ1WE5SR0sybVh2?=
 =?utf-8?B?T09ZUXdhdlc4Z1F2blJyQ3MwTWh2L2NranhGUUIybGV3ZTBmRWI3RHo5eVJZ?=
 =?utf-8?B?ZUF6NHFUTTRISWZLY3U4QmFrS2VBcFlSUGJQTFJOMTExOEpWSmZwRGsvdmVi?=
 =?utf-8?B?djlIdzUyZ1JDOUR3WXQxZ0tueDFPdHE3RnhQMS9MbmdORVNwSSs0bW56NlJm?=
 =?utf-8?B?VE1oZzRlUG9mUVQrSWVSZ3VnSjhhaElWRXppZkxUZmRSSFR1Z0NNZ2NINUZS?=
 =?utf-8?B?UzB2MVhhUnF2VDI1L0M2RE1xTWdOTkdNdzR0dEMxZXVkNi9FSnZ2OXlFdHc0?=
 =?utf-8?B?NGhBV2prNktDbitDdnpxNzI2WEZ5Nno5U3M2M3E1UWRIU2Qydk5lY0RwQnB4?=
 =?utf-8?B?VFZKeUxEQlVYb3VESzNrZDhqWFE0VUFsUnkzbzhEcjBsZ1Zya2ZCdFhZdlhz?=
 =?utf-8?B?dTcwQmVOUkcrcS9JMlpad0FMMGh3M1RDRDI5QnFFMzcvVDFmWjVqV0xGUVhu?=
 =?utf-8?Q?uXy5Gw0GfjFzvSW0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bed43a7e-de18-4a56-ac25-08da2c9630c9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 23:48:00.3617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vtqZofdNU0l2MkzKZjr0kxSOmnGSwxbGCOlj3IHzvUqcld9Ji7bwX85KJMPZsbkLP0vJhx4jxnKkotqDuTFDSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1881
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-02_08:2022-05-02,2022-05-02 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205020172
X-Proofpoint-GUID: CcQ9DASeHSH_i0yYUtigShJWYca2CrEU
X-Proofpoint-ORIG-GUID: CcQ9DASeHSH_i0yYUtigShJWYca2CrEU
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/2/2022 3:22 AM, Eli Cohen wrote:
> Allows to read vendor statistics of a vdpa device. The specific
> statistics data are received from the upstream driver in the form of an
> (attribute name, attribute value) pairs.
>
> An example of statistics for mlx5_vdpa device are:
>
> received_desc - number of descriptors received by the virtqueue
> completed_desc - number of descriptors completed by the virtqueue
>
> A descriptor using indirect buffers is still counted as 1. In addition,
> N chained descriptors are counted correctly N times as one would expect.
>
> A new callback was added to vdpa_config_ops which provides the means for
> the vdpa driver to return statistics results.
>
> The interface allows for reading all the supported virtqueues, including
> the control virtqueue if it exists.
>
> Below are some examples taken from mlx5_vdpa which are introduced in the
> following patch:
>
> 1. Read statistics for the virtqueue at index 1
>
> $ vdpa dev vstats show vdpa-a qidx 1
> vdpa-a:
> queue_type tx queue_index 1 received_desc 3844836 completed_desc 3844836
>
> 2. Read statistics for the virtqueue at index 32
> $ vdpa dev vstats show vdpa-a qidx 32
> vdpa-a:
> queue_type control_vq queue_index 32 received_desc 62 completed_desc 62
>
> 3. Read statisitics for the virtqueue at index 0 with json output
> $ vdpa -j dev vstats show vdpa-a qidx 0
> {"vstats":{"vdpa-a":{
> "queue_type":"rx","queue_index":0,"name":"received_desc","value":417776,\
>   "name":"completed_desc","value":417548}}}
>
> 4. Read statistics for the virtqueue at index 0 with preety json output
> $ vdpa -jp dev vstats show vdpa-a qidx 0
> {
>      "vstats": {
>          "vdpa-a": {
>
>              "queue_type": "rx",
>              "queue_index": 0,
>              "name": "received_desc",
>              "value": 417776,
>              "name": "completed_desc",
>              "value": 417548
>          }
>      }
> }
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>   drivers/vdpa/vdpa.c       | 129 ++++++++++++++++++++++++++++++++++++++
>   include/linux/vdpa.h      |   5 ++
>   include/uapi/linux/vdpa.h |   6 ++
>   3 files changed, 140 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 2b75c00b1005..933466f61ca8 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -909,6 +909,74 @@ vdpa_dev_config_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid,
>   	return err;
>   }
>   
> +static int vdpa_fill_stats_rec(struct vdpa_device *vdev, struct sk_buff *msg,
> +			       struct genl_info *info, u32 index)
> +{
> +	int err;
> +
> +	err = vdev->config->get_vendor_vq_stats(vdev, index, msg, info->extack);
> +	if (err)
> +		return err;
> +
> +	if (nla_put_u32(msg, VDPA_ATTR_DEV_QUEUE_INDEX, index))
> +		return -EMSGSIZE;
> +
> +	return 0;
> +}
> +
> +static int vendor_stats_fill(struct vdpa_device *vdev, struct sk_buff *msg,
> +			     struct genl_info *info, u32 index)
> +{
> +	int err;
> +
> +	if (!vdev->config->get_vendor_vq_stats)
> +		return -EOPNOTSUPP;
> +
> +	err = vdpa_fill_stats_rec(vdev, msg, info, index);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static int vdpa_dev_vendor_stats_fill(struct vdpa_device *vdev,
> +				      struct sk_buff *msg,
> +				      struct genl_info *info, u32 index)
> +{
> +	u32 device_id;
> +	void *hdr;
> +	int err;
> +	u32 portid = info->snd_portid;
> +	u32 seq = info->snd_seq;
> +	u32 flags = 0;
> +
> +	hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags,
> +			  VDPA_CMD_DEV_VSTATS_GET);
> +	if (!hdr)
> +		return -EMSGSIZE;
> +
> +	if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev->dev))) {
> +		err = -EMSGSIZE;
> +		goto undo_msg;
> +	}
> +
> +	device_id = vdev->config->get_device_id(vdev);
> +	if (nla_put_u32(msg, VDPA_ATTR_DEV_ID, device_id)) {
> +		err = -EMSGSIZE;
> +		goto undo_msg;
> +	}
> +
You seem to miss VDPA_ATTR_DEV_NEGOTIATED_FEATURES from this function, 
otherwise I can't image how you can ensure the atomicity to infer 
queue_type for control vq.
And should we make sure VIRTIO_CONFIG_S_FEATURES_OK is set before call 
into vendor_stats_fill()?

> +	err = vendor_stats_fill(vdev, msg, info, index);
> +
> +	genlmsg_end(msg, hdr);
> +
> +	return err;
> +
> +undo_msg:
> +	genlmsg_cancel(msg, hdr);
> +	return err;
> +}
> +
>   static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info *info)
>   {
>   	struct vdpa_device *vdev;
> @@ -990,6 +1058,60 @@ vdpa_nl_cmd_dev_config_get_dumpit(struct sk_buff *msg, struct netlink_callback *
>   	return msg->len;
>   }
>   
> +static int vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,
> +					  struct genl_info *info)
> +{
> +	struct vdpa_device *vdev;
> +	struct sk_buff *msg;
> +	const char *devname;
> +	struct device *dev;
> +	u32 index;
> +	int err;
> +
> +	if (!info->attrs[VDPA_ATTR_DEV_NAME])
> +		return -EINVAL;
> +
> +	if (!info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX])
> +		return -EINVAL;
> +
> +	devname = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
> +	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	index = nla_get_u32(info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX]);
> +	mutex_lock(&vdpa_dev_mutex);
Given that stats_get() is a read-only operation that might happen quite 
often from time to time, I wonder if it is now a good timing to convert 
vdpa_dev_mutex to a semaphore?

> +	dev = bus_find_device(&vdpa_bus, NULL, devname, vdpa_name_match);
> +	if (!dev) {
> +		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
> +		err = -ENODEV;
> +		goto dev_err;
Missing nlmsg_free().
> +	}
> +	vdev = container_of(dev, struct vdpa_device, dev);
> +	if (!vdev->mdev) {
> +		NL_SET_ERR_MSG_MOD(info->extack, "unmanaged vdpa device");
> +		err = -EINVAL;
> +		goto mdev_err;
Missing nlmsg_free().

Otherwise looks fine.

Acked-by: Si-Wei Liu <si-wei.liu@oracle.com>


-Siwei
> +	}
> +	err = vdpa_dev_vendor_stats_fill(vdev, msg, info, index);
> +	if (!err)
> +		err = genlmsg_reply(msg, info);
> +
> +	put_device(dev);
> +	mutex_unlock(&vdpa_dev_mutex);
> +
> +	if (err)
> +		nlmsg_free(msg);
> +
> +	return err;
> +
> +mdev_err:
> +	put_device(dev);
> +dev_err:
> +	mutex_unlock(&vdpa_dev_mutex);
> +	return err;
> +}
> +
>   static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
>   	[VDPA_ATTR_MGMTDEV_BUS_NAME] = { .type = NLA_NUL_STRING },
>   	[VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING },
> @@ -997,6 +1119,7 @@ static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
>   	[VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
>   	/* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
>   	[VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
> +	[VDPA_ATTR_DEV_QUEUE_INDEX] = NLA_POLICY_RANGE(NLA_U32, 0, 65535),
>   };
>   
>   static const struct genl_ops vdpa_nl_ops[] = {
> @@ -1030,6 +1153,12 @@ static const struct genl_ops vdpa_nl_ops[] = {
>   		.doit = vdpa_nl_cmd_dev_config_get_doit,
>   		.dumpit = vdpa_nl_cmd_dev_config_get_dumpit,
>   	},
> +	{
> +		.cmd = VDPA_CMD_DEV_VSTATS_GET,
> +		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
> +		.doit = vdpa_nl_cmd_dev_stats_get_doit,
> +		.flags = GENL_ADMIN_PERM,
> +	},
>   };
>   
>   static struct genl_family vdpa_nl_family __ro_after_init = {
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 8943a209202e..48ed1fc00830 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -276,6 +276,9 @@ struct vdpa_config_ops {
>   			    const struct vdpa_vq_state *state);
>   	int (*get_vq_state)(struct vdpa_device *vdev, u16 idx,
>   			    struct vdpa_vq_state *state);
> +	int (*get_vendor_vq_stats)(struct vdpa_device *vdev, u16 idx,
> +				   struct sk_buff *msg,
> +				   struct netlink_ext_ack *extack);
>   	struct vdpa_notification_area
>   	(*get_vq_notification)(struct vdpa_device *vdev, u16 idx);
>   	/* vq irq is not expected to be changed once DRIVER_OK is set */
> @@ -473,4 +476,6 @@ struct vdpa_mgmt_dev {
>   int vdpa_mgmtdev_register(struct vdpa_mgmt_dev *mdev);
>   void vdpa_mgmtdev_unregister(struct vdpa_mgmt_dev *mdev);
>   
> +#define VDPA_INVAL_QUEUE_INDEX 0xffff
> +
>   #endif /* _LINUX_VDPA_H */
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index 1061d8d2d09d..25c55cab3d7c 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -18,6 +18,7 @@ enum vdpa_command {
>   	VDPA_CMD_DEV_DEL,
>   	VDPA_CMD_DEV_GET,		/* can dump */
>   	VDPA_CMD_DEV_CONFIG_GET,	/* can dump */
> +	VDPA_CMD_DEV_VSTATS_GET,
>   };
>   
>   enum vdpa_attr {
> @@ -46,6 +47,11 @@ enum vdpa_attr {
>   	VDPA_ATTR_DEV_NEGOTIATED_FEATURES,	/* u64 */
>   	VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,		/* u32 */
>   	VDPA_ATTR_DEV_SUPPORTED_FEATURES,	/* u64 */
> +
> +	VDPA_ATTR_DEV_QUEUE_INDEX,              /* u32 */
> +	VDPA_ATTR_DEV_VENDOR_ATTR_NAME,		/* string */
> +	VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,        /* u64 */
> +
>   	/* new attributes must be added above here */
>   	VDPA_ATTR_MAX,
>   };

