Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1FF4E1C75
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 17:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245432AbiCTQDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 12:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbiCTQDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 12:03:50 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CF7DFD4D;
        Sun, 20 Mar 2022 09:02:23 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id s11so13530642pfu.13;
        Sun, 20 Mar 2022 09:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QCU5ZRJFEefm79t6wz74guLnhRy4d8d28xqeCwvjgpA=;
        b=b1n9rXEfDS3N3+gqPGWVrgTkeHAxWddAAuyFhcy+HlcGjrQImWjQwIFCSNbmfbzcsQ
         sd2ZlZidh76qlcWGhYURbl3Fqn1Hq4fZTUoBvqe7dQgS0DspFQx8+Tzad6rBgQOMXJob
         f8mwSJpvtfCs/ErhF7Tgim1pA2OQDCqHVZ4XJu2PPKWZK6F5/frMuFzRR1vZrFNGcbdM
         LrbiPBEgb50kduyfKregYjkQrhD1RT5QcXjllb9KJjQtVqRwS1DHh7d8rmHnef3toVUJ
         A+leQ+tuEQYwQG7zub4hSj7gbiMa7qnwMRUin2kAduVZPXxRH2lwF8+aWNSrEdK0c2kq
         btcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QCU5ZRJFEefm79t6wz74guLnhRy4d8d28xqeCwvjgpA=;
        b=vW2zOvIHC3foIKKgZNmZdKf3CPiIgJX464Xt5jio32B6NNbHSUsmbgh78ISpdhD8+i
         4H92dUcHb8P8y8JN0bG++y/17FIZl4TkfjGytT5qR6sR/BIlqEZpIhIzlofVZBjgupb4
         9cs7RVhTPKRKkjXZVIrmw3ZjYiVBqFQwxCNbHs0WJ1cM1mcfIVdggVDAerIEiE1i/Aqv
         7qwGGODNN+WWpSiBEnfhzLZ2zRybo3YzYFuJwRGXoRu6SWIcWVA7wB1hqCfwIz9DtkUO
         LKwEAP/WziIfWgJF+y4yFZRatjub56MZQN5zIO/Eo7hbGEX72YULw6Dxm8KaGoSyQkEw
         AHqQ==
X-Gm-Message-State: AOAM5323fgJXlFKx5v93UBM92aQAfeWEMUfvpMBSeftDJUoGdyGgCJnp
        mcZraYJI2hPL2ZkK6pf5ur5Rc2AQXmc=
X-Google-Smtp-Source: ABdhPJw+2azPs9BP92uUGoQnTQUMJt2uTU3STcYdDEdNxECbTS7dpumJymDZTfTKPoW+Ol+Ku6KeSA==
X-Received: by 2002:a65:6a13:0:b0:373:14f6:5d33 with SMTP id m19-20020a656a13000000b0037314f65d33mr15585243pgu.62.1647792142932;
        Sun, 20 Mar 2022 09:02:22 -0700 (PDT)
Received: from localhost.localdomain ([1.145.30.29])
        by smtp.gmail.com with ESMTPSA id t18-20020a639552000000b00381f263db66sm11587566pgn.89.2022.03.20.09.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 09:02:22 -0700 (PDT)
Date:   Mon, 21 Mar 2022 03:02:18 +1100
From:   "G. Branden Robinson" <g.branden.robinson@gmail.com>
To:     linux-man@vger.kernel.org
Cc:     nick black <dankamongmen@gmail.com>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [patch] console_codes.4: ffix
Message-ID: <20220320160217.gws42lklp6ishzub@localhost.localdomain>
References: <YeEc2pYvKEckcAmv@schwarzgerat.orthanc>
 <CAN4uE+p-uKzHNYry2YhCMfEFBQ2jUqpDAGx=+eha01w-L4fAjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jwugz2kmfx3fzi7r"
Content-Disposition: inline
In-Reply-To: <CAN4uE+p-uKzHNYry2YhCMfEFBQ2jUqpDAGx=+eha01w-L4fAjg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jwugz2kmfx3fzi7r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nick,

