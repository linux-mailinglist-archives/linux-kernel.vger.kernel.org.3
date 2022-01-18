Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA704922D1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 10:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbiARJfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 04:35:54 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:54970 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiARJfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 04:35:54 -0500
Received: by mail-wm1-f44.google.com with SMTP id p18so26241987wmg.4;
        Tue, 18 Jan 2022 01:35:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yqez6OLbU0LlAXxQc+U5YEFdroOkgDkm+OsLc2FpZLM=;
        b=Jfq3JX9YbSwzYN1sRHCNJzsA2f9IGdiqECp29KGSNkqWqDJ7TXWZMHlttmxSuQfP4Y
         IOM2/5Jm7YPDuac9TLTgxSUQ15tYm5wgezKBp6jd8BDenthzzg5qyQIxSYl2DfGWn1GF
         QkpfpSaIwAVmWBq4VPjXz8mrYIbPRl9ociO/qOa33URmLjUDV30T4EdzWdTqLwp+9waY
         2iDCkBGozsjDz3KdvQPSDQfHPjXXZQpmnt0zpQ0s8mP07EpYRL858+pXjVxPhsrnwXpR
         ElJeFo+h2uKCGSxKXC+IBpyCuQg/gPShWUay75RQcdQZaPkcNm1ZJgw8SX7dtNy4vKPC
         OE+Q==
X-Gm-Message-State: AOAM531xZMwi45+YCtDntDe7ElL2+iXkW8p2LAPFG2Xm0XeUWtsEkyEf
        esGlyqY8lqvvdFo5F15Scec=
X-Google-Smtp-Source: ABdhPJypw/3o2cvOYuXKhhFw3KtkqwS2GkT6q7D0xEF+rhwbailgasqnqmJlHUgSlb+vYQuY3lv6Mw==
X-Received: by 2002:a05:600c:6013:: with SMTP id az19mr18079459wmb.53.1642498552982;
        Tue, 18 Jan 2022 01:35:52 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id t15sm15652797wrz.82.2022.01.18.01.35.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 01:35:52 -0800 (PST)
Message-ID: <a7267804-1400-c63d-50a0-72423f141317@kernel.org>
Date:   Tue, 18 Jan 2022 10:35:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V6 1/5] tty: serial: meson: Move request the register
 region to probe
Content-Language: en-US
To:     Yu Tu <yu.tu@amlogic.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220118030911.12815-1-yu.tu@amlogic.com>
 <20220118030911.12815-2-yu.tu@amlogic.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220118030911.12815-2-yu.tu@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18. 01. 22, 4:09, Yu Tu wrote:
> This simplifies resetting the UART controller during probe
> and will make it easier to integrate the common clock code
> which will require the registers at probe time as well.
> 
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

thanks,
-- 
js
suse labs
