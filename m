Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684F650ABEC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 01:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442406AbiDUXXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 19:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236452AbiDUXX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:23:27 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E32F45AE8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 16:20:35 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g23so1389324edy.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 16:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mtzzvTX2FZWpYfASrGmIBlMmWHZXe5gxLBO6bskoUbk=;
        b=Ea3mKJ1ynIyGjGgcZPbYaa07HFzGBunGsG9Z3uPHY5830yNYhIsLBolYPgzx/8wlX8
         KdGabqf5lr9XvB7btXqspjrg5QmzRF7pipi1mdtJT120KvMfCaR5nes/dLJxJ7tpk32J
         HmPDFUndhT9e3YE5GuUirmLo+KhITjeMidDQbAMgDU2qWZyDdA4aeb5Af6YOUo6igbZa
         GmKzBmh8AaJNcYH7ZCnvSClGbp/HLVIFafPRPzwUv28VW37tqdSOB75FR1Giq5fo0m/k
         Bc2Q5blxsgQREXmHjkcntLIhEBZ1STWR1wFUJCIQrf0ICT/4JDKyr7YB0dzesW/2spk7
         sgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mtzzvTX2FZWpYfASrGmIBlMmWHZXe5gxLBO6bskoUbk=;
        b=k964E5FRPWVqwCaoyuzg4G+JUTSGP5COmFzXyDDgXz0s2/8OFONV03c9EyZ5f4aNxs
         gfGCt4u4mGq6bNMBieXksOnCTh0BnepnNmTea8sidrodYBOo4uUkmzG1cGmQAE//W7zb
         MHl3S7UipfWm/eTCdjIwBqaF4uYGeZpwn21+87HaZIF4Y5Am4XWoVpJy6uAypOM3OHaX
         WJg3faX80kP8Vgps6T9H390dZ/C9K6LW20bI0BNyv/EVbgbkMDzm19QllJZ9c3bOsuJ9
         22WNBmERRoZSTb4aGPyelsbFnee0R/bfYELD6dsnv7IA7GBXuETC1UOS5F17YCi5Fgiu
         g3eA==
X-Gm-Message-State: AOAM531JGr8sSrTvG6iksJxmPKMGtFvW44oM6aHy8BSk30PSHIfkkMT8
        eetChPOuNZzcUliBIGzMoNxnYnUtMWA=
X-Google-Smtp-Source: ABdhPJyLJraznTTMFich4fGcVX7wFl4eLg7/n7BVsXkq1eMOcWRT/q8zG5C/ZU0FtXAbiQ5bnfxhvA==
X-Received: by 2002:a50:8d09:0:b0:41c:b898:19a6 with SMTP id s9-20020a508d09000000b0041cb89819a6mr2041330eds.30.1650583233620;
        Thu, 21 Apr 2022 16:20:33 -0700 (PDT)
Received: from leap.localnet (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id br14-20020a170906d14e00b006e88db05620sm141227ejb.146.2022.04.21.16.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 16:20:31 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jaehee Park <jhpark1013@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
        jhpark1013@gmail.com
Subject: Re: [PATCH v4 1/7] staging: r8188eu: remove unnecessary braces in single statement block
Date:   Fri, 22 Apr 2022 01:20:29 +0200
Message-ID: <3485895.R56niFO833@leap>
In-Reply-To: <16185752.0ZKypZ73Fx@leap>
References: <cover.1650568579.git.jhpark1013@gmail.com> <b96ae957e2ddc519e56813a1c56e770168f67a2d.1650568579.git.jhpark1013@gmail.com> <16185752.0ZKypZ73Fx@leap>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On gioved=C3=AC 21 aprile 2022 21:52:14 CEST Fabio M. De Francesco wrote:
> On gioved=C3=AC 21 aprile 2022 21:20:26 CEST Jaehee Park wrote:
> > Remove braces for single statement block to minimize the number of
> > empty lines, without loss of readability. Issue found with checkpatch.
> > WARNING: braces {} are not necessary for single statement blocks
> >=20
> > Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
> > ---
> >  drivers/staging/r8188eu/core/rtw_mlme.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/
> r8188eu/core/rtw_mlme.c
> > index 3e9882f89f76..d3f4d7cdfa08 100644
> > --- a/drivers/staging/r8188eu/core/rtw_mlme.c
> > +++ b/drivers/staging/r8188eu/core/rtw_mlme.c
> > @@ -112,9 +112,8 @@ void _rtw_free_mlme_priv(struct mlme_priv=20
*pmlmepriv)
> > =20
> >  	rtw_free_mlme_priv_ie_data(pmlmepriv);
> > =20
> > -	if (pmlmepriv) {
> > +	if (pmlmepriv)
> >  		vfree(pmlmepriv->free_bss_buf);
> > -	}
> > =20
> >  }
> > =20
> > --=20
> > 2.25.1
> >=20
>=20
> Hi Jaehee,
>=20
> If you just want to remove the braces, your patch is good.
>=20
> But... Did you ask yourself why this code needs to test if "pmlmepriv" is=
=20
> valid before calling vfree() on it? Actually, the code doesn't need this=
=20
> test, it just needs to call "vfree(pmlmepriv)" unconditionally.

When copy-pasting I overlooked a couple of things... However the argument=20
is the same: the code doesn't need that 'if' statement before vfree().

I wanted to write "[] it just needs to call "vfree(pmlmepriv-
>free_bss_buf)" unconditionally".

I apologize for not reading twice before sending my email too soon after=20
writing and moving sentences around.

> OK, I know that this is not directly related to your patch or any other=20
> that is explicitly made just for removing unnecessary braces...=20

"pmlmepriv" is valid because we know it from the previous call to=20
rtw_free_mlme_priv_ie_data(). Therefore the code can dereference=20
"pmlmepriv".

=46urthermore, even if "free_bss_buf" were NULL it wouldn't matter because=
=20
"vfree(pmlmepriv->free_bss_buf)" would be a no-op.

Sorry if this inaccurate wording might have confused you about what I was=20
trying to say.

Thanks,

=46abio=20


