Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E9855CE27
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbiF0HBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiF0HBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:01:08 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71B526CF
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 00:01:01 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id be14-20020a05600c1e8e00b003a04a458c54so981499wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 00:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=JQ6BJkIBB0iuDWSouR0v+Ao2Lgbe3w3R+14xG93o9xk=;
        b=2AWfMwMcTegs4b4opzBhY/wwU3S/mkbyFO3l+vsapib2LNgKheHE6IppogNvVtk5uP
         UlRY3k27QNO9mipLmBaqh6+12cRTCRxvUc6+Wfkb4aWceHfMVRKuv7amS0eNwSLJbAS2
         AUOLOpig137iD7NSOLfT0WBxA2FXBDx3Nrl7iqbRCXzBPXg8ZfDAOYAL7RwbymvSBTMq
         TS9+mAdBfsJBGrBIiR1+H00qKcc9vA+4HYRYvZcEHvj+0VW5JVi5k5p+N7Xxb1QZY8SI
         MhJ6OYcf0c6Zun9pri+O+LnyadlbsBSUez3Qjl176C2JQHVySFCOTJCb0faG6sLxIyct
         U90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=JQ6BJkIBB0iuDWSouR0v+Ao2Lgbe3w3R+14xG93o9xk=;
        b=MGGtkiybV83F0qetbw6vDb4ZX33ebbzERewxk6hfQA8YmdbUCqaimQ1+JRXlhg2uAc
         VBvHQtCYbevmBbDnAKvVnLdSsu4Kq+AM/uzHNeI3VNtTwmTOIIf7v3gMwq0/9nFzZeRk
         J6y1KOX8pCCTif+z6aClLa7F7fgxDMzwsvVwjIvCyxQmX90w72BEWsFNcOKebL1uGorB
         OUoGNP7LptvvilVqRVdIpMNJ+pk/U5UwxeQX2f8sNEAnKSiCh9HB3ZiuCXRD4YKvv22A
         gKBKZT3YsqPuaUypPyRHL9h4DrR5MAbPaELikxH4lIfN8LwecgJUnJ9XmRpAAd9GfIiK
         noUg==
X-Gm-Message-State: AJIora84GLqgkD1qXdITvfb+0VrKjfYPeGeAxsaaw6vDAgDnsfklWyVD
        8YOng/Psf2FuyM1v4HTw8YOK9Q==
X-Google-Smtp-Source: AGRyM1tsboWv7CmBuSib/MKQWOTP7R/cF8DQ1rA0QOY3EnXdzt4uRTN9+gNDfqLJF0pteDC8B0fi8g==
X-Received: by 2002:a05:600c:1d85:b0:3a0:3d28:bdd9 with SMTP id p5-20020a05600c1d8500b003a03d28bdd9mr13908668wms.114.1656313259081;
        Mon, 27 Jun 2022 00:00:59 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:6f56:f3c6:ba4f:bf5c? ([2001:861:44c0:66c0:6f56:f3c6:ba4f:bf5c])
        by smtp.gmail.com with ESMTPSA id r15-20020a05600c35cf00b003a0375c4f73sm11304434wmq.44.2022.06.27.00.00.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 00:00:58 -0700 (PDT)
Message-ID: <9cdf2ca0-4f86-09b0-8834-c0c39eb70054@baylibre.com>
Date:   Mon, 27 Jun 2022 09:01:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 6/6] drm/meson: add support for MIPI-DSI transceiver
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>
References: <20220617072723.1742668-1-narmstrong@baylibre.com>
 <20220617072723.1742668-7-narmstrong@baylibre.com>
 <CAFBinCB=RJeaqVi+d6gGAsQTWAU68iFF6T9bXAQVYUWKxgiYaw@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <CAFBinCB=RJeaqVi+d6gGAsQTWAU68iFF6T9bXAQVYUWKxgiYaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27/06/2022 00:32, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Fri, Jun 17, 2022 at 9:27 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>> +/* [31:16] RW intr_stat/clr. Default 0.
>> + *             For each bit, read as this interrupt level status,
>> + *             write 1 to clear.
> Do you know if an interrupt line from GIC is routed to the MIPI-DSI
> transceiver? If so, we should make it mandatory in patch #1 of this
> series (dt-bindings patch), even though it's not in use by the driver
> at the moment.

Probably yes, let me check
