Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FD251D2A7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 09:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389749AbiEFH66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 03:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386640AbiEFH6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:58:52 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DB267D0B
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 00:55:09 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id p7-20020a05600c358700b00393e80c59daso4856290wmq.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 00:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=fGiYCF2iw5t4VtH5jxb71hCLielghGLBGlvL9ckdnuk=;
        b=HDf5cH9w7G+JBlziGdc4NZXV/Bl8VMVD4v/0jrGsIwWz5NYvLAQiFnPEmBoFsefeYO
         sztyl5l3CnuKRyfgcmlntK3uO2Uh9qRQ2WVhIS+x3SMuT64wNnk7r/pLCTYNUSYIfyUa
         GgQS6XxeKpAkTkvg1zvrVI7ngmX6YfRKyw9eWZ1eoi5BD2v5M+HqyipHoAE26Y48TGAE
         oujwYlhZJBPJYX1VZP3NZZd0iizRFCD5qGVVtvr++gjmvLLoYFZUqq5+5xVj8iixhKGO
         46xpw2wOlxEc0haZbvZ9x3LUU3d1/MiRGsHt6zDrTSugr6+ECDUHhI4Lg0cYDE7T9MT2
         RI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=fGiYCF2iw5t4VtH5jxb71hCLielghGLBGlvL9ckdnuk=;
        b=qVEqTosD4EAYZTmBy6K7m1CUVFDKW+XF8GrSs8+UZzhu0RVSGelMS9opIXYokZ85s5
         Ns0+rTt6apSGNbNloH4rAfkOtXXytpWiBmYJGJrlrzBD2N04EeeIlxASzJw7LG3vQZja
         XN1IqGURz5QAwe9/9GrhXaiu1vb406AHoOUf5wAVdGFzmhz4yXTmbE5fHsqFQrHo2AeZ
         y0mrWlISePMk3VNAihrHQcxn9O+AqA6RotyqmNd2P6Szb2b4tJ3vfFEF45EEdZfCw8I6
         Gd+7gnomoloWXaNjBftTgxsa7aSc0GTGthwRUULwAir4PTldVzo0BUQHWICN1fFjAwtU
         jm1g==
X-Gm-Message-State: AOAM532UGGNNELR3B5Xmob9I6HXhpPXExYjpN8A+MqLr0H7xK1g1vbe+
        7Jmw+IFMPMosRTASshYQYtIrMw==
X-Google-Smtp-Source: ABdhPJxXUWYFj9gN67iP4+AdZg3KlNlbI6sMi3eGWQ9KfpsoSreGWKSf6vkbdnNjGdQ1YfZ1QGmKqA==
X-Received: by 2002:a05:600c:3b24:b0:394:7b59:dfd9 with SMTP id m36-20020a05600c3b2400b003947b59dfd9mr1343514wms.129.1651823707491;
        Fri, 06 May 2022 00:55:07 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:56b7:4b6b:7ed:112a? ([2001:861:44c0:66c0:56b7:4b6b:7ed:112a])
        by smtp.gmail.com with ESMTPSA id l13-20020a7bc34d000000b003942a244ebfsm3373135wmj.4.2022.05.06.00.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 00:55:06 -0700 (PDT)
Message-ID: <ca6b70a2-9bcc-fb86-200c-e1714c9d53be@baylibre.com>
Date:   Fri, 6 May 2022 09:55:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH printk v5 1/1] printk: extend console_lock for per-console
 locking
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-amlogic@lists.infradead.org
References: <Ymfgis0EAw0Oxoa5@alley> <Ymfwk+X0CHq6ex3s@alley>
 <CGME20220427070833eucas1p27a32ce7c41c0da26f05bd52155f0031c@eucas1p2.samsung.com>
 <2a82eae7-a256-f70c-fd82-4e510750906e@samsung.com> <Ymjy3rHRenba7r7R@alley>
 <b6c1a8ac-c691-a84d-d3a1-f99984d32f06@samsung.com>
 <87fslyv6y3.fsf@jogness.linutronix.de>
 <51dfc4a0-f6cf-092f-109f-a04eeb240655@samsung.com>
 <87k0b6blz2.fsf@jogness.linutronix.de>
 <32bba8f8-dec7-78aa-f2e5-f62928412eda@samsung.com> <Ym/Z7PYPqvWPEjuL@alley>
 <45849b63-d7a8-5cc3-26ad-256a28d09991@samsung.com>
 <87pmktm2a9.fsf@jogness.linutronix.de> <87a6bwapij.fsf@jogness.linutronix.de>
 <87zgjvd2zb.fsf@jogness.linutronix.de>
 <b7c81f02-039e-e877-d7c3-6834728d2117@samsung.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <b7c81f02-039e-e877-d7c3-6834728d2117@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/05/2022 08:43, Marek Szyprowski wrote:
> Hi John,
> 
> On 06.05.2022 00:33, John Ogness wrote:
>> On 2022-05-05, John Ogness <john.ogness@linutronix.de> wrote:
>>> I will go through and check if all access to AML_UART_CONTROL is
>>> protected by port->lock.
>> The startup() callback of the uart_ops is not called with the port
>> locked. I'm having difficulties identifying if the startup() callback
>> can occur after the console was already registered via meson_uart_init()
>> and could be actively printing, but I see other serial drivers are
>> protecting their registers in the startup() callback with the
>> port->lock.
>>
>> Could you try booting the meson hardware with the following change? (And
>> removing any previous debug changes I posted?)
> 
> Bingo! It looks that the startup() is called when getty initializes
> console. This fixed the issues observed on the Amlogic Meson based boards.
> 
> Feel free to add:
> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> Best regards

Thanks all for figuring out the issue, perhaps other uart drivers could fall
in the same issue if startup code isn't protected with lock ?

Neil
