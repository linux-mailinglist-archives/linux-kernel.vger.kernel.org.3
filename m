Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D82465749
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353100AbhLAUpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352983AbhLAUoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:44:07 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65949C061758
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 12:40:45 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id g19so25758417pfb.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 12:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B2fG4Fj+Pcq2JOlCeTCx4gjvN3R1W+eefnyaZvsGg5c=;
        b=BCPH3GEF8eWIAWD82BEB2uW7vZ9j/Q5YzJrWJ1y9XKL8y+KlzxmQB+Iw+K5+3XUqqI
         twfIHL+B9kFiQtmHAZpg91Sl0tcc1R/x/uz4R0lKj289UL5ahBGQczFq/xr47rEsfDZJ
         HqM7Di8pgaSvtimbSWNIma6SH+L6hLUWUP4EwDRJVcpouniozMDF1Z3KtKnqh1eNmgQn
         lZ2+yB/gEI5HWoltztHM21VXR5EmIcQtD3rNagTM9QilgbOsL7gv5aMmu0rWR4bh7bEL
         jSwTkaKgmAG+tE1MzZzPb4Ik+VMPgeYpKsxVPvyPp+dgxV68uhaiqDliWF1dMYRR+y5o
         xHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B2fG4Fj+Pcq2JOlCeTCx4gjvN3R1W+eefnyaZvsGg5c=;
        b=56OJN549a7rUEqKjonMyQ4G2BdSqOrzlmWsSdSppi/IDZuyGs1iE2zG/g7Mxl49krJ
         awdFK3Src5agoxrMLx8QpISi0zTxqO1Rva4gCEnICj4/EMdV7WIlioHfUjro4KGQ0dW0
         9u/dCm8yutnmZBUi0EG6S+ve5Da+PLF1O4K/wfNd9NC2nQ093V1r6o2RaN6D29dE5Wh+
         5slmmrDx3Uw1uUQSBd0/qw2TTjn/5wZ4b0pPg3Itx5f3plYV8I6gmJ6l7pP0Z/hyPlQD
         7UOzmagAZAJrDee8x0vZqu2iDldplthD5Fk6rzluJ9+pEtmGx9Qzsw0I0f0YiiG8Oe0U
         qdGQ==
X-Gm-Message-State: AOAM533RNqF1b95s6KYqno5faFCc7FHdwU7NZ+KAzqkGab09gQSc+Y5T
        fvjp2jIbBScjcf/64G4xgoc=
X-Google-Smtp-Source: ABdhPJzRao+DF2XDngmzL2fnX6NCq8JUujCpFBXb6TagU2UqXzC8iYCVJJNcqmY1uAfRuJHUZj3x4A==
X-Received: by 2002:a05:6a00:1409:b0:4a7:e94c:9309 with SMTP id l9-20020a056a00140900b004a7e94c9309mr8455586pfu.40.1638391244903;
        Wed, 01 Dec 2021 12:40:44 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id j127sm715094pfg.14.2021.12.01.12.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 12:40:44 -0800 (PST)
Subject: Re: [PATCH 3/3] phy: broadcom: Kconfig: Fix PHY_BRCM_USB config
 option
To:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Vinod Koul <vkoul@kernel.org>
References: <20211201180653.35097-1-alcooperx@gmail.com>
 <20211201180653.35097-4-alcooperx@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <4c9c9d72-7830-1f06-c398-16d7c1e81c94@gmail.com>
Date:   Wed, 1 Dec 2021 12:40:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211201180653.35097-4-alcooperx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 10:06 AM, Al Cooper wrote:
> The previous commit 4b402fa8e0b7 ("phy: phy-brcm-usb: support PHY on
> the BCM4908") added a second "default" line for ARCH_BCM_4908 above
> the original "default" line for ARCH_BRCMSTB. When two "default"
> lines are used, only the first is used and this change stopped
> the PHY_BRCM_USB option for being enabled for ARCH_BRCMSTB.
> The fix is to use one "default line with "||".
> 
> Fixes: 4b402fa8e0b7 ("phy: phy-brcm-usb: support PHY on the BCM4908")
> Signed-off-by: Al Cooper <alcooperx@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks Al!
-- 
Florian
