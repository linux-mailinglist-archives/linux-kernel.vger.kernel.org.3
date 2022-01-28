Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E6B49FE95
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 18:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350402AbiA1RBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 12:01:14 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38294 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350394AbiA1RBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 12:01:13 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id D8AC11F46392
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643389272;
        bh=HcvGQIq3fvQYfjKx8yTy+bAX9ZDUMawBDHbxMWj950E=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=DxSLK81NgXLNHJdDzNjkSeN6KC6c+7RJmMh02ayrUFsCCU6kYJ2O1EhAhSkbMTLk9
         fH1+qyCaLHEQRZE3Wk10iew8DQrLfd2IWFAR/G3tQzUftJzWEyvZg+98h1MI7vITSu
         ARsacZ7SN96lfy6dIc/cObMGtxW0Hccye88uE98Zu2YSmmtHXMUq2PA0McIhuoGPr7
         yTOAOmovRfB1jlojgKnCPN4v2nimKHwvLedNoAfu+/PvuQqcgsRZUv2bbfII0XaHyg
         xJ3LEMR83OTAEB+5+FLa6DKKz36gIAWY+vgg8ckvDMQuMnWja3FlDHfoakpkyK4O3k
         2XYjihUlGIo8A==
Message-ID: <ab0b6146-d8ab-b9f5-4dea-99849a0f5ee4@collabora.com>
Date:   Fri, 28 Jan 2022 22:01:03 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     usama.anjum@collabora.com,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Martin Kepplinger <martink@posteo.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>, kernel@collabora.com,
        kernel-janitors@vger.kernel.org,
        linux-media <linux-media@vger.kernel.org>,
        linux-staging@lists.linux.dev,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: imx: imx8mq-mipi_csi2: Remove unneeded code
Content-Language: en-US
To:     Fabio Estevam <festevam@gmail.com>
References: <20220128133649.1393201-1-usama.anjum@collabora.com>
 <CAOMZO5DaNpZbO2JS7KUOHJLAZNqpnY_ub8H_UF2sSHuQp-Ki0g@mail.gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CAOMZO5DaNpZbO2JS7KUOHJLAZNqpnY_ub8H_UF2sSHuQp-Ki0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/28/22 9:23 PM, Fabio Estevam wrote:
> Hi Muhammad,
> 
> On Fri, Jan 28, 2022 at 10:38 AM Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> ret is constant in imx8mq_mipi_csi_pm_suspend(). This function cannot
>> return error. Remove the return variable. Simplify other functions which
>> are using this function.
>>
>> Fixes: f0c2ba1ed4ad ("media: imx: imx8mq-mipi_csi2: fix system resume")
> 
> The patch looks good.
> 
> I would suggest removing the Fixes tag though as this is more of a
> clean-up rather than a bug fix.
I'll send a V2.

Thanks,
Usama
