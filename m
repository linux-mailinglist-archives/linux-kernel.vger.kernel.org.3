Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC04547DC7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 04:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238262AbiFMCze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 22:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbiFMCzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 22:55:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD863A1AF
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 19:55:30 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25D1hLF2030207;
        Mon, 13 Jun 2022 02:55:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=E/RbhwGWLuH5hwhQ3qAvSdeNp0pZ/WiQ+imvJognpAc=;
 b=RvEVrSXMKgtE3gTOLm1ABRrcaN1+P8ecOoB0DpjzYBO7xTCStl1JsoWqza3WYcT78YRp
 Ix8DQJUBHSyWGRDCYdOFpVvIVwnmiKeGFKgN/QjxdybNEbKjgmlsVxJUVN/O0TB7hgVY
 thHTI21yhqlo111kO+c332Mir0qfKrUZ3A0iBv4pzPEez11gcBwiAo7XnbtvHuX2U64j
 b93XbPsUgaCOs+hnwr6Vi5zoTTfv28BNJxfZacDJLI7qhTwcc/pTmWPrI/NjHOQbxWS9
 yE2QRFznuBt3+59jOs77DVEBOIFMcsh3xfJ3vGBxLBrCG7F+wTRRGI1o+VJm+M47cPcz 7Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhfchxqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 02:55:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25D2osuQ005823;
        Mon, 13 Jun 2022 02:55:25 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gmhg2uq68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 02:55:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P38Ydxxs5pqUpb2LtLiQq0slbqpv/8+nU6PYa7Fdq+tttF/ClFmn4a1+V0zvD7GoXEiwUaejDDQ1yqG35sz5kb2H99Zo3s9fDsSx3TQsCuo1icNanYcYEqY5YJP6rQ3YsoV2t+EFB5mPUeRlAsGEt8L4SNLUbarpPAUw79ga56NFTGeqR7S3nnehrWg+OU22ZwCmPNeJU4CGRwFczdI9TegOtrJ0wmjDqxDlVdnYiQZhyXTRW1njJuN6W+CGv2X96jX3ucW4URS82dD4ETnnvMxrnJoSLE6HuparSIoPTNK93IISUM/eEyeH17qB1rhtTgoZRSlljhYLu8/cnZVSwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/RbhwGWLuH5hwhQ3qAvSdeNp0pZ/WiQ+imvJognpAc=;
 b=cKH70XrDto9w2D4qrDLiD0G9aXdkxmEq3R/y0rufmnahj+hz6oSQT9rqfNpwy1w+k8G1gODnpGJb267OSo9NZr07ETAMc0suTtZvy80BednEnOuCBT/eiM7zXfVFFdOwAwuuNVfCFn0NLjmCbwGxCiakq381reE0gHosEo304i56MWAKAuBpiWKA8xUEO7ekFscJPxYASPZknF3pz7fVWB/Yc7GN4tHIHycM33UC2uBj/Xm14CCKpOK9afJPGcmjcVQ0Q6+Cb1lKKHR0ChedlAH6N7mW6IUyvMkeXApxyOhQszt9S9rbjzsgq55OdE6Bd9zSb+FIy3h22ijJg/nGmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/RbhwGWLuH5hwhQ3qAvSdeNp0pZ/WiQ+imvJognpAc=;
 b=GbEK3h328QBSNrSEoDCtqkmzWUkF0IxoJc3Uu2MycHUTKh2ZUpT8F7ugJ/OYYbmQBjDXWau9wR4xba7MyKcOH+Nlj/ATJTtVafLUK9wB8fhPR2i+WwGF/ZdZ3zJw2qqV69OZ1D5qUu2bmukuVHr5zbPfMMW2IuKjcSSfZMMXb7M=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BLAPR10MB4865.namprd10.prod.outlook.com (2603:10b6:208:334::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Mon, 13 Jun
 2022 02:55:22 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0%9]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 02:55:22 +0000
