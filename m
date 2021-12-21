Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1BD447C457
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240097AbhLURAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:00:37 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]:37513 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbhLURAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:00:36 -0500
Received: by mail-qk1-f169.google.com with SMTP id m186so13173261qkb.4;
        Tue, 21 Dec 2021 09:00:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hppWg+GP3gWKz2SnHpLcfxKFRiULg/7tXUCt9Pb6Dtw=;
        b=YhNfGJqvR7HmU+SZuRaiqqA3BwOqnDcRKhfrqyVwCsSZ7po+iuOYSKq9NfBx+MlX9w
         9JntaGYgW0gxakjb17ST6xGalt+yNpffwEqgketLSleSijNp4Cql1kgZhWjvmRybcmmi
         8zN7SddQjneAh1LzxucLtNDX9wSZB+JVvHWKsdf9O8BQJ6wvP1i3olFfpAZIsd9kpQxN
         YRB6Cssb5NByluYNoGcH/PXOfyJ0CjfHid8GxsA4ixXRjAYNT0HPx0mKYefFlG99pGse
         k1ADOCANqlXMKM2xxxwhwrb/RD6VArm3OnFVtU7IfPszwyZQMvI4AFBMOBkzfT56/LN7
         OGdA==
X-Gm-Message-State: AOAM531AgzmauqSMsiy7IRt+aEyL7IVsagcotLK9sKW0gkGX2NcAduue
        S5kG1CDK4UWG0pgTywNOog==
X-Google-Smtp-Source: ABdhPJy9Ijw3JTHq6M8l2dQq/+DijjJRegt9T5f4n4IacLZGw6vjlaabB9NNgyBoqSHkr1oDMj4OHw==
X-Received: by 2002:a05:620a:301:: with SMTP id s1mr2645982qkm.771.1640106035583;
        Tue, 21 Dec 2021 09:00:35 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id h9sm14412295qkp.106.2021.12.21.09.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 09:00:35 -0800 (PST)
Received: (nullmailer pid 1450837 invoked by uid 1000);
        Tue, 21 Dec 2021 17:00:32 -0000
Date:   Tue, 21 Dec 2021 13:00:32 -0400
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Lee Jones <lee.jones@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>, linux-rtc@vger.kernel.org,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: mfd: Fix typo "DA9093" -> "DA9063"
Message-ID: <YcIIMGHA5E2FS2M5@robh.at.kernel.org>
References: <20211216164037.2888316-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216164037.2888316-1-alexandre.ghiti@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021 17:40:36 +0100, Alexandre Ghiti wrote:
> The device described is the "DA9063", not "DA9093", so fix this typo.
> 
> Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
> ---
>  Documentation/devicetree/bindings/mfd/da9063.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
