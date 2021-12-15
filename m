Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652D5476236
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 20:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbhLOTxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 14:53:04 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:40769 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbhLOTxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 14:53:02 -0500
Received: by mail-ot1-f52.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so26236753otj.7;
        Wed, 15 Dec 2021 11:53:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F+7zx1G12gcU32oCO0oDb+7WaFMbkfK3I4pJhCJ/550=;
        b=RXy/DqLn2rUnsAqFXoE5gULaW7E7oVa0BBXNaenVmCpPWPhTgN4j73ts4LAU4chrMj
         u1VBFon3JJLcaiJdrycO7AaWncsKz52JNRXNIM9cOkc49Y2gTcefuOzAItO8QUtNjWlc
         BBb8SjuuXuxQnI/EuHiU0IBahuDTplxy2ujDdXQDOHbg438Hk43UT6m7Dw7eeqnImEdI
         FSaIRoOHy4xIS6op34KMTY+DvJI/7533LTVCrrdzkuIaOTjATI+SakmghB3UjrNSFAMv
         Vng5zzndJipTQuK5ylDO9yJ12TgTi6fLZNEXAeXfqb/RRnXD2O+q6Jp0Kr96KP3YW4OG
         xf/g==
X-Gm-Message-State: AOAM531dsV88HE8FIJee04pvYjnR9XwWnCIGAJ9Nn57qWINhsZYfviUK
        edS4K2fG52bH6fve+99yCg==
X-Google-Smtp-Source: ABdhPJxl3j4PI+RLOXiDgbqAe/8mYKrGVyo06CZJHm+/9QvZ5PkugWgUKfoaX7GvakIHOGaVB9jBmg==
X-Received: by 2002:a05:6830:8e:: with SMTP id a14mr9509976oto.280.1639597982243;
        Wed, 15 Dec 2021 11:53:02 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e20sm538598oiw.32.2021.12.15.11.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 11:53:01 -0800 (PST)
Received: (nullmailer pid 1727871 invoked by uid 1000);
        Wed, 15 Dec 2021 19:53:00 -0000
Date:   Wed, 15 Dec 2021 13:53:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, loic.pallardy@foss.st.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] mmc: mmci: add st,stm32-sdmmc2 compatible
Message-ID: <YbpHnPwrNpsbH+PB@robh.at.kernel.org>
References: <20211210091834.28958-1-yann.gautier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210091834.28958-1-yann.gautier@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2021 10:18:34 +0100, Yann Gautier wrote:
> Although this compatible is not used in kernel, as we use the common
> MMCI driver, it is used by bootloaders. The U-Boot driver was merged
> before the kernel driver and uses this compatible.
> To avoid issues when aligning device tree files between kernel and
> boot loader, the ST dedicated compatible is added to bindings file.
> 
> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
> ---
>  Documentation/devicetree/bindings/mmc/arm,pl18x.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
