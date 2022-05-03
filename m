Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C1B518E8D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 22:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbiECUVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiECUUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:20:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5A32BB2F
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 13:17:22 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243Hguu2026258;
        Tue, 3 May 2022 20:17:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=kPEHyMbU567zsfBmDW8p2uXElDUHXngXYSMaUpbjR9g=;
 b=zpL+zpBlVfBzjfiVe/aHCziWEqOeYShHkn3t3/Uf3kynzHviWDoBrMB+8cD3lgiBO9RQ
 H8Wb49ds9hYf8yd4UjkWzr30vC86Q1ImLnyL2V8qUobtHLdHi99MCL9WxWr/37fB7+Xl
 g6mbD1sqaoJ1FDsyPv124RPFZpSjf9Is5OE4y4U4OHaxJ8pWYExhqvHIegrynOjCrCeZ
 FwYIezNObIjGk/dvO0N1W3YehqUx6k1v+D9oplbSijjXi4/aHCC+nWKOe2kx8H/LfT2G
 GP2OPhrWjbu/VY4gEhGkSMYxLB3R9gTgs4XMRzJY5jKebW65cN7SYiMKpBVe+ucCmDX3 tA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruhc6myr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 20:17:14 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 243KGfq9022067;
        Tue, 3 May 2022 20:17:13 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj9aphv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 20:17:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YnL4n+JphXVrObUw8W4G7AgjdlqHuIPM0ZVB/RRJhjpvEO61JkkRwY/lJ51r5TbGK5wP2rEjVM3seviO8IEnp2nCRJLuTOTuhwXeggQs05fNpjsrIS7Y/VzQYpoZzkIngILi0JE4G58Ak8ItkJUP/KAZ2Ea/xtjpyPezDYZqdJR5AUJ6rmO807Kgkv/Rb7eqsJBN2OTiZRYH2UMmooRBADeQICmtnEYmF4dGFrs8G/iVg4pKA7CWNqtAIX70P1AUj0PWSbQYx6caWzM1OUdMGaIHxf6xIOmVd8cxYJEPdmH5KQehw8eaQBVEbCAvF5aEUt6Kq05F4Nyqjk0RyWvl3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPEHyMbU567zsfBmDW8p2uXElDUHXngXYSMaUpbjR9g=;
 b=g/Fzl/i/MIYQLS81FskftarIs9AP2pyDAtoBRfoPYR4f5T/fkPnz5CGevjO8fJR0i+NpXG0Vo1xuZ2BA1l/mAVkm2GOF0F1ZVb+14f/qSBSoDDttZ19UfMW6XwA2ZrCox4ueEvE1rUkGQIw4zTTed6LbQCVZ5LKjVF9hYadYF4egYkkfnuEJuY8o/oPuILI0JRr1+9Yjo3LL0CayJFiF7QX4w7ptq2fqhkVXkTMdDlazik0YJDV6/nmpibMK8rakabg3ZEEVFKvrAWDSsk6zEFxMup7UqjrZO7yc+SfbQUz08kjznQ/PlPiD0iyVKPZkQJogGT82jEZ/RMJjeywI3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPEHyMbU567zsfBmDW8p2uXElDUHXngXYSMaUpbjR9g=;
 b=ycarqtQiSBAM0WqxUlhw/XKbQbdlaGL9s68kKrEPr9QfMUMyTC/bop4AyKuOVagDGRvlRflLMUcUY3UwVGniXU2rUfDplu3ccUtNE36NfBibETre1wwBxTlBZ2B+TOQ2UD3h4zkHpu3pHQ3na+9ciQTrhUtj24IhVyi0UhL95PU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY4PR10MB1910.namprd10.prod.outlook.com (2603:10b6:903:123::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 20:17:10 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461%7]) with mapi id 15.20.5206.024; Tue, 3 May 2022
 20:17:10 +0000
