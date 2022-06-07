Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DED5424B1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391781AbiFHAm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 20:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383738AbiFGWGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 18:06:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF066195956
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:17:19 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 257IWxKO014272;
        Tue, 7 Jun 2022 19:17:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=92PRXfuTNPph8/JfQGBWy762LnLqeJKF82QFFZW18ec=;
 b=GS28UtizUSGMl50RN4Q16ytPoG6PaHwgYN1CA23LTT/eHdKaAbgq5ooccPIaGchRODRf
 r3fwL0W1hjZZsuMzFeT73lIKPD3dJgPy3bFSn1HZxp/MPpnq9ozS5RKAapWxbKNZ6bqz
 0uSAdq6XfoHTSWGFYEQ61eFbZwoU05Bz7Q8Ce8ZfGz8Mpt6iKzFRCSSMDRAnJbOEVX1k
 tw3+aKytL9cDZeIEe/UdgRHQC7Tr/RWpvwoBPu28qJE7R4VxfwRUIYfIxBaBbCZ+J4Lk
 wllDDR05OoowoiDDeG1Qa8YS1jsrYiIPkyvCTe5aO2hhoJs2UorVpx0C4zw9y1h9dGFa EA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ggvxmvvv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jun 2022 19:17:11 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 257JGA3Y020688;
        Tue, 7 Jun 2022 19:17:11 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwu2y0k4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jun 2022 19:17:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WIgauHTC+TVSyUPhfHFiSy+X9yNIt0dqzuGtgAmRSm7kW+tv08MNqpijNxO1Pt6/wpmvWUKwyaH/vROcQSgsPxj2HH2F50nKcsZl2zQz0n/wuawVx0scUKXywGj4WZpLdUAX1Q+cb2u/O4ZchzVW6Q8zS7de2cGpfNF3nJDlO1J8Kbj6ZU/YMxgWwoZtnPGHG0jTrcfNh1WJ1uvViiqSPpB7KfbPjLrAfWGi74vdp5okj3XuReMkzQtt+2v/dQSfEE3mj9/tbsCe8SYVTv6HRPNKQuHQf1rbHkcCA4dQJll3pn9Lh67uqUWlY0+533pd3e6sZd3hxO/1ECTsj6CYhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92PRXfuTNPph8/JfQGBWy762LnLqeJKF82QFFZW18ec=;
 b=NVOLqf4uOSXgvv1NPeK5pSC91BfSEXTOyQ9tS8Rc88Czyc9fPdCRRZMBL5AdT4m89wtEAGESiDzKlGw5Zs+z5gSlGdTwxDmyoHHdNFwsN8iVC4Dv5feEJYFwHJhzv2zMZHwEN27zK7z/OAd/RXrycawtc7nJ8JVhSvcN+x02AcfX7ftUyfLX252mqjHmTZkLhZPuL6cDd7/w0RcLnhoBNFj4xZ6QqGWgeN3BPDn1dU1bfrsOVlcFHXXQYMs6C2nNexC91M2ZCdXwk3NWXIzMbC/Dmuvdd5TFhS2Vz+zOQ5xtsBc+zlp/f1EPI2Z73NUKI5i4cmXLAu/FFBLal6N1Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92PRXfuTNPph8/JfQGBWy762LnLqeJKF82QFFZW18ec=;
 b=Op16cb/4MuQkYsm/RzNkJNC3KHFc1eTS9uv5ZJEXpsByKmIZ1Cmmi+GyWRShsxufuuIDPZcfJI3cwp5HRZ184ppku0VQmwVzxxZwRwf5STMWz585PQ7lj7ggpeYW41nTYkI4nz9LJ+dysCyvV/1FO7o9THzAoqVOY+Lhp/9+NoQ=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by MN2PR10MB4336.namprd10.prod.outlook.com (2603:10b6:208:15f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 19:17:09 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::cd04:db71:3df4:581]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::cd04:db71:3df4:581%5]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 19:17:09 +0000
