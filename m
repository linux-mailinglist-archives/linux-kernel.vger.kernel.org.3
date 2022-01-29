Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E88A4A2D7B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 10:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237400AbiA2JwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 04:52:11 -0500
Received: from mout.gmx.net ([212.227.17.22]:58109 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231812AbiA2JwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 04:52:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643449927;
        bh=7txWuC+cxLDcHk5GOkyqFF+HK5YNAy2EVa4xiw1MfaY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=S5KaH4mX/syRN0z4KBxI5n99XBBGLaFONztzXq0kfvIiQS558ECiciNRMNyJvSn6h
         hiCFBFV8F1SeUA6/gx2IeR0dtZUTKLdmxFMoVjq6wzAOePS8/RXTvJAza4dhqKvNLU
         2yOVGC005H2YRKlWiVJbKkuWmKjYSvayXe4E8Mnw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYeR1-1mjLMK3DxD-00VdZd; Sat, 29
 Jan 2022 10:52:07 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 0/5] clk: Declare mux tables as const u32[]
Date:   Sat, 29 Jan 2022 10:51:53 +0100
Message-Id: <20220129095159.2202366-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VMtroBv0nDy70kKkvtsscxItTZO+E/vHQlpHdQejS/3+/+SaWBb
 MU2GNTHebaxr0JhwnlK7BayTm9zNyTloxTzgzELfm3iRzdVgI2J8P96zR+QGyXOsSfo84pp
 NcrcQtEzwD367B9yimU1yqlJveI9INZD3Ri7rMCwDqD69IQ3u7Fj213TAdKwTWIRUiCRkbA
 nQwF4kWu3/KzgwXPkv96w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PmWkQYuZqNw=:nGhauw4gD3+PyjJvPeLWPx
 yYMYzWaRtFuaHiToQy0l/v7D6I3/TT5lEaKX791YEPzW8MA1dJPsNR50AjltVX/ZlBlDEaf96
 K80QhzlgpED4m3dBkhoKfejpClwmepf9cAgbEWRiOebrfY60sO/zH4kyxAN17X10jZUBlt85c
 GziofarXEId+QbII+ut4nlo1+m6LWQ2JIMMjEyA3A6ssUj01bhrPbByqKYfaJDcawAtvjxb4Z
 AxBmT16y6uP/bFGLiTDYnPLFO73NPYIM55ji2vh/91ZXhEBbWPaJooy6oeGpmmZA/2HH4oQkS
 LoFoiwj4kcackCToqaRxCps/qsCi/JgaymRo2yPyy0yp5hy/aAUja5SSK3Xh9gFhsst6u9xPH
 1kOxMpv/cgyoXA96TLNqAD6ye77QVT/lBut02wseFMbVEbgBODEHD4wqxMHHkeNJqup55/+Wm
 Rl0kO8ZGcj6p2vgRGimPQ+ZPAdv0v/P07Rf04jqFFWg4mvM1calfVeN5VCCOkbVhuQ5AWzFTl
 5Nt2L5v3jQXIOnl90fu79nKudkPjRpKxx0asdzVCDxlepYJJvjDaygcxy4uyh7yUYqTEhJ7z2
 s0QM3PeaJH1Td3U4oohD0rNdniubLUcJlHRTc47CeWn+BH4/D5J5drNQPZZOhctb2wVtDcttu
 9OGIUch0EiCtLbB3N37cLIcZhtRfZJhz71/cmtk0vxAkmncgaLQnFd8fFgtAUzK9MnzayV+HC
 wbxHs2G8RRSMPIKJozWhTASxJ9342DxzBCNNSpXZnId8ym7nOquG8nh+k82fEDrazXC7+pZTd
 RDxyq+Fidw6Fciu4fmv1CTWs5InHTp+lnWpijjb92BtF7IkmRBFuNASmgq4YOa4UWOMpYwxIV
 RL9Vzt21POK5ycdxZKnwW5NT2wHbG8XC3Lx0pcgsLQb/9vWFlNxvrhGvlgx8WpLx5Am2Laf4V
 mEya1CCBb6M/38R2/ovuovJ7v7gu8AgkQwELfYwfl9o77nOBT4mV3tTdpNg+uRJdwMe0XXG22
 POZhYZTah86lozEMWllwymV8RD6WU5MA7NiWanWJp3J8TunkMRopkKDAvv2uNS7qZc8Bp85+J
 4fYa7S3qAVGfgY=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that the 'table' parameter to clk_register_mux_table is never
used for modifying the table elements, and so it can be declared const.

Jonathan Neusch=C3=A4fer (5):
  clk: mux: Declare u32 *table parameter as const
  clk: hisilicon: Remove unnecessary cast of mux table to u32 *
  clk: mmp: Declare mux tables as const u32[]
  clk: qcom: Declare mux table as const u32[]
  clk: pistachio: Declare mux table as const u32[]

 drivers/clk/clk-mux.c                 | 10 +++++-----
 drivers/clk/hisilicon/clk.c           |  2 +-
 drivers/clk/mmp/clk-of-mmp2.c         |  4 ++--
 drivers/clk/pistachio/clk-pistachio.c |  2 +-
 drivers/clk/qcom/kpss-xcc.c           |  2 +-
 include/linux/clk-provider.h          | 12 ++++++------
 6 files changed, 16 insertions(+), 16 deletions(-)

=2D-
2.34.1

