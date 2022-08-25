Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45A85A17F3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 19:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242455AbiHYR1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 13:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235860AbiHYR1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 13:27:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D69A061D
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 10:27:22 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PGhiSK021451;
        Thu, 25 Aug 2022 17:27:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=bdPq8YbGsIh51yQ4SU+KlitK51o+plNq2Nxqi1AT8Nc=;
 b=RWPivvNSwtfxHON91trdVT1e+QbS5+taajyDmtew55GWkTd0jd5enn0bWQKHR6snHdAh
 hEihYGa39sOb+iC5QAiFltv4B1wi3USPLkM008ctiFPAkDRDFuJJuuVL3YL/BrZIOVl/
 krXnXYeP3BWaF7xmd5zBhmPnBVsqKGnUYUilceqKdulyKbFujxQKZP6z5F0ITjVlvzWK
 zXvQJaqfJWcYgj91PN+Q8sKxqIIzgpx1RZaQLFMXwbt7lAHWI/1HsKXya+cBJrgwb4x1
 jBTrZtynxS8b90kJQrDhT2kBdmH8nTZ8cB/jv3MAbDJOydwIL8JqRI287LmKTttntHOf dA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j55p25fd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 17:27:10 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27PFJI2F003694;
        Thu, 25 Aug 2022 17:27:09 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n6pny0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 17:27:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcabU4J/V3zAE5s+8CGO2RdPRZxv79dOsBmmZLjkR3d01uliBl/tJtfJH8mLvAxxFTTT5D63TTCg1OIKG18OIDS8WmxXV1YDfaKn6oN9bbioEAYaPD+qGfBXvJBJiXWyYpPFG9y7TjpB+o92ORUcN6pulkOGXedEi61qo9rKzVTxG5tcN4gkVzwLM1a8OMbWMK84ZvfFUqLu76Anqv9o/LKzj1PTfN1NXkcluiEBsY+Hd2Xyl9gMtnVuIJVeiawnPCwKTUQUjniNAiZtInmjkQIWweMSDQUB95r/gTDJwK6HNikfCPgil+aXJKaOGdE28jZgavkLvUvhKYbQlPip8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdPq8YbGsIh51yQ4SU+KlitK51o+plNq2Nxqi1AT8Nc=;
 b=ENmgR0ytMo0SJSDgBoQbGo+hF6vqyLXx9iNn4yFdMvRQ+6uy0Eqf79QoFEJ9krb0NdZ0CwFC91juxkRUSSojhkuHDRvukk19mREwFDRMFKEC99Apr7S+OBcpM4EwQ+RiUBreOt9eDJp3KpK+vZL9z0XagpguZ9INrFT5D/8+kTV2ld9Vr6u/10081yofxa+ai0JZaBz5Z6CZAvsZcNl8chsj7ZkF6Z1V45u01h3yllZk77xOCTZLpvRI43OKufLDWN6jIhNJeQcTOkV2myUUUHRSYHNh1q/XgwV5jQQ1ep8f5/LUz/W8zAstOA6AvdqHiaaivjMAkIkFrQSjXjvXqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdPq8YbGsIh51yQ4SU+KlitK51o+plNq2Nxqi1AT8Nc=;
 b=YtA6GCb15gFeDtgL7HxRAjFSrxRqGbSaDmly8Z+qCksfhkn6a4uugcWs7z5qAtLL2Q7DPo6ilMSlSub4O/ko945CriV+cpe3vrVwIqof3uYhrQ/i2UZMb1jO0I8+1d+gar9I32HsxKTwoC1NK8iV5k9hE3ry77O7ghwAdFrUczA=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by MN2PR10MB3310.namprd10.prod.outlook.com (2603:10b6:208:12c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 17:27:06 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::44ed:9862:9a69:6da5]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::44ed:9862:9a69:6da5%6]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 17:27:06 +0000
