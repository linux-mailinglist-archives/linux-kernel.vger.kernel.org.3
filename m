Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6FC485D68
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 01:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343932AbiAFAnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 19:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343908AbiAFAns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 19:43:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCD3C061245;
        Wed,  5 Jan 2022 16:43:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E07E5B81E8F;
        Thu,  6 Jan 2022 00:43:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A34C36AE9;
        Thu,  6 Jan 2022 00:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641429825;
        bh=/YDkwy4ecu6dwLFHnkv/OtX9QPkqizHVJ89OBGMRBr0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=EZX0RVsfWcGbWJdLEw+ar7XBZEOWIsd30E3ngqimT0hq/CG5xOcuD/ICs2bFXSOMg
         U3cVuVUpHJ0EQPw045eGDOBCeFfYLl1GgLxqu0BDrrOeRrG3/3KYd4F9aU77YdDAcW
         BhHBaXeaFOdK03bKHz5QxsuoFmqnj5nScd/zGDj4Qab/vgZPazKBAoOU0QUop6aNuJ
         ZLs1XvuQ4WDRJ6OocpDlNzF3vMUfmWmGVz5B5ViVlEid0nYtqTRT/YwYsxMtuGk6xU
         J2aHTZwMhud+I7kd63J/XNlyNrrQwchaVpwPy3lo4hONKpIE8bhTuMuZ3tXcdHbiq1
         F8ZMLT8VflDQw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210907085137.4407-1-caihuoqing@baidu.com>
References: <20210907085137.4407-1-caihuoqing@baidu.com>
Subject: Re: [PATCH] clk: socfpga: agilex: Make use of the helper function devm_platform_ioremap_resource()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     caihuoqing@baidu.com
Date:   Wed, 05 Jan 2022 16:43:44 -0800
User-Agent: alot/0.9.1
Message-Id: <20220106004345.A5A34C36AE9@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Cai Huoqing (2021-09-07 01:51:36)
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
>=20
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---

Applied to clk-next
