Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D3E4D98F9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347174AbiCOKmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347169AbiCOKmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:42:22 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3AB506E9;
        Tue, 15 Mar 2022 03:41:10 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KHqh438Xbz4xNm;
        Tue, 15 Mar 2022 21:41:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647340869;
        bh=RjFJmXH6IA0N3FVtyaPB9cyP/4A8Z1CtKfNY3KyxfMM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rrvTTtucA5oLJJIat8mBZU9RC6r/1MI6nxSsybiWMqwZTFrPHpPljXbdRlGfDQ7g9
         USo/cJlCd9wBAz/enNVgxLNKTrnKxPeFfCRYqR7HiQbhaMC2iPsR/tdaUK9ed4xu5R
         nqUQPk7BQCp1Ho9x1/M7moofRHEj2kB7K7wrgUQxMNZTcC5k82cTMVLHF6P+WH1v2p
         ljl7+6fmwx5oYsuLGVEtjVu+rKjCHWgh+kiLTWgqlY0RYTbaf61hxrULisgtU1IQO1
         Do0iCI5wIwbyXYOBlmn8suCLFbwmYxZGRTPXghiMhxfKsS+L6IaExvfp9D+rqHtyOv
         YpS80TnySdy1g==
Date:   Tue, 15 Mar 2022 21:41:07 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the tip tree
Message-ID: <20220315214107.4568a949@canb.auug.org.au>
In-Reply-To: <20220315092219.GC8939@worktop.programming.kicks-ass.net>
References: <20220315140644.369d98d6@canb.auug.org.au>
        <20220315162327.53f7139f@canb.auug.org.au>
        <20220315163747.3e11ad15@canb.auug.org.au>
        <20220315092219.GC8939@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vH84N1wp83rkD/uMB=IbbXM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vH84N1wp83rkD/uMB=IbbXM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Tue, 15 Mar 2022 10:22:19 +0100 Peter Zijlstra <peterz@infradead.org> wr=
ote:
>
> Almost, it's this in combination with a follow up that uses it. I've
> just managed to beat it into submission, will hopefully be cured for
> tomorrow's build.

Thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/vH84N1wp83rkD/uMB=IbbXM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIwbUMACgkQAVBC80lX
0GxG3wf/UjoJ6iXMtCRn2W1gD1Z0F82xen3cb52JX3wAB/J4OK5QR/RnISqhQRz7
KsH76q2H5LCs2+fbnq7Tg4Rv80cAEFnFGpjw8MofSvzoV7gapHATBhMR52ykhpn0
LS1ydUpx4TqlfPgrlU8RmhbnwCFYMZ8rcVYZszKy3stR9ykq47e1clEgKv+kkAhB
mKRCFAvJQIJTrW/qMTIOjGwSFQDfemiOZEvWGDN4sKHEg1Ajk5QSnfAeaY43Glxo
4N4Ebf+zc0USBs4Y3CElMpJ/DdGVu+a+6RnFni3fTdrzdnplOF/Z3RRMUquAK5mI
yefMr61zyg72+wyq0qpBOCY1kjZZcw==
=9cu9
-----END PGP SIGNATURE-----

--Sig_/vH84N1wp83rkD/uMB=IbbXM--