Message-ID: <65e5da9c-32d1-17d7-d8c6-96cbfac23fec@oracle.com>
Date:   Tue, 7 Jun 2022 20:17:01 +0100
Subject: Re: [PATCH] mm/page_alloc: make calling prep_compound_head more
 reliable
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
References: <20220607144157.36411-1-linmiaohe@huawei.com>
 <20220607113257.84b1bdd993f19be26b8c4944@linux-foundation.org>
From:   Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20220607113257.84b1bdd993f19be26b8c4944@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0419.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::23) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f8b27b7-b19a-4d7d-9f4f-08da48ba5138
X-MS-TrafficTypeDiagnostic: MN2PR10MB4336:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB4336BEA9F2F820FE24A0862FBBA59@MN2PR10MB4336.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WkqbPjqvQgHPvG82q5eaWsdyPwrzruc3GOi3OnXan+TPWQU5ctER/DHT3LciSKjbYzgubH3RAjOExFe2nbzUiXMK0idt5EapKVkTYQhTYuSamnKW8TIjfXciBQppGQgLxMt7Ef/Yrq+cN873xyCnxOYZtgpzKv8oV7L/djgQc1P+QZmx1Zo+vps4dc2ykYCpMUkrOBzFYrsKkU37ABtxw2GvZWVpSFFlY3ILLyYmGbUYCKnLcHRYC3h5a1EPlJI0tdT4CyXiXQ5TsmwkEB7DCxE3vzk6WUWVLMSPJKv50fACuSAm8NA1XFp5kg2szOZXmYCnEfNRqaydb3Mn72SiycA+sgPlGzzZrSZ4n3wVY0sR5TyPnwOmNyfbA4Nf5i7ardijCdfjsG9k6bWdKmvdMEwXQKp1gQSPoxur8nbub6AOHvs5WPye6imPe9Hhys2XmiJtPNLaD4YklqgJ90RLGRyphqvFu6WlSGD6WA6tMsC7BdlZWCDbvyr2+scFy+rxJgP02kKUrDCkKeh/w3o7e5TnI9q/0qWd6Eo6L8NhxiqfApPT7lKBA8ZDOn5AVwrP/HFjI405qbljUq2OB6R29lDrMeGQsHUTCC9KuT0fAxBFYTkimaVvTw3dqAdRqNUe4VJIDBxh8m26MqaP58Ge39HHVgeTkBMcAxxtLaViFPcC9XSngZTAlV1lJOyae3pOQVEH0x7U/YB+RZvqRVqsnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4835.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(4326008)(53546011)(66556008)(38100700002)(66476007)(36756003)(66946007)(5660300002)(6506007)(31696002)(2906002)(6666004)(8936002)(508600001)(316002)(6486002)(26005)(31686004)(6512007)(86362001)(186003)(110136005)(2616005)(83380400001)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHRiQklJanhHUkVJQzNXVkd3V0x5UDFXTXZvbjZnTWVYblhXTWhTTXdhaWhP?=
 =?utf-8?B?N0NoNUwvaE5pMU56MkwxRWxXcFR2dlpqZUQzSGJvVm5Bc0JxSzA4UDZuemo0?=
 =?utf-8?B?aG9qalhNTjAyYjhDN3JHNjZpc0dqeWdOMWNNc0oyRnVhS2Z1RmpubEhLdVMr?=
 =?utf-8?B?SmRQTytDb0lWWFd2RTRMOThsWlNIT2NIMlFzMVNMMHdvMkJHMXlOZ3JLcHZS?=
 =?utf-8?B?UDV2VDZlbjd0aERsWUh4SjhCWnVqMXp0NmdFL3QwNGhnZ1FjOWFCVGVrWTQr?=
 =?utf-8?B?TElaNFo3SG4xWlk0eEdqaTc5RVhZTGpsU0JPanV5cVJqUThPa1FVc2dabFN4?=
 =?utf-8?B?dTNtWE5pMVRMTlFpcHFpREpsMmRHcFl0VzA3Yno0dUpUYTA3SzBCN0hia0lm?=
 =?utf-8?B?VmQ0SEVwUHhEQmVJZWN5RmVHMk1GbXNsT3pveElZbVppUzNzSCtOSG1vSjB6?=
 =?utf-8?B?eEtPclBSNFRPREtwUk9Wd3kxV1o0OTJjZk40RW9reStTZnVxRWswc2paQlRt?=
 =?utf-8?B?TjQ1OGlONlNMYnh6THhWTXhLVVQ1OXRpZjFXRUNxdGo3L0duS3RkamZSZVdF?=
 =?utf-8?B?eWVOUFZqdnhJRGgzMHQ4clM0YVZLR3BoSU5WaEJ2cWQyZWk2anNzVG5YeHp4?=
 =?utf-8?B?bThIUHBBQVd0SWRwK3RYSFkzTTl0ckYxNDdzZGZUeDZCTjdHNGRsQXVLWFZa?=
 =?utf-8?B?eVNGdzViU29Rc1I0SHMwcEViam1tclJpVk4za2tpV21oNmkvUUI3Ynowdk1I?=
 =?utf-8?B?QTZOL1NVNk53cXhCUzI2aFF3SlRCN1F6U2RWN1hhMnFVTXNFSy9LVlFad1d5?=
 =?utf-8?B?M21kNmFBZGRncHNZa0hhMUxmaTgyWTFsamV5UHRYVU9uRUZ3SjdSOUFrL0pM?=
 =?utf-8?B?NFd5a3E5UE5NaTNzVC9TQ3RJNExYUVI4cTBXZlRWcXJvQ21ON2NWTlRYTDM0?=
 =?utf-8?B?aHF1YmhuL1g5UCtQdXJVODRLK1BqOFVEWDJvKzR6T0NScXBvbWlZRm5XUE54?=
 =?utf-8?B?MFlxc0doaGFIYmpDaXBvSHZOUXBuTW9BeTVrQWdwY0ZiSWh6aWFaQXJ2Mk9m?=
 =?utf-8?B?a0o3SXUwczdob28xeGxJcEpJdkE1V1ljRko1ODdKMHdvdW5FUTVaSi9yUkVG?=
 =?utf-8?B?VlU1NVlGZ2ljYkVGVGxKK3czcFUva2RNQ1ZrMzdjeEhiSWI5VDBiSzNQYkZ3?=
 =?utf-8?B?THJIT083dklkS0NpY2U5QXQrbUN5ZTJkbURiM3JYVzJWRkFQdUgzZmVON1hr?=
 =?utf-8?B?Tm5iWWtGT0htQ2FtZnZ2bExWcGRpaURsK0NmR0NNNDJsVDFNR1pkOVphMEVq?=
 =?utf-8?B?YlFNdWVrakdZNGk1R1REby91Y0VOZWN2VXJlTGkybTQvSE14RHB1N3lRZ3hR?=
 =?utf-8?B?N050WllmOXJPTEFwRGkyT3I1YVFHcUNNQk5tNHN5cHVrNnhHS3Bqbkc1ME5P?=
 =?utf-8?B?c3NiWU8wNWhBL2Q4MnpWaHdGWlhYTm80VnRrekJPU0xoYU9tTUs4c1RZeG1J?=
 =?utf-8?B?Vy9tZ042Y0RGUWdZRTZzYlhPYUpBT1JXT1E1a0VKQW5DUVhmT3gwOGVVR2R6?=
 =?utf-8?B?U3ZrcU9aMGRTcU5zemRJWk1sdXdHSjA4NStueDkyaU9Gd2JJanFJMERJd0JR?=
 =?utf-8?B?RWpFYmR2RVdZMG1wNFNubVQrQi9OOFZaTFdaZWUrb2NYV3VWYWNDQVlEbHQ4?=
 =?utf-8?B?WGE1R055b3Y4NHY0N0VVbkpNQjU4c3k2L0R6SUtVNzNFQW5ybmVOTytjV2p4?=
 =?utf-8?B?K2Y4eXU0RXJ6UHVxcENoK1JmeCtYS3pjSDNVZFc0OCtLSUJFTUJTQWwxVDZ0?=
 =?utf-8?B?aXRNcncrOHI3ZUZqaXZzZTZOVmt6UGlYWFcxdWk5TUg4TjlOcHBtUzEzVFVC?=
 =?utf-8?B?anRSeHVXWHJCbVhZTmJ5ay9CZ3drU1FwbEFUaUdkNGMyOEUyUmlpYTlxNzZ5?=
 =?utf-8?B?YzZFV0dUR1lOTHJpVEhkdFp2MjlCRk81Q1JGNzNrMzJ1VXZUUWVUcmxEeVJj?=
 =?utf-8?B?SnkrRk5VRCtrM04zOUl5aHBRMzBGaEJrTVRTMjhyWEhNQXFMNnNHOEp3dENI?=
 =?utf-8?B?bmg2Z2ZOQUZDWnlDWEtQenFQQXZYMVBGRmxHY2pxTWJvWFVGM1N1L3FqcUVB?=
 =?utf-8?B?Q1NXRGdVM1dXWVVwVnBmYUk2SmdkSDVkZWdVeUxvdlhkNWwraUhjUHZLT3Jk?=
 =?utf-8?B?Q2licU5YaC85L0o2bE5IV3lyak5ydXloNUQ1YXh3SDVGQmhzKzIvZ3hsK2xk?=
 =?utf-8?B?VWExQ004NU5wd0ZDT00yV3h2THRqNnFSbzdUOG56anFaMUxadWF3QTVnem4x?=
 =?utf-8?B?ZlNWL1VpS0hPQy9JcndUMUlQRGh3OEJJbUpHOWJBZ0hKM0FCdHR6UHowbDhF?=
 =?utf-8?Q?YCYr846kkg+e7Dr8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8b27b7-b19a-4d7d-9f4f-08da48ba5138
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 19:17:09.3096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E3Lg18DKSybRDGF1JaV2RmzFggIc9Dbfv6P2X3YHfn5cyPWV02e/TbbqllhEE8Lw40DvQFEyFsjfsD+H1BqeVAhTSvs06CPRmoo0B+nvYuY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4336
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-07_09:2022-06-07,2022-06-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206070080
X-Proofpoint-GUID: I3wXOTO4vLzZ-pnkeE_PYrAdREyKI1Ed
X-Proofpoint-ORIG-GUID: I3wXOTO4vLzZ-pnkeE_PYrAdREyKI1Ed
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/22 19:32, Andrew Morton wrote:
> 
> Let's cc Joao.
> 
> On Tue, 7 Jun 2022 22:41:57 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> compound_pincount_ptr is stored at first tail page instead of second tail
>> page now.
> 
> "now"?  Some identifiable commit did this?
> 

