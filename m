Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A58494E7A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 13:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244544AbiATM7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 07:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237067AbiATM7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 07:59:54 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2F6C061574;
        Thu, 20 Jan 2022 04:59:53 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id m1so21357735lfq.4;
        Thu, 20 Jan 2022 04:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LsmckIhI4rAR2wBGS0GbJd6b2Xr2c/U/68CeWyncqcA=;
        b=YzqLYvoBCsUBhWov+dYz9LNmT70qVxSj+G4GHIh6zRcgXktSuRKn6RiJM5FXIzJDz+
         leoMlA7y9fBhMFW2a8tLX/qBJYDGotwpgq2UsqSI2lkDZPnZJgifwW3GBLubfP+OOrFK
         sKpExBmAvhJL8Zd7v59DW11zpDSNm1+VQSPjP6x40fMG4vjoo4T185xht6Ln+b1fe+KN
         HaC+szCJyuIqyucXrJqcjpVgdbBBsKXAWEelr7B6UYL95HGssmmFxoXEm5RcWKjHbO9V
         6BBrMEQGeCzOwgd3GUsXIT1cxvDYPijW0Aa0gryj0EhLJ63tarAuwLjUpM02aoXFV/zb
         U37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LsmckIhI4rAR2wBGS0GbJd6b2Xr2c/U/68CeWyncqcA=;
        b=kLZYJRC6dzZBXv8mT9ba9dn2q34nS0hxKCOe9snN45e3OUbRblUFtbJi98dUHSeGrc
         OrZZ8AQkEYi/5KPSX2HsOm/iwq0PyLz944CYR4lGybouLmVXmKaWoOH4u0XP5EmO6f/u
         ylGLouBmyad3kiqLIdffF1R049pLaAQxGT4KH8DT0v6ipUsF8QqXu/DvLbuo+HJX3If0
         MvaIHHc7eIinRUpHKCcM/osqcYhAEZ31ilC1CDuoDcaZOt1NCO6n9QOG6c4r3RuemJQS
         TTFQ4Vm4mKRghS6WD5ofxQN94H22bVpzZGK/vAft/2poyNFBVViz39ePUPJDOMedKUTP
         QQSw==
X-Gm-Message-State: AOAM530xIxfU7njws14ymWPizWkiRZeGA6SG0ljC5SJh9bo1T+eenOQp
        5k3xwp1SxuwMbg+XHKeA3vUN5vBTBa8=
X-Google-Smtp-Source: ABdhPJwFfQkBgrktKE3ju6bGfP+W7sKeTkfRmdmm9IaX1Ybzae/qv3ZGsSRrv49/hXVQMWFKOfCzQg==
X-Received: by 2002:a05:651c:1a29:: with SMTP id by41mr19572266ljb.151.1642683592339;
        Thu, 20 Jan 2022 04:59:52 -0800 (PST)
Received: from [192.168.2.145] (109-252-139-36.dynamic.spd-mgts.ru. [109.252.139.36])
        by smtp.googlemail.com with ESMTPSA id p25sm351459lfa.49.2022.01.20.04.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 04:59:51 -0800 (PST)
Message-ID: <cd7a212e-71ff-90a6-d3dc-1391567fc113@gmail.com>
Date:   Thu, 20 Jan 2022 15:59:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Patch V2] memory: tegra: Add MC error logging on tegra186 onward
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        krzysztof.kozlowski@canonical.com, linux-kernel@vger.kernel.org
Cc:     Snikam@nvidia.com, vdumpa@nvidia.com
References: <1642669368-20605-1-git-send-email-amhetre@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <1642669368-20605-1-git-send-email-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

20.01.2022 12:02, Ashish Mhetre пишет:
> @@ -521,23 +535,64 @@ static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
>  
>  	for_each_set_bit(bit, &status, 32) {
>  		const char *error = tegra_mc_status_names[bit] ?: "unknown";
> +		u32 status_reg = MC_ERR_STATUS, addr_reg = MC_ERR_ADR;

No need to initialize these variables, since they are always initialized
by the further code.

Please write it like this:

u32 addr_hi_reg = 0, status_reg, addr_reg;
