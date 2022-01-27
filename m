Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A269D49DBC5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 08:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237420AbiA0Hjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 02:39:41 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:35389 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiA0Hjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 02:39:40 -0500
Received: by mail-wm1-f50.google.com with SMTP id q9-20020a7bce89000000b00349e697f2fbso5287874wmj.0;
        Wed, 26 Jan 2022 23:39:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RKtXYPsL4FZx1b/8XEZmhVsP2QrG7CtPdAKDsf7DNCY=;
        b=j3iqjmGGQbdhl4+Pej5EhtyMSFoj+751UKW80HKAERhgLaCVhAqVdspL9e6KwxXniR
         kdn49lbVhzIMurgOcKsLWpZIujow06b6HiJUj7WsW3ahmjmH2r3IuGnBPrWlUKMLlogj
         LRlgcPi6VJISlNvyH+uuLSsUFxXJBczY3YYLZiurkemdBPea18WujjOR3zN1v5bUEiRU
         cA7s5pfEZD/vj585wThub9tlxm6s6BIuca56Ek+h28aQkgA1v1qMyn31kILT95HzVCMF
         TcJ6qkE0hgfRbKhLvyW2UPj1qblDzWo9Z6wYNqxgDyg9K1eVMJAbPP3SPcbcOylu9l2X
         2klQ==
X-Gm-Message-State: AOAM5322LWiEoQHegiqKEzDok//ZXwp50ouYkunTJFnY6QzBQgNwmhq8
        dRN4uQnXrub2UwFRpGGxpBG1B1JoweA=
X-Google-Smtp-Source: ABdhPJyYtaNmBS17DR5zKwadnAh9GK2L3GMOJ0jvXvo+B0ukC9ovbS6TS767qu7y8iqTB8vC2kZYkA==
X-Received: by 2002:a7b:c08b:: with SMTP id r11mr10600482wmh.111.1643269179433;
        Wed, 26 Jan 2022 23:39:39 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id n11sm13771930wms.3.2022.01.26.23.39.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 23:39:38 -0800 (PST)
Message-ID: <cbf04c3c-b2d6-f818-cf23-a5a8e2fb727e@kernel.org>
Date:   Thu, 27 Jan 2022 08:39:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] tty: Replace acpi_bus_get_device()
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-serial@vger.kernel.org
References: <7355105.EvYhyI6sBW@kreacher>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <7355105.EvYhyI6sBW@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26. 01. 22, 20:55, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Replace acpi_bus_get_device() that is going to be dropped with
> acpi_fetch_acpi_dev().
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

thanks,
-- 
js
suse labs
