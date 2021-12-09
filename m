Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D75F46E405
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 09:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbhLIIXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 03:23:22 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44380 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbhLIIXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 03:23:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AFD36B823D0;
        Thu,  9 Dec 2021 08:19:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3D8C004DD;
        Thu,  9 Dec 2021 08:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639037986;
        bh=hfXj6sEyMGh7apbVadKjPkQJEvpUksXZWQAcf6+Il2Y=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=KhsEMYlx5JBk+yFLyBd29T8lc96x2Xr0zBDQ4g4QozYrKVC1E2HXSIDDz0kgGC8ro
         mOBx+JemsX8yvFI0gJL5FGURT8Lu+YleMfkdqn1a2mgImq3KXGOlcsvb0cnWOi8ifV
         ysDk43Ir2O8hedk09y68gUFOJw+JJJQKa63nRnIv69kWKvKIl4esYbQw4t5uutDgNV
         OLtzlH5kymnZL4dP+Z516m7cNb7TBeCloqt985C+CPxqiyWHyQ2zBJuxmo2ZhHWnGC
         y7xzczdNgK1pynhdMBgGTVb5ZXL66zH2YwJSeokpM01bn+/eERYci8MujG6820fGSA
         5Q+jZFwYyGhvw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211207114003.100693-1-vkoul@kernel.org>
References: <20211207114003.100693-1-vkoul@kernel.org>
Subject: Re: [PATCH v2 0/2] clk: qcom: Add clocks for SM8450 SoC
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vamsi Krishna Lanka <quic_vamslank@quicinc.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Date:   Thu, 09 Dec 2021 00:19:44 -0800
User-Agent: alot/0.9.1
Message-Id: <20211209081946.4B3D8C004DD@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2021-12-07 03:40:01)
> This series adds the GCC clock support required for SM8450 SoC
> along with devicetree binding for these clocks.
>=20
> Please note that the GCC driver patch depends on new alpha LUCID_EVO
> introduced by Vamsi in [1]. That would be required to be picked before th=
is
> patch can be applied.
>=20
> [1]: https://lore.kernel.org/all/a0b04869a20a0afef99dd457ebb6474f50591210=
.1637302009.git.quic_vamslank@quicinc.com/

Can you use --base with format-patch please so that kbuild robot doesn't
get angry? I think the robot may be able to find the patches and apply
them now if you tell it what to base it on.
