Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7C3485DE9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 02:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344163AbiAFBO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 20:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344154AbiAFBO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 20:14:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E115DC061245;
        Wed,  5 Jan 2022 17:14:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B12961994;
        Thu,  6 Jan 2022 01:14:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA762C36AFE;
        Thu,  6 Jan 2022 01:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641431665;
        bh=On4Ogi2udkz2uxmfuAxWjwEpzX8UHKoDSsxMTCKKTio=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=T+hSnkBSC1JewkBb0tuv5F1g0NueuOwhEYFb46v+DIA3Ay9/gWsAU5Iwo1TzGUMmI
         c8L8iN70+FohVJRKX6cNMvvSSWPcMFZVeFUOQeQOWncrTEgfiv5V+VDGgBUiYMPnHR
         mgJiWgHZgFXrBuklOWnWk0KKLd95iIj6kL/ZKaVWCTwTQazj+QWwWNtN094Le7gwmF
         PNUrOKP6A6k6qaI4zgitenD7zl3GUplgYYs8LoRO1OWIOaVsv5vdY4n1gayKUO6S4W
         U/ZMQ8JS/SW+/e1mEH9qqLcSz0ViWjzAnuPG5pjJCNl0XhUb9tWPsBaQ3bSjoUcIhg
         pWMKQj+eTun+w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211025031038.4180686-3-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20211025031038.4180686-1-nobuhiro1.iwamatsu@toshiba.co.jp> <20211025031038.4180686-3-nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [PATCH v5 2/4] dt-bindings: clock: Add DT bindings for SMU of Toshiba Visconti TMPV770x SoC
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     punit1.agrawal@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Rob Herring <robh@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Rob Herring <robh+dt@kernel.org>
Date:   Wed, 05 Jan 2022 17:14:24 -0800
User-Agent: alot/0.9.1
Message-Id: <20220106011425.CA762C36AFE@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nobuhiro Iwamatsu (2021-10-24 20:10:36)
> Add device tree bindings for SMU (System Management Unit) controller of
> Toshiba Visconti TMPV770x SoC series.
>=20
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> Reviewed-by: Rob Herring <robh@kernel.org>
>=20
> ---

Applied to clk-next
