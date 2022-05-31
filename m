Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEF8538D08
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 10:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244927AbiEaIl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 04:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241386AbiEaIlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 04:41:21 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C54D7CDD1
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 01:41:19 -0700 (PDT)
Received: (Authenticated sender: didi.debian@cknow.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 2F4A910000B;
        Tue, 31 May 2022 08:41:16 +0000 (UTC)
From:   Diederik de Haas <didi.debian@cknow.org>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, 970639@bugs.debian.org
Subject: ZSWAP still considered experimental?
Date:   Tue, 31 May 2022 10:41:05 +0200
Message-ID: <10087857.nUPlyArG6x@bagend>
Organization: Connecting Knowledge
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2184614.iZASKD2KPV"; micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2184614.iZASKD2KPV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
To: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, 970639@bugs.debian.org
Subject: ZSWAP still considered experimental?
Date: Tue, 31 May 2022 10:41:05 +0200
Message-ID: <10087857.nUPlyArG6x@bagend>
Organization: Connecting Knowledge

In https://bugs.debian.org/970639 the request was made to enable ZSWAP.

Upon it was (rightly) noted that zswap.rst contained this:
> Zswap is a new feature as of v3.11 and interacts heavily with memory
> reclaim.  This interaction has not been fully explored on the large set
> of potential configurations and workloads that exist.  For this reason,
> zswap is a work in progress and should be considered experimental.

Furthermore the mm/Kconfig contains this on the ZSWAP option:
> Compressed cache for swap pages (EXPERIMENTAL)

But the contents of that zswap.rst hasn't changed since the initial commit  
61b0d76017a50c263c303fa263b295b04e0c68f6 from 2013-07-11.

Similarly, that line in Kconfig hasn't changed either since the initial commit
2b2811178e85553405b86e3fe78357b9b95889ce from 2013-07-11.

Should ZSWAP should still be considered experimental or not?

Regards,
  Diederik
--nextPart2184614.iZASKD2KPV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCYpXUoQAKCRDXblvOeH7b
blLaAP4gUZrU0GhMyFbf2FcJzCdDD2ytZ5hVTlmTQxhh2pDiBAEA84igmX8EzyH+
eheIFdz7Emk634VV2Vn+P/HuHzLh3Qw=
=YiWN
-----END PGP SIGNATURE-----

--nextPart2184614.iZASKD2KPV--



