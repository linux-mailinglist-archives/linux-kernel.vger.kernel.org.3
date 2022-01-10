Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08AB14895A8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243491AbiAJJuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:50:20 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:51258 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243329AbiAJJst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:48:49 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20A6juY7030824;
        Mon, 10 Jan 2022 03:47:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=eRYDLyz+LPBq9MDS7nPUbIBLRnqZnHufAJrzcP4C2OU=;
 b=O1BkUNvMs9zYY86WUIZ4Dq8MKORm0FP2eZBDm+1K1T2YrTwINHgUUIkRk4ReNX4z+YfW
 ro6wgB6hgEiHbr9g11h3mwSBec+Jg/AJ9PD1UjHJswuX/MHUjtKrkvtjYT70Jm2mCu8n
 qOPlXfBjSd4sXm4PwRZW4pnMvz1yuoJP7QvG/2iyfa6grpmX4MY+VarpHI6Lextu4srF
 MI3j3yDMaxW3pjnJsGufo2xMYOQyhBUUYT8AMWEnKSI2V5Hp0b5Ks99fb7UvjHha+Izr
 ykwKkfydaTsb12fxGqQxcaPvayUzS65o1IB46yF/xj5E9UjO08cZ/ykxdvplkUc5lXkf xQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3dgfear4w4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 10 Jan 2022 03:47:56 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 10 Jan
 2022 09:47:55 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 10 Jan 2022 09:47:54 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DC54646D;
        Mon, 10 Jan 2022 09:47:54 +0000 (UTC)
Date:   Mon, 10 Jan 2022 09:47:54 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <cgel.zte@gmail.com>
CC:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <chi.minghao@zte.com.cn>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] sound/soc/codecs: remove redundant ret variable
Message-ID: <20220110094754.GI18506@ediswmail.ad.cirrus.com>
References: <20220110012833.643994-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220110012833.643994-1-chi.minghao@zte.com.cn>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: sVZkMFJizHY_rDKXA1PCi7Yin1kOoQdp
X-Proofpoint-GUID: sVZkMFJizHY_rDKXA1PCi7Yin1kOoQdp
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 01:28:33AM +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Return value from devm_snd_soc_register_component() directly instead
> of taking this in another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
