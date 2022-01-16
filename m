Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9DF48FC88
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 13:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbiAPMJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 07:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235032AbiAPMJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 07:09:19 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832B7C06173F
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 04:09:18 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso16252396otf.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 04:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nzQepfLL+SGjYE7/8X4gZEz0wVEIHbxydae1Vjcfelg=;
        b=li4eNDHzmKQPKXQH9EPaZqkg3ZKafq+S1WNXBl3larEL7wbJLhx1iOgVLhJe5+whhW
         OIrZ2I4haacmN/3uAP8Z+Mut0w9Vhfkw5m1nPc99SKrZTx1xG0aoJVm/cLQ3e87lnZ5M
         sNCasYAPmabIQgdb0WZwoqslm11l0s1jXFEw6SKs5pOw3tQqNWEKaBX4RpyoBe+AqTd6
         2RHoNLI7t35r9z+5UZLLqSSRJQh45vK+9aQ+DI/ws9+dDnPEkYnr6yh9EhwPcSc4S/jR
         ZGbrEdSUbUFFEC1IWfPqt5VozKeCJopfPE0wZWxmyE57gHz7LD+3WoOKDdEaGZe4Avfg
         +/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nzQepfLL+SGjYE7/8X4gZEz0wVEIHbxydae1Vjcfelg=;
        b=o2nDb3COyoj6F5NKAN/5Thb2w5TMXM1FSI0acYQJY0nBzVWdlCmAqiFBC6Zw2cHZ0N
         Wcu73y3VT4rDNolJrw9YdgFhVzgicAx9g7fIDpyWwzq4nOEJysAGrmD/yjOoMUZ7gR2o
         J1IxHpPFrucZDFqoxRS3La2DR2zv1OgZrs+siKjcK/ZUbyU6Xtx09R5hAdtqB7LK3ML+
         YOX7lRoXAaq8p8Uau2gB1Yym1zboMh4VoABMdgkGUDQg/pJ7RWnS2SVTrs5Y/twNHkf1
         BW94RvErEPta5n031+IDmaphSWJ+xpIMBM9xlEoBNNa5PlMYuxkLBYsOIGFlU/lT4VKy
         8oow==
X-Gm-Message-State: AOAM530s+O4Ii1iLI0b4qjCHGbAchO6OFvBtz4R9FdrhXD/5Bspe+ihX
        RgN8yiT42nZmFPN1wYva++oblNKBhjx6UsMXfoR0XA==
X-Google-Smtp-Source: ABdhPJwa04h4sD14vv2Z/CGZajhxLfFbKVOadbmybRdvY888f4W2fEZ/uIH7hFe02AlyoMGqWsll6X2tNHCd6NvGZqo=
X-Received: by 2002:a05:6830:4:: with SMTP id c4mr1427187otp.237.1642334957532;
 Sun, 16 Jan 2022 04:09:17 -0800 (PST)
MIME-Version: 1.0
References: <CGME20220113122404epcas5p4aa1c3ac09510eb55cce5fdd0791993a6@epcas5p4.samsung.com>
 <20220113121143.22280-1-alim.akhtar@samsung.com> <20220113121143.22280-13-alim.akhtar@samsung.com>
In-Reply-To: <20220113121143.22280-13-alim.akhtar@samsung.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 16 Jan 2022 13:09:05 +0100
Message-ID: <CACRpkdZkc9ShabhKoVnXMfQp3M7siYUYirBFVBP8y3dLEw5azA@mail.gmail.com>
Subject: Re: [PATCH 12/23] dt-bindings: add vendor prefix for Tesla
To:     Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net,
        catalin.marinas@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski@canonical.com, s.nawrocki@samsung.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 1:24 PM Alim Akhtar <alim.akhtar@samsung.com> wrote:

> Add vendor prefix for the Tesla (https://www.tesla.com)
>
> Cc: linux-fsd@tesla.com
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>

That's an interesting new SoC vendor...
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
