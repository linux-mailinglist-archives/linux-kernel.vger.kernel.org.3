Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A7D508E67
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381083AbiDTRac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381056AbiDTRaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:30:30 -0400
Received: from m228-13.mailgun.net (m228-13.mailgun.net [159.135.228.13])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 80E0B46678
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:27:43 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=codeagain.dev; q=dns/txt;
 s=smtp; t=1650475663; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Subject: Cc: To: To: From: From: Date:
 Sender: Sender; bh=WXXXW89y+QcFXfQJ6sbWfqbkXidxsm82Hd4VQkHn9TM=; b=c7x3q4cvmHRgqtUgLvkWLF4bGx6BzSGfFnCvZ86EtFUExbt4FgyFgm6L34jMwXdMFr2Qu/Wz
 uHZ1II/8jwaaI6/u6tz7t07R+3XYN4x2SAILqsbuuhEhvLoVQGXYTwkIDhZU39tvpeudL3YQ
 5HSYieGplxs2nTl/4uVXynTYIMVSxpQToFaYgWhgbFfqsZn1stdCV6TbdTWbDGGQvl4xmwSD
 QDkiBxHprbSXZvNdXvIGtv4u3YevwmRnIytk9ydNBQjyd8/uyuJg4i4p2FfTH/BRzmG7maUR
 wTuMop6QMGYXrGAI2l7vuC00EC594V6QHM5L2FzBr6HpfmTI3KVFVA==
X-Mailgun-Sending-Ip: 159.135.228.13
X-Mailgun-Sid: WyJkNDU4NiIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWM2ZCJd
Received: from AN5Bruno (dynamic-user.170.84.57.33.mhnet.com.br
 [170.84.57.33]) by smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 6260428d514839a8197fb290 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Wed, 20 Apr 2022 17:27:41 GMT
Sender: codeagain@codeagain.dev
Date:   Wed, 20 Apr 2022 14:27:31 -0300
From:   Bruno Moreira-Guedes <codeagain@codeagain.dev>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Bruno's Patch Watchbox <patch-reply@codeagain.dev>
Subject: Re: [PATCH v2 0/2] Docs: Update information at changes.rst
Message-ID: <20220420172731.ru7kfrdkmprybtu7@AN5Bruno>
References: <cover.1650376049.git.codeagain@codeagain.dev>
 <8735i83xo1.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7gc4pk3xhyxkzqh5"
Content-Disposition: inline
In-Reply-To: <8735i83xo1.fsf@meer.lwn.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7gc4pk3xhyxkzqh5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 20, 2022 at 03:35:10AM -0600, Jonathan Corbet wrote:
> Bruno Moreira-Guedes <codeagain@codeagain.dev> writes:
> >
> > The PATCH 1/2 fixes the missing cpio requirement, while PATCH 2/2 fixes
> > the kernel version reference.
> >
> > Signed-off-by: Bruno Moreira-Guedes <codeagain@codeagain.dev>
>=20
> Patches applied, thanks.
Thanks, Jon! I have also been thinking whether this filename
('changes.rst') is a good description of the file contents. Do you think
renaming it to something like 'requirements.rst' and updating its
references would be a good patch?


--7gc4pk3xhyxkzqh5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQTUrsHCxGmQ5vyKRAZtd3tyEY2kgUCYmBCgwAKCRAZtd3tyEY2
kuLWAP0dXCyqGEKvy9lN8fHENyzVin2V+xVzNahalr1kWHsangEAhBgOwZx6wbuj
85Xnz6TZqI6h6E9MUUAtaezbbS+j3QY=
=bzsu
-----END PGP SIGNATURE-----

--7gc4pk3xhyxkzqh5--
