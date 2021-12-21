Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2460C47C23F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237791AbhLUPGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238934AbhLUPGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:06:41 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D733C06173F;
        Tue, 21 Dec 2021 07:06:41 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so17021019otl.3;
        Tue, 21 Dec 2021 07:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ndnr4OCryfcect7aYGHe18tbwXIs5dkNZfE/W0ByRm4=;
        b=oIEL4JlnTZJ+EeTOqom3SfS47lUV+G6xfpIQvytVQgCmumyFI4W+D6uvJ5oD8lzZN/
         pDipWEolYya3XvsIcLunnvTWWUxY7tjB3V2F7GSDHOlBaqSl6jkEOYUPEJm7gwon+7bn
         HlCHldFS9bj4M/lXdbgYrJFgzvRPDvRz7QxjQ4vDgEXEsD8t4Bxwhw+apMdl5Etq6E4m
         T6c1Xi5asUnPSiiDjX5dZu2GlLADB7FN2FLf8sQkXk2746uAaCljjSTG8nO95OfeAZHC
         rYXRcsTzi/uw8yoa53+wwrPUK/2jRNCACS6yFLAtOuTbF0dYC1BKj3TzqBct8IJheCQR
         YbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ndnr4OCryfcect7aYGHe18tbwXIs5dkNZfE/W0ByRm4=;
        b=EDRBhRlAJTOebkkrFslBkI3YNS21Kg9OjxGzVju+pp7otD4Y5qetY/tWs9/9ONSoMy
         ihbUMJ3+fy5nbKqbM/5AknbuIc3rBWNvmfnjUvRKEqt6QQTTMer4QkpFTqkKk3z8jR5m
         EGazR6Bu1barZ5y5Q8eib0UprKtzj2ggwtwtSPrfog1Z0M1hhjLizXJNERXOux9AikUX
         K/MraZ7Q179OfNYIWUDUE2AWszzcUbEPBDeByzsBJQOmN/5c/WY7wewmTApVJkvGGfdx
         spSdVYRnbAPoV3C/n3QCkLLaQ9ckwe2x6SeDqHEGGvHNLFfYW/QW9iGSMYkJpY6eUTO4
         TVEA==
X-Gm-Message-State: AOAM533CS5+XBk5Bg6sFuynHdPVbDXA387nvZmwQPoWqeVTnHQHkpSBl
        yL+WV9Off90aZLeemgVNeE0=
X-Google-Smtp-Source: ABdhPJzz0MoI++eGJVGGlfXwB8apYvOaL9+csbvoZhP7p6USdxQEBCGqwOdXTrDjR8yw/DqKPqS5bg==
X-Received: by 2002:a05:6830:1397:: with SMTP id d23mr2505927otq.68.1640099200419;
        Tue, 21 Dec 2021 07:06:40 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j5sm3627661oou.23.2021.12.21.07.06.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 07:06:39 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v5 8/9] watchdog: max77620: add comment to clarify
 set_timeout procedure
To:     Luca Ceresoli <luca@lucaceresoli.net>, linux-kernel@vger.kernel.org
Cc:     linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Chiwoong Byun <woong.byun@samsung.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20211211175951.30763-1-luca@lucaceresoli.net>
 <20211211203432.32446-1-luca@lucaceresoli.net>
 <20211211203432.32446-2-luca@lucaceresoli.net>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <9ef37bd7-0bb5-d9ee-6643-47aac9870a67@roeck-us.net>
Date:   Tue, 21 Dec 2021 07:06:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211211203432.32446-2-luca@lucaceresoli.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/21 12:34 PM, Luca Ceresoli wrote:
> Clarify why we need to ping the watchdog before changing the timeout by
> quoting the MAX77714 datasheet.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> 

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
