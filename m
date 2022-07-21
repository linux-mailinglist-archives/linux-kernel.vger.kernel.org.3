Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B20357C90E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbiGUKdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 06:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbiGUKdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:33:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06484D125;
        Thu, 21 Jul 2022 03:33:52 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LA5sBO004022;
        Thu, 21 Jul 2022 10:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=CnSIPAxDebxmRerI8YS75NLA1Y0+UVBa3B2dTUXWCYY=;
 b=NG1ckIrG2mv7AhCaVLA6PtPuXDU45aGORO15BQDSBgA+hdwXvAmaxG8fhWF1z2ntABJB
 LIstesZ5SGRPT9vkONiiexZGPiH+mHedPOhitJUczQa3fd9/KDgyR9ePWa8sxpCFj6u4
 0rJym6JlJEvx0h/fKgqILozrMSMiwZcB3QV3L1NkIIaAvDidsp+ZIbNptoFiw14RmEq5
 Ax4iQpvby1PG9qqxpMouX6yhsiz+wr2qmdvCS8EAD/SSTPqh6CkA4oCdtYOkm+8L9ypk
 JDkrWbbk2UF1uURl3TwMW0H9KecVewIyOgJFPhzZjFgr5aMKvq++cqZ+aUlrQurfWC0n 4w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx1464g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 10:32:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26L8Za5c022226;
        Thu, 21 Jul 2022 10:32:29 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1htkw1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 10:32:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIsF+hNeaPM4iLDe3xPNohNCeIwgaIQ4SA1gBPMchdjpi1DIJ7JY4SzRHTHoA2ac9kqAzIRKz8awI+ddfoRXn4tFO010r4bbmuT/VeOnEK6ACb65JzBZUCE7uEaaA4KDCilaN/OvU4SXb10o6nIvqXIjLsyM2+fgV3ge+Aw58S9bxny+wg8Uo3wCJ8ztuGisQ7pw/Z4ra7U0c+NDl00R9z5bzpocWjKeJIBM6SQDLBEPsQ0W8aeSt6d441NoJ/+tb4JmUfHQS0dlrcgG/qRHaRjUtHfZR02U9PqpPIx27gUjFML4bGIqxDVNnHXOxNWZ9/5x67Aop9vf5XihkTAFpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CnSIPAxDebxmRerI8YS75NLA1Y0+UVBa3B2dTUXWCYY=;
 b=K/msI6+kJ4rpoSvhRD4zR90J301+wu9O39FE3haHgUPqnF6foM7MX3d3xinIHkcyBGFe5bfKvSS6nUgg3mFkgy8ThSpQiLnfzMbW6z9uCLyc7RCnAV8z9drgN76xS362fbOVhaqDa5jdGDgsMqMlAlFencWBN66bDNrlqJA6mn6UdApF2VQvLdikcaZS3kQ0cLAYRPg4vZasa2DjBP8WG0Pepd4kwf5KZgZG91O4d+owvFWZSQ7ZWA/1R6wHMw0V5z0cO+UhSiyH60J5aLygbFEsx8kYNf84Op1CGvPED8GrG1keTheBdojluPWnoNjRoj7Iwgz9Fhn7IrSgnBZ0zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnSIPAxDebxmRerI8YS75NLA1Y0+UVBa3B2dTUXWCYY=;
 b=m40GmomUlxaUgOy7AH1ACy3FQcHfrxE+0gPxM3CiX2fGkcO2CScvTGqfN5fHxOWG2q5IbGYVcEdJUpyEazoowZY62KDtlbX4Cu39ktAbpWXv0Wod/QYw1W6XuJFu5nVbouQhb8ear3IP5KvBD1/QhB6nfUMlDL8m6CUinRZyFd0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4644.namprd10.prod.outlook.com
 (2603:10b6:303:99::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 21 Jul
 2022 10:32:22 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97%4]) with mapi id 15.20.5458.018; Thu, 21 Jul 2022
 10:32:22 +0000
