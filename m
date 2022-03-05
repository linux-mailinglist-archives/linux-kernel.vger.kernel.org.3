Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3250B4CE5D8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 17:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbiCEQMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 11:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiCEQMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 11:12:12 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C531A8CB3;
        Sat,  5 Mar 2022 08:11:21 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2d07ae0b1c0so122037097b3.2;
        Sat, 05 Mar 2022 08:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tmdN0Wx0WiOtxWo9RPNayDEHKMGDKTOmsWU1SSOA3c0=;
        b=nczZcheOu2LkbRSYD2oRcotZ8BmDYFYsJTPEifCtDh8WWg/h52Vne6Q1Lz7mvEsbbX
         muBkseMobZcWe0RAZmYiT4EaZVVLK1nSdTlf4bJJaYtVxluHSesRU7pO/tcgb8e2XVyp
         jR/0BVCeMT7IscAKKmhyvad49Lz6/4rMSSPvx4Taj1YK5yDP8LVCfQ+R70oeyb6Pz7Ww
         Jd2MVuE7SmMVQmPhPi82y0YgPgPHgs7YDbowIWg59VeztZjnCgQydJT7qbGMHvAU/UJo
         svq3OLYrq7fSC15V6MYXHcGTGnbg8h71jxa+YUyghHD0aDtyMHgYptYmmKLWjnXE4YXB
         V58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tmdN0Wx0WiOtxWo9RPNayDEHKMGDKTOmsWU1SSOA3c0=;
        b=a98ITzh13+V+mOlpUi1hgnKqng9qmD9z/Oc9pUhb3J5NZfaqpVAkRGR4l7Vnv9H+ni
         /vdrRnCXHvhn7GnHJ+jyIwdFpgAk13y3Sr1kGfmPDtLNDayFehAk93SWEQqVwoz4Vwje
         pn/bw8dMVE0TcwaNWGNchL28Cvf2HthET57w3n0RddNBhRiHrKHB+N9dQRk3ILUevC6k
         kN3WFJe0afDzNgkIo9lWSaKBPfYGpx2b2GE8pqFQi3NfrTgTwfehRBsSQFRq/b8NDdVf
         HIoZ6xP56RL0iErJT4B59UdNbhfE7Xtuz+hdjhFKU4k/+P5wFPbW6GkSG4QcSKGe71eh
         UYfw==
X-Gm-Message-State: AOAM530Tn5/DCOCnpjFEirLPxTo1/xG4KrABH33GFlpGj3cekW1zalRQ
        vOjofzsDqpLClnY5Wp0dSJSlof2NtksrAawIYgI=
X-Google-Smtp-Source: ABdhPJxshUS9MZ0MKEraBYqWoPu8CWBX0qYTF+zKsIFYHOhy86O3rZz29WlhfkwL43x8Y4I9xsruSG9n6haA8qAMHto=
X-Received: by 2002:a0d:e80d:0:b0:2dc:8c0:df1f with SMTP id
 r13-20020a0de80d000000b002dc08c0df1fmr2841042ywe.52.1646496680890; Sat, 05
 Mar 2022 08:11:20 -0800 (PST)
MIME-Version: 1.0
References: <20220304100145.6356-1-wanjiabing@vivo.com>
In-Reply-To: <20220304100145.6356-1-wanjiabing@vivo.com>
From:   yanteng si <siyanteng01@gmail.com>
Date:   Sun, 6 Mar 2022 00:11:07 +0800
Message-ID: <CAEensMykqQfrj2rnTh19KWt87XHazSPqn3XuBsw_JWVvb_c7Tg@mail.gmail.com>
Subject: Re: [PATCH] docs/zh_CN: fix a reference file name in free_page_reporting.rst
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, kael_w@qq.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wan Jiabing <wanjiabing@vivo.com> =E4=BA=8E2022=E5=B9=B43=E6=9C=884=E6=97=
=A5=E5=91=A8=E4=BA=94 18:02=E5=86=99=E9=81=93=EF=BC=9A
>
> Fix the following 'make refcheckdocs' warning:
> Warning: Documentation/translations/zh_CN/vm/free_page_reporting.rst
> references a file that doesn't exist: Documentation/vm/_free_page_reporti=
ng.rst
>
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
Acked-by:  Yanteng Si <siyanteng@loongson.cn>
> ---
>  Documentation/translations/zh_CN/vm/free_page_reporting.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/translations/zh_CN/vm/free_page_reporting.rst =
b/Documentation/translations/zh_CN/vm/free_page_reporting.rst
> index 31d6c34b956b..14336a3aa5f4 100644
> --- a/Documentation/translations/zh_CN/vm/free_page_reporting.rst
> +++ b/Documentation/translations/zh_CN/vm/free_page_reporting.rst
> @@ -1,6 +1,6 @@
>  .. include:: ../disclaimer-zh_CN.rst
>
> -:Original: Documentation/vm/_free_page_reporting.rst
> +:Original: Documentation/vm/free_page_reporting.rst
>
>  :=E7=BF=BB=E8=AF=91:
>
> --
> 2.35.1
>
