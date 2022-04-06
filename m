Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58AD4F680A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239709AbiDFR64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239831AbiDFR6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:58:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD6118595C;
        Wed,  6 Apr 2022 09:09:11 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236FlTEq001019;
        Wed, 6 Apr 2022 16:09:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=N42fMK/NY96yCou9cfbaQ6Gkcj/uek4IpWLhZy1LYNs=;
 b=K7sWW/DsmYaws86k5pDOmRBGQQKS1TmhC8L1kHubVumDeM1Jql3ma37FC1+/Ek0hdWXx
 uVgXONfew9em//b26GP7M6kZetyHZez9p1NbETVLrlvIUaE3+t/uu8Xmc2Su5+5XlpkS
 J1RuYLFxry9fuxVWd0Antvo+fXDFDxZbs+npUvPU3au6HpZtbkrtNir3jT3CkU/gVQq0
 1ZixRAD1TYaQcarUnUYQY1WKyEoNzseUBhcTjjhTOOa0xCh65smrIEVNRXLXYCa8VQ7c
 BhdWjDkeC1sA4bWmzC3u06DJydhhsGOjZPZVXAS/UIh10hFA7IUKIpJMQ5xgBRMFaEXt /g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6e3ssd5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 16:09:00 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 236G0cBm025204;
        Wed, 6 Apr 2022 16:09:00 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2047.outbound.protection.outlook.com [104.47.56.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f97y6g8x9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 16:08:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChMEKzM89WZs5+36GJ3R++z9msr0E4q1IopW9LZqhExLL03iTeSh04FBNdG01Zc07r9228NrBbJS9o0i7vbvfcC7gUQ9gcTH0S5EpsCFf/BMHheTWRX8U1xE/Djb3KzPkQpKjCH+IvMH/n/jTvVteXf2W0DAKcxZGf5pbwnkSH9ItuTYEtzS7OCNl62HOaNxUVtFCKzLfFWkk9a7R9hMPYyp9bQsiFEBkA8uFeY0nY//i428T2a2uPNQ15h0+gGBVpcaLR5dsMCKL7ArvkZvJeSztWjwhKRYP4m/k4eCqRLbYVUxwgtZhlqmwOJjLv4Y+H8afiWu6lWw/I6JVbtcXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N42fMK/NY96yCou9cfbaQ6Gkcj/uek4IpWLhZy1LYNs=;
 b=Va/NV+F/BnfJsC3MoHMgSf1ZnBNzigxOw8qaIkr1PtiRhH6U9+MjlzjA6PUPSfU527XICfk9KhKr7Zd2eg3WkJ9uvixDO6yxIvWZ4NFq8hg8Bez6Qcxgeft/lR6ufda/GN6DmhEG7ZOVYfnHj8rQ6Mt0ILJTE9WQD3n6wjU4VmtOZfdM+OUYbUPM1NHhedENOT8NiwuEXG3vBYQC/VMFK/LPgXmVA4/Wbk/CxY91hUarml1/NY64Wd/tY1fdgDfN3hQuBD08vfgney4FDqrS0pMos06+lH0bgbZ+fKO6iGsOLDlPBcscG27ESIEKr2cHxz8bFIKrFBHt8Y9yELnLgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N42fMK/NY96yCou9cfbaQ6Gkcj/uek4IpWLhZy1LYNs=;
 b=HN+75Lqyj74VkXTsFUD4+AdiLteQxWSDJYYhbfzKP8KvX7atNy2gKKRVipQTLpqgm6+JpYL2DyT04fOoKqJHydca7hn8r4R5omEftDdpX0liFXpixRis0Ei5orMXanOSwhGLKYRpwNKxz+lp9XySkX2J8neD1SUKjPx8rpAkqdo=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 CY4PR10MB1638.namprd10.prod.outlook.com (2603:10b6:910:e::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.31; Wed, 6 Apr 2022 16:08:58 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3cb2:a04:baff:8586]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3cb2:a04:baff:8586%2]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 16:08:58 +0000
Message-ID: <9eaf17d3-c259-cfc1-0aed-19abf420e3f7@oracle.com>
Date:   Wed, 6 Apr 2022 11:08:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] scsi: core: always finish successfully aborted notry
 command