I think this was in:

commit5232c63f46fd ("mm: Make compound_pincount always available")

>> And if it or some other field changes again in the future, data
>> overwritten might happen. Calling prep_compound_head() outside the loop
>> to prevent such possible issue. No functional change intended.
>>
>> ...
>>
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -6772,17 +6772,8 @@ static void __ref memmap_init_compound(struct page *head,
>>  		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
>>  		prep_compound_tail(head, pfn - head_pfn);
>>  		set_page_count(page, 0);
>> -
>> -		/*
>> -		 * The first tail page stores compound_mapcount_ptr() and
>> -		 * compound_order() and the second tail page stores
>> -		 * compound_pincount_ptr(). Call prep_compound_head() after
>> -		 * the first and second tail pages have been initialized to
>> -		 * not have the data overwritten.
>> -		 */
>> -		if (pfn == head_pfn + 2)
>> -			prep_compound_head(head, order);
>>  	}
>> +	prep_compound_head(head, order);
>>  }
>>  
>>  void __ref memmap_init_zone_device(struct zone *zone,
> 

memmap_init_compound() is only called in pmem case.

The idea to make this /right after/ we initialize the offending tail pages has
to do with @altmap case wheere struct pages are placed in PMEM and thus taking
advantage of the likelyhood of those tail struct pages being cached given that
we will read them right after in prep_compound_head().

I agree with the general sentiment of making this 'more resilient' to compound
pages structure changes by moving prep_compound_head() after all tail pages are
initialized, although I need to express a concern about this making altmap possibly
being affected or regressed. Considering on 2M compound pages we will access first and
second tail pages /after/ initializing 32768 struct pages, or after touching/initializing
256K struct pages.
