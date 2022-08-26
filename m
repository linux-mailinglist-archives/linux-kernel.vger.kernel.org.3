Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C005A1EBD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 04:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiHZCUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 22:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244792AbiHZCT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 22:19:56 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08662CAC7D;
        Thu, 25 Aug 2022 19:19:49 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id z187so253874pfb.12;
        Thu, 25 Aug 2022 19:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=EKv+05k9JH9Uqt50ieojM3xFY0PImw/aMobYWks+ACU=;
        b=IR8uNFhKc8EwHSA99QLCf1XBiQI05t1u4FZUAmU/UAAmc6B7Gvv4r0iNBuuklrt/ZS
         0saapFrEH4ETVuEorR7JHcw369GOP4qzX2pTcY9r9ogmR1lxcUvE5YCyxTVOr4xbCQ4D
         gKeIXOb5XvVQug1SmxAjDd5DKVtU6yHl4P6ChAZAVfqTnBbp0zYORFmJNAUBUGWXwneW
         yxV1Q47SPTfBvofihOuCXKEVRb2h12DjamR3ZJPO5kPPpNYy9jd+xRKL0U1Ld5vxDyfN
         xF07qsz5JdnTPE5w/gf9IUC0JoP8cKGEHeWDziA7XWUQGi3OGncXAGUk59KCKPt09zLR
         W0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=EKv+05k9JH9Uqt50ieojM3xFY0PImw/aMobYWks+ACU=;
        b=esKGCfztdckVjm5A8h0ZasSdMcPCE2SlwR+RQ/tvLJU1CpDCiRjvou3yswODKJ4FG0
         Yf9IskJkPidV1Ovqm3hNl4fDxpGuG1UW4mvcE8NY7PF5cruh4MfllQZ4c4DQomcwABlK
         nqqt15H4L06M5lnHl02IyDZxvFo8q99X57dW9bVfBc3OLi2yc60b8nxnkqJalddxPLs5
         FqVZfCx4B+tzdrm4IbkjFvgpLaLOCKB55eGJfj5JKAisj848rSoXBKqjWhrFhyRCGWRn
         bpXlCqDozB2kjPI13yBN3yT+QxcyAX4KhXD2WgjcaPkHjes8ACj4AkU7T6reRyygEmVA
         OBzQ==
X-Gm-Message-State: ACgBeo1RNiLfB83eQ2m0gCT5YQCr1/dibZkq0HA91BFXIPWWFBuoo8n8
        TllWNm0xViXDxjgU6vUt0/jokwab0Qk=
X-Google-Smtp-Source: AA6agR72Kd9MhYKN4v9ZosUWuPVDW/XsA0f47ZYPY8StQXb+V3ZClucUd3DBGQ6gZGKV7wNijgPNzA==
X-Received: by 2002:a63:4f10:0:b0:426:9c61:5e48 with SMTP id d16-20020a634f10000000b004269c615e48mr1498704pgb.360.1661480389296;
        Thu, 25 Aug 2022 19:19:49 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-18.three.co.id. [180.214.233.18])
        by smtp.gmail.com with ESMTPSA id z16-20020aa79f90000000b00535dc0a14d1sm331682pfr.130.2022.08.25.19.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 19:19:29 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id C8DEB1037E0; Fri, 26 Aug 2022 09:19:14 +0700 (WIB)
Date:   Fri, 26 Aug 2022 09:19:14 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: Update version number from 5.x to 6.x in README.rst
Message-ID: <YwgtoiKl5Azt7Pre@debian.me>
References: <20220824080836.23087-1-lukas.bulwahn@gmail.com>
 <87a67syxa0.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HcCi7VObJn1wc0Ii"
Content-Disposition: inline
In-Reply-To: <87a67syxa0.fsf@meer.lwn.net>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HcCi7VObJn1wc0Ii
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 25, 2022 at 12:48:39PM -0600, Jonathan Corbet wrote:
>  - applying-patches.rst should just go.  I didn't prevail last time I
>    tried to make that point, but I still don't think that we help
>    anybody by dragging 1990's instructions around now.
>=20

Hi jon,

If we're about to rm applying-patches.rst, at least we also need to add
a warning to the doc, saying "This documentation is obsolete and will be
removed in the future.", while adding the same deprecation message on
scripts/patch-kernel. The script can still be usable and kept around for
a cycle. If no users complain, we will go ahead rm-ing.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--HcCi7VObJn1wc0Ii
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYwgtnAAKCRD2uYlJVVFO
o0QwAQD8+c21JS2Qr4cJ/P+8AzF+0Su0R+RgDEaGY5euIb/adAEA4dngDeR8H67S
hFwXS0JKA5liKoPRrhI+RdQYE5+M/w4=
=wX+p
-----END PGP SIGNATURE-----

--HcCi7VObJn1wc0Ii--
