Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17F756C2EF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239439AbiGHTKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 15:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238234AbiGHTKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 15:10:19 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC9F1D30F;
        Fri,  8 Jul 2022 12:10:18 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id y2so20523620ior.12;
        Fri, 08 Jul 2022 12:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qkcbC6yq5XLhBzTTu+MMovI7rdFjrz0afp4P2lwP3Gk=;
        b=Ufb7JbLaRhwgNFKC3wKUcoi0CLM79ax4hGpkwdpDERueBoG2oimALdcBQiMMdk8AQ0
         S4bIhQsF1yRoxsk9YWyrT2KajKQlFdZXYuGkuaExm2x8kCra+o5KI23F/7QJl0sFwi/5
         ZmHqrmRYDUBYnC3YIiaBwMMTlPSxuGkX9O+7cTrfcKBB3cf4u7k8R3mSWesnJOXh72Qc
         /P1QeI/wFCk8Ct6GoGKa7uuf8G6ztBGEYJLSJx3z4mwtRR0vIy8Qr6oQVs3pG0LWQf+V
         fzqa/tH4Anl7pjYUUO4okchtUi+3/smTZNVRXNCE9fSr8M2Gb6sQj/fS7+zyv7QgBVZl
         rprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qkcbC6yq5XLhBzTTu+MMovI7rdFjrz0afp4P2lwP3Gk=;
        b=dOHRekn69Y/XioiRfpm+5/Fbh235YvyspFhuucfWHIIsGXaHMsVTgESU4olsXhJ0Ti
         SqAtmz8LB+HwRwh7GjUQ8peDXJhlNVgenemITdJVBrNjM8d6DCxqkamSMzCwK5Ym4rJ0
         z4+oyYvwGxuysbM8NKN6XF0OZ7cYa3kou13VGAH2FIh6LvOdJUQjOVK8puML0z3I/KFI
         zdNXro8Rb7uxDmA0QDpx1ovx8/EA/msB4XgYBMbpgzbkETJ5cbL6qYZVrdFNdW4/cfik
         rA1DNlO4TjI8ebw4RsOFLckygGdM63L0nVJz0UxKVbRi4pCunoxn41a8yusAah+yfb8+
         3BQQ==
X-Gm-Message-State: AJIora+axOzMfF0OrH2boojj6PTs3uh5fQwYr7jPyihX71+5NgA5fUcI
        p2n1skCN4DPyfm7tPPft6hFaNiD+nI3NvrvQVb4=
X-Google-Smtp-Source: AGRyM1vjrSQNi3fUurB4mnaqOn2/DN69XlyXYO+6EfgfC+s7JyKUTAOAPdIQ9gUdIjFF2zBdLd86vSxWQZKRB/0SjcQ=
X-Received: by 2002:a05:6602:1682:b0:65d:f539:e30 with SMTP id
 s2-20020a056602168200b0065df5390e30mr2690129iow.81.1657307418278; Fri, 08 Jul
 2022 12:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220703192448.13763-1-khalid.masum.92@gmail.com> <Ysgn0hxHkt3pvzAB@kroah.com>
In-Reply-To: <Ysgn0hxHkt3pvzAB@kroah.com>
From:   Khalid Masum <khalid.masum.92@gmail.com>
Date:   Sat, 9 Jul 2022 01:10:07 +0600
Message-ID: <CAABMjtF98YwVaaaAKftFyta5CPM2As=1ykvyDf8CDLsCusKxkQ@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: Describe function parameter 'mult'
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Felipe Balbi <balbi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 8, 2022 at 6:49 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jul 04, 2022 at 01:24:48AM +0600, Khalid Masum wrote:
> > Currently the parameter is not described. Which triggers warning when using
> > make htmldocs. Fix it by describing the parameter.
> >
> > Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
> > ---
> >  drivers/usb/dwc3/gadget.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> > index 8716bece1072..e8c86b08cd83 100644
> > --- a/drivers/usb/dwc3/gadget.c
> > +++ b/drivers/usb/dwc3/gadget.c
> > @@ -657,6 +657,7 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
> >  /**
> >   * dwc3_gadget_calc_tx_fifo_size - calculates the txfifo size value
> >   * @dwc: pointer to the DWC3 context
> > + * @mult: multiplier, 'mult' value for SS Isoc EPs
> >   *
> >   * Calculates the size value based on the equation below:
> >   *
> > --
> > 2.36.1
> >
>
> Does not apply to my usb-next branch :(

Thanks. I looked into usb-next and a fix is already there.
