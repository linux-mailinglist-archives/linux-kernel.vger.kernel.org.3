Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7812446A6B7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 21:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349606AbhLFUUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 15:20:32 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:36682 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349544AbhLFUUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 15:20:31 -0500
Received: by mail-oi1-f181.google.com with SMTP id t23so23630057oiw.3;
        Mon, 06 Dec 2021 12:17:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3X/LugIcWCRknrOirt8f6uvFdTZbieXOBqDYLzyWp2s=;
        b=516OrC7SS9OAQfLWW5bUeaLY4zYq+7Y3pYBI2bN66BAvUJWYXQRedvJ0Diy50brwFq
         Js4digkB8wnIgj+A72WbcL1hGFf0INjYDJBEiwpS+hqV/fmcqAwOcC4VhVQdst5yCg23
         969YuxYCFCZ7uvmjOONBdG1dHguGgXUxd2DBdgDsIjq6j69Kj1snSLuvS9pwSsGdYhYx
         f6nHkCSqKZmrXjtYlHVmJtASYj15ZcX+IOpk49c6VpsS7XKBZ+HIj0hkdW987KZcW2bU
         miGWj4XbfmBAoqwu9DcvW/i8XDHlY3c6Vf4l3u77XMOSyMRxptv3ySOh//38rSUwNzds
         grbg==
X-Gm-Message-State: AOAM530mNpAk92Y2oGe1UCvbR3UPOx9I/7xfR6c+d6zCLLVSZTiRWTTH
        ykZkse9ojp6O6D9A+kCG2A==
X-Google-Smtp-Source: ABdhPJw9/zkKLK37BKk+7ac2n41iY16XzcSVeXkQJ34BJbzihtRflW3mClcGd893Dvwo8lJ5mQYrEg==
X-Received: by 2002:a54:4819:: with SMTP id j25mr877141oij.66.1638821821971;
        Mon, 06 Dec 2021 12:17:01 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j20sm2874870oig.52.2021.12.06.12.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 12:17:01 -0800 (PST)
Received: (nullmailer pid 2513545 invoked by uid 1000);
        Mon, 06 Dec 2021 20:17:00 -0000
Date:   Mon, 6 Dec 2021 14:17:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-renesas-soc@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: input: gpio-keys: Fix interrupts in
 example
Message-ID: <Ya5vvOtq2kgf9hkT@robh.at.kernel.org>
References: <cover.1638538079.git.geert+renesas@glider.be>
 <47ecd2d8efcf09f8ab47de87a7bcfafc82208776.1638538079.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47ecd2d8efcf09f8ab47de87a7bcfafc82208776.1638538079.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Dec 2021 14:35:06 +0100, Geert Uytterhoeven wrote:
> The "interrupts" property in the example looks weird:
>   - The type is not in the last cell,
>   - Level interrupts don't work well with gpio-keys, as they keep the
>     interrupt asserted as long as the key is pressed, causing an
>     interrupt storm.
> 
> Use a more realistic falling-edge interrupt instead.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/input/gpio-keys.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
