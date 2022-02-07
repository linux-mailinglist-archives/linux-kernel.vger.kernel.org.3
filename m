Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A11E4AB344
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 02:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348545AbiBGB5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 20:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiBGB5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 20:57:47 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45733C061A73
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 17:57:46 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id e145so15687325yba.12
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 17:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E6jB5unxCOG3OGPVEmlfiBcR16mWOiuXX5uTcKkbUQI=;
        b=Zm0HO44MuTh3Ps5IZZv8ARTzJUHAkn0gmuSgse19xSu+4RBR3xXWtUFMhDlpZwnpNL
         oeHCrCy1Y+J6yEEwQotcYLROd50usnIe+1sdVWddcJPzilfVgSQwqzNOYXrwYLP0i/0T
         yPysrrH5XxK3Vgqo75kJnst7+hTTyAOUf69xZcLrQ4wnFEwP03pZUP/qBF8qO2QGVOg3
         qtJ0zqAczc/7GPOss4fS3lwXdFhrYr3CG1cTrKzZVwfgmSQ+N8SrZp75scLK88JLn3n+
         yTIGu3bLb66Z4z66xS/8gKPKECIgOSTmEpTKOY7tY1y8HOP+zFY5r5IsB4akL+geFjWt
         +YIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E6jB5unxCOG3OGPVEmlfiBcR16mWOiuXX5uTcKkbUQI=;
        b=U+REYcZAujTkbRM8Kb/ur6bCXkyGokiUQVm607AscyGg3jQ6No32Naa6DwUOkrAsLW
         t5IOxwNUIP0VkzcFDUWz1Z/w5v6Jk1opj/KoJL8/1YsgIG1htHnxy/v580i3vbKKJ3jU
         21mRWY1sfcOngaQQcK/z5nKhKO8itaVw3yNRuhpqNr+cInAuaHIcY+Dmx5auIuk3mNtp
         BIz8bm6F4DmbL+wPkZ2m1LNFuHTQybQXkiXt99pnU5H/AL0g7x8krapouTWz5+qPflJx
         KViHXIAJWTH2gn50I50pGcO82/NGmZ/NhX+/SnZ1EcUFvQciiCDu0PAqbzozSbfnG1MG
         2jmA==
X-Gm-Message-State: AOAM531ceBx1q0PglulydA8zkV0z+pkfPrg4fxHWpq12px7hPVbFZRIn
        jEnbqjLNwcSG+IkmKh0dDiltr08vggyWLbo5MD8=
X-Google-Smtp-Source: ABdhPJxfztv/wBcGEPXfgrgrXn8ooNS5PkjWrqePaC+KxO3p486LI47ivujmNuL3yE1MnPf7NdaDnvArqLVBhY8Q5is=
X-Received: by 2002:a81:de4c:: with SMTP id o12mr8984374ywl.109.1644199065562;
 Sun, 06 Feb 2022 17:57:45 -0800 (PST)
MIME-Version: 1.0
References: <20220206074615.3527-1-joelcchangg@gmail.com> <c0b504dd1f254f19b6ff60948684303b@AcuMS.aculab.com>
 <8536ca17c2945cb77c506d99eff5ccc42e71f2f3.camel@perches.com>