Message-ID: <0b986dc4-5843-3e2d-c2df-5a2e9f13e6ab@oracle.com>
Date:   Tue, 3 May 2022 13:17:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 3/3] mm: rmap: Use flush_cache_range() to flush cache
 for hugetlb pages
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     almasrymina@google.com, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1651056365.git.baolin.wang@linux.alibaba.com>
 <dc903b378d1e2d26bbbe85409ab9d009631f175c.1651056365.git.baolin.wang@linux.alibaba.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <dc903b378d1e2d26bbbe85409ab9d009631f175c.1651056365.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0203.namprd03.prod.outlook.com
 (2603:10b6:303:b8::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67aa8421-8c2d-403f-1e9b-08da2d41e738
X-MS-TrafficTypeDiagnostic: CY4PR10MB1910:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB19108903FE5776D9BB2DACB9E2C09@CY4PR10MB1910.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CpiMGEEHvGWKTVVjUeMoHOSgFCgAOq/3QMhZW9TA1Tf9Frb3khAVgMfuLdSeMzQNrdFsmuLKbAy3BS8PUB6Y0AAYSho30nBQwyCjgjs0cafAmrllrRwQEqgu268pyVz2YxXLCS0HR2VfbfxeeSpWKReGew5iD66s/Is0oRnAtNtMe6Np9zxHTNYjn4zXL4timyMRCOprHAOyZKcb3+/qR5pEWgsDkV+iKcbkktkm9bRokQtn+v352ReMEanrQaayop0Xc+sw3+VyDR07WvKz7x5Tfuk7Tn5/pdHAGj6HO3Cv36eyUlA5lgBHfigTJ/2RcC6VpFf4S3hIYjMMx7NBJW90sjNHzj+MFSMcSVH6gomcxQBFLpKdtCIfl3BC20MjAh6Z3sDEK5no8Xv8e1boH09dQHBkA/pp5INYkZ/9wFGDaf/bqBkVe7A2vpCXxCmVS8WLKOySgnRYQiDgKThAproDVz8PhdSw6M3d5X8dtOnEwT7fiMA9AZ0v1PMhW3qjc3Xb1V7hjMWSvKVAvdvXSOWhMa+t7M04m+zcp/sv1AW1G/ayDCKQ7Wvz8Xes75J02hHUNt8KbKvQo4fqZ9b6WXmZP+iFkmQtBTfkE6xJy9ej7SSOfd3qvyvmMCxpLhpJ+YfnpsezSOO2uhXquQDzAR260+/XFGzrQOsXkVlzBNPaBDpPZjbCxsOCW5Mtv1R7MU6OBuErFrN/as1uxPsQkomTVR3BjwS8ruitjpll8ini6NmH85lVBzIEZSmfpYLKWGZV5FFgkaxCi6tKFdjl4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(6506007)(53546011)(31696002)(2906002)(6512007)(26005)(38350700002)(508600001)(38100700002)(8936002)(6486002)(36756003)(52116002)(44832011)(5660300002)(8676002)(83380400001)(4326008)(66946007)(66556008)(66476007)(31686004)(186003)(316002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHFxNkx6RUExdVpGRXZldE9BNnR4SmM4SGMrcmRKazFlUGpvN2pQOVd3ZXY2?=
 =?utf-8?B?ZGdyR1cyZmQ0VnhRa04wenRIOVhlR1o3OXdIRFZyNndFYjNDdlNodXNYMTd5?=
 =?utf-8?B?QTRQY3JmQmxjSnVGZDVwWTdZenpWcnpOUG9rV2tGS2ZXdWdBVGRhNGRXamxJ?=
 =?utf-8?B?RXNBSFF5T2V5aHpRdHVmbE9rSFYyQU9makpKMU5BRTdUTC9XSnVuMmhBUWIy?=
 =?utf-8?B?RTl3Qi96b2M3ZFBaSEMydEM2MjgwR2tPLzVKZVRoYU1yZ0tTTVJoTmZHV01r?=
 =?utf-8?B?c05YZ29vTWxoWTY2QzJRUzlacUNkalR5WlhwN3Vsbk1IT3dLZlVrNS9OVllu?=
 =?utf-8?B?QnNkd0NhUVBZcmtITWxLSDBST1BsckxFQ2VwU0tSc21ITGs2czdhYkdjamQ0?=
 =?utf-8?B?ckxzTVdjaTAyZUhMREJ5cG1CTFcydUNSeWlKMnN6UTlLREVzekNnQ0Q3NWRR?=
 =?utf-8?B?ckhOM0RoTkMzR2ZYWFBLcDlZR1Vxa0dUVG1WZnc3Y3UreUd1TW1ZNHlrNTVZ?=
 =?utf-8?B?VDdDbFlpQjI3eUtiWktsUWZ2TS92M3pUMzFKaWdGTFdvczRJZFBmVUNSNytr?=
 =?utf-8?B?N3U4L0FPUjJLUzQyc1pKaCtkU1RoTjBKV0ZDM09CbUJiQkFKMnM1cWs4Syt5?=
 =?utf-8?B?ejcrZ1BOcjBMK0d2bFJvSmdCOFFTVzd1T1R0MzN5UkFmN3MvSExEbGJySy9D?=
 =?utf-8?B?aU1taTIyOGRZWVEydUxIY0h4NjJIUFU1bXV5Y0VlTGlpcy92azh5OGVTbjAr?=
 =?utf-8?B?TGlYYjNHa3BjcFdmZXVJbkRtK2hTdnJuSzM4UVl6ZFoxNXpwZmpQT0pKUzha?=
 =?utf-8?B?OFhmVy91RUoxWTR0RnRYUS9aaDY3L2dIOHhZWW9iSkpXK0h6bElKTnA3eUZE?=
 =?utf-8?B?djlPa0dXc2NyQUEza2NTWktSclkyTTZHV3ptb2hmckxPMVV1SVUvSWE1VHU0?=
 =?utf-8?B?eDBLSWpsQ0ZZSy9BdmlJTmhvSG5ibVM4MXk2MHFnT1lKUlpOckpucHVBZGdo?=
 =?utf-8?B?OWEwWEhjQnNhcUhiYjJzaDAzTnY5b3FMVWdBMUJzY3dyNFEvNHJEa0NYZEYw?=
 =?utf-8?B?em9Nd3JFMHR2NGxyZ25COGxhNm5EOFl0a2VyU3ludlo4eUtvNWxtcEFDVzND?=
 =?utf-8?B?TFg4RVUySE1VajVKWDd4VlM5REhYTXVrUkZQcE5QTGJJR3BUbzdtcWxmVGNU?=
 =?utf-8?B?Zno2QVIxNit0SGxXZ2hCNkwwNU4zallnMm1nWnRJSWxiYTFTcTFHRmk1N0xL?=
 =?utf-8?B?WkMvRVhObUZ4aUplU0hsVEVydmw0MkdoeUkzaWNVelJ0N0pwSmhNdkpiZDI2?=
 =?utf-8?B?YmdGYUl1QXE1NWVmL1ZKQ0V5eXhCMzBxSmw5dGt1bU5PNTIvTU5BODMzaWVO?=
 =?utf-8?B?YWh0eGtpV2J5dmIvK3JGSFZiUEMwaUlibHJseVZYdmlhdW4waDA1QzNRZFJY?=
 =?utf-8?B?cEkzQ1hCMDA3MWVKTjEyT1k2Q0R6TFBhb1VOeVdhZ2w4Z2VqRVBCUUhzci9o?=
 =?utf-8?B?cndTcWlGRUI5WHlObTdsdDkwU2NJQmhLN1hIY1doSFBlcW9XKzRjZWozZHlw?=
 =?utf-8?B?My9WOERmT1IzWUl0eHpqQW00R0ErT21EdzFiYnhQVnZ4TERCbDNOWURKTDRp?=
 =?utf-8?B?bUl2T1RoMnlKbDdpa0czZnZxNlpuMEFYVXJpU0JQSlhNc1k0RUtuOVoyZkc5?=
 =?utf-8?B?U1FPRHFrOUxaR1RIZlFtRjNUdVVZdWNISnRPQWIwcGtKM24zWHFNZUIyVjUv?=
 =?utf-8?B?ZkVHeGNtMW1rR2E0NW1GV1BGSndsT2ttSUlWRVZqOTVBZjR6SElrMVlPaHFo?=
 =?utf-8?B?YWROMFJSZmZOQnFLYmEwMksyUzgvYmpSeVcrbXA5RFQrbW5Zb1lrTG1hS3lm?=
 =?utf-8?B?L3gyR3JpK1hLdHp5VGo1Sm5SRmMyVTlrSVJucUczVmdCcy9aZS9LaXNqN2ww?=
 =?utf-8?B?ZEhLRkJQd1Y3RlBsNytTV2g5d3cxaUFSZm9Ua3NGSkNsRFdRaGYvcEZRajJk?=
 =?utf-8?B?T3l4Yjlac2IzdHpSOGhpTkJTckhsQzBFSVp3UDRpdCtpZXhhN05vZUcyRCtt?=
 =?utf-8?B?THRMVFU5TElLc1g4a01yVE9VYWtzU3FUTDhZMDBYcDBHMGVSYmMwemsxQ2E1?=
 =?utf-8?B?VjRkVy8rYVlFc2pjYW81bW16MFRnMXd3ZzlueUx6dGtMT0ZYbGprNzAzMkRi?=
 =?utf-8?B?R1dyb3RqQ2haUmJWbGgvUGpockNzdW90cjA5bDNqY2hyY2o2Wm51ZjlNcllI?=
 =?utf-8?B?WXNiOXl5MXRTNnFxTGpWTFdvWVNDTWRNWHZ2TzA1T2lwdDhWVm84a0E1c0ZU?=
 =?utf-8?B?RHZwYmlRMlU4NFRpZVdSZFhBN2xyUk5icFB2TERMU1Z0cFhrTjlDSXc1VEpX?=
 =?utf-8?Q?9oZgTseJyezXfuiY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67aa8421-8c2d-403f-1e9b-08da2d41e738
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:17:10.2935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SpBMNDx5H5C5BGX+jxAbxnK8wuaJpEn6VHHrMvHLq3awix75EXU0xrOR32+KgHXo4gQ5n7c6uWwH2/FdNQ76QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1910
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_08:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205030126
X-Proofpoint-GUID: 3wk2xrGNkPxCro-4xPp6EYML9vE2bjQM
X-Proofpoint-ORIG-GUID: 3wk2xrGNkPxCro-4xPp6EYML9vE2bjQM
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/22 03:52, Baolin Wang wrote:
> Now we will use flush_cache_page() to flush cache for anonymous hugetlb
> pages when unmapping or migrating a hugetlb page mapping, but the
> flush_cache_page() only handles a PAGE_SIZE range on some architectures
> (like arm32, arc and so on), which will cause potential cache issues.
> Thus change to use flush_cache_range() to cover the whole size of a
> hugetlb page.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/rmap.c | 90 ++++++++++++++++++++++++++++++++++-----------------------------
>  1 file changed, 48 insertions(+), 42 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 4f0d115..6fdd198 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1528,13 +1528,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  		anon_exclusive = folio_test_anon(folio) &&
>  				 PageAnonExclusive(subpage);
>  
> -		if (folio_test_hugetlb(folio) && !folio_test_anon(folio)) {
> -			/*
> -			 * To call huge_pmd_unshare, i_mmap_rwsem must be
> -			 * held in write mode.  Caller needs to explicitly
> -			 * do this outside rmap routines.
> -			 */
> -			VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
> +		if (folio_test_hugetlb(folio)) {
>  			/*
>  			 * huge_pmd_unshare may unmap an entire PMD page.
>  			 * There is no way of knowing exactly which PMDs may
> @@ -1544,22 +1538,31 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  			 */
>  			flush_cache_range(vma, range.start, range.end);
>  
> -			if (huge_pmd_unshare(mm, vma, &address, pvmw.pte)) {
> -				flush_tlb_range(vma, range.start, range.end);
> -				mmu_notifier_invalidate_range(mm, range.start,
> -							      range.end);
> -
> +			if (!folio_test_anon(folio)) {
>  				/*
> -				 * The ref count of the PMD page was dropped
> -				 * which is part of the way map counting
> -				 * is done for shared PMDs.  Return 'true'
> -				 * here.  When there is no other sharing,
> -				 * huge_pmd_unshare returns false and we will
> -				 * unmap the actual page and drop map count
> -				 * to zero.
> +				 * To call huge_pmd_unshare, i_mmap_rwsem must be
> +				 * held in write mode.  Caller needs to explicitly
> +				 * do this outside rmap routines.
>  				 */
> -				page_vma_mapped_walk_done(&pvmw);
> -				break;
> +				VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
> +
> +				if (huge_pmd_unshare(mm, vma, &address, pvmw.pte)) {
> +					flush_tlb_range(vma, range.start, range.end);
> +					mmu_notifier_invalidate_range(mm, range.start,
> +								      range.end);
> +
> +					/*
> +					 * The ref count of the PMD page was dropped
> +					 * which is part of the way map counting
> +					 * is done for shared PMDs.  Return 'true'
> +					 * here.  When there is no other sharing,
> +					 * huge_pmd_unshare returns false and we will
> +					 * unmap the actual page and drop map count
> +					 * to zero.
> +					 */
> +					page_vma_mapped_walk_done(&pvmw);
> +					break;
> +				}
>  			}
>  		} else {
>  			flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
> @@ -1885,13 +1888,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>  		anon_exclusive = folio_test_anon(folio) &&
>  				 PageAnonExclusive(subpage);
>  
> -		if (folio_test_hugetlb(folio) && !folio_test_anon(folio)) {
> -			/*
> -			 * To call huge_pmd_unshare, i_mmap_rwsem must be
> -			 * held in write mode.  Caller needs to explicitly
> -			 * do this outside rmap routines.
> -			 */
> -			VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
> +		if (folio_test_hugetlb(folio)) {
>  			/*
>  			 * huge_pmd_unshare may unmap an entire PMD page.
>  			 * There is no way of knowing exactly which PMDs may
> @@ -1901,22 +1898,31 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>  			 */
>  			flush_cache_range(vma, range.start, range.end);
>  
> -			if (huge_pmd_unshare(mm, vma, &address, pvmw.pte)) {
> -				flush_tlb_range(vma, range.start, range.end);
> -				mmu_notifier_invalidate_range(mm, range.start,
> -							      range.end);
> -
> +			if (!folio_test_anon(folio)) {
>  				/*
> -				 * The ref count of the PMD page was dropped
> -				 * which is part of the way map counting
> -				 * is done for shared PMDs.  Return 'true'
> -				 * here.  When there is no other sharing,
> -				 * huge_pmd_unshare returns false and we will
> -				 * unmap the actual page and drop map count
> -				 * to zero.
> +				 * To call huge_pmd_unshare, i_mmap_rwsem must be
> +				 * held in write mode.  Caller needs to explicitly
> +				 * do this outside rmap routines.
>  				 */
> -				page_vma_mapped_walk_done(&pvmw);
> -				break;
> +				VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
> +
> +				if (huge_pmd_unshare(mm, vma, &address, pvmw.pte)) {
> +					flush_tlb_range(vma, range.start, range.end);
> +					mmu_notifier_invalidate_range(mm, range.start,
> +								      range.end);
> +
> +					/*
> +					 * The ref count of the PMD page was dropped
> +					 * which is part of the way map counting
> +					 * is done for shared PMDs.  Return 'true'
> +					 * here.  When there is no other sharing,
> +					 * huge_pmd_unshare returns false and we will
> +					 * unmap the actual page and drop map count
> +					 * to zero.
> +					 */
> +					page_vma_mapped_walk_done(&pvmw);
> +					break;
> +				}
>  			}
>  		} else {
>  			flush_cache_page(vma, address, pte_pfn(*pvmw.pte));

Thanks,
The code looks fine.  It is unfortunate that we need so many levels of
indenting and exceed 80 columns.  But, that is OK.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

I see you have a followup series to address the call to ptep_clear_flush()
for hugetlb pages not unmapped via huge_pmd_share and will take a look at
that soon.
-- 
Mike Kravetz