Message-ID: <c8a8a616-da4c-f2ce-0bb2-e0cba69db24d@oracle.com>
Date:   Mon, 13 Jun 2022 12:55:14 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH RESEND v4 1/4] kernfs: make ->attr.open RCU protected.
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20220602063907.136569-1-imran.f.khan@oracle.com>
 <20220602063907.136569-2-imran.f.khan@oracle.com>
 <YqYpTShTDLvAp4vx@slm.duckdns.org>
 <6d1c5a49-fc16-5fc7-e527-8cb91ec0d25c@oracle.com>
 <YqalHuEB6OjjUosV@slm.duckdns.org>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <YqalHuEB6OjjUosV@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYBPR01CA0042.ausprd01.prod.outlook.com
 (2603:10c6:10:4::30) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed6ca36a-9dd8-47f5-ddd9-08da4ce8283a
X-MS-TrafficTypeDiagnostic: BLAPR10MB4865:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB486550F3888F89C880E288B1B0AB9@BLAPR10MB4865.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Is/+ppL2ww2f+mf7nYKolhvWSG3DwjjSLTkSh9W3Nach2nsNO6oF927S2mrw1aaXwOFkO/bC5NAWadcE/atAn/Z0nxMNU87SWqI/rUBISRXiqSU9HZdY25akjg3cTpv7+ZqcRcah0h0MLKLv+Foy4IvYfRt3COvdQYvtQzTk0lc8ecKbPMWvB/Uq16hjvOJxkWImj12DxIssUtHoXYWWhykpLCnBE5oVrLK9yFXbU39KKaMBiAxUorEZt5/LSXBg2b5Cr+MZTbhe5rzV8dilCXwIevODt/dXhF7xOsracVjK8XrCq8VLgMhng7QeTvSb/zE0lIRwhw40Rzi8EIIahDQ9SaXcIZ/1BM/mhFakdhO3EJt8Clq4aRp+oa8+2F7d9duoOEZx5HOfUQ4NDQu/mPzDV7Hv9+ez/Y4ulk0+o4s1oMS7Kx5MyC8hLEDuokS9idE3FM2qePpZcpM7cmTiXOzZKMYpU6jmQtFfA38Ee7VMSd5h0A+7ViBU2Y9i150I25P0kYg+A/Ug+vHvdxbQadd3b2rp0TgI8I6NokZyF3o28+gQ5N+twCNOUt1h3pl02YkIHrc1dqnSN+FFwqVYGc8BRr7c2MoIm5kEOdYEFuYSL6TapmSAUmYv24YIxtX/J5SXISABBhj45zHu0xCZs5igmJwc1YL23FAHjtD35T5jS2UXRxP9T0O6YCGeVm0q22lNLADOiB0UJyTsE0isxALcJZAFhV1WGV5vcmRmC7wPg7h8TrRAkgEYdLoFdVj9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(31686004)(36756003)(6916009)(316002)(66476007)(83380400001)(66556008)(4326008)(38100700002)(8676002)(186003)(86362001)(53546011)(31696002)(2906002)(6666004)(66946007)(2616005)(6486002)(8936002)(6506007)(508600001)(6512007)(26005)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzlxejNxMUx5L05MOGVUczdSNitPT25EK1NZUmV0UEc5aEdvdWwvLzNkcTVF?=
 =?utf-8?B?MTRlc3dOODlUK1JLbSswMWJxWmdHUW1MdXVTOStOV0RJRlMyaUV2RzI5S3RQ?=
 =?utf-8?B?Nzl3U0Jkb1lVUHU5eFFlUkN6alZ5TTBIR0Zrd1pxWkFjanhZajNUSldRUHZk?=
 =?utf-8?B?bVhEWGRtcytrVS9QL2RLMzl2d2FHRitwK0RVa0FsTnFKZG9wbnArNFZpbFpV?=
 =?utf-8?B?b0Q0TjJGNW1wK1lHUEc0MVVkK2doWGErZTZ5WkJlZW5NYjYxNDBIbWVBQ3Bt?=
 =?utf-8?B?bHV1ZnM5eUZ6a0k3TG80dUovVVQrdC9NdnZ2M09BSGJlR3hMVGpheENvZXVU?=
 =?utf-8?B?NHFBbHZGK2RmQ0hPQjV5UkhjaVQ0Zmx6bWlBK3ZPdHg5QnF1VE95cVZySHNE?=
 =?utf-8?B?YXg4Ym44YSt6Y0tIeDFMWGw0Z0h3ZktZWk9IemYxQStyTDhlSjViblVadU5v?=
 =?utf-8?B?a1pVdk53cXdqUXZnR1ZLWUl3YzI0V282VG9Sd25Sc0hLTHpaNXZzakJvbDhr?=
 =?utf-8?B?MmNvK3RiYVN2WUdIZzJSdmFsbmg1VFRIQ2VNQm9WbEhnSGZrbjJCbFhreEtF?=
 =?utf-8?B?MlByTmpzUzF5RGVTSWkzQjdxWDBIWHc2TCszL3BXUkJBSlNERytDV1NxbnBL?=
 =?utf-8?B?VVZiU1l6em0xdktrVy91eUlZcDZYUXZqeERxakZLSnQyT3l4enFqbTd2bU9i?=
 =?utf-8?B?UmpaOGNJdytnMUN4R1dBL1RaU3dCMVNobXRzWkptb3VVZmVWYTFGT2NoMUtl?=
 =?utf-8?B?U1h0Q0YzS2t4TWNsU3lndlloQU1rSHlqeDdMMVJxWmFyV1I2N3lPbE5OZ3oy?=
 =?utf-8?B?K2ZSejZJbGJkVUNHWDVVd2lLZGpybThOWGVYR3FoNU1ZZUVDOXQvdmNrQ2M4?=
 =?utf-8?B?d3pCNWxiSDRZNm9HZTltRnRQZXhLVGtRdXA2ZjFWYnVzaDBLWG91SU1pczd2?=
 =?utf-8?B?c1VnTzFJQTJUK0plTVJiOFZ2OTk3L0tVM0FQUDRaSzRqUnBpbVhGWU1yeGZk?=
 =?utf-8?B?MDNPZkZxV0xHQ0F6eldpaUFueE1JdU1ZOCtlT2N1Y3kzc2I3RWJ6TTVnMTNz?=
 =?utf-8?B?YWxaMm9ZWndoSHJ3a2FSU09QN0xoelhYQjExOVU4ZGJISHVGVExOWFJnc0JU?=
 =?utf-8?B?STEyRVkrMDh6U1l3SnpBdHVSR29iWHU2RmJuVjd2b0JublhKUFdGRzFuUzdX?=
 =?utf-8?B?WmIyc1ZXV0xHUmFHOElKd3pIK1NTb2hySUErNDI4WXZlbjkrVGJvR1VyQy9K?=
 =?utf-8?B?allCQmhNcDVUNEtib2NDT1lVQ0lmTU5xcTJvNDN0Wlg5a0U3RE9DTTRuRDY1?=
 =?utf-8?B?cExqdVhNN3ZiZExpaTNvMSsyNWhaanJtcTMvYTZLdTRuWFR0a1VhR245WWJl?=
 =?utf-8?B?eHQ2bzRsRXZyWmQwWW9sb3hlZ3ozZWxlUFVOV2FRSkNBM0h4V2o2NUFqRjJp?=
 =?utf-8?B?TWZTdWY2UFplV1pPQ1VZbGpMYU1XS2xNZG1tTGJGcXdmaENudUVrdFVwc2Zo?=
 =?utf-8?B?YWQ1M1l0dkRoM2Z5MW0rbFRLN1RyUlJrMTVQekh4bm5kc1c0SDFpSXFTbDFx?=
 =?utf-8?B?S00ySGZzalJXam16WHo5bk5HVnJPSDBPMmhUcmsyRldKanQyN1U1RWpMeDJM?=
 =?utf-8?B?ZDlNbko1UlBpdXFrcmFrOUI4VUxlbGhmUGJVQi9uZ1d1S2VsaXlMdFNkblVE?=
 =?utf-8?B?OVcwZXZ4aEpTbXhSSm5pckUzQm8rTzhwQ2swYklsYjNnaG80U25SdDc5U0dU?=
 =?utf-8?B?SEFYeXNPejNEbXJpM3RucjBLam0zbU1CYmlCak0xTTJlaW40cWxYc2JtSDRL?=
 =?utf-8?B?cllPNVJFWUZ4UERNczk4Z1NvSU9JRFZVZzlNZUh3TzNCelFGcTdrWnhmMHNO?=
 =?utf-8?B?MVJGN2tiWmJHYlk2T0tVb0h2T1p5OTR5azA4SHRrVjVYQkVaQ2ljSHVBajYw?=
 =?utf-8?B?Z2hCSjVvU1QwdGhjdmNvSTVyc0FOMy9QT05NZmtCNkc5ajI3MTFINFd3NWFM?=
 =?utf-8?B?em1hNXZrM2JPNWJtaXhVS0E5Q1BhQTI1TWNKU0hjSTZPM0hMcXBHdVFtQ0Nm?=
 =?utf-8?B?bWt3NFhSaDdnWjYrRVZDVTFpbUo1SzRLc204N2ZrbkFFclNMckNkUDczWHVk?=
 =?utf-8?B?eDZ0anpqSmp2Mkw5M2hCMmYvaEhrMmpjNnNsdEUvWU9hR3BDVXlCOERSb2Fm?=
 =?utf-8?B?QmtWdFBQdDdWbktDNmx3ZHZiSHlmQUJIZWdvRVpHYmQ3OXBSWXRBVzlvMWha?=
 =?utf-8?B?SmNaaEpiaHloOFhTUkxEd0lJRFhaL1lacFZTVW5qYTM0ZGNPZWtnOEo2T1RC?=
 =?utf-8?B?TDkya0tPMUhVbWU1cUJYUklBQ2NEOHU2MDRVRjRMZXdqRW13NHNmQ1ZIbHpT?=
 =?utf-8?Q?5IX+SQLD/h1M5nhw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6ca36a-9dd8-47f5-ddd9-08da4ce8283a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 02:55:21.9928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7yy4Ak7CwX/i/jmiI5FwLcDQ7bV4CUmSKtuuvRNUZ3WUfDlZb2HfvsJ9wlJdHbo2YV6kK58PZZ0EN76nsuhNaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4865
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-13_01:2022-06-09,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=882 mlxscore=0 spamscore=0
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206130011
X-Proofpoint-ORIG-GUID: 6hDR-OVowaR0cP9xuTlLK9UKkNTf8Fme
X-Proofpoint-GUID: 6hDR-OVowaR0cP9xuTlLK9UKkNTf8Fme
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tejun,

