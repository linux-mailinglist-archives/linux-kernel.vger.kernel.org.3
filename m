Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAED57C95E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbiGUKsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 06:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiGUKsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:48:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53977E007;
        Thu, 21 Jul 2022 03:48:35 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26L7jHIJ001713;
        Thu, 21 Jul 2022 10:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=kGT32gzwHXwpY00I0iFFIHpXyijz2qt0qt8BGysLB2g=;
 b=a2kUYrLXCQAV6nzKzz1XiDTtTtBt4BK50rKYlMturDC7GABmp8uDacYQRCttmpebcEa5
 AQGWEAcZCi9ruW6+Ol6d++auf47t/l2fJ/R5Rc0x0W6biapK/tHo8Y0oJSTZeIi2q4vn
 NAiXFCxISHXEOA96IEAjxgoa41qmVY4UrC8NVDc7VKPDUaFfGl0CL47Lq1saykVb2AZW
 gMzyyNFVc8Sg7/va8GCO2SrIC6DkIv37dI6N5corje3p8tLmjr2gZKQimr5szUkGtqJI
 Ihe60y+Z4NmVgLGfAGGHD9gsrj41Gsel1u0Fgco9uOjyRveMvfS8rx56vfoIOMhQE9zM 2g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkrcbux7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 10:47:57 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26L9WugH002711;
        Thu, 21 Jul 2022 10:47:56 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1mcunxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 10:47:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJaek2P3CPPgo3osBpR8njJ0SdqOx2y/fco8YTr7azj2gIx6AtiOfECqZJJoBNKjUVUUA9e+dobNCjSPINxXD8CZWweEWVqSEr6EM/VTFyXQBfp4bIS1eKvnFdvpbYyGrpyresasm2gtUXdJ4LgmN2WyrgHkqx0k7AqgQ6q2JYA6+rhMkvOn+EFUlxF0vfcFO3/6kf3jIeL0eMlV+pk8DyjdYF0lUQdIqH7nZIKxXzRrG2qdEVRWD1Oh0Elv6CO9OzqtkfudEVvMUMRRVhNTd7GNV0d7V4iuzC45d93mz1OGqtSKPKFmaZ7OmFxfRd2qJO2+LDMgdSiKm7eY1VYP1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGT32gzwHXwpY00I0iFFIHpXyijz2qt0qt8BGysLB2g=;
 b=ofMhU3CElDLwCbq5gxak6UPy6VAKcZImRrrE094T/xfU1mB9gx16acoJ7dWDWY4RR+JCDti4xIW6RqhtHg013e3zwhq4IDg3KsrodWBd01qsa5skdOu9xsdp2IQWxvdA6uE5sDvp15ZD1UTYoIcPTCvZqOFehh8GXxZ2xFAib/DfvkiT5Ipg1HMVUhK24TXrgnvcXqeRMSFyIh+e0nsX3oUw4ubAcEO5JwRLnpuP6mka/Xl+YrdCyiHrrIJFTmcjsvKV6IkFnaEeZqKXG64+NPUbTGDG7GG28tLTuRZG29bg65AvquJALtvauwQQbd07/oQ5PvphirJA5iCbbnb++A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGT32gzwHXwpY00I0iFFIHpXyijz2qt0qt8BGysLB2g=;
 b=TOxc/Xd5v4XRP1GWO/sHV0/gxtA0xBYTYWW7Qh5xpJW+9rRUrZDFQjSxsDawQOZpV8ydUGudFTdAu/CZPq9mNGCQ8j1IuWgcvGeoIX3pzZayk8mWz3XJ5j79Qpo7giYkZkL9lsxgj+Fo23Vfv033zave8RZp+WuZ3Ecf1DTfEd0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR1001MB2305.namprd10.prod.outlook.com
 (2603:10b6:405:30::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 21 Jul
 2022 10:47:52 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97%4]) with mapi id 15.20.5458.018; Thu, 21 Jul 2022
 10:47:52 +0000
Date:   Thu, 21 Jul 2022 13:47:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     alsa-devel@alsa-project.org,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>
Subject: Re: [PATCH] ASoC: qcom: q6dsp: Fix an off-by-one in
 q6adm_alloc_copp()
Message-ID: <20220721104731.GK2316@kadam>
References: <0fca3271649736053eb9649d87e1ca01b056be40.1658394124.git.christophe.jaillet@wanadoo.fr>
 <20220721100042.GL2338@kadam>
 <a29ea047-4935-4893-108b-f29f46971272@wanadoo.fr>
