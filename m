Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0599951B1B3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 00:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378954AbiEDWTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 18:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358446AbiEDWT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:19:29 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC7DFD2E
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:15:51 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id s30so4754049ybi.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 15:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qLBklQTU++z1XSeA0IFDBp8dJkPyeYhGjMSHqs5VeMA=;
        b=NWe0TZcqMFAwCb8eYzInkQywqxx45yJ/Dp3UIamLDQ3fdPCvawza91uR6m3BTXZB1c
         tOFje3SBN3ZUSbpczZvytggrRDBBNbpv2xxtvzN3Yf8JFj4juv+Ixd0d4sCLqPQ9pO0M
         SkPfGB9EZ3QwwM8oegYN4MjMndK4rqiMyKtjTrkIyjlxw2cNBCk65l/GhzOjUjAI1YB/
         iA765SA3zq2F/ud9RrhWKMjOyEKO3KnEU1HU2UVlR5w75a/XuK9ZtPxe/kNs3B0zlRk8
         F9Dz7yO/Krb1igXE6UMDINeUjlXTVXHft6B128HL30WE9LHSQgnc4nqoZMqLTr8jgy1m
         E61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qLBklQTU++z1XSeA0IFDBp8dJkPyeYhGjMSHqs5VeMA=;
        b=dPzuE42jtIau0yUQGMGeaddvREFsdLvp26gZtHkA3CJmFoZxArRcGxod7rxzBE2xM0
         wKJNrn9f8ZAyZZGSkTlooO1QHhPGzJ01CkjQCvEp7oezMkMC27RQmXEkp4uYs7TnzHS8
         jfRHIqinrc9ARPc/nQrAdP4QAxhTIB49aQKlGoRRD6Cmlaac0kHlgURhd/4Y4HbEdIJ/
         p9aIIPRamIhElCYvE/AFiDIBI/99sopjGXWK+mCpT7lOf6azOciF45q0HQ7oeTfxqrF3
         7mKEoiAxQhio6C/rH5jzxgSklLXnmqbQeQYh3nYnlkJSYcBS/OmEPNJnBZ150dA/A29S
         MKAQ==
X-Gm-Message-State: AOAM531mp4QFpk5L1vGC3kff7VfxhbvXjk9IKgWa1uPbzE9gUB+f4I5X
        vN8kbNMW9ezu59ep7fR44/s7e0zDgMSHKVZdwt2eKg==
X-Google-Smtp-Source: ABdhPJyjwpvxnoeMjH4hOqPTmTuEjrbSWm6SYSfBU1hA8Xqb22rp4DU76PZhUpFUOSMMV4MibDXJTCgu5WQIa3Kjr3I=
X-Received: by 2002:a25:aa94:0:b0:648:62f2:ef4e with SMTP id
 t20-20020a25aa94000000b0064862f2ef4emr18637229ybi.626.1651702550800; Wed, 04
 May 2022 15:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1651647576.git.hakan.jansson@infineon.com> <64b59ca66cc22e6433a044e7bba2b3e97c810dc2.1651647576.git.hakan.jansson@infineon.com>
In-Reply-To: <64b59ca66cc22e6433a044e7bba2b3e97c810dc2.1651647576.git.hakan.jansson@infineon.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 5 May 2022 00:15:39 +0200
Message-ID: <CACRpkdY3xPcyNcJfdGbSP5rdcUV6hr87yJNDVDGZdRCfN+MqLA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: net: broadcom-bluetooth: Add property
 for autobaud mode
To:     Hakan Jansson <hakan.jansson@infineon.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 4, 2022 at 11:04 AM Hakan Jansson
<hakan.jansson@infineon.com> wrote:

> +  brcm,uses-autobaud-mode:
> +    type: boolean
> +    description: >
> +      The controller should be started in autobaud mode by asserting
> +      BT_UART_CTS_N (i.e. host RTS) during startup. Only HCI commands supported
> +      in autobaud mode should be used until patch FW has been loaded.

Things like gnss uses the current-speed attribute to set a serial link speed,
maybe also Bluetooth?

Would it make sense to use

current-speed-auto;

As a flag for these things in general?

Yours,
Linus Walleij
