Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDE44B9B57
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 09:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237930AbiBQInZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 03:43:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237053AbiBQInW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:43:22 -0500
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8E92221B2;
        Thu, 17 Feb 2022 00:43:08 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a23so5439625eju.3;
        Thu, 17 Feb 2022 00:43:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IxAqI07yw/RNtyVS6JIMaXpsffDUL/C6yQlcRg0URz4=;
        b=tpe567QAJ9yZ0cxeB4tBLTDO6rkRlTmBfLCqaMQHN+SK3iI3w8kUld8Pz4x5heoi+g
         N6tJ3NhQVepCbdUZ6mW8ApxE0knWtQaJ+NdExLb2xG2caZRdzlodaP2AMYBqyMPnx64X
         bv7A+6VncRDZ+sWLXxvdDa4qMRFe3xDUSqgykE5lHTjzTVJJJxoiyYCD+1hxbqtFNVlF
         63JAA4Anx3JzPeLdDo3PncBgbR81neSb58/w1Xk7uTq6rzEReHZwsH6fqWwa/YUiZfWX
         l3DmUyoZu+/JNrObDD1LSS5lkQoqSWxrU+tvjq4Q/+0OY6sXqzuNp77AWLqqPN587aP0
         2Rmg==
X-Gm-Message-State: AOAM530ybd640A2zN9n/crNU+H4fgefE7ZJAI8iERiG6Qgd43lx79U0K
        zEnoHQvSY1uSONQ6/oZ1RRs=
X-Google-Smtp-Source: ABdhPJz1JKK35XckyAQsD3r5VBtAh9SirVsICqcP9TUKLaKx2lNl05HnpKC+PF3FVcGYT6qHknUJUg==
X-Received: by 2002:a17:906:bf1:b0:6cd:186:9ffa with SMTP id z17-20020a1709060bf100b006cd01869ffamr1482647ejg.506.1645087386473;
        Thu, 17 Feb 2022 00:43:06 -0800 (PST)
Received: from [192.168.0.110] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.googlemail.com with ESMTPSA id z8sm917438ejc.151.2022.02.17.00.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 00:43:05 -0800 (PST)
Message-ID: <cdad7f26-dd4f-4120-c88a-b1cbbb9a56d7@kernel.org>
Date:   Thu, 17 Feb 2022 09:43:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v8 3/3] MAINTAINERS: add maintainers for DRM LSDC driver
Content-Language: en-US
To:     Sui Jingfeng <15330273260@189.cn>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Qing Zhang <zhangqing@loongson.cn>, Li Yi <liyi@loongson.cn>,
        suijingfeng <suijingfeng@loongson.cn>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20220216181712.1493400-1-15330273260@189.cn>
 <20220216181712.1493400-4-15330273260@189.cn>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220216181712.1493400-4-15330273260@189.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2022 19:17, Sui Jingfeng wrote:
> From: suijingfeng <suijingfeng@loongson.cn>
> 
> Signed-off-by: suijingfeng <suijingfeng@loongson.cn>
> Signed-off-by: Sui Jingfeng <15330273260@189.cn>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ea3e6c914384..3f5e13a6358b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6453,6 +6453,15 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
>  F:	drivers/gpu/drm/lima/
>  F:	include/uapi/drm/lima_drm.h
>  
> +DRM DRIVERS FOR LOONGSON
> +M:	Sui Jingfeng <suijingfeng@loongson.cn>
> +L:	dri-devel@lists.freedesktop.org
> +S:	Maintained
> +W:	https://www.loongson.cn/
> +T:	git git://anongit.freedesktop.org/drm/drm-misc
> +F:	drivers/gpu/drm/lsdc/
> +F:	Documentation/devicetree/bindings/display/loongson/
> +

Did you run checkpatch?


Best regards,
Krzysztof
