Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4B25231FD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 13:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbiEKLmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 07:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbiEKLmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 07:42:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F08724218D;
        Wed, 11 May 2022 04:42:16 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BB5inB024475;
        Wed, 11 May 2022 11:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=vJg8mEiRXx7C1rj52k5E3SEcpn7jeG0A/G4rmIGjxLY=;
 b=U5QY3GtyPIbsEgW08ShOyyJs1+MnDN1X/FAistYZCmgdnA96tNtgmLMxcWi6E1KAJTEp
 G6MUczWuZHrXAWpgc5/jYQPWbFNyYSE546y+t8X8v+cUzc0IRu7euQ0cMZj5t4hXNLnv
 q6ffUPLGfXmmpIa/tc1Foep/1UICrgwX2vZmL1Bgnb/3xL6f6yUsrIdnDiD7D4OIgGC6
 NIFS7LoKg1r7WogqtFaehwkspWA2/9EZ3xKuAWqIHUGZyOefRjRaryu8tFft5Os8xUyk
 qyPYej8KUpniAAYESbveBXt9IhShQk84NnvBxV2byOveOR3AmDssHdkKmWLRdPeVhs0Y Mw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwfc0setx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 11:42:07 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24BBZ8rT031229;
        Wed, 11 May 2022 11:42:06 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fyg6ep3u9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 11:42:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7s1o8BEmdbVo24Xdyqb8DTrmJEtz3qLU8kWscqAMpv8wZVZLY8ZGALb4Bz0Lc4KZgQUGVburrTtkoxooJRImYSJWpZWpS/LEPkis8g8HtWDB8Q/L+aPahWZWjTwmsvKcGzVcyFicDSaVfa1Dko6k9muZkX6gmVprE5t8S+SmC7Y6P5/ZkkG54dzIBEokS8xZ6kO/WdYuOY8Vc1knJR/a49tX05dHlrZKOiras9BobqdFOVQMM0qrTta+e6CIcTV3GGY5AueP+lkKi0efhtPNpV50QsihprdiSkBp1BOJLlDs4V1fVpI00bQZAY/9wh9+kUQS1G7nxbSBbg3bSKuBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJg8mEiRXx7C1rj52k5E3SEcpn7jeG0A/G4rmIGjxLY=;
 b=a7pDJENC4W2/TbqLejYUqgC8GanCNX/xvHc8poS1SGmpObz95ebwzjR4QICNz90BpAi0a3YijZBqoVM1EVG3iSEX2+Pz5jBn/hzGV49/tiB01ceGi7g3XXF6ylQ8TjE5p0UojlY88d0TeTu3nrUUDrfdTgaEywQ6Y96C4LaWUSOmvOb+O9RDv+dEql/WzMntiNjQ9WLy9netOONfDyVScWDlzmI52yA4NiXD6nw4X387KIQEMOEaPf5TQFBWGNNelLaKEr6PR1DUSRfVY8PDpWICjMoX/mGTpb51dCCLfKs+ryFQs4MhImZJEwcwQyYXVpqeP+VEywf3cjlZhwckFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJg8mEiRXx7C1rj52k5E3SEcpn7jeG0A/G4rmIGjxLY=;
 b=DwfpoMJs2cwnc3SZeqGgrpNuK0/Y2/z0nOMGGT2jjQ4eeDEgEtZEV2SoebCKh3vf6HVOUIanG/1WFOpV53q6rFmTDJrR2I9GspUch0q//EqmcteYLy3Lxdn1VLLyFtLszzEHc59VkDcQe7XgwQfYe/enF6emR5ZHj/TVk3OSt6k=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB1868.namprd10.prod.outlook.com
 (2603:10b6:3:10e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 11:42:04 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5250.013; Wed, 11 May 2022
 11:42:04 +0000
Date:   Wed, 11 May 2022 14:41:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] test_firmware: fix end of loop test in upload_read_show()
Message-ID: <20220511114139.GH4009@kadam>
References: <YnOm+9tEN+xerpov@kili>
 <YnPFh6ULhhPloue2@bombadil.infradead.org>
 <20220505130251.GV4031@kadam>
 <YnmXhaSMqi5k7KV7@bombadil.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnmXhaSMqi5k7KV7@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0024.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b0727de-9a15-45bb-853b-08da334344d8