On 13/6/22 12:46 pm, Tejun Heo wrote:
> Hello,
> 
> On Mon, Jun 13, 2022 at 12:36:12PM +1000, Imran Khan wrote:
>>>> +static struct kernfs_open_node *
>>>> +kernfs_check_open_node_protected(struct kernfs_node *kn)
>>>> +{
>>>> +	return rcu_dereference_check(kn->attr.open,
>>>> +				      lockdep_is_held(&kernfs_open_file_mutex));
>>>> +}
>>>
>>> I don't understand why the above is necessary. Whether you're a reader or
>>> writer, you can deref the pointer w/ _protected as long as you're holding
>>> the lock, right?
>>
>> As per [1], we should use rcu_dereference_check() for the reader side when we
>> are holding the lock.
> 
> Hmm.... can you quote the exact phrase that you took the above from?
> 
I took below phrases as reference:

If the access might be within an RCU read-side critical section on the one hand,
or protected by (say) my_lock on the other, use rcu_dereference_check(), for
example:

p1 = rcu_dereference_check(p->rcu_protected_pointer,
                           lockdep_is_held(&my_lock));


and


If the access might be within an RCU read-side critical section on the one hand,
or protected by either my_lock or your_lock on the other, again use
rcu_dereference_check(), for example:

p1 = rcu_dereference_check(p->rcu_protected_pointer,
                           lockdep_is_held(&my_lock) ||
                           lockdep_is_held(&your_lock));


Thanks,
 -- Imran