In-Reply-To: <8536ca17c2945cb77c506d99eff5ccc42e71f2f3.camel@perches.com>
From:   Joel Chang <joelcchangg@gmail.com>
Date:   Mon, 7 Feb 2022 09:57:34 +0800
Message-ID: <CAJ-=yTE7mZr_DtCE3HA4ruqexo1gH+LPCWzHAeSmivzj5H76Gg@mail.gmail.com>
Subject: Re: [PATCH] staging: octeon-usb: Fix 'should not end with '(''
To:     Joe Perches <joe@perches.com>
Cc:     David Laight <David.Laight@aculab.com>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.com" <gregkh@linuxfoundation.com>
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

The hunk has two lines that end with '('. The hunk was rewritten but I
believe the logic remains the same.

I agree they are longer than is 'nice', but they are still under 100 chars.

Maybe I should submit 2 patches instead of one?

On Mon, Feb 7, 2022 at 1:17 AM Joe Perches <joe@perches.com> wrote:
>
> On Sun, 2022-02-06 at 14:16 +0000, David Laight wrote:
> > From: joelcchangg@gmail.com
> > > Sent: 06 February 2022 07:46
> > >
> > > This patch fixes the checkpatch.pl check:
> > >
> > > CHECK: Line should not end with '('
> []
> > > diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
> []
> > > @@ -1792,23 +1792,18 @@ static void cvmx_usb_start_channel(struct octeon_hcd *usb, int channel,
> > >     case CVMX_USB_TRANSFER_INTERRUPT:
> > >             break;
> > >     case CVMX_USB_TRANSFER_ISOCHRONOUS:
> > > -           if (!cvmx_usb_pipe_needs_split(usb, pipe)) {
> > > +           if (!cvmx_usb_pipe_needs_split(usb, pipe) &&
> > > +               pipe->transfer_dir == CVMX_USB_DIRECTION_OUT) {
> > >                     /*
> > >                      * ISO transactions require different PIDs depending on
> > >                      * direction and how many packets are needed
> > >                      */
> > > -                   if (pipe->transfer_dir == CVMX_USB_DIRECTION_OUT) {
> > > -                           if (pipe->multi_count < 2) /* Need DATA0 */
> > > -                                   USB_SET_FIELD32(
> > > -                                           CVMX_USBCX_HCTSIZX(channel,
> > > -                                                              usb->index),
> > > +                   if (pipe->multi_count < 2) /* Need DATA0 */
> > > +                           USB_SET_FIELD32(CVMX_USBCX_HCTSIZX(channel, usb->index),
> > >                                             cvmx_usbcx_hctsizx, pid, 0);
> > > -                           else /* Need MDATA */
> > > -                                   USB_SET_FIELD32(
> > > -                                           CVMX_USBCX_HCTSIZX(channel,
> > > -                                                              usb->index),
> > > +                   else /* Need MDATA */
> > > +                           USB_SET_FIELD32(CVMX_USBCX_HCTSIZX(channel, usb->index),
> > >                                             cvmx_usbcx_hctsizx, pid, 3);
> > > -                   }
> > >             }
> > >             break;
> > >     }
> >
> > What has that hunk got to do with the patch description?
>
> Nothing and this should be revisited or explained much more
> as it seems to change the logic.
>
> > > @@ -2121,17 +2116,17 @@ static void cvmx_usb_complete(struct octeon_hcd *usb,
> > >   *
> > >   * Returns: Transaction or NULL on failure.
> > >   */
> > > -static struct cvmx_usb_transaction *cvmx_usb_submit_transaction(
> > > -                           struct octeon_hcd *usb,
> > > -                           struct cvmx_usb_pipe *pipe,
> > > -                           enum cvmx_usb_transfer type,
> > > -                           u64 buffer,
> > > -                           int buffer_length,
> > > -                           u64 control_header,
> > > -                           int iso_start_frame,
> > > -                           int iso_number_packets,
> > > -                           struct cvmx_usb_iso_packet *iso_packets,
> > > -                           struct urb *urb)
> > > +static struct cvmx_usb_transaction *cvmx_usb_submit_transaction(struct octeon_hcd *usb,
> > > +                                                           struct cvmx_usb_pipe *pipe,
> > > +                                                           enum cvmx_usb_transfer type,
> > > +                                                           u64 buffer,
> > > +                                                           int buffer_length,
> > > +                                                           u64 control_header,
> > > +                                                           int iso_start_frame,
> > > +                                                           int iso_number_packets,
> > > +                                                           struct cvmx_usb_iso_packet
> > > +                                                                   *iso_packets,
> > > +                                                           struct urb *urb)
> >
> > Those lines are now far longer than is 'nice'.
>
> True.
>
> This _might_ be better with the return type on a separate line
>
> Something like:
>
> static struct cvmx_usb_transaction *
> cvmx_usb_submit_transaction(struct octeon_hcd *usb, struct cvmx_usb_pipe *pipe,
>                             enum cvmx_usb_transfer type,
>                             u64 buffer, int buffer_length,
>                             u64 control_header, int iso_start_frame,
>                             int iso_number_packets,
>                             struct cvmx_usb_iso_packet *iso_packets,
>                             struct urb *urb)
>
>
