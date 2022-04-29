Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E01E51425F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 08:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354562AbiD2GfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 02:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354549AbiD2GfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 02:35:00 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A055E7A9B1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 23:31:41 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id m20so13528448ejj.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 23:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VV4IEsHLUTf4LJBEf6r2x88mFgCM/XS/Mg3GKKEB8y8=;
        b=Ej0VEVTh4EWlFm1B2h8idG9tgLnzuqxDMWwphTEMdC7gDBjRyJt5mp3rN8cX1x0NQI
         S/u/4diHpQQuM/VQUWjyKvp5kXI10XbEjEkSoJC+wdxRQisTWx7fqxBH5tebW5/xsTXA
         kRPSUccgrHhBP4xVBLp593gmyExjeV4O7WKqHgPju6nfr8F4T4eSlIbvBlORnv/TjbcD
         Q0y8asDKVVGgfmVW21ogh13RksGdFlBanff0lKkiJ9LQ6zvq3XG/TjZ5JPNJZyJGZe8c
         OzcJuC8IYQ4+QVe/BCVUFn20DVk/qnuI6cQ/MkYcghByDENn9w/u3xVkgO2WdAgKZBLD
         cAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VV4IEsHLUTf4LJBEf6r2x88mFgCM/XS/Mg3GKKEB8y8=;
        b=a4JUw6lyQK9ytD5ZIGuO+ptJab+sV72zw4KLf5g4lcKkiBqNB0Ne7XUWvPVzT2vaiB
         +raINF8ijmMFQ35pA9Ahki+JDHHoUBxdeqR9ubeI/LBrrB2rfaq50vnwvZPVmMGc0Bus
         xgcEUy9TdFunXoEOt7wboFY6HywR4hsua1VLrPxD/UWog2J7yXweDuGuVgNVu8VopA1h
         5WWGVPaeXiH1GPROaGegcFCEy0DKEuh2eyzUzN0FKwybSkiUDw+P/T+P1naDAknWMdBV
         aCMt255GwDw72/gyNGLOZj+YdpbHHhiJKwfB4wEeAZDUI/CpHfXT2xuFrx2Exm07xZli
         eVrw==
X-Gm-Message-State: AOAM533iRqiAGw1DZnvwqW7PMaF/hrW8B+qPF+ybhm8DiqwhNrJhD0VZ
        yZm5FRGYyJ2+QHdtfCXMvLmdjQ==
X-Google-Smtp-Source: ABdhPJz59K7SfWDqQwwv1xsVc/CjFpBb4AMYnq3cmsg5FoKmDuYAaZ/b6HBFgOglA2wN4T2LJBLuNQ==
X-Received: by 2002:a17:906:9b8d:b0:6f3:c659:d3b0 with SMTP id dd13-20020a1709069b8d00b006f3c659d3b0mr11744398ejc.553.1651213900212;
        Thu, 28 Apr 2022 23:31:40 -0700 (PDT)
Received: from [192.168.0.168] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id jy27-20020a170907763b00b006f3ef214e54sm334759ejc.186.2022.04.28.23.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 23:31:39 -0700 (PDT)
Message-ID: <f1e839d5-010b-ddbc-d132-5d0f28c1699e@linaro.org>
Date:   Fri, 29 Apr 2022 08:31:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] dt-bindings: google,cros-ec-keyb: Introduce switches
 only compatible
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>
References: <20220427203026.828183-1-swboyd@chromium.org>
 <20220427203026.828183-2-swboyd@chromium.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220427203026.828183-2-swboyd@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2022 22:30, Stephen Boyd wrote:
> If the device is a detachable, this device won't have a matrix keyboard
> but it may have some button switches, e.g. volume buttons and power
> buttons. Let's add a more specific compatible for this type of device
> that indicates to the OS that there are only switches and no matrix
> keyboard present.
> 
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: <devicetree@vger.kernel.org>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> Cc: "Joseph S. Barrera III" <joebar@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
