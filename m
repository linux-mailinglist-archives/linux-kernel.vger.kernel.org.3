Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEE949B3F4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 13:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450382AbiAYM1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 07:27:23 -0500
Received: from ewsoutbound.kpnmail.nl ([195.121.94.167]:38926 "EHLO
        ewsoutbound.kpnmail.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448671AbiAYMY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 07:24:29 -0500
X-KPN-MessageId: bb7be0c6-7dd9-11ec-8226-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id bb7be0c6-7dd9-11ec-8226-005056abbe64;
        Tue, 25 Jan 2022 13:24:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:from:to:subject:mime-version:date:message-id;
        bh=dolYya/a860xjT4wUBYK+PxeDQUA6/qNUXyKqrOAog8=;
        b=W06r8mjFLwPAe6bDZVcIeUq310tutvd4hfcRyC0fSVoPFBwm3qaj62q64xqieXVvFwONShcZPaBLQ
         B5KxL3S11TaFWxT+kOOHUpHvUUb/FrpLDAgFQmzjwHyD3QTbfwdFWGN4smibT2yI5CX4ouBe3FXng7
         lB3w8BAjlwlDlzOLW5Op74lJ+7DsuMVNUY1xoGSbxonJyJM1U1uL5uTVC8edvSM5ByEEkulxV/hnfY
         xrmz2p6/BBPTPLMGugBDctv80URDr6sbbvuhvuWVAWrFEA83R/fXZzyB8nErTXjhXusyB7UN0V/Nat
         l+8E1vG8t+dR968BAfjuV6KDgrZdUpQ==
X-KPN-VerifiedSender: No
X-CMASSUN: 33|ztIXQRl/g7NziXQTlSZ6TbQDjImAN7jwv0bG2jJ3G2XSlDcKttdmFVV5dixB+oz
 19NFh5ulxy5bERUAqqjsehA==
X-Originating-IP: 80.101.105.217
Received: from [192.168.1.10] (marune.xs4all.nl [80.101.105.217])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id bc1e48a9-7dd9-11ec-9812-005056ab1411;
        Tue, 25 Jan 2022 13:24:26 +0100 (CET)
Message-ID: <7e49399a-beb1-9dda-8bae-b715162f4fb9@xs4all.nl>
Date:   Tue, 25 Jan 2022 13:24:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v15 12/13] firmware: imx: scu-pd: imx8q: add vpu mu
 resources
Content-Language: en-US
To:     shawnguo@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ming Qian <ming.qian@nxp.com>, s.hauer@pengutronix.de
References: <cover.1643077283.git.ming.qian@nxp.com>
 <8717d91000002047c7d0925f5eae66fc7f795e27.1643077283.git.ming.qian@nxp.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <8717d91000002047c7d0925f5eae66fc7f795e27.1643077283.git.ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn, can you Ack this? I think it makes sense if I take this one through the
media subsystem.

Alternatively, if you prefer to take this patch yourself, then let me know.

Regards,

	Hans

On 25/01/2022 08:11, Ming Qian wrote:
> the vpu core depends on the mu resources.
> if they're missed, the vpu can't work.
> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> Signed-off-by: Shijie Qin <shijie.qin@nxp.com>
> Signed-off-by: Zhou Peng <eagle.zhou@nxp.com>
> ---
>  drivers/firmware/imx/scu-pd.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
> index ff6569c4a53b..af3d057e6421 100644
> --- a/drivers/firmware/imx/scu-pd.c
> +++ b/drivers/firmware/imx/scu-pd.c
> @@ -155,6 +155,10 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
>  	{ "vpu-pid", IMX_SC_R_VPU_PID0, 8, true, 0 },
>  	{ "vpu-dec0", IMX_SC_R_VPU_DEC_0, 1, false, 0 },
>  	{ "vpu-enc0", IMX_SC_R_VPU_ENC_0, 1, false, 0 },
> +	{ "vpu-enc1", IMX_SC_R_VPU_ENC_1, 1, false, 0 },
> +	{ "vpu-mu0", IMX_SC_R_VPU_MU_0, 1, false, 0 },
> +	{ "vpu-mu1", IMX_SC_R_VPU_MU_1, 1, false, 0 },
> +	{ "vpu-mu2", IMX_SC_R_VPU_MU_2, 1, false, 0 },
>  
>  	/* GPU SS */
>  	{ "gpu0-pid", IMX_SC_R_GPU_0_PID0, 4, true, 0 },

