Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CDA50C69B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 04:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbiDWCgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 22:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbiDWCgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 22:36:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF89138484;
        Fri, 22 Apr 2022 19:33:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A5DB6179F;
        Sat, 23 Apr 2022 02:33:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912D4C385A0;
        Sat, 23 Apr 2022 02:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650681197;
        bh=/SJ4T0F4oNZZY8Jsauu/S/f29fb81Ix2OBxKsgfZbmk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Rk+gxUCZY+NxqjW+znoKIRvUMJTyjj0+RVivWePzJjlFH2eRkhBuebk3g0rjmTYIn
         X68jwmSXuOfKX7t91e1INpUfbD4/vZmdZX1EMFUIoaohePPnSP0/i4Z6xfd2OPIOxl
         +6eqFfs/1ulf0XRug45PkpPJHQepnEPpMNf5UDYnkIndZjaD3HJ7UnpRTg/Y1IWS+D
         DoAmTzRcm8eAiQeusgP5dWPKaoT9M1f56mZ7u6V61jusE2RJ1MGUPwPmnh/vRiYCEN
         y54uf7UvNFYvY8AV43h9UeH8JRmoshuG3v6hVG2nVJ5/xMAVC6w+vlw5LPlLYictqK
         VhSQyhqIbi8tA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220407151831.2371706-5-steve@sk2.org>
References: <20220407151831.2371706-1-steve@sk2.org> <20220407151831.2371706-5-steve@sk2.org>
Subject: Re: [PATCH v2 04/10] clk: max9485: use simple i2c probe function
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa@kernel.org>, Stephen Kitt <steve@sk2.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Kitt <steve@sk2.org>
Date:   Fri, 22 Apr 2022 19:33:14 -0700
User-Agent: alot/0.10
Message-Id: <20220423023317.912D4C385A0@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Kitt (2022-04-07 08:18:25)
> The i2c probe function here doesn't use the id information provided in
> its second argument, so the single-parameter i2c probe function
> ("probe_new") can be used instead.
>=20
> This avoids scanning the identifier tables during probes.
>=20
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---

Applied to clk-next