Message-ID: <a151e3d3-db1d-c3ad-dcd5-3f758b4138ab@oracle.com>
Date:   Thu, 25 Aug 2022 10:27:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] vmcoreinfo: add kallsyms_num_syms symbol
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org
References: <20220808205410.18590-1-stephen.s.brennan@oracle.com>
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
In-Reply-To: <20220808205410.18590-1-stephen.s.brennan@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::23) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3c392da-c0c9-44ac-d171-08da86bf086f
X-MS-TrafficTypeDiagnostic: MN2PR10MB3310:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VTJCTy1Fkfg8GkHsHxfJCnEYfXcX+74TDv33lRoeX2/9AnZpgqAXcE88/HwVXbZNPAEcocvRv1GH0bLnV1XpNNEk0fCV4tDRJXJi66JBJqtTFa4vWKGVmEIj/4cXIuu3R2pzxPsnV5WtKMcp9FH4K9P2Spa/Pty2SgDyt+GccAC8ac4ZAODbieId/YU9B2pC51gfUzshWrSVxt17Gpxuev0SIXVjp4fjnfEur7wJ6i7cDPWyAj0AgnzEvsR9wUDY6L60CU/eIAXkPp6AOqbvTr5nOTbSY/Zivx8OvH9VmlfUlpUN5Klat+aYL3ksdQZyw2mKNEMfEIWbn/ueefHxCYsqSIXLjm0Y9shgYMz4hv8qIRtcqhr5q2WJgZ4BIJ6YFdoZYuv8O32PC/Uk/rkoipLSGUxPobu3Ot0+sTVhlB1xOSrtVNGzOd8+AuQa0UXtl4TMa9Ezgr2C1Y7bKI0AVXVpFt8E5cFDEJML9Y5Rfshie/4sXmFFph+VhSya46SZWRBpZSeXDEN/WyWjz5ABFhRPTH8Zl7L9WpX7Vd+BKgl9hVfFhKpPTIVOs3Flkzk8sPB++GwXUtGv2PmNgbk6en8naRPcMTm3gJ2U26C+dm9S66oZc+F7xpM39z0rQJd6ODmWQMkHKBVCn538mZChsGZ5SBAymtQAevDDCCvUMaOP+Af0CLTXfqOnd+iYwH1D392ex+Sp7BQR62TAOv/XX724GmNlO1KmGrydHwQLff4y6aEaW2ZUzJQUDVu50CqzEJRwxNe0AoulsudrnaSd6OPVyUr29XIg0cUH/pN3P+256ukkE1V+2yWDtOLQ+DOu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(346002)(366004)(136003)(396003)(316002)(110136005)(54906003)(5660300002)(41300700001)(31686004)(26005)(2616005)(6506007)(2906002)(186003)(6512007)(53546011)(36756003)(31696002)(86362001)(83380400001)(478600001)(966005)(6486002)(66476007)(4326008)(8676002)(66946007)(66556008)(8936002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHFkSXp1dWF6R2cyNEN6WnF2SENMMXpSSmxscEtIZzBpOEFGVWZzK3R6MjRO?=
 =?utf-8?B?cXpPMGlWVkFqSk85cHA3aTR6NmlDNkZrOXFya2RtMGI1eGZGYmtHMldYL0Er?=
 =?utf-8?B?RSthSDFpWUhjQXhteUUwNkRtYnYvQ2lPTitKQXdUOEdtcFBBVytwT1NRQ241?=
 =?utf-8?B?bEtJc3EzQkJmYjIveVJ5Qjd5Z0lHYlN6RVZYb0tjbkVmN1F3UDFrRnZQNnZD?=
 =?utf-8?B?MXJGOGlvM2FoMkk3WWphRGlkWG56U0VmVGRaemdCdU0vUTZRcGR1YmtqWlRZ?=
 =?utf-8?B?K0V0eXgrUktpeVU0ZzJTQ2xXT0JQTmFWWU5aMklSYnpPTEpqS2xyTms4bXJl?=
 =?utf-8?B?a2tVekRVUkFGR0t1Z1ljaWNxelg0SzFZUVdlSkFwUEp1UUVCcGRzK0tGWEda?=
 =?utf-8?B?LzRVeVRqVjhtSkdmbHRxL3FBM05lWDJLUGlvVmxlNGk1WUFLcVg4SlppamUr?=
 =?utf-8?B?RlNNbXkxdTVvQ3hGSGlqVm9Ya21sV3g5dmx0ZmF3MHBIQ081WFdJYnZWNGI2?=
 =?utf-8?B?NnNYbDhpRnpXcG8rNDR6c0lvVlh4S2JzNlF5dkx1dEcvL1RnbktBTlgyTWkr?=
 =?utf-8?B?SGl4YkNnUWFvb3VtcGhXRi9SQVBIaUtYQWo0KzYvNU8xcXc5L1l4ZU96OUJa?=
 =?utf-8?B?dCs4TjUxZ0R4bFdTQmY5cWxCbWZneDh1akg4aVVtK1ByS2krRisrdkthZVFq?=
 =?utf-8?B?U2JYYmVoaWVscFU3WlJBd3ppSzRxWFNrcThXUnI0ZE42TEd1ZHZOcnQ4MEdW?=
 =?utf-8?B?TGhzN2RUSjZvZ3FUb001YVZRNVJWRUF1U0pwdXFWMThsb05UdEhNdU1PQkEz?=
 =?utf-8?B?cFZXeDVYRS9XTHlwYlBYWHNDRVJ0bFdDYnRFMkFCZEtjanJBSFFoSkZzUVBi?=
 =?utf-8?B?eGdNd2RwRVlta002WnA1N1gvaUJ2TGlZY09mK05Jbm5MZWJHVWZlb2c5T1Y4?=
 =?utf-8?B?NnNraGVXNEpGejNmSk5pSC9oRkYya1FZYlQ1MW9qamp2ZmFYeUFmWC9lL0l4?=
 =?utf-8?B?bC9zZk01TGZYQzB1SFJkeFVsMERocjRjNnBSYmxCcS9YYjNBRHhsUFovL3FY?=
 =?utf-8?B?VXdUWk9IN2t1amtTZlFGcWpwME9jb3FxbkFMbDQwb1BvS2tHYnlXYU9jZEVP?=
 =?utf-8?B?MVpLaS9vcHVBZ0lsT2UrRWpWZlFyZVJia09QMWE2VnFEckVzZEZFNjhjZFgx?=
 =?utf-8?B?aDlWSlRzejl2c3FUQWZiT1FzRXRMR1kzTDJGeStNQzYvVms3Z0ltTk9iVnNU?=
 =?utf-8?B?WjR1NzZub3BZdlhPaU1IWTlNNm5pekJKREdYWmhGQ0JyeHpNNFhTZ3J5UHBM?=
 =?utf-8?B?NU8vNzN5VFd0VHhodUp0U0JvalVUUDUyZGxJN0V4WHZScG85YkdiMXFwVi83?=
 =?utf-8?B?V0NyeDBYVmVzelRFdWRVd043Z3dGYm5hVGNZK3BGNzNWdkN1OFNTUzZCWGVI?=
 =?utf-8?B?MXRiRG4zak9PKzdBaCtNQ3ZtSUMyWXFRYzBiNCtaQWx1WUVIaC9ZZE9PU0k2?=
 =?utf-8?B?RWJEb3ZNWmFLdjQzeWxUNEFBL0pBOFBoWWI0RkxqSDZSbk1sWG9GenhjNU9N?=
 =?utf-8?B?aHdIM2hTSmJzdDE2YWJSUy9sby8xVENWdVd5N0thbVJEUEZuRjFIaWp3elAr?=
 =?utf-8?B?dmlscDNJYm80N3RLbHkrbXQwQXE1NG81QmNVaHBZSXd2VWc5bXljWDU4UVU3?=
 =?utf-8?B?ZG1zem9ZWGxyV2RWQlJ1RkpNS3NxK3RyNFM4bHpoQVN0VURNeW1ZVFZwWCtV?=
 =?utf-8?B?VGViaUtZWHRXOUl1ZUJtN0U0UlRmcEJray81QjM1cE9YNmNGbktJS3dwWWhj?=
 =?utf-8?B?TlM5MS8xOVg0OEdzSnlPSXZmbUl5ZVRsR1ovVjEzamRvTEpobUxFaVlJdDhV?=
 =?utf-8?B?dEVKaTIremMvalEwdU5lZGNIb3k4K0tMekxLdTMrbHZqdjlrbGg5MFJDZ2xM?=
 =?utf-8?B?MXliSlRGWkhwWDg4M1AxR3FrVVNaeG41NS9tZW91dkJnZU55TnVPNnVVTjFI?=
 =?utf-8?B?NHFIUVJjZDlsY3RjanlOOFcrSWdqVXo3RjVUZ0xrUVhqakZ4Z1pnS0VZSm96?=
 =?utf-8?B?VVdvdFJKenVjYjlZU1NYdGpQZzFkZDl5VzdHRTI4dWJUV1FzdGdOaE1hc1Nu?=
 =?utf-8?B?ZU5aYTZ5SFJHWUJQaTN2Z04rb0l2a0l4WFFtMDZYcnUyQ0ZNYjRDNkl5SDdh?=
 =?utf-8?B?cWc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c392da-c0c9-44ac-d171-08da86bf086f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 17:27:06.6642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: leohu+PVHy7BXlkGJOv5KNGt5Vq1R8EQJX/3ACpCACDmZOCdr9NjccDaxFloYBc6o/H7uiyUHiVFNH5ozwSkxzeTFXcIiIpNPKZw8DTVOSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3310
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_08,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208250065
X-Proofpoint-ORIG-GUID: ACzPFgQQ7DpQ3MEeoLuUrRnRZxo-bUdP
X-Proofpoint-GUID: ACzPFgQQ7DpQ3MEeoLuUrRnRZxo-bUdP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I just wanted to check on the status of this. I got your email about it 
being added to mm-hotfixes-unstable, and I do still see it in the quilt 
patches set:

https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/vmcoreinfo-add-kallsyms_num_syms-symbol.patch

I see the patch in mm-everything-2022-08-15-02-47 but it seems to have 
dropped out in mm-everything-2022-08-17-20-59 and later tags. As a 
result, it no longer shows up in linux-next.

Please excuse me if I'm ignorant of part of your process here, I know 
you handle a huge volume of patches!

Thanks,
Stephen

On 8/8/22 13:54, Stephen Brennan wrote:
> The rest of the kallsyms symbols are useless without knowing the number
> of symbols in the table. In an earlier patch, I somehow dropped the
> kallsyms_num_syms symbol, so add it back in.
> 
> Fixes: 5fd8fea935a1 ("vmcoreinfo: include kallsyms symbols")
> 
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
> Hi Baoquan & Andrew,
> 
> I made a silly omission in the above mentioned commit, which just got merged
> via Andrew's non-mm pull request yesterday. I must have dropped it as I
> cherry-picked between versions. Would you be able to queue this up with whatever
> fixes you'll send for the 6.0 rc's?
> 
> Thanks, and sorry!
> Stephen
> 
>   kernel/crash_core.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 07b26df453a9..a0eb4d5cf557 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -494,6 +494,7 @@ static int __init crash_save_vmcoreinfo_init(void)
>   
>   #ifdef CONFIG_KALLSYMS
>   	VMCOREINFO_SYMBOL(kallsyms_names);
> +	VMCOREINFO_SYMBOL(kallsyms_num_syms);
>   	VMCOREINFO_SYMBOL(kallsyms_token_table);
>   	VMCOREINFO_SYMBOL(kallsyms_token_index);
>   #ifdef CONFIG_KALLSYMS_BASE_RELATIVE
