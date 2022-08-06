Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1960A58B598
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 14:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbiHFMk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 08:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiHFMky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 08:40:54 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD66637C;
        Sat,  6 Aug 2022 05:40:52 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id bh13so4785906pgb.4;
        Sat, 06 Aug 2022 05:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=o6pt3V1ha9yMo8oPh0RhSV7A5lQkFUBOGwSJxIjKq5Y=;
        b=K3zZNGyQzBOJGo9GHJ77B64dvtlpK4HGVReHiflBNDRpOjaH5sqOdA8CSpHY5CKTyf
         jMxciE0uAHt180KJ/Y+huKoZL4LmZDsa6WkKOyCwoxB/ThJX4uVJEg7ZTShFI/az0Ar2
         z7gP6VTnSFHOO3nyj7PfGi5h2pn3jkcI30MOA4gJBLa6ZPkeSr1jNi+ni+/957EXpVKE
         8cMH0A3oIzRK5Ii74+i2xFTbbdfg/VV4lJGKX03EHlP6Q0ikAumdp8EVEn0EXa//V+ro
         7vXPHclNzVW+zRBDjtu+d19HsGrRLP2TD974QnRupiahEXDmXn0SLRi8PGivCy1jVQMg
         wXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=o6pt3V1ha9yMo8oPh0RhSV7A5lQkFUBOGwSJxIjKq5Y=;
        b=MuBhcaN1sy6pV/Eqib90wu6mq4X9exrknzIt6r/5Lboiv/kWeTUoRcoyQwzic31Lrt
         +hRxKMynQUo2hhRN/6CmIG6Q97xtJnLfdhkSOCy+zhFgryoJjiNATBV5PhpOI/y/J7Ye
         5n+FvHt3dfM0oH/Nyb+IVKk8dKxsM+kQ0TcjziQig4ZbZTRhpcoBh1pgYI/MPxec4A4e
         iNAKydSf1obiV6qHyXlNqWhlnd9zQ3ZOATd/Iz4JL9+/vQFSUU0GrIly5DKUDuUEaj2K
         TDjGcvflPA8yKlCSFvtRQ1QJul0OJ6/b0+bHp/3kjTpmC8XRNxmvNWOW4CAmn7hx9C2K
         8fxw==
X-Gm-Message-State: ACgBeo3sRzCO6lBRQ0AuiwzbcMO4UVNsNYzN068b67bvwKA1jAT2fWWl
        JrbkAnNyrVe+HlHRTN1MmHA=
X-Google-Smtp-Source: AA6agR4HVXRr5ozE4MZULCJYLmm+yzEtIzOb6rNsc6/YEix1fRqJBoSHmvvrRwFlh1pZPSou+4rtrw==
X-Received: by 2002:a63:d555:0:b0:41b:ca49:54c3 with SMTP id v21-20020a63d555000000b0041bca4954c3mr9091265pgi.360.1659789652285;
        Sat, 06 Aug 2022 05:40:52 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-10.three.co.id. [180.214.232.10])
        by smtp.gmail.com with ESMTPSA id r19-20020a634413000000b0040c9df2b060sm3072702pga.30.2022.08.06.05.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 05:40:51 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 80D7A103B77; Sat,  6 Aug 2022 19:40:46 +0700 (WIB)
Date:   Sat, 6 Aug 2022 19:40:46 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, daniel.vetter@ffwll.ch,
        seanpaul@chromium.org, robdclark@gmail.com,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 19/33] doc-dyndbg: edit dynamic-debug-howto for
 brevity, audience
Message-ID: <Yu5hTr6qcLwiPRNp@debian.me>
References: <20220805215355.3509287-1-jim.cromie@gmail.com>
 <20220805215355.3509287-20-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
        protocol="application/pgp-signature"; boundary="zCnbKQzWNc0slIHJ"
Content-Disposition: inline
In-Reply-To: <20220805215355.3509287-20-jim.cromie@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zCnbKQzWNc0slIHJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 05, 2022 at 03:53:41PM -0600, Jim Cromie wrote:
> Rework/modernize docs:
>=20
>  - use /proc/dynamic_debug/control in examples
>    its *always* there (when dyndbg is config'd), even when <debugfs> is n=
ot.
>    drop <debugfs> talk, its a distraction here.
>=20
>  - alias ddcmd=3D'echo $* > /proc/dynamic_debug/control
>    focus on args: declutter, hide boilerplate, make pwd independent.
>=20
>  - swap sections: Viewing before Controlling. control file as Catalog.
>=20
>  - focus on use by a system administrator
>    add an alias to make examples more readable
>    drop grep-101 lessons, admins know this.
>=20
>  - use init/main.c as 1st example, thread it thru doc where useful.
>    everybodys kernel boots, runs these.
>=20
>  - add *prdbg* api section
>    to the bottom of the file, its for developers more than admins.
>    move list of api functions there.
>=20
>  - simplify - drop extra words, phrases, sentences.
>=20
>  - add "decorator" flags line to unify "prefix", trim fmlt descriptions
>=20
> CC: linux-doc@vger.kernel.org
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
>=20

The documentation LGTM (no new warnings).

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--zCnbKQzWNc0slIHJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTsebsWCPCpxY9T92n/R0PGQ3AzwAUCYu5hNQAKCRD/R0PGQ3Az
wGuzAYDy/O8VqIX4dB6ItFwNHJm1rs7Qg4OuYgYbKFvhP69MPdWx64MR4soFNSUx
y/x/+HABgNTyMUR8QKMtJnT6K443IFX7iqf6bs05/IbT4PqLQjZXkpc+PQBWALvU
6LjFercp5g==
=Aeer
-----END PGP SIGNATURE-----

--zCnbKQzWNc0slIHJ--
