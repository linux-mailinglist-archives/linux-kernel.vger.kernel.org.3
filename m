Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D382B54D1CE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 21:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350113AbiFOTmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 15:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346484AbiFOTl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 15:41:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C88754BC0;
        Wed, 15 Jun 2022 12:41:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1632C61004;
        Wed, 15 Jun 2022 19:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C09AC341DE;
        Wed, 15 Jun 2022 19:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655322117;
        bh=gJZ35XMlWABSEvjyqknjgbGYwqTWYnqQ9D+CRtxCbDo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=eGacAflhSw7FUfA/QOlZwCIN4UzdgStp+BYNTcHwhWpR6jO+xotKCFphK7aLThJu6
         V6RmpuZgUuuuQqfANxYtF2jheLIg6aBn0ei4efRYTd0A3myxh7rvJyKYgep5ITCrCx
         ZG9IYmj5Qm1j0M2Y+2gTUNsu3oEy4W2Brln+NLW3yhxDYYSoqafVlbhKY4cNuEwBDv
         Nt+Ztn8vEeNYE1MBUl/wn1aEoK0SkM9wcXhipQex/wW2ekJJ7fEhRCw9/rLYxUEPxP
         BWmZkCjGGgHn6wqg/UeB9B7Mpu2xzP5ChZD4Obv83rZZoW7xYO/BrNDgNNNCf1XBHG
         urZzVytc0IYuQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220612145955.385787-2-nikita@trvn.ru>
References: <20220612145955.385787-1-nikita@trvn.ru> <20220612145955.385787-2-nikita@trvn.ru>
Subject: Re: [PATCH v2 1/4] clk: qcom: clk-rcg2: Fail Duty-Cycle configuration if MND divider is not enabled.
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, tdas@codeaurora.org,
        joonwoop@codeaurora.org, svarbanov@mm-sol.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
To:     Nikita Travkin <nikita@trvn.ru>, linus.walleij@linaro.org,
        mturquette@baylibre.com
Date:   Wed, 15 Jun 2022 12:41:55 -0700
User-Agent: alot/0.10
Message-Id: <20220615194157.6C09AC341DE@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nikita Travkin (2022-06-12 07:59:52)
> In cases when MND is not enabled (e.g. when only Half Integer Divider is
> used), setting D registers makes no effect.
>=20
> Fail instead of making ineffective write.
>=20
> Fixes: 7f891faf596e ("clk: qcom: clk-rcg2: Add support for duty-cycle for=
 RCG")
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
