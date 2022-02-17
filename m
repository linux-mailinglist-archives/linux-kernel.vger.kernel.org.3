Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B89A4BA5A5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243064AbiBQQWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:22:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243041AbiBQQWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:22:37 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68103167F8D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 08:22:19 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id c4so93955pfl.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 08:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7xlrl9elM1qetAzeAOSNskPv8W23aPLNt6zInyIdm50=;
        b=w7SMc3R1fI7qa+IHIfDsUjvRQbsv+GH4vWzV2Vr4aGDmOnjNv9NgNYe08/K1XqfKU+
         PYRBRrU+jlnvrb7aZ627g7Z3Js5twNC3pq8YzjfYIIHcMDnOVqGHdU0JneUkdTr30TFf
         IsasmebdnajMuWl94HTPWYxb9eaMG+Zyo6E0eWsLWl2WXCChdNZRlkD19i760V6jW7Qp
         3JNT0lioiOMoq2EDBPs9JDvC7iOtGx4P+4rATFOOPigmwu+9nUUW8ZvA1zqXnoTPoE5x
         9ipfirZLG0/SEZQMR/40uY0tPJDm+ggCI3Ik6E/ablZZnf7/hm6A7XbvNt+Groh1IeVT
         rInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7xlrl9elM1qetAzeAOSNskPv8W23aPLNt6zInyIdm50=;
        b=7ni1MpnCBJeJXNUJSU9MDAhAk4x7h3cx+xLiM08MLp3/bXbSC4rv/yBVjwahD0U1km
         d2xjG9V7luxjczxHFsStAqcJpv0+/zftta52R+3AH4T9qYRvnJ/sqQvHLatvISYucpGp
         OnrXHi25KbggV0HH92rj99UyCMFPfUc4dcSm7JpKGhEzLf8VvPH8hGBKLXOheONtjObD
         Q3fuHK/N4vGWfVIw6ViL2tAgnbbKfeGH60XDgOv3/+v+7gEFCe6dp8f+Rowy/L3eoqHp
         I4B+3SMzdND64UbnYxUZsCmZIKbS6fzb/EzvOMhNUyQRjuAvhl78cSSbvbEnXPa2+aSf
         mo3A==
X-Gm-Message-State: AOAM531IhFHMEE2Ds/uueh++l9Rw2s0MujyQqnWF9BTnRmXysL8fXOoW
        oE75hjR9aPs552ItFJtQS61aJChrt4adhtETEA2UaQ==
X-Google-Smtp-Source: ABdhPJxi+glvreoGdGLbL3g+lsngHfQbV9GM+RnOiWmV7ag0TFGlFKkV8e6uuuKFvlBxOX5gnVs45jIEADyWK/l8M/s=
X-Received: by 2002:a63:83c8:0:b0:36c:9413:8969 with SMTP id
 h191-20020a6383c8000000b0036c94138969mr3018371pge.115.1645114938453; Thu, 17
 Feb 2022 08:22:18 -0800 (PST)
MIME-Version: 1.0
References: <20220214213020.685-1-tharvey@gateworks.com> <9d5cff18-5493-f6dd-4bd6-9bafa2a503a7@camlingroup.com>
 <CAJ+vNU0sWGsQa=YwLE9Ng34-DhJF=YR3oTV+q--KcgTMCjBa2w@mail.gmail.com> <378824ab-3cc9-dcf5-b9ea-5e49b57792a6@camlingroup.com>
In-Reply-To: <378824ab-3cc9-dcf5-b9ea-5e49b57792a6@camlingroup.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Thu, 17 Feb 2022 08:22:07 -0800
Message-ID: <CAJ+vNU2JbRm2SPQTPC7J-E0PGc0tuzd-9-=MFsRSWKEu8ti9aA@mail.gmail.com>
Subject: Re: [PATCH] serial: imx: leave IRTS disabled if using modem-control CTS
To:     =?UTF-8?Q?Tomasz_Mo=C5=84?= <tomasz.mon@camlingroup.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 9:45 PM Tomasz Mo=C5=84 <tomasz.mon@camlingroup.com=
> wrote:
>
> On 15.02.2022 18:26, Tim Harvey wrote:
> > On Mon, Feb 14, 2022 at 10:03 PM Tomasz Mo=C5=84 <tomasz.mon@camlingrou=
p.com> wrote:
> >> This hardware flow control sounds quite limited. Once CTS becomes
> >> inactive, the transmitter will still output all characters from TxFIFO=
.
> >> Transmitting whole TxFIFO already sounds quite bad, but that's the bes=
t
> >> case scenario where gpio interrupt is handled right away without any
> >> delay (so more than TxFIFO characters can actually be transmitted).
> >>
> >> Does the internal RTS default to inactive when it's not pinmuxed to th=
e
> >> actual pin? If so, then controlling UCR2_IRTS based on CTS gpio could
> >> halt the transmission when the TxFIFO is not empty.
> >>> I agree that the increased latency makes using a GPIO for CTS
> > (software controlled) not as good as one pinmuxed into the UART block
> > directly (hardware controlled) but without this patch GPIO for CTS
> > does not work at all because the internal RTS defaults to inactive
> > when its not pinmuxed. For many applications the latency is not an
> > issue.
>
> I think I didn't write the message clear enough. I agree, that the GPIO
> handling time is something the user has to accept. Usually this part
> alone is not that bad though, as many receivers are capable of receiving
> more than one character after deasserting their RTS output (transmitter
> CTS input).
>
> The general expectation is that the transmitter will output maximum one
> more character *after* CTS GPIO change is handled by software. This is
> not the case with current version of the patch.
>
> With current version of the patch, after CTS GPIO handler finishes, the
> UART will continue to transmit up to 32 characters if not using DMA.
> When DMA is active it is much worse, as it will keep transmitting all
> data already submitted to dmaengine.
>
> As the internal RTS defaults to inactive when its not pinmuxed, the
> software is able to freeze the TxFIFO (and thus DMA if enabled). To
> freeze TxFIFO when using CTS GPIO, the software has to clear IRTS bit in
> UCR2 register. Setting IRTS will thaw the TxFIFO.
>

Tomasz,

Ok - I understand what you are saying. Yes, I should be able to use
IRTS to freeze/thaw the transmitter based on it being inactive when
not pinmuxed. I will work on a v2.

Thanks for the explanation!

Best Regards,

Tim
