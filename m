Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6CE4D6979
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 21:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347540AbiCKUcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 15:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiCKUcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 15:32:09 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4411C65FD;
        Fri, 11 Mar 2022 12:31:06 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id bc27so8370970pgb.4;
        Fri, 11 Mar 2022 12:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5YcRXOxif+S+AzHay+qQ1GwCYD0es2yHXPwCiyj+9d8=;
        b=o+S4a5dcBKiYB5VgQwrDRL8AZ1yUw1xwWPsBDarcrOGTaUllKKkvOeah+yPZZ10CuO
         yCF4NOPuTvt2qiEziZLP0FRsS1Ikr37oHtCnmvCOrTtI+kAaQGJ7f78BAeKdOFvGK5zD
         gCYTXSpsys7NFpRYICLbt729+2N1yVVF/lfMQ3Odpa2qrSiY0MijvqKSH/zRJDoSADbF
         WM7YWz3OxGERI0+lvl+FgD5I3yywI0bhX8dsT6pntLHKlh0qnMwOg/zgr3nqXHLWE0Kh
         w8ow/1qQZ3JYVCrj7mTByBfEBRPxXA4i9pzq38cxzsrhwfz8P26ScAFCeVotLsUu3NmA
         uf4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5YcRXOxif+S+AzHay+qQ1GwCYD0es2yHXPwCiyj+9d8=;
        b=7Cgc9WtDKPI/yCW0ClEy5H1us5t+8gv2HdXgWAAruCWlJLO38mfHIL+tFu5iFJlwK/
         CEaPdMgkJJ236DHxIlSAuYR5oBvB2wI9jdrDQ+p77hEh3YiujXkpiYEKx7sFXtVqwJTh
         IOWVchi+ofd4n9hAevKr6zT8qoO+iaFXcoWeXfY/SVF0iWxjNyalQ3X64IayzIW1lBK/
         tZaHN1ZCeISDvPD0Ld0Sv33R3ZeO/VjF63gBPRK65f0Md7IVhuznVXPilNM806EdsyII
         KPwpIuX4ZAMbceM9UkIwu+V1RgXZV5JVhQ0WoSURBRzjlTYaNyrKHi0wYfXZPeTho8vt
         koMA==
X-Gm-Message-State: AOAM533QxBBBvVviHl521862yhL+Izv85wmprcwuJ70p2LmyoQQBmupo
        hbv6jcwfcNZIXs7RdHu248M=
X-Google-Smtp-Source: ABdhPJy1U9OdHjFPsH8cVEDJNBdRaTiPrlFvq8RJGpbTycdIObzurn1VAxGv3lLCsiGCdq2gYgxUNg==
X-Received: by 2002:aa7:91ca:0:b0:4e1:fe3:5da6 with SMTP id z10-20020aa791ca000000b004e10fe35da6mr11872443pfa.85.1647030665318;
        Fri, 11 Mar 2022 12:31:05 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id m12-20020a17090a414c00b001bf6d88870csm10211884pjg.55.2022.03.11.12.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 12:31:04 -0800 (PST)
Subject: Re: [PATCH V3] tty: serial: bcm63xx: use more precise Kconfig symbol
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <20220311093233.10012-1-zajec5@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <713b803d-2e5f-244f-ef08-4b5c743f37d4@gmail.com>
Date:   Fri, 11 Mar 2022 12:30:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220311093233.10012-1-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/22 1:32 AM, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Patches lowering SERIAL_BCM63XX dependencies led to a discussion and
> documentation change regarding "depends" usage. Adjust Kconfig entry to
> match current guidelines. Make this symbol available for relevant
> architectures only.
> 
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Ref: f35a07f92616 ("tty: serial: bcm63xx: lower driver dependencies")
> Ref: 18084e435ff6 ("Documentation/kbuild: Document platform dependency practises")
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
