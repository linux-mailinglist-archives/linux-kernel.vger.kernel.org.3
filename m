Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493DF493E12
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 17:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356099AbiASQLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 11:11:45 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:34552 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242993AbiASQLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 11:11:44 -0500
Received: by mail-oi1-f171.google.com with SMTP id bb37so4891658oib.1;
        Wed, 19 Jan 2022 08:11:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HsgvhUeYKTMvXHzAAdKiut/MtRl4CxD2UOcDmgyuM6U=;
        b=6xd/3VOAatwu1RundXoebYYx97SiJRBCcZmRCHG3uua2/tj3s72O3Y4eP5Fo8f/231
         k9QxgSQhQGgZNWF0uZ6rq+C4KV3q3W48Y6SlefRoNQGJSNSvvxKFeKj0+RJVuLNSbmnH
         uQlRv3h7mZDG61441z8Okuwb3B4GETb26tOpyn0wtBKClAZc2jJXQ86grHgdF8+lsV1M
         wQH7x7jl13r0X0JAL6FbgdL/zruj9Bd5LEWGEnimg6vbIM6rkNpsC/Uiej5Rsrbda1pK
         +Cz6U0OsQgMNcQ14Lv52Mhbvvk7ZV/ktfCfSWkvBIprX8fayJld4JWfDY3OKF5Z3XyGn
         86sA==
X-Gm-Message-State: AOAM53370edXAtf9ISPvn/GfhTlYH7aaxHVVv21/E93pnoCP99A5Z1QC
        IL4lJ1cDCQf+x1vxQ/uX/p3jWUHwYA==
X-Google-Smtp-Source: ABdhPJxGt3yqJ/I+wLtRExmS5xQdqP2y+8g3jjrsNTovs0w1RheJ6nhVZ3/sfjczY5mvprGrEL0WwA==
X-Received: by 2002:aca:aa03:: with SMTP id t3mr3463465oie.167.1642608703509;
        Wed, 19 Jan 2022 08:11:43 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g4sm59954otl.1.2022.01.19.08.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 08:11:42 -0800 (PST)
Received: (nullmailer pid 3681912 invoked by uid 1000);
        Wed, 19 Jan 2022 16:11:42 -0000
Date:   Wed, 19 Jan 2022 10:11:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: arm,pl18x: Make each example a
 separate entry
Message-ID: <Yeg4PocQo9qiSlq6@robh.at.kernel.org>
References: <20220106182518.1435497-6-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106182518.1435497-6-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jan 2022 12:25:14 -0600, Rob Herring wrote:
> Each independent example should be a separate entry. This and dropping
> 'interrupt-parent' allows for 'interrupts' to have different cell sizes.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/mmc/arm,pl18x.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Applied, thanks!
