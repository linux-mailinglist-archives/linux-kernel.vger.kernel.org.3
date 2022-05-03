Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688CE518C85
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 20:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiECSql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 14:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiECSqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 14:46:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D370032ED4
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 11:43:05 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243HOXoU024988;
        Tue, 3 May 2022 18:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=m0VzOlsVV/tamdghaTyM7h08boosQRpadXeng6QDqew=;
 b=jafwxzhfJVe2jQEitLBpV3lRv860NvUifgVyYEgc3P8vWgHA17FM7RXSPwO8KqbEeIbL
 CZI0KCR8AwPzgAmCGhidVDZjaYeAazPWCgbD0TIHpPMly6PD01HK4KAq34XrQnIAnVQ6
 R7bgN79kpHxaipvvTxfbCNtpISE7fqY32tnKITLMTIvLG4iFWQn7k2e2Kf6wxceSOQRi
 P7v0+3fjJv0nfZn6fgFeOKthF4ewwV9gxLVPJGV3/yBrKYv/FFqawtOw5YdYzD/C3tb4
 O4bFSCZON+gMv8fVCiFLUPm+fV1I4L1gUvb1SsXyoiLmGzGHaUSnY0hYmM+vTJqgEVk7 /w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruw2ej4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 18:42:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 243Ierki013539;
        Tue, 3 May 2022 18:42:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj8t8cu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 18:42:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccNgNMo7yqdedFSKs2Kn0Be27NyY2izui/+Id9dDbeW4y+jfGX5Z5KzFyoPpP4KvO+VHggHHyheyqDO+Rsk4NNhvTRTqSH7PMrl9cqaa5dXMgeJa8vUKLrhr1mQdJJWT86tLTnMR3h3aN5fRWDCBMEz8dMp/QdnyfimTy5vxjprVwZAPuHC66VmjLbAP7ttImrTmSHezLOshqtjptecMqZTYaz2Wjcami2HXztsONtM/3vpVdCoeqa6wF84cKuf4tSkWnpfXzp7wHhMEeAgOKm7TwMERkpHkI0cwNALT00nGkE2tz9uWByvp+T5MaNGjSNU0IfsK2FvTApdrFPmpoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0VzOlsVV/tamdghaTyM7h08boosQRpadXeng6QDqew=;
 b=FqemuvjMUrX1Hvc+A6GXXBA3h4fqI/PCPg3tsuZpga8hLEuVg4EREtplN5JcxP9jgU8jDXzW3SI1JiSWJpjBCnqy8PBpLxETkwvY1mJhZ8qSDyQtQW5ydcy1YHz4/5yUKIdAJVy0KGOZQza3IgBEjBG5sgcDin+Ri/wp2r5bC7mHjYQMKH9umN5444XuePMPuhC2b3KtVndyVhNbn1kF1NbpLGtG7KinKADrWahJTiiHeuUL/qXkPlKLhoPmv7cEpb6IF8zmPR21seYE636lud3NXeSrgetZkQsgcC8CXiuY5KjS/0dBDcIwMrVQwYaZ/X98U03uKGz7TmiB5NcRqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0VzOlsVV/tamdghaTyM7h08boosQRpadXeng6QDqew=;
 b=ug1IoAHipxClxwGDcD9VTkr4zgX/44u6ALSR4hVudMYt1kfSwubecfTX6mFwqW9QbpLe7Hl70AtayjrQaeUgls6DD4TyNZqgjmiDihqFd1d6UPtOWY5AlZFimt3CP9gItfkocYEkXjLxovcwP5OTfBR+SZyU/jgwtD/mzCdChYA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM5PR1001MB2091.namprd10.prod.outlook.com (2603:10b6:4:2c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 3 May
 2022 18:42:56 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461%7]) with mapi id 15.20.5206.024; Tue, 3 May 2022
 18:42:56 +0000
