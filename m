Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C48F4FED43
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 05:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbiDMDD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 23:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiDMDDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 23:03:53 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC9F2656C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 20:01:33 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id o2so1091881lfu.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 20:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9B5Bgd6y+D2b5bf/PHddV0cYSTfDz/gFBZ7J53x9Nsk=;
        b=WaEkr27rG3OburA2d8oeVHK+sc+92BI3Fi8YwcbmOJarjbuxfDpU5zcriwVKazSCMV
         jJAHJtwJvXbuSuTpY53KBCWbJzVtbOqrriaveJQvxC9YvU1ps6PNDRte1i8VvEn2um+F
         d+trcmOQr6u6qU/DaDttRbpQdntee43gnU1afWpkBm9JEfLYhr2pxjyDdaOpwWcK19mW
         7sqo/QYK+juQCRRqXa/Ewl+PlSZJu94q7i55c1uf7DXLc8mdeYNkSXs0pQ/PBmqX2jPh
         VOEg9oBGqi1ZIHOYtGZnNn+PZ0bXxgClI44hK3qa9Lh8duUZM6WU5OQpO5b13WeF6PPC
         3ROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9B5Bgd6y+D2b5bf/PHddV0cYSTfDz/gFBZ7J53x9Nsk=;
        b=i+9MwxcLGV2lgTh1Ft/GS88pDFa7pK+8JzVuuB3BEh0b2txmykNoxeChWVRresarcW
         PHjcSWCYluO7J/NNDYb8iBrh8Z6aKAmENdzQN3NgE+xqokR/DiqBrhkyAMM3xCtbc8hw
         6EII846tqjThlAEvObdf2Lo0FKoF4wP4do8u9h2R4Nu/okbqSEJKKnWeNX+I96GW7z3P
         A1h9qC4Pv4wJLLIO88p0yLVf1Mva9TPHvmhxJEuH3SZIzOa1B7uRBTn1lIh6ueb+oXdJ
         1Jxep3AA/7feMzIx8nJ6QuXrtbVLYmJ5B2D1s3oV3V6+5xm+QGy17PmOX51xd7HD7klw
         6VIw==
X-Gm-Message-State: AOAM530UA9vGh31vf9wXayern7kX82oy6tcKC1J6Uhm2vUFoHr2LxTFh
        DmibQJWRh4OOMaCl4dSGR7HhVxSkHui150TVDjM=
X-Google-Smtp-Source: ABdhPJxOEF8VtmULdkpXg0dHuKyT/hBLh6OzeysI154DZ2PZKJFsgIPyxdD2/h7K01/pce23CdfNtapUk14Pk4Snq5c=
X-Received: by 2002:a05:6512:12d6:b0:44a:4a14:a19a with SMTP id
 p22-20020a05651212d600b0044a4a14a19amr27792636lfg.619.1649818891444; Tue, 12
 Apr 2022 20:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220403224207.GA397480@euclid> <YlYPuIMr8mq66Lea@iweiny-desk3> <CAMWRUK6FaOC1+3ZP+af7uSyfAHjZ3KWwNqM1GjRYth+OyA-8EQ@mail.gmail.com>
In-Reply-To: <CAMWRUK6FaOC1+3ZP+af7uSyfAHjZ3KWwNqM1GjRYth+OyA-8EQ@mail.gmail.com>
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Date:   Tue, 12 Apr 2022 23:01:20 -0400
Message-ID: <CAMWRUK4785GQt2UYVbXmEkUVuf0j+mv8977hYe=XT22FnecpSA@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8723bs: simplify control flow
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy linux kernel <outreachy@lists.linux.dev>
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

[Resending again in plain-text mode.]


