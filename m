Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54CB54BB7B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 22:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240806AbiFNUTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 16:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353436AbiFNUST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 16:18:19 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E616563
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=Kr/UeB9oM281vcck974XwJ6BZeKE
        XSbV2DPYhGfC0DM=; b=old13mZqsudOfh92apttnUaWMOqDo2YNpVaSuIEkDDTH
        26ZV4zId3oQ74jOEeYu8FKj1heZB8bn258l6tHgQELGF1oblrptMY63jMmm5q7zC
        MqOYkC9NPIunSOFvvnEro78caWdUiXRRAG+Dal3iMhfHs30a1ViLGK2ugEuo7fs=
Received: (qmail 1848877 invoked from network); 14 Jun 2022 22:18:13 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 14 Jun 2022 22:18:13 +0200
X-UD-Smtp-Session: l3s3148p1@yLqhGm7h9psgAwDtxwyXAGMY7IbT6g6m
Date:   Tue, 14 Jun 2022 22:18:13 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: thermal: rcar-gen3-thermal: Add
 r8a779f0 support
Message-ID: <YqjtBQdzexzCRrmq@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220610201701.7946-1-wsa+renesas@sang-engineering.com>
 <20220610201701.7946-2-wsa+renesas@sang-engineering.com>
 <CAMuHMdW3uxQHk6SBX5MqnZsYqwY8p+0wmD6gHwS3ESUrkmpWkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uOF+LnROtUk/ylo3"
Content-Disposition: inline
In-Reply-To: <CAMuHMdW3uxQHk6SBX5MqnZsYqwY8p+0wmD6gHwS3ESUrkmpWkQ@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uOF+LnROtUk/ylo3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> What about splitting this in two separate checks at the top level:
>   - one for regs (R-Car V3U vs. the world), and
>   - a second for interrupts (R-Car V3U+S4-8 vs. the world)?

This task seems too much for my YAML-foo :( I couldn't get it to work.
Can we leave it as-is for now?


--uOF+LnROtUk/ylo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmKo7QAACgkQFA3kzBSg
Kbao4Q//WYdbnQJ+s0sI1UFm7IC6XM44Mtao3slqtfqPV0sWpqWXsoHT4QO/rkee
OQrCTYGWJW5SR91kRoQVyaOdsDVx69m5QOW3OJn/m3MP8QptfirX+AYPAp+1EN4l
ylHwOca+mQwVUspzttGM/nswNa0SIfTfz8kKWuvi8qFSoalMR4Ec6m0kR1pucof2
Er3Kc7/Prg+lMVMZr4I9Ddw01Bku71RLBjOnkWYMnFLAvnUmwc/FPIKVdz78SVOQ
p97K6c0xqwWF/NefGRQ2tIASErbSXYTWbpz5Plr+aiHWDmGQUd+ZjDVamC2y4oWE
HOjHeNMUGVWH1otstnAUiSUtpgaY21mpUbyw2nHeHdm+FSlpSymAt9PLTLDc6G8G
nFweTobJ5nou73nAEnN/pqxbCfY4zJxcw27C3HFBiALbEDODCQzmenIKbqBHq1I1
jUCAFd86eMwjsBNojdRCELeXMEcDkrIQnljC/GJXO8bACWlS/rEgy1mmZ3WdbDmM
MTAci4u/q29eZUJ1TBdQWFnJavzdGgGiRQ/bXO1cZkh8ytAWcug77eamdXpZ6hyG
lfo2oBDyLb5wlPsLLs9Ol9/nvCwabA/oJ5Iz0Qnk/13WsK4/R79+w8u69KT0s/FL
ZbUjxH3ydmYu9JvB4HnCf6uH7uhjyTbJf7QhFlb77r+6yx5WYxY=
=HtGH
-----END PGP SIGNATURE-----

--uOF+LnROtUk/ylo3--
