Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268F44C97A6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 22:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238513AbiCAVSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 16:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233874AbiCAVSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 16:18:37 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719D415A3D;
        Tue,  1 Mar 2022 13:17:55 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K7VTF5Wvcz4xZq;
        Wed,  2 Mar 2022 08:17:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646169474;
        bh=JQQ4mdgelSKajGDuvzRCBAehyZ8wOPedQlrF4HMdSt0=;
        h=Date:From:To:Cc:Subject:From;
        b=US7Jx+wMAykUDK2TBKf2phyWrEdUjJtxKHfGzRUNfNevDCZm/hh2cLGVwBdDcq3eH
         hzMF9rzaOjjv61gpFm50Ek2OEOcyNP+kGC9f/zBJ1tu/gJouzorjGcvcWaF7X7lUBp
         WFYHrcGPK1Jb56lI+oYsLHUxngEEcRoSSe561Modkz+DwQmZn9CdvwFOvtlgGLYTl2
         dsVsOZDQX3S4B8HdSfrHpzPYA2ImzKt3tmMfLDoujcx1XJvtxFJfb4nUTHRVKlAShM
         DIStubMJV3o9nLwduvLvEC3NDNvDn5adfvRynfmWZbEhV7JuwPR3c2iRaMP8hUj3om
         kAF7+UtNxa8xw==
Date:   Wed, 2 Mar 2022 08:17:52 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the drivers-x86 tree
Message-ID: <20220302081752.7fb5afd3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kvRB+alrUEanFgfocHMJOXW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kvRB+alrUEanFgfocHMJOXW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  646f429ec2de ("platform/x86: amd-pmc: Set QOS during suspend on CZN w/ ti=
mer wakeup")

Fixes tag

  Fixes: 59348401ebed ("platform/x86: amd-pmc: Add special handling for tim=
er based S0i3 wakeup"

has these problem(s):

  - Subject has leading but no trailing parentheses

--=20
Cheers,
Stephen Rothwell

--Sig_/kvRB+alrUEanFgfocHMJOXW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIejYAACgkQAVBC80lX
0GzNsAgAgExeGLJCGtOk6fdARirTvFft4W+Aer7YFMufGpyGchGhouT9imKbfhHE
rMIt4Ph+/TEWtBErngapgVSXin2njUcDMQnOgNACmG5DP3P/x+BDPVV0L44rVkFx
BO0F8n56DToNenE+Rk0x79WwgKP9OxPpxyoQHeODil56FZPvEyZWlMb0rj6LPHpM
u7VdNFc3ME+rziMaIqXW1ihnSbrP+ZYUA25C3/+ZuEvvksX+bZ8ufl7yU8qbmKbp
JJijN4+N8srvoNLXYhEdOw32xOLKo2ZMc37liXVsegfS5JcFsGVQBa7ycXaWYMj3
nrAJYJqcirLB8z9XVzNX6OsZe8YXzQ==
=1nLH
-----END PGP SIGNATURE-----

--Sig_/kvRB+alrUEanFgfocHMJOXW--
