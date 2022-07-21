Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A9557C87D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbiGUKCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 06:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbiGUKCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:02:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557762AC9;
        Thu, 21 Jul 2022 03:02:21 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26L7gXSr002199;
        Thu, 21 Jul 2022 10:01:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=oVYQD9aj4HbrkOChfwJmC02zeQ2aS2bsNteqVGYQ0pM=;
 b=HfUAyNLHO8yhjApnxbsgb/gP+5aytASXMtZn5peHtvm/Thy8zJEe8VSz2kMDHc5LiEMZ
 O4lIrp1Er5DTxz34HF7KD9xJJEh84OZt6eYw0OmO/aR8+HaiApRqOydItw1U+jwFYc2C
 7BSL7DjaVtoEt1RSCzX5dZ0Ea+Sqaa9do4xRGyzrOV6qPkJ3LYCrZOoACtWtG73RVnUX
 xmi2/1Qde0fNOMZ7bQZt79ynQpKjKf+83FD+U0j0UezK+uYORPkoDHl5GBMaOWKKTKZy
 HYDu9WOnjHcRjSI3hUswze4HMRmAqVAZ536SWIthISqtfffHU01bq7QER7AscPD7JVfl IQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkrcbryt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 10:01:05 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26L88vwg016401;
        Thu, 21 Jul 2022 10:01:04 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ep7f0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 10:01:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HutSSg9wTm0+xYocjivPyLJO0jdUXBnmwGvzZzOOhxg0w72L4F7hKy/6q+d3okGimyAhwgF5/412GPC0N0KwSzP3bDtfm+5mAJPMg/8FXNF6uTHwgTIpxVT9iereQSbgV0lfwc6chyhGGRyI9/yvl0FrI6TR5BcEgnPyh8kLz9EI8YyXXJDoya3jFR82PA1FM64VEsxJdIFuhmLYJ3s0jI45+MAwXVOExQYYj63nOhIINeCVSwYXxDx9R6wW8swFrJIICr08hnthMTUydg0j6orebN0+6uQme0vUDJ7B5DuJwIhkIokiIqucBtETvLHkcmJP8XNuEURcYJFE+FuO5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVYQD9aj4HbrkOChfwJmC02zeQ2aS2bsNteqVGYQ0pM=;
 b=OB+ikJkYMUBmANlP5gBMsP9ZoAZDvep3ruSEIPAVJo7pU6W92I/ONVLlmfS2dYQlrlhcA30R52jIM5dZbzAxDH3VQkNt1pzYBq7/7Pg7CGZJIvW7R08Z20DfFPe9OV0BCCR2L00SI5Tom5XwKsEuHuAFqnLR+/C0SeUaO0MFyuuK/do+Rm9GRt5Gsdlp03vaGYnU0z/tdn9OwDFNT5rq6o5YojJ58QEsZo6iyTf3F6yDvVPmiWvXJvbtgTFGGqExBjqDng4qooPgMBeg9bwDcZaWlOWb2e+s1Wl4bhh7Ojfc78QYMkRL5fvApIp/7Xty9hyqXm9pvebSrlt5+4hsvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVYQD9aj4HbrkOChfwJmC02zeQ2aS2bsNteqVGYQ0pM=;
 b=FSqy4cHJDfoZFTYwP7SIJC8/oPRxu/21KadMOpPbRpRSnWyG7SBJNotG5EDjfCTOqpKQsPS+58y3e4xTK8SR0QOtb+c26wI9+lrB2wOm/XtXep1SxAF3XX+Ig2Nw59nnQer+HP7tQT5GI5laN4zz/jCCX1w63efgTOyAcmvF8fI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR10MB1410.namprd10.prod.outlook.com
 (2603:10b6:404:46::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 10:01:02 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97%4]) with mapi id 15.20.5458.018; Thu, 21 Jul 2022
 10:01:02 +0000
