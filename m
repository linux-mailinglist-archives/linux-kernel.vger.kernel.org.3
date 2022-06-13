Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C2A54A021
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349775AbiFMUtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244927AbiFMUrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:47:41 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F8112C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=1wRsT0Tmd+oAhhjtNXgHdngUWT+v
        HobjCLA2n+Eu8jE=; b=nNEycXghB1tHVghNXVU8zGRnwhQu3LFM4yI/OhJFipsr
        RNkTyPvAProZEYMeV93oNQ7vSjBSVZs4lgaPKoW3pZarZjtU2xH86diNB/QHeIFD
        T48mce3RNUN0K0I+bi7QOMCy8pkX1EfFZWkJEaPmPo+IK6spVLB0VYLK9Zs6eoM=
Received: (qmail 1425404 invoked from network); 13 Jun 2022 22:04:57 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Jun 2022 22:04:57 +0200
X-UD-Smtp-Session: l3s3148p1@1TUqzVnhx1dZD+/B
Date:   Mon, 13 Jun 2022 22:04:53 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: renesas: r8a779f0: Add HSCIF0+1 clocks
Message-ID: <YqeYZXTDmW7rfgCP@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220613130949.10001-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pSAZrI7vICVqWXoz"
Content-Disposition: inline
In-Reply-To: <20220613130949.10001-1-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pSAZrI7vICVqWXoz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 13, 2022 at 03:09:49PM +0200, Wolfram Sang wrote:
> Those have been successfully tested. HSCIF2+3 still need verification.

I managed to test all other HSCIFs and SCIFs now. I'll resend the
updated patches tomorrow.


--pSAZrI7vICVqWXoz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmKnmGEACgkQFA3kzBSg
KbaUABAAqDFLBfhHhNSGTuYDvGIIagahcjf7xC404xBrgEiz+2M8H6LDZFMm6nM3
BjkXPYJlX8w+0rIOgatsET4QLVw8Q1fip/ubea36tBG6wD2JJU7+yjXFWbhxlrM6
If+MMOMOhj7FSDfM1KHGHpLRPULGT0Nun36738rh6ggs8/xid79LAPXIhUa5oOBH
mpN9zHO3/EFgzWDVzTr06rX7ASXNsvrSs5Z+Aa3EsqNM4Fvk7Vod9H8RsmuHvqgF
UuHHu0YIibyB+1bon/ypb9VIX6s5t8h0lyiTM6rdAtEjjQIjc72PPLrv6pCGL3h9
EW1WUAeVDy2KltQ0ueH5X9c4Ajgsew+40YeGizsBhRzNqRPLWETGj6UibNp/5oUo
2emjQ/+dg/5//uKnUMTWJw+68opzYSzeQEDr3Lx19d2KbVoJfqgpKgIJslNoJsAH
ESFoaJoC3+tIaf2Oba63DaH9Y0tHJRX+3JLhQaZarWWZuMlcPRX7snNvM0Qr9bJJ
yTq+druC3EIm9PUh19FOB+QehUCvoCD+X6zgtvrG7DVQImiOyLuhILbwEBI61IYI
TbfDlTZMStnTwsGlhHqWpN0mz1zfMmS6g6QpF0clQla3FrRA2jcs+w3NxO+9eAm4
mWGsK87DPUA/AbHwKs5Mvvr4+g27znN/RDORZYUbGltysqCVmCQ=
=9YHp
-----END PGP SIGNATURE-----

--pSAZrI7vICVqWXoz--
