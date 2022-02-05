Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27144AA829
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 11:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379738AbiBEKg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 05:36:56 -0500
Received: from mout.gmx.net ([212.227.15.18]:59435 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1379703AbiBEKgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 05:36:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644057395;
        bh=3hZ576UTl3/lTq+uXDRzn9J611V/XEzqawADOC1QOxE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=lfQ2S/lUVhYnB0SrSbEUooYGCzSV9SmLiP+0K3rlclLiDG3Y93oAU7r4TWQEKHBzc
         P6aDjtGT0ONnQDrYJOgmEo25SLYc7XcoHxq9jicDuS9bafYQgrTwJP3KMB3p+KDJ5p
         nBTPWNDRbWHMExVzHEd+wQMx9qStsYatnfZr4wTQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIdiZ-1n2IBr3nAT-00Ebbo; Sat, 05
 Feb 2022 11:36:35 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        kernel test robot <lkp@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Joachim Eastwood <manabian@gmail.com>
Subject: [PATCH v2 1/7] clk: nxp: Remove unused variable
Date:   Sat,  5 Feb 2022 11:36:07 +0100
Message-Id: <20220205103613.1216218-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205103613.1216218-1-j.neuschaefer@gmx.net>
References: <20220205103613.1216218-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q6a4fF67vwV9Q2gA4ypPC6NgQDlJQUlmeAr9vKgZCkZuqBEySG2
 2ofC6Tkp4doIVDc6chHBxl1+2bcpp2Ut7kRfNOKj7AvLc2y/ntflmq58yay2npkRurLR4pc
 QjWyVukMyWreSL3A0hw18bSFrPvqkk13c5w+0is7GXgtLN/dIgMUPnoSTZTLpvPkqJgXf54
 fly8BWQOHGGypjV8VxB4g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4G9LrCCCF/w=:gWZbduS6zWFfd6ebgvcF/M
 4qnuWJ2a/sg7nhNLMzxxPyRc6K6LLJ9dmEQzO5YytyPLYhfhOmXMFZdFjqAAPs1ZL9aCWNox3
 ky1ie+KMmYt1MvlyVH3rc8yOdfWToU0b2PfPHgBPNzFd4hIt3YgMOVddpFIbxaeBcat5yNe7R
 iMpkf/3lNgnfu+u+cLhWEb1BGAS5a86wUOkqzKOivfb43BEQUm0ubyulAl6oOBXX62Mj9P5Et
 cSL5IFWDUeruzQNMTbWIsVPtBh9SeOcaYIz8HyQJZZT+bBoj2a11o+FRgk/JH9ABLDFFbf01l
 WbIg7OCc0LUdFrF2DihU6MdISaoJwjAucqmQn4hvvvEbWxDF520wN3WaJ47utLpdsCcVk29IY
 Qpivs0nXxobg61Sz2M6jM0lW4d/JlfOwQewLqaQIRmUzlC6E/86ijAZ1H22158YR2P11whBOy
 BkzXnHIRk/cAmEeAn98PaGjpPDlkvLPFKkmfsOsrC0DEo3RtrzWMfR2XZpeTl6Rtly5iLYcHt
 VhDR1SKG3FBVdjizJgvc4XMAX7OmiBlJV+Uk3ryi5rPsWLBiBBFnPF6LTSMrRCo+kD3R9YnUu
 L18Pmycj6BPe/RdZR7TXumYpwMUy+AeRwfAjTpSixrihgNiZ7jTm2qQo8fPIXTfSn4dXQNux/
 at5He9OZEbovl3j7wUjVesOlrgBOT6DJUWOj6S+TVs6Ky9V8dRJjVwLjCDNSTo4Y5siXl3+WP
 3BJOdYsDtbiELym1FRfS1TYxYcP0ulUmP7WqJLkjtQYzrHvbPvnAhX5Y+pNF906tm2Ik4U3bS
 sX9xdkyEE/ttloZKK9WLFzk+IcoZ8A29QUHNtRwILQrEievTdov8zvhIa4TmIxl8RUru51xTy
 GJLUhlwdhmz2kjDCqLCV0q02wYwK/Q0uyy/Se1RQzne5nncPPeydpiF2PcebqSic8HJebn+Io
 AHJBVyIskHzOBuWsOzb/xPttirz/LYr6AEyPLODFcL+nctHV5JmKIjUB3FwXHNFetfRpoqp56
 aXFGKEcQ/r5Sc2raktEfDP6si4quW6B0KMyTM6lyZiOF+8cLi0hw+rlkJ87FgJBURYP0rbb4G
 jBdv6b/kOJAr0o=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC warns:

> ../drivers/clk/nxp/clk-lpc18xx-cgu.c: In function =E2=80=98lpc18xx_pll1_=
recalc_rate=E2=80=99:
> ../drivers/clk/nxp/clk-lpc18xx-cgu.c:460:13: warning: variable =E2=80=98=
stat=E2=80=99 set but not used [-Wunused-but-set-variable]
>   460 |         u32 stat, ctrl;
>       |             ^~~~

Get rid of the (apparently) useless read from the PLL1_STAT register and
the declaration of stat.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: b04e0b8fd5443 ("clk: add lpc18xx cgu clk driver")
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

If the register read is actually useful because of a side-effect, please
speak up.


v2:
- New patch to address this warning
=2D--
 drivers/clk/nxp/clk-lpc18xx-cgu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/nxp/clk-lpc18xx-cgu.c b/drivers/clk/nxp/clk-lpc18=
xx-cgu.c
index 8b686da5577b3..349eebf69ed93 100644
=2D-- a/drivers/clk/nxp/clk-lpc18xx-cgu.c
+++ b/drivers/clk/nxp/clk-lpc18xx-cgu.c
@@ -457,9 +457,8 @@ static unsigned long lpc18xx_pll1_recalc_rate(struct c=
lk_hw *hw,
 	struct lpc18xx_pll *pll =3D to_lpc_pll(hw);
 	u16 msel, nsel, psel;
 	bool direct, fbsel;
-	u32 stat, ctrl;
+	u32 ctrl;

-	stat =3D readl(pll->reg + LPC18XX_CGU_PLL1_STAT);
 	ctrl =3D readl(pll->reg + LPC18XX_CGU_PLL1_CTRL);

 	direct =3D (ctrl & LPC18XX_PLL1_CTRL_DIRECT) ? true : false;
=2D-
2.34.1

