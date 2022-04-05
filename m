Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77EB4F2177
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiDEDxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 23:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiDEDxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 23:53:16 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC32B1D338;
        Mon,  4 Apr 2022 20:51:13 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id d138so12814487ybc.13;
        Mon, 04 Apr 2022 20:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=TT8cfI20ps2jkS0BBKD4E1g+eYIbUBm85sCgqhHCb+8=;
        b=RxXFXC+jtGNk6eyXLkOmGzyu1OydIRCdfkWYmoRUFzudPsO3L8r5H884HahcvkuGJa
         //bR6Jx4gZ/CvtN8XtyG0m1vnpz5EeDYRKGK0cPK6kGDWWpkQSKVv1PghOelJC5yjoKF
         BIkc5yu/Nzo5j9bWjCIqkWu+/FRPwaJQihYkNX8TKVL9lFIYDb7fRWNPh3BMHqAKtA8f
         2QEz3T4sKRiOAO9GRKjDgPWbvlXcq3j7UQohreEpWInD1eCOeNDEm5K9SWgEpHJCUu2B
         2zHOQoezojUn1HyXOXufttM4N4OqwhqLv25cdmgxVW0kUfFavLCXutvYwP4IAiQsBi99
         bdZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=TT8cfI20ps2jkS0BBKD4E1g+eYIbUBm85sCgqhHCb+8=;
        b=Uk9taD5G73NLPUnISflwlBzl0YGpMwtZUoGBQMwUtNlfbtpJqfai2HViTgN2jbk3Cx
         wx6xyNjGzfwhOd3GnfAIDKi/rSZjXf0LY88vXrs2EOnp96UmGG+YGbUi/GJ9qgUAzLTz
         ZPMix4KalDizSyTZdHTWtmKf1bML5aU9D5q3MS/YKH6kECfU+cLD5rx5KBb/VGOjJ1bT
         +75QC2k7QTfI1D1lfbbVg7k4LyhHO0B/JW9vk0ciOh80oODrUjUYbxAdE0S6CfjoHTlq
         /Cshhgsz298pvX6oy9l98aaarCBj5ZIA2GdJRjM38eAbA9CWrAxQGgl678Jip1WPq760
         x4bg==
X-Gm-Message-State: AOAM531e/dr8A7n2oSvwXQ34L+PqLZ9kEwV7WG57y6GKJMjic9QlUaxC
        eTfX1vIz/Li6yL+98iK44gGC36kLxldlQ5hkji4=
X-Google-Smtp-Source: ABdhPJxLDIByWyO8OsuAqSnbLLXGmfFQzg/hCHaByiTILpyKv8XO83+yTkbozOPu3l1myFPm0gyq0LIUsXLOI2vJAhw=
X-Received: by 2002:a25:a0d4:0:b0:63d:8b32:6d56 with SMTP id
 i20-20020a25a0d4000000b0063d8b326d56mr1170958ybm.218.1649130672998; Mon, 04
 Apr 2022 20:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220404172322.32578-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220404172322.32578-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <Yks3Q75ZrUkXSjwz@ninjato>
In-Reply-To: <Yks3Q75ZrUkXSjwz@ninjato>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 5 Apr 2022 04:50:46 +0100
Message-ID: <CA+V-a8skF4h6yhjSFw5PXQEbgKEQt6kMs9bEsO3OCNfE1hu46A@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: renesas_internal_dmac: Fix typo's
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Pavel Machek <pavel@denx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
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

On Mon, Apr 4, 2022 at 7:21 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > -     /* This DMAC cannot handle if buffer is not 128-bytes alignment */
> > +     /* This DMAC cannot handle if buffer is not 128-bytes aligned */
>
> Well, as we are here now, I think this can be further improved.
>
"The internal DMAC supports 128-bytes aligned buffers only", does this
sound good?

Cheers,
Prabhakar
