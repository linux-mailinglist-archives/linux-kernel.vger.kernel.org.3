Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F68D4AA82B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 11:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379737AbiBEKhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 05:37:07 -0500
Received: from mout.gmx.net ([212.227.17.22]:34813 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1379725AbiBEKgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 05:36:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644057404;
        bh=un66HwMXzx1+JWKGj3Ie+e7wbnjBXvxVWjU+DYbV0ps=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=b0dHsqC2bTTP6Auv031hNteHBdcxWqgiNdTM/Gulghm8yGwYXtp7dG6F+kMV2zsa1
         frrRVosWIJSALbBxc+atyIdgkrpogUKQRWQBnNSdGYtYBTNxE1E/GrBSvw7+QnNVrj
         3L+CmDJyu/CRb6MOg5CQ0FGLN1RGFkpNVSmSYC40=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUowb-1mq8b72tRB-00QhUl; Sat, 05
 Feb 2022 11:36:44 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 6/7] clk: qcom: Declare mux table as const u32[]
Date:   Sat,  5 Feb 2022 11:36:12 +0100
Message-Id: <20220205103613.1216218-7-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205103613.1216218-1-j.neuschaefer@gmx.net>
References: <20220205103613.1216218-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fxvWhth2K2e6hWUBAb7ugpC0GFHmNxb4qSUdCbpXl9hEenG/ZyC
 x3mNaHkDMCIW/wP2NYIClOXktUsfwIsfXOV5xup1MIHgcZHMMYsJqKtHhTaF/MonDN8gjGH
 f2Ie0DzocHOecH2Q2qxo5rpGvPYxkhOm3Ws8xhNMiKMlZSkzWQDjSa8v+l4nIXAVLfrgV3o
 4HIlwg9JibRc4oeqv2yxw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fqEniijzM18=:4yD3sWjBxqkHBCmqdtYOMm
 yVZ5gOB4oPSQhfv/je9cWReRnlmZE0pJguTyKh1JYCg86/zQW99d9w6HS/u1H3RAv7vAwO1Zn
 qE8IRO87NBlkVwFJSuVWaKPcfJooXB0MG7DsQddt2YM80uxewPDoIWnJGhehwC8IPCgDC7h1T
 x0BTj/Q6/ZLeRv1FgIQX/3SxGQiZ5FBFBdnHyCdp5FCZcLZQahN2+PR4gaWvAgwEQq9CZRGug
 7OkLI275/PHoI7VBtkf7A0wR6HbIClf7NhT4xbGnC4L1OtdaJxCrypCv0PLFLUd5xlGE9fyqQ
 J+r1kbFXiAV+Ojf+/e/ExA+SD+TVGhWN3p5cOjJqNXcDVUYnkvpaOSBhGfDwp7hdQQTIXweif
 5BFZS0tJsYMo9vaJ/3N/79RCIoDHM7jv1GhViZGQc1Fkx2jwqhcLRR1RjGppaNo2EYtYi/cG+
 Y5013/SJrkYpJR0eGFtEkz6KxkRg02mPaKm4OHKA6KQGWN6vEC45jEI8iEcBm52HkdJFYYCTd
 62bjM9P3p+l4s1BrMbLa6UBT12G2I8S7IsjxxzgsJ36lmWYthZeEh6zlChPOyxMYtGAkhZD/T
 pQzuSKWn4aRp6K5va99+ezxDstqPwoc3Bpg9RxG7vQKJ0MmeP2wn8sOzjDPYzIc+AskdxjEZh
 mH3F4xxM+hfWRenoN84xsW/V9Ah1EQdkEBz9+GoNgePuOdqZXAA1dsceP/ajZ8BKlEDdxDPkc
 dlhiXTGz4CbUB2l7U4t/xQpB3CIB0R8KAs8N+uncIBSl+U9llTvjQFnzmMGa7CGUyHw4Jjw9j
 y6IWJwS00bRY13utKPlxQTc5gaYqSSdALM/0BHBeQ2I08Pk5HqAWKCswYC6aw2VxZ+chMwiaU
 gKpPUIciBo1uTmNpQ+7GmOtEezYVtsHDnBfiMpnWYz/8WimJcc9nNR4Lp7sxCtpa8mjfiPvMf
 aX6ZjdsakdF+3h88EBV6cqzEYfx5Pf4o5abexggVOsGeV3+CGh9/mT2PspF+sEuoF3C5nOnd1
 bNQgGAZxjSJq/Qe2+KldgRNFU5uLxPV7SbHkCqC4PsP8mm58Cw8RfAVqckc2hbUuR4Baqs/8D
 djOThNPikw7xP0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that clk_register_mux_table takes a const u32 *, we can declare the
mux tables as const u32[].

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v2:
- no changes
=2D--
 drivers/clk/qcom/kpss-xcc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/kpss-xcc.c b/drivers/clk/qcom/kpss-xcc.c
index 4fec1f9142b82..88d4b33ac0cc3 100644
=2D-- a/drivers/clk/qcom/kpss-xcc.c
+++ b/drivers/clk/qcom/kpss-xcc.c
@@ -17,7 +17,7 @@ static const char *aux_parents[] =3D {
 	"pxo",
 };

-static unsigned int aux_parent_map[] =3D {
+static const u32 aux_parent_map[] =3D {
 	3,
 	0,
 };
=2D-
2.34.1

