Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FC24C4CB6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243934AbiBYRl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiBYRlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:41:55 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6001EBA98;
        Fri, 25 Feb 2022 09:41:23 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id B90521F46598
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645810882;
        bh=g0A6Uimeahydl9ph1AOCmp+Nlt9LsBikz3PaHAbqQik=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=XSq27hNWEmg+dff4RWcqF8uRjKG41+rebGEt6dY+bVLIfhgB+/s8dF0ew02+wVCdk
         ImnWiIpzlCJ2dwbhkJdxIVhdOijT52QuSb0hQJi8SKJ5CN+WUN453G3UGp+tGrPfyp
         KKJbcfr6e/bm5/DN4G7Y2UhloQAFDkuHGRT9+N7HQL1EdvBvfXIB5nz2WcC57NZG1r
         eIRkDZpyCmBVQeSR1lRZff/YAu8P35X3CZAa7P4t1TW91vN0F6512w52raITKS7uoY
         0Iz3cf7kzwuuAfx4xe2DOoYXIfQ3mge13nLFrPSsrc+/boy69ArNkgOCz1V7iMWFmF
         O5BFwY9hygLXg==
Message-ID: <98ef3e84-e17e-d1b9-5109-ec631d77905e@collabora.com>
Date:   Fri, 25 Feb 2022 22:41:14 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
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
        open list <linux-kernel@vger.kernel.org>, mkl@pengutronix.de,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
References: <20220128170722.1624767-1-usama.anjum@collabora.com>
 <cb4db484-c4e6-9cf9-baa5-0be454947ed5@collabora.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <cb4db484-c4e6-9cf9-baa5-0be454947ed5@collabora.com>
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

From:
https://patchwork.linuxtv.org/project/linux-media/patch/20220128170722.1624767-1-usama.anjum@collabora.com/

State	Under Review
Delegated to:	Hans Verkuil

On 2/18/22 4:08 PM, Muhammad Usama Anjum wrote:
> Reminder.
> 
> On 1/28/22 10:07 PM, Muhammad Usama Anjum wrote:
>> ret is constant in imx8mq_mipi_csi_pm_suspend(). This function cannot
>> return error. Remove the return variable. Simplify other functions which
>> are using this function.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Changes in V2:
>> Removed fixes tag
>> ---
>>  drivers/staging/media/imx/imx8mq-mipi-csi2.c | 16 ++++------------
>>  1 file changed, 4 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/staging/media/imx/imx8mq-mipi-csi2.c b/drivers/staging/media/imx/imx8mq-mipi-csi2.c
>> index 3b9fa75efac6b..c992b845e63d1 100644
>> --- a/drivers/staging/media/imx/imx8mq-mipi-csi2.c
>> +++ b/drivers/staging/media/imx/imx8mq-mipi-csi2.c
>> @@ -693,11 +693,10 @@ static int imx8mq_mipi_csi_async_register(struct csi_state *state)
>>   * Suspend/resume
>>   */
>>  
>> -static int imx8mq_mipi_csi_pm_suspend(struct device *dev)
>> +static void imx8mq_mipi_csi_pm_suspend(struct device *dev)
>>  {
>>  	struct v4l2_subdev *sd = dev_get_drvdata(dev);
>>  	struct csi_state *state = mipi_sd_to_csi2_state(sd);
>> -	int ret = 0;
>>  
>>  	mutex_lock(&state->lock);
>>  
>> @@ -708,8 +707,6 @@ static int imx8mq_mipi_csi_pm_suspend(struct device *dev)
>>  	}
>>  
>>  	mutex_unlock(&state->lock);
>> -
>> -	return ret ? -EAGAIN : 0;
>>  }
>>  
>>  static int imx8mq_mipi_csi_pm_resume(struct device *dev)
>> @@ -742,15 +739,12 @@ static int __maybe_unused imx8mq_mipi_csi_suspend(struct device *dev)
>>  {
>>  	struct v4l2_subdev *sd = dev_get_drvdata(dev);
>>  	struct csi_state *state = mipi_sd_to_csi2_state(sd);
>> -	int ret;
>>  
>> -	ret = imx8mq_mipi_csi_pm_suspend(dev);
>> -	if (ret)
>> -		return ret;
>> +	imx8mq_mipi_csi_pm_suspend(dev);
>>  
>>  	state->state |= ST_SUSPENDED;
>>  
>> -	return ret;
>> +	return 0;
>>  }
>>  
>>  static int __maybe_unused imx8mq_mipi_csi_resume(struct device *dev)
>> @@ -770,9 +764,7 @@ static int __maybe_unused imx8mq_mipi_csi_runtime_suspend(struct device *dev)
>>  	struct csi_state *state = mipi_sd_to_csi2_state(sd);
>>  	int ret;
>>  
>> -	ret = imx8mq_mipi_csi_pm_suspend(dev);
>> -	if (ret)
>> -		return ret;
>> +	imx8mq_mipi_csi_pm_suspend(dev);
>>  
>>  	ret = icc_set_bw(state->icc_path, 0, 0);
>>  	if (ret)
