Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203F2545546
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 22:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239481AbiFIUEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 16:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbiFIUES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 16:04:18 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBB06A05C;
        Thu,  9 Jun 2022 13:04:17 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bg6so29781480ejb.0;
        Thu, 09 Jun 2022 13:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hHccYO4z5usBojn087eWGV+jtlxg4L1Z0rSYUHXah30=;
        b=MzK55xDftqFwDPyfVCY7qiTgQHhw5KesPgjLEHgVe5c8iVsi7WJVaGi3HQShA5VfEQ
         Kn/0mRYQS73Chzq89V+ucqGUae0L6oTBbtkQRbknGz2rA/qaiNxFD22oFYTqCkDAU4EZ
         a+/aVe6nUWt4hKAQosJGv3YfLIXqFcS90I9GBPXwz+VnH4A41p/PhAHRX2rDp7fU6StS
         NduLvu5zanSz2LpVdKlLaZvlsuLPjgrMyntgiAU8noKZgFaLX9LU6wY6aTEHkp3SqXuZ
         59c/FZe+gEKxuZ/pgVYQZ+AnBvfYbshMkp90Fkaqe9Iu8ek0XMEp3B2Ez93Xd++aCQsj
         z66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hHccYO4z5usBojn087eWGV+jtlxg4L1Z0rSYUHXah30=;
        b=rSNSI3e7xXs/7NjQHj056HBpV/WtuxlvKe8wCysEPl6dsI98bZdLaXRD4qqqdcUubT
         S99eScepDsFUYCRgeMT6ngiB04B2ijaf9BawTcJFJYpCTF1Sp/uPElaMke6amB8/gipn
         WBsvvyQbXmXfSM0fqC7tz9qaZ7C/bWSnvCAmR/AY/OH1StsosafpWHc/kebRtstLc/2L
         yB7V/RnIufHFjfOUv8EzUa13Mj4iSgd2/rGjx2PTjDlQ1/hXslozI1hWCkEdjM8XXbOq
         MFrPTqQpVMrFOaAURbgBKZ4Jwz9nd4JJIyGoPIX5b3Rz2zoQA5qsnbyagZbu8UjXhKr2
         a54A==
X-Gm-Message-State: AOAM531I0GwVwGAh0XddgeLQTkv7dueDhkUV8tIuvwZj2pvsZxX/WGj+
        naC9cuFlRfqeo+HLvjT93g8K3aOPkekTwAnk+0k=
X-Google-Smtp-Source: ABdhPJxfhhcOra1ui4AvrkvXdWpqY9OeKmCTNjSpjd2RoNGVaKcF2Dqv56z2FDMl582+UvxSiToI0PJmhOR4YpEYj9Y=
X-Received: by 2002:a17:906:b18e:b0:710:26db:7a53 with SMTP id
 w14-20020a170906b18e00b0071026db7a53mr29313366ejy.290.1654805056333; Thu, 09
 Jun 2022 13:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org> <20220609113911.380368-7-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220609113911.380368-7-krzysztof.kozlowski@linaro.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 9 Jun 2022 22:04:05 +0200
Message-ID: <CAFBinCC2A-Fe9QbZtffmCvHFNWcgaL-TZydwFBKsBp-n2sD_1A@mail.gmail.com>
Subject: Re: [PATCH v2 08/48] arm64: dts: amlogic: align gpio-key node names
 with dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 9, 2022 at 1:39 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The node names should be generic and DT schema expects certain pattern
> (e.g. with key/button/switch).
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
