Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98B8539EAE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 09:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350367AbiFAHqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 03:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350497AbiFAHqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 03:46:32 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47719E9E1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 00:46:30 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x62so992228ede.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 00:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=T6fxYgINWBY11Dni0RdPgNMNlUUQKxzxAv4RKjFNoh8=;
        b=ssAjHW1BeAwXHaBfJEtFzqK3YHHy2KjzIBif5IWHtpiL1VbzWcaVUh4js9Djhqmali
         u4KB8OezdhL1Zo+ygWK8iiZcby1EM6gpkv7MPuTiSE7VfNe7FpM6e5oRIN0Pf/4kcoUJ
         4YEuKryEr+wQPbii/Di3yMa7YA4EGzhLX4n+v5FcL64flYBaHTN+PiK2ffwiNoNEdvXJ
         Rhs9MPPwL6YmubnygHTzCrLbWudSIXTcnGD8ptwWMjfJIb6L+TOcuR36XmCZVbMcvWay
         gNMmR82Cj7wt7REuYXgffWhE04Y4cDkX3G4IfHNI0QelpgKhf59ckWEbgXP6vkdngc14
         xW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T6fxYgINWBY11Dni0RdPgNMNlUUQKxzxAv4RKjFNoh8=;
        b=ujGzyTm3cdmaTZiv9E/wkuAtFgJ5xteMZwB/YLVxfZjixIlOHXTZUK6Qmb1Ch5J9Ah
         gx/p/BlowqUwoqA4QWRKk1luTNCNDPg1G2QtvwadioHpEJU/tGAJjdBRtmgeb5L8bT5B
         H4bGyM+9xA+BafdoUSqnErWwMvmxDaqCuEjNkeJICvguAPamXY8eUDth6LkYyN0i6TXL
         CuBw6Vl2nXXi2Hrvm1S8m0Qd42/FglPTVYsopUqDdtZT0WOxbb7DMNnLcRkGZuXIlgcs
         UWqZJWWnRxW9T2P7jG1LIpCyXjhkzrSxH39R8WTrLmEX8jaglphp0wiZVxKhLa3iS31m
         Dhrw==
X-Gm-Message-State: AOAM532OmaaxeM6BSRtZa6oXo3hgHnxPsSLoaYPiG7FsGzFshuA7O3qK
        /BnQB/wP1XSr8pEkaDXkPnoocfCzIp+xGLCL
X-Google-Smtp-Source: ABdhPJx674EkevDvreeBjkA9QX9V23D5lA0OtNhSm7nrHja+xIv/fZuP1EBU8ne7sB2l4OcKJzSTBg==
X-Received: by 2002:aa7:ca1a:0:b0:42d:e1b0:2dd2 with SMTP id y26-20020aa7ca1a000000b0042de1b02dd2mr8295939eds.157.1654069589129;
        Wed, 01 Jun 2022 00:46:29 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ec2-20020a0564020d4200b0042aaaf3f41csm532956edb.4.2022.06.01.00.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 00:46:28 -0700 (PDT)
Message-ID: <903f926c-4977-9e0f-0e40-53cdc164e9b2@linaro.org>
Date:   Wed, 1 Jun 2022 09:46:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add prefix for
 ClockworkPi
Content-Language: en-US
To:     Max Fierke <max@maxfierke.com>, thierry.reding@gmail.com,
        sam@ravnborg.org, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220601051748.1305450-1-max@maxfierke.com>
 <20220601051748.1305450-2-max@maxfierke.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220601051748.1305450-2-max@maxfierke.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2022 07:17, Max Fierke wrote:
> Add a prefix for Clockwork Tech LLC, known as ClockworkPi. They
> produce a number of hobbyist devices, including the ClockworkPi
> DevTerm and GameShell.
> 
> Signed-off-by: Max Fierke <max@maxfierke.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