On Tue, Apr 12, 2022 at 10:59 PM Sevinj Aghayeva
<sevinj.aghayeva@gmail.com> wrote:
>
>
>
> On Tue, Apr 12, 2022 at 7:48 PM Ira Weiny <ira.weiny@intel.com> wrote:
>>
>> On Sun, Apr 03, 2022 at 06:42:07PM -0400, Sevinj Aghayeva wrote:
>> > Checkpatch issues "WARNING: else is not generally useful after a break
>> > or return" for the following code:
>> >
>> > while (1) {
>> >       do_join_r =3D rtw_do_join(padapter);
>> >       if (do_join_r =3D=3D _SUCCESS) {
>> >               break;
>> >       } else {
>> >               rtw_dec_to_roam(padapter);
>> >
>> >               if (rtw_to_roam(padapter) > 0) {
>> >                       continue;
>> >               } else {
>> >                       rtw_indicate_disconnect(padapter);
>> >                       break;
>> >               }
>> >       }
>> > }
>> >
>> > We simplify this code in multiple steps. First, we remove do_join_r
>>
>> I can't say how Greg would like to see a change like this but my gut say=
s that
>> each of these steps should be a patch in a series...
>>
>> > variable because it is only used right after it is assigned. Second,
>> > we remove the unnecessary else statement right after break:
>> >
>> > while (1) {
>> >       if (rtw_do_join(padapter) =3D=3D _SUCCESS)
>> >               break;
>> >       rtw_dec_to_roam(padapter);
>> >
>> >       if (rtw_to_roam(padapter) > 0) {
>> >               continue;
>> >       } else {
>> >               rtw_indicate_disconnect(padapter);
>> >               break;
>> >       }
>> > }
>> >
>> > Next, we move the call to rtw_do_join into the while test because the
>> > while will loop only until the call is successful:
>> >
>> > while (rtw_do_join(padapter) !=3D _SUCCESS) {
>> >       rtw_dec_to_roam(padapter);
>> >       if (rtw_to_roam(padapter) > 0) {
>> >               continue;
>> >       } else {
>> >               rtw_indicate_disconnect(padapter);
>> >               break;
>> >       }
>> > }
>> >
>> > Finally, looking at the code above, it is clear that the code will
>> > break out of the loop if rtw_to_roam call is <=3D 0. Hence:
>> >
>> > while (rtw_do_join(padapter) !=3D _SUCCESS) {
>> >       rtw_dec_to_roam(padapter);
>> >       if (rtw_to_roam(padapter) <=3D 0) {
>> >               rtw_indicate_disconnect(padapter);
>> >               break;
>> >       }
>> > }
>>
>> ...  that said, this commit message made reviewing the change much easie=
r,
>> thanks.
>
>
> This has landed a week ago, but thanks for the review anyway!
>
>>
>> Did you submit a patch for the r8188eu driver too?  I just noticed it ha=
s a
>> similar loop in _rtw_roaming().
>
>
> Right, there is also another similar loop in the same file as well. I thi=
nk I wasn't sure that this patch was going to get accepted since it was a b=
ig change, so I didn't fix the others before this one got it. In the meanti=
me I hit slightly more than 10 cleanup patches and moved on to working with=
 my mentors. But I can fix the other loops if you think I should do it.
>
>>
>> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>>
>> >
>> > Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
>> > ---
>> >  drivers/staging/rtl8723bs/core/rtw_mlme.c | 18 ++++--------------
>> >  1 file changed, 4 insertions(+), 14 deletions(-)
>> >
>> > diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/stagi=
ng/rtl8723bs/core/rtw_mlme.c
>> > index 3eacf8f9d236..a45df775d535 100644
>> > --- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
>> > +++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
>> > @@ -2594,30 +2594,20 @@ void _rtw_roaming(struct adapter *padapter, st=
ruct wlan_network *tgt_network)
>> >  {
>> >       struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>> >       struct wlan_network *cur_network =3D &pmlmepriv->cur_network;
>> > -     int do_join_r;
>> >
>> >       if (rtw_to_roam(padapter) > 0) {
>> >               memcpy(&pmlmepriv->assoc_ssid, &cur_network->network.ssi=
d, sizeof(struct ndis_802_11_ssid));
>> >
>> >               pmlmepriv->assoc_by_bssid =3D false;
>> >
>> > -             while (1) {
>> > -                     do_join_r =3D rtw_do_join(padapter);
>> > -                     if (do_join_r =3D=3D _SUCCESS) {
>> > +             while (rtw_do_join(padapter) !=3D _SUCCESS) {
>> > +                     rtw_dec_to_roam(padapter);
>> > +                     if (rtw_to_roam(padapter) <=3D 0) {
>> > +                             rtw_indicate_disconnect(padapter);
>> >                               break;
>> > -                     } else {
>> > -                             rtw_dec_to_roam(padapter);
>> > -
>> > -                             if (rtw_to_roam(padapter) > 0) {
>> > -                                     continue;
>> > -                             } else {
>> > -                                     rtw_indicate_disconnect(padapter=
);
>> > -                                     break;
>> > -                             }
>> >                       }
>> >               }
>> >       }
>> > -
>> >  }
>> >
>> >  signed int rtw_linked_check(struct adapter *padapter)
>> > --
>> > 2.25.1
>> >
>
>
>
> --
>
> Sevinj.Aghayeva



--=20

Sevinj.Aghayeva
