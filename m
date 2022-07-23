Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD8757F0F0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 20:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238083AbiGWSfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 14:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234991AbiGWSfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 14:35:38 -0400
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 23 Jul 2022 11:35:37 PDT
Received: from mail.sf-mail.de (mail.sf-mail.de [IPv6:2a01:4f8:1c17:6fae:616d:6c69:616d:6c69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CEF11C21
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 11:35:37 -0700 (PDT)
Received: (qmail 5608 invoked from network); 23 Jul 2022 18:28:33 -0000
Received: from dyn.ipv6.net-htp.de ([2a02:560:57e5:9000:d178:e8e0:1215:6c2]:54918 HELO daneel.sf-tec.de) (auth=eike@sf-mail.de)
        by mail.sf-mail.de (Qsmtpd 0.38dev) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPSA
        for <shorne@gmail.com>; Sat, 23 Jul 2022 20:28:33 +0200
From:   Rolf Eike Beer <eike-kernel@sf-tec.de>
To:     Stafford Horne <shorne@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/4] PCI: Remove pci_get_legacy_ide_irq and asm-generic/pci.h
Date:   Sat, 23 Jul 2022 20:28:53 +0200
Message-ID: <2212080.iZASKD2KPV@daneel.sf-tec.de>
In-Reply-To: <20220722214944.831438-2-shorne@gmail.com>
References: <20220722214944.831438-1-shorne@gmail.com> <20220722214944.831438-2-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1921665.PYKUYFuaPT"; micalg="pgp-sha1"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1921665.PYKUYFuaPT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Stafford Horne <shorne@gmail.com>
Date: Sat, 23 Jul 2022 20:28:53 +0200
Message-ID: <2212080.iZASKD2KPV@daneel.sf-tec.de>
In-Reply-To: <20220722214944.831438-2-shorne@gmail.com>

Am Freitag, 22. Juli 2022, 23:49:41 CEST schrieben Sie:
> The definition of the pci header function pci_get_legacy_ide_irq is only
> used in platforms that support PNP.  So many of the architecutres where
                                                              ^^
> it is defined do not use it.  This also means we can remove
> asm-generic/pci.h as all it provides is a definition of
> pci_get_legacy_ide_irq.

HTH

Eike

P.S.: recipient list trimmed because of unrelated KMail bug.
--nextPart1921665.PYKUYFuaPT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSaYVDeqwKa3fTXNeNcpIk+abn8TgUCYtw95QAKCRBcpIk+abn8
ToSJAJ4zgKghB8MWnJBGKc6gkbY4S34LggCdGRqsBaz89xgbeKDkbqt9jTSnbBU=
=onFn
-----END PGP SIGNATURE-----

--nextPart1921665.PYKUYFuaPT--



