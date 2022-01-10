Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E651488DF2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 02:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbiAJBJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 20:09:17 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:36501 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiAJBJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 20:09:14 -0500
Received: by mail-ot1-f46.google.com with SMTP id s21-20020a05683004d500b0058f585672efso13605431otd.3;
        Sun, 09 Jan 2022 17:09:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kMd+vk2w2umhXK+iIaflqiwGDi4CAHz/3zi7xCWYQJo=;
        b=IZown3FUbkg4F4szBhX2eATqkRe7zUhDBbeu0s5VRlMpRMQ3jS4qQgYrZFTSx9fYVS
         XH5ubBed/7agOn3e/02Gx2KlCcKJQYf8UCPBpfOtnI9Q/C4zUtLpyU5zocYyUnfGlfio
         2d1lU0s9gx/6CyRU83d0qjMI1SDMFI/2JRpEkLDJDgXF2y14Y7y82OFAteAkDyH9beWF
         FKZaIJoXDr7UozUoPhlr5zksR+YuiWfcjymL1Cw9xHlLZm6MKQhXl23LiwHFuWo9wfzc
         tSQEgfCULkPHliSoVKcB+7DAeigbuQiT2uom6sRPvSn0sfnLUoBR586a6MgyLzxbwNXL
         R4oQ==
X-Gm-Message-State: AOAM533QGv/jDqXGvbzyE0C0NAaFfuvCL4l9ggm+upt0TGfGFKnn8vKo
        XrYLnC1KiKu6sIsZxDJIjA==
X-Google-Smtp-Source: ABdhPJwF8eS0UZpOnfiYuLpW/LhvTeZiMyODFlm+SZ4Z48KcdCJjmZbhl71GYAAlZqSFKktefrK1yA==
X-Received: by 2002:a05:6830:2a86:: with SMTP id s6mr14724688otu.377.1641776953887;
        Sun, 09 Jan 2022 17:09:13 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q5sm968654oiv.2.2022.01.09.17.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 17:09:13 -0800 (PST)
Received: (nullmailer pid 3967508 invoked by uid 1000);
        Mon, 10 Jan 2022 01:09:12 -0000
Date:   Sun, 9 Jan 2022 19:09:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        devicetree@vger.kernel.org,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH] dt-bindings: iio: adi,ltc2983: Fix 64-bit property sizes
Message-ID: <YduHOGkcmak9TMh2@robh.at.kernel.org>
References: <20220107032026.2408196-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107032026.2408196-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jan 2022 21:20:26 -0600, Rob Herring wrote:
> The '/bits/ 64' notation applies the next <> list of values. Another <> list
> is encoded as 32-bits by default. IOW, each <> list needs to be preceeded
> with '/bits/ 64'.
> 
> While the dts format allows this, as a rule we don't mix sizes for DT
> properties since all size information is lost in the dtb file.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/iio/temperature/adi,ltc2983.yaml | 22 +++++++++----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 

Applied, thanks!
