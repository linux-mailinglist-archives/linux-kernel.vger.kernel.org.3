Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B011855DDE7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236818AbiF0OLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236811AbiF0OLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:11:46 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6646513EA4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:11:43 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25RDY9G6019791;
        Mon, 27 Jun 2022 16:11:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=Gu+lu0nOeS2h5e8b9+9qnEX+bLJApI7K4L9CihF4g1Y=;
 b=0Y+X//JhipgODKq/QA3DnFlaBKhn9LdT00V4QpYUL6gPMcsKQTvZTGjPFrA/3PeyPDIk
 W3k2W1ruDu0EqYdehm8hxYbHoikdx+CCdgvYK1A7PGy9UAfMgdp4EFPg79nxCzDsEuMD
 +sR4aFcQduS0dlT+W++0vQf55UHoJhtfF6BPcHUu8loOcc/E6qSvTgfMOD85MCpSewOk
 nU2kgxD8Dyfu+X33NgdxcLXSztLURiBarlzBmd+QPsaYjsNU2GiFb+8d0iT7Uip/nxrj
 1/zNCxnXUB3ylDaDx3+Ol+v4O4BJUhSdQft2QbL1hSmR9TXdG0r+PMK9xQ1uhtQr5nhK wA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gy9mr1qtm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jun 2022 16:11:35 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2FB3810002A;
        Mon, 27 Jun 2022 16:11:35 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2AE98221770;
        Mon, 27 Jun 2022 16:11:35 +0200 (CEST)
Received: from [10.48.1.86] (10.75.127.48) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 27 Jun
 2022 16:11:34 +0200
Message-ID: <dd288fc4-9a30-936e-6724-4ab869a735a6@foss.st.com>
Date:   Mon, 27 Jun 2022 16:11:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/stm: ltdc: remove error message about scaling
Content-Language: en-US
To:     Yannick Fertre <yannick.fertre@foss.st.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220603134250.592408-1-yannick.fertre@foss.st.com>
From:   Philippe CORNU <philippe.cornu@foss.st.com>
In-Reply-To: <20220603134250.592408-1-yannick.fertre@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-27_06,2022-06-24_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/3/22 15:42, Yannick Fertre wrote:
> Remove error message about scaling & replace it by a debug
> message to avoid too much error.
> 
> Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
> ---
>   drivers/gpu/drm/stm/ltdc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> index eeefc3260c07..a4098aaff243 100644
> --- a/drivers/gpu/drm/stm/ltdc.c
> +++ b/drivers/gpu/drm/stm/ltdc.c
> @@ -1215,7 +1215,8 @@ static int ltdc_plane_atomic_check(struct drm_plane *plane,
>   
>   	/* Reject scaling */
>   	if (src_w != new_plane_state->crtc_w || src_h != new_plane_state->crtc_h) {
> -		DRM_ERROR("Scaling is not supported");
> +		DRM_DEBUG_DRIVER("Scaling is not supported");
> +
>   		return -EINVAL;
>   	}
>   

Dear Yannick,
Many thanks for your patch,
Applied on drm-misc-next.
Have a good day
Philippe :-)
