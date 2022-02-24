Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99224C38C3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbiBXW3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235515AbiBXW3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:29:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F28549F09;
        Thu, 24 Feb 2022 14:28:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9946761B24;
        Thu, 24 Feb 2022 22:28:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC781C340E9;
        Thu, 24 Feb 2022 22:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645741718;
        bh=qSZUwXLXtZB/NQ/nBMG49XPdeys5BXHmru2v38priTE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=jgx9igDKKiYqwTrqLTHxyLccW2HHsrvawz3VGaJODtO7Oq4/HXMcRYPBpnf4l/wzZ
         bwwS2sfaYbZaHMUxVxxWViZ6lNdp+4ROOStNmlsCHWRv1Dg/5x0UooiXB/5i72sEDi
         PaEysaGAriC5NFhJMMpLu9/UFOPToctf/WmrnmkJKMYYSYd6HE7w3QMffFirubyin9
         04uiJX8F+9fM4qZazALuwRfUFqNqQvJfqpUQ1Vj0xY1iZOVkeuU3KLAba9I72/bObK
         O5B+KYLJXzY3gfNey6RStmBDZr84s2Mcg09SPhq1cZfoglnLHWK5TLoQA9JJ/PChqG
         qRZtYk9x4Stnw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220221181322.5486-2-tdas@codeaurora.org>
References: <20220221181322.5486-1-tdas@codeaurora.org> <20220221181322.5486-2-tdas@codeaurora.org>
Subject: Re: [PATCH v2 2/2] clk: qcom: clk-rcg2: Update the frac table for pixel clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
Date:   Thu, 24 Feb 2022 14:28:36 -0800
User-Agent: alot/0.10
Message-Id: <20220224222837.EC781C340E9@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2022-02-21 10:13:22)
> Support the new numerator and denominator for pixel clock.

What SoCs does this patch affect? It would be good to know if it's
fixing something wrong with existing SoC support or if it's only for
future SoCs that will want to set a 2/3 divide.

>=20
> Fixes: 99cbd064b059f ("clk: qcom: Support display RCG clocks")
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
