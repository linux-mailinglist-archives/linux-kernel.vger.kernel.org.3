Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1415464C2B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 11:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348840AbhLAK6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 05:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbhLAK6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 05:58:17 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F93C061574;
        Wed,  1 Dec 2021 02:54:56 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id t5so100233644edd.0;
        Wed, 01 Dec 2021 02:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OvJoAjsiwp/bIqgJqHb/Ct3NhVVdCidlBQIJ1jfhjxs=;
        b=Ta5UwXQvxUApA7IqpY3NDy68+xmL0+wr28tsdHISkNUFTGtfo7ptrUvzPoouoG4Nx2
         osPBXDez94IdJ/Ji8qVLfg69ULnlL2GEWjuFInCCKrQbi65AUPgw6NbEIRVdzbIEYR7c
         x0Kx4WQK+IbDaVrUC13ojGgd4ckfNAl8tl3vooROqTe/KKn31IOCSbXfp8NcdnqCbwNZ
         HhRk+c3bxQxbAaQ1j+L9xwtBKR1zEm0vc9H1nR8oDadA8hNUjk7SQDDuOCI+SFCINZda
         zEvhNiVGZOXCBPwzExF5WQL8TDmt6z++I6hoKF3dxWZ9NbfFynMR8FEXS5ipoSL6ZrI0
         vZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OvJoAjsiwp/bIqgJqHb/Ct3NhVVdCidlBQIJ1jfhjxs=;
        b=yqd5SbaBrEzWwBTYSkqe+cZsDB/Xunii04SG5bulXfXrMS2nYz564EbCKjuaumqD6k
         n6796NcGaKfKpnUVxsR2hsAgifMIcvl0jpdEqAkG5mWwn2a6GyNZ299xSZwDtD1FsBz3
         SthpDFng+T66beaxVaqGNEK4aVOOxwi7WPzrcjGH3Z7DmzDWl4/vNyS7lvf+tjryGQTF
         ZkQp9U9MNvX4CBYdvmeieW/qDP3vr84wCVDBopp0iQ41HxLN5uyfrTmISHvG3F/MvmYD
         eBQt3d0S7EbPd3zCiRAwz5N7kZIqG60wycopw7yn+8bvmqa0INXr2IjQUtqaMU/OFJ/s
         D1hg==
X-Gm-Message-State: AOAM533zJeUFcbcLubPTxb5VDJt1v/84cyNf4gxYOQ7feuhFCylWUL2T
        b8kMm92cdWlcZXAZYEi2NH+iTtKHd5y/FbioYc0=
X-Google-Smtp-Source: ABdhPJyMWHVjrLETt3XzlgtJwBoFDiG2sOhLr7LzkkX2v2atvCCOmIF8fnH8GGIVBIfk+JoF72F7zcD7q9iN3fMwxgw=
X-Received: by 2002:aa7:db8d:: with SMTP id u13mr7199099edt.111.1638356095305;
 Wed, 01 Dec 2021 02:54:55 -0800 (PST)
MIME-Version: 1.0
References: <20211130111325.29328-1-semen.protsenko@linaro.org> <20211130111325.29328-4-semen.protsenko@linaro.org>
In-Reply-To: <20211130111325.29328-4-semen.protsenko@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 1 Dec 2021 12:54:19 +0200
Message-ID: <CAHp75Vd8PFhs8_Ji5x1X2Ph5ey+8JrRuneWCrG=5a+52Lh-ptQ@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND 3/5] tty: serial: samsung: Remove USI initialization
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 1, 2021 at 12:42 AM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
>
> USI control is now extracted to dedicated USI driver. Remove USI related

the dedicated

> code from serial driver to avoid conflicts and code duplication.

Would it break run-time bisectability?
If so, why is it not a problem?


-- 
With Best Regards,
Andy Shevchenko
