Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEEE48207A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 23:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242208AbhL3WDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 17:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242201AbhL3WDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 17:03:10 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589A3C061574;
        Thu, 30 Dec 2021 14:03:10 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id x15so102841964edv.1;
        Thu, 30 Dec 2021 14:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ro4azlri2Zm/Aj3GAOqfPGTdL14kEj8hPy5vMhDOk3s=;
        b=iZcOuTOXbnajSmpNak/VH7PsvvLtp7oEpjNKsstHxFFbHjcWBkdhbJcUVC/EMDnYe7
         F94AjkOUtybuY2vsSPVB88twIXpC8q88mo6hnAy48hi+mZUrdrbKZYpFGg4ve0E/U4b2
         Yo1V+LVp5nLIcxS/wSCBPYRQKrmQElRNQmXCpvP1GJYUxLwtMF21cSImggQJi9qoqtAS
         fWSX1E10cg8xmXRW6nut40c1xeYGw52QS/O6SA0aqPfGoTVSulhGyQXu3EBo4hZ5vwmN
         nNSpyL+ZczpsEQVoHfeec+b4HXwA4wylbZA7D+r2ldFygowyaZ3fDIAADfoH5s/hjGcR
         vljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ro4azlri2Zm/Aj3GAOqfPGTdL14kEj8hPy5vMhDOk3s=;
        b=H2SjNicOyDUWRq3ZCq3JA+YIooU7SSfY9AsaMU/WXhaJQ8g2Gng0aQlq8LKwNRtOuK
         OBufWfmnyfl3AXdtHOY1QCo06CazSpDh00fC0ay2wYGQ4kWTuAFQ3Wz2meYZKCNFaVFf
         OLTcF2jL66D3xpChojYTz7glOzuZ4sZB5E2AqoSRUS98a18nZG7gucc9nEHz6xoyTeOL
         572KCCR+t7G+6O7odwoucw8im4XI29s6ffYD4PxGAV9jPdr61q6x5fRKx14owJ2PwBUG
         rNUTfKpmiAQJwQ7WV/MYhjKnHGC+wcMXIW9Y/dOMTCpN7J84JABWr9001SJYtqkeAgVq
         lY/g==
X-Gm-Message-State: AOAM531vSXPNf2AkJ9kLaCttUznaFtf8C1N6AwFpdtGYivdWuiTeoBiF
        ZcOkVQ99ajCST2V0TIpsKuEAY3+Ck3Mq7rilsIw=
X-Google-Smtp-Source: ABdhPJzytRLWIy3Sg42BMbiWEwzl3/6DV0vgiArKAMhEQP8GnjZyILfsCFjEWtF5ALNni05otch+vMtoQ/ooRgfx3iQ=
X-Received: by 2002:aa7:d55a:: with SMTP id u26mr31861066edr.265.1640901788806;
 Thu, 30 Dec 2021 14:03:08 -0800 (PST)
MIME-Version: 1.0
References: <20211229121605.10513-1-qianggui.song@amlogic.com> <20211229121605.10513-3-qianggui.song@amlogic.com>
In-Reply-To: <20211229121605.10513-3-qianggui.song@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 30 Dec 2021 23:02:58 +0100
Message-ID: <CAFBinCDL=KF2CQyaH0k=qTTEsHmuG_CfXY+6MWyMcY0Qb3SA4g@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: gpio: Add a header file for Amlogic
 Meson S4
To:     Qianggui Song <qianggui.song@amlogic.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 1:16 PM Qianggui Song <qianggui.song@amlogic.com> wrote:
>
> Add a new dt-binding header file which documents the detail pin names.
>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Qianggui Song <qianggui.song@amlogic.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
