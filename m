Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB1A50C6A6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 04:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbiDWCiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 22:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiDWCiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 22:38:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710317520B;
        Fri, 22 Apr 2022 19:35:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D9526179F;
        Sat, 23 Apr 2022 02:35:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B11C385A4;
        Sat, 23 Apr 2022 02:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650681326;
        bh=XJ14PyQ4pg/RzzeycrZxq8OeRG230tLNBOK8Xilz1x4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=A+//P+TRh6DazDzlapDxWTwXOzAAdgmlOEAvhemMcMPNdrqS5S7+Lx2+FoFxLHe8Z
         /LHNA0RnPFCmsDgsiYm//sf13nQmSqmE43SdtT+fOyC6Vr5kWpl0NnQOlfKdz5mAPR
         83ZObdLfdcp5i27EQ6DHXImQ+aSKxfIZNCI1bpeSv1xseNhAa4yYeH6wxvVNeBqQzZ
         cQebyaU1A/NeQMG/fZEaZWKELpmJ61wAUiqnErEWUD7BP0ymjPpQ0KVdYXdxwkyZR6
         3tNcWhdOa+jhtF6q+b5JbEzx4wJAbtz/UmCvMgW05gYpfDVV09meaDEQ6vc5EhxbSm
         B1bGs58jkl7Tg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220407151831.2371706-11-steve@sk2.org>
References: <20220407151831.2371706-1-steve@sk2.org> <20220407151831.2371706-11-steve@sk2.org>
Subject: Re: [PATCH v2 10/10] clk: renesas-pcie: use simple i2c probe function
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa@kernel.org>, Stephen Kitt <steve@sk2.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Kitt <steve@sk2.org>
Date:   Fri, 22 Apr 2022 19:35:23 -0700
User-Agent: alot/0.10
Message-Id: <20220423023526.63B11C385A4@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Kitt (2022-04-07 08:18:31)
> The i2c probe function here doesn't use the id information provided in
> its second argument, so the single-parameter i2c probe function
> ("probe_new") can be used instead.
>=20
> This avoids scanning the identifier tables during probes.
>=20
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---

Applied to clk-next
