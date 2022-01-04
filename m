Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0817C48496C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 21:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbiADUqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 15:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbiADUqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 15:46:34 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BB1C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 12:46:33 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id p12so11371238qvj.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 12:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TWapPhsHYw3VtBoPQgmWd2yPfeI/3LTqvIBr/d8b8MA=;
        b=eUsY5bx0KaZNUWF69TH1bVVX0ClCrXV/8+zehGbpDu27aJz407/M4e2Y4oO8MIOE7C
         0IhQsaYyjYbs0Vkmg1EzpHEN3GCcHdTH0+zL0xg6fOm0sM2ZQf3IdvNYXu809V4ZyVM0
         UgKS4CzdHOCLvOPYyVY3+Z4hNGkHA28eSa8AI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TWapPhsHYw3VtBoPQgmWd2yPfeI/3LTqvIBr/d8b8MA=;
        b=csgYZpz/gK3VEeWSqEHGx+dVOqB2HsKSl+YBPMsDURZg6ZJTmVsPd/ypHaYU6nzEt6
         guX1lO3gPn2S5uO1vd3czyuMgRiCUunH0k2VV7BBnSQyB6bEfIh1MgF1AoBhKbzTNHX1
         Bgn0cTYFIC8xUt2PKEpSqDsROadyuUbN7iwwKNIzGddid/tL8v/U8S2WpJAn/hoXYRqF
         XS0ynU4pWbsymtuTUIPqNsN0x5aExNqxcKnysZNyO4rdWo+HSltrIZ+VcdOVehVrMfFb
         r4MHpbyIrGbpxdfgdCdfyzm69Wqz9/QfBzUy/QTDKqYW5amwhh+ZB70sGt/WPLw+3u8w
         B1rg==
X-Gm-Message-State: AOAM533qT1dbzPlyzNsS706h2OmcKD+co9eJyn2417wgTyEdiSYUEcHT
        9CqhIiyudmRmDTnFhkADk818+w==
X-Google-Smtp-Source: ABdhPJyo5ioGOfzcQV1Z4+h5S/0pv/JabmELhbJt3jcNITsDgK8amivYK96uZOZM8l8bApMp2O6nqg==
X-Received: by 2002:a05:6214:c4f:: with SMTP id r15mr47994044qvj.22.1641329193040;
        Tue, 04 Jan 2022 12:46:33 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id bi9sm31266556qkb.60.2022.01.04.12.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 12:46:32 -0800 (PST)
Message-ID: <c78c7f1f-40bc-1d3a-744f-199a613c4af1@ieee.org>
Date:   Tue, 4 Jan 2022 14:46:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v3] staging: greybus: audio: Check null pointer
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, vaibhav.sr@gmail.com,
        mgreer@animalcreek.com, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org
Cc:     greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220104150628.1987906-1-jiasheng@iscas.ac.cn>
From:   Alex Elder <elder@ieee.org>
In-Reply-To: <20220104150628.1987906-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/22 9:06 AM, Jiasheng Jiang wrote:
> As the possible alloc failure of devm_kcalloc(), it could return null
> pointer.
> Therefore, 'strings' should be checked and return NULL if alloc fails to
> prevent the dereference of the NULL pointer.
> Also, the caller should also deal with the return value of the
> gb_generate_enum_strings() and return -ENOMEM if returns NULL.
> Moreover, because the memory allocated with devm_kzalloc() will be
> freed automatically when the last reference to the device is dropped,
> the 'gbe' in gbaudio_tplg_create_enum_kctl() and
> gbaudio_tplg_create_enum_ctl() do not need to free manually.
> But the 'control' in gbaudio_tplg_create_widget() and
> gbaudio_tplg_process_kcontrols() has a specially error handle to
> cleanup.
> So it should be better to cleanup 'control' when fails.
> 
> Fixes: e65579e335da ("greybus: audio: topology: Enable enumerated control support")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

This looks good to me.  Thanks for fixing things.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
> v3: Same code as v2, but remove the redundant message as requested.
> v2: Updated to use common error processing at the end of both
> gbaudio_tplg_create_widget() and gbaudio_tplg_process_kcontrols().
> ---
>   drivers/staging/greybus/audio_topology.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/staging/greybus/audio_topology.c b/drivers/staging/greybus/audio_topology.c
> index 1fc7727ab7be..6bba735d2e5c 100644
> --- a/drivers/staging/greybus/audio_topology.c
> +++ b/drivers/staging/greybus/audio_topology.c
> @@ -147,6 +147,9 @@ static const char **gb_generate_enum_strings(struct gbaudio_module_info *gb,
>   
>   	items = le32_to_cpu(gbenum->items);
>   	strings = devm_kcalloc(gb->dev, items, sizeof(char *), GFP_KERNEL);
> +	if (!strings)
> +		return NULL;
> +
>   	data = gbenum->names;
>   
>   	for (i = 0; i < items; i++) {
> @@ -655,6 +658,8 @@ static int gbaudio_tplg_create_enum_kctl(struct gbaudio_module_info *gb,
>   	/* since count=1, and reg is dummy */
>   	gbe->items = le32_to_cpu(gb_enum->items);
>   	gbe->texts = gb_generate_enum_strings(gb, gb_enum);
> +	if (!gbe->texts)
> +		return -ENOMEM;
>   
>   	/* debug enum info */
>   	dev_dbg(gb->dev, "Max:%d, name_length:%d\n", gbe->items,
> @@ -862,6 +867,8 @@ static int gbaudio_tplg_create_enum_ctl(struct gbaudio_module_info *gb,
>   	/* since count=1, and reg is dummy */
>   	gbe->items = le32_to_cpu(gb_enum->items);
>   	gbe->texts = gb_generate_enum_strings(gb, gb_enum);
> +	if (!gbe->texts)
> +		return -ENOMEM;
>   
>   	/* debug enum info */
>   	dev_dbg(gb->dev, "Max:%d, name_length:%d\n", gbe->items,
> @@ -1034,6 +1041,10 @@ static int gbaudio_tplg_create_widget(struct gbaudio_module_info *module,
>   			csize += le16_to_cpu(gbenum->names_length);
>   			control->texts = (const char * const *)
>   				gb_generate_enum_strings(module, gbenum);
> +			if (!control->texts) {
> +				ret = -ENOMEM;
> +				goto error;
> +			}
>   			control->items = le32_to_cpu(gbenum->items);
>   		} else {
>   			csize = sizeof(struct gb_audio_control);
> @@ -1183,6 +1194,10 @@ static int gbaudio_tplg_process_kcontrols(struct gbaudio_module_info *module,
>   			csize += le16_to_cpu(gbenum->names_length);
>   			control->texts = (const char * const *)
>   				gb_generate_enum_strings(module, gbenum);
> +			if (!control->texts) {
> +				ret = -ENOMEM;
> +				goto error;
> +			}
>   			control->items = le32_to_cpu(gbenum->items);
>   		} else {
>   			csize = sizeof(struct gb_audio_control);
> 

