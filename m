Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585E7481436
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 15:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240410AbhL2Org (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 09:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236856AbhL2Orf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 09:47:35 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E873C061574;
        Wed, 29 Dec 2021 06:47:35 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id s1so44902096wra.6;
        Wed, 29 Dec 2021 06:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8pVmwUNsObc+mIv19XaUYVEFYop0fMlvWAcN7inSu9c=;
        b=jGZL2VVjGjMsymL0YjKuOjKzT8fcP+CYLyFrisqpWg1ExetEuwrsgnxOyTcC1MbDNa
         3nCgmy3qmMGmm2h/AKQQOFSZ1eMYRscOCGZWD8AnPg4yiLj0PHyjr9ytlgKyP8TKqmTr
         3/O56tXXrdyCKUqz3wB4BXZTO0Q7HnpR0eApxIAwHCdXGVX5aQa9j7iFlfh9MVEjdULm
         +aBm8NfEqQoiwAPpi4ImyCpNtchaXsTmI1CcmA9azt81Kgm/oItbRnwYs/kBgOAjr9Dq
         7Dhlsf/nwMbMpTD7bUJxwykjdZp/qJke1aALCvCy19HQ27nDW14sikKwi/K4IZJaQZ29
         9x3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8pVmwUNsObc+mIv19XaUYVEFYop0fMlvWAcN7inSu9c=;
        b=TZMShMnNN/sr+L9pTWx6DFVtZizfjMbiI81zwt4zksSVPct1uB9gq/1L/4pqJQSmqo
         SRFh4C2qh+EOJ/qWMRbrUJ5Oq+WlIJ6OLeeExbFh8Zlr35akhGPwPgg4PDNrZnEczHDt
         FHHtt1nqWgqjvgGF0DtnxD8+XmEuSNe3MP24sCWQh2yWoQ6c66N7MgRh5EUwjcM6oYtK
         TMFsyXdQXxZHbGjO7ILQF/ePuW+/PXI3/++4yvw1FRoHoGHZoI1YTPmuEcBNkoZ0QXte
         lgvwz+mfGT0cvamsHKJ6FRWZJETAtX5cvE+c/VvG3YNSNXyRiJ3TPPJdQQqPFsLuWhs0
         S1Tg==
X-Gm-Message-State: AOAM531IVmtC47uGuSkXcYUYMC/7gcbF3KAp9MLsKA+WAhVijk6gd0B8
        WbWKi/rfj5s1sG7NZWTdSAk=
X-Google-Smtp-Source: ABdhPJzRcKJI3ftPV2yRZHTj546iiSelANDcMkkltqWi0ueohf9VwK+G22gfHh0QbM1svBryC6MNyg==
X-Received: by 2002:adf:bbd2:: with SMTP id z18mr21770585wrg.118.1640789253854;
        Wed, 29 Dec 2021 06:47:33 -0800 (PST)
Received: from [192.168.2.177] ([207.188.161.251])
        by smtp.gmail.com with ESMTPSA id i15sm10694746wrf.6.2021.12.29.06.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Dec 2021 06:47:33 -0800 (PST)
Message-ID: <b5d0858e-7a70-5a60-b361-12c842068bc5@gmail.com>
Date:   Wed, 29 Dec 2021 15:47:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v8 01/14] dt-bindings: Add vendor prefix for Airoha
Content-Language: en-US
To:     Felix Fietkau <nbd@nbd.name>, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     john@phrozen.org, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211220211854.89452-1-nbd@nbd.name>
 <20211220211854.89452-2-nbd@nbd.name>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20211220211854.89452-2-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/12/2021 22:18, Felix Fietkau wrote:
> From: John Crispin <john@phrozen.org>
> 
> Add vendor prefix "airoha" for Airoha, a subsidiary of MediaTek
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Bert Vermeulen <bert@biot.com>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Applied to v5.16-tmp/dts32

Please add the linux mediatek mailinglist for any further patches so that I can 
track them.

Regards,
Matthias

> ---
>   Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 66d6432fd781..025df36aee5f 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -59,6 +59,8 @@ patternProperties:
>       description: Aeroflex Gaisler AB
>     "^aesop,.*":
>       description: AESOP Embedded Forum
> +  "^airoha,.*":
> +    description: Airoha
>     "^al,.*":
>       description: Annapurna Labs
>     "^alcatel,.*":
> 
