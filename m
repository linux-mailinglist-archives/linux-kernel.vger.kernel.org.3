Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13D74AA9C2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 16:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380278AbiBEPxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 10:53:49 -0500
Received: from mout.gmx.net ([212.227.15.15]:57835 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232649AbiBEPxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 10:53:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644076426;
        bh=YfZya6X96vYqsQSbwTEIIDVkJz7pOxjH0XPmxKVtP4c=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=dPDgE1aSRR/41j+ZA9J8g1iYMK5bMtQ1poEPSCDWXD+EATucY/5J19EGjhjT3vq6V
         BaWZ6UA3fyIu5zuPD8Wcsyb4cimV/imoLnI3Eg+tYzgEc4pBG0CTE/P6zGx5Q+2dEf
         GfT7W+V8ZMNU2Ev7opyc7eAQ+ev6bEYfWuxb5nlw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([87.78.182.239]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6bfw-1m8T5g2yCs-0184b5; Sat, 05
 Feb 2022 16:53:46 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH v3 0/2] Fixing the compile-test warnings in pinctrl-npcm7xx
Date:   Sat,  5 Feb 2022 16:53:29 +0100
Message-Id: <20220205155332.1308899-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sQIjNl+kSem/HXl/drlvCq2VP+JrSIjz9yMQmmGIa5ddgt5Tugh
 7J7S7ZBoQrBzAqH9Hn9f8P3lT2Cqcqo9JH02wF9iJLe937qv9A6UW3ngOItP7tSUVw3vIrx
 5lBDYgvbuSdUgoSpdMeX9cIKL2Ug4FAC/xDb2m2UMCoVShbPfLhu8khE26bLkWaOcEnJ2iy
 aPNo3Z0iP7FXPuCrBDY0Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:om3+7VNlD0w=:T8T235ZzZHJ20wXBnlo5IH
 kYK3rruw2X/XRMetbZ0oD3Eu+LIZSbmRi50E2OSOTiTTXipUuvjTqtNZoNd70AgDvCeW+AUNw
 OCw/c4HG0nmgTZbjb1Mrel9RkoTpvBYz7DZJSAhxI6R/oykmhArxvkKtEGsRS62VGy252IjQh
 xN/kyi3l6eKuCTbaU5Tsk7TZZfwy4YkzEQjJukxVnjRVn3JoC8PVVz3EeUfUj6++62TJ8CMxz
 6O+gsU2DxiuiHcqlVvAZLfPX+3DIz6Iol1l0PVb1Wy0msnjmkcASgjrbR6Vr1w/hcYVIqzTEJ
 MVfEzdHpAVK78JmGk+Nq6orF60+NiTyZhljWohL3Q/vRi0COk+PcDO9v/mHg7tc47J7ICQjHs
 v41AXXmB90ux8KR5oq4X/iQx+8f0GtJLeceKH4Rlx91HC/V21cSPB65RoLe9tES96lYLTUH7Y
 ZqNuSxX5H5CLnD5ei35bgB5qWGybcxiYKs4U1h5eAwYJP8JxsEn2Qq5s4JFJXeI39nbkrjdw4
 RpyWvnn9zHHQimdub/j7xEdkQ/akYQ2BX4FqrmtrfF3QMevOv9oDSmij2ND+yp0+j6Ef8vVLL
 HMY0m9n+86R5GSRSrLLZJl+ZjBgqNSnOfAFjSYMmqLepbnjfznB/7I4OVEFAD891s9xN6lxSe
 aIuFUfmQ6NtdpMaOn5j3dsSplC+vyaskD4J3r431SmFnloapdLMs9sMlnn240QEbWiT4Nh7OL
 TmMhMzVIKdeHgl2wMM27WJBd3coPb4RD1rwN/rCPoDaAqz6/9GKM8RfAHh23pfqnfRizMBpu2
 oqzU0gvmeSJRxurisSH8h8sGa1GxPkDkdQdZysy9uf3o/qj9xI1VjFPh06JVrOG14fgBCdE9s
 oSqgWWQEkRRDBRpYC5JihIXAmxoiHbmgW5INRjyHwBPC3nGlrfcscIPE5sFKToFA/jDvs5XiG
 0K0MkLlRLul1L5matJvxNQ3F/nvKC10bhli+E+yyEngKHC98hD2P7Qo7Y9kn1k+GKcUga0PmE
 CjjyaTn2A3gJqCq1zKI80AfQRBW2YIy0skRyPhv61K1m6WOjM2rIZbSch5sCeiIi0XNlQqMKi
 swXe8A8yyKEb0o=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My "Nuvoton WPCM450 pinctrl and GPIO driver" patchset brought two
warnings[1] in the pinctrl-npcm7xx to light.

[1]: https://lore.kernel.org/lkml/202201292234.NpSNe4TD-lkp@intel.com/

v3:
- Changed to %du to %zu

v2:
- "Fixes:" tags

Jonathan Neusch=C3=A4fer (2):
  pinctrl: nuvoton: npcm7xx: Use %zu printk format for ARRAY_SIZE()
  pinctrl: nuvoton: npcm7xx: Rename DS() macro to DSTR()

 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c | 160 +++++++++++-----------
 1 file changed, 80 insertions(+), 80 deletions(-)

=2D-
2.34.1

