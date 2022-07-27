Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AD3581D24
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 03:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240146AbiG0Baa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 21:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbiG0Ba2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 21:30:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBC82F8;
        Tue, 26 Jul 2022 18:30:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A1B761750;
        Wed, 27 Jul 2022 01:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3DCC433D7;
        Wed, 27 Jul 2022 01:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658885426;
        bh=yj2Ur7WNIMLD4IPYirOGmRmGzZTZYD0CQwJt3Fu56KQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=T1YaYEgVmahi4txOt7oECNAcUCpkA+B/p5Z1t7hxcw7iK7LqpL3UiJ3wCfzOV5ET+
         v3JbSW7gOiYhlWEfx3bptQheSRxnsdi3MCdNp/8AOoqRfTgHT3T/pmteyDqffxot1U
         5XQpsrUTSOUqX35oAveG4O2Cj1NyPemnJ564FYlOwrmJUhYxZmlw9vV52vCGFTSf7D
         gxUl2SQn2y3C7NenPfBn2mJvx7V0Xnc4zYeGiWa+Dt5PS61QnW9XMrFDp7C+2aNl0T
         Za2PCieGMOdDpAG4gNBDU71UUFKTIAS6Is+vNbu71Goxqw8v0KsXVwvK0yso82Rr1w
         NIzhhK0PrJoHw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1658315023-3336-4-git-send-email-quic_c_skakit@quicinc.com>
References: <1658315023-3336-1-git-send-email-quic_c_skakit@quicinc.com> <1658315023-3336-4-git-send-email-quic_c_skakit@quicinc.com>
Subject: Re: [PATCH V6 3/5] dt-bindings: clock: Add resets for LPASS audio clock controller for SC7280
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org,
        quic_tdas@quicinc.com, quic_c_skakit@quicinc.com
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Satya Priya <quic_c_skakit@quicinc.com>
Date:   Tue, 26 Jul 2022 18:30:24 -0700
User-Agent: alot/0.10
Message-Id: <20220727013026.8B3DCC433D7@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Satya Priya (2022-07-20 04:03:41)
> From: Taniya Das <quic_tdas@quicinc.com>
>=20
> Add support for LPASS audio clock gating for RX/TX/SWA core bus clocks
> for SC7280. Update reg property min/max items in YAML schema.
>=20
> Fixes: 4185b27b3bef ("dt-bindings: clock: Add YAML schemas for LPASS cloc=
ks on SC7280").

BTW, that period at the end of the fixes line should be removed.
