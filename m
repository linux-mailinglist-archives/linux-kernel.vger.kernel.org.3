Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6933531690
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiEWTV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 15:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiEWTVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 15:21:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFB96D877
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 11:57:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDF6261261
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 18:57:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC736C385AA;
        Mon, 23 May 2022 18:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653332232;
        bh=879aFF9uyZobIk3fQF2c9wXlxyMRKkOB5AS/hxoLmCQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OZ0Fz27lmYi9vc0z6gjxUs4iDf1yXVgq8phBOCOq/XLnnMfEpeUbbvfwLGQGlQr0P
         rpTAzxje0YupT/MeWjRDu5yO+t1hNCJFleqS/kkt//Uifpodnl+djn3OIO7BDxGnYF
         PKusv/w5+29LXPpNTkM47qlY6AV4SL4JATD7mmwtgOx5HXOpkiz81PZhtnk7FDfGTA
         eIyhEMm4qCOibkpCj7t9twTy7XWrNWlPD77CFocHB8qI3fgz1QSy6WollY478qtPIk
         tZDshiU96Q4nQy3fo/6aYmk0Z217b3JKakNw8oMEIdXG0w2vWmhDveIt9Qup27f5lX
         UPBQ3tMFudFow==
Date:   Mon, 23 May 2022 19:57:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Olivier MOYSAN <olivier.moysan@foss.st.com>
Cc:     Tang Bin <tangbin@cmss.chinamobile.com>,
        arnaud.pouliquen@foss.st.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, alsa-devel@alsa-project.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: stm32: sai: Use of_device_get_match_data() to
 simplify code
Message-ID: <YovZAf4S0XphBsco@sirena.org.uk>
References: <20220519124235.21100-1-tangbin@cmss.chinamobile.com>
 <69d5cef3-57c0-9bc7-a83b-a85ef1c4cf29@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="D+p6NkMZHcHp/pjf"
Content-Disposition: inline
In-Reply-To: <69d5cef3-57c0-9bc7-a83b-a85ef1c4cf29@foss.st.com>
X-Cookie: Sales tax applies.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--D+p6NkMZHcHp/pjf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 23, 2022 at 03:28:48PM +0200, Olivier MOYSAN wrote:

> The current patch requires a change in the driver.
> Either changing STM_SAI_x_ID enums, or replacing data by a struct.
> For instance:
> struct stm32_sai_comp_data {
> 	unsigned int id;
> }
> struct stm32_sai_comp_data stm32_sai_comp_data_a = {
> 	.id = STM_SAI_A_ID;
> }
> struct of_device_id stm32_sai_sub_ids[] = {
> 	.data = &stm32_sai_comp_data_a},
> }

Either approach works for me (or a revert for that matter).

--D+p6NkMZHcHp/pjf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKL2QAACgkQJNaLcl1U
h9DuAwf7B4DIzNtZ0XzfzZJZ+4+f3o1jf4181qlohJddMInl8qu8NI3UjsBmG/6V
kbnPnNFNA8Dt0Y4M/1Qgsux2KKSf71TBiU4F0u1sLUWdmfmevcRSb3dDryoOxnhe
y1ztzF3lErZxTRTpbK0fhud5x3CQuOpHVtY0NsOmB3nAtOcebC7Y+NsV7duG68zR
FWHJUlYGhm0+D3EambBVFiT6hYxgMNk239MLMBCSLbpCaZTCj+9q0RCzYmG8F17Y
pzmwNKfe1F9xoWVWBgxz/EA5o2/jebc75dUdjLfz+y0eCGaHEYnugd6/cFSWLeQr
CZYC5j7tJ4vB8J7WFGhYwA+xMvoL8w==
=UNvf
-----END PGP SIGNATURE-----

--D+p6NkMZHcHp/pjf--
