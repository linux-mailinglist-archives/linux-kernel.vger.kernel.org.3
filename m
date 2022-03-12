Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0744B4D6C04
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 03:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiCLCYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 21:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiCLCY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 21:24:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FADFD1F;
        Fri, 11 Mar 2022 18:23:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86D22617D1;
        Sat, 12 Mar 2022 02:23:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F7EC340E9;
        Sat, 12 Mar 2022 02:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647051802;
        bh=H7+KWKVuEkz2ZDnsRcOBekRcv+1e9fwHY0nBxbU/9qo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=TEqfYNq9bXWlhC8GsZFRVdQy47W6IotvpHIS1jRt3j63yhRnbZZP8tbHw8BbG3yQe
         FJmtBYoVkZ/N3Fl1mwnAspJV79WzaNT3v+dAPpkIAGesrghfnr3QeIK+zLLXyfN3uB
         0OlkxCHPlCukC4DqtQ3NvJyRpL9N+b1XrYY5e8AIvhBjmet8D9oNeo99e5fdS1qnaM
         Ih37ziRKuYXJZRVIwAFmPZzM92oZaYUvaUBUptKE8r+lAp7Qp/bGAydxIm29wQIei1
         dm2RSpTwlB758H5Hq5NPnMFgVuBPVyrvLhXj+KAAip+ViBJSUmTK5dmGuy6jxt0bFg
         OodxViAEyzUpw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220222195153.3817625-1-trix@redhat.com>
References: <20220222195153.3817625-1-trix@redhat.com>
Subject: Re: [PATCH] clk: cleanup comments
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@axis.com, linux-amlogic@lists.infradead.org,
        Tom Rix <trix@redhat.com>
To:     alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        dinguyen@kernel.org, f.fainelli@gmail.com, jbrunet@baylibre.com,
        jesper.nilsson@axis.com, khilman@baylibre.com,
        lars.persson@axis.com, martin.blumenstingl@googlemail.com,
        mturquette@baylibre.com, narmstrong@baylibre.com,
        nicolas.ferre@microchip.com, rjui@broadcom.com,
        sbranden@broadcom.com, trix@redhat.com
Date:   Fri, 11 Mar 2022 18:23:20 -0800
User-Agent: alot/0.10
Message-Id: <20220312022321.D4F7EC340E9@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting trix@redhat.com (2022-02-22 11:51:53)
> From: Tom Rix <trix@redhat.com>
>=20
> For spdx
> Space instead of tab before spdx tag
>=20
> Removed repeated works
> the, to, two
>=20
> Replacements
> much much to a much
> 'to to' to 'to do'
> aready to already
> Comunications to Communications
> freqency to frequency
>=20
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---

Applied to clk-next
