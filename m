Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A2F51B7C5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 08:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243273AbiEEGLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 02:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiEEGLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 02:11:42 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA0537BC0;
        Wed,  4 May 2022 23:08:03 -0700 (PDT)
Date:   Thu, 05 May 2022 06:07:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1651730879;
        bh=7wV3nEqPSepuWRAWthSPZD1tqykwAgSdmFsPCIxH7/8=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=m5ncVI+42u1olzmIdRjOX7p/YpFN8gJhka+4KasJ4F9b/8M8Wbr+EHNLponmiC1p2
         0HelPzW8rdUyEdAj8Plbx4pVoXPeevt35PmsWEhQoUXeGWAayOGScA5Iwaqo+2W6Tj
         L1/mjeGT2klut1BMqZgTw0RcTg4QUKvy3siiemP1ohX/i27G6KT79GT91emgtEtnJq
         q6VXdb4srwETpPE5hZfSsqO5nsb5DfyPZ57JOrQxSEB9rERMTjNBd5v3dwXk/Gn5aM
         s346iSqeWMTq71yTlQweFGtAgyCFKFVsJQy/OxUV8epgrPgusJmZiT+HoGCCPVVW3F
         FYD3P/5JI1olw==
To:     Marcel Holtmann <marcel@holtmann.org>
From:   Juerg Haefliger <juergh@protonmail.com>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Reply-To: Juerg Haefliger <juergh@protonmail.com>
Subject: Re: [PATCH RESEND] Bluetooth: ath3k: Add MODULE_FIRMWARE for patch and config files
Message-ID: <20220505080744.0343a857@smeagol>
In-Reply-To: <6A323366-2AB3-443E-A605-C18EA7A2E161@holtmann.org>
References: <20220504074606.15505-1-juergh@protonmail.com> <6A323366-2AB3-443E-A605-C18EA7A2E161@holtmann.org>
Feedback-ID: 10260306:user:proton
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_8zeict0kE8yCg0ChFWUkcf4Hel9dCyVf4xhoRkb9k"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--b1_8zeict0kE8yCg0ChFWUkcf4Hel9dCyVf4xhoRkb9k
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Marcel,


> Hi Juerg,
>
> > The ath3k driver loads patch and configuration files so add MODULE_FIRM=
WARE
> > macros to povide that information via modinfo.
> >
> > Signed-off-by: Juerg Haefliger <juergh@protonmail.com>
> > ---
> > RESEND:
> >  Resend from protonmail email account to please the test bot.
> > ---
> > drivers/bluetooth/ath3k.c | 2 ++
> > 1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
> > index 88262d3a9392..56e9a64177ae 100644
> > --- a/drivers/bluetooth/ath3k.c
> > +++ b/drivers/bluetooth/ath3k.c
> > @@ -538,3 +538,5 @@ MODULE_DESCRIPTION("Atheros AR30xx firmware driver"=
);
> > MODULE_VERSION(VERSION);
> > MODULE_LICENSE("GPL");
> > MODULE_FIRMWARE(ATH3K_FIRMWARE);
> > +MODULE_FIRMWARE("ar3k/AthrBT_0x*.dfu");
> > +MODULE_FIRMWARE("ar3k/ramps_0x*_*.dfu");
>
> I am still not convinced by the glob file matching. How would that actual=
ly work?

In my case I need to remove firmware blobs that the kernel doesn't need to
reduce disk usage. This information helps. While it might retain unneeded
versions it's still better than nothing.

...Juerg


> Regards
>
> Marcel
>


--b1_8zeict0kE8yCg0ChFWUkcf4Hel9dCyVf4xhoRkb9k
Content-Type: application/pgp-signature; name=attachment.sig
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=attachment.sig

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0NCg0KaVFJekJBRUJDZ0FkRmlFRWhaZlU5Nkl1
cHJ2aUxkZUxEOU9MQ1F1bVFyY0ZBbUp6YWJBQUNna1FEOU9MQ1F1bQ0KUXJjcEpCQUFxVnl6K1dE
K20yUEd1TGgvVituQzc1eHVNT3NGeURWcjNTYm9rcGZ5UGxyUCtUUFRpTmxWeE5vUg0KdjRBejNm
b3BLamh1Vit6bDFwSWl0bUE0Ym9wOTNHbnFTeFlpbEVJdzdYZ1o5NlJTYVVqQ3ZwWHpsZTd3ZXJY
Zw0KT040TkFqY1pjbk56V2dIckdaYnZWL1AxZ3ZaaXpiL3h4MWNwSFVUT3huS1FPVjR6MkZtWVRB
ZlZESFJVenlqag0KSHg4ZzJuazFJSGlNaDlyampSYjdhWTBxWkdIeWhNNlFHVWlKMHBRTWkzT0xo
eEhDWnN0NkFzWnBYM3kvRFNZNw0KeVRVWXd4eWp6K2NHSHo3cDRhZ1BPOCt0LzRjaCs4YzIxalVJ
K3d0b1NnZG5XZnJJWWhkYUhxMkljK21sazZoeQ0KVHB4ekRvdkRJQ1B1WTVvc2luek9IcHN0dGpI
MEJ6cXY2b2ZhcUpScytTenBRZ0NaSlBlOWloSUNQQ3pJVldnaw0KWCtFb3ljRDFUZG04ZnFYMk50
czR3UkxDTm9tdkZ2WjNXVHJpQTJwWFliSnA0bVpCZ2d6VEZ0YVRob1N4WVlDaw0KazRnN09mNnlH
UXZPQjk4ZGNLTDBPWERwU2Z1S29oSkZTSjE0Tkl5OEVXMFh0V01YczQvN1hibDkybGpVMnMrag0K
Ty91TjlFcHIvVm1KY0M0ZFc3M1VrSUUyTEJLUVk2cGpPRDZ3d0JrV01NbkF3Y05mUC9yempsNnVw
cUY2ZDlneQ0KU01TYW1keFgvaFRxMnlLRnN4a2NoV0dUMWYzOXBsNDRSSFB6d080b2FpUXpDelUw
b0k2bllqenVzTWZZajhpeg0KTFRkbXVvMmQ4UUJqOWRaZXdxRXVSVkFNRnJjdzZLYXNBMlFuM05z
U3NGTnZPR0F4MFRvPQ0KPXVwSDkNCi0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQ0K

--b1_8zeict0kE8yCg0ChFWUkcf4Hel9dCyVf4xhoRkb9k--

