Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA05C53856E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 17:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241566AbiE3Puk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 11:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242042AbiE3PuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 11:50:02 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297806B000
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 08:13:36 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id k16so10726719wrg.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 08:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=ShWA5Lf0IpnRT/XMhhsf2/+2EvIbcOqOmelUR0srNOc=;
        b=AVap6MTvKL8EUOtxSsbeFx/oS7vr6T58xi77FurdF+yckI3eVzLyhv/kZza1SpGPMs
         iTweZHGgyaqx0uAQyBgGt0apu0+S39Tqdpr/C8BrzJhSsbclxVFKbz9QJU9QK9y4OvXK
         /b/JtXyrHr0rjT1ekKRzzZ+fCMkoBzbLCwm3oUPkUaupadGhprLqzSgjji35kAJTj7ue
         BVNgtsd2qMnR6BDOlQFZ68NCNsImXh+3mMaGYExhel7n3UahQc17ds95uS3if/g6xakk
         jRZbnh7pO6rCwndwbDgP7ZUZ0etEL69Pc9+a+SL60fBrJiGomCV5xif0g9L76H8l9LlV
         yl8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=ShWA5Lf0IpnRT/XMhhsf2/+2EvIbcOqOmelUR0srNOc=;
        b=ZxAh6e/4+e1/arIPfqWKguyoyKowLLXxR5sqWhSiTqkT31JmWf03tjzG/v+n0/TmO7
         g57k83W6cAmqmkP5ni4dW+tShRCry839JIX5q8XZSmzTsgwNmuHOR352dU+r1aa9fs+9
         kks6aHG3vobRy+bS5Vd2EEYb4k0qf+Qj0cSkM+ypfpf2tpuo0ThxjNqqTMQqJenXweOK
         IlHVn5PB6jRZvJtbAlABMP9kn6/f+9ACZmVdLIFgv62v7BiwmUAdDhQcz72nMbC9mTVd
         fdncMz0Ho2vQ8eDL2sdpUS7RbWrMTtlQK2dXfnd1bqxchkOpW6uhZIrYtzjKjbUUOsy8
         wx7g==
X-Gm-Message-State: AOAM5325kegLXGNl6HtvyLQPQXf8Aj5ZlRKu+EBGNObdn+C1oasRGvK9
        62sCT0tVzl00xwaN3Xx0Sm78HVKZ1Sg=
X-Google-Smtp-Source: ABdhPJycjThRvVXA4TdgZGtCguNCNnJmMgh0NeSrVoGYQoxN2AdcaQpJZxsyR8DfdIBQA3s7RaI9XA==
X-Received: by 2002:adf:e198:0:b0:210:4e7:f57b with SMTP id az24-20020adfe198000000b0021004e7f57bmr19518989wrb.296.1653923614640;
        Mon, 30 May 2022 08:13:34 -0700 (PDT)
Received: from [109.186.23.63] (109-186-23-63.bb.netvision.net.il. [109.186.23.63])
        by smtp.gmail.com with ESMTPSA id w15-20020a5d680f000000b0021033ba8b15sm3208679wru.44.2022.05.30.08.13.33
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 30 May 2022 08:13:34 -0700 (PDT)
Message-ID: <6294DED6.70904@gmail.com>
Date:   Mon, 30 May 2022 18:12:22 +0300
From:   Eli Billauer <eli.billauer@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     Zheyu Ma <zheyuma97@gmail.com>
CC:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] char: xillybus: Check endpoint type at probe time
References: <20220529065839.3817434-1-zheyuma97@gmail.com>
In-Reply-To: <20220529065839.3817434-1-zheyuma97@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/22 09:58, Zheyu Ma wrote:
>   static int xillyusb_setup_base_eps(struct xillyusb_dev *xdev)
>   {
> +	int ret;
> +	struct usb_endpoint_descriptor *in, *out;
> +
> +	ret = usb_find_common_endpoints(xdev->intf->cur_altsetting,&in,&out, NULL, NULL);
> +	if (ret)
> +		return ret;
> +
> +	if (in->bEndpointAddress != (IN_EP_NUM | USB_DIR_IN) ||
> +		out->bEndpointAddress != (MSG_EP_NUM | USB_DIR_OUT))
> +		return -EINVAL;
> +
>    
As far as I understand, this finds the first BULK endpoints in both 
directions, and verifies that their addresses are MSG_EP_NUM and 
IN_EP_NUM. Because both of these happen to equal 1, I suppose this 
indeed checks the right thing. But am I right that this won't work if 
either MSG_EP_NUM or IN_EP_NUM have a value that isn't 1? Not that I 
think that will ever happen, but still.

> +static int xillyusb_check_endpoint(struct xillyusb_dev *xdev, u8 addr)
> +{
> +	int i;
> +	struct usb_host_interface *if_desc = xdev->intf->altsetting;
> +
> +	for (i = 0; i<  if_desc->desc.bNumEndpoints; i++) {
> +		struct usb_endpoint_descriptor *ep =&if_desc->endpoint[i].desc;
> +
> +		if (ep->bEndpointAddress == addr&&  usb_endpoint_is_bulk_out(ep))
> +			return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>
>    
Given that you've added this function, why isn't it used in 
xillyusb_setup_base_eps()?

Thanks,
    Eli



