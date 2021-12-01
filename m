Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D25465921
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 23:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353535AbhLAW3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 17:29:18 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:40817 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353573AbhLAW3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 17:29:08 -0500
Received: by mail-ot1-f45.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so37342777otj.7;
        Wed, 01 Dec 2021 14:25:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TVRItOUf45Hmpy2bGhqmZEEE26i5Yr+YcGE9jV7vzDg=;
        b=wVieFDHackwojg0o8EdZM9AN6tEmXc8kmCfTOCXir6j/gSoYnZnAgOrft0iTYbGfJz
         kyc0t+G0THfLa59BLLHx1Cx7USBfg1x/wdlQkVPIRsguyiz0AhtWiKfRrYW+DK51XuU2
         YxZDyU4ZwrziKlqfSAlG4m8dycXfN7RIfON9gievCRRLl9xojeDbx+s+p0m+q3PO8BpE
         PaUNfyGKjmuSU0yY73KlRQYr0E8yJOyoc0sPGXygQlLIlrfkYjZWNN5IZ6ej8WfISG4F
         FBD18Y4bAUZqXY5/EUHVeZ8rHrYKKTGd/Aj8+jAmaOV5mDfrsCNyVcdh1/cVME2uj9FO
         0TLA==
X-Gm-Message-State: AOAM53026QGGkJvIFYLpIDpGZL5Yq93VR0XUlEuiAH2aBqgzRGhzEalq
        XkuAon/F9rP1Js0RolWKVDqvnLEhUA==
X-Google-Smtp-Source: ABdhPJwFVxZ9U1ssjI3w/4LIeqTVI0fgaNk0MnikGSWabqkj170XvzUfDhF5pL/SAPk3VYftAU+Ogg==
X-Received: by 2002:a9d:5c04:: with SMTP id o4mr8319657otk.339.1638397546473;
        Wed, 01 Dec 2021 14:25:46 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u13sm378176oop.28.2021.12.01.14.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 14:25:45 -0800 (PST)
Received: (nullmailer pid 2869357 invoked by uid 1000);
        Wed, 01 Dec 2021 22:25:45 -0000
Date:   Wed, 1 Dec 2021 16:25:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lars@metafoo.de, jic23@kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: ltr501: Add
 proximity-near-level
Message-ID: <Yaf2aV6GCOaswsDH@robh.at.kernel.org>
References: <20211125125646.54831-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125125646.54831-1-nikita@trvn.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Nov 2021 17:56:45 +0500, Nikita Travkin wrote:
> This value inidcates the proximity level that should be considered
> "close".
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
>  .../devicetree/bindings/iio/light/liteon,ltr501.yaml       | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
