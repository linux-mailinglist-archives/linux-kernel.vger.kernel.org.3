Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DD04C3848
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 22:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbiBXWAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbiBXWAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:00:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67DD22A2A3;
        Thu, 24 Feb 2022 13:59:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F6CF61A9F;
        Thu, 24 Feb 2022 21:59:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832F5C340E9;
        Thu, 24 Feb 2022 21:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645739971;
        bh=CDdPrraqVI9dDQwli71QfsMjRNbwmyD++ElTmP4lXLM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Xgi8BWfSV2JIpmqHTKvdnEq9nQQWIwZbJRQBNTaJ7fQHo/ndB5pK6NOfb9L1k5oby
         jQ8oeO+P4vwJkuTjGa0ZNmrMazBaEkqy0fIy33XMwUbKAVVwYlRT3JMR/OKmtjPHQN
         P+BRcgmqCSv+iCuB+wNTFztoN6ug9y0lubphdCmoDhdtSpbWGOVoiJtGgtDPJw4v0C
         UyzN2x839u7cvr/7n0/0c4m23njly2+xkIrInIC+G55C1ChzObcFM30nTAZt5zT3P/
         PVtMZD4HgPyNaqvu5EWfs6b2w6ZksROqTafeW9OAHSx77Qj309pp+Y7//Ffxdj3M83
         7maMoguP2bZaw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220223172248.18877-2-tdas@codeaurora.org>
References: <20220223172248.18877-1-tdas@codeaurora.org> <20220223172248.18877-2-tdas@codeaurora.org>
Subject: Re: [v5 2/2] clk: qcom: lpass: Add support for LPASS clock controller for SC7280
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <tdas@codeaurora.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
Date:   Thu, 24 Feb 2022 13:59:29 -0800
User-Agent: alot/0.10
Message-Id: <20220224215931.832F5C340E9@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2022-02-23 09:22:48)
> The Low Power Audio subsystem core and audio clocks are required for
> Audio client to be able to request for the clocks and power domains.
>=20
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
