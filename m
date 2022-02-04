Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430114A9E62
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 18:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377156AbiBDRyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 12:54:39 -0500
Received: from mail-oo1-f43.google.com ([209.85.161.43]:34507 "EHLO
        mail-oo1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbiBDRyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:54:36 -0500
Received: by mail-oo1-f43.google.com with SMTP id k13-20020a4a948d000000b003172f2f6bdfso153798ooi.1;
        Fri, 04 Feb 2022 09:54:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b5p3mJZddYDzFbrbU20Q/j04KekocXb3aRuM7SgPkpk=;
        b=isW4bDyVtcw8bMkdik+yvk1H2WMNqtfPGAXpWCIsR5bXsjshItDNf4nJyuhAdj4QU1
         6mb8+AIzHnGAciNm+tjMU48SoS/IieC2Uu+W0eUu/I0i4k7+EHnz/L5AKTBAaNJlulmM
         L0sY3R71T4xgT1NDhgZpXY7at2DxxzSJZXnCnPrVi3RmzqwqMQMRX6z5QHdI++j6/jTt
         5YIMle0xDGaD2L6zbsIV3/lA/moWEPFd8IRfMurrKN+caxIYo168XtJCBM7hpxln6ykf
         8FZjVR3vk/9ZqMSCsrKzhxJJtzygNUC/HoGCD8aKXtOf/lq5mcDk6A3LQ9C5YMsUsdFh
         r/Fw==
X-Gm-Message-State: AOAM533PGcvnIgMZ4KCVvjpxTtukqJHXzmlnUcwAYs6+oJeTAfIKSWO1
        NQg3JtIcbytECMM0aMsw3g==
X-Google-Smtp-Source: ABdhPJw3GNOA8ALuAWNWyS9AiNy/RwGT0qFRTd+XdMZJS2kgIVxmpQAb/M91bDdIMzkyH55ZCTRlVA==
X-Received: by 2002:a05:6870:46:: with SMTP id 6mr26839oaz.244.1643997276183;
        Fri, 04 Feb 2022 09:54:36 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bf15sm1139526oib.32.2022.02.04.09.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 09:54:35 -0800 (PST)
Received: (nullmailer pid 2823569 invoked by uid 1000);
        Fri, 04 Feb 2022 17:54:34 -0000
Date:   Fri, 4 Feb 2022 11:54:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] MAINTAINERS: dt-bindings: Add Krzysztof Kozlowski
Message-ID: <Yf1oWh5aglhIpgta@robh.at.kernel.org>
References: <20220204161851.138874-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204161851.138874-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Feb 2022 17:18:51 +0100, Krzysztof Kozlowski wrote:
> Add Krzysztof Kozlowski as a second maintainer for the Devicetree
> bindings, to share the Rob's workload and help in review.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> ---
> 
> After talks with Rob.
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 

It's great to have you (formally) on board.

Applied, thanks!
