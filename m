Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A022E483611
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 18:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235998AbiACRbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 12:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235590AbiACRbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 12:31:01 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8661C06137B;
        Mon,  3 Jan 2022 09:30:39 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id o3so13011865wrh.10;
        Mon, 03 Jan 2022 09:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ieLzOgCJ18o1a90jIR9YZk5rmj0v70cqqTlRuLr9aYE=;
        b=Ki1DNOBNOCnARRUZ5+7C8IrcnSgC3J/g4IC6/oX9CI3jlP9ItYiZwWQPH182hng2u4
         8msPlBASs3pJ2+DA1jUoTMhs+WZYBJq1GbOWR9ShfhVQMLQ7FhEl19Q+lHMDC/ZSc3t1
         /CzpgboCmCSL+SAgVM+sLxMATL0X05RGrhpiCscE51bD3ldDgBIx4nVnfwCQkOZiBUaZ
         mL/CDwwvBM36kXbyBq+3aPkh8SflASt6fHwoypEDdoRIAalVb5N9P4J5exQL0Fx/x358
         hV3p6oDZMRCL8QgBR06ULpC6LmLJ5PsU1HN3NPvXbaZusJ8wwrB6eYi+3oSRWDOwG+73
         IpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ieLzOgCJ18o1a90jIR9YZk5rmj0v70cqqTlRuLr9aYE=;
        b=Yk4yRBHO2n7rFSenW85LYGrmgO1NL+3CPPW1CJ8suiqTgOX9hKBCwtpbTCSwnHQMsZ
         xYSoS0KW0Gr3xQWxkKwSYAKuzbsLEiPyrbVigTpoFx8ccUeVmH/ukqpIIMGNfh2B23hw
         zmW7LgaJRriKevTgDTeYZVkB8Fhbannpx2L00yhHX3GkiNUZywhFoOQs9N0wpRrYS6eE
         8iMGOxx3+ttGv0oyaEREb45Yxy3ysQBZyi130/zqWou3urbZxdhCusO4LQAaR55aeEKF
         LZXhbL4p+i5WYLYXIICddhApTXd7XWtq2V3Y+pwvikRwnFYueDJejRaGI3fS6sRYx38J
         srnA==
X-Gm-Message-State: AOAM5326HfftSGcLivzRt66RYozyIvaKVaPiGwo93gloqFW9mKot90tw
        S0zB69TjFzO7ewfoQYbVNH5UvFjJSLmIZw==
X-Google-Smtp-Source: ABdhPJyloc9hnDCLTV+5qSTOWpsbGeHAHWWR/pxWTNZScHowNhp5SlOoecPkrlpU/g2rXr7cRPqP9A==
X-Received: by 2002:a5d:638b:: with SMTP id p11mr38529186wru.241.1641231038529;
        Mon, 03 Jan 2022 09:30:38 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id l8sm36648090wrv.25.2022.01.03.09.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 09:30:38 -0800 (PST)
Date:   Mon, 3 Jan 2022 18:30:34 +0100
From:   Tomasz =?UTF-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts: kernel-doc: transform documentation into POD
Message-ID: <20220103183034.77ba8a8c@fuji.fritz.box>
In-Reply-To: <87pmp9tcju.fsf@intel.com>
References: <20211209225549.69010-1-tomasz.warniello@gmail.com>
        <87h7b8cfg0.fsf@meer.lwn.net>
        <0796a780-f5ee-0b6c-e7ef-544ba5f6a429@gmail.com>
        <87pmp9tcju.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jan 2022 11:04:53 +0200
Jani Nikula <jani.nikula@linux.intel.com> wrote:

> On Mon, 03 Jan 2022, Tomasz Warnie=C5=82=C5=82o <tomasz.warniello@gmail.c=
om> wrote:
> > On 17/12/2021 00:12, Jonathan Corbet wrote: =20
> >>>  my $kernelversion;
> >>> @@ -468,7 +306,7 @@ while ($ARGV[0] =3D~ m/^--?(.*)/) {
> >>>      } elsif ($cmd eq "Werror") {
> >>>  	$Werror =3D 1;
> >>>      } elsif (($cmd eq "h") || ($cmd eq "help")) {
> >>> -	usage();
> >>> +			pod2usage(-exitval =3D> 0, -verbose =3D> 2); =20
> >>=20
> >> Why the strange indentation here?  This file is far from pretty, but
> >> that makes it worse.  (Other places too). =20
> >
> > Sometimes beauty requires cooperation. You can help it in your pager.
> > If it's less, then try `-x 2`, `-x 4`, etc. =20
>=20
> In kernel, tabs are 8 characters.
>=20
> See Documentation/process/coding-style.rst
>=20
>=20
> BR,
> Jani.
>=20
>=20

I am a heretic then.

Except for the initial dogma, I understand and agree with the rationale
in coding-style.rst.

Only what if I have stared at the screen not for 20 hours, but for
40 hours? Now I want to have indentation even deeper, of 16 spaces.
And how do I get this having 8 spaces here and there instead of tabs?
The system begins to fall apart.

The misleading statement is that tabs are 8 characters long. No. They
are exactly 1 character long. And that's ASCII 9.

Cheers,
TW
