Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F9553E7DB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbiFFJ2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 05:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbiFFJ2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 05:28:43 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DACBF77
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 02:28:41 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b8so1286551edj.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 02:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=CZYagJgYZ1zkpsLL362Hu3OFzejYcv3wUUFkHLhcy4U=;
        b=MEYM2+ibWfzWS3t1mRebwtFZljOOSal2v84sjKN2Bud6nMJI0rJE+VLSitCngN0asq
         YAMjPgJztYLJDTUkndEHNR/WbZp+Xd/C2BTRfFaGpolmyT9sUmXa9lMNCR/wGdag8npb
         4p5tD4UayZO9Ls9zs3Eep6IdKXHqU0CG2IA82q7Cqr/SqJ1ZlcE2ZHWqWztn4RwK2mUc
         4rIYWxdGPP0BnZAPo46ENvisH15Av5wO8gP+qWZdQmviq7FXOsz65BKcY4R/zJfs0ioE
         PEgLAi6NBkZTEj+ZgDSg40oqgoc+hZWwEslOLvWef51kWf2bUQF4TqoCrPmqtxhRnuTW
         Vxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=CZYagJgYZ1zkpsLL362Hu3OFzejYcv3wUUFkHLhcy4U=;
        b=Xbn6Xhn0vgoHBpyuXXvSeL5kFR/sJAP2EQCySgGIuAdN3ay0CkzWF6hSOcImpnsqgf
         npXv7XDf4Aa8m0nCWUI6NlpvtrVT6t9ibxc8YVKIFM2wLwZjjPwsW1nKYHLgsPJzs3fl
         9HklR+4+riqpaYEh3TkvqhBFJpL9MmgD7hDzQWEWH1KqKG96LmfUzYbcTh/ld49e2mfM
         wg0+YPKGhThI4u1WpwUyL/gPU1YIjOkqZFuPhVxM3TnIJanYLEQQAOMQSgYzh/uXY/Vg
         +xqKTykHX0lz/8ALiF6zsMj8Hu+VUoOSg60Tj9Z0FnVImLyiwAy8SPzG4Ewhb1CvlUMI
         MkvQ==
X-Gm-Message-State: AOAM530CJjjEvat1fRImtM/REBruOViSCfkPmWr+JSfZxeMgNwnomad4
        wRIBuzmKGBrpezKErnEfWmM=
X-Google-Smtp-Source: ABdhPJyszevYNPuTBTC2iVM31Hh+k7ht19JCXqdzmsVJrINi0gJqlDe5oZPCnRJk/iM/x/4kQzBYZQ==
X-Received: by 2002:a05:6402:2948:b0:42a:ae0c:2f26 with SMTP id ed8-20020a056402294800b0042aae0c2f26mr25337943edb.425.1654507720027;
        Mon, 06 Jun 2022 02:28:40 -0700 (PDT)
Received: from [89.139.32.160] (89-139-32-160.bb.netvision.net.il. [89.139.32.160])
        by smtp.gmail.com with ESMTPSA id jg36-20020a170907972400b00701eb600df8sm6319059ejc.169.2022.06.06.02.28.38
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 06 Jun 2022 02:28:39 -0700 (PDT)
Message-ID: <629DC880.8050708@gmail.com>
Date:   Mon, 06 Jun 2022 12:27:28 +0300
From:   Eli Billauer <eli.billauer@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     Zheyu Ma <zheyuma97@gmail.com>
CC:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] char: xillybus: Check endpoint type at probe time
References: <20220531054431.3978424-1-zheyuma97@gmail.com>
In-Reply-To: <20220531054431.3978424-1-zheyuma97@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/22 08:44, Zheyu Ma wrote:
>   static int xillyusb_setup_base_eps(struct xillyusb_dev *xdev)
>   {
> +	if (xillyusb_check_endpoint(xdev, IN_EP_NUM | USB_DIR_IN) ||
> +		xillyusb_check_endpoint(xdev, MSG_EP_NUM | USB_DIR_OUT))
> +		return -EINVAL;
> +
>   	xdev->msg_ep = endpoint_alloc(xdev, MSG_EP_NUM | USB_DIR_OUT,
>   				      bulk_out_work, 1, 2);
>   	if (!xdev->msg_ep)
> @@ -1962,6 +1986,10 @@ static int setup_channels(struct xillyusb_dev *xdev,
>   			chan->out_log2_element_size = out_desc&  0x0f;
>   			chan->out_log2_fifo_size =
>   				((out_desc>>  8)&  0x1f) + 16;
> +			if (xillyusb_check_endpoint(xdev, (i+2) | USB_DIR_OUT)) {
> +				kfree(xdev->channels);
> +				return -EINVAL;
> +			}
>   		}
>   	}
>
>    
I just checked this against hardware, and made it fail deliberately by 
replacing the (i+2) part with (i+3). I got a kernel memory corruption, 
because xdev->channels was freed twice: Once in the snippet above, and a 
second time in cleanup_dev().

So the kfree() call here should go away. xdev->channels is freed when 
xdev's reference count goes to zero.

Thanks,
    Eli
