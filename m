Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0550E483CEF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 08:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbiADHci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 02:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbiADHcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 02:32:19 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69C2C061397;
        Mon,  3 Jan 2022 23:32:19 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id v13so31498230pfi.3;
        Mon, 03 Jan 2022 23:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fWQcTX75F7B2swlmevnXrf/NgC8qkWVQPz0k8OSXOnI=;
        b=HalwiQpguEc2tixitHtNgvMqG7qz2MY03H/8ocGVM9MoQ2hODb9PUj+MiwWnXLpplX
         y++HwX/xtLWshE0hj0Klv88nzKtbJqPWf7sooUaISB3UH4tMjav6S1XIvXMhjL0ZVYHB
         63byF9hNLWoDccNLe9Up34b1sdyKpYbI56TC+km2GTagM4ETyZHVkeU33iXeLmtMQYSN
         cUxOXSP9ECm0uvrl/0cquJxHECZDYUU/oZR+keSdFIa+8lbLufLk4D12HgoGmV0zJz9F
         /X2OehNkjgPZR5Xtt5ifnSq8SSHnuvrVOEiCI7Q/YuY5xQBpgiTJ21I+9jIo1yTiY1C5
         9zLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fWQcTX75F7B2swlmevnXrf/NgC8qkWVQPz0k8OSXOnI=;
        b=clI+cEGPBPma5Lo/UQeUFVrPT1gvagLucEwUapgR9bVOYghHOm7m8taYCq8PlPHcGG
         5GrihZHR1P9RjiA39BIw/FMqEk4jpC3ZxBcqCoXq9NriwVV82c4E20ofZhNVFOA3G3VA
         v+34GsLkVsGQejrFHOoBpJMyLDNKhaEGJfnivNUQC3hJ+uodS46lr/Jnq0IhX2GK1SHp
         2R3YB51Rwtx7aPNQhta8PwN1LmBaR9ldzecYW320+PyuhpHO2uHAH244l5pmb4MOhKsa
         7APugQH7gqymQQQ1IniW2OTCLPNEfwwpbt1CyYaQ7eiG9YApI/CjBpGQSNHzDLw6k1W7
         Kgcg==
X-Gm-Message-State: AOAM530Vaa38KZy4L+djlciPBnDMWM9+Kmv7VpArYv1z6jMksfglK1Ug
        VyNYpO+eezrJZLRYPKEVxJc=
X-Google-Smtp-Source: ABdhPJzGYmeqoCug02V/vXX1io8DMEdzmw/bTtBmLl/vyhRdABVIJi8MvirIX1hpCmFCUhAHJsQvmA==
X-Received: by 2002:a62:5a06:0:b0:4bc:186d:3798 with SMTP id o6-20020a625a06000000b004bc186d3798mr31808742pfb.49.1641281539215;
        Mon, 03 Jan 2022 23:32:19 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id t25sm25577741pgv.9.2022.01.03.23.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 23:32:18 -0800 (PST)
To:     hch@lst.de
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org
References: <20220104064708.GA15446@lst.de>
Subject: Re: make pdfdocs fails on Debian stable
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <8f21b702-abc2-c9aa-7593-9aff17e61ed1@gmail.com>
Date:   Tue, 4 Jan 2022 16:32:14 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220104064708.GA15446@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Tue, 4 Jan 2022 07:47:08 +0100, Christoph Hellwig wrote:
> On Mon, Jan 03, 2022 at 09:58:31PM +0100, Mauro Carvalho Chehab wrote:
>> Ah, the error is specific to RCU.tex then?
>=20
> Yes.
>=20
>>=20
>> You'll need to re-run xelatex with -interaction=3Dinteractive, in
>> order to be able to identify what's the root cause.
>>=20
>> You could do this by using LATEXOPTS, e. g.:
>>=20
>> 	$ make SPHINXDIRS=3DRCU LATEXOPTS=3D"-interaction=3Dinteractive" pdfd=
ocs
>>=20
>> With that, LaTeX will stop at the offending line from the .tex file.
>>=20
>> On a quick test here, I'm getting these at Fedora 35:
>>=20
>> 	(/usr/share/texlive/texmf-dist/tex/latex/l3packages/xtemplate/xtempla=
te.sty)
>>=20
>> 	! LaTeX Error: File `ctexhook.sty' not found.
>>=20
>> 	Type X to quit or <RETURN> to proceed,
>> 	or enter new name. (Default extension: sty)
>>=20
>> It seems that a recent change (probably to better address issues with =

>> Chinese and Japanese translation) added an extra dependency to some
>> stylesheet.
>>=20
>> I solved it by installing this package: "texlive-ctex".
>=20
> There is no texlive-ctex on Debian, but ctexhook.sty is installed as
> part of texlive-extra-utils.  Here are the last lines from the
> interactive run:
>=20
> (/usr/share/texlive/texmf-dist/tex/latex/ctex/ctexhook.sty)
> (/usr/share/texlive/texmf-dist/tex/xelatex/xecjk/xeCJK.cfg))
> (/usr/share/texlive/texmf-dist/tex/latex/etoolbox/etoolbox.sty)
> Writing index file RCU.idx
> (./RCU.aux)
> Runaway argument?
> {\contentsline {chapter}{\numberline {16}A Tour Through TREE\_RCU=E2=80=
=99s\ETC.
> ! File ended while scanning use of \@writefile.
> <inserted text>=20
>                 \par=20
> l.191 \begin{document}
>=20
> ?=20

I suspect you are suffering from corrupt RCU.aux (or whatever other
intermediate files xelatex generates).

What happens you run

    $ make cleandocs

before

    $ make SPHINXDIRS=3DRCU LATEXOPTS=3D"-interaction=3Dinteractive" pdfd=
ocs

?

        Thanks, Akira




