Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22627570AEE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 21:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiGKTs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 15:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGKTsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 15:48:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1745509F;
        Mon, 11 Jul 2022 12:48:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39EFAB81195;
        Mon, 11 Jul 2022 19:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F14C34115;
        Mon, 11 Jul 2022 19:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657568901;
        bh=Lxp2E8ekZg/0/qPQCqI9niN28BmOoqa+084t2OecaxQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=YxXD/mTjTqCaB+xAsUAsx5wPlZyTLA1JS2cWIDvH8zPMmp5WHHU47M3vosuOTGWPw
         uNxWJ63ztw8V59ffzmkIyoBKSZX2JrfB2W86xG5zQDRaiyT4/gMmBNVrORIN+9G3xN
         6ZjIi7Pgid+EMsffKAoxGvyEOGvDEOt6huxIQDUWFcueM+NmlaVHxZgzXBINFib5Eu
         OZx1Om4AIdigCzUXyqwihik63qeY3U0zqugh38tx/nHCLZyF79zSLgae0glCzUklwW
         n9w9PctF478M6weu4usG28B5GV0GbHoON8uf6q0mjrTOHbZ7oEvC680MwuSO47Dmff
         DYGga0ZiAQT3Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220711123519.217219-4-tmaimon77@gmail.com>
References: <20220711123519.217219-1-tmaimon77@gmail.com> <20220711123519.217219-4-tmaimon77@gmail.com>
Subject: Re: [PATCH v8 03/16] dt-binding: clk: npcm845: Add binding for Nuvoton NPCM8XX Clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tomer Maimon <tmaimon77@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Tomer Maimon <tmaimon77@gmail.com>, arnd@arndb.de,
        avifishman70@gmail.com, benjaminfair@google.com,
        biju.das.jz@bp.renesas.com, bjorn.andersson@linaro.org,
        catalin.marinas@arm.com, daniel.lezcano@linaro.org,
        geert+renesas@glider.be, gregkh@linuxfoundation.org,
        j.neuschaefer@gmx.net, jirislaby@kernel.org, joel@jms.id.au,
        krzysztof.kozlowski+dt@linaro.org, linux@roeck-us.net,
        lkundrak@v3.sk, marcel.ziswiler@toradex.com,
        mturquette@baylibre.com, nobuhiro1.iwamatsu@toshiba.co.jp,
        olof@lixom.net, p.zabel@pengutronix.de, robert.hancock@calian.com,
        robh+dt@kernel.org, shawnguo@kernel.org, tali.perry1@gmail.com,
        tglx@linutronix.de, venture@google.com, vkoul@kernel.org,
        will@kernel.org, wim@linux-watchdog.org, yuenn@google.com
Date:   Mon, 11 Jul 2022 12:48:18 -0700
User-Agent: alot/0.10
Message-Id: <20220711194820.D9F14C34115@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tomer Maimon (2022-07-11 05:35:06)
> Add binding for the Arbel BMC NPCM8XX Clock controller.
>=20
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
