Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A0B4D3801
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbiCIQvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237873AbiCIQk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:40:58 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981FA70F55
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 08:33:52 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 229ChahE025200;
        Wed, 9 Mar 2022 10:30:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=5p9dlokEkB0sYsrc9fOvTc1J5T04pBFuBWWS+FlOuYM=;
 b=fDW5v5bEuOn5ZRJKZ54qCUsh0X01/+9fAFAGK91fs+EaS/ymSL3/qeyG05XSqn5rE8bX
 g6Sge4ijTiLE1ajjz/SDYSCOUuPr4Js6GGj/UBDeNgd5q1DMGC7h3WmtxNvEL3FhRywc
 ghn+DX7RK4U7MkvxTZfdGqwZOL1i9GHZc0XSJGuvr8tSDmvB9bDP4maMKcZ99FAHsypA
 drSlgFRL7rsmXuHy+8VzXMvauC5Dev/R4wWI6DhlPi7/AHzpzi52U0fRv+pMgvX5hw2n
 skNTf1VRv4ksuYvCjW8uf8J0CkNxRvYqxuHlQ8IRncjRk4vwWxfeE8HvDRffBKBx758L 3w== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3em656nwq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 09 Mar 2022 10:30:50 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Mar
 2022 16:30:48 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Wed, 9 Mar 2022 16:30:48 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 026CF46C;
        Wed,  9 Mar 2022 16:30:47 +0000 (UTC)
Date:   Wed, 9 Mar 2022 16:30:47 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Simon Trimmer <simont@opensource.cirrus.com>
CC:     <broonie@kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: wm_adsp: Compressed stream DSP memory structs
 should be __packed
Message-ID: <20220309163047.GJ38351@ediswmail.ad.cirrus.com>
References: <20220309130017.2816-1-simont@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220309130017.2816-1-simont@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: c9fV52yxDRZ7L-UVldX0dtYbvo2KBf-A
X-Proofpoint-GUID: c9fV52yxDRZ7L-UVldX0dtYbvo2KBf-A
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 01:00:17PM +0000, Simon Trimmer wrote:
> The compressed stream code has a bunch of structs that are used to
> represent DSP memory but have not been marked __packed. This isn't
> safe, they could get padded on a 64-bit build.
> 
> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
