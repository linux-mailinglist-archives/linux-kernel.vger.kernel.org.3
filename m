Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E8354BA2C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 21:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345245AbiFNTMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 15:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345217AbiFNTML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 15:12:11 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3A720BC5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 12:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=bQN25CW45ouQ5NGl6irn0aT+WYcb
        3VCc3CpNxPofNC4=; b=24y5kHhxLjaqQm/6O9vOrNSt15261BiNhqG5Ksjf7fA5
        5vnMuvAjWzz7eiiXR0PlsY24DDbx4+dcqB0zl2xysgRiDQm9HsN+DekVTYbhNOF+
        tnXqu3jBERlbrNuZxwR0VH5Runb3A95uGayE8dR0g0sixuaoWu/Pk2M+ouWazvQ=
Received: (qmail 1829616 invoked from network); 14 Jun 2022 21:12:03 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 14 Jun 2022 21:12:03 +0200
X-UD-Smtp-Session: l3s3148p1@JSoCLm3h8psgAwDtxwyXAGMY7IbT6g6m
Date:   Tue, 14 Jun 2022 21:12:02 +0200
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
Message-ID: <YqjdglN156QSg9jR@shikoro>
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
        protocol="application/pgp-signature"; boundary="ztfOnw5xrfs4xUfZ"
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


--ztfOnw5xrfs4xUfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> What about splitting this in two separate checks at the top level:
>   - one for regs (R-Car V3U vs. the world), and
>   - a second for interrupts (R-Car V3U+S4-8 vs. the world)?

I'll try this and see how it looks, thanks for the suggestion!


--ztfOnw5xrfs4xUfZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmKo3X4ACgkQFA3kzBSg
KbYmIA//V/QRt7xcWjrLRSc6pESMzGk6HyoSrZ6ONFbIogArW1iYVh7dcNkm1moO
4j2Ssfsd/5pdkTVZ4tGrzn4hAHpZVKm09b919GNsVEeP7kIFymOUMmVQIgkZ0CME
zSD8j+8qisBASPCgWt1/xLLPw30Pr35BRHdAIHOTmXo60Oy6E4DZDqlo8Qw1UmBt
PsY607TV+Tn1LRDW0n5tkSIxsaGRsZLtsnTMzGCr8BvDSWQq92ksOmMMhcqevnK9
zxUHQmDWScWe92M5lNOsrAgKVl2MTDGYYOVgIx+W8+P6wj0URpPh9iadfSQUgE9b
jnHpTEPTcseFVVagjEIIXVsFYEe/RePPrE38XGNkjaoyaZVp8C+DWCQHHfDPkp/U
0RRVwsTcly7ETzH2i6cIbdqdmZRPlBeiQW1Yr6EcYS/J276cQuXNxCcJVhBfGCTX
WeZcEwbzDWpX0c7bobql135mvb+C25pK1crFnCJjDh5WYg7iUnWuZci5/iK6tv7W
5xxCD1rcSuqeyeyuQf2NhuKADuZL4l35eXHKtn3JTlcGBtIIdsh718oXJRxoKgFu
1WGIHe5yz0xZOpHfRy5ITrBD7eemcbDVjd0O7Ehl9iuAGNdW+R6MeQPXapuEjcpf
fblBqXdNSwKFzmb2/1xf+I9YKJYz6LU+vd9s2995Gl7goa+JF4w=
=DXqu
-----END PGP SIGNATURE-----

--ztfOnw5xrfs4xUfZ--
