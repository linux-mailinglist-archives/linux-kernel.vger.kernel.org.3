Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC95C556EE2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 01:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377281AbiFVXO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 19:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358619AbiFVXOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 19:14:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035C541F83;
        Wed, 22 Jun 2022 16:14:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9952B81EA9;
        Wed, 22 Jun 2022 23:14:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69185C34114;
        Wed, 22 Jun 2022 23:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655939692;
        bh=/uVthb01br9MZumIFaVkOhWoIWCaLcapdG4eFx1TO7o=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=bZjaZ0QJdUXZ/ywRUjEZJIU+Qnj9F4z0SEw75Wq6oLnrZ4Y/G9JTLyAVHy+C+lWnh
         joJbyE2XY7BNIpTK8wL4MB0cAPYH7JTzJbcz8S7S+f9Cm3lf6MBLdm33GwIT1eBdqY
         hzZCtCFKMlt+0hDL1bkHaIuai7chVh+S5m+8NEtmjf/0eSA+LjsADEfGqvxEDdwLWI
         33qAN8dlyg/yjNI7MMS5NlQG9wZKzSr9HJKON+FVDRfsQ/a3PqJn2OzCqNXUQYPw6H
         u6u98kehDxjCOBZq7PtkvQwuktdCLXhQebnbRUDE4a6aNU0yCDZQVrCW/JH3PIba56
         /kKbbQb2RKU0Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220622171147.85603-1-andriy.shevchenko@linux.intel.com>
References: <20220622171147.85603-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/1] clk: Remove never used devm_clk_*unregister()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 22 Jun 2022 16:14:49 -0700
User-Agent: alot/0.10
Message-Id: <20220622231452.69185C34114@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andy Shevchenko (2022-06-22 10:11:47)
> For the entire history of the devm_clk_*unregister() existence they were
> used only once (*) in 2015. Remove them.
>=20
> *) The commit 264e3b75de4e ("clk: s2mps11: Simplify s2mps11_clk_probe unw=
ind
>    paths") exactly supports the point of the change proposed here.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Applied to clk-next
