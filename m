Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6544CFFBA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241720AbiCGNPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236834AbiCGNPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:15:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406288B6F1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 05:14:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F056AB8101B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 13:14:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2EF0C340E9;
        Mon,  7 Mar 2022 13:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646658876;
        bh=jK5tthGPa6NNlk/rKdqUQuBhZW7CjqSVqu7tpEhh/7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dKzcECX9lMHtNjgh/SJ7YqhiXSzyOghF1D8Ddn28YStxnA5oZgphXDATXx1Z5x22I
         YpFb4cNHhjLlQ9OxOmrxza+hTnJynAuo5KMNXoLnPLsJeV1GE10mB1/TM/dDtZKzqX
         LNsf1vnJmga02E/9T1F73sCA3ybZrJPopvzH+qprr0SUg9Hxk/EPHoX1LNwBTv+LjT
         B9ZfRhDUyycrr8Rm4hxyWyxjoBojZX+YshrjSEOqo3CWArdjMlplkRryBGT4rRU/zI
         dbkIloO7e/RO/YPAH7Klxrgs5PX9kEMwDDS6VJ1HlVbfYYYLGJc4ZYjbWi6ft+i6Hd
         dhn4tiaFM70Dw==
Date:   Mon, 7 Mar 2022 13:14:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        tangmeng@uniontech.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH v2] ASoC: amd: Fix an ignored error return from
 platform_get_irq_byname()
Message-ID: <YiYFN7TL8ZpnAM2d@sirena.org.uk>
References: <20220304004543.11797-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vKS5jss5k13JvKxY"
Content-Disposition: inline
In-Reply-To: <20220304004543.11797-1-yang.lee@linux.alibaba.com>
X-Cookie: Store in a cool place.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vKS5jss5k13JvKxY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 04, 2022 at 08:45:43AM +0800, Yang Li wrote:
> The return from the call to platform_get_irq_byname() is int, it can be
> a negative error code, however this is being assigned to an unsigned
> int variable 'adata->i2s_irq', so assign the value to 'ret' concurrently
> to solve this problem without affecting other functions.

This doesn't apply against current code, please check and resend.

--vKS5jss5k13JvKxY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmImBTYACgkQJNaLcl1U
h9Ayawf/UAHZ/XEOH8Ig5XxzKsT6C8R6T0FSBLGJg3y7QBXcXluvNaQQs8kogFjZ
N4MyL9viPZ9zoWVptKZB3wgcJpFfzviuXKemILq0HqY2Vd0LL/79YxvLek/CJFS3
drf/lRSIafH0ZUBIkyhg+y6vf2YWDEJvIh2u/4DLhYGcMaPtq002I1iXg4ok9FMU
WlLWlT4k5y9n/Qhddm2Sq5d4zVCD9SgPf4Rmvi2wJH7xJOHrG6jwZ/dF61ok5SUQ
aqrcd1vDhpHLTAtPRSEIL0Zt0Q5WDdGgW2bBOyJANMeqwz7w93t8BJKrrRSNSpbL
3B1auFFO2XquDL01ePZWTm8Xtk351Q==
=dJZZ
-----END PGP SIGNATURE-----

--vKS5jss5k13JvKxY--
