Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C01473B4E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 04:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbhLNDMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 22:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbhLNDMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 22:12:09 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96CBC061574;
        Mon, 13 Dec 2021 19:12:09 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id y9so3053679pgj.5;
        Mon, 13 Dec 2021 19:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=quoR+TZ/qpdjmw0cQ/LVqVjG7Bub9Md1PQ4Qq09DCq0=;
        b=Oc459qZZJkOYSlCEcviZfTFtW5PeeKXISKGhw1BzRWPLEk6jZh+jD/eHoSL7kyR5yC
         zmmPTKmOHULKtkiVmSXo5btVMgp64Vb1ppMs3byI4aFl+i/x1LrGfYVVLYjTmTTYK4ac
         81ldzWhbxn5jMvoosIl7z2GD3P/IdI8QaJBd/0oVl7HqUdRAy+6W1tVr7Esemulp48Dw
         TJGYykC+kYX/EZR1lLGWtcsqe4kUFNXdD0hUITTHX7WrP1d7JWyke3suVHZKMslGVogw
         oZIL/JIyqQWonCZ/El7Ck/q1hVG4DMn1/jOASlYZfdMuG6ZcgzWPqv4qtgBkagOjyKbf
         KANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=quoR+TZ/qpdjmw0cQ/LVqVjG7Bub9Md1PQ4Qq09DCq0=;
        b=GeO5nSTsCLxpIoccBRi4/R8ueAfxaN26UYzoMYbnYPJ5itD3+225SKq/fziWxDQV8U
         ztELxno7AZAibtDEdvTHItDkqnGHoDD8SEKsX/1e/qjA6FA0MTUhmH9ho3838FTB8Pwg
         5XVy7iwiU5RiMkFQ2bc9oW6pNhbqn9sQ5yOjE+FGLYaaV2D7XgWs6zpIPd95mZtEUICn
         ZyiqVfEEjZNG0K2ToLrqO+luSStpjiKTZq2GLpvv/STPp8TqSFrwjSEwDtQXHmHJc+bl
         5M6U+yPbHmcbgWUR4kJNiB4PJj2ZX/XX5zgtWtZFcLhwMTGZ0JnDe6o253xDolS/y4zI
         L0yg==
X-Gm-Message-State: AOAM531EhtCmd/apMqeF/aNX9CSOIEO7iFFe7cvDjmRa2k11hAMmnyQL
        iy6I8wP6BPHx8KxaQe8M7SJUS3/n/p8=
X-Google-Smtp-Source: ABdhPJwzKHAdAmOr2NG3LeFomsLpG0Uuo10dMwvbuEwcDi4meuYIgvvnBpbtlhQsPeh95nCka5jePw==
X-Received: by 2002:a63:8f06:: with SMTP id n6mr1901633pgd.95.1639451529088;
        Mon, 13 Dec 2021 19:12:09 -0800 (PST)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id q2sm13825449pfj.62.2021.12.13.19.12.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 19:12:08 -0800 (PST)
Message-ID: <b7f4804a-01dd-9dd9-01f1-2187a955cb13@gmail.com>
Date:   Mon, 13 Dec 2021 19:12:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: linux-next: build failure after merge of the gpio-brgl tree
Content-Language: en-US
To:     broonie@kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Xiang wangx <wangxiang@cdjrlc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-gpio@vger.kernel.org
References: <20211213203112.969238-1-broonie@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20211213203112.969238-1-broonie@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/13/2021 12:31 PM, broonie@kernel.org wrote:
> Hi all,
> 
> After merging the gpio-brgl tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> /tmp/next/build/drivers/gpio/gpio-bcm-kona.c:508:34: error: duplicate 'const' declaration specifier [-Werror=duplicate-decl-specifier]
>    508 | static const struct of_device_id const bcm_kona_gpio_of_match[] = {
>        |                                  ^~~~~
> cc1: all warnings being treated as errors
> 
> Caused by commit
> 
>    19784a059cf47b ("gpio: bcm-kona: add const to of_device_id")
> 
> I used the tree from yesterday instead.

Doh! Should have double checked the code as the diff was not giving 
enough context. This patch should simply be dropped, not even build 
tested by Xiang it seems.
-- 
Florian