Alex has been waiting on me for a review of this patch.  I took longer
than I should have because I thought he was expecting a technical
evaluation of the accuracy of the sequences documented.[1]  Now I see it
was just a matter of man(7) and tbl(1) syntactical and style review.

Easy bits first.

> Remove CSI prefix from the list of non-CSI escapes.

+1

> End all items of said list with periods, matching other sections of
> the page.

+1

> Fix up the busted OSC command list (reset palette and set palette).

>  ESC ]  OSC     T{
> -(Should be: Operating system command)
> -ESC ] P \fInrrggbb\fP: set palette, with parameter
> -given in 7 hexadecimal digits after the final P :-(.
> -Here \fIn\fP is the color (0\(en15), and \fIrrggbb\fP indicates
> +Operating System Command prefix.
> +T}
> +ESC ] R                Reset palette.
> +ESC ] P                T{
> +Set palette, with parameter given in 7 hexadecimal digits \fInrrggbb\fP =
after
> +the final P. Here \fIn\fP is the color (0\(en15), and \fIrrggbb\fP indic=
ates
>  the red/green/blue values (0\(en255).
> -ESC ] R: reset palette
>  T}

Yes, this was majorly hosed up, syntactically.  What you have is good
repair to obvious damage.  +1.

I have some suggestions for further improvement, but please don't gate
the patch application on these.

1. "Operating System Command prefix." does not need to be in a text
block.  It can be set as an ordinary table entry just like "Reset
palette."

2. The description of ESC ] P _is_ in a text block.  That's good,
because guess what?  Since it is _text_, you don't need those pesky font
selection escape sequences.  You can use man(7) font macros instead.
You can furthermore apply all of the style rules that attach to ordinary
man page text.  And I would tighten the wording, too.

So I would write...

ESC ] P		T{
Set palette,
with a parameter of 7 hexadecimal digits
=2EI nrrggbb
after
=2EBR P .
=2EIR n\~ is
the color,
and
=2EI rrggbb
its 8-bit red/green/blue channel values.
T}

Observe the use of a non-breaking space escape sequence \~ to act as a
"tie", preventing a line break between "n" and the very short word "is".
This is not essential; it is a recommended typographical practice.  I
also saw someone ask how to do this on StackExchange recently[2].

I dropped mentions of range because I feel that people using hexadecimal
can be expected to know how to count in that base.

>  .ad l
>  .TS
>  .TE
>  .ad

3. Consider dumping these adjustment requests bracketing the tables.

They arise from a misconception that adjustment cannot be manipulated
=66rom within tbl(1) text blocks.  It can.  I would check the output to
see if leaving adjustment as-is results in ugly table entries, and if
does, add 'na' requests to the beginnings of the affected text blocks on
a case by case basis.  We try to discourage the use of *roff requests in
man page text; moving them into tbl(1) content is a slight improvement.

