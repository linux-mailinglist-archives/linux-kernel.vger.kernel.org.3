Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C894653CCA9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbiFCPv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245670AbiFCPvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:51:54 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E075964D5;
        Fri,  3 Jun 2022 08:51:51 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-f2e0a41009so11095828fac.6;
        Fri, 03 Jun 2022 08:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=UYOlwffmM58R+CDON6dZUZP/KSj/6r4KIPXsM0u8ZmE=;
        b=VOgs41OGnu8/HEni6b0RedGYYv75pBW6zF+P0KDI5RcRj1cWWmOmOXpL4o7uIZg8Ua
         QjoIaeR+tYQBm3ZqqKHvkIdPFagZqoAgR5VZVxD+1ifgGRslX0tq+RKtOk6l58HjcVAY
         yRY4eSbU1MJF0QirSGuOissb8c+8SMbEmUFN+ibu/b3SarDIzH7MH3u5nVtwjxsaolP/
         3lG3uC2X/BOoaHekWOLIpkcU4zD3WM6vNU0W3E/9eJNoaxBBNvyFSZd1STi5JMr33ZdW
         FVKs8O/DZxtH+Og5Z0KjPYXCXVCdZ9vzGribcZZXmUvHUsdY/HDrOeSN1WCoegoDg7cK
         x+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=UYOlwffmM58R+CDON6dZUZP/KSj/6r4KIPXsM0u8ZmE=;
        b=vrtwjv3UczBhPMz30UHSWCKmwwbPWAAhLPkkzdk3z2xN8E1q/YPldWyAuVSkhdDq+a
         P2H7xtlQ3M5+4rOSF8p7jzafKTFmEzrWWto4hVhFXbjm3t2SX0sWE7775/hZHV83J6se
         G23aFhjifEB1eQblN8WzB8qk++C1Sc4JGm7XlHUOlf0F3js3MIHuTwgYH2Jjt8bUzmHk
         U2dpY5FRSOW/qNIik1F4PVzoZz1yE1hmKyxsEsJvqm+HvE7R+hq+McVDO+ZKr2UEDl+2
         1Ai3NAq69zBJ4lDLEPRmFdUD8U2hO3vHnonh/84Q5gkNS8MJKH2elxzPMNx+V24g59Nk
         uW5g==
X-Gm-Message-State: AOAM5315D/L2ztgXAXVn1pvLwOE43jrKalpUqxqzFn8L+60hIIxwCYlP
        wGOgyVnJetTL7B7DYkumUz0=
X-Google-Smtp-Source: ABdhPJyrbh4+IGQTeLvGWmCulWznMsQdwLukWxlI2auunsMm3k4bLydWUbx2fg2chKsyxFGrBI72VQ==
X-Received: by 2002:a05:6870:e8c1:b0:f3:1b5b:f277 with SMTP id r1-20020a056870e8c100b000f31b5bf277mr5853755oan.187.1654271511173;
        Fri, 03 Jun 2022 08:51:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j12-20020a9d190c000000b0060b2972b503sm2156275ota.64.2022.06.03.08.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 08:51:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e669408a-727d-c1f8-cb91-05e950ec2881@roeck-us.net>
Date:   Fri, 3 Jun 2022 08:51:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
References: <YpncSXSTTyKGprLi@debian>
 <10f49cf3-3f92-e5e2-d69a-77c37f12a1fe@roeck-us.net>
 <DM4PR84MB19274BAD84AE7497C663F70C88A19@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: mainline build failure due to 6b47441bed49 ("watchdog: hpe-wdt:
 Introduce HPE GXP Watchdog")
In-Reply-To: <DM4PR84MB19274BAD84AE7497C663F70C88A19@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/22 08:29, Hawkins, Nick wrote:
>> I sent a patch fixing the problem a minute ago.
> 
> Thank you for correcting this. I had the compiler set to W=1, is there another option I should be using to catch errors like this?
> 

arm:allmodconfig reproduces the problem. I had seen it as well,
which is why I sent a fix. The key is to enable -Werror
(CONFIG_WERROR=y), not W=1.

Guenter
