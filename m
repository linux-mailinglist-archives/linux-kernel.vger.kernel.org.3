Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21271525156
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 17:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355995AbiELPdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 11:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355676AbiELPdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 11:33:10 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97C124F0E4
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:33:07 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id w4so7747725wrg.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=lJYjLsOwmK98ck5i9BA7AMHyM0+m23dl9hRD8ezZWsg=;
        b=7175BeiZTNnqicYIMG/cOrNiBlDvLKZRf1+0zm252nF0IbNg5cux+zMTmEhDwfdwjj
         D8y7WGXTRdBo9lGN10jQCjFjp7pJWpudmv1c6xod6aiIDaee9K72/VExLTRrN7jWxdE5
         C10ZP+ZKBU60oLVrauNVP14wSVba01uWfQREMogbhDXsfJgOF7ZGdkzwkvSqLXtdUmuo
         fYp/kJSJKcY/bwejIU9LcYeE6Y2TXIJsv7d27xixdHP9ZnErc6a77xHNuvfztBdeJiuu
         hyzdVNNhqH3JgJXfH3iFTFvJSFe00qzD8P13AW/XCioV+1dPbiyQcRb6AxQBqLRVMuZo
         Cjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=lJYjLsOwmK98ck5i9BA7AMHyM0+m23dl9hRD8ezZWsg=;
        b=OsVBCBNvd7Pr0utx+s/NreaEToKcfzTM86KbNVKBHHRYTswLLZeC7GdCLi1rFD0vUd
         GkEL+0mGEPAQjG2AvV6XuiIM3BNj9IrmFLIGosJO4edmqvT+o1ZchNTJ/k53NR6/HiZS
         8HcJmOiNKoiio3l3mji4fhtDF0xZJ7Hh/bXRSa0t/5L7XTCWbvU/jcQsT502bZ3EUg6x
         rz30Vg6tF/IehHCvEyxsS/48+cTJDcP5L63/x/2RFDQmPvgmvZO+pogNger/APc6lkWY
         SuzPCrdsbifku+3V8BQRVL5ognpEYki3RVPqAZjGllOBdiNWuyP6i4hYC0/U1Fq3FdPF
         eJIw==
X-Gm-Message-State: AOAM533wluMmBVlyV9ATifwwmK5WpK//rqVUjHynjMrDkY9aAukU51jg
        s3Zh+5HCKG/dCTav+KFJwUGABA==
X-Google-Smtp-Source: ABdhPJwxvzdMxbrTjFcSe+SbbqUc4+HBjEVB6/fb0QRLLMg1yy6dIz3V8d6rId8zYFdHJl8rC71Tow==
X-Received: by 2002:adf:cf12:0:b0:20c:dc8b:ae99 with SMTP id o18-20020adfcf12000000b0020cdc8bae99mr211414wrj.550.1652369586258;
        Thu, 12 May 2022 08:33:06 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:4b80:c5a9:17cd:ed1e? ([2001:861:44c0:66c0:4b80:c5a9:17cd:ed1e])
        by smtp.gmail.com with ESMTPSA id t16-20020a5d49d0000000b0020c5253d8edsm4505077wrs.57.2022.05.12.08.33.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 08:33:05 -0700 (PDT)
Message-ID: <f3a08514-a92d-df2b-48f6-b29d0be42861@baylibre.com>
Date:   Thu, 12 May 2022 17:33:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm/meson: Fix refcount leak in meson_encoder_hdmi_init
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Miaoqian Lin <linmq006@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220511054052.51981-1-linmq006@gmail.com>
 <CAFBinCAQaCNcYmF0kT6o7zOCHy3eV+vHOHC10XULYXvDO6_-6w@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <CAFBinCAQaCNcYmF0kT6o7zOCHy3eV+vHOHC10XULYXvDO6_-6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/05/2022 14:38, Martin Blumenstingl wrote:
> On Wed, May 11, 2022 at 7:41 AM Miaoqian Lin <linmq006@gmail.com> wrote:
>>
>> of_find_device_by_node() takes reference, we should use put_device()
>> to release it when not need anymore.
>> Add missing put_device() in error path to avoid refcount
>> leak.
>>
>> Fixes: 0af5e0b41110 ("drm/meson: encoder_hdmi: switch to bridge DRM_BRIDGE_ATTACH_NO_CONNECTOR")
>> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> Thanks for sending this patch!
> 
> Neil, while reviewing this I noticed that on module unload we're also
> not calling put_device().
> This note doesn't affect this patch - but I am wondering if we need to
> put that put_device() during module unload on our TODO-list?
> 

Indeed, it should be fixed.

Neil


> 
> Best regards,
> Martin