I rewrote the groff tbl(1) man page for 1.23 (forthcoming) because I
found the existing one difficult to understand.  Even Lesk's original
paper (CSTR #49) left me wondering in places.  (I have a thick skull.)

Here is the subsection on text blocks.  Font style changes are lost in
plain text email.  More context is available at the source[3].

[[
   Text blocks
       An ordinary table entry=E2=80=99s contents can make a column, and
       therefore the table, excessively wide; the table then exceeds the
       line length of the page, and becomes ugly or is exposed to
       truncation by the output device.  When a table entry requires
       more conventional typesetting, breaking across more than one
       output line (and thereby increasing the height of its row), it
       can be placed within a text block.

       tbl interprets a table entry of =E2=80=9CT{=E2=80=9D at the end of a=
n input line
       not as table data, but as a token starting a text block.
       Similarly, =E2=80=9CT}=E2=80=9D at the start of an input line ends a=
 text block.
       Text block tokens can share an input line with other table data
       (preceding T{ and following T}).  Input lines between these
       tokens are formatted in a diversion by troff.  Text blocks cannot
       be nested.  Multiple text blocks can occur in a table row.

       Like other table entries, text blocks are formatted as was the
       text prior to the table, modified by applicable column
       descriptors.  Specifically, the classifiers A, C, L, N, R, and S
       determine a text block=E2=80=99s alignment within its cell, but not =
its
       adjustment.  You can add na or ad requests to the beginning of a
       text block to alter its adjustment distinctly from other text in
       the document.  As with other table entries, when a text block
       ends, any alterations to its formatting are discarded.  They do
       not affect subsequent table entries, not even other text blocks.

       If w or x modifiers are not specified for all columns of a text
       block=E2=80=99s span, the default length of the text block (more
       precisely, the line length used to process the text block
       diversion) is computed as L=C3=97C/(N+1), where L is the current line
       length, C the number of columns spanned by the text block, and N
       the number of columns in the table.  If necessary, you can also
       control a text block=E2=80=99s width by including an ll (line length)
       request in it prior to any text to be formatted.  Because a
       diversion is used to format the text block, its width is
       subsequently available in the register dl.
]]

Regards,
Branden

[1] I did that for the ones most recast, ESC ] P and ESC ] R, but
    unfortunately the console driver on my system suffers from serious
    redraw problems on scroll; if you reset the palette from the last
    line on the screen, many characters on the screen do not get
    repainted in the new color.  Keep changing the palette, and color
    errors accumulate, so the appearance of color 7 (the default
    foreground) can appear in many shades simultaneously even though the
    driver, presumably, thinks they're all the same.  If the redrawing
    errors are deterministic, can I assume that this will never be
    rectified because someone out there must have a 24-bit color ASCII
    art image viewer for the console, and fixing the bug would ruin it?

[2] https://unix.stackexchange.com/questions/694622/how-can-i-prevent-a-lin=
e-break-between-option-and-parameter-using-rb-and-ir/694765#694765

[3] https://git.savannah.gnu.org/cgit/groff.git/tree/src/preproc/tbl/tbl.1.=
man

--jwugz2kmfx3fzi7r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEh3PWHWjjDgcrENwa0Z6cfXEmbc4FAmI3UAEACgkQ0Z6cfXEm
bc7tRRAAk1DTf8yXCVoJT0od5QHp0SJgpinngRzvHkDrF4DqBe5Z9IDHWj4J5Vpm
F8Nr63Mdx7AUV4HxWEFMtGhv1/V+5gmNV8rxv6Nr2PIgX9TmwbzxIii1jeFC6tlU
frWDtK5xGhfBakFDGQ2ZahTcHimtcAykvDgbpdVqVceXXzItXM5qkxk4h8falXGJ
oJ2twWMPpEfi2nKX2b3Cdw4z09Wcwp1Nouv7sXDPWB/r68Gqq8MvjeNrsKmmIvMp
j5ZM/qyUQRkurFFJlDNNxTeW8QxMlJoGB9ls339Lcl/8ZkVTVdWaKt4/JBrZa1w1
JQIoI+zF9IXZ6wHO/38JS8sRgSguZJ/fx80LTEjbrcFJpdE1Q3iegcxZxXHMPzkC
c3Jl4dOyTxiJgvoBuYcv2XHd+5Ydt0M2lKttiSgolTMa48bhDON5dyYB6tTOZh3I
K+01pOjkqeqCAbrQAlIgCoNvzI5xgdQ1oQbtWpQYx0ufZb8k7TVuZFJbh51rs+cH
8SoFK8to47LjvNjVTkGjVCcgOTotuyTAC3WlZpqxR8r13p4UXclpTY4ntVca84EN
arW4c4YlLcWLYuGdoISx+dSrFSSgmrhouhx0nT+GumepPixEnPDxtDY5Nw9z0CYw
uFc3YwDVF2z+fWIu+yiiNyf/5QSRs36pfzgBBFtBBOxuQgIQ8as=
=HnlG
-----END PGP SIGNATURE-----

--jwugz2kmfx3fzi7r--