X-MS-TrafficTypeDiagnostic: DM5PR10MB1868:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB1868E37F464E9C682B86A3E88EC89@DM5PR10MB1868.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gakWPX050ptpoORROc5ylJIR8U+WWV0Pz0Cl5BvDRuzBdNqw7jYpX5zEHmyglvFXXLVo8m4HZw7KvOgsvv37S9HskQ41qEI6NAWrV1+NoOandu7HLEAAnGBqPH2Kad1zVWtkIuD/f5+Ps8gnLsMG9rQVsWaszFzBUsOinUsbU3XI54nFQCpWz96BKubmMWyHbbMp7VwJgpGamVRwTGVA0InNTXfV4ntn+AenCOBccJ1WADvESGb7mnueSYT+x5u/ZPN3UhLDbXj+s/cvnZ6ItiMyzSff7P/f6TtpypPgSZf5GMBXK3QRQ2OCUc5U2bIDO8NMSHeHPg3cYSwIOZlE3lrhPsew3VXfUKC/3NHt5ccU4KJXLFT1x0C61wOCvp3d9pOs8W+fYGwAPZcNbkH7OYU4Eh22mCeP4OcVSWdDZOsDDQ/XZnIpn56v5/ahPUh6hQRcP42xFZ21G9CRVTsYeWq2eNgMcsrG+wlWJiNwEh231M7DmpOJ+8DsR804/B9+Kn8DBNBQT8yLfEN62fmG6/VnTqkMrfBlWxh4FE63kRd4MbvxzAIIitRl0efYODQP3L2ZN93Ry3AjJbAHODzWCbVQL7lug7x9indnJ47Qhj3cyq6OzvrXtj4Wajx/CS2+qEsJ89hYmM5p2Uc/C49tdwVZ2yI50qVBs1jiiZI6ShsmODxLTFQhn+eGGHUju/Yl4+yefcNEVq6Y5BhPUMYyZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(1076003)(9686003)(186003)(6512007)(26005)(8676002)(33716001)(8936002)(44832011)(4326008)(66476007)(66556008)(66946007)(5660300002)(33656002)(316002)(2906002)(110136005)(54906003)(6506007)(38100700002)(52116002)(6666004)(6486002)(38350700002)(508600001)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vv+mfKmKOmV3EdExjGeUVaLuXffyArpxkrsnsUvpDi3S7ttSLPpezwvBReWR?=
 =?us-ascii?Q?kHWIDxj46K4jQGGpNlfpcrcsAGrHcD7TEW9C+aFc9PKycAf2yWq7DHcx1w36?=
 =?us-ascii?Q?DW8JVDSCZqcsJ5Bk0PmbpXrJvys1GAe2RyGVBDVl/emZWrbl/ddvl7P5uIpq?=
 =?us-ascii?Q?8FMsBGCcteOeelUUqYk4mvgWyHouA6R5yrBtRTgWSsODa/9OLymE2j8VKENm?=
 =?us-ascii?Q?2lbz3ERwW53Ng1mtAR7fEomfoCXuECbnaHiJvczAwhoj464cSZHajQHDXjEz?=
 =?us-ascii?Q?V0UndUfVNTkK7dmqnlZUq86Y/pToxb9ykr0fCDCHBkQ4xOyKImcBr0Ff7zV0?=
 =?us-ascii?Q?zzkaivZjkk0TgW8oIQkEvRXIy6q3N3cHjSuiO6Yk+jRMgq/Q3dv5yXamG0P0?=
 =?us-ascii?Q?QZwdBnFsreT+LhO5lTEeVfSccz2oQllBFLyZbvBjTaiHOMnifboLnMv8wSge?=
 =?us-ascii?Q?klRx5QgXV89tgCP+GmG4XTRkEEFbDNO8R972cgzlMf4KGYHck4yC7YZD/wrQ?=
 =?us-ascii?Q?XMeHeDOwzu6yTNbTSsz6lNrjtyOYX2WYm3fzqrrLfTKzdjMZbflmUf/MuBUA?=
 =?us-ascii?Q?00iIul1IaVuXZ7nD2+dkjP60+1upzgIiSQ8Ks7l/je/c1s/2q1YqXFyRHYxw?=
 =?us-ascii?Q?faTS//NJZRKaso+LeCVU00HiHUYZbWiPj/j7H5CrVW9XGcKiWnL2MQd1hUR9?=
 =?us-ascii?Q?GKbIkzwsoP0VNk/MaLe5tmrwDIpFJiLyCapgLJkZSPOMXtuc1UuhNUqgT0Kd?=
 =?us-ascii?Q?d88PmpFX+9SSnh69UdeWzuNFQhQMuXfpMpir+GExOmNLdGNuGPn+w3XfELty?=
 =?us-ascii?Q?lJNQYBJQlAjFU2Vw23UWLhAWUAjizadHcz8PBLKedd4CQq6SjNroZcH6K0Nf?=
 =?us-ascii?Q?ifASyIfPbj3WJ68maYJVvvnpBgQroCXS2oijq/1+Ce51meEJSc4s+8v0f8ew?=
 =?us-ascii?Q?VsMf65Um0gZR0npOo54KYz3siNJMropKuUmhnJALtxDBw0TS3F34HS1PaU/1?=
 =?us-ascii?Q?v4DmsrTiB6Kf3gjrgycSkmDsl9IbbQZlIEVY8dahwHTQ+CUXOgUwIH/2+BGo?=
 =?us-ascii?Q?oNzsWMV8JJbuYWDKlypVQj0hphjo9e+0zeZ2jo/KXNI99cZZgbWldYbLxeBt?=
 =?us-ascii?Q?ukGaPfRo+Po4DLYu4UzyL7ReOFEIyP8L2zXoP6JTu02g2Qq7h4m+2W4Dpy8+?=
 =?us-ascii?Q?aOw6giy3wGb1Taz/af1y3P6awSklwTMYsqupYat2cBTIdpBDI07FB8+m3Azh?=
 =?us-ascii?Q?ZoLPP1Myf1AQow0+je1y0JLGoJg/AkaFnUryaAwmtcWqAX/6Xe6qrD0a5tGZ?=
 =?us-ascii?Q?C77EAI5KS9t2PWljnu149lGbIa97XgFY1YpdAdAHqwdqRWhG1oVb2YwRGfu7?=
 =?us-ascii?Q?bZkctg7oR+ds8AkcNo+QSiSCzGoU6UvvDytQ417/zTty7tw5FqfcZsduC3PO?=
 =?us-ascii?Q?NOIb014D0oLJirEVe1yYs9yS8Hmm0nzotRsZBZ805NdF3M/3Ys86CfuzPgiI?=
 =?us-ascii?Q?uwQ6sDlmaK77ERCt3OXBMb+A5ULbaHdl3K/CDlTWZwVeMuI9HgzhkiUvsek5?=
 =?us-ascii?Q?tl4rVEXCMj9fF5GtdZfRuSEXAKWZHuz0mhxn/6iIrI11xh07vz90FvN8yp+S?=
 =?us-ascii?Q?R7dU4II71BWTFFgGVobzjX85zOd1hIRRvukY2ERJ9+dwZKHmNzb5sw9a+wpI?=
 =?us-ascii?Q?DhYe1ruDo+bEek3NO/+hcvkIxn6VXCG8gZ58AftG1mtzQf2fO5cWVSr+gxEQ?=
 =?us-ascii?Q?S6T2wWa+F5KZkqG1XbLWA8cm1uJzJW4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0727de-9a15-45bb-853b-08da334344d8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 11:42:03.9087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dtduV55Ao12qe7SZMQ2VjbHgH4vKEKpT0UiMGVhB5z3nuoj9QC376d6dIj1g7k0D/JsJgtTgDJQfxvqeQechq6bMUj7tFYFY92dKbHN0KRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1868
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-11_03:2022-05-11,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110053
X-Proofpoint-ORIG-GUID: VIFZ9Y4knJD1QDQyWFshHYXnTXKhc16u
X-Proofpoint-GUID: VIFZ9Y4knJD1QDQyWFshHYXnTXKhc16u
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 03:36:53PM -0700, Luis Chamberlain wrote:
> > This test is reading out of bounds.  Another fix would be to write it
> > as:
> > 
> > 	if (list_entry_is_head(tst, &test_upload_list, node)) {
> > 
> > But there is a desire to make it impossible to access the list iterator
> > outside the loop.  Linus was drafting alternative list macros but I
> > don't know the status of that.
> 
> Fine to get these fixes merged, but it would seem test firmware
> would be low on the list of places to fix. Either way I'm happy
> for this to go in.
> 

I'm just fixing new static checker bugs as they are added, but you
made me curiuos to see if there were old known bugs still.

The following functions are still buggy:
wd719x_interrupt()
nvkm_clk_ustate_update()

Most of the others are Smatch false positives, but some are a bit tricky
and I'm not sure either way.  I marked them as false positives if the
author seemed confident that no end of loop test was required.

Bugs:
drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c:489 nvkm_clk_ustate_update() warn: iterator used outside loop: 'pstate'
drivers/scsi/wd719x.c:691 wd719x_interrupt() warn: iterator used outside loop: 'scb'
lib/test_firmware.c:1408 upload_read_show() warn: iterator used outside loop: 'tst'

Tricky:
drivers/net/ethernet/mellanox/mlx4/alloc.c:379 __mlx4_alloc_from_zone() warn: iterator used outside loop: 'curr_node'

False positives:
drivers/usb/host/uhci-q.c:466 link_async() warn: iterator used outside loop: 'pqh'
drivers/infiniband/core/mad.c:968 ib_get_rmpp_segment() warn: iterator used outside loop: 'mad_send_wr->cur_seg'
drivers/infiniband/hw/hfi1/tid_rdma.c:1280 kern_alloc_tids() warn: iterator used outside loop: 'group'
drivers/staging/rtl8192e/rtl819x_TSProc.c:260 SearchAdmitTRStream() warn: iterator used outside loop: 'pRet'
drivers/perf/xgene_pmu.c:1487 acpi_get_pmu_hw_inf() warn: iterator used outside loop: 'rentry'
drivers/perf/thunderx2_pmu.c:814 tx2_uncore_pmu_init_dev() warn: iterator used outside loop: 'rentry'
drivers/gpu/drm/vc4/vc4_dsi.c:769 vc4_dsi_encoder_disable() warn: iterator used outside loop: 'iter'
drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c:111 nvkm_control_mthd_pstate_attr() warn: iterator used outside loop: 'pstate'
drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c:283 nvkm_pstate_prog() warn: iterator used outside loop: 'pstate'
drivers/gpu/drm/panfrost/panfrost_mmu.c:203 panfrost_mmu_as_get() warn: iterator used outside loop: 'lru_mmu'
drivers/net/wireless/ath/ath6kl/htc_mbox.c:107 ath6kl_credit_init() warn: iterator used outside loop: 'cur_ep_dist'
net/xfrm/xfrm_ipcomp.c:246 ipcomp_free_tfms() warn: iterator used outside loop: 'pos'

regards,
dan carpenter