Content-Type: multipart/mixed; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline
In-Reply-To: <a29ea047-4935-4893-108b-f29f46971272@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0071.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::22)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2757c380-8fad-4695-94cc-08da6b0675f0
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2305:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5v/BZsigKerDoiSoFHXIQv/Ty4O28h9UR9TdI7jH4j67od6P+wFu3l/IctRX/YKqL+Ksrqy1CCVvQCl2Mv6pVmgkde241byeErBQ88bpQjIeO9zz4pBY2SyZfwmXZ4ERU8PdyWe0rSaCsmoRKCf0nByJVeGfaC72hjOiHgdTcrBOhuCZemG4XiviO7GamSSwaHUfDjO+4rgshABegDHCl/hKs3d4WGM8pEwwLihWRSDptoGdD6yHjDriQSOj917OxAFsatg/zOKpieYgJswUyTsiJcY5yOtu3SJQKK2wRQiHJoxBqgktAIyts6kX+hUBE0nnfOiQ5Gy2spaVMsjM0LxZwCxS1Rt2N8OWDJtFQc8LJIBbEA3ffkkOkK68XD5Zmkr9+5X97IpDQejkz2h7ue+CjPKgsqNiOjg6oLjEMGiI5BahEsXnqyAsGxFpvc5CbZVwoHb0ju9z2slIrzFAZ5ADKATBlcbVfeRjqVF71S8yDrQ1AdCE0vtyB0K+LcdO3p1pJK1RjN0RcCYd+9jOeUFQ5ZqOu1OopmVq/pWeVyyMk4x/5pEbR167o7oDLIngzcR6VIG4HuCgUZPTqsRistzgiGTsSviuXaiLWHJ6EmOvvXhGfDmAccJkSIfCOUy7PKs0QRH5i7BFTTi6iV1R1NcwO7CCm5dw9xOf+h5C1ROvSNpLVq4OVN+jBHh8SF+BOBp6DhCXWaA2BuzEIqfCMZynma4cWgIoVjsJfZmqbHawCfIlsbxEgY3emQY4RfVFwcv1Jtc9AMqtMzP2PZDHlg+uhcF3GpOc8CqsjcLdnPVDDMUQMya9UKiNoVsjLGdLAy9p0VkAwvm3GORhoEi+poiqFdkL5EIwfMoo84oHoW8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(136003)(346002)(366004)(39860400002)(396003)(66556008)(7416002)(5660300002)(235185007)(66476007)(8676002)(4326008)(66946007)(2906002)(44832011)(33716001)(8936002)(54906003)(83380400001)(52116002)(86362001)(33656002)(38350700002)(38100700002)(6916009)(316002)(26005)(6512007)(6486002)(186003)(1076003)(9686003)(41300700001)(44144004)(6506007)(6666004)(478600001)(32563001)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FG4d21e0bkwkEM8nnfmYiiffy/t6yx/hYZrrsr651rw/jtMMabmgk2Py1ZNH?=
 =?us-ascii?Q?5jkXWxs7OLSMLu/VCjQC1Nx32m7B6pnbSHEIPU6pgiFcMVWKG6YibI+St79v?=
 =?us-ascii?Q?MuC7uIfgRMhWn1SmL4RwoVudZ52eAHFqVx0OvObBTe6FcsjvE57YrNbuSrJJ?=
 =?us-ascii?Q?vkAQovfy88d+8cfnVFbUoXPUj82Ot9czdN/1o4mVowXTzgd1d5jwC4sY2bK3?=
 =?us-ascii?Q?86p3LrLUX+eJlsPhUrTythBPBcDYE2e6uaOA7QGd3Vn4g2VVbf5PhjJ9Hasm?=
 =?us-ascii?Q?J6ObMoifBMlm4z4hkLMowJZceAgTLmDDkNx0BD6h1OgvfMkPdMWSct1Fz6RS?=
 =?us-ascii?Q?cCRy852bkAwtmzjo38MAIdDyG+nEdVO6iFbMNOKBQ6uvbnIrBG0P5yOYumiG?=
 =?us-ascii?Q?pF5aOpJDpuoU4hHVGvRylLO/BCWql9JFxs0Vhw8M2VIbKrR5Xu3ZNm6+c0yf?=
 =?us-ascii?Q?uHSBXeiaIoZXqrNdZuagjngORAEYwQPbrkbN/TYW22PXVC08bGP45VhLFRt6?=
 =?us-ascii?Q?HEKSmK6cSDYC42LgC2+iuoMUFUMFEBmv1WcuPW16usGgraIJ8Lk/BIjhJEjb?=
 =?us-ascii?Q?eFYPlPZJ0bc0Y4J0qWW1T0DmIR+sLB/PLMz/CJfk/ZQPHF9cgigxsSDQ4EVv?=
 =?us-ascii?Q?aYCtA4GuRH0STnLVlP0U9hpV1Th7jLMEhEuO5CsGKCeZ/iVtty93RSd4bzY0?=
 =?us-ascii?Q?x7IlNzD7IP3qb/lOmEubtMLSuRv4dN9W2ej2oDt9MEwN8P8sdVtZ09OGJJHj?=
 =?us-ascii?Q?5066EWT+z9BmXdKBlUu4cSZ+z2Zy0H6Ia1r2ILFWriuJM1WItKN61E6FCEaJ?=
 =?us-ascii?Q?5N8/kBU2odpqp9KwNXJZLM73W0tmHGBa/xCumz3jlscXrZmwnFPcdXciyg1e?=
 =?us-ascii?Q?blSqdX2978eVlzc6GVJBnilJ+4a4zSON9Be3Sl2+2aZAb4mr+pcSk1SbDUZw?=
 =?us-ascii?Q?obuwHpq6NJ8UJcEkddgjw0+fQcm7dP4pbYGdi8R+cJ/3VXOFgCJGBC/l5NjV?=
 =?us-ascii?Q?1hl1zEBd6l2404rIOrS3mXIykCBR3gyipq7uQXUWUnSnUp139g9zeRZ4Laox?=
 =?us-ascii?Q?/RDrIBEHXZGXRC6OfyXPXdaEY5VYCm+s7x91dYtXITLkMN1x0HdRfEPFJ7nD?=
 =?us-ascii?Q?yKjvwgUC514yRBEOxUPAnR1S5UeHxz6Fu3B2w9MQ+iZrX+4Y3k+B7oPQewnu?=
 =?us-ascii?Q?JC72bUaUOpBcNctDpBzzEkXmwuBvVGJ5dKAEAXDFrW3RxtqMnPhQMH6QYV8k?=
 =?us-ascii?Q?cAiamhq76CHXeV98lk6Gq3MhSvB06MXaRUrZFYduNPNzcZIp09e4MXQvDTx3?=
 =?us-ascii?Q?tn6pqrEAkk3D4Ut9Ly+y+WfPYm+ePVvB3aeIpH9HvWcqz+eYIvUR0NNFTI+h?=
 =?us-ascii?Q?lndLn6Cs0PENi4qzSTj+iQo47KzS7Dei6aMn3kRuQRt5YB6RmXDOVn3hm7sA?=
 =?us-ascii?Q?CXXAVOjm0vjBsT/rKzr12ibwc5QObC2VP0AJTAEF1URxH6lAzLZr0th8wInT?=
 =?us-ascii?Q?j+2zqwgpH29eW3N2SnkHYKOCBUS8RxTlRn87I1HUlThN/ffKwgjgg/bl0eJr?=
 =?us-ascii?Q?c1KyMUviE1k54VHz5oc95BgcXh4glOVMtrcyW3cCxxv+uXeZvEr2f+a9+mot?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2757c380-8fad-4695-94cc-08da6b0675f0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 10:47:52.4491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UsV7nH91RIelQjOmwjOuUYT0u8iHME09lwqOjoayBNJ6J+bQhNnjRerfpdtNR17HJPQPqHkaycsRPXQfMMbcE/VbBS9rm/6bf1WmIApf8pM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2305
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_14,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207210042
X-Proofpoint-GUID: QC8RBaPBNtzmknOb7YmqHxBUw6d9A4AT
X-Proofpoint-ORIG-GUID: QC8RBaPBNtzmknOb7YmqHxBUw6d9A4AT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 21, 2022 at 12:30:32PM +0200, Christophe JAILLET wrote:
> You could add find_last_bit(), find_next_zero_bit_le() and
> find_next_bit_le().
> 

