Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E5D48F35A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 01:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiAOAJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 19:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiAOAJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 19:09:24 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA66C061574;
        Fri, 14 Jan 2022 16:09:23 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id m4so39626224edb.10;
        Fri, 14 Jan 2022 16:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6WxgRspTa9pdiuAuq6uLhSBKFJubCNNBfbR5oS90b7o=;
        b=KGoHG6HXMM7jvUx9Y8QNcz74un6IlPxstlSzzYzk0AqnYszuBg3SIHArvidcgByuHl
         hAq5pioMPEYm8hHK3OkUNrVgG0pm8sGjWfg4+VRLWkL22CmDLbZPWnED0dd5FDFDdI/M
         wiWRzLFfCT+1vc/fOjXgPAMczpnR8Z7JA/ml8GBsi+eqQlnCIYxoqvujlXRF2L1g3b0s
         dyMJn2Ua7jG4GkPUjeqJLLqoaPw/w8m3d7BvIcxznrNayIyytxDYkbFTjAnXnBJP01D9
         UbPe/sN7t+prvljMu/y+9zm3SYsNtDddNe4E60G4q5dvVKSY2WiaZDJZlqLICyyOKAID
         wKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6WxgRspTa9pdiuAuq6uLhSBKFJubCNNBfbR5oS90b7o=;
        b=lVtMVTm9k4TUb9CC89KAN1h+iS4kENJFHGR6BGPzhJCAwKO+ZI/LNgh/rBPaP3OuSi
         hiOA4QCLyumloRSTA/q/3OwO7og1rEZR//uKolgX0Y3lLlvC/Nc7grqz5F3ocQW3S3B+
         zF2CT+gdISpwVJbTolfuSmTyC6nHIBdDAKq58VHvHzN4svecgFNQkLpgw6+N7onRNlaI
         9/U8R3R4mF+ZmYuHvX0xzfIb5NHFSGY7jguZh3Mnbn1Y9b0As9somd2Ekkd8ZTy59DJi
         HmamFcrAMrYZyZ3kzT0kbucZB8FVPBzGtSRs58KF7U3dato8jkfsVjA8Wl94gGXAutR3
         wELg==
X-Gm-Message-State: AOAM530/FiI6lYYf/H8oXNV82lrC6zaPm/CRxPSPKLq1isOJjg2LAL3A
        ypqh8JlmpQDaLSjWE8FAwvm9vkAe9J4WRqtr5Y6fKa0773A=
X-Google-Smtp-Source: ABdhPJz9ZyGviTxwAhE2hO5kJPWpzDkAuJFLi1AhPe5xXLp16SMB9TUcenUz5Eb6OensaynZMbCWU9gUo24uUxm9Qws=
X-Received: by 2002:a05:6402:518a:: with SMTP id q10mr10857118edd.29.1642205362382;
 Fri, 14 Jan 2022 16:09:22 -0800 (PST)
MIME-Version: 1.0
References: <20220113115745.45826-1-liang.yang@amlogic.com>
 <20220113115745.45826-4-liang.yang@amlogic.com> <20220113212957.768FFC36AE3@smtp.kernel.org>
 <5d99ac02-a246-5bcc-2ecb-371b0d193537@amlogic.com>
In-Reply-To: <5d99ac02-a246-5bcc-2ecb-371b0d193537@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 15 Jan 2022 01:09:11 +0100
Message-ID: <CAFBinCDkNk+Ba340vshhL2rE76U9qb_dZ5ZsgWnMgFYpL6i1jA@mail.gmail.com>
Subject: Re: [PATCH v9 3/4] clk: meson: add DT documentation for emmc clock controller
To:     Liang Yang <liang.yang@amlogic.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liang,

On Fri, Jan 14, 2022 at 4:06 AM Liang Yang <liang.yang@amlogic.com> wrote:
[...]
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - "amlogic,axg-mmc-clkc", "syscon"
> >
> > Why is it a syscon?
>
> The register documented by reg is shared with SD/eMMC controller port C,
> and it need to be ops on NFC driver.
Can you please share an example how the .dts would look like in the
end for two example cases:
1) using the sd_emmc_c MMC interface
2) not using the MMC interface of sd_emmc_c but only using it's clocks
for the NFC

Initially I wanted to suggest the usage of a sub-node with compatible
= "mmc-slot" (see
Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.txt for an
example) to decide whether the MMC controller is registered or whether
just the clock controller is registered.
However, the mmc-slot compatible string is not documented in
Documentation/devicetree/bindings/mmc/mmc-controller.yaml currently.
Maybe the MMC maintainers have any suggestions if other IPs have
similar requirements (for IPs with shared parts).


Best regards,
Martin
