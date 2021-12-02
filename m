Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085DC465BA5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 02:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347426AbhLBBcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 20:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345273AbhLBBcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 20:32:10 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FE6C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 17:28:49 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id q25so52497112oiw.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 17:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5gpy4sVMzHHpUlsImi5kl58Gd1L0IEwpwxD1YdQQvBQ=;
        b=PmllECeJTsKVQzyq3fs24scpkhBsQYtimCCEBzVdvfA1Vp9wzh8BEfZW4KAnmXv2VY
         T/o/CapcXTv2Q5kS4pEiq39mMfppHLCKrsrH6K2aqiWkXz9ln9yB8y/Hb/3hmroHDLjd
         sJO7VapIW0v8YX5L8y0iCmtalDl4R7tj9LZlFbPYLsvApLlKcuG74fm25mQWhTV9myXk
         TrKo7k1TWmd0ljc6nvEnXwompmZbt7kaSIQ1aHCUzVbbeXn7MHhX4U7MzhxnspWm1hc6
         Qn3l8m7qVwVKIPPn5ZimiS38UuR576O3Iigl14HOx6MIRhq1Hz8+1XZju1zBR+1cZyOO
         eldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5gpy4sVMzHHpUlsImi5kl58Gd1L0IEwpwxD1YdQQvBQ=;
        b=pUlxypheFlBZApF7gA8OQNOUc051IvhmJU2xyRjYI2aPLnW8T69bKhQwHfLKO0+3ut
         +gbpJF4lcNpFWXG84uxJuqnWbymtQhAocVd5BvVYvzo4e1LEbULOkO248cobbp+EzbQ+
         HbJm/lnUofAqSdGtSoqcWe6i8qrFWTOgDOqL/b9nc125kfRVQgdxNfXskBOR1YylLikd
         K6LDmJwRPw1KzbUM6I3Q8nVB2XZBWMv+/MToks/lVuFs/w+oPVsq95OT8v7pGiUW4JzH
         mmYwSByrRlThdaMTFEdN1tMg/MPc93sCQ5SPJbkku8iZscfqXhXDTDEvuz1svDqxG6PU
         /c7A==
X-Gm-Message-State: AOAM5317qJZlOGOy7rgp0kAgWzQ/pbkU/5fYC2X7sW1lfZViV30KGOpD
        cfSrRONmf+bOiR84jwAbKYWURHO+alJKisNeHobIwg==
X-Google-Smtp-Source: ABdhPJxecnz1NO0fgLf1UE399iXCnEzQsG+UsmsEG6gIeEhXW9yYIQzCp0kbjcc193owkf4Og+b8awgaUPwSMZC0LNE=
X-Received: by 2002:a05:6808:60e:: with SMTP id y14mr1921269oih.162.1638408528758;
 Wed, 01 Dec 2021 17:28:48 -0800 (PST)
MIME-Version: 1.0
References: <20211125211443.1150135-1-Mr.Bossman075@gmail.com> <20211125211443.1150135-3-Mr.Bossman075@gmail.com>
In-Reply-To: <20211125211443.1150135-3-Mr.Bossman075@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 2 Dec 2021 02:28:36 +0100
Message-ID: <CACRpkdZ_o=L8t8wysy_wOaUydR-ptEkg07-mOjA32OWzEea8=A@mail.gmail.com>
Subject: Re: [PATCH v3 02/13] dt-bindings: pinctrl: add i.MXRT1050 pinctrl
 binding doc
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     linux-imx@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, ulf.hansson@linaro.org,
        aisheng.dong@nxp.com, stefan@agner.ch, gregkh@linuxfoundation.org,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, abel.vesa@nxp.com, adrian.hunter@intel.com,
        jirislaby@kernel.org, giulio.benetti@benettiengineering.com,
        nobuhiro1.iwamatsu@toshiba.co.jp, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 10:14 PM Jesse Taube <mr.bossman075@gmail.com> wrote:

> From: Jesse Taube <mr.bossman075@gmail.com>
>
> Add i.MXRT1050 pinctrl binding doc
>
> Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
> V1->V2:
> * Replace macros with values
> * Add tab for last pinctrl value

Patch applied to the pinctrl tree.

Yours,
Linus Walleij
