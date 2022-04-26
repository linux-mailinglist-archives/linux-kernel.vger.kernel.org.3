Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9336650F6C1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 10:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345971AbiDZI7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346752AbiDZIpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:45:20 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF15B1C9;
        Tue, 26 Apr 2022 01:35:27 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id r8so19913570oib.5;
        Tue, 26 Apr 2022 01:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mn6wvVHUr2ZjEGUHwg6ZBaeE1qpv9Jm8HoWE6ChaE5w=;
        b=Cjyh57ww3jEqGpCEOjpaagYrIbnQDkIVSg56cj65shwf5FOtqPWIsfKCgOYSnf8+JP
         OkaRxiKrKynR9oM/7/X9CJf/suN464U7DRxIMwDXVBJvH2oUr/5Ucyr5bTSZ6XKa+XlH
         s30BaQTKJ4G2fMqTsKqR4RlUItkgeY3xuQjIJ0OAi6dCYv9/6ukkPN/D83E+UAAP4kUv
         E8rL0Uv4aVP8tsRLYPJlyZxXI2QuTPC9WFGNgvgX6KoX1nwefGAOt5KC1EOE8BAHmEyT
         FdLBt3j+KUAdm3EX7ZB63fYmszLiYc9pWw5K0/GmbYixLkoc2BSgf8yxsjPhuuaQR3h1
         QEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mn6wvVHUr2ZjEGUHwg6ZBaeE1qpv9Jm8HoWE6ChaE5w=;
        b=b81sfHnLuZuD8r1rvw1moTNsu74M3j++7YfFP3U/7EljJFo2f6WAyuNXd1bT5BfvP2
         2+Hvdic6hHA2EP6M/hH5msNepH6+RZBCWNV88ZAYH0P1zCMMR7YkmZ/n63h7WHQO0pow
         3PpSzp5994Pf+/pV0YUI5ZKN1sy9+7HxovssJIhmk+TiJ9FNCkb5ph0LG63IHGUDh0J1
         612GKlG5EBf2MlJ/TrmyoqdFBi6pWidOJY7i7zj4a8cpeN9y7Zfz08iBkAD/l9NgQrN7
         YdznlTpKJ2OACKGzOm2hwV6w35gM5t7yjO8FNgcZMJGGVDmkFP2arbLsZAEInyoPxDV6
         uhmA==
X-Gm-Message-State: AOAM531BQ2gNk5fl5P17znTRjzAOnTr8sLkmW63k0kv+h9Y9Gi4eGxp1
        s6mpDs1pDef5N5mGMZwIuFY=
X-Google-Smtp-Source: ABdhPJx86nfNuiQLtsN7uS6ZBCx9NR+9viNEVO1HJOBKCs5hKA6oKSltL6O7UKG6m6hPSsD0t3LT/g==
X-Received: by 2002:a54:4010:0:b0:322:4560:1a84 with SMTP id x16-20020a544010000000b0032245601a84mr9736428oie.40.1650962127005;
        Tue, 26 Apr 2022 01:35:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g11-20020a9d5f8b000000b00605bff9c2dbsm1327902oti.42.2022.04.26.01.35.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 01:35:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <275d7e40-a4bf-624a-6072-9750c6cb1ff0@roeck-us.net>
Date:   Tue, 26 Apr 2022 01:35:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 4/4] watchdog: iTCO_wdg: Make code more clearly with
 macro definition
Content-Language: en-US
To:     "liuxp11@chinatelecom.cn" <liuxp11@chinatelecom.cn>,
        wim <wim@linux-watchdog.org>, Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     linux-watchdog <linux-watchdog@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1650957029-910-1-git-send-email-liuxp11@chinatelecom.cn>
 <1650957029-910-5-git-send-email-liuxp11@chinatelecom.cn>
 <dabd968c-1a03-b67e-0457-3583383f0d2e@roeck-us.net>
 <2022042616273282549226@chinatelecom.cn>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <2022042616273282549226@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/22 01:27, liuxp11@chinatelecom.cn wrote:
>     On 4/26/22 00:10, Liu Xinpeng wrote:
>      > Using SET_NOIRQ_SYSTEM_SLEEP_PM_OPS reduces redundant code.
>      >
>      > Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>
>      > Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
>     Also, Tzung-Bi never sent a Reviewed-by: tag. As with the other patches,
>     this is completely inappropriate. Really, who gave you that idea ?
>     You adding such tags without receiving them means we can never trust
>     your patches again since you are making things up.
>     Guenter
>     -->Very sorry about this. I am not clearly when need to add "Reviewed-by: tag",
>     Just expressing thanks.
> 

If you get a Reviewed-by: tag for a patch, you keep it in the next version of
that patch unless there are substantial changes. You _never_ add one yourself.

Guenter
