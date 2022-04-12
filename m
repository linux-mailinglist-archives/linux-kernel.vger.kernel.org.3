Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5075B4FE98C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 22:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiDLUnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 16:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiDLUmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 16:42:42 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BA3FC109
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 13:37:43 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id k23so39604269ejd.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 13:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EkBcRQ3FSxoHr2CTVma7OTMsNkj+chjdnuq3vagcoSg=;
        b=pAItBEs6qc+VnWOS8cvFja8MzCU+mPUp2b9wDr39p3iDEc+KTKl5xGVfR3H9pg5bNZ
         +v2pc16/PHlSc8lLe/W8GA1rWIWqd/AqMVO5HSAZpF93YGFPyqBhaVLUnwS/jB413+YL
         8LKSuXW3X2Ibg1NraGS7CqfKnjkdYj6b+8LGGM3SUbzhYYwPZWprCyIjr0jSjs7XHYT7
         hayWKuEkvO4jbS8PNSD1suSqFZ3peirX+udmGWIrxEvcUdnRDAhOdsxb6ouNwFNTEsxd
         Ic7uOOYSe7EVY7gKpAeWEVUdXQNsQavSpHfXfa+0U/oxR+8t2WpJvhclX0TV7Ai8AobW
         32wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EkBcRQ3FSxoHr2CTVma7OTMsNkj+chjdnuq3vagcoSg=;
        b=OpoPEQ5qjz3rNQJKYYq5J9B6ZgJY2TCixJdV7/e80dHR+9VWTZXTtAm9UhYTZ5ufCj
         /nQFQHSFQzz5csb5Q/HigMj8lUj92XDIXXrgFZ3LRfVEmM3wGOAoAmmdfwUpFY7V8E+J
         zsyyMc0uK5b4yTNxTznSaFEF5y4QAMY+ZG+EmR+lxv6789XYihD9+P4yul5YGmFZ7m5S
         YiXfKajeycLhYI28pniJc2Ws7bWVQIAYRZJew30pk0XHlOKJPtOsmwTlqU4DRON01BB6
         Rq8ya63D/yGvADZVk6n/9qWtSQtEIs3X277kRSs1UJqlZfgSR9NWcC+Bo2N5QavGvr4k
         PJcg==
X-Gm-Message-State: AOAM532UEIevWW+TLhzJ3hCztS/Kdd7qYqKUeE4V38JBZnSwFbEZD1Rl
        lLX4In1ek5D6qWSJMxbizy4=
X-Google-Smtp-Source: ABdhPJywyDgdZmOauAKekxXMp8ylMAfdHu/iyTZe6vmSobj3jlxlUAeuk3DQoNJqjXUW37Rr5Oqv6g==
X-Received: by 2002:a17:907:3d87:b0:6e6:f1f3:ba7c with SMTP id he7-20020a1709073d8700b006e6f1f3ba7cmr36244569ejc.128.1649795761348;
        Tue, 12 Apr 2022 13:36:01 -0700 (PDT)
Received: from leap.localnet (host-82-60-208-254.retail.telecomitalia.it. [82.60.208.254])
        by smtp.gmail.com with ESMTPSA id y13-20020a50eb8d000000b0041f112a63c4sm32207edr.52.2022.04.12.13.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 13:36:00 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     johan@kernel.org, Jaehee Park <jhpark1013@gmail.com>
Cc:     elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
        jhpark1013@gmail.com
Subject: Re: [PATCH v2 2/2] staging: greybus: remove unneeded return
Date:   Tue, 12 Apr 2022 22:35:58 +0200
Message-ID: <5792471.alqRGMn8q6@leap>
In-Reply-To: <d4d01ecdabc492e52a3decebf165d1f584f3b3bf.1649793138.git.jhpark1013@gmail.com>
References: <cover.1649793138.git.jhpark1013@gmail.com> <d4d01ecdabc492e52a3decebf165d1f584f3b3bf.1649793138.git.jhpark1013@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On marted=EC 12 aprile 2022 21:59:15 CEST Jaehee Park wrote:
> An empty function with void return type does not need an explicit
> return. Issue found by checkpatch.
>=20
> Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
> ---
>  drivers/staging/greybus/audio_codec.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/
greybus/audio_codec.c
> index 0f50d1e51e2c..3e3a16568def 100644
> --- a/drivers/staging/greybus/audio_codec.c
> +++ b/drivers/staging/greybus/audio_codec.c
> @@ -1032,7 +1032,6 @@ static int gbcodec_probe(struct snd_soc_component=20
*comp)
>  static void gbcodec_remove(struct snd_soc_component *comp)
>  {
>  	/* Empty function for now */
> -	return;
>  }
> =20
>  static int gbcodec_write(struct snd_soc_component *comp, unsigned int=20
reg,
> --=20
> 2.25.1
>=20
Hi Jaehee,

If I recall it correctly, Dan Carpenter suggested to remove this empty=20
function.=20

When developers remove lines of code from a function which becomes empty
after the removals, they also remove the resulting empty function and
delete all the calls (if there are any left) at the same time.

Thanks,

=46abio M. De Francesco=20



