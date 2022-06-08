Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94B6542BF5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbiFHJvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbiFHJuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:50:39 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0053BAA22;
        Wed,  8 Jun 2022 02:20:27 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id e11so4599881vsh.13;
        Wed, 08 Jun 2022 02:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/VQUCDn34E17XXsnPnnfZCFOxTViuV31TOkFWFDSdOw=;
        b=f0X/bujXGwJ+MmEAkd0qotOhcFoiRSEQeAhO+ZT6ZKqdm65ykalxwo7PP/j3nei3NA
         sd5uWGmtDDKJ5e6YaHOOIRqPaXz0yfVKblGRdte3reIZn4CHGNq3K2OmALBOSItGlaQ8
         QyU+sd7ZsP5/pQ+xVGrmuBGFDfsY2V6kfmJU2bvfdEamgrMN017PxabFWSlG3yydmHGq
         XkHAnh+AyugJbr3JTj4IMKGVdcayognpsFZz0LhdKbrYNhJnLpMOg1GVnn+6+GB/prLt
         a84AMwNlojKBya+wXBei30DbF1UGcbgHbutwfL8vBlY51PC5cIKacGhGXTC8aT9JBXL3
         xhyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/VQUCDn34E17XXsnPnnfZCFOxTViuV31TOkFWFDSdOw=;
        b=Q70nDh62fpGg+UFXr898yFnfz8nEyBdfDP0ZXK0P6qUoBn+5lyuFnBjurFY+PrLdJd
         PAat3sLUX8JWFUUkVGxNHaCeLB8GNonZk9UcKI+/h5KZ2iQdW1f8YO5Y79RK4JSrRhjF
         mZaPeqtIZqdEer5xv62jnKhDWmCE2AFy2z2+ICFaQlhudx/E9KTx2vqMmQULvzbJ6zae
         oiU9aHObq8X+Kjy1m5xBEQmSDNQmOqK3vLGRbCkhfxswY7K6qfIomhRgKtR/MkwvymnG
         BENUFXBY2zaQXm3Geyoa+uDveX3OegBbOdHJ5I9XTyihBS4bDijnYi0HkJahjon1ycyH
         FXxw==
X-Gm-Message-State: AOAM531kDpX/rUwN9lWSANVrYlvCe/pWnZnVK20fzntiC9JzlqqY8t6d
        +lm7IJNXy7Y6zmAgyeJ2+NI=
X-Google-Smtp-Source: ABdhPJzs1KUFTE0j4mzpuEPdj5w2Uv1REGhxWfscyAt1j63j9Ch8txeCMY2hWDHxFSNSmqBmdbHr3A==
X-Received: by 2002:a05:6102:5c3:b0:349:e2e3:9f44 with SMTP id v3-20020a05610205c300b00349e2e39f44mr17962403vsf.57.1654679995580;
        Wed, 08 Jun 2022 02:19:55 -0700 (PDT)
Received: from [192.168.0.24] ([88.126.57.132])
        by smtp.gmail.com with ESMTPSA id s11-20020a67ce0b000000b0034bbe2e0b56sm825462vsl.20.2022.06.08.02.19.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 02:19:54 -0700 (PDT)
Message-ID: <96408912-aaa3-ba55-cdfb-3e316ae6e324@gmail.com>
Date:   Wed, 8 Jun 2022 11:19:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 0/3] arm: bcmbca: add bcm6846 SoC support
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        joel.peshkin@broadcom.com, tomer.yacoby@broadcom.com,
        kursad.oney@broadcom.com, samyon.furman@broadcom.com,
        philippe.reynes@softathome.com, Arnd Bergmann <arnd@arndb.de>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, soc@kernel.org
References: <20220601022215.32494-1-william.zhang@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220601022215.32494-1-william.zhang@broadcom.com>
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



On 6/1/2022 4:22 AM, William Zhang wrote:
> This change adds the basic support for Broadcom's ARMv7 based
> Broadband SoC BCM6846. The initial support includes a bare-bone dts
> for dual core ARM A7 with a Broadcom uart.
> 
> Changes in v3:
> - Simplify dt-bindings patch subject line
> - Fix timer PPI interrupt cpu mask for dual core cpu
> - Remove unnecessary cpu_on and cpu_off properties from psci node
> - Add the missing gic registers and interrupts property to gic node
> 
> Changes in v2:
> - Add new line between entries

Series applied, thanks William! I will comment on the VFP fixup separately.
-- 
Florian
