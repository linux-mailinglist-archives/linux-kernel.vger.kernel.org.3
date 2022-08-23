Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF8859CE5C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 04:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238959AbiHWCRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 22:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiHWCRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 22:17:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35855142F;
        Mon, 22 Aug 2022 19:17:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F7CCB81979;
        Tue, 23 Aug 2022 02:17:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D04C433D6;
        Tue, 23 Aug 2022 02:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661221052;
        bh=pfXMxMnVFDAtpIxjbyYv3GCQSGQCRWtAD9VmgmA+ic8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hMv7GoHUyTXn5fhPoFtX17RfzX2PHj5HRzXBDfMBLXEA/yFvQc1/EBPZj2u3ykG0C
         Uzj2sdbOulMQphAlPE26I04U8UHD81w4hMxCD8qYpW7wMOnArm9MdUExnwFjphmLUU
         VS1yCcXdlm3fPx5dAARfcKPKCJWZmDoJz4J7Gpcn6oe8C5F3Jq8LwW4cxN9rpxV4C8
         K/Nj1HxEufE+EHubASXnJsxwUBFyVsTrUT/FHMZLeDSz5QEWZhr8WNTTJ6xkErwbey
         Y3fgT0aAd0q8Xu2xiGYzYHhwds/AScX2+bVtIqvG3QZ0P+4zb9HxlBYaPODkdMtFqf
         w5KkIfXIqF5Wg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220625083643.4012-1-stefan.wahren@i2se.com>
References: <20220625083643.4012-1-stefan.wahren@i2se.com>
Subject: Re: [PATCH] clk: bcm: rpi: Fix error handling of raspberrypi_fw_get_rate
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Maxime Ripard <maxime@cerno.tech>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Date:   Mon, 22 Aug 2022 19:17:29 -0700
User-Agent: alot/0.10
Message-Id: <20220823021732.34D04C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stefan Wahren (2022-06-25 01:36:43)
> The function raspberrypi_fw_get_rate (e.g. used for the recalc_rate
> hook) can fail to get the clock rate from the firmware. In this case
> we cannot return a signed error value, which would be casted to
> unsigned long. Fix this by returning 0 instead.
>=20
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---

Applied to clk-fixes
