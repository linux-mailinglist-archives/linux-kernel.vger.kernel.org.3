Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A48250A98C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392104AbiDUTzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241640AbiDUTzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:55:08 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C994C7B5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:52:18 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v12so1311888wrv.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BQ5dyd6fs/bmeT8pS5RVio7sbjG930KgOScg6ZzdPYo=;
        b=BbVajbWzTI9iuTT8JJXqugzc+jYRncQ2CahBLrh1s0jY529GXxKHFiDclAFH4xjuv1
         5fMoB1rGe4LhMTtHVm01nDiM4LVubcEJKNUij/1P+Cm8oSIDB92SAJac8BryUCWv1ZCh
         9DoIuvyNbSaxE42uLvVyUpAoEv6ufGe+ijlGiYKknamH0//ETKR9nVWmyP7N0dR/qNoY
         ESciveBBXx8JIKKr7vEQQ7mu88IpvCZ8vz/HJUP7U2gv2bAELU1ql3thEQd7Dy2Vj7VW
         XGaJDBWbWWWIpEGbzKleZ9vB+oWrwQacCQefiqtwztcPjK96SD+WkDSQq7OY1gvu4ISl
         GOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BQ5dyd6fs/bmeT8pS5RVio7sbjG930KgOScg6ZzdPYo=;
        b=sS67Ns/IdQy+J4DFqsKbMtyq2I5OQr/IRqOlvFbibpk6NzTqh9zfOzzuh8weeoLPue
         ThGiqZzgWf471ZVShLE0yKJurWpA+Vwkr6mNCltOhQeH7zS+L1FqhwjGrbJxb8yqJ+9Y
         htlT1mGBwa5pJ98dVBnOZTECA2hOYmmaZwg9sjbwlmxwvWEO9i5WfPwwWx1biKLA7zPv
         dyXd9DHGVkXZZ07+lNLVVQ8V1gCo1dhIMBJsqmlE/Od3NqunLEIJoedDJr0yo3BLaIFj
         O1YsVY3/NsEza846zVL4BQCZHP5tyT9zd66+cayQZK4jk5oqX1CJ3xiPcGSUJtIpJyrc
         OXUg==
X-Gm-Message-State: AOAM531Ej6Q637Bgk7m5psce1TdadrTVeKtkBuT6a4EtEH7t/SmG8kzv
        oUZ53XSMb2thTrRYnntprhRvX8DcFLA=
X-Google-Smtp-Source: ABdhPJzN6SNNtwOoCtQDCY9KQ49Aeegx8MoX9dTJFyJTMUvteQbKMvaqYB6aDL49STrkEKq4lk9FAA==
X-Received: by 2002:a05:6000:111:b0:207:ac77:3d07 with SMTP id o17-20020a056000011100b00207ac773d07mr977069wrx.136.1650570736840;
        Thu, 21 Apr 2022 12:52:16 -0700 (PDT)
Received: from leap.localnet (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id z3-20020a1cf403000000b0037d1f4a2201sm2776214wma.21.2022.04.21.12.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 12:52:15 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry.Finger@lwfinger.net, Jaehee Park <jhpark1013@gmail.com>
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, jhpark1013@gmail.com
Subject: Re: [PATCH v4 1/7] staging: r8188eu: remove unnecessary braces in single statement block
Date:   Thu, 21 Apr 2022 21:52:14 +0200
Message-ID: <16185752.0ZKypZ73Fx@leap>
In-Reply-To: <b96ae957e2ddc519e56813a1c56e770168f67a2d.1650568579.git.jhpark1013@gmail.com>
References: <cover.1650568579.git.jhpark1013@gmail.com> <b96ae957e2ddc519e56813a1c56e770168f67a2d.1650568579.git.jhpark1013@gmail.com>
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

On gioved=C3=AC 21 aprile 2022 21:20:26 CEST Jaehee Park wrote:
> Remove braces for single statement block to minimize the number of
> empty lines, without loss of readability. Issue found with checkpatch.
> WARNING: braces {} are not necessary for single statement blocks
>=20
> Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_mlme.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/
r8188eu/core/rtw_mlme.c
> index 3e9882f89f76..d3f4d7cdfa08 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme.c
> @@ -112,9 +112,8 @@ void _rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
> =20
>  	rtw_free_mlme_priv_ie_data(pmlmepriv);
> =20
> -	if (pmlmepriv) {
> +	if (pmlmepriv)
>  		vfree(pmlmepriv->free_bss_buf);
> -	}
> =20
>  }
> =20
> --=20
> 2.25.1
>=20

Hi Jaehee,

If you just want to remove the braces, your patch is good.

But... Did you ask yourself why this code needs to test if "pmlmepriv" is=20
valid before calling vfree() on it? Actually, the code doesn't need this=20
test, it just needs to call "vfree(pmlmepriv)" unconditionally.

OK, I know that this is not directly related to your patch or any other=20
that is explicitly made just for removing unnecessary braces...=20

vfree() behaves as a no-op function on NULL pointers, therefore there is no=
=20
need to test whether or not "pmlmepriv" is valid.

Thanks,

=46abio M. De Francesco