Content-Language: en-US
To:     Wenchao Hao <haowenchao@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linfeilong@huawei.com
References: <20220401035020.1043239-1-haowenchao@huawei.com>
 <775f75db-edb8-8f39-2592-862756811710@oracle.com>
 <275178ca-1fe4-b00b-c1f4-c8c34e7f4686@huawei.com>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <275178ca-1fe4-b00b-c1f4-c8c34e7f4686@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR08CA0008.namprd08.prod.outlook.com
 (2603:10b6:5:80::21) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2188c6b-776f-420a-8286-08da17e7c189
X-MS-TrafficTypeDiagnostic: CY4PR10MB1638:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1638717897424E0B386412B9F1E79@CY4PR10MB1638.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hecgP7HNaDD7C7DW+J05YGos2ksDydyCjSCfbYlFdlAujpPc7IOkU4X/f1jdppqPNmm5DCMPvBVUPHPMChu2A2HQ8Q9O6Vye7c2i4NJzaEUKL4bBhiRquWH+yKQeBjADnYCKGrTlyNLqzH+JubYyb/anRuo/R++2c8+nuTzAs9yt/9wqH+6L+3re87/rt5n9jJypH7mBh2p7kBTaEEaL1T4SfOkUmAFvg0Jf+TPpVu/1SAIHcQ3CznGZW9+Ou/m576EWBmDBdgvGpoldluGMuFtmQ35mbXiYGZC/bip52ARCfxkfAjDsuyfHnbErQxBM6DOgTshST5i320d1dqVZSDONbBdz7oJOjGi0tbqTYi71+mKxRJjOJEp2qnm2bEtO9iy3mRLchV6IrXapxnMROVQxQncMEG0RsY4tyXMrDvKfLqJ9CpE8Noy9hp86/QV/23ZwIulnvK73fdzbXoSy5XSx/t3I0cR6c+dFyzjCFh1JyS+vGsH8uPqgASqjpo4MGsTHoqFHcYjDqK+HMkIUCZpNuQTQO0qrQED7n265mmrUZ11C+RSY5bE00/TqeYfDdRQTOErZ6NGTqIbOUn9lo0T7XIfr9J+jG04aARc3gDmDejq8D0cNCwSevd761Btpch7XGTSc2reXQE9kGKmkv6Y3s7foxSuZA1XEuHEln5jvOkXGmZY4pxEJI010rJHtNZJ2cF36sa+syPXC3MJZVGr0ephcGRUMwPrmrbTxL0M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(38100700002)(31686004)(6506007)(86362001)(2616005)(186003)(26005)(83380400001)(31696002)(110136005)(36756003)(2906002)(316002)(5660300002)(66476007)(66556008)(8936002)(8676002)(4326008)(6512007)(66946007)(508600001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z25LNkF1cjJ6eWtGZzRFclJtcEdxbE5jVmJxaWtlVTd6ck5waHU1OWhCN29m?=
 =?utf-8?B?dHdzTDJZMHhBS0NtWDVERkEzYkhJeGZUK0Zyei93R0RvYTFCcHpWOHZScG5o?=
 =?utf-8?B?ZWFQZlh1MEhGSEdBemJId1QyUlZKdVp1b05YQ2ZjMGkyb3VDZGV0dkRyM3Jk?=
 =?utf-8?B?Vm9OaSsxa0xXT202aU9SZFBVOHU2cnEyY3RleWtqK3BqWk5xWTR4NG4zT2dZ?=
 =?utf-8?B?djRjY2JTd29Yb2s5WkZDOENzd1RyVHdmZFZaeUlDTVZ3b1dNeE15SjFWeldv?=
 =?utf-8?B?YzF3Rmc3M0g5dVJNL2tLdXJFQ3kraXdiVzRjdmRLRWs5YklSdnU4Njl5aEpa?=
 =?utf-8?B?a3BVTkZoRjh0bnNWdHhTdjBtYTJ6aUpid1VhRXJyQmpiNnFUSDdNbXF2Z3Zp?=
 =?utf-8?B?bHhORnFOVFJyZnpIYmxUWnVsblVyVFlpRDR4SUJDa3pMcDE5b2JneW1hMmRz?=
 =?utf-8?B?OU91Qm1MTVhSTnZZbnlzcSthZzd2QWw1RWxacWt1S3FGb3VmWE5USjJLWkM1?=
 =?utf-8?B?SmlNdlJWb1A1cFhNNGZ6b2lVZzlLU2l1T0lCTjhmc1htaUZPMlVEZlhTKy9K?=
 =?utf-8?B?TVhwUEo0cjRLVElEeTZvdWVlenpQRTMwRzZKTmVjMGF2V0JrNzgxWGx2bjM5?=
 =?utf-8?B?VXBFb1RWaHNaWUFVUUVTc1VkZERxK0dxblljQjRwaFN1RDd3aHJPRXBidEQx?=
 =?utf-8?B?NmFhdldtRy9YWCs3eVcyZjl6Q3VYbERIZ2JFZ29qUUl4dCtpU0Y1UkxISlVZ?=
 =?utf-8?B?R0ZaUmFHWTVHWU9mOW5TS2FVaEF2WnZiRHdOeWszRnA2SjJUYlRYZTZBZU1U?=
 =?utf-8?B?NWl3NU5rT0dUZFJiNmdoV3RHSUdjdjIzTHhSdjJ6TmpFVlpPQWs0WGtKSVRG?=
 =?utf-8?B?bGx4TTNDMVZHZUkzWGpON250cWRVT2VmNThucFNsOGhIbGRhVkEycVVHOUUx?=
 =?utf-8?B?NkpQS3FJZ1RnKzVIVDcwelpvNlZ3YllobnhlSVY4T2xqTFVabWN4T0k1MVRJ?=
 =?utf-8?B?MXFIc2NxK3MySUFNRE0wSERwaHRCWXRRWVZkZnd2cnVlQk44TXhHSDJaNVls?=
 =?utf-8?B?R2FIT2dWR1RJSGt0NUF3UlFqS2FmSTMyNWRvZjBHcm9nNUUvYVRJa0laOWVT?=
 =?utf-8?B?UWdiek5FaXJNdVd2aUZWSkt1R2REUUMyRlI3SEFuaDhFdFZnQVpWVVlsSnE0?=
 =?utf-8?B?MEhiVEEwenk0ZDZjZnRINnZVczU3bkNmeDRTejJHVDdXN3RBYXo1TStMYUwr?=
 =?utf-8?B?RmIrekN5V1JUaHhiTlZoaXF5TTJJTE9WMTBFazl0OWRyYkx5azVwNWJKNUxD?=
 =?utf-8?B?YjRFcEtyeWRBM05GLzQyOHVEOS9oMzVxYzFBV1VCREZSYThhQjZwRGROQlF0?=
 =?utf-8?B?UDBueS9pUFdTU3FuV3pmdm4wWnhFeFRjblBWd3hHNFJGR0ZvRUhoTzMvQ3kz?=
 =?utf-8?B?VFM3MGxiMW5KOElKWkxkbWRvR0dWQUs5SDI4bDBRb1dUbG1xVjNWY1IrZndC?=
 =?utf-8?B?b0l0cDVwR251MlI1QjloSVFIelJPTWl5WjczTW52aS8zWnJSYVladU9QZWsz?=
 =?utf-8?B?bkRiWkczWk10N3ZUaVZzMmhvVFQremYySDkvVkphMkxxRWhtZWpiWjNTd2xa?=
 =?utf-8?B?MHgrUmNFbXB1dEYxejBKZWtibFFha05ndno3bzUra1NzTkp5aFdNeWtISlM1?=
 =?utf-8?B?VE1IYmFDSHpOVGFWeklBUk5qUmdJM0RDZ2NLM0ttVWVoWVc4ZXVUdU8xaFdo?=
 =?utf-8?B?aVRhUUZWSDdqaW9EdjJUaGRJcHVyYnpOaXYrTW1yUGFLeVVROFdlS3dQWU5U?=
 =?utf-8?B?a05vRFYxeXhFNzA5blBqSjlydHpvZVgvNjllWWJUNlF5alF6NkZlS3JmVUZJ?=
 =?utf-8?B?dk93cml5NHg1U1lWbXloZUkwSFg4WTE0K2hDNksyTVYvZTZFZU1nbTljdFp2?=
 =?utf-8?B?czczdUpUb2VVTzNVeXgvK2M2Smk0TDQxeTY5RUwvSTJmTnhzTStWcGlGTXhx?=
 =?utf-8?B?L0pZKzVBbWJDT0VIU2NaWExSZWVwNzM2THBlNUYrN01BcjBQQzV5WWRIdzBx?=
 =?utf-8?B?VnpNZHVaY1UwazhPMk5NbHhzYzBBSzVuSEE1eFpScTZGY2Nya3Nuc1VYNVVD?=
 =?utf-8?B?RHgzU0ZERmhXTGZQa2txaVFUemtzZUo4OUJDVzd5N1pWaU4xNEcwWWgyYlA2?=
 =?utf-8?B?ZzA4MXRIcG9BRW5oWDdvczBqcGRNVEhVb0ZNK2hneWEwYTQ2d1pPZXhaRUhm?=
 =?utf-8?B?NUp3L0tkZVFkSjZoei9FaFAxZHJ1eVd0T1RmVHVIMmVCSC9HWWJVczJDN2x6?=
 =?utf-8?B?VERSRE05eVUyN1p0YllwVnlGaGlDZ08xT0NDSlVEeEJpazEva3YzVjBTOUQy?=
 =?utf-8?Q?3nIkB0PIqhdyDduM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2188c6b-776f-420a-8286-08da17e7c189
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 16:08:57.9807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ocC6Wu3bmt0WLGEs3kewvgiW0PBnOAFNlT1aHEZqt/r0rznUBL8c0XewonPK0/TYrZkToEOPL6IPIOu0n8PvrGX2AApTepRMVI9mmk7Vhho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1638
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-06_09:2022-04-06,2022-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204060079
X-Proofpoint-ORIG-GUID: c8MhA0-6FiFVAp3O1U2Hdjmqm4yxSS4M
X-Proofpoint-GUID: c8MhA0-6FiFVAp3O1U2Hdjmqm4yxSS4M
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/22 1:56 AM, Wenchao Hao wrote:
> On 2022/4/4 0:58, Mike Christie wrote:
>> On 3/31/22 10:50 PM, Wenchao Hao wrote:
>>> If the abort command succeed and it does not need to be retired, do not add
>>> it to error handle list. 
>>>
>>> Adding command to error handle list is an annoying flow which would stop I/O
>>> of all LUNs which shared a same HBA.
>>>
>>> So here if we successfully abort a command, we can finish it via
>>> scsi_finish_command() which would reduce time spent on scsi_error_handler()
>>>
>>> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
>>> ---
>>>  drivers/scsi/scsi_error.c | 55 +++++++++++++++++++++------------------
>>>  1 file changed, 29 insertions(+), 26 deletions(-)
>>>
>>> diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
>>> index cdaca13ac1f1..15299603b7ee 100644
>>> --- a/drivers/scsi/scsi_error.c
>>> +++ b/drivers/scsi/scsi_error.c
>>> @@ -173,41 +173,44 @@ scmd_eh_abort_handler(struct work_struct *work)
>>>  		goto out;
>>>  	}
>>>  	set_host_byte(scmd, DID_TIME_OUT);
>>> -	if (scsi_host_eh_past_deadline(shost)) {
>>> -		SCSI_LOG_ERROR_RECOVERY(3,
>>> -			scmd_printk(KERN_INFO, scmd,
>>> -				    "eh timeout, not retrying "
>>> -				    "aborted command\n"));
>>> -		goto out;
>>> -	}
>>>  
>>> -	spin_lock_irqsave(shost->host_lock, flags);
>>> -	list_del_init(&scmd->eh_entry);
>>> +	if (scsi_noretry_cmd(scmd) ||
>>> +	    !scsi_cmd_retry_allowed(scmd) &&
>>> +	    !scsi_eh_should_retry_cmd(scmd)) {
>>
>>
>> I don't think this test is correct. Did you want all ||s?
> 
> Sorry, I made a mistake, it should be "||" here.
> 
>>
>> For what the patch is trying to accomplish I'm not sure if it's
>> the behavior people wanted. Do all drivers have configurable
>> abort timeouts? If an abort takes N minutes to complete ok,
>> and that's put us over the eh deadline maybe the user wanted
>> that device to be offlined.
>> .
>>
> 
> I think the changes would not affect the timeouts and deadline
> because the logic changed is after command abort successfully.
> 
> We check if the command need to be retired after aborting command
> successfully, if it does not need to retry, just finish it (only
> commands aborted failed should be add to error handle list).

I'm saying an abort can complete but the device could be flakey.
The user could have set the deadline for 5 minutes. If the abort
took 5 minutes and 1 second then the user might want that device
set to offline, because retrying that device could take another 5
minutes. Instead of waiting for N retries they might have just
wanted all to that device failed.

> 
> I submit this change because we want to reduce the time spent on 
> scsi_error_handler().

I get that and I agree users do not want to wait for the entire
host to be blocked. I'm just saying that it might change behavior
that users wanted where the device will be offlined. I'm not 100% sure
though, so it's better for maybe Hannes and others to chime in.

Fixing up the EH to work in a way that does not require the entire
host to be blocked like in your other post is best. It would
give you want you want, and preserve the existing behavior and also
help other users.
