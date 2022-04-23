Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CFC50C69D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 04:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbiDWCfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 22:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbiDWCfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 22:35:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5F65DA68;
        Fri, 22 Apr 2022 19:32:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D05D6179F;
        Sat, 23 Apr 2022 02:32:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F86C385A4;
        Sat, 23 Apr 2022 02:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650681162;
        bh=9iNeV8+jHiFlEsrvuhqlZcQfmg3NMxYh+CTbXuM7am0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=OHfjeRbLKX3C1SVvmxogorLvFfIyl36pqksjGhj8vwfjIVma3rx5iLFDO0vZjkWbn
         8bUiM5+kCj2VVQdB+AWdsMEah05IxmNUiFrm2dG4VNGGcnvwnF0nol8PyoyH8kFqoX
         V/ExCm5VahB4sc3q1B07vV6ahI53lxIeMSYSarIwQDMCNmxko14bTb2XK1g+dvxXuD
         UAQMusP8s1HC4k0Ah2uH56onOzbDzUz4A+ediAfZD/oTrp2gSICaDVxEOEdwLCTzsw
         A8hmUk8986ayClGWwaehyee01XADADkokgKHX2mmbeUCMPf1i6qx6BuDc1FYdxUfKQ
         A5hyD+p7eJOwQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220407151831.2371706-3-steve@sk2.org>
References: <20220407151831.2371706-1-steve@sk2.org> <20220407151831.2371706-3-steve@sk2.org>
Subject: Re: [PATCH v2 02/10] clk: cdce925: use i2c_match_id and simple i2c probe
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa@kernel.org>, Stephen Kitt <steve@sk2.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Kitt <steve@sk2.org>
Date:   Fri, 22 Apr 2022 19:32:38 -0700
User-Agent: alot/0.10
Message-Id: <20220423023242.00F86C385A4@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Kitt (2022-04-07 08:18:23)
> As part of the ongoing i2c transition to the simple probe
> ("probe_new"), this patch uses i2c_match_id to retrieve the
> driver_data for the probed device. The id parameter is thus no longer
> necessary and the simple probe can be used instead.
>=20
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---

Applied to clk-next
