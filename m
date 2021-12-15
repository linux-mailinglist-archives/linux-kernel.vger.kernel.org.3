Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2901476441
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 22:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhLOVIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 16:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhLOVIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 16:08:35 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5051FC06173E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 13:08:35 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id i22so10610387wrb.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 13:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SI4r6mSk903/fHU8Ev7RhyYWsrPcFnd8IGh3DZzsS6w=;
        b=Hr7LW7HFJOof6fOg2fReA0362wmmehPXA1Ch7mBBknVFDIDjWsDp3RG66FsRdYS6t0
         XfXVA6yRA0zNBSmVcpGzSczS225H5EPKf+VZ9joFhY66yS1LkR5JmO7XtEkpXDf+qV3n
         dop5wb2YfHgCfnGMvlUocIj6jrLD67YpXylvzRhtMg38G70eFU2CRZVP4ELcWJxT+23X
         jkt+e6Ua8Uo8f9RgHmNe/w0aguDhGhiv3yPmi+6uvuoWfWk3DWT5odhvA4jA2NAvmvrQ
         pftFKOdLxXhujiZBHp297SmqlhYHi4qQIziRiUxNG6tj+gJWzuPIwh6VHsW5g2HVpPr2
         77MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SI4r6mSk903/fHU8Ev7RhyYWsrPcFnd8IGh3DZzsS6w=;
        b=fwmUiGPaTebnKbmJS4IIhRF5CZWhBnKhl3LRH2HKo04fChyu3gnBRroJ52K+pPTeID
         NjbmiDlKlyiIqHvcDVNugbTv09JKMr1cRY/OQMh8ZL7ODl54INYj0XgQWhlm71w0IhHS
         eBI1OqKlnGxfj/GHcyLu7Nsot7IM2FqG3NawlU4jccnG4f2POt4irlKdBIS6ybymfb/W
         JeJrGcjZE2PoQJi0hhZ7JdtzLl0F7dDyx7/11eNxcpKJCn4J9EyXtOG4BXOHS8BggzkD
         N0pKG76glEVN/tCjoFupvtjFZTM1ET89Z/loDqw5TmIvwAZMv02NLNPRKlc5nxhnMpR0
         hERQ==
X-Gm-Message-State: AOAM532C0T/HM/2+rNPJ5VgPLTFhIm9uXXftxsS61A6gEXUhZBYnHbSX
        zejbHIYL9VJ5mFevELrJSpmzIA==
X-Google-Smtp-Source: ABdhPJx0etjiGjzoBUYOOSNyc2dmWzFChhMhbxapdWVLrDBIM5to3w3eCjb5xtm8kX/Da17ICteoqw==
X-Received: by 2002:adf:fe0f:: with SMTP id n15mr5676743wrr.705.1639602513768;
        Wed, 15 Dec 2021 13:08:33 -0800 (PST)
Received: from google.com ([2a00:79e0:d:209:8505:8095:9f82:42b7])
        by smtp.gmail.com with ESMTPSA id j11sm2925430wrt.3.2021.12.15.13.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 13:08:33 -0800 (PST)
Date:   Wed, 15 Dec 2021 21:08:29 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Andrew Scull <ascull@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: firmware: Add Open Profile for DICE
Message-ID: <YbpZTSpmnieCNZ9a@google.com>
References: <20211213195833.772892-1-dbrazdil@google.com>
 <20211213195833.772892-2-dbrazdil@google.com>
 <YbpPYG4rzPmJmwA6@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbpPYG4rzPmJmwA6@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

> > +        dice_reserved: dice@12340000 {
> > +            reg = <0x00 0x12340000 0x2000>;
> > +            no-map;
> > +        };
> > +    };
> > +
> > +    dice {
> > +        compatible = "google,open-dice";
> > +        memory-region = <&dice_reserved>;
> 
> There's no need for this indirection. Just add the compatible to the 
> dice@12340000 node. You can bind drivers to /reserved-memory nodes.

I have not found a way to make that work for kernel modules. Built-in
drivers can bind with RESERVEDMEM_OF_DECLARE, which puts an entry in
__reservedmem_of_table and __reserved_mem_init_node() iterates find it
there. A good case study might be CONFIG_TEGRA210_EMC, where the driver
itself can be a module but the rmem parsing is always built-in under
CONFIG_TEGRA210_EMC_TABLE. I don't think that's worth the trouble with
this driver.

David
