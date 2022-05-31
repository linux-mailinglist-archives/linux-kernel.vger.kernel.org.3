Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EE2538AD6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 07:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243972AbiEaFUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 01:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbiEaFUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 01:20:53 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6149633E36;
        Mon, 30 May 2022 22:20:52 -0700 (PDT)
Date:   Tue, 31 May 2022 05:20:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1653974448; x=1654233648;
        bh=Qn94Rdc6z8iOr5MWW/k9CeWfMnXEwDuKIt92qILF4Ko=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:Feedback-ID:From:To:
         Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=xhqx5oqPSqCAIrshNn59bwStEkXdY4e+3Iokt/YXaetl3MEJtj6HSHDyFSloPTvUM
         oc9Nhe9taqzjKKD39mJv6i2ROZ3gLrshU2dtlP2Y7L+6Y14wGoez4xEnzYlA0CtS/l
         tFwyo2pPE6eVnrOvRDveVZS/Sd4i+fTTT5bmRxXLVi0wb/gtYr812R1g5zU1JsD/RX
         LitBSySXWDnWrnjuxCVxjwERA7ZRIH3DhYxPHqyixhgzJ6gblJYpCrV4cEQpECfjr+
         RDUOBhBm8jg1t7fdwRppzR0j5uhdfLwAPrvrxp/gFXGTMi8dEWY26PqfUfcm2ue6FC
         CJdxINXd/qXeQ==
To:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
From:   Jari Ruusu <jariruusu@protonmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: Jari Ruusu <jariruusu@protonmail.com>
Subject: Announce loop-AES-v3.7x file/swap crypto package
Message-ID: <nuUFwoZpQ2tOf6CnoMYyxyQEEaU4aBm7kwfn7OjPfGeAfRvzs6TU9l81DT7wt2bRw1ryTMtqBNld6qcVKDpSPktSGz1uDDviPZsY3uFr1Og=@protonmail.com>
Feedback-ID: 22639318:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

loop-AES changes since previous release:
- Worked around kernel interface changes on 5.18 kernels.

bzip2 compressed tarball is here:

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.7x.tar.bz2
    md5sum 0e1ca8602d064f7d8c64f2dd47b661fe

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.7x.tar.bz2.sign

--
Jari Ruusu=C2=A0 4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD=C2=A0 ACDF F073 3C=
80 8132 F189

