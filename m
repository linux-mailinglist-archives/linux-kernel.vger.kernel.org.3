Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30222506F8D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 15:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345135AbiDSOBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344830AbiDSOBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:01:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F0A38DBD;
        Tue, 19 Apr 2022 06:58:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA07461693;
        Tue, 19 Apr 2022 13:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73840C385A5;
        Tue, 19 Apr 2022 13:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650376704;
        bh=sGN5CWJMdVz20am6iOdFUlCdx+o7gih1dOCoJNfeTSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oVlUbHyYZrYiHdaKXoEt9i5RnHm0Tqyb/SexzIytdTBl35qudDnnNVGa1i2jiMyXC
         EiT2Occbmv0R6ejqmALFC41DISyln6ioVQUxOiobhGuHEBRGmk895qCiGT3llLpgCS
         DuAciLfgcCBmA6K9EUwaISHek/9dhN+cIDcMCx7WdivxTx1MPnQF5HZzzZvZ9Cwnvx
         62Uki5HSRL/zTuf2lvogFTfDR6Lp4/b7t23mS7PaWA5w9XWLhuNcQNFlsl8HGlm8T/
         oQ9nz++paPpgY3+W/RpjtfPgw3zZRXV/15bYCfriFjjuEbhwJljAk7bDa/MtAG3UYh
         Z0199/1sNdoLw==
Date:   Tue, 19 Apr 2022 14:58:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/sme: Add hwcap for Scalable Matrix Extension
Message-ID: <Yl6/+baDhElVxwyC@sirena.org.uk>
References: <20220414115544.36204-1-tianjia.zhang@linux.alibaba.com>
 <YlgNW0/ji6KlkyZo@sirena.org.uk>
 <e7a0d0d4-b6ca-6fec-df33-929961f0d43e@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y7+zdXbMAYrYfLfn"
Content-Disposition: inline
In-Reply-To: <e7a0d0d4-b6ca-6fec-df33-929961f0d43e@linux.alibaba.com>
X-Cookie: That's what she said.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y7+zdXbMAYrYfLfn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 15, 2022 at 10:25:33AM +0800, Tianjia Zhang wrote:
> On 4/14/22 8:02 PM, Mark Brown wrote:
> > On Thu, Apr 14, 2022 at 07:55:44PM +0800, Tianjia Zhang wrote:

> > Why add something independently, especially given that there is no way
> > for userspace to do anything constructive with the feature without the
> > rest of the kernel support?  Any attempt to use SME instructions without
> > kernel support will trap and generate a SIGILL even if the feature is
> > present in hardware.

> Great job, I encountered the issue of invalid REVD (requires FEAT_SME)
> instruction when developing SVE2 programs, so I plan to gradually
> support SME in the kernel, thanks for your contribution, you can ignore
> my patch.

I see.  Unfortunately all the new registers mean that we really need to
define all the ABI as soon as we enable anything and the only thing we
can really skip out on when doing initial enablement is KVM (which I
have in fact skipped for the time being, I'll look at that at some point
after the initial support is landed).

> In addition, I would like to ask a question, whether there is an
> alternative SVE2 instruction for the REVD instruction that can complete
> this operation, if the machine does not support SME.

I'm not aware of anything, but I am mostly focused on the OS support
rather than any of the actual mathematical operations that are more the
point of these architecture features so I might be missing something.

> > Do you have a system with SME that you're trying to use?  Review/testing
> > on the current series would be appreciated.

> Unfortunately, the value currently read by my machine ID_AA64PFR1_EL1
> register is 0x121. It seems that the hardware does not support SME. Is
> there any other help I can provide?

Other than verifying that the series doesn't cause trouble for systems
without SME=20

--y7+zdXbMAYrYfLfn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJev/gACgkQJNaLcl1U
h9D6Pwf5AXCOiooQjnPnliTaNN7/AbtJt2IfDB/g6sI7mk8sbxHv9T62E2BNQW9K
7pG00JpxzBV/cjBTdT0JKgAK4Ze5I0OE8kO6rW2at9n6sKHKBTr3Adbu52KNs6CI
wiWlZkTu6RVfy/TKHwsaw93QSJtSbo8LamAbADXSAcZ2BpdVsUvZsaVho/uLEth4
lmd8iCnXhCpZrsyMuRx8sx6FSgizBGtxhWyhxK+1DqN8zEQxE2j2IE7SQiq9k0eI
y3/ZF+cwQnAssmJQxS+smIdH6uBFpowl2t5CcUkE2rKIvF69rvun8tSHHDBnv1cK
QTE+0+iGFwrWMHo0H63sSeZGs3qMig==
=6+y1
-----END PGP SIGNATURE-----

--y7+zdXbMAYrYfLfn--