Date:   Thu, 21 Jul 2022 13:00:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Banajit Goswami <bgoswami@codeaurora.org>,
        alsa-devel@alsa-project.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH] ASoC: qcom: q6dsp: Fix an off-by-one in
 q6adm_alloc_copp()
Message-ID: <20220721100042.GL2338@kadam>
References: <0fca3271649736053eb9649d87e1ca01b056be40.1658394124.git.christophe.jaillet@wanadoo.fr>
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <0fca3271649736053eb9649d87e1ca01b056be40.1658394124.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0022.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::8)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b559103-c1a7-406c-e6c9-08da6affeafb
X-MS-TrafficTypeDiagnostic: BN6PR10MB1410:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WQtxFDehchCHbjE5t+dKLi27nLoHtBEdA9hcR2Z8Qwh8BlkGZWuD+oP79ovLva7qllcY4a2X1NnHfpVnsuTDHzgMBiPftcxoP5Nx28G1H0LKioJ7zvjGIAUw6DR9wr/tLfVI0CLIRWYgcmXKEdV4La9RyC/rqgTY0eyghwGxp5XuGkPEHEQoEaDUNGWTkiayJ1oflH4mUOmx5kl1hlmIOgLfi80YzGOQfjlEXtPXb5cmRbocpSJDPLfl5nwOkC0gFWTAgCtylfUugCXvgivhip1H42DEuBkPnEeRPtWDnwuPMBrg4xh87kRC4W6T86Qdc92q7UMcirVsARQMstuEzY70M38v+658aHwfhH8Z9iVCX3sx5ivynX1poqRn1LbTiNBvfsov+a/zK5w3VRTbuj/gRyc6+7DtD6ZGRMBjwcdEn9UdVg/l2Djki90ZbrmW/brJKHySZSQ/jPuk5+/vrOEhRkmer60CoXMmTRNQ4AW8CdNteCUGLfNyliqJvF4GM/HHSBBziR5WaFAyejY+NquI+I9RTfg8LarugtbXEIiyy8ih2PDj7DajQPjJvWirBRrZ+Atg4EJgrqiCSjrvNJ7LynaAXTbdbleXn19NC5FOWaXamUH8KrYrxkOTG9/UtZnolcPax47+BeiZ+Tq0pPbDtq01DHAfgpbyD/SeZrxqa6nx/fZCPV3Ed/9og9HVTsXTykPHP08zCwkrXowDk8rKnpY823lEIehAetUi1unwevqWjqjHSR2KbBT48srLbPQa2sDLqU2majyVPQu3pMBgrXVhhpq5y8i8tGZhBiHkDvQ7RoR17o3Qemj4Re1WUl8YzDuRAB22GkHyyKA5b5BcU/ocf0CmtkOrVdPwhsE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(396003)(366004)(346002)(136003)(376002)(6486002)(6916009)(316002)(478600001)(41300700001)(6666004)(54906003)(235185007)(33716001)(2906002)(7416002)(66556008)(66946007)(66476007)(8676002)(4326008)(44832011)(5660300002)(8936002)(86362001)(83380400001)(38350700002)(107886003)(6506007)(186003)(33656002)(52116002)(38100700002)(44144004)(26005)(9686003)(6512007)(1076003)(32563001)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ar+fmNu7e+BE58q/yy3i2JFmTgk1Y3tpVBksgz9zuNO9BkhtenSnbuOExkzi?=
 =?us-ascii?Q?zUuoksvZobE4ocfKgvoVce79H+TphWom1toTKbOyOiBNr4yfA8b8+CskR6WB?=
 =?us-ascii?Q?VUbfmrg9ERXUJcwo0TFMOjC/NUi3/r1m9sgrNo3TMZMnwSp8Pg9gFRhMInCh?=
 =?us-ascii?Q?f++0PmmdDjWg2iFzN9F2PAmkvD9fC7Rcfv0fVHfQSukfZXbnjhIQ7VFRQTd4?=
 =?us-ascii?Q?3Rg5XzL0dy6cif6rl4m8GVZtHzk2bGJZR/5CKfIaSzuA/46Tz3Uo00Rpz76g?=
 =?us-ascii?Q?LeELNwlm7HF4IgjDzJzo6NebEGi8pIuw0ihM5Bz0n0LzX7+H+b0MHtYkb2/a?=
 =?us-ascii?Q?Opqwsmq+XOwyKer/C0/heza161sCtihlE/Q3X2Xz/pfpXMxfOz2WZA1GPqAQ?=
 =?us-ascii?Q?eR4V/Umo5YZQ45YGNQeo5QUVm+yeGsQ4nJ3RHCCDi5n1lS5ItJTyi8XXu9eP?=
 =?us-ascii?Q?G0kKWPJ6PcgNpS8y4kAKGMYFYrYhZPNNrjan+k1cg0DNDJwvbg5oVtNUPTUB?=
 =?us-ascii?Q?cLUTiCbjkMjId6XA70uZEXIVMRYBClYqLu+MVty5SM0SQ2GcpZbaiYoVjRIO?=
 =?us-ascii?Q?SbskPetgJmyyNd8XaMU/NgoE5E8B9G1vtTP6uMaQmHi0RxaWkHwltnV7qF5R?=
 =?us-ascii?Q?y+pRCORDtU4HiTEGYA8Wlb2JIl5o29GXZjQ4Ra1dSgcE48pa4PWyrWnjVtCb?=
 =?us-ascii?Q?9ncXqyF3jJduwO7HxnmPxfyiUFV2vQRrBS8DJHadn7R8sDPQnJMSJegLBONU?=
 =?us-ascii?Q?Uujf/bW4GfWV78zSbYnbgkC5qMFfGVWlW3DP8aoH6Vk7hZ+J2FO6L+wByYak?=
 =?us-ascii?Q?9ityxsVU0EWzpey7yEtp/7MMikOYLoxMNQEQFxEPFLvjmbBOLy93ADLr/QPJ?=
 =?us-ascii?Q?Ggp/WIjM4ecJVtOwp3Q4+SFndWbC2/sC0zEYi0Wl/GyXeKnl8YXcBiBWtxIu?=
 =?us-ascii?Q?wSJ+XnnKaaMlj6r/YmjuVemLQuX3rzmh0PTnvlTJ9XhoWsvb8TP6Xp3aNHxW?=
 =?us-ascii?Q?ERR9Slak/2zmcZZrPBt7A8jRb6/jC7FSPErSNdszpk9uIK6e7vZ7i1enxwMS?=
 =?us-ascii?Q?vetJdhfuW7tI+LKXf8ekZQq+4AfU2+Tm7eHGDNX7Fh8KsSer/miiFopr6f+i?=
 =?us-ascii?Q?S69FKWf/MkNagr3ROQYDN8bxJzl2kNr5HO8IZ7R3qKENYANq4zWP7cePn46/?=
 =?us-ascii?Q?pTjDCQ6XO/pxArsrbO6n/Re8+eC4n1TPPuo0TqE5c+Gjplle8atW754ansU7?=
 =?us-ascii?Q?jf3xm6Nb0/0DrHZ+4M7H4Z7mY8B5DCRIlB1udSVAEs7gJdbt8zwiSgdpSg4X?=
 =?us-ascii?Q?Bqbf4H6QdFZyVTqXIIGHy4IIAG7CkLN2K+lPyCFdLqvyWSTeDpaLxIeyVCfD?=
 =?us-ascii?Q?+IhDSdqys1DBFnSgfenzerl0POY7JAErzhfwepcWZ2UX9L0NFaloeeZKbdSD?=
 =?us-ascii?Q?9saqoMsTRn5meUF5hoSzYreTeXsUMBmd3EuJu4+y1bFw0EpC1okixD9s2tAk?=
 =?us-ascii?Q?qmKnjgfxFYFWEpcKdL2DxbEnKzW2J4UFaQzn7u3yJqILaZmtrHydF9Lqlwrm?=
 =?us-ascii?Q?L9OgpXrhg9vKn6LidM9o+2Mt5vs3LLf+eyS7bomkbcC4nxHf46IcN+6IzWB8?=
 =?us-ascii?Q?bQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b559103-c1a7-406c-e6c9-08da6affeafb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 10:01:02.4021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rjh7lD9wFuWQb6myghu1JVzoir0BuzxK+8jnJ2by2ynrWArmJz53h4YngBl2bTd0zU3iukELpPxsmQie9bs+s0qfiMxjylqUgjMCPJHMzQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1410
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_14,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207210039
X-Proofpoint-GUID: QjmCfoYC0xulcMJTHscAGdTnxDpKDt4Z
X-Proofpoint-ORIG-GUID: QjmCfoYC0xulcMJTHscAGdTnxDpKDt4Z
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 21, 2022 at 11:02:22AM +0200, Christophe JAILLET wrote:
> find_first_zero_bit() returns MAX_COPPS_PER_PORT at max here.
> So 'idx' should be tested with ">=" or the test can't match.
> 
> Fixes: 7b20b2be51e1 ("ASoC: qdsp6: q6adm: Add q6adm driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  sound/soc/qcom/qdsp6/q6adm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6adm.c b/sound/soc/qcom/qdsp6/q6adm.c
> index 01f383888b62..1530e98df165 100644
> --- a/sound/soc/qcom/qdsp6/q6adm.c
> +++ b/sound/soc/qcom/qdsp6/q6adm.c
> @@ -217,7 +217,7 @@ static struct q6copp *q6adm_alloc_copp(struct q6adm *adm, int port_idx)
>  	idx = find_first_zero_bit(&adm->copp_bitmap[port_idx],
>  				  MAX_COPPS_PER_PORT);
>  
> -	if (idx > MAX_COPPS_PER_PORT)
> +	if (idx >= MAX_COPPS_PER_PORT)
>  		return ERR_PTR(-EBUSY);

Harshit asked me to write a Smatch check to prevent this bug in the
future.  I got his email before I got your patch.  :P  Attached.

sound/soc/qcom/qdsp6/q6adm.c:220 q6adm_alloc_copp() warn: impossible find_next_bit condition

I'll probably try to make this check more generic, but even the simple
find_first_zero_bit() version will probably find bugs in the future and
it was pretty simple to write.

regards,
dan carpenter



--ikeVEW9yuYc//A+q
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="check_find_next_bit_off_by_one.c"

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

STATE(next);

static void match_next_bit(struct expression *expr, const char *name, struct symbol *sym, void *data)
{
	set_state(my_id, name, sym, &next);
}

static void match_condition(struct expression *expr)
{
	sval_t sval;

	if (expr->type != EXPR_COMPARE)
		return;
	if (expr->op != '>' && expr->op != SPECIAL_UNSIGNED_GT)
		return;

	if (!get_state_expr(my_id, expr->left))
		return;


	if (!get_implied_value(expr, &sval) || sval.value != 0)
		return;

	sm_warning("impossible find_next_bit condition");
}

void check_find_next_bit_off_by_one(int id)
{
	my_id = id;

	if (option_project != PROJ_KERNEL)
		return;

	add_function_param_key_hook("find_first_bit", match_next_bit, -1, "$", NULL);
	add_function_param_key_hook("find_next_bit", match_next_bit, -1, "$", NULL);
	add_function_param_key_hook("find_next_zero_bit", match_next_bit, -1, "$", NULL);
	add_function_param_key_hook("find_first_zero_bit", match_next_bit, -1, "$", NULL);

	add_hook(&match_condition, CONDITION_HOOK);
}

--ikeVEW9yuYc//A+q--