Thanks!

> > 
> > regards,
> > dan carpenter
> > 
> > 
> 
> A reduced version of mine was:
> 
> @@
> expression e1, e2;
> statement S;
> @@
> (
> *   e1 = find_first_bit(...);
> |
> *   e1 = find_last_bit(...);
> |
> 	[... snip ...]
> )
>     ...
>     if (e1 > e2)
>         S
> 
> 
> (and it takes only a few seconds to scan the whole kernel :) )

Nice!

I wasn't going to be before but now I have to re-write my generic
check to be even more *powerful* than before!  The new check doesn't
rely on known values for the limit, but uses comparison data instead.

(Still takes overnight to run so I might end up sorely dissappointed
and defeated tomorrow morning)

regards,
dan carpenter



--0ntfKIWw70PvrIHh
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="check_off_by_one_capped_return.c"

/*
 * Copyright (C) 2022 Oracle.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see http://www.gnu.org/copyleft/gpl.txt
 */

#include "smatch.h"
#include "smatch_extra.h"

static int my_id;

static void match_condition(struct expression *expr)
{
	struct expression *prev;
	int comparison;
	sval_t sval;
	char *name;

	if (expr->type != EXPR_COMPARE)
		return;
	if (expr->op != '>' && expr->op != SPECIAL_UNSIGNED_GT)
		return;

	if (!get_implied_value(expr, &sval) || sval.value != 0)
		return;

	comparison = get_comparison(expr->left, expr->right);
	if (!comparison)
		return;
	if (show_special(comparison)[1] != '=')
		return;

	prev = get_assigned_expr(expr->left);
	prev = strip_expr(prev);
	if (!prev || prev->type != EXPR_CALL)
		return;

	name = expr_to_str(prev->fn);
	sm_warning("potential off by one check '%s()'", name);
	free_string(name);
}

void check_off_by_one_capped_return(int id)
{
	my_id = id;

	add_hook(&match_condition, CONDITION_HOOK);
}

--0ntfKIWw70PvrIHh--
