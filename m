Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CD24F0808
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 08:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348387AbiDCGPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 02:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbiDCGPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 02:15:04 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AAD32ED5;
        Sat,  2 Apr 2022 23:13:10 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id s8so6104398pfk.12;
        Sat, 02 Apr 2022 23:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iqcYjJqeAGHOxk9rC6rzT/4cJTQjLiPEBtPtNallgoU=;
        b=Ai6HzXtHc0uKlmt9INXqJSUeKr9EH33Q2j4WBafh/MJdcKXtU0DsIuf5qXLmcGjIr+
         J/x/VNKPKCXAhvRydsIj90akhWtP1MHD0J7XBlSOtYsl6q2uceHO0ylFipwZn1ZjngDk
         Mm/wuon+Aa+5OxEfI0iWet/706W/9GsH5T4CXKCASsAd/D39tnslez+5IiuZMNcPKt6k
         kbSqOuEhUZ+57C8ZP7eOyaVYaRXZ4Cmqa0pbeMrcfURj0WDwEOZiUAnDFBV5dNiIPDA2
         nr7zN6ZoAmkxiOoYgBIBgN3hDVDknq92mwhWLwh3kzcU0lhiyITzQWqwIaSCS2cUoF1K
         ORYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iqcYjJqeAGHOxk9rC6rzT/4cJTQjLiPEBtPtNallgoU=;
        b=nOoJH+JcFfGfvASEwIt+UZMBT2zVZcDtDMVhVmatwYgYLtBHhnnHusGctxVsOwjeVK
         cvWK6vhF5CpC+lnEoaH/bc3ZgFI8xOjcVNJes4exuUjLy8PUqK/Zdyqr7VGLxieH6Chm
         LlpYwX1waBnfcx0nlqjl8VZmeGdlIdQ+wvh8kfiH1ERQx+yIeBBfixTc/biCsm9f+RCX
         YyxvlHHko41s2xMOdnfXWZjB5VvcEkKOLm1mtRl1YoDT3skPKvr6NkaI83yJuwu+WJud
         k87XQZEQ4AtPpcjJ7z6yoPxoz0IW3UFuetHzms4djBHqHLe1AiHYJphqkauiO/2peyOS
         zePw==
X-Gm-Message-State: AOAM531FWAatauy9FcdAJBuYM5zU2wQmbd9zWQBBdZ/7AsHgyRvPfQDz
        5uiglf+uuCIYP8L0V1ApICI=
X-Google-Smtp-Source: ABdhPJyRIpXteTf1cloPvJlVcVw9JuXei83O10GMNROZ3VtoU9KoPyHLol5rNJHhPhQscANAd70X3A==
X-Received: by 2002:a05:6a00:1581:b0:4fa:e6d4:c3e6 with SMTP id u1-20020a056a00158100b004fae6d4c3e6mr18173399pfk.84.1648966390229;
        Sat, 02 Apr 2022 23:13:10 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-68.three.co.id. [180.214.232.68])
        by smtp.gmail.com with ESMTPSA id c63-20020a624e42000000b004fa9ee41b7bsm7720108pfb.217.2022.04.02.23.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 23:13:09 -0700 (PDT)
Message-ID: <f4377408-ace7-a041-084f-5863bcfb7184@gmail.com>
Date:   Sun, 3 Apr 2022 13:13:02 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] usb: gadget: uvc: allow changing interface name via
 configfs
Content-Language: en-US
To:     Dan Vacura <w36195@motorola.com>, linux-usb@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Carlos Bilbao <bilbao@vt.edu>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20220401160447.5919-1-w36195@motorola.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220401160447.5919-1-w36195@motorola.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/22 23.04, Dan Vacura wrote:
> Add a configfs entry, "function_name", to change the iInterface field
> for VideoControl. This name is used on host devices for user selection,
> useful when multiple cameras are present. The default will remain "UVC
> Camera".
> 
> Signed-off-by: Dan Vacura <w36195@motorola.com>
> ---
> Changes in v2:
> - remove stable cc
> 
>   .../ABI/testing/configfs-usb-gadget-uvc       |  1 +
>   Documentation/usb/gadget-testing.rst          |  1 +
>   drivers/usb/gadget/function/f_uvc.c           |  4 +-
>   drivers/usb/gadget/function/u_uvc.h           |  1 +
>   drivers/usb/gadget/function/uvc_configfs.c    | 41 +++++++++++++++++++
>   5 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uvc b/Documentation/ABI/testing/configfs-usb-gadget-uvc
> index 889ed45be4ca..611b23e6488d 100644
> --- a/Documentation/ABI/testing/configfs-usb-gadget-uvc
> +++ b/Documentation/ABI/testing/configfs-usb-gadget-uvc
> @@ -7,6 +7,7 @@ Description:	UVC function directory
>   		streaming_maxburst	0..15 (ss only)
>   		streaming_maxpacket	1..1023 (fs), 1..3072 (hs/ss)
>   		streaming_interval	1..16
> +		function_name		string [32]
>   		===================	=============================

Since you mention that default function_name is "UVC Camera", why don't you
mention it in the documentation?

-- 
An old man doll... just what I always wanted! - Clara
