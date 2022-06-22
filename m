Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8122554DFB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358111AbiFVOxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358885AbiFVOxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:53:44 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677A9186CF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:53:43 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id mf9so14478700ejb.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HksIOYQ04JYg2f0eKNPT7IHZR7tMMF0Xa3OeTT746VA=;
        b=mqARrPAKxR8z0ETRJaLvggdZ3s8/6oH8pOtcLK9EdQ//wTAN9usE69XpKc36A4DGCj
         KXP1LUdMWuA7uY3EXWy3Ax0bndxwsEfh4x54N6zuYD54JzzSZJzwaSw6Zh7QCX8xO2zt
         IXCZhg2PcrezimwVFqLzo5Ify3K8cbljOnS9ygVFx0TBXMH9iserpKW0ArD3uZyfXcwu
         wWsUuSJ2HnnMkIkozcHGcalwpQYi/w+0yGZ2LSRWeIRXYv+ulbucy72N+UU1PgQRbbG+
         eGtfsDJIECXsQNbilsyqaLxFMDKbc4Dct24TG3VuHWkoGv0zqmjrK0PBeDb/5TrrbYJ9
         HY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HksIOYQ04JYg2f0eKNPT7IHZR7tMMF0Xa3OeTT746VA=;
        b=3BRVUypmofvubJDVQJyurF4ijOHqATDhAWWcOEQpz7B+v6nHDB8UUZW4e/NDQLoeTY
         vOxBzGG2tdLBHqjGv3xlSBxPNbAnJ8q4a7vfq4ZJnClIjzuWzIDv021thPNk6BNF2dol
         qid4uZ3ZGqh8STG3L9eAwAickTqffhi9676AX+u37pzdZBM+G7rKabsMuqJT/GdkqEPw
         7+nI/exq/+un3SzmrOtH/2CQnPrS3w4SOe2Dqr59OltZKwlIGwSKmtqR6FOoTrW0mypD
         kKwfdggB1mFAdGt3NM0ONjD02L8QOFGH6UPxsisMb4YZfb7ektpbw6SmN1fVkOiMLnC+
         ySWA==
X-Gm-Message-State: AJIora+nj7FJt7wizkY3DXSUwEUTY/NRPM+WU01kZg4nSeimhuPhZJrU
        VN1z0lf2Oe0D9Xu3mTM8MGoohA==
X-Google-Smtp-Source: AGRyM1u+K1u+xwGtx13m+HGTMXIlqo/MNWEzkQKKWF4vAOgxf/oC3jSGonkXzyloIphNK0YGE1ME8w==
X-Received: by 2002:a17:906:ca91:b0:70d:52ca:7e7d with SMTP id js17-20020a170906ca9100b0070d52ca7e7dmr3505720ejb.552.1655909621956;
        Wed, 22 Jun 2022 07:53:41 -0700 (PDT)
Received: from [192.168.0.226] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u22-20020a17090617d600b006f3ef214dc0sm9423261eje.38.2022.06.22.07.53.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 07:53:41 -0700 (PDT)
Message-ID: <8f0501c5-84f2-10f1-ae06-4b3936c50b12@linaro.org>
Date:   Wed, 22 Jun 2022 16:53:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 0/7] usb: typec: Introduce typec-switch binding
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bleung@chromium.org, swboyd@chromium.org,
        heikki.krogerus@linux.intel.com,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Neil Armstrong <narmstrong@baylibre.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Pin-Yen Lin <treapking@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Xin Ji <xji@analogixsemi.com>
References: <20220615172129.1314056-1-pmalani@chromium.org>
 <CACeCKaetgayTS+yX0cuNiK7j6Yqd4o2ziX6nCoGTt64A3jFT=g@mail.gmail.com>
 <YrHE9KrF0HG9rVi/@kroah.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YrHE9KrF0HG9rVi/@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/2022 15:17, Greg Kroah-Hartman wrote:
> On Wed, Jun 15, 2022 at 11:13:33AM -0700, Prashant Malani wrote:
>> I should add:
>>
>> Series submission suggestions (of course, open to better suggestions too):
>> - Patches 1-3 can go through the USB repo.
> 
> I will take patches 1 and 2 now.
> 
> seems the others need reworks or acks from the DT people.

I just gave for patch 3 and before for 4, so you can grab these as well.
Thanks!

Best regards,
Krzysztof
