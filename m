Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A434D2EC9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 13:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbiCIMLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 07:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiCIMLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 07:11:43 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C72315723E;
        Wed,  9 Mar 2022 04:10:44 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KD9y96mnlz4xv3;
        Wed,  9 Mar 2022 23:10:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646827843;
        bh=ZAwwIsaomuUk3Ev0XnTox9yb5+TIyOgHAjQzDFuNUV4=;
        h=Date:From:To:Cc:Subject:From;
        b=q9j356HvUWIEV68AUp2ePGkaoptePie2k0kOQAObUkbcWOV/Ld2Jrmh5mlAfRD6jw
         IF02p+8Lev/sCbTgFRcFVSQZUDTO76szqGn40O7YOKZVriDtsKEgEbhDiLONScTHKw
         xktAC/0VyMYWTJG5/Hv66LhhXVZAhITDjG3Y9YLlGoqiUWn+76nHsbNOrhpKRmy5hz
         O7l8AfaVfsii0OJykmkT2oEQZpIVaQxig7ofr2cgeFRTr5JW/du5Ww5NYdXz9M2CLZ
         +HyFwbqI2nDP+UP1rdzMvRbTyiaUTVkYHDSs1p8M2wX32uQwxaTI5guosHJ9YMZjBz
         fAJVM+9i6en3g==
Date:   Wed, 9 Mar 2022 23:10:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Gross <agross@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the qcom tree
Message-ID: <20220309231041.22fd158d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.wv7_eMo32=XtcqPAUJOnfr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.wv7_eMo32=XtcqPAUJOnfr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  ea58caed9926 ("clk: qcom: smd: Add missing RPM clocks for msm8992/4")

Fixes tag

  Fixes: b4297844995 ("clk: qcom: smd: Add support for MSM8992/4 rpm clocks=
")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed for the future by setting core.abbrev to 12 (or more)
    or (for git v2.11 or later) just making sure it is not set (or set to
    "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/.wv7_eMo32=XtcqPAUJOnfr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIomUEACgkQAVBC80lX
0GzZmAf/TUG/L5+Sj7ywSTC7/ohCEBr5Gq608RhLLRpSBFHfYANiyiNROoQpYdZq
nQJzGk2m8dBpcopwez8ow1EGUn5HQgZpANwEkd+aaxfvXCpuot/3DYXPbPAVnjTW
YNOrRGz4UbWc/ZYOpTmqITRY6Y6SsMJZON2aDbSyI6COqujlKXWGlNBippdzRz5F
nAuWSWCX6fcOPaDtASCa9RW9N8wxqMgy4IOK0/pwal/L1+XOdlgF/3hAjt1fiztF
onIrbQHHtBGshx64ggYq1hnAMsUIvPwZ1XeS1uN6iyeFoXbgcvGsDrgUOj20OiVN
Jdybt0qA4QZU28ZolnNO/XDN+d7qOw==
=2mzH
-----END PGP SIGNATURE-----

--Sig_/.wv7_eMo32=XtcqPAUJOnfr--
