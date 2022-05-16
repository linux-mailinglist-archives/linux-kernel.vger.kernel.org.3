Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E595289A0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 18:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245670AbiEPQIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 12:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245664AbiEPQIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 12:08:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A209037AB4
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 09:07:57 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24GF72JR009397;
        Mon, 16 May 2022 16:00:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=MTc5lijZIFw35MDgY6cEo9JOLpZH94xs+SwgosuOXDg=;
 b=PRkC4Yvc1ye8/nQI+Pv90ItVaPtAwY2bPFBZpzkFaNNstDDKOR8uHtUQx6jh/0tJAdRZ
 T7JXxVHQpWpyh+AuJIEKY3iS7OgfxHwtY8+fLOhMtfeR2ioaM83E4uE1A1fhUB4K2Lde
 iCl7F30m99w4alh2bL5j9IRUHdxxMHPKZuGQXbJQPwpHWgT9WEhTczgMM+aHQXChgCLn
 Kwcn1HVCJSaD75QwWlKH03Lv4/PKWqZ++W2w/YlJWN/kI4t5ksyDVYw8IIqRkEmXOtwY
 4xaDvnbP7xMkhMnbgfWss1Rmg9lVx2nijnrVv4GgrD9dnc0WDvl29Mw5wG+yyJK1CKul nA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24ytkqbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 16:00:13 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24GFt9hE010944;
        Mon, 16 May 2022 16:00:12 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v22q73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 16:00:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gA16/x2Um1L13JnoNroZT7RXOWRgZVvEnUqXRtouSTfwv4nGp69HY2vdqW/iRULYI1U99mj1v+mJNqtpeGrEim5oQ4UEjQjCV9uem6zujqQCYWXlHgnqLZ7Nq/OKEwdy7Lxd+nxxEpmaflIUyx3wZo1JQITM1CGn5noWS/weEEohVZoeRqGHOB0xAGebyY9ddTRo30/IfGMFL5yTI6wEFyv9FYvgCf3u/VVF/nZqaN/BnsFgYeHRVXhhU/aXDeJcpKyE+d4ugh3tTNFgRCI5YZcMhy1pp4+qUsHcF1jVy0/sVg4SX9yVNiW/lRPYiOlhrYUHQfZVxai1b1DPrI5eSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTc5lijZIFw35MDgY6cEo9JOLpZH94xs+SwgosuOXDg=;
 b=KmC2r2fgadE5G8Q47bRznEVtdQocxVGM9CMZY2NI7aMEpuI5mw24N1Vj/yKWWahlq1fhRQggo49hrL/Aw16GE10iU0ZI1gg6yYrAFGaNtefFZvYw6x7TBtpVz4O8FOKm8IZWEwYuC7bqQgwzC8fZoJoF1Ls0Hre3JeCKO8wjZnsUZTGRjdn66nCloyOKx7RyRYKR70QYzSmSKfofp034sj/7UBDKJhGNYqUTUxW3MXLRGfPRyilUn48kPvr2yRAlSqxTzxSNH9p4JhUQXKjUb5yUb0zFe5go798IS9yClEttoppBTXJ9dEd27CeDT4+AI55qsFTMJHL+yhg/ZDCEwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTc5lijZIFw35MDgY6cEo9JOLpZH94xs+SwgosuOXDg=;
 b=hzYE2MylG/khSa2QcCuFtsvRjbNZe3azyzKw9+sKlfXyT8IjEoyfSngyyKb/1WQUsS/Fp5GwleSxfAGW101k7NbT/cO2IJhMhaAZwHvpcQ+qPHNCr/S//Irhw00J74CZLF7qCOys+LrkI7gJnzvXdF2bKlZChLoCiJOBA/xL6fY=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by SN6PR10MB2464.namprd10.prod.outlook.com (2603:10b6:805:4d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Mon, 16 May
 2022 16:00:10 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::125:f19d:8eaf:b8e4]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::125:f19d:8eaf:b8e4%3]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 16:00:10 +0000
Message-ID: <80286144-cca4-ef07-3aca-2c2374881738@oracle.com>
Date:   Mon, 16 May 2022 12:00:05 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH V2 2/7] xen/grants: support allocating consecutive grants
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <olekstysh@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
References: <1651947548-4055-1-git-send-email-olekstysh@gmail.com>
 <1651947548-4055-3-git-send-email-olekstysh@gmail.com>
 <597125fd-4c85-fde0-9d5b-a9cc13a81ccc@oracle.com>
 <d1d61bcf-86f9-68cd-9bd4-a13bf8149b88@suse.com>
 <91f95228-215c-b817-8bb6-8e24c0caf925@oracle.com>
 <e04fd32d-b379-d515-2080-781e555303f1@suse.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <e04fd32d-b379-d515-2080-781e555303f1@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0344.namprd03.prod.outlook.com
 (2603:10b6:8:55::28) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce285bab-33b9-445c-29f6-08da37552758
