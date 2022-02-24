Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749E74C383C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 22:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbiBXVzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 16:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbiBXVzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 16:55:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FE12757A4;
        Thu, 24 Feb 2022 13:55:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F40361A8E;
        Thu, 24 Feb 2022 21:55:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70999C340EF;
        Thu, 24 Feb 2022 21:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645739707;
        bh=sc2xqK9W9vCEKREKGgUUdQGHEqSTFN3CoLmDeODofz4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=YLM1DFStydH8hNW/WDDspAwlBPdlEfPzo4fUUc6BdE+DvkXfwN3vRIzTQ5uDlKkCf
         ICrU1OAmKt5ajs3d6QrR+q1Xb5Tu5xDSl1IHlqdAw0tYNpShagkHgyPFyAEuSxPhH+
         zP9yu3IHcBvnXGOY6sIZSwsPJTtAWxtULDQLVz93Zi9UAi4C+BZNwNgQJNwwVH+Fbi
         U6z2FeigJSsuEgfFZsB1FwOAta8vun8myPFcZF1CqTQd48by5LYn8U4TYlSz/3S/hW
         /gYAjjMF1s4/PGcFCWkskbqEsA487hYQY1M7IM6u1n608v/6pgh4yIntxpdOlwjYHf
         Pql2UYncVUn0Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220223185606.3941-1-tdas@codeaurora.org>
References: <20220223185606.3941-1-tdas@codeaurora.org>
Subject: Re: [v2 1/2] clk: qcom: gdsc: Add support to update GDSC transition delay
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Date:   Thu, 24 Feb 2022 13:55:05 -0800
User-Agent: alot/0.10
Message-Id: <20220224215507.70999C340EF@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2022-02-23 10:56:05)
> GDSCs have multiple transition delays which are used for the GDSC FSM
> states. Older targets/designs required these values to be updated from
> gdsc code to certain default values for the FSM state to work as
> expected. But on the newer targets/designs the values updated from the
> GDSC driver can hamper the FSM state to not work as expected.
>=20
> On SC7180 we observe black screens because the gdsc is being
> enabled/disabled very rapidly and the GDSC FSM state does not work as
> expected. This is due to the fact that the GDSC reset value is being
> updated from SW.
>=20
> Thus add support to update the transition delay from the clock
> controller gdscs as required.
>=20
> Fixes: 45dd0e55317cc ("clk: qcom: Add support for GDSCs)
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Looks like I need to apply this for clk-fixes. Please keep Bjorn on Cc
next time for awareness.
