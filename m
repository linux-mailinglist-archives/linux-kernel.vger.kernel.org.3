Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C8648AAB5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 10:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbiAKJlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 04:41:35 -0500
Received: from ewsoutbound.kpnmail.nl ([195.121.94.169]:65055 "EHLO
        ewsoutbound.kpnmail.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiAKJle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 04:41:34 -0500
X-KPN-MessageId: 1361e7e9-72c2-11ec-9abf-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 1361e7e9-72c2-11ec-9abf-005056abad63;
        Tue, 11 Jan 2022 10:37:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:from:to:subject:mime-version:date:message-id;
        bh=wx8es6Sa9R3UcDRmVMXh+J0gt+hanItmvkh9hiFzidA=;
        b=qYo5XO4K2Rjo1gOKwp8+6anqIIHeXCM4fT4PnYe8fwqVKbF7/yYwYk6DqEj8XyeARArmH3VCAubTX
         dETR3OjSJ47t7NAAk5yfCwCisPJATBm6hlUv4kOSaQ5lJjn0VKMw06y3ALjgt8sohvJWh0X4zOhxhv
         QEQCuMn+VEOg5uJpcjcEckMMlgqKpO4y+eymQ7hF22/HrKQzAqgosxx226/wJZYPcInVLSP8OPNSfz
         +gJmbKzv9WkuyoHJtgEh/7TqrxBI8rX6KjZdygZqkcgZQUHNxqgamLIn2N6829o93OLcA06zklDhnQ
         dbPN3IK2C3rLYuSMjtuM80AFkn8L09A==
X-KPN-VerifiedSender: No
X-CMASSUN: 33|7RRAhfMlvMNJYg11WBWh7fsEFhTdvaun8Tj9AkDLsTb9IYq39A8DZ+a5JS+cLx3
 p5cmT2Dey3IeL1KENajadWA==
X-Originating-IP: 193.91.129.219
Received: from [192.168.2.10] (cdb815bc1.dhcp.as2116.net [193.91.129.219])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id a9071312-72c2-11ec-94d2-005056abf0db;
        Tue, 11 Jan 2022 10:41:33 +0100 (CET)
Message-ID: <5fd4efe8-2fa2-d691-adac-8c9272555d86@xs4all.nl>
Date:   Tue, 11 Jan 2022 10:41:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.1
Subject: Re: [PATCH v2] media: platform: Add brask to the match table
Content-Language: en-US
To:     Zhuohao Lee <zhuohao@chromium.org>, mchehab@kernel.org,
        bleung@chromium.org, groeck@chromium.org, levinale@chromium.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211221095326.383055-1-zhuohao@chromium.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20211221095326.383055-1-zhuohao@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2021 10:53, Zhuohao Lee wrote:
> The Google Brask device uses the same approach as the Google Fizz
> which enables the HDMI CEC via the cros-ec-cec driver.

For future reference, please add the driver name in the subject as well.

A patch with just "media: platform:" as prefix suggests a patch that
touches on many drivers in media/platform.

I've manually updated the prefix, so no need for you to do anything.

Regards,

	Hans

> 
> Signed-off-by: Zhuohao Lee <zhuohao@chromium.org>
> ---
>  drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
> index 2d95e16cd248..8c8d8fc5e63e 100644
> --- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
> +++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
> @@ -215,6 +215,8 @@ struct cec_dmi_match {
>  static const struct cec_dmi_match cec_dmi_match_table[] = {
>  	/* Google Fizz */
>  	{ "Google", "Fizz", "0000:00:02.0", "Port B" },
> +	/* Google Brask */
> +	{ "Google", "Brask", "0000:00:02.0", "Port B" },
>  };
>  
>  static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,

