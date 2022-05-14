Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C87527113
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 14:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbiENMxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 08:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiENMxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 08:53:31 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F151A048
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 05:53:29 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ba17so12948992edb.5
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 05:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=+PHsJAsxfIYg4xwedDRPY7xnEkVYsM8huaRoMxz3pGY=;
        b=bes8OpNqBC8DPPjhYngv8u49A17S2jY6EnkAUTc/afpw3YRAQUk+w1/d54OKCNIiG9
         TdDbZ3hMpqVqpKlkF58AxbfICfA7c14gm107cKHcU56EPHhhEfw0Sh+OG/0Uf2+Owilt
         gSwy3LBwWJRqaTE/9tSP7zB7z6Fooo0grOjsWbyHTeS/DpQ84lCmo+q89xVGLU72/Jfr
         KQOwU63SmTuWjK4et7Ie/o5w01tbAUCrN5a/0jwnQSIA7a8pePoVBpwUPw1fJLrFPEmG
         GTCAT7YAs+E7h0XrQysqafHvrVj9aaGqZ2eNGEcrwRbZtTsxE5cRbjwfvItxfHWFex8W
         CSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=+PHsJAsxfIYg4xwedDRPY7xnEkVYsM8huaRoMxz3pGY=;
        b=fFv5TYeh5QnXIstIIAfHtJB/dEwDY0P5/iuwuOKnIOgngKsqnBpRmV/IpDnaqgsy+M
         jcRtlY3KgNgthpmZr2YAbo0ZFf+zUbGepjopFeDAnx4aacwjky1BOG/aOD01xB+lvILB
         Bmd5YIyamyll37ksSHbdb9HzJBOEXZqCMnpHTKdFFvG/tX+WAm7N+z7EgkHpgqD5K3qk
         pF0UZZtq8zf7xjCQUkk4xZgx+7c/Kk5uucl4QwPqcQidBDWZY1iVkf7N8J7q6/Knaryw
         E8QzbyWrFmwWupkaa7tE3QK6TZvBYK3oxG/RunlK68HnfZlKI/W8Uaz79RjpwmuuL5zq
         ldxA==
X-Gm-Message-State: AOAM530rc5sbxhQwxBwARU5eYQuLt9P6LPy0D3uW+trjDuAwWHUleUGs
        88ukMpfGLOvBqx7cYTQm+Zmpt3PFAgY=
X-Google-Smtp-Source: ABdhPJzs53UAKqlCr3ga0yC8k1tXg2BNA85u9//TvuJIQUt3pX26UFJHPQu3AJFJl01Cwka2aYtgmw==
X-Received: by 2002:a05:6402:51cb:b0:428:2617:64ba with SMTP id r11-20020a05640251cb00b00428261764bamr3584008edd.135.1652532807802;
        Sat, 14 May 2022 05:53:27 -0700 (PDT)
Received: from [217.132.235.78] (CBL217-132-235-78.bb.netvision.net.il. [217.132.235.78])
        by smtp.gmail.com with ESMTPSA id ig25-20020a1709072e1900b006f3ef214d9fsm1721342ejc.5.2022.05.14.05.53.26
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 14 May 2022 05:53:27 -0700 (PDT)
Message-ID: <627FA604.2010302@gmail.com>
Date:   Sat, 14 May 2022 15:52:20 +0300
From:   Eli Billauer <eli.billauer@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     Zheyu Ma <zheyuma97@gmail.com>
CC:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] char: xillybus: Check endpoint type before allocing
References: <Yn9XwHxWsLIJXlHu@kroah.com> <20220514114819.2773691-1-zheyuma97@gmail.com>
In-Reply-To: <20220514114819.2773691-1-zheyuma97@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/05/22 14:48, Zheyu Ma wrote:
> The driver submits bulk urb without checking the endpoint type is
> actually bulk.
>
> [    3.108690] usb 1-1: BOGUS urb xfer, pipe 3 != type 1
> [    3.108983] WARNING: CPU: 0 PID: 211 at drivers/usb/core/urb.c:503 usb_submit_urb+0xcd9/0x18b0
> [    3.110976] RIP: 0010:usb_submit_urb+0xcd9/0x18b0
> [    3.115318] Call Trace:
> [    3.115452]<TASK>
> [    3.115570]  try_queue_bulk_in+0x43c/0x6e0 [xillyusb]
> [    3.115838]  xillyusb_probe+0x488/0x1230 [xillyusb]
>
> Add a check in endpoint_alloc() to fix the bug.
>
> Signed-off-by: Zheyu Ma<zheyuma97@gmail.com>
> ---
> Changes in v2:
>      - Check the endpoint type at probe time
> ---
>   drivers/char/xillybus/xillyusb.c | 27 ++++++++++++++++++++++++++-
>   1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/xillybus/xillyusb.c b/drivers/char/xillybus/xillyusb.c
> index dc3551796e5e..4467f13993ef 100644
> --- a/drivers/char/xillybus/xillyusb.c
> +++ b/drivers/char/xillybus/xillyusb.c
> @@ -167,6 +167,7 @@ struct xillyusb_dev {
>   	struct device		*dev; /* For dev_err() and such */
>   	struct kref		kref;
>   	struct workqueue_struct	*workq;
> +	struct usb_interface *intf;
>
>   	int error;
>   	spinlock_t error_lock; /* protect @error */
> @@ -475,6 +476,25 @@ static void endpoint_dealloc(struct xillyusb_endpoint *ep)
>   	kfree(ep);
>   }
>
> +static int xillyusb_check_endpoint(struct xillyusb_dev *xdev, u8 ep_num)
> +{
> +	struct usb_host_interface *if_desc = xdev->intf->altsetting;
> +	int i;
> +
> +	for (i = 0; i<  if_desc->desc.bNumEndpoints; i++) {
> +		struct usb_endpoint_descriptor *ep =&if_desc->endpoint[i].desc;
> +
> +		if (ep->bEndpointAddress != ep_num)
> +			continue;
> +
> +		if ((usb_pipein(ep_num)&&  usb_endpoint_is_bulk_in(ep)) ||
> +			(usb_pipeout(ep_num)&&  usb_endpoint_is_bulk_out(ep)))
> +			return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>   static struct xillyusb_endpoint
>   *endpoint_alloc(struct xillyusb_dev *xdev,
>   		u8 ep_num,
> @@ -482,10 +502,14 @@ static struct xillyusb_endpoint
>   		unsigned int order,
>   		int bufnum)
>   {
> -	int i;
> +	int i, ret;
>
>   	struct xillyusb_endpoint *ep;
>
> +	ret = xillyusb_check_endpoint(xdev, ep_num);
> +	if (ret)
> +		return NULL;
> +
>   	ep = kzalloc(sizeof(*ep), GFP_KERNEL);
>
>   	if (!ep)
> @@ -2125,6 +2149,7 @@ static int xillyusb_probe(struct usb_interface *interface,
>   	mutex_init(&xdev->process_in_mutex);
>   	mutex_init(&xdev->msg_mutex);
>
> +	xdev->intf = interface;
>   	xdev->udev = usb_get_dev(interface_to_usbdev(interface));
>   	xdev->dev =&interface->dev;
>   	xdev->error = 0;
>    
I wonder why this check is necessary. The XillyUSB device presents bulk 
endpoints only, and the driver never tries anything else.

Actually, if this warning appears in a real-life scenario, it definitely 
indicates a serious problem. So I think the warning should be visible, 
rather than silenced like this.

I realize that a code sanitizer has been triggered, but is there more to 
this?

Thanks,
   Eli
