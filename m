Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB214A7119
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 13:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344242AbiBBMy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 07:54:56 -0500
Received: from mout.gmx.net ([212.227.17.20]:46767 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344246AbiBBMyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 07:54:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643806493;
        bh=WRVN3BlGhrYJ2hDYSDvlgTraCSrMYSaHLg4/ooc3xLc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=d1NFuz9AMPYS16tXGJNupOwJREnZAUOukweJ7C7/JuX8gxwzZYduZbDgVxfttH8G4
         wzKGbiw6RteXDHocRk73pqD5LHk1ApJ96eJng56K6j1IktNcl/O7fu50Gav4CkmfY/
         bSlKnNcrazrLD88DwsTXMSZW5osDj6PRc9crymLA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8QWG-1nApJ63nxQ-004P4l; Wed, 02
 Feb 2022 13:54:52 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 0/2] Fixing the compile-test warnings in pinctrl-npcm7xx
Date:   Wed,  2 Feb 2022 13:54:36 +0100
Message-Id: <20220202125438.19345-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7glLdjVidDXKYvA7rh32xSpTaodXZIN4/AAX/UUQc44J9+3XhcZ
 GJ9xwySyJkTGkTBq2N4d0NULN71a6rLYTDdxMSaqPpG2OJFbE86mtDDUi8/Uf01QP0mQE9d
 3MUGcN80Z5cLME0onWyYwMnshf7Ux4gqu5e0dtagdjCNMKmZIYOFJpzOcSqSPzOWDuo6bfw
 SuGA7zA31PlsqNQ1tXA1w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ywwEcjU9F/M=:SsjdxaNV1jDrJ5JQKl4xlX
 xLWXIjuGpS1El7RAbsVnz6Ydt0pCkOIuGwp9NiLUZPgWHgTCcQG51rYc33SMyaHMtwjcsb7GA
 suXnwCyRnjv4NZ9CWAvhupK/9AOQajagutdBLwLbCYjPo3hDKqQDO2wsMn5xhJCtp6wQSga3H
 QS2WSE8kFHL57W7q0q58bpReqloqJrWHl/M4AM4n6kMtBrSJoIX/HMQ8NqAavMOrmmIUwcBli
 tpLvvWxRqYOt2c8p0FTwJ12iNVINfkh20kkIa7Htl1IzwcfYZctFiPk71j51u1QPxXBhIVAKy
 DbU27DOWLOgrlPUfrmgETi2q5iCc+xfUcMUsDfD7AQkVvxVZJmpfOt4/eNoAMb0AUDV0q0H1i
 FWqcAjhxnl57jkSi4Enr0uImrhc3UYQrnsceEDRsymF6589ffSC4mUwXbwkYVYfOteWoAZHD+
 q5PaFon0vhEXM2FSrXFOOD+QcA2GdJ8VeOEIFUTau2G5UFommTuq7BeQcKb+DI7pY8u13rraL
 6t7GLXYiZB8Yf7NjrcrQv+HinBBlbLm4H9YZQpXpzs9B+YtC4KKjdsXrx9JOkZf+rtt+uawx9
 Ez9ZMIdqcT7300puzetPDav5CQdhiJ4jMfPRypGM/KH2Bs46sPh8VWU5EqnxINeF5i+9dqsRn
 lZCiOOhP3vzzlUE1jetHbG6oirmnRsIFQAxCKd30kAn/MG+kwvnVKWRRlifPTEKMusTOZuJlv
 vwH60UXX+ettucE31eO9uWHOMyl1LMQuaS41deqcnrlAvW5xgD7bYMtnr54DOFkJbPiVirCI9
 CEF9tAu91sG+M8M1HYX3LRQ2rZ6j3Xr9gZXVA5nVvcYmvVzzaXjsCwPD0QayOjRnCt/EWtnCv
 Q2k/zLmvgpMXKY4CcwBdn2CwWETWJQWwLC6GsE/rIX5Ax+YCYmXhxzo0l462xj+QB5MCNS/Di
 /2ffrdl5tHesYxuGoZxrY+Xc7TPdVMYiqDoTYWxrobFQ5574/sMVEtJkB7n4FB/zuKKUtTjvs
 LMcepZuZlLvAmU4MPzv8exDPviZznvP9sXId0V6Bfsqp7Zpm/njq+jmPRzTPLR8IoHkv1wx7c
 CpyYddv+SRZCog=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My "Nuvoton WPCM450 pinctrl and GPIO driver" patchset brought two
warnings[1] in the pinctrl-npcm7xx to light. Here's an attempt at fixing
them.

[1]: https://lore.kernel.org/lkml/202201292234.NpSNe4TD-lkp@intel.com/

Jonathan Neusch=C3=A4fer (2):
  pinctrl: nuvoton: npcm7xx: Use %zd printk format for ARRAY_SIZE()
  pinctrl: nuvoton: npcm7xx: Rename DS() macro to DSTR()

 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c | 160 +++++++++++-----------
 1 file changed, 80 insertions(+), 80 deletions(-)

=2D-
2.34.1

