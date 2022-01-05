Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634A4485CAD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 00:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245559AbiAEX4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 18:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245538AbiAEX4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 18:56:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584B4C061201;
        Wed,  5 Jan 2022 15:56:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBE6E6188C;
        Wed,  5 Jan 2022 23:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47356C36AE9;
        Wed,  5 Jan 2022 23:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641426963;
        bh=F6GwUBhFCMqgCxke8oC5TlWXvfgRNbOLP789p+6vDH4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=UbYymUTpDjlUDSWBCc9WgKKqK3jTEKDq+Yt2kZcA21ycGA7moVEAVg3AjOgmN+bXs
         3jRm8KspFFASv9XiF4fRa1zQEZ1T3cpXG/2g2TdAspfhmWhHZDeNQT6mEdg9sOEhmL
         3h/yc1YyvGzKTCP+8rBQJLBss9JmSlOFaaHv4kF6Z4Qk/NcNLFQa7amUtzvZkJfTSA
         QQUpgHYmWcjl8WiZErEiD+O/5lYr36zE6yfg1cEODLDqMmXJs8/YG5e2cogC/V/dcA
         bEgWMWV6Lb+kfczFG2YWBgOWMSmQNVh9ho5hWyKhSx1fB17PCwd9SyGWOrEcSCRbVd
         Frwep9CSbaZNw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1640018638-19436-2-git-send-email-tdas@codeaurora.org>
References: <1640018638-19436-1-git-send-email-tdas@codeaurora.org> <1640018638-19436-2-git-send-email-tdas@codeaurora.org>
Subject: Re: [PATCH v2 1/5] clk: qcom: clk-alpha-pll: Increase PLL lock detect poll time
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <tdas@codeaurora.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
Date:   Wed, 05 Jan 2022 15:56:02 -0800
User-Agent: alot/0.9.1
Message-Id: <20220105235603.47356C36AE9@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2021-12-20 08:43:54)
> PLL poll for lock detection can take more than 100us for certain type
> of Lucid PLLs and also the new PLLs types(Lucid EVO), thus update to 200u=
s.
>=20
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Any Fixes tag?
