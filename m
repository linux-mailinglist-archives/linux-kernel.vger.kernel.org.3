Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15084F227F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 07:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiDEFPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 01:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiDEFPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 01:15:35 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B260494;
        Mon,  4 Apr 2022 22:13:37 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2e68c95e0f9so124231257b3.0;
        Mon, 04 Apr 2022 22:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=vExsGhbuGDTgRyjW6nsfnayP9D5NmT9wV3d2NDaVDlA=;
        b=iEEMqo/gdMqZDaeJ8ngvcLvi7M/MxYHDLLBWCCDlrLQkXuvHn/p+mJdjNKyIpLwOEw
         FgvQxrR7H8h3oyOw1gqXfbWnVogSA4UOn2y46Om0907kQq0XDRBtB5HYe7r8tTSlCXv3
         5eB99n9v5BBw+gI8AYX6KEKmw/jTsNbBSYkQApZW+79VauduYczHhGcsqXIYPnfMI3LM
         iH9irl55DqckLefCEkk+T8HaZk2OLu7jGFPuH3cmRm1DrOXqchJKw8iN/aVKT/5v6Mku
         OYPro0IijdnYdP7K86XPcVDzkmN04uK+UXC8bmH09begZngQunt6FxOWsa2ARxQnaJlX
         Sh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=vExsGhbuGDTgRyjW6nsfnayP9D5NmT9wV3d2NDaVDlA=;
        b=4neNX2ByxjMnOiFdvRoAfstpl09j7dyidB9oww2zGI082roLV8hBGRMaETWHDUMO1O
         sv+LmBsO8RghFk1GdqRlHAT0zuHU29G0WsOEzK9iZ0qUcWDCdLMHGRk2v9oq9vCj4pDw
         BfcxWU9D/Vq0D+PrirrMeDLCYL60J3gRLaACc1zGXlWWqYiflOv6+veQy/YbiSLzfeBd
         cCOL2vhJscTuxcDhDripwTwMpCsbRCfIcIcHGt/NcOkrurgc49VquIQ6+E7JR3zPvgAX
         BE/TR+oZfN2xk+dsc2wiXJFPvu1hyzsVdVtgzjtY32Hkkk957nEn7vicGyYvBGkHpnSX
         91QA==
X-Gm-Message-State: AOAM532W7x6WJIgOD+lWPVdklOemybVWPKGJWyih2tmMrxJLBwcvdsL6
        U0DL27/YXqlvuu2A+rHGzLGIOXmhDsTPJg0Ml4O0C0SHmmnUKQ==
X-Google-Smtp-Source: ABdhPJzkKqwaQo8Q3QAxPhyp/Mpg9znQAfCPlsdm3+WUQh6q6jkj8gyvWAI3sawXFa/tnpmEjORexlXzyqTgZx3MXDI=
X-Received: by 2002:a81:d0d:0:b0:2ea:61b1:181d with SMTP id
 13-20020a810d0d000000b002ea61b1181dmr1295727ywn.16.1649135616943; Mon, 04 Apr
 2022 22:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220404172322.32578-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220404172322.32578-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Yks3Q75ZrUkXSjwz@ninjato> <CA+V-a8skF4h6yhjSFw5PXQEbgKEQt6kMs9bEsO3OCNfE1hu46A@mail.gmail.com>
 <YkvJXu7Y6Tc68U9e@shikoro>
In-Reply-To: <YkvJXu7Y6Tc68U9e@shikoro>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 5 Apr 2022 06:13:11 +0100
Message-ID: <CA+V-a8uPSr6+xcyqmBXZzuPb04v8KLNRou5Y+QvC7ibuAU_2Ng@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: renesas_internal_dmac: Fix typo's
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Pavel Machek <pavel@denx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
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

On Tue, Apr 5, 2022 at 5:45 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > > > -     /* This DMAC cannot handle if buffer is not 128-bytes alignment */
> > > > +     /* This DMAC cannot handle if buffer is not 128-bytes aligned */
> > >
> > > Well, as we are here now, I think this can be further improved.
> > >
> > "The internal DMAC supports 128-bytes aligned buffers only", does this
> > sound good?
>
> I'd think it should be "128 byte aligned"? But I can't explain why, just
> a gut feeling.
>
Fine by me.

Let me know your thoughts on patch 1/2, I'll send a v2 with updated comment.

Cheers,
Prabhakar
