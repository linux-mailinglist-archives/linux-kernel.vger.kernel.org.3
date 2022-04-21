Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D8150ABF3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 01:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442534AbiDUXZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 19:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245455AbiDUXZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:25:41 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29FF48318;
        Thu, 21 Apr 2022 16:22:49 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kktqr2zGgz4x7V;
        Fri, 22 Apr 2022 09:22:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650583368;
        bh=2++Muujv5OpIQr+TSeOBmxjcr+Obc8n7CYKml+tJZak=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LqpO7YMHwHBWsqLdrVHiidYvrUYSFT9ZmWzX54owE5idNpWU9Un5SldZpaBmvgdJP
         z0kWWAoiTLBnHqrIoNyNVgKcmoFGUN4SlErw0Bsx0Tvtt0YwEfR0/U/nRrK/EhHN+W
         VvS1gWn5P+O8eVRE7ksOuDdAEe7H37m1ggWeTu4ogP8/ssmiA2e9E1iVdcstYFeBlW
         p4po4og6jije/pg/q58ZjMHTkeV2XwFz9gJBdYCt+Ag4tNVJIq/ybTZAbxiAlxUWQ1
         17A4HRR2ucCVMzy/i1ZoTXuDchc9Of2Z/dsszBlIRyJICGsPclpZDn3/o6kIDZjdFn
         7b+Ww9w7LM14g==
Date:   Fri, 22 Apr 2022 09:22:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH v2] topology/sysfs: Fix allnoconfig build breakage.
Message-ID: <20220422092247.5c638079@canb.auug.org.au>
In-Reply-To: <YmGEL2klp4S97UiH@agluck-desk3.sc.intel.com>
References: <20220421152645.3a849198@canb.auug.org.au>
        <YmD+geU9CmjoVnN9@kroah.com>
        <YmF8Hrq5kgDdfvtS@agluck-desk3.sc.intel.com>
        <YmF+FTxgu2U4/oPA@kroah.com>
        <YmGEL2klp4S97UiH@agluck-desk3.sc.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WZrOLBY0B6HuGBNBfp4wLkv";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WZrOLBY0B6HuGBNBfp4wLkv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Thu, 21 Apr 2022 09:19:59 -0700 "Luck, Tony" <tony.luck@intel.com> wrote:
>
> Fixes: c3702a746ff5 ("topology/sysfs: Hide PPIN on systems that do not su=
pport it.")

This is actually commit aa63a74d4535.

--=20
Cheers,
Stephen Rothwell

--Sig_/WZrOLBY0B6HuGBNBfp4wLkv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJh50cACgkQAVBC80lX
0GzfGwf/YKargFQdr/xGLVVE5KkZw+DzEfcbfTl5KkqsQcHHDcfJ6sPaKAnWAv5T
mctpUNeWD0nGRPpE6svfoJQqSbLa9xh9JEwx/uc9ZLcxdRYnll7XwiRabeL/K7dt
4PipXZrdSXzn6JntsFBC6CW8cUEZqLGj2eJMQahv2T2HoSkZNdS60Wak79skDxRA
eoMtJq8ylR8aVWdyM7SXMaFtl8jAn8dsSQSLm5gx4p+k+xWfDPKSv0cYBH43u9NW
G6pnue8EzYV23c8D12om0eOui1s7QJrLg+yXuAaAPBU72V3B2+JnX0nk836Hwr97
BTId+gwgmQQUqZHzJxD8AqcsqBuy7Q==
=kgLe
-----END PGP SIGNATURE-----

--Sig_/WZrOLBY0B6HuGBNBfp4wLkv--
