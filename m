Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97FC59F616
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 11:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbiHXJSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 05:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235794AbiHXJSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 05:18:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A54783BEA;
        Wed, 24 Aug 2022 02:18:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01605B82380;
        Wed, 24 Aug 2022 09:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77E3C433C1;
        Wed, 24 Aug 2022 09:18:32 +0000 (UTC)
Message-ID: <5fcd86a3-ac30-3544-4ea6-4072f0c83ccb@xs4all.nl>
Date:   Wed, 24 Aug 2022 11:18:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] media: Fix comment typo
Content-Language: en-US
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220715051532.29742-1-wangborong@cdjrlc.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220715051532.29742-1-wangborong@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Duplicate of:

https://patchwork.linuxtv.org/project/linux-media/patch/20220722064105.70610-1-slark_xiao@163.com/

I'll drop this patch. BTW, same issue as before: the subject line suggests
a media-wide patch, when it is just for the tm6000 driver.

Regards,

	Hans

On 15/07/2022 07:15, Jason Wang wrote:
> The double `the' is duplicated in line 1300, remove one.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  drivers/media/usb/tm6000/tm6000-cards.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/tm6000/tm6000-cards.c b/drivers/media/usb/tm6000/tm6000-cards.c
> index 98f4a63adc2a..b7842cd6f9af 100644
> --- a/drivers/media/usb/tm6000/tm6000-cards.c
> +++ b/drivers/media/usb/tm6000/tm6000-cards.c
> @@ -1297,7 +1297,7 @@ static int tm6000_usb_probe(struct usb_interface *interface,
>  		le16_to_cpu(dev->udev->descriptor.idProduct),
>  		interface->altsetting->desc.bInterfaceNumber);
>  
> -/* check if the the device has the iso in endpoint at the correct place */
> +/* check if the device has the iso in endpoint at the correct place */
>  	if (!dev->isoc_in.endp) {
>  		printk(KERN_ERR "tm6000: probing error: no IN ISOC endpoint!\n");
>  		rc = -ENODEV;
