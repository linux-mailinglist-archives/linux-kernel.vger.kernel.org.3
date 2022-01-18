Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE28B4922D4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 10:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241428AbiARJgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 04:36:14 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:39883 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbiARJgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 04:36:13 -0500
Received: by mail-wm1-f51.google.com with SMTP id d18-20020a05600c251200b0034974323cfaso4195976wma.4;
        Tue, 18 Jan 2022 01:36:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lta+WiuGF7fVL9x+wdfLW8Dwz6jPkLm8BCBCGdScuOQ=;
        b=aMmq4LXNO5J9jAk6EPj6C3DKeGO08HCU2Of4J3NtI+vxZ05hY5gwv8VJ0PG3GPv2Y0
         9HZUK15+1Bmu8MTeSYQR+4Cd8ZTdoyuht4yk5yScPSbLyzCN683LnEBFJlBh/07X60CY
         PUrcFbAn+UaH55K643FHJHDkkOtjWJqU9xTWTDvbnRXJIgXwxBWVqi6G4lENLcluy7gm
         8rIL8aNvMQoIOrSyDFJpx0MTlxpTrCEnGpaR7WlHlM6BiOPXgGWsru7ZwSMJEW9J4Cav
         M82X8WzATCPShYyAoT5fdM6V+l/Xu/rqw/S9BSirClJcQbKSnoRiKg1DGMrotTmyeowz
         YUdA==
X-Gm-Message-State: AOAM5311w0gV/yJfVthRVoPdxQq6xoIAE2+yQTEbQekCy0sXaIrw09Z3
        60sbcLSLh7Oh/7cM7aZAZR0EyRXF/IY=
X-Google-Smtp-Source: ABdhPJwfz5XfSzdygUoU4zgOvnVdt80kU0t1wt1KF/ylE/SZrny+8imsIAGG4/JngREUP8gG00Ej8Q==
X-Received: by 2002:a5d:6d04:: with SMTP id e4mr5456617wrq.406.1642498571862;
        Tue, 18 Jan 2022 01:36:11 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id l25sm1730544wmh.18.2022.01.18.01.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 01:36:11 -0800 (PST)
Message-ID: <97dfc8b2-fded-01df-44e9-b24988a76d54@kernel.org>
Date:   Tue, 18 Jan 2022 10:36:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V6 2/5] tty: serial: meson: Use devm_ioremap_resource to
 get register mapped memory
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
 <20220118030911.12815-3-yu.tu@amlogic.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220118030911.12815-3-yu.tu@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18. 01. 22, 4:09, Yu Tu wrote:
> Replace devm_request_mem_region and devm_ioremap with
> devm_ioremap_resource to make the code cleaner.
> 
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

thanks,
-- 
js
