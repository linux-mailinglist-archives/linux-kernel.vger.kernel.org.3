Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B5A4F678C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239415AbiDFRil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239397AbiDFRhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:37:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262A01AAFE7;
        Wed,  6 Apr 2022 08:45:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A40F661CB6;
        Wed,  6 Apr 2022 15:45:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF83C385A1;
        Wed,  6 Apr 2022 15:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649259947;
        bh=41EacShtWzCQoGg2CSmxYcgHNKQSLGqlvRwMFYBUpvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jFRZKXLRdlHi0dRk6ePkDwGBnWF2iSNJFfLPGnKTZGszofWUkHIu5xsdjBMStB1QE
         OJa6QDnjTfXJFwtF40el7QhEIpnzghQyWNlWK0uctZ/mAJsa7Nn8HnSqNnyRGqwaFs
         HNeB/d64ew8quKjSKAS6DM0TX9/k8URkBtHGIDbTFMakUL1P5sW2lYScR5yB9zsqgA
         RUGJlnZhmbw5S6vg63yCAdWqVDkrTaZmLU2KKbmuT0FDED4CgDYlhVyhyufEAKMUG7
         GosuUkUyIZynNWBdxHUUS8s+vD6uusEixc2ch9vEODpxs1Sh7eEyt0cu5EAwOSBIZ5
         Ok4IGniHcReVw==
Date:   Wed, 6 Apr 2022 16:45:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_jprakash@quicinc.com
Subject: Re: [PATCH V9 4/6] regulator: Add a regulator driver for the PM8008
 PMIC
Message-ID: <Yk21pdu16lyR8jXm@sirena.org.uk>
References: <1649166633-25872-1-git-send-email-quic_c_skakit@quicinc.com>
 <1649166633-25872-5-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n53G-atsuwqcgNvi3nvWyiO3P=pSj5zDUMYj0ELVYJE54Q@mail.gmail.com>
 <Yk1B4f51WMGIV9WB@sirena.org.uk>
 <CAE-0n53Cv_bR92M64dhdnDge_=_jeOs4VZzDhUkksN90Y7rgog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3o4D9CnC8BckVjL9"
Content-Disposition: inline
In-Reply-To: <CAE-0n53Cv_bR92M64dhdnDge_=_jeOs4VZzDhUkksN90Y7rgog@mail.gmail.com>
X-Cookie: Look ere ye leap.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3o4D9CnC8BckVjL9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 06, 2022 at 08:23:11AM -0700, Stephen Boyd wrote:
> Quoting Mark Brown (2022-04-06 00:31:45)

> > It's a MFD function driver isn't it?

> The DT binding shows a single i2c node at i2c address 0x9. The
> compatible for it is "qcom,pm8008-regulators". It looks like an i2c
> device that is dedicated to providing regulators. I'd only expect to see
> an MFD if the device responding at i2c address 0x9 supported more than
> just regulators.

There's a MFD parent for it, and if it's for an I2C device for a pm8008
why would it have a -regulators in the name?

--3o4D9CnC8BckVjL9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJNtaQACgkQJNaLcl1U
h9BeGwf/d1110LzQUHbbuM9dmnSs/NoOYGR7DD9LaHmEcDNScYih+K4ljBOvoooc
tUpvkxD79KZMEijjxH4qVrqPIVHR0FErPqSbQxd/WF77c4q0gwK8l46zOa647ft+
yHMBUIhnX9M0tHmdAZ4vAtAchVu2hJBfZ+8LBOTpinth8WlDyV02sywfOkGVFhrR
odiV1qNHpJohMKkmrTr6581MYqGXkKuvL3E9f4bs7I3ea2SFufZ2pgQAo+4EljY4
Y43biQwKHsuP97ReGraRZ4Y0aX18yEYQ4rWFQJSrOl+WMfkaH476lk4fMNx4MJHX
q9bauCXdB7jxhR0gvnLDIY8yJ/J/vQ==
=0flY
-----END PGP SIGNATURE-----

--3o4D9CnC8BckVjL9--
