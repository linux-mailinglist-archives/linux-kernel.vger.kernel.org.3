Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E0848FD49
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 14:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiAPNsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 08:48:41 -0500
Received: from mail-0301.mail-europe.com ([188.165.51.139]:45007 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiAPNsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 08:48:40 -0500
Date:   Sun, 16 Jan 2022 13:48:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1642340915;
        bh=bwU6pvleZwgGVAcnFlHXD7WXvOTQdAfgrmW5sho68S0=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:From:To:Cc;
        b=cMTM5ffj7jf+s+7f9hZyDASuf3zOTHYMUMbyQMjVkYYG4kJxGMylBnHudVkfdRIEI
         PDrMAKaQuJvJBa85bUhy6emrGMLfAjjNsp87bhg34jK551j4L2zlwA61e6wVApOVSq
         Ug9an9AU1ZA80jWV+39vBd0mEsl7CiQrm6yRl2v3gdBpO+J8HoCM9edM0QHpDQ8gV8
         1QGrBvcnc2zk3Uc62lckZnKx9V4XS07OZalNe3i1b9rPDjIsXdG1vNW9JaOmomARxx
         Q3qRkhognFC+ZddmI7lLGolB3eRWKiGGXSeKVrr9dIU6LFtwKwjHrS0vDtXdj2VJEi
         td4OgnYbfriSg==
To:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
From:   Jari Ruusu <jariruusu@protonmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: Jari Ruusu <jariruusu@protonmail.com>
Subject: Announce loop-AES-v3.7w file/swap crypto package
Message-ID: <8LUdOFjFwCBEYnY82H3a1lkMp0bcXSZs4UNYBpQP9lNigJqB7tnq6OUQR5LB4Lk1eus6P2XpWAlzbTBGc1RJNpkwD7dIED07P5E1N87YL80=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

loop-AES changes since previous release:
- Worked around kernel interface changes on 5.16 kernels.
- Silenced switch-case fall through C-compiler warnings.

bzip2 compressed tarball is here:

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.7w.tar.bz2
    md5sum b0d091656ee091d7a8f74ef2a54c0520

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.7w.tar.bz2.sign

--
Jari Ruusu=C2=A0 4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD=C2=A0 ACDF F073 3C=
80 8132 F189

