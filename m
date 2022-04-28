Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F67D51337A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 14:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346131AbiD1MXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 08:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346119AbiD1MXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 08:23:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450DC2BB26;
        Thu, 28 Apr 2022 05:19:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D40B461FB8;
        Thu, 28 Apr 2022 12:19:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62EA2C385A0;
        Thu, 28 Apr 2022 12:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651148387;
        bh=0ZF7rbfOURu9fFQScLsiQBow2Dp0oWt4z38KgBEVbyw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RqPNCacM155R73rT1xOj26j/PjnWU1BXlCCR+fgYHwmP6pAMyuA+qIPZhfNq50dbF
         Hqi5elhl8jrh+4pjB1DaSTmiNMRnjVoz/zO6fLCu3R4HrPrtNNskRIltHnmVgCh71n
         mLB27rM9gvH9guv4nsUV35OSWd2QV0993k1yu8A8SgrpHjaMdb35bDh1/7zF8eb76j
         CopMvriSjfhzOzhzavCS63LS2g5Mh8uIL/X1yS8TctGAI5VnIBhVmuWwpl5WHmEwcS
         3RIxqZnWcz1fAD66e6vhNGq01RmJpcHvLKpqMEn7/GwmhFMX5v01TIVcbbnl9k/CaF
         mZYWEGTDD4+jQ==
Date:   Thu, 28 Apr 2022 13:19:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     robh+dt@kernel.org, angelogioacchino.delregno@collabora.com,
        aaronyu@google.com, matthias.bgg@gmail.com, trevor.wu@mediatek.com,
        tzungbi@google.com, julianbraha@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [v4 00/18] ASoC: mediatek: Add support for MT8186 SoC
Message-ID: <YmqGXCg97X6Vqvs+@sirena.org.uk>
References: <20220428093355.16172-1-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="14HuojlumyrWt7WU"
Content-Disposition: inline
In-Reply-To: <20220428093355.16172-1-jiaxin.yu@mediatek.com>
X-Cookie: Bedfellows make strange politicians.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--14HuojlumyrWt7WU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 28, 2022 at 05:33:37PM +0800, Jiaxin Yu wrote:
> This series of patches adds support for Mediatek AFE of MT8186 Soc.
> Patches are based on broonie tree "for-next" branch.

This looks mostly good from a framework point of view - I did notice a
few minor issues which I commented on (some of the control things are
repeated in other patches) but the overwhelming bulk of the code looks
good.

--14HuojlumyrWt7WU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJqhlwACgkQJNaLcl1U
h9D9DggAg16/opdgBxLyrYeeiZua8OPPegaMglo/X8k1DiCR0BudGSgln13XMg5i
gmLRcCIr6/gI69T9tIdarki2mOqMhdyZAjZtLsL8crocPPM5/pkuGF9lFg+dEyWa
Hl3ipVQEKqxgtSSRelBtwZbT6N5tvVNjQkV1R0+376N/jbtS4gUa3wcs6weJhCGz
7Zo6/8FogQaAG0S/RkqiBRAOfStCbJl+33rN1nASR7mZJHCsu6kefxdHsrtYJKq9
VqQtzDPI8wfHaMhJ/cFidSWVssQD2Uoyea3/Fk3I5YmHvnM77gIB5taZPeAlKQxh
9Ofv/WaTnH7gZHg389wqh3jxMnUJmQ==
=bwgG
-----END PGP SIGNATURE-----

--14HuojlumyrWt7WU--
