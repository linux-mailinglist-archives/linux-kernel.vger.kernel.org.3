Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F438485D47
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 01:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343891AbiAFAhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 19:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343872AbiAFAgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 19:36:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99997C061245;
        Wed,  5 Jan 2022 16:36:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37AEE616BE;
        Thu,  6 Jan 2022 00:36:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA94C36AEB;
        Thu,  6 Jan 2022 00:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641429409;
        bh=Dqfz3to/SPUN1BLKQ2pKBuJ9N0GmOk3juh+/9wSH7YE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=RCEPFSquOanEPqGcyt58HdHoigp94N8izOOnMJ93j7pJjbt18LqUtVEkHmbLE0T7F
         yR6B+Q4xgCCJQv3M2E542fJ+yvr6BRy2TJCK7VxDmILcedA4I/0W1CX4Dku9wPgsMM
         7DWgWzaXdn2zjVY/CL5o4Bb7ieStFb/Hl7Y0I7GeXGDaOAE7af45+eByQKQzLOSBjV
         1VlINLNC5ZLCk/YHGsdk4oV5ZAIrxszgBjMuLYsBJyFPwlUykopozk7fzzb7KYH1+L
         8EWs8rP+dDl8vDQx8Drhxfi2bb3K4l/4FPvS+Nb0b5f4EF9tWTdPVD+y0vg/UeAmB5
         Ak0MBvArXsDEQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <504303c7cf92af8368dcda0cdde3b9c15a833418.1640154492.git.qinjian@cqplus1.com>
References: <cover.1640154492.git.qinjian@cqplus1.com> <504303c7cf92af8368dcda0cdde3b9c15a833418.1640154492.git.qinjian@cqplus1.com>
Subject: Re: [PATCH v7 05/10] dt-bindings: clock: Add bindings for SP7021 clock driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, tglx@linutronix.de, maz@kernel.org,
        p.zabel@pengutronix.de, linux@armlinux.org.uk, broonie@kernel.org,
        arnd@arndb.de, stefan.wahren@i2se.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        wells.lu@sunplus.com, Qin Jian <qinjian@cqplus1.com>
To:     Qin Jian <qinjian@cqplus1.com>, robh+dt@kernel.org
Date:   Wed, 05 Jan 2022 16:36:48 -0800
User-Agent: alot/0.9.1
Message-Id: <20220106003649.7FA94C36AEB@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Qin Jian (2021-12-21 23:06:01)
> Add documentation to describe Sunplus SP7021 clock driver bindings.
>=20
> Signed-off-by: Qin Jian <qinjian@cqplus1.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
