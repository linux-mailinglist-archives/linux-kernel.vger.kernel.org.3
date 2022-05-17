Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AFA52AC24
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 21:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352853AbiEQTl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 15:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352854AbiEQTlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 15:41:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1F4522FC;
        Tue, 17 May 2022 12:41:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0BE6BB81C09;
        Tue, 17 May 2022 19:41:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E207C34117;
        Tue, 17 May 2022 19:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652816481;
        bh=FgdSjd/rFw8jiuUv2YH2aiwegMDQriMKJOQcbbSUmh4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=eGZMJb+sn2IT28xBtiBLoxYYblIkuPwmKaiL/PoLYuHyqdgryUkAjg9AsXvN8uuXV
         dKsI3xlnM1k6MxuLj43tc5JGhwauraf3OQlNMD93ZKBJDQ5WFHknx2xfWQ5zdfx/em
         gjwyUpnrQLNJmrWyLMPn4WsMUJDX1a827f+9C5yu+TBc22ez2DoFM7gyxiFy2OFqoS
         id9iqaterX7+vTlEg/xEorIW671sOcyMUXtUX48WdUO9p6mt5i7AbVEOo1KF20RpNE
         Dx5cocvbrb6DXRI6/HzQ3BQMtWj5n/hO/PjrQMikNnBjj6URXaA/4NX/L/nuh3F0wY
         Kjn+eYqXYKQeQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220413071318.244912-1-codrin.ciubotariu@microchip.com>
References: <20220413071318.244912-1-codrin.ciubotariu@microchip.com>
Subject: Re: [PATCH] clk: at91: generated: consider range when calculating best rate
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 17 May 2022 12:41:19 -0700
User-Agent: alot/0.10
Message-Id: <20220517194121.9E207C34117@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Codrin Ciubotariu (2022-04-13 00:13:18)
> clk_generated_best_diff() helps in finding the parent and the divisor to
> compute a rate closest to the required one. However, it doesn't take into
> account the request's range for the new rate. Make sure the new rate
> is within the required range.
>=20
> Fixes: 8a8f4bf0c480 ("clk: at91: clk-generated: create function to find b=
est_diff")
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---

Applied to clk-fixes
