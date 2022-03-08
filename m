Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFCB4D1B0E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 15:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347673AbiCHO4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 09:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347669AbiCHO4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 09:56:11 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064284D614;
        Tue,  8 Mar 2022 06:55:15 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id x5so24781095edd.11;
        Tue, 08 Mar 2022 06:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W3N2onZNeXEWUzsjOhw5lgCOnooSllP3AJaBPnKLKa4=;
        b=cF3pFpGgsqh/x0O0WYaF1G/ds8gl5IPznUxWzBDUnwryuQjj2erEikKXEmJmDAEwac
         SqSiXNIJNgNK6/P7a6OmTsRygL8siE+jjxWC2jCvXYLAnO3Q8PLBXQbIUgW5Ch4jO4Sb
         eJ2baKwVhvQcJwoXaB3A5MynHxfdPwmqxNzUV7w1tFE2iA1UTg29aRMs8h9WxuUaAPj3
         X1k/wm97jt6+aw5/6STGgqcA9xXm/hbxjZnmUr0JbEiyh4S7cOKlICT0gz0w8+jT5YSP
         vLhua+dZM/YObcOBwqkloUXb2JivS7+92w6lO5j3Q82O9qWuJd/g5CF2bPA7RJFzb+Mm
         6MGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W3N2onZNeXEWUzsjOhw5lgCOnooSllP3AJaBPnKLKa4=;
        b=COrst7vNMuA3ev0QUJOVG8lC/0qR/ew9cpxbk9UsUDgBxZvwKjU00QaUA4eCpLGCWj
         d/MLxbpwCpKCplVaXvWredIQCq31ljFM17rEG6upX1RTFkJz7mXCQo4eNR4h6d/5FX5P
         nwfNBW6SF7MRh9l9EC1qznMpvAOTUzZ1VuaPyzG//PhLhl33+JoT4G9EDAH94vXjiqXw
         P+u67LbfvEcRk1AjzpgtI1y1BaxYNnuOTX2ujPNEr7BAOptZ4UF834F8AsdMxRr37t5K
         nMIfQSJbuzvYZgE2+LPyWXcfbxdbF8y4PNuyzfIjLD7vN3JBcispjTeDKhFWQkrkkohm
         jeig==
X-Gm-Message-State: AOAM5300aMrBRrsk+lBjg40F7K6FiR6Jyawf+aVJ583bb6LHQN2oFIIN
        qVOq4KiXihNIVQj+T/o+pCrUjSz15kEyO1lMxZE=
X-Google-Smtp-Source: ABdhPJy186BBAJ+8888FuwNYh2a/36jnGkxB9fjC/QjwyNVZWRM5U2djbwUwdYrGc3tqLepqzxoLsixLK774/uzEZ68=
X-Received: by 2002:a05:6402:3589:b0:416:7de7:cdde with SMTP id
 y9-20020a056402358900b004167de7cddemr348358edc.218.1646751313432; Tue, 08 Mar
 2022 06:55:13 -0800 (PST)
MIME-Version: 1.0
References: <20220302095606.14818-1-ilpo.jarvinen@linux.intel.com>
 <20220302095606.14818-2-ilpo.jarvinen@linux.intel.com> <20220306184857.GA19394@wunner.de>
 <CAHp75Vdxa_p866t5B7zJ8nHS-v+tu3vLiW0=vaBznnyCGyve_g@mail.gmail.com>
 <ab82f6a-8d1b-8e89-4ea-77d1a55667d2@linux.intel.com> <20220307191854.GA27748@wunner.de>
 <YiZfdlw0A75cojCx@smile.fi.intel.com> <6931d6ad-7520-b585-a8ba-35349e730bb@linux.intel.com>
 <20220308122220.GA24694@wunner.de> <d9aabfe-1179-67c2-98d1-f36e7e698f33@linux.intel.com>
 <20220308145042.GA20520@wunner.de>
In-Reply-To: <20220308145042.GA20520@wunner.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 8 Mar 2022 16:53:56 +0200
Message-ID: <CAHp75Vfd-bi3s=JnNTyov4C7prNhwuWHWsUC6n9pM_E+d4picg@mail.gmail.com>
Subject: Re: [PATCH 1/7] serial: 8250_dwlib: RS485 HW half duplex support
To:     Lukas Wunner <lukas@wunner.de>
Cc:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Raymond Tan <raymond.tan@intel.com>,
        Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 8, 2022 at 4:50 PM Lukas Wunner <lukas@wunner.de> wrote:
> On Tue, Mar 08, 2022 at 02:59:59PM +0200, Ilpo J=C3=A4rvinen wrote:

...

> Of course, if hardware-assisted DE assertion requires a particular pinmux
> state, we could double-check whether that pinmux state is set.

I'm wondering how to achieve this.

--=20
With Best Regards,
Andy Shevchenko
