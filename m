Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A6D50C6AA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 04:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbiDWCh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 22:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbiDWChr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 22:37:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D5313976D;
        Fri, 22 Apr 2022 19:34:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F05F0619A0;
        Sat, 23 Apr 2022 02:34:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4939DC385A4;
        Sat, 23 Apr 2022 02:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650681291;
        bh=tYvjYg78ebuLyC2egMJx9eCccKwIHxZuRUnTDB9jyII=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=AWcMYrRUNRRkFxSvyaCWa3Cd8JDWgqKUYWRBCakIScQ83O1+OmKPxkdbAo5jPyL0E
         xsJrqw+1hf5wpu2w1pDbLExiRYosBhUKvou40xtETQMEci3egeMfWiL0S6658/mFgw
         yyVWXofMXTNVntace6PM/xLRvK37L7PTL8tWIGz4QZZBoQVKsiGGKkw01DE7UXXC6r
         KJ3bWD82dFCEchgG4tVUCU75zZkMGCdXQ3FJYcOwEUxSBMiDb+S+brzAejDNpOOvtw
         rtfgJ30iOQYw4i3J5MWonQGN53uoJXHn+9/+7a5J82q6ugVnG0I399ayy/SL5xL94w
         tspIhCGVyCSig==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220407151831.2371706-9-steve@sk2.org>
References: <20220407151831.2371706-1-steve@sk2.org> <20220407151831.2371706-9-steve@sk2.org>
Subject: Re: [PATCH v2 08/10] clk: si544: use i2c_match_id and simple i2c probe
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa@kernel.org>, Stephen Kitt <steve@sk2.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Kitt <steve@sk2.org>
Date:   Fri, 22 Apr 2022 19:34:48 -0700
User-Agent: alot/0.10
Message-Id: <20220423023451.4939DC385A4@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Kitt (2022-04-07 08:18:29)
> As part of the ongoing i2c transition to the simple probe
> ("probe_new"), this patch uses i2c_match_id to retrieve the
> driver_data for the probed device. The id parameter is thus no longer
> necessary and the simple probe can be used instead.
>=20
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---

Applied to clk-next
