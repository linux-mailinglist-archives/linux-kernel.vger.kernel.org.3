Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58112483590
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 18:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbiACR2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 12:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbiACR2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 12:28:08 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67ACC061761;
        Mon,  3 Jan 2022 09:28:07 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id r15so58975097uao.3;
        Mon, 03 Jan 2022 09:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PYGbrhrQYdiiSYIr0MXbuo0UU4USUTz6W+z6yxq4FV4=;
        b=BnZOr5EU2lrKnxSQmroAAnfq6BcslDRr2J5u3MctuVOdiaJVPVhfDuZVLIowJcd7AP
         iMcS7BhWGfWVqvqOURttEr9A359GHzprrxoLFo7MhWGYomSBrsFfFVJcF+zu09hqFgF+
         VPNiJR/4/gEN/6cLIFabbwQOgL883J3z28RJuZPDI09R/Wm1q87XJZMcrbO2yFWyufzN
         HF5MB84rHskI35EkAuMSOhIClhVvzErUlBEc8P9yKE3zyYjmbRAZBefu5oGf9OW6vwKo
         JyLczSQlRVPLpFEm1MAxwj0+HsOYsN8K3+KytAhcgynmKjd/XkyuvCxmDqchbgTzFb1Q
         p76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PYGbrhrQYdiiSYIr0MXbuo0UU4USUTz6W+z6yxq4FV4=;
        b=nEIlVxFSsVFY99LRNWJA6dhgoh5PSav6076dS3IsDIYPKslL6g4bkokdSU9Hp6L3o4
         Dhm3ppvAdq0xtZlRbPLpMbEFO9an0nQdImZlMbTkQyNFWSLqLb32AbRQTIzYSHekSt6a
         vAqsMXPac9zsW4zNQTPmBVCS7Vk/p8gpDHkj2vDwSUvfBNX28y70QyVGNUoneRq3OKKf
         /BY4o54QE+CTs1uqMpKgUlTbbwbfN3Wb+ET4jLfag/qZ7zjsCsTW6+WOWWxpejLISiFY
         DkfBRd3l04pNL1LM+zvsu39dmS3pwadrzmQW6eIzbdPVmmQ9JGV4jadrAFnmmd/Iiodg
         aYNA==
X-Gm-Message-State: AOAM531ZTR3WCTCqnSAMTaUuyMY/oyBLbKiR4EhDnPC/tJMIR2JgSZYd
        7lN1/H+j1p/CxeNxJdqmdHs=
X-Google-Smtp-Source: ABdhPJx2RSQhS+KuqJ+EMKRyl3I/xAbCf0zk5fLf9kfioM02gpzSAtHML+uEAGGas4nMSNqtZuqPCQ==
X-Received: by 2002:a67:c81c:: with SMTP id u28mr14740609vsk.71.1641230886268;
        Mon, 03 Jan 2022 09:28:06 -0800 (PST)
Received: from [10.230.2.158] ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id h26sm775182vsl.21.2022.01.03.09.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 09:28:05 -0800 (PST)
Message-ID: <ca7eae05-899a-7805-6e6e-9fbdb2b83dd3@gmail.com>
Date:   Mon, 3 Jan 2022 09:28:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 9/9] mtd: rawnand: brcmnand: Add BCMA shim
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Colin Ian King <colin.king@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM SPECIFIC AMBA DRIVER (BCMA)" 
        <linux-wireless@vger.kernel.org>,
        "open list:BROADCOM STB NAND FLASH DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>
References: <20211223002225.3738385-1-f.fainelli@gmail.com>
 <20211223002225.3738385-10-f.fainelli@gmail.com>
 <20220103181225.20a60d82@xps13>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220103181225.20a60d82@xps13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/3/2022 9:12 AM, Miquel Raynal wrote:
> 
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_AUTHOR("Braodcom");
> 
> Small typo here :)

Whoops

> 
>> +MODULE_DESCRIPTION("NAND driver for BCMA chips");
> 
> NAND controller driver, I want to enforce this *controller* word
> because NAND is way too vague and refers to nothing specific.
> 
> Plus, it's not really a controller driver that we have here, more like
> a glue interface.

Certainly, thanks!
-- 
Florian
