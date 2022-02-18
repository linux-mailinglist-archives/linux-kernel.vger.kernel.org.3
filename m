Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C4C4BB7B4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 12:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbiBRLI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 06:08:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbiBRLI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 06:08:26 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AD22AE73A;
        Fri, 18 Feb 2022 03:08:10 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id B2A481F46751
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645182488;
        bh=MWH+/EKkY4LjLqgJrcKLJ7r78Z4lhuUmpr0kon7qvkg=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=Wj0tW+9GkMa6s8+StqasaD8bQ8GVceX1XiW5s2yWmvR2d1+xqNFU2ZcOa0w0tvhqW
         v7Z1Do5WOb6zUvAs8pgH9XXkRymc3slhIvm6juwFLlJVhInMN81yyJ6Y9dudvZm14G
         nYceNqcWFNOWBtQKNOcgter2/OJEdb5wIYZ0wgM9TXTNGznBCcPOmiUEuwb2p4hPJr
         CbyqbQdgJJ8MAchJj9Q3bnkKEbMITkSnJYFFnoeU54yWOtPtlFZQC6vleB2HrD422L
         4sS2ZIT5rRK67K8c7z1Ygh5Yury9IVnEVo1D53+PwEzBuDMTsOFH+Ll2YjRBA74Zse
         F47n4UsVbNI4w==
Message-ID: <cb4db484-c4e6-9cf9-baa5-0be454947ed5@collabora.com>
Date:   Fri, 18 Feb 2022 16:08:00 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     usama.anjum@collabora.com, kernel@collabora.com,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH V2] media: imx: imx8mq-mipi_csi2: Remove unneeded code
Content-Language: en-US
To:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:MEDIA DRIVERS FOR FREESCALE IMX" 
        <linux-media@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>, mkl@pengutronix.de
References: <20220128170722.1624767-1-usama.anjum@collabora.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20220128170722.1624767-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reminder.

On 1/28/22 10:07 PM, Muhammad Usama Anjum wrote:
> ret is constant in imx8mq_mipi_csi_pm_suspend(). This function cannot
> return error. Remove the return variable. Simplify other functions which
> are using this function.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes in V2:
> Removed fixes tag
> ---
>  drivers/staging/media/imx/imx8mq-mipi-csi2.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/media/imx/imx8mq-mipi-csi2.c b/drivers/staging/media/imx/imx8mq-mipi-csi2.c
> index 3b9fa75efac6b..c992b845e63d1 100644
> --- a/drivers/staging/media/imx/imx8mq-mipi-csi2.c
> +++ b/drivers/staging/media/imx/imx8mq-mipi-csi2.c
> @@ -693,11 +693,10 @@ static int imx8mq_mipi_csi_async_register(struct csi_state *state)
>   * Suspend/resume
>   */
>  
> -static int imx8mq_mipi_csi_pm_suspend(struct device *dev)
> +static void imx8mq_mipi_csi_pm_suspend(struct device *dev)
>  {
>  	struct v4l2_subdev *sd = dev_get_drvdata(dev);
>  	struct csi_state *state = mipi_sd_to_csi2_state(sd);
> -	int ret = 0;
>  
>  	mutex_lock(&state->lock);
>  
> @@ -708,8 +707,6 @@ static int imx8mq_mipi_csi_pm_suspend(struct device *dev)
>  	}
>  
>  	mutex_unlock(&state->lock);
> -
> -	return ret ? -EAGAIN : 0;
>  }
>  
>  static int imx8mq_mipi_csi_pm_resume(struct device *dev)
> @@ -742,15 +739,12 @@ static int __maybe_unused imx8mq_mipi_csi_suspend(struct device *dev)
>  {
>  	struct v4l2_subdev *sd = dev_get_drvdata(dev);
>  	struct csi_state *state = mipi_sd_to_csi2_state(sd);
> -	int ret;
>  
> -	ret = imx8mq_mipi_csi_pm_suspend(dev);
> -	if (ret)
> -		return ret;
> +	imx8mq_mipi_csi_pm_suspend(dev);
>  
>  	state->state |= ST_SUSPENDED;
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static int __maybe_unused imx8mq_mipi_csi_resume(struct device *dev)
> @@ -770,9 +764,7 @@ static int __maybe_unused imx8mq_mipi_csi_runtime_suspend(struct device *dev)
>  	struct csi_state *state = mipi_sd_to_csi2_state(sd);
>  	int ret;
>  
> -	ret = imx8mq_mipi_csi_pm_suspend(dev);
> -	if (ret)
> -		return ret;
> +	imx8mq_mipi_csi_pm_suspend(dev);
>  
>  	ret = icc_set_bw(state->icc_path, 0, 0);
>  	if (ret)
