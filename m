Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7505AC4AF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 16:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbiIDOLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 10:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbiIDOLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 10:11:15 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A5131EE5;
        Sun,  4 Sep 2022 07:11:13 -0700 (PDT)
Received: from stefanw-SCHENKER ([37.4.248.23]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M6lUk-1oS5iI2clq-008K9h; Sun, 04 Sep 2022 16:10:56 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     linux-clk@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH] clk: bcm2835: fix bcm2835_clock_rate_from_divisor declaration
Date:   Sun,  4 Sep 2022 16:10:37 +0200
Message-Id: <20220904141037.38816-1-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6oSaHcTOotAL64NBQsFwW8u0vvbfsKei7LqGC3+lO+x1QPcXby7
 VT+BeGToJk56f7xT+x0OzbJsJqcKAElsInVqjK6xvy33uMlgFEYplwiCWayB7hHgLfdc8cl
 6pbheYHb2iUQkwvibDn3NVMzQYZwBwYU8ubZQJ9kQLcmTyMd7Z5ODDQCs4BWNzVljJY9S3y
 nKapWwmV0tvAZaVgGdwIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YNM5B2ppFuI=:YdJ7zX5WteTZAf+raa7NgE
 JVP0HieizKyN6kB44LkkZ3IfOqyq6PO8t/JOqeAQPxRxHUUnW1+dTptLE8Vbn7iXF2zCHk0qM
 7JwLeyLhuE3Tl4Ghna9H6mbTCFS5hvf5LLYwYr90KZ4Ce28PXQb868DI5Tz6tIFxAyh+k/X37
 8FIJ3Wzd7e8CWaOMY9bqr7Oebwf53yxa4hpFo26OEzq6aoKN4j2ThmTtdpmIlvaEqvC5NDb4n
 Gqn8oropAwn6+DjKEpFJ4WxxjcbjTr6RkaKm7Bp+ZNKqjZ9BlWUIBHaBFaVDlppmUYV49qGXN
 yiAoPtCCunoISJe5pRs8Rk/Dp2M0yFnUiPDW4KAebo0yL+xglRSmytmseQHjNn6wOjY9VyYXU
 GsArdFvjNwpjrJzyaBqy+Y5YTge001jlsO6rT02a1HCLB31wtP4vHKt2ObsRllB/bxc9BDmUB
 k4iGeDaZQpt1fZY535eHm37uIIeeckg0eeiU7yL/6qg+vj2YczGDcV0IecM5JcvFOaHMU+nDW
 qFvO++dFe6NKfIjxAmFPdZTwSr3jLJqenLET5LZOp/lZk8T7SrBCQGUvqn+n8+uf7Uj9QLPMT
 I8EouWVXiaQ6+a17Ad83FYDgG6jLU2FcpxLwVpaoveZJ0r23lIU3SjeYUifpzKAno1DQZHjcb
 8nxaTj1+9fRaDo/UdGwvgBX4bpvJkGeGx8XYu1kl5ATma+/LqvYT5qlXhdSLEvp6w0wNC8v+x
 4woTCKC3JTIQoOUmIKeg8usjxE8EtqFJofMP/3BPqIVWMSaWBQ2gk96DKFVoRSZCGTlgpUJh6
 UU7Jg4WdWSsztgwjiwdieLO8EHM0w==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of bcm2835_clock_rate_from_divisor is always unsigned
and also all caller expect this. So fix the declaration accordingly.

Fixes: 41691b8862e2 ("clk: bcm2835: Add support for programming the audio domain clocks")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/clk/bcm/clk-bcm2835.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 48a1eb9f2d55..9e9f8b242958 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -966,9 +966,9 @@ static u32 bcm2835_clock_choose_div(struct clk_hw *hw,
 	return div;
 }
 
-static long bcm2835_clock_rate_from_divisor(struct bcm2835_clock *clock,
-					    unsigned long parent_rate,
-					    u32 div)
+static unsigned long bcm2835_clock_rate_from_divisor(struct bcm2835_clock *clock,
+						     unsigned long parent_rate,
+						     u32 div)
 {
 	const struct bcm2835_clock_data *data = clock->data;
 	u64 temp;
-- 
2.34.1

