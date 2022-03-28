Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E153B4E9B73
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 17:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239787AbiC1Pq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 11:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239298AbiC1PqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 11:46:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2D04C7A2;
        Mon, 28 Mar 2022 08:44:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33DA6B81123;
        Mon, 28 Mar 2022 15:44:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5B6C004DD;
        Mon, 28 Mar 2022 15:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648482278;
        bh=bVwuxMR1FNIryjiDvIXdi9f+NUSMKrjmUQq6FdKXor8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I+mXUJEaHR9d0bwysioVzxtU17wrckU+sj8J+vCUMXI3+mZ5IL3NvplD9Tmqliw5b
         VMvY8sWSdaAfTdlY3vPFcCvltz1VT6gS1PDK6Ll1d+24jIse2UPucFPT5IiPARzAmU
         3/wBfa+2+HG5vJWxzLi5SKxBic9jcGA0pgA8D+WgLTFlFSpS5/vxq1J7ULz+V5UOop
         0ZFRvg343SeWzE+1t92wLS7rG5gEUod4BZyzNA5mKCfJugZgfGP8fP3AOOB0BR/wxZ
         tPbEkN3Kdm5UlBelQIZ8q+wvYyun0QmQeLGGdHSGPswXp6/G7clumKRTAks8JFqGIb
         XMJkMggW8YULA==
Date:   Mon, 28 Mar 2022 16:44:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, thierry.reding@gmail.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        jonathanh@nvidia.com, catalin.marinas@arm.com, will@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/6] ASoC: tegra: Add Tegra186 based ASRC driver
Message-ID: <YkHX3/8BbXo4obWI@sirena.org.uk>
References: <1648447526-14523-1-git-send-email-spujar@nvidia.com>
 <1648447526-14523-3-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q6kdKZClj14YwsHl"
Content-Disposition: inline
In-Reply-To: <1648447526-14523-3-git-send-email-spujar@nvidia.com>
X-Cookie: What hath Bob wrought?
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q6kdKZClj14YwsHl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 28, 2022 at 11:35:22AM +0530, Sameer Pujar wrote:

> +	regcache_cache_only(asrc->regmap, false);
> +	regcache_sync(asrc->regmap);
> +
> +	/* Setup global registers */
> +	regmap_write(asrc->regmap, TEGRA186_ASRC_GLOBAL_SOFT_RESET, 0x1);
> +	regmap_write(asrc->regmap, TEGRA186_ASRC_GLOBAL_SCRATCH_ADDR,
> +		     TEGRA186_ASRC_ARAM_START_ADDR);
> +	regmap_write(asrc->regmap, TEGRA186_ASRC_GLOBAL_INT_MASK, 0x01);
> +	regmap_write(asrc->regmap, TEGRA186_ASRC_GLOBAL_ENB,
> +		     TEGRA186_ASRC_GLOBAL_EN);
> +	regmap_write(asrc->regmap, TEGRA186_ASRC_GLOBAL_INT_CLEAR, 0x01);

This seems weird - we resync the cache, then do a soft reset (which
presumably desyncs the cache) and then explicitly restore a bunch of
things (hopefully everything that was in the cached state?).  This is
certainly very much not idiomatic and looks worrying.  Are you sure that
the device is getting anything out of the register cache?

> +static int tegra186_asrc_put_ratio_source(struct snd_kcontrol *kcontrol,
> +					  struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct soc_enum *asrc_private =
> +		(struct soc_enum  *)kcontrol->private_value;
> +	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
> +	struct tegra186_asrc *asrc = snd_soc_component_get_drvdata(cmpnt);
> +	unsigned int id = asrc_private->reg / TEGRA186_ASRC_STREAM_STRIDE;
> +
> +	asrc->lane[id].ratio_source = ucontrol->value.enumerated.item[0];
> +
> +	regmap_update_bits(asrc->regmap, asrc_private->reg,
> +			   TEGRA186_ASRC_STREAM_RATIO_TYPE_MASK,
> +			   asrc->lane[id].ratio_source);
> +
> +	return 1;
> +}

This should only return 1 if the value actually changed, you can use
regmap_update_bits_check() to detect the change.  Current mixer-test
ought to spot this.

> +static const struct snd_kcontrol_new tegra186_asrc_controls[] = {
> +	/* Controls for integer part of ratio */
> +	SOC_SINGLE_EXT("Ratio1 Integer Part",
> +		       ASRC_STREAM_REG(TEGRA186_ASRC_RATIO_INT_PART, 0),
> +		       0, TEGRA186_ASRC_STREAM_RATIO_INT_PART_MASK, 0,
> +		       tegra186_asrc_get_ratio_int,
> +		       tegra186_asrc_put_ratio_int),

Can't the driver work out the ratios based on...

> +	/* Source of ratio provider */
> +	SOC_ENUM_EXT("Ratio1 Source", src_select1,
> +		     tegra186_asrc_get_ratio_source,
> +		     tegra186_asrc_put_ratio_source),

...the sources?  Or does it need to be configured before either side is
ready in which case this might be the best we can do for now.

--Q6kdKZClj14YwsHl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJB194ACgkQJNaLcl1U
h9DJPQf/TvXk6oi+ijY9O9IQ133Gu9xWGWV+7fiQYkIlAtddglEabfYOJxtLVKuV
xgm5SIaEfWvUPj3kevurFVLxyTvAZhpI8KfamsiUlRKjlK6IkKEsfx6yhYY9tvLn
6QDMj18+mr1VrQNDyrlFRpuV8anPmnuHmXAJBb3gM4HSxM48Dn0uQyLgxkRwL9Ke
X/j54DAQE8SAlTMafIfz24xWmojIyEyEY6CHIVrxfYqhJGIv24fQoIgA9P+b1vMW
NmIlXb4oJ+TveCsUJBwRiwRzV8TIqoErgLkcReVThoeIf5yMz2smnJ7QltwRb+QN
8BxNA3n76o2Idu8GGTH3RLmDwzHjhA==
=G6cv
-----END PGP SIGNATURE-----

--Q6kdKZClj14YwsHl--
