Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50DC247BD11
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbhLUJmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhLUJmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:42:12 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034F9C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 01:42:12 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id d198-20020a1c1dcf000000b0034569cdd2a2so1649724wmd.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 01:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=z1TZscSTdfeoTN+rbE+EnIAa34sPklQbO0+nPYIjMM8=;
        b=Hk3Wc2CRMeXhPNMDBnLbb/9dUz3lTwWfPb6+PiVpEmYbKOTov+GQ/pc9B+Zww+q7Xu
         eaJnd65ZO/SL9wxPSosiYL1zo/SIoahyAuXaBttG/VtNYIwXC32jEgn34PInJ6nsKILo
         BS+snXU1YeOkfn0AGJNsUy6tpjIac/J+cUvygd9ci7QNRLtgUA5HD+UojzPPvGxtp7ea
         UAAWpDlVkpO8YaFu4v4lt70LxK/TljvHpyuROsIap0i076mYe4hlhJizaB36CSE4Z8pV
         RhdzE9U2ilD+fx1gHVEBknRoLkwQcCm67Wb6VnYO6N997Pd7Oe2oAbaL/XPCxTjFFt5+
         DW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=z1TZscSTdfeoTN+rbE+EnIAa34sPklQbO0+nPYIjMM8=;
        b=yy94mIUrSzTMSAzBB98BLImR0JM9QytW/OfK2Za7HkBbCrgLmkZQpgcaLXhURgKPIS
         o+D7Cxl5Dwq91EjLFhNazdFKQIRzskcSE78Li8HSWw7w22qbkoFjNMI2plB9iD4pOuTd
         gtQ8AqwBzDjIlctbotPo4I93cYC+zEQvAD1bA9RiUwMiyJCKG3n5Ewdr7HWYJicc9JXC
         KlXscemPiYhhnsYUdIUHtJcGg85vmYQZUy7wtjx+TjLcokynidTJnMH98apttkYdpVjY
         lQ30LkpcAYChC9/ODhH/GHgjQiuIW+DelYA8VYKAc+NPpz8URCC9QjdNfZj9dEM67KRG
         BIcw==
X-Gm-Message-State: AOAM533b9n7v7NUPS45hKI05B4zBfQ539XHx6zTfmvmcS/uP8pTBoBiV
        kRyaXcp+28GX/XuUqxAlom5KQlQ0xRw3tA==
X-Google-Smtp-Source: ABdhPJxd8LBIzc0eEi6wUlWNN88/9JlZAIVMnYbN95LRErIhZmO5I9REj+rrEnLArVOYVrJ8Jb6U+A==
X-Received: by 2002:a05:600c:2295:: with SMTP id 21mr1903119wmf.187.1640079730614;
        Tue, 21 Dec 2021 01:42:10 -0800 (PST)
Received: from google.com ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id 9sm417923wrz.90.2021.12.21.01.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 01:42:10 -0800 (PST)
Date:   Tue, 21 Dec 2021 09:42:08 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: Add Freecom system controller
Message-ID: <YcGhcImIRV2Ylmz3@google.com>
References: <20211122102210.3137559-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211122102210.3137559-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2021, Linus Walleij wrote:

> This adds a DT binding for the Freecom FSG3 system controller
> found at CS2 in the Freecom FSG3 Intel IXP42x-based router.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
