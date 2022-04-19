Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAED1506B78
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 13:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351962AbiDSLzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 07:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348783AbiDSLz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 07:55:26 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A1335DD1;
        Tue, 19 Apr 2022 04:52:44 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id i24-20020a17090adc1800b001cd5529465aso1611692pjv.0;
        Tue, 19 Apr 2022 04:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hgKJN+BTkPcTumaPzYlJnDgFDvKESErgzJKeOXPJ+6w=;
        b=a41/SubBxXOfJRynBjORLy07hhYi1HOaXYsOs8EU07MB9hCGsKMf1tortD0p+6Nrvi
         3U80B9rihzHVFgPLDcn7+XH4dpi7XlldtoAEmWFeLJ+uZnVlU0WatIr1tNySfbfD1gKh
         C/wetlmmpqOv2Ev3aEGE19uRwSTlwxAh36qW6m14mpaLODWTp5+XFhGX5tJCGkcDZIuE
         VsfQ9cLrSj/rXKmStmXI+Yirhk8ijjhOsBuF4LcEjCYkPZPuBv9BFtDwV4L3Enq54l+k
         8kx2D7R5ReAZG38kJ6sSm9NhN9W1Nto8z72IrBz3YX868Pr3FAZzDFW01mNHKgjzju6e
         +3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hgKJN+BTkPcTumaPzYlJnDgFDvKESErgzJKeOXPJ+6w=;
        b=lzyPhjJSZeIYeDhLrP4aUniVc9/QhsgV1W8soFA0Qi3ZBwTyMD9YVwvmW80wY91gvJ
         Ld/rYMuG8DUsSBwija/ocbhvw3pRzEDkUfAxSFd3j/1eEF4vH0BUrlwfhtpha20pjSj8
         wIOvjtSpvdi259dTK507xBBoQtYr1VfE9j5J16anRiYpK4NMHPWwU6phiTslWrL+Nxp/
         WxlQC5h/F3i/QIf9tGirN7ekmpwTxV+++nEDiEmzLHO/h/wOy/Y5a1Ocd25swPLSLyNZ
         S4YKwsM7OeAjcd9atvCfLD2F3YByfjF+P0VGVI08ODiCpZrsa3uiGX5ZiDHSVaEsatbR
         s+BQ==
X-Gm-Message-State: AOAM5303dBi2WUX/ur5LRL1/1HPAVsbFxXCWv0jFrTenD7CeXeODTdSv
        sFFiu/96Ept8s9Lv7VwymIM=
X-Google-Smtp-Source: ABdhPJy2TK4FrHgnxqX4lVJgi/IlH3G3b/8bdbG8EatbMpfeNcqOdDYwPNJ2WTeSg1cfyyPb/UNSWg==
X-Received: by 2002:a17:90b:4c48:b0:1d2:1493:eef4 with SMTP id np8-20020a17090b4c4800b001d21493eef4mr17509704pjb.24.1650369163585;
        Tue, 19 Apr 2022 04:52:43 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id m17-20020a17090a859100b001bc20ddcc67sm19425892pjn.34.2022.04.19.04.52.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 04:52:43 -0700 (PDT)
Message-ID: <5a9c77ab-8627-b8e2-67bc-e7bd260654de@gmail.com>
Date:   Tue, 19 Apr 2022 20:52:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] docs/ja_JP/index: update section title in Japanese
Content-Language: en-US
To:     Kosuke Fujimoto <fujimotokosuke0@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Tsugikazu Shibata <shibata@linuxfoundation.org>
References: <20220419081813.6838-1-fujimotokosuke0@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20220419081813.6838-1-fujimotokosuke0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Cc: Shibata-san, who originally picked the English title]

Hi,

On Tue, 19 Apr 2022 17:18:13 +0900,
Kosuke Fujimoto wrote:
> Update section title "Japanese Translation" in Japanese instead of Engl=
ish

Please explain _why_ do you think Japanese title is better.

I think you want it to be consistent with other translations.

>=20
> Signed-off-by: Kosuke Fujimoto <fujimotokosuke0@gmail.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Akira Yokosawa <akiyks@gmail.com>
> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/translations/ja_JP/index.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/translations/ja_JP/index.rst b/Documentation=
/translations/ja_JP/index.rst
> index 20738c931d02..558a1f5642b0 100644
> --- a/Documentation/translations/ja_JP/index.rst
> +++ b/Documentation/translations/ja_JP/index.rst
> @@ -5,7 +5,7 @@
>  	\kerneldocCJKon
>  	\kerneldocBeginJP{
> =20
> -Japanese translations
> +=E6=97=A5=E6=9C=AC=E8=AA=9E=E7=BF=BB=E8=A8=B3

"=E6=97=A5=E6=9C=AC=E8=AA=9E=E7=BF=BB=E8=A8=B3" sounds a little bit redun=
dant to me.  I'd say "=E6=97=A5=E6=9C=AC=E8=AA=9E=E8=A8=B3".
What do you think?

        Thanks, Akira

>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D> =20
>  .. toctree::