X-MS-TrafficTypeDiagnostic: SN6PR10MB2464:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB246449CF778C35616B1E6BA58ACF9@SN6PR10MB2464.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ssye4ycntRwYHP93ngFZHHwlpKu5Kxy3Y0CALkUs7Oo/MrT7dYnhHlYq5nNry8q+nXqrporb9P0B5SBXAUbtY5e6tUxgVssu63yqV5xYbe1pjg2Kzll6cE7tMCiXTt5B8dw478EUxmo7OE6AZi3KfsRpFvLmTJ2X7Hd3Ue5SE2hWPxvRiH8AkaQS4WwdQ7zLIUfzPucilPP/JJtht9uo/NVyYBVeCHiNILy/MGfs5bZq+2+4PEC7M21a0FG+yhj9KDKb0KN1fH+Mfi+3WwswUeQIs9tJ3fVjT3OkmurKK/eYSunyoXhr+fEI8hTTkJNGT87Hhyz3T8gxx9Ou2ge6RYu6PIfzSozljd/TFsmm2EPmM5Mp1GBRMYZLt1Wv1MvBj8qvnjO+XeyIBTg+fbKNCGeo77ltBbS811AGrBdj/X0iWsU1fcXvhPcdqrD0S5i7J+ClfEirkuA1SkrxkMJ1caXX9yFWnv6wfOJwsNzo+vi8vWxmIBQUD4CNUaR++myF7q9oIepOro9iDwm9Nj2pP1yQEd8BPluGpnHcewgP8GybyjwJE9FWW1WoTin0zTveNNf6btIc0/F5JN8GHsE950wtoS5+eWPG1p+U79g0Jg9PpVhtdP8F6al3NFRXghLrF77IxzHEk/4KMl6/0nlpVrpFM2teN5LlQsXA82BK8GiS/EynK9VpQ05NaqYaB/1uTM3Q4Zf9+q9e89DKamQCEk49BGIl4OYKfotALsi/2oQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(44832011)(83380400001)(5660300002)(8936002)(31686004)(36756003)(6486002)(508600001)(2906002)(6506007)(4326008)(38100700002)(8676002)(66476007)(66946007)(66556008)(31696002)(86362001)(26005)(6512007)(6666004)(54906003)(316002)(186003)(7416002)(53546011)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFhadkJpdEZBY0JnVXNNZUt2bjF6a2dubjNMTVNoSFovdWxrYmhSV0dEc1Mr?=
 =?utf-8?B?TTVrWWJ4Z2s1d0FaQjNNNVM3eURpb2RCbE56S2hQeUNpelozNk5kNnM4TFVR?=
 =?utf-8?B?VUN1TjlKakFHYU9ncDJrZ1JTWk5lb2pOU2w5bEMrVGtPTjcvM3ZQZXJmd29V?=
 =?utf-8?B?Y0JyNklPTUdZS1JJZi9jK2p3bEFjQ2s5ekpSL1FmMnZTM2tKUklmcmpCTkJy?=
 =?utf-8?B?SVJsREFXcXBjcHZ5WnhoVnpXcCtWTzVUS1J1Rnl5Vnc3Tmc4dDdWaXVFbHpV?=
 =?utf-8?B?WERaQ095YmdTRjZXTGYxTmptTWlzRGNiRi84Y0t3QU5vODJQMWI4RU94K1Ru?=
 =?utf-8?B?M1hGdmkzMWc2S3JMSTVqTEZ0T0tBVStKOVg3M1p0QWwyQ1RZSzhvTHBSTi9B?=
 =?utf-8?B?ZXpmT3BDcmRsRUw4WjFuZ09kMXN1OFlGZGdXbXpDZ2FtKzZsb2E1VmZEcTg4?=
 =?utf-8?B?dWxNTnNxVVh0N3BxUitlc0E4bkJSN01YQXp1Um14Z20xMy91TURMdytOYVAx?=
 =?utf-8?B?SVZ5NDBqQm5KUlRtMjlZQ0d5NGhlT1RYdDlYUWNHOFJ6T1hUMC9GNWZyY29k?=
 =?utf-8?B?Ym50Z3dObGM5YWFtbitzcG1xdWdvczMzUjI3YUpEZU8xbEIxcWZIRm1DOFRH?=
 =?utf-8?B?bmZkMTRSejFFVkhOTXVBNXJpUjlrQUE0bmNia0t5QzFIODFlNVV6ckoxbWlL?=
 =?utf-8?B?bEZ5WC9BTG41ZjlLVHZoT3RHU1dDTzg0ZHZSRk15NWpMYUF4cStJRDQ0VFhN?=
 =?utf-8?B?RkVxNWlNRkIwcTBvbUloY3BkbUh2c0t3YTN4OHV3bGh4RmQ0QWpJczMzWkZJ?=
 =?utf-8?B?ZTU3Y00ydzhJc3FTNmx5dXhsSDlYQkxzaXpvTS9Ta2MvL2U3aW02N2UxdVZm?=
 =?utf-8?B?dVM3ZTFpeUpZZHRzTTdaTnpNdkNUb1lsdHBCdm1GUDFWN0JDa0xjcWlsNUtZ?=
 =?utf-8?B?ancvOGhzMm50bmswYUJ1MmQ3dkt6T3pDQkRXcnlBVDNMSUtEM3oxU3dvc3pV?=
 =?utf-8?B?eVBpbkJTbmVHM0ZWVGRleHlIZjBmdHJ5MjVDY3AxTFZqNlc3MW5BL1ozTWg2?=
 =?utf-8?B?VGFmanRqMjNFR2NLNkVOTFpVUm9hVkNZaEdIQkZ0Q2pReTZzcTR3MTVZVUda?=
 =?utf-8?B?RjdnMG1HaTlqV2dUcWJKd2Ruam1pTXBXenQ5aHdCK3djUmRndEVsc0tLSkg1?=
 =?utf-8?B?ZENLc1o0S1lsdWpyanRFT3ErOCtSa2s2Um9tcFdLY0p3NTVIdTdtQWdnZnhh?=
 =?utf-8?B?enFyNnpOWmZrd25GbSt3M0Zkd2ZZY1pTL2VWYkZ1aTE0Z29nOWlpbUR1ejFr?=
 =?utf-8?B?MnNqZm4rZmZQV2FQczBPd0RsL25mWWRIOE5EandDT3hoRGRSS1d2d2RFQ2hv?=
 =?utf-8?B?VFYwTnBOczhwYjNxdlF2QnJpSnE3NTQ0aHpYeng5bzFrZXBWODQzandpeisw?=
 =?utf-8?B?emhJV1V1Qmt2SHcxeElCWWVORnoxdlJFVzd1N1l6VlgvNDBoUzZZOTczTGlK?=
 =?utf-8?B?Y21hN0N2bnhCSkgrclB1Q09TM0tQYXhpczBDcDZtZGk2Y1QxUk9na3J0NUxD?=
 =?utf-8?B?NlUzOG1HY3lURzNaQkNIbHZGbTlCUGxNQklCdG5hVVVReWc4c0JNSFd3M1lM?=
 =?utf-8?B?aldGTDZ3ZmN6aE5MK0ozWlNEWCtFRkY5QkRxQUpOZGg2Z0pFd2ljL2hlZkk0?=
 =?utf-8?B?ekhMa05tTkNtdFJpLzZpUy9zaUx0U1F3ak5YNXQ3Z2NBcUpLTkkrNjk2S0ps?=
 =?utf-8?B?b1FhcG9EQlFNczlJZ1BSbTJhYkJYSHQxRmk0RHhjdVE1S1Q5NXlqUWRjNmVX?=
 =?utf-8?B?b0Y3VkJ4KzhydEJObWZQa2d0WTRxL1ROUlNVVDRIbytjcjcrajBFcFBPUkF5?=
 =?utf-8?B?MVVEb2Q4RTJncXdlVmtCZi9jcGpkbFZoMElpVTduYXBFNmZRRHNDV09qS2FT?=
 =?utf-8?B?R1dnQXcrYzZ3WmtJSTM0eDM1N3k1UHpPNGJ3di9uUUQrUEdORXMzZUxtSHp0?=
 =?utf-8?B?c1FrRml5ZlVucGNvbldrVzVON3JteFhxcjFCckVrZExLekFDTExUSC95NmZR?=
 =?utf-8?B?TDExN1BvNndRQ3VjbStjODBXYUFlYzArUzUrclI1WTYyd0F6TzlOMGMvZ3VJ?=
 =?utf-8?B?cnZlVTl0bHhxUjJaeEp2dVVNb2RnRmMyNXk4RXJsU1gwdnRjZEJLd1FucGpD?=
 =?utf-8?B?WjRhVFUrVlZwQy9sUTRLYVVlNXF4cFdKM2t1MXRIRms5Zmo1YzNodXdyMWRk?=
 =?utf-8?B?LzBhRnF6T1JFOEsxM3JCcjJKRVAvQWNzdnl1a2J5UVM1Q2k5eUJ1VUtMRzhz?=
 =?utf-8?B?SlRrK05JUWt0VjFIbnYzbW5IQ0pxUnV0c2FWTldzUG1mOWZBVUlYRmxXWG5t?=
 =?utf-8?Q?8WclvEQ+diXTdGNY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce285bab-33b9-445c-29f6-08da37552758
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 16:00:09.9902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FmoHxtbIvZsHsufZhRIcehYjAnhh14jgM+LxPJqnGqh2rfYvKOaKhp5mqABijLixWttSzvLNnMI1Akir23/yy25LmmKEBaW03RaN14oJdY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2464
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-16_14:2022-05-16,2022-05-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205160091
X-Proofpoint-GUID: yQg_XaNzmgEyh--YBNbdb2uxZkJd1LLY
X-Proofpoint-ORIG-GUID: yQg_XaNzmgEyh--YBNbdb2uxZkJd1LLY
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/16/22 1:59 AM, Juergen Gross wrote:
> On 14.05.22 04:34, Boris Ostrovsky wrote:
>>
>>
>> On 5/13/22 1:33 AM, Juergen Gross wrote:
>>> On 12.05.22 22:01, Boris Ostrovsky wrote:
>>>>
>>>> On 5/7/22 2:19 PM, Oleksandr Tyshchenko wrote:
>>
>>>>> +/* Rebuilds the free grant list and tries to find count consecutive entries. */
>>>>> +static int get_free_seq(unsigned int count)
>>>>> +{
>>>>> +    int ret = -ENOSPC;
>>>>> +    unsigned int from, to;
>>>>> +    grant_ref_t *last;
>>>>> +
>>>>> +    gnttab_free_tail_ptr = &gnttab_free_head;
>>>>> +    last = &gnttab_free_head;
>>>>> +
>>>>> +    for (from = find_first_bit(gnttab_free_bitmap, gnttab_size);
>>>>> +         from < gnttab_size;
>>>>> +         from = find_next_bit(gnttab_free_bitmap, gnttab_size, to + 1)) {
>>>>> +        to = find_next_zero_bit(gnttab_free_bitmap, gnttab_size,
>>>>> +                    from + 1);
>>>>> +        if (ret < 0 && to - from >= count) {
>>>>> +            ret = from;
>>>>> +            bitmap_clear(gnttab_free_bitmap, ret, count);
>>>>> +            from += count;
>>>>> +            gnttab_free_count -= count;
>>>>
>>>>
>>>> IIUIC we can have multiple passes over this, meaning that the gnttab_free_count may be decremented more than once. Is that intentional?
>>>
>>> After the first pass decrementing gnttab_free_cnt, ret will no
>>> longer be less than zero, so this can be hit only once.
>>
>> Oh, yes, of course.
>>
>>>
>>>>
>>>>
>>>>> +            if (from == to)
>>>>> +                continue;
>>>>> +        }
>>>>> +
>>>>> +        while (from < to) {
>>>>> +            *last = from;
>>>>> +            last = __gnttab_entry(from);
>>>>> +            gnttab_last_free = from;
>>>>> +            from++;
>>>>> +        }
>>>>
>>>>
>>>> I have been looking at this loop and I can't understand what it is doing ;-( Can you enlighten me?
>>>
>>> It is recreating the free list in order to have it properly sorted.
>>> This is needed to make sure that the free tail has the maximum
>>> possible size (you can take the tail off the list without having
>>> to worry about breaking the linked list because of references into
>>> the tail).
>>
>>
>> So let's say we have the (one-dimensional) table of length 13
>>
>> idx    ..    2    3  ...  10  11  12
>>
>> grant       12   11        2  -1   3
>>
>>
>> and gnttab_free_head is 10. I.e. the free list is 2, 12, 3, 11.
> 
> You meant 10, 2, 12, 3, 11, I guess?
> 
>>
>> What will this look like after the 2 iterations of the outer loop?
> 
> idx    ..    2    3  ...  10  11  12
> 
> grant        3   10       11  12  -1
> 
> with gnttab_free_head being 2, i.e the free list is now 2, 3, 10, 11, 12.



OK, thanks, that helped. I couldn't link the free chunks in my head


With the error handling in gnttab_init() fixed

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>



-boris
