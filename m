Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6F2484FA2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 09:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238729AbiAEIzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 03:55:50 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:35737 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiAEIzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 03:55:47 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 6C9244000B;
        Wed,  5 Jan 2022 08:55:45 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     miquel.raynal@bootlin.com, Clark Wang <xiaoning.wang@nxp.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        conor.culhane@silvaco.com, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 0/8] i3c: master: svc: some bug fixes and add runtime pm support
Date:   Wed,  5 Jan 2022 09:55:44 +0100
Message-Id: <164137293677.1744375.6793157793281994769.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211227074529.1660398-1-xiaoning.wang@nxp.com>
References: <20211227074529.1660398-1-xiaoning.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2021 15:45:21 +0800, Clark Wang wrote:
> Currently, only the fourth patch needs to be reviewed, and the rest have been
> added with your review tag.
> 
> Thank you very much for your comments! :)
> 
> V5 changes:
>  - i3c: master: svc: add support for slave to stop returning data
>    - remove <%s> in logs
>    - add some spaces
>    - !SVC_I3C_MSTATUS_STATE(reg) -> SVC_I3C_MSTATUS_STATE_IDLE(reg)
>  - i3c: master: svc: add runtime pm support
>    - create svc_i3c_master_prepare_clks() and svc_i3c_master_unprepare_clks()
> 
> [...]

Applied, thanks!

[1/8] i3c: master: svc: move module reset behind clk enable
      commit: 57d8d3fc060c7337bc78376ccc699ab80162b7d5
[2/8] i3c: master: svc: fix atomic issue
      commit: a84a9222b2be2949f11f2d7c487052ac2afed4d4
[3/8] i3c: master: svc: separate err, fifo and disable interrupt of reset function
      commit: 9fd6b5ce8523460b024361a802f5e5738d2da543
[4/8] i3c: master: svc: add support for slave to stop returning data
      commit: d5e512574dd2eb06ace859b27cafb0de41743bb5
[5/8] i3c: master: svc: set ODSTOP to let I2C device see the STOP signal
      commit: 173fcb27210b18b38f1080f1c8f806e02cf8a53b
[6/8] i3c: master: svc: add runtime pm support
      commit: 05be23ef78f76a741d529226a8764d81c719a1e3
[7/8] i3c: master: svc: add the missing module device table
      commit: c5d4587bb9a9a03b30bbc928b4a007fcd1f8c279
[8/8] i3c: master: svc: enable the interrupt in the enable ibi function
      commit: 7ff730ca458e841dbcdc87f264d7afe3eaed525e

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