Message-ID: <16644a23-e7df-a330-fba0-a9cd5da4800e@oracle.com>
Date:   Tue, 3 May 2022 11:42:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 2/3] mm: rmap: Move the cache flushing to the correct
 place for hugetlb PMD sharing
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, almasrymina@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1651056365.git.baolin.wang@linux.alibaba.com>
 <4f7ae6dfdc838ab71e1655188b657c032ff1f28f.1651056365.git.baolin.wang@linux.alibaba.com>
 <YmosZpGwSoB8TlnK@FVFYT0MHHV2J.usts.net>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <YmosZpGwSoB8TlnK@FVFYT0MHHV2J.usts.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0324.namprd04.prod.outlook.com
 (2603:10b6:303:82::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65fd4923-f57f-4257-9262-08da2d34bd3b
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2091:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1001MB20917F966CD23701698AB801E2C09@DM5PR1001MB2091.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pXryhHsX15/vKpGKKdSAHKfAlnlYaf2uFhsIP3ri2DAL/X3Dr80WZSdcViohm5W7b2Fmkk4zOBAbQQquUvBGc6nIo/YF6KEWxvGEaGDD/I2jf0ee5iu/JY7RhMoKgNw2fV4H7/OPokOsKWkEcYmX6OGy37RmIS5aVaQz6JBFdjyClReL9zcEBf2QXbVvAeymO59DpPzzY/FHDxDjveeD5PgXnA/yHXwfyObB2GBXuPHbKdimDvjEhOcK+OpcYlztcUrzuJOer2RplLmEFcTzE7YanC72YIQCNvuyt4xuPPYWf6ex9q6W4/K5qA/ndWrE2Tj+jszxbDzh9M+vApBESMw2Kpz4VAsb7ElD3+b3c85fjPCQfWGvi18fkWrBd30X3YLqz8SqyeU6inlbrdFJRFgthBOuHELWz0+vqJChznlTxyDVKyWP45wfJ8uSz9QdfBC9nj+i3d49alUPnaWT+mEEZXUYTYQAIv0jDA+dhkMKIXeglETsIZOKcqaFtnTu6GCJv9odhAc5hCWtsRPLJVq10rGy3hZzYFW1YeQtER1poD9w7sm1wPfvCMZyi62gqXjMOsd/iOWyaHlDqMy6YLYmG85YD5Pa74POvl9zcj7e1ICrm4UInBSaJaI9CtkLVl/pzuFeHmiN/gb0kI2r3lWEnT4aOG1t1OPouYTADjHUBvzqfhvOSvkcYPYyRpvOkhdZXDrK0UCS5l6ODW4YrHAGZrbdAeer+KpD5XOcJSxnUM2vcdJj/+zqffVp9I0AFJpAL/wcIoy1mPti9ve2uYopUVGHWhSXuebHykgO+x/F5Tb/hbJ6y+TcIVZgg+I34lizvvVQpE/sq1mJfI9+9RNUgvGSMqIw4wiDVSCoZE4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(83380400001)(38100700002)(6486002)(86362001)(508600001)(53546011)(110136005)(6506007)(186003)(8936002)(31686004)(5660300002)(36756003)(44832011)(2906002)(31696002)(66476007)(4326008)(2616005)(26005)(52116002)(66556008)(8676002)(66946007)(6512007)(316002)(6666004)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0FXWVl3UjJ2bmUxMGpIQ3BnWkViK0txL1RZbkNSdVVaOFkvakRMMGcvV1pa?=
 =?utf-8?B?bWVJeXF0ZDAwOGVkK1F5SDRVRkViV3pBcTYwMUpiQzgvUWtXWUVMbFFBK0hz?=
 =?utf-8?B?bHRsN2hjVnNNd0NRVmczNEZSbS9mVTkyVTAvZlZyWlF5M21GUENoUVV5eGsw?=
 =?utf-8?B?THBjWmN5THV2OEM5cklydkJuQm9WZ3hGcjdwUjhvVkdnbWFTYUhyNnVaV3NH?=
 =?utf-8?B?dVVtOWxkcWt6VWhoMkFPVHlhcTFSNTc3c3JrOXNpajNrNUFIZC9WbkkvTERI?=
 =?utf-8?B?UFNTN2NzTlZLamtZVWQza0ZXYlpDa1FzMXJrY2MvVlM4TWdoemo1LzZ4NWM0?=
 =?utf-8?B?TWdvaldBbk9kdnBKc2tUaGlETXVyOUtQLytDTy94SXphN0RESXpaT3NNazM3?=
 =?utf-8?B?NHFXWk0rUTByL3ppbW9BZmV0SWl4QWdtLzNCL3lEckt1c0dQaUl1M3dpN2Uv?=
 =?utf-8?B?bWhpSTBQZWxoZ09wb2ZPR2dUSnJodE9uaVkybG43SFd5NmZkeUdUVXJQR3lj?=
 =?utf-8?B?U1lYRGVwWW9kOXdUaFFCSis2LzRTNXNVbmlNOE5pdDk5dlNsQVJQamZ5Zms4?=
 =?utf-8?B?MWNYUi9RcGhQNUZhN2ViT3dpQXM3RkhRZW5hUTBmZVhnckFZaFdjaHlXQTRK?=
 =?utf-8?B?K2lpOHBia2MvN1JPODRnU0craUdWTTcyeGl6S0pZT2EydWVldHpOYnoyZ0I0?=
 =?utf-8?B?Ylk1dy9sSHkyNzBxWFdHOWFzenE5TGJHNE9YOHM3cjBQa25ZUnVYTnB6REgw?=
 =?utf-8?B?OTJmOG5Vc3kwaWRXa0RKVGE1eFZwMUJhQk5scFdXMkh4djJQVEFuMmdUeDBs?=
 =?utf-8?B?bEpyalhWbWh0ZFh1NE1qUS9SZDJJRkpCYS9lR0EwaVJjYVBwd2d3U1FnWXFO?=
 =?utf-8?B?V29uM3VUVW10RXlmWEhnVDhYdkRJcnZZRXlTVzRIcXRUTExjYWtvZ3k2VkVB?=
 =?utf-8?B?blpJdDN1N2d4Z2trVTlUSzVGOXZ3UzBMUkdwbEJtZTBlVGFPM1VFalI5Zko0?=
 =?utf-8?B?ZEQ4T3VXWGppSHc1UTJIcWVkS2RZVUlGSHRCNllUQkNncXRKOWV2emZ2NFo5?=
 =?utf-8?B?bklHOE50RzB2aXhHVUo0UzQ5MWNvTnE2eEkrc294YmtjZ0VTZzJyL1B0cXBE?=
 =?utf-8?B?K1ZsQmRtS2M3aHd0V1BTL2VqQWdsa0tGbWwxeUczTzRWK0w3SllvOGx5NFBr?=
 =?utf-8?B?cGhSdkk5NHhlV3hTckEzS000TXEvSG9rTGZGWlV0Ny94Umw1QXlaZm03RUI0?=
 =?utf-8?B?UHZmSEZCdXhHTDhwK0RoUFNGMmh4YmU5akV5KzFyc25ZalhhNXpjU2RXVS9M?=
 =?utf-8?B?ckdVdndPR1hyb1dBN3p4UTlURC96TEltOXIyV3RWSitNSXpsS3JKWk4ycTZ2?=
 =?utf-8?B?d0RIeHp0em1aRGM1NHFlZm15MDhKY1FGYWdSN0NGaXlHSEtyaHNxc05zK08r?=
 =?utf-8?B?eitCcW51N2IvS08vQkg2aTFUZVNwdTNqQUlISFo2RXNwdHRtdk5yaXFJdVlp?=
 =?utf-8?B?QStGTmRneGwySlc5aHU2LzRsS25TdEk1QlhoYUxrZVVySE9JQzhjY2hxanF5?=
 =?utf-8?B?ZzA3QitkQkJhQzZlV2haSVhQYW5wbkhZWnRjZ2JFWDZESXVleE91Y3h4a3pV?=
 =?utf-8?B?R1pSdTVva092NjlkUDF6cFh5dzFJd3RydkRjNENHQjRaaFNLY2p5Qnd3TmxN?=
 =?utf-8?B?NVV0TkcvSmlYMUpjYnFuQnZWUUJFTTdSZmlTTSthcm1lQk42bWl3cG9wRnJU?=
 =?utf-8?B?ODhGTG1DdnlldEtXVHoxZXk3aTBRVENjZXBWSlQzVUh0dndGTXFsbmErWW1n?=
 =?utf-8?B?MVY4OHpaNkRCUEd2TjlyUFJtWXN0QlcrZ0JoVjZmOWN5M3kzMlNkWUdDbVpK?=
 =?utf-8?B?TldvM2J3SGlDYmRSTVpKREg4d2NxYWNEU2IxMldhWDhMTzdnMEVycFd6WjRM?=
 =?utf-8?B?WHpadUhTTDI4TGZOTys5RThoYjNEQzZNZnlFQmozZHZ2U2kxZEJxbml1MFZ0?=
 =?utf-8?B?eFN5N3hoSnJBUVJmNjZNU2VVTGJ5TXUyWCtjalZGUDlhZTlMT0lFRW1VV3g2?=
 =?utf-8?B?aXNTSGgySkRyaWdCSVFJY3d3U0pmZXBCRnorZC9xWWxYZlZiTkw2NHdQalN3?=
 =?utf-8?B?ZGVaZ2REM3BtOEVVL3hGai8rTkFOcWhCRVNGZ0NzQzh4cGZHRzNZWWU0VVVN?=
 =?utf-8?B?c2VoUk9VMFpFaHpHKzZiTmVvNGlZS0ZoS1hLdXFtMzR1YmM0NGlhSktGNStm?=
 =?utf-8?B?L1JPTHp5RjQxOG1MWkx4b3dGT2ZjbUIrYXpHMC9kSjkxU0RGTU9jMjRuVEph?=
 =?utf-8?B?Y2pjRkdIbGZZeTArVWZzeVFrU1F5UUxzN0tLeEwzL3IydXFOSnVPYXE3dnA1?=
 =?utf-8?Q?lOlcHU5oGjtWvkBE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65fd4923-f57f-4257-9262-08da2d34bd3b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 18:42:56.4568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1YHHjjdgmc95TE1bmtfdSs305c3cdTCJybgnYvkxIgjJzJ3rfwaE02kTywHAFLeKmSlbo+kF6Sr/9dOxt7NQvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2091
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_08:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205030117
X-Proofpoint-GUID: 1NAbmUqT2J3nz9gmlaAvV2A1KI64OlB0
X-Proofpoint-ORIG-GUID: 1NAbmUqT2J3nz9gmlaAvV2A1KI64OlB0
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/22 22:55, Muchun Song wrote:
> On Wed, Apr 27, 2022 at 06:52:06PM +0800, Baolin Wang wrote:
>> The cache level flush will always be first when changing an existing
>> virtual–>physical mapping to a new value, since this allows us to
>> properly handle systems whose caches are strict and require a
>> virtual–>physical translation to exist for a virtual address. So we
>> should move the cache flushing before huge_pmd_unshare().
>>
> 
> Right.
> 
>> As Muchun pointed out[1], now the architectures whose supporting hugetlb
>> PMD sharing have no cache flush issues in practice. But I think we
>> should still follow the cache/TLB flushing rules when changing a valid
>> virtual address mapping in case of potential issues in future.
> 
> Right. One point i need to clarify. I do not object this change but
> want you to clarify this (not an issue in practice) in commit log
> to let others know they do not need to bp this.
> 
>>
>> [1] https://lore.kernel.org/all/YmT%2F%2FhuUbFX+KHcy@FVFYT0MHHV2J.usts.net/
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>  mm/rmap.c | 40 ++++++++++++++++++++++------------------
>>  1 file changed, 22 insertions(+), 18 deletions(-)
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 61e63db..4f0d115 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1535,15 +1535,16 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>>  			 * do this outside rmap routines.
>>  			 */
>>  			VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
>> +			/*
>> +			 * huge_pmd_unshare may unmap an entire PMD page.
>> +			 * There is no way of knowing exactly which PMDs may
>> +			 * be cached for this mm, so we must flush them all.
>> +			 * start/end were already adjusted above to cover this
>> +			 * range.
>> +			 */
>> +			flush_cache_range(vma, range.start, range.end);
>> +
> 
> flush_cache_range() is always called even if we do not need to flush.
> How about introducing a new helper like hugetlb_pmd_shared() which
> returns true for shared PMD? Then:
> 
> 	if (hugetlb_pmd_shared(mm, vma, pvmw.pte)) {
> 		flush_cache_range(vma, range.start, range.end);
> 		huge_pmd_unshare(mm, vma, &address, pvmw.pte);
> 		flush_tlb_range(vma, range.start, range.end);
> 	}
> 
> The code could be a little simpler. Right?
> 
> Thanks.
> 

I thought about adding a 'hugetlb_pmd_shared()' interface for another use.
I believe it could even be used earlier in this call sequence.  Since we
hold i_mmap_rwsem, we would even test for shared BEFORE calling
adjust_range_if_pmd_sharing_possible.  We can not make an authoritative test
in adjust range... because not all callers will be holding i_mmap_rwsem.

I think we COULD optimize to minimize the flush range.  However, I think
that would complicate this code even more, and it is difficult enough to
follow.

My preference would be to over flush as is done here for correctness and
simplification.  We can optimize later if desired.

With Muchun's comment that this is not an issue in practice today,
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
