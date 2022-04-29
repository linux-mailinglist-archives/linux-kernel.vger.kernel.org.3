Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8688E514061
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 03:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354076AbiD2B6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 21:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbiD2B6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 21:58:18 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB57BB0AE;
        Thu, 28 Apr 2022 18:54:58 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id m6so4230336iob.4;
        Thu, 28 Apr 2022 18:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YNr4dv3JNnMf5I1DjV2JKVssdmjDHBNzpOU5voLiAd8=;
        b=bcY/QvagGm6wnaiLh7HIpm1nJWUo0J8Kqi7JVPwT+GO7FzLIYnLE1hJw6pEk0+2QjV
         nRgH/n2ha4GRwWYv7HPeegKvd7hmjZyNyvakANTKr6MaHAKhnHyqqvFXBhVgoVi3oV0x
         res1FAtFZeEoHWekc5USVup5nCF3f4vICvBqeiI1s5NYtkbVciu4T+ZQD5QB9mS07l6M
         be795bir8IC5jm3+Hix/ZynnWwSmODOQ90A5111DskfACowJFBU6HwZvKdNf53mhtBGf
         ZQO5lrNRhWCdDyyUNtaLbag/YFYTLtoleHt1Y9yWvvLy909Us6mZ6xyB0nM7Iw9IiWQ8
         TQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YNr4dv3JNnMf5I1DjV2JKVssdmjDHBNzpOU5voLiAd8=;
        b=7p8AsfAVceQgzRqwTod56Po0bSkYNIFpx64eZBhQ/k+qfR+G53jvjrjJNvYC8IoRmk
         gyOVbEC7NzUJZLC6L+j2I7/AExu5nhzTcEKUHZgg737Sk6LpTje0wW+PA5ebS5WHcDzQ
         PZHBswHPk87SINF48b6fuM64iAdGWOUd4L7eadMGC/re0cj7rua0vJHM3EHet8cuAEJ3
         Da8LrEcVFrIBD3khIDIKhcaO1N9mESCWCCGrWTtzmaq3oTmjWhSkXsHe66nefDMRQ5+5
         8txnAXuuyDKMzbZZv7m9uxMJrUCtieyVP0cQ8CE0AJ/4oxg1zvSVLSER40ocJ/eHq7dX
         9tOw==
X-Gm-Message-State: AOAM5326yT/Oacy51HyKbDKPggu2MzlgWcdm2l8XYsE61zBYcR4NVbbW
        XI2ryIEzHtbVAH9r/wQ8LLPFNM6ShxZVvEpSAXo=
X-Google-Smtp-Source: ABdhPJxtaktnOnC6Jze7ekAknMust1zCbi4KjcY7JcVhMPZwKAzxl/2IgeH/EkSzRJoUAingHwsKsKx7qHhnv1wmfMo=
X-Received: by 2002:a05:6602:2f12:b0:654:b304:b016 with SMTP id
 q18-20020a0566022f1200b00654b304b016mr14632824iow.60.1651197297569; Thu, 28
 Apr 2022 18:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <e05ec742-c3dc-df7c-c5d7-29358d0a7081@linux.intel.com>
 <20220424015757.21993-1-surong.pang@gmail.com> <YmfdN97xtmwSOo59@kroah.com> <CAEDbmAQmYQdMNY8sANnSuauBcsemrV1MFR3bB83JJ7cHNdWGmA@mail.gmail.com>
In-Reply-To: <CAEDbmAQmYQdMNY8sANnSuauBcsemrV1MFR3bB83JJ7cHNdWGmA@mail.gmail.com>
From:   surong pang <surong.pang@gmail.com>
Date:   Fri, 29 Apr 2022 09:54:46 +0800
Message-ID: <CAEDbmARx0EvvUo_d7w5-gtTvSp3YiTatsMZoBJVZc2O7-M+cWw@mail.gmail.com>
Subject: Re: [PATCH V2] xhci-plat: Let usb phy shutdown later
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        mathias.nyman@intel.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Orson.Zhai@unisoc.com,
        yunguo.wu@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,
Sorry for html email response.
Yes, The subject should say "xhci-plat". And it didn't fix a specific commi=
t id.

surong pang <surong.pang@gmail.com> =E4=BA=8E2022=E5=B9=B44=E6=9C=8828=E6=
=97=A5=E5=91=A8=E5=9B=9B 14:26=E5=86=99=E9=81=93=EF=BC=9A
>
> Dear Greg,
> No,  It's just a patch to call usb_phy_shutdown later.
>
>
> Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2022=E5=B9=B44=E6=9C=8826=
=E6=97=A5=E5=91=A8=E4=BA=8C 19:53=E5=86=99=E9=81=93=EF=BC=9A
>>
>> On Sun, Apr 24, 2022 at 09:57:57AM +0800, Surong Pang wrote:
>> > From: Surong Pang <surong.pang@unisoc.com>
>> >
>> > Let usb phy shutdown later in xhci_plat_remove function.
>> > Some phy driver doesn't divide 3.0/2.0 very clear.
>> > If calls usb_phy_shutdown earlier than usb_remove_hcd(hcd),
>> > It will case 10s cmd timeout issue.
>> >
>> > Call usb phy shutdown later has better compatibility.
>> >
>> > Signed-off-by: Surong Pang <surong.pang@unisoc.com>
>>
>> The subject should say "xhci-plat", right?
>>
>> > ---
>> >  drivers/usb/host/xhci-plat.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat=
.c
>> > index 649ffd861b44..fe492ed99cb7 100644
>> > --- a/drivers/usb/host/xhci-plat.c
>> > +++ b/drivers/usb/host/xhci-plat.c
>> > @@ -390,13 +390,13 @@ static int xhci_plat_remove(struct platform_devi=
ce *dev)
>> >
>> >       usb_remove_hcd(shared_hcd);
>> >       xhci->shared_hcd =3D NULL;
>> > -     usb_phy_shutdown(hcd->usb_phy);
>> >
>> >       usb_remove_hcd(hcd);
>> >       usb_put_hcd(shared_hcd);
>> >
>> >       clk_disable_unprepare(clk);
>> >       clk_disable_unprepare(reg_clk);
>> > +     usb_phy_shutdown(hcd->usb_phy);
>> >       usb_put_hcd(hcd);
>>
>> Does this fix a specific commit id?
>>
>> thanks,
>>
>> greg k-h
