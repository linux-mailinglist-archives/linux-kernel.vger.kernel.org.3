Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D291E542A10
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbiFHIz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbiFHIy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:54:29 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D433B70F8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:15:03 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id i15so236898plr.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 01:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8vPFgOEV1xO89FzsTPP5iEjwMIT+hgmPQkmB1wvaKd8=;
        b=NxuArknVDQMEogVDnd4kT8QYdMO/UNOtjjLGX6TgITDz1V+r3wi9XsjkdaqbUdZ25C
         zULuBg0YJJrPE69lHdy9iK3lg1GsC973iOtjtaJbqt81GZFgAVerLUu7wBWHpgrOM+00
         bnGZJNL5zPueeV1Jf9EtrM9kOJ1GM3TssLlXgSzfl7F6FevSVqVHTf74UCUUT8FpEON+
         KPB67d2VP5Wj+GAWbZ8V8x2NDUVbnhDL9PVlOwOnNFVNyxzKCbKJSJNb5jXAxGay4XgT
         YyF8dFWc/k7tvM50Z4jzHUJ7ATYG39v4SBpMFv1bczIqIJcmk3GLnZBy05WrkowyH6bh
         dIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8vPFgOEV1xO89FzsTPP5iEjwMIT+hgmPQkmB1wvaKd8=;
        b=yIPs5YHiAr6co2VVexdSlGfOOqxUWOBq9z+5AFHkaPR0rFzD+GYelBIlqbHsWdsBNm
         G/AjGQePc/0oKml5sINIGuBDh8lD2zl9k2bZkA4n3sxk/ccwix+3dsqJguZTBeQIGqUj
         hOAdMX/MLxwqh/tLIhw3Yo8QQSHaw9DsF3e833AnCXNtB/7PWxQs0bHWYTmzAuQMBMeX
         fIkj0+JFDbN3Uf5bbbLgI7uDdez5Qsc8LZnU37PL6RPM3O8IUegDD5qFhuRRDJcAsnNb
         AzPJM8fM8+9LDfdEIyn1CFw0qMouyNnWBf5jdckTU1jQNbnLpacUFwKXchnXotkCOHoL
         UlkA==
X-Gm-Message-State: AOAM531r+kCkuXxfhF8/E47lhSses1poJFC6A2b7EbmIUtc8ifI0IpN0
        fnEwe5oqY7VUpypwGuqSw10=
X-Google-Smtp-Source: ABdhPJzooNQjoFk9kVwU6edcEV6qA02eTMA4edGS6RG5yxZB5e96PiHK+PcXVGd07k9q2LFerOq29Q==
X-Received: by 2002:a17:902:d64d:b0:162:3595:220c with SMTP id y13-20020a170902d64d00b001623595220cmr33676194plh.10.1654676103195;
        Wed, 08 Jun 2022 01:15:03 -0700 (PDT)
Received: from [192.168.0.24] ([88.126.57.132])
        by smtp.gmail.com with ESMTPSA id y7-20020a17090322c700b0016160b33319sm13949931plg.246.2022.06.08.01.14.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 01:15:02 -0700 (PDT)
Message-ID: <91fb36b5-eb63-c0cc-eb77-9d523fc45b10@gmail.com>
Date:   Wed, 8 Jun 2022 10:14:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 5/5] arm64: defconfig: enable bcmbca soc support
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     joel.peshkin@broadcom.com, tomer.yacoby@broadcom.com,
        kursad.oney@broadcom.com, philippe.reynes@softathome.com,
        dan.beygelman@broadcom.com, samyon.furman@broadcom.com,
        anand.gore@broadcom.com, Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
References: <20220601225654.18519-1-william.zhang@broadcom.com>
 <20220601225654.18519-6-william.zhang@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220601225654.18519-6-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/2/2022 12:56 AM, William Zhang wrote:
> Enable CONFIG_ARCH_BCMBCA in defconfig. This config can be used to build
> a basic kernel for arm64 based Broadcom Broadband SoC booting to
> console.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>

Applied to 
https://github.com/Broadcom/stblinux/commits/defconfig-arm64/next, thanks!
-- 
Florian
