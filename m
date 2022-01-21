Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E02495C11
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 09:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiAUIjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 03:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiAUIjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 03:39:06 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B67C061401
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 00:39:06 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id q9-20020a7bce89000000b00349e697f2fbso27438089wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 00:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5WZ6mypcJ2R1wGosAmpXdFhGbAKQVNpR3ybI6dSypA0=;
        b=uQY0mIJW+qAbtFxNL+dj/Sh1kCoe8+m9G/K37p1/XZotpZTwylvIVUhbu4wuiCBPxn
         5WyRpQczzRHfhm59xVpI5/yNi0XMIOASC5sn/Z40bCp87AxAOBpdNfA8tf6R+tun5I1b
         WwVLUTw3p3IVZy3MVpZSV5nm2sGqxMdigzpMZDB3Y+t629XuN51wx8NnbVcM2Ox3Q9Qd
         Mvu5ZIw/xgeZe3oPmm8KlDYZlM/d3q1XFH/BDGKOzcilp2QDD5tcXNBtikBz5kiWAHcA
         J0dhGUB7oagXnXwjkj5k2YyFsrrF/JFZIGpE6Vz+mOJDBoSO5FmSl986Go2p0bs6CXkE
         yVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5WZ6mypcJ2R1wGosAmpXdFhGbAKQVNpR3ybI6dSypA0=;
        b=0p5vnm8934vtKWgulPM+U69Gup6RLrWQ/E7SifRqq/AsJodVkVBIryS+XGlq+n92B3
         lXxeWWic5Xsvkazn+V8D4PzlWaYmKoyRnA69ttqVnEdkSXm5e+72GAG3biOoR/t81RyS
         C/W18PHpmnFbI7aThR8w4zyLyj5yfwirRRBbbRUGIg+ja2CYLSpgukua+O1o6ggBYh74
         cuSTXlPyk981iZzD4VZiBLTjyOXz4imlrQ8RGoq7cVHwKtbsCbL3gNGPVGG2HY/P5UUd
         ZgT4TTsRp9jAtEuKKlk6aOQ+BCoJWWQ+D2lLNFPufucl+SSsJaTXyEmv/I8QRJSL5g8I
         yinw==
X-Gm-Message-State: AOAM531oJbmRAFbGq3qHyieRNIvDGyDlzvX8GSFO11hs1KY5sH1P9VXh
        O9Ia67jUtkmMDzQHuCqoKAa9lg==
X-Google-Smtp-Source: ABdhPJyN3vNmCddqfvDMAzeF+N2ym9YGaiVGex/2JkuoDu+0WMpnuPQz3SxAAYWHxCKgEFIlNEGkFA==
X-Received: by 2002:adf:fd43:: with SMTP id h3mr2862159wrs.341.1642754344867;
        Fri, 21 Jan 2022 00:39:04 -0800 (PST)
Received: from google.com (cpc106310-bagu17-2-0-cust853.1-3.cable.virginm.net. [86.15.223.86])
        by smtp.gmail.com with ESMTPSA id d11sm6351991wri.65.2022.01.21.00.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 00:39:04 -0800 (PST)
Date:   Fri, 21 Jan 2022 08:39:02 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        - <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: cirrus,madera: Fix 'interrupts' in
 example
Message-ID: <YepxJgjQ89PmMUkD@google.com>
References: <20220119015611.2442819-1-robh@kernel.org>
 <Yem5rQ7RFG3bUUxV@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yem5rQ7RFG3bUUxV@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2022, Rob Herring wrote:

> On Tue, 18 Jan 2022 19:56:11 -0600, Rob Herring wrote:
> > The 'interrupts' properties takes an irq number, not a phandle, and
> > 'interrupt-parent' isn't needed in examples.
> > ---
> >  Documentation/devicetree/bindings/mfd/cirrus,madera.yaml | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> 
> Applied (with my Sob added), thanks!

Was going to say ... :)

Please add my Ack too:

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