Date:   Thu, 21 Jul 2022 13:32:03 +0300
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
Message-ID: <20220721103203.GJ2316@kadam>
References: <0fca3271649736053eb9649d87e1ca01b056be40.1658394124.git.christophe.jaillet@wanadoo.fr>
 <20220721100042.GL2338@kadam>
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <20220721100042.GL2338@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0014.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34d8c282-162d-401b-83fc-08da6b044bb7
X-MS-TrafficTypeDiagnostic: CO1PR10MB4644:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3LXF1Gqrua9WMOjhhIEFEyUOf7Ha6sKzLXp/u6AQbwdO/KT25UStT7jrTUjcCNle78q7tyGD5dqwFRWt4pJJn4B6Te3ZqMX4S89VRIcshnyEtgt5QwPrv97cYAripbPeeXh/JM8VLGq4rsFaCchnMbB8glnYjIg9U4gCbBu1BOyfuiJYngavbNQR79K0eF3GBpBXRDqz6dbrYcC0dBoxvcIsqlF0n1Esf9izUIbQMv240MXwRQiOvy6Cki4Su7+SGCYonplBJF/qD8niYBzKVMfe3xw3ZbgdFD2lDfANNVnWm7L5rQ9lYfR5hmjSEqEmycNcjWqepNz5X2JSi05cFetXpDoapqu4xAPA6RoDPLgcM4K7OCPGpmHn0zFoU3vV7bKDhZxesIVmqTePR/wHQ19rtnWOn6rTddC8loG2rWaZkbJ9subNNKD1a0v5twduh9ItrEsxiwqtkShKaz/WcvfcQhuittJxeGM8vDL0rucmPDOeXMSVS0zVr8snghsLkREvyzwIUdrEjkv49WE1AzsygbXtIc6M5Nub54JKkNbq80WDYEOPOBzAhzLAFoCsRtCX2WzB5MMmnsWiR0O4TW/9Q44VKPGgQa1iN5jT7naaCjqDLUJ/Xl5d64PFNUBUM797/8F5CUY+diTC4navhmSPSzmjBsLqcdT6lixnNpXt27Hk/7Px6y7hMmLD33TEFf/UOGDyAX9XzAlw234WYnczexpoPkREALyCGZvQcbIOYrR+jqHhatVcuuxLJ8jSc5pK7IFoZIRaEK1FyAOZeX1g0GZTJmkwcxxEDh+XCw1T6eH/fVZrWEpVkZYPGYBWO8yViKb24vV7RdH2BlVXYlHYpFc2w7oEZg9uEQYT3Rw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(346002)(376002)(136003)(39860400002)(366004)(186003)(41300700001)(44144004)(6506007)(52116002)(33656002)(26005)(2906002)(6666004)(107886003)(1076003)(6512007)(38100700002)(38350700002)(9686003)(86362001)(33716001)(7416002)(478600001)(316002)(235185007)(6486002)(8936002)(66556008)(4326008)(66946007)(66476007)(54906003)(5660300002)(6916009)(8676002)(44832011)(32563001)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dknl0Tcsfd6uxIF25V243xjQcDCTXK9MJJplZ9ekMJpNy9dY0bXUs4Gsv+D9?=
 =?us-ascii?Q?3wCmwjdkFx8xppyDstx3AB1XhJUxKvSBbWrAgaVzX0RzMCNzKxdgr9z81f0t?=
 =?us-ascii?Q?78WPRYnhWxkpYzdneU7FW3WvVjgki1AIFL9jCmAOqnAXs5gWRRr7idCSYBLb?=
 =?us-ascii?Q?X5p8MPd0314x+jc7oJ/82nohkRXNIkSnO7IZrwesW2nwcEpAuZlioZLxLY/w?=
 =?us-ascii?Q?RrIS6LIjyAVtPpk6dttmTqzP0Yigm84CNyMuiyJ98WdBTIqye7kfV0RHJ+R+?=
 =?us-ascii?Q?P1Da+/2GYoqDdAezCsI9HFXNyOGJ6SvJ0s8z1u+dgda3S/htIKaRisa3mRBW?=
 =?us-ascii?Q?uiZnWMLfM5lMG9rYbFsOcZiSw6PrXjPTJPQwq9qv5MRVNNxabo7eiJbDCuGR?=
 =?us-ascii?Q?tRrTYsRwvFa+I42ptr5nKAnvsyp7LQC4KhXyALgHLUjl66Og0Bu2aUpL8sCB?=
 =?us-ascii?Q?wRFlFIDhxA0WWXjJU7Pf8RHXExjb3ncsjiFZXSKOo11zhI2sanzrGw6kOMxs?=
 =?us-ascii?Q?KQyekirvYmYDPjI9P7PfxywBEXkYaRb61cvZRVH1CbM6NavPXrJ9s6UDQf1A?=
 =?us-ascii?Q?F5YUmUMlQ5EPLOd6rI9hk/OAVjknceawBhTKZZ4EwHusQgrFcWgM02Y8JiM3?=
 =?us-ascii?Q?lPBbOg6OGza7gkQggE4/qwzOWPe/adgBfIuEEW3R0wleZkZz3jamI3pDEgLc?=
 =?us-ascii?Q?GDxiWCRpMgVQEM/UdTxO2ogovtj8kc8vAAI/GfOuC30rvYJDxVHyxmS9MSl1?=
 =?us-ascii?Q?RGZhaECtgjZJoyxwtsxo/+bZypfMHNoCkFBk+PZ9wcoFtgoIQ6K4UqqGbtDf?=
 =?us-ascii?Q?AL/bRjspfwgn+U276Z6RppAOmnJ7nfYyEhSx/tU/w1H2hwQhr00jLtg2+ON0?=
 =?us-ascii?Q?wX/ySeepGLVT3iA8cMM/p+rnds9GrYsEU6OiCKIzU3zk6bJq7/+6oIg+nozS?=
 =?us-ascii?Q?AYNKfyfUHeiP4YuFpQK05HLvKDUAW9f9P40PzZq+rpEnNR8SHm7Uc1ut0N/9?=
 =?us-ascii?Q?K3JrGIdEKcDG8pkMdeAS6s0u/XFTKEad6eA1jfeaZ7NonsbWiAghzHY4O4Hb?=
 =?us-ascii?Q?Hwljq47MeAGhXcaWuyngmlgGiiw2caV5urFgRmSK7KNqCxc5Fm6ZVi1kDlHI?=
 =?us-ascii?Q?/qlBUmS0/bz6lDExBxjpZRIEQXLVPNw9kD5lpJ8tI8JEo80JlBFGrUNXKRKG?=
 =?us-ascii?Q?uOcoMODoS4Dgl8xhTtgRBQBS1KFteOqPD5xn4DdHWGYZXeKJC/lGZ9tw+IZW?=
 =?us-ascii?Q?IK6Z88zlCCpAfK9/L/pV+ovYBR0bWaBvV840qgWcFfJJ5JjB0P1VCPByJLYL?=
 =?us-ascii?Q?D5LFR+d2ZvHbgLWW8C+y+sVaem52n9rjLJUnWm9rlpeRYE9Gxdl22ReoAMWZ?=
 =?us-ascii?Q?YoSscPV22WKtJIz5u1zK5hdlanl6E4fx5BboZCNZVzEqgDXOW9Zph6QUay6R?=
 =?us-ascii?Q?lFT1MvDax5Sg9q077TKp/FErA9XZoczjcPVNMcW2T7LG8V/L4f/8tlaKhed3?=
 =?us-ascii?Q?5MIITgk9LAAEwfTfTsnk5uxwEK46jSvxBXQkrsCjPT4mRkAsJi6m/MOkmeix?=
 =?us-ascii?Q?WNHQO0TRBSQK4tybAFqM7r+mKQ3FEUe06II1W/yjQ/gOIfTCXOV5cQouvbK5?=
 =?us-ascii?Q?ow=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d8c282-162d-401b-83fc-08da6b044bb7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 10:32:22.5236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eI2wgQCFgbjuqwqU6L7PJWlPiZ0QBLN9Mmt3Bn9csvp4AiLUgRRxdes+Oyc4O1rbTyZTVvCFa0mi2ySth3SO2oqp4dxm0+0BZjNH742kP54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4644
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_14,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207210041
X-Proofpoint-GUID: s4VFL6cH8YiLFaJh7PvWzlV_uoxLzkT8
X-Proofpoint-ORIG-GUID: s4VFL6cH8YiLFaJh7PvWzlV_uoxLzkT8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 21, 2022 at 01:00:42PM +0300, Dan Carpenter wrote:
> sound/soc/qcom/qdsp6/q6adm.c:220 q6adm_alloc_copp() warn: impossible find_next_bit condition
> 
> I'll probably try to make this check more generic

Attached is my first draft generic version.  There are other ways I
could have written this, but I'll test my first draft and see what that
looks like.

sound/soc/qcom/qdsp6/q6adm.c:220 q6adm_alloc_copp() warn: potential off by one check 'find_first_zero_bit()'

regards,
dan carpenter


--+HP7ph2BbKc20aGI
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
	struct range_list *left_rl, *right_rl;
	struct expression *prev;
	sval_t sval;
	char *name;

	if (expr->type != EXPR_COMPARE)
		return;
	if (expr->op != '>' && expr->op != SPECIAL_UNSIGNED_GT)
		return;

	if (!get_implied_value(expr, &sval) || sval.value != 0)
		return;

	if (!get_implied_rl(expr->left, &left_rl) ||
	    !get_implied_rl(expr->right, &right_rl))
		return;

	if (rl_max(left_rl).value != rl_min(right_rl).value)
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

--+HP7ph2BbKc20aGI--
