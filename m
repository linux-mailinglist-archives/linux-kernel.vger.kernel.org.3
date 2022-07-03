Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3AB956494F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 20:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbiGCShB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 14:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbiGCSg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 14:36:58 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E442AE9;
        Sun,  3 Jul 2022 11:36:57 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-31c1d580e4bso64365017b3.3;
        Sun, 03 Jul 2022 11:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=01IXmPhYuZ6VlM1S6cBbYA+G+eWAheXLMfpJF09J5h0=;
        b=XSQ7W9e1A8JRu6cEwBFhiCyxx9kMVLCUi9x+mnwH/P/dRBvt9yzVwY84PdQQMbJjY0
         PLG8/WP54VYi+oYdj993LciYnsM36VxfuiKE5zh5rM5NgZeWuYSooctgIHIRkjM/GECz
         sFJ+vdbou4WsGusH5mqjaEQOMuLEvNK4HY7J0BaZqo+c70pxQZU5B4ac2NbmtDc8RJbf
         vKhzfweWs2mUZXLRTvzW8rS0FMpKtCSHT8QgsIfrwtkT6MdWhXrcVybcpJ6bYJPlLYko
         Jbw4Nus5vNQZXQZpghFkM0nEsoVCicPmUCZ7y6W1fTBsFet5YkeB+p45vq8o48S4XUS2
         5EUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=01IXmPhYuZ6VlM1S6cBbYA+G+eWAheXLMfpJF09J5h0=;
        b=kfLFVterFrYrgqRfHMySiQcj9U6D5RCEUz5tLq96y5wWKOJgRwADTqnRjnZAE++oSQ
         XOvd3O7wdOngPmk+Qz+G6J99wHZCLt38qNy88gV9A7Zre8UcApSM8idaCMAMK3lJeUk5
         d5OK8xU6arVlv7ZM9qSEuCSIExafF8XqT5Zh+jeVjvDN1jQYIfZU8muAjgy5v6QaohTK
         epUgPm6HFw3OaxphyVy4buiW1joU/K+8k7BBCP/h3pMLTe7jwPMuOwClyrKWRaHm07jF
         aJAC+NduWwCPvbifWcZ/3z7DofRABp6xndZREfaB9ailLbzixO+Ys6hESquo0eW2h6DG
         ExZA==
X-Gm-Message-State: AJIora8bzKq+Q0p0GEK99Mkf85s3xPks2pGUpQ0xtWD17hB15fB8Bq+E
        2w+ljksotj+TSEFGBf7IAeKjqRZMpBo2QHDVyeA=
X-Google-Smtp-Source: AGRyM1sp15ETRPyE4hQ18Jlc955QlxmgsWxeKfPbmHoG83zFyjKbeg/AfEUK084940cbAYDFXU+IEzkBK5MXiUugW0o=
X-Received: by 2002:a81:b52:0:b0:31c:932d:e3e5 with SMTP id
 79-20020a810b52000000b0031c932de3e5mr2536002ywl.185.1656873416766; Sun, 03
 Jul 2022 11:36:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220703170039.2058202-1-LinoSanfilippo@gmx.de> <20220703170039.2058202-6-LinoSanfilippo@gmx.de>
In-Reply-To: <20220703170039.2058202-6-LinoSanfilippo@gmx.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 3 Jul 2022 20:36:20 +0200
Message-ID: <CAHp75VfTQmzfVbxbVKWyWnJZERfPs5v=SmjexY0d+CPYXT7xgg@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] dt_bindings: rs485: Correct delay values
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 3, 2022 at 7:02 PM Lino Sanfilippo <LinoSanfilippo@gmx.de> wrote:
>
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>
> Currently the documentation claims that a maximum of 1000 msecs is allowed
> for RTS delays. However nothing actually checks the values read from device
> tree/ACPI and so it is possible to set much higher values.
>
> There is already a maximum of 100 ms enforced for RTS delays that are set
> via the uart TIOCSRS485 ioctl. To be consistent with that use the same
> limit for DT/ACPI values.
>
> Although this change is visible to userspace the risk of breaking anything
> when reducing the max delays from 1000 to 100 ms should be very low, since
> 100 ms is already a very high maximum for delays that are usually rather in
> the usecs range.

Yeah, something similar is what you need to add to the previous patch IIUC.

-- 
With Best Regards,
Andy Shevchenko
