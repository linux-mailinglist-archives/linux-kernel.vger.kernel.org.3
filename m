Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7704A2D86
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 10:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242996AbiA2Jwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 04:52:37 -0500
Received: from mout.gmx.net ([212.227.17.21]:36547 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238457AbiA2JwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 04:52:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643449934;
        bh=SjobegYeCpUDAve7xiuQBv0BWl07pgDK9eKK4i8RRPs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Ets050nABkDUfTnVuV2reJhTxXdwnk6WYChZVH3zKncpwK25er0mNIMyEHlMtNkR5
         n2RsvMqSTmbhqSO7XwYv3bG+0Ufrm77KtPrsXTORDM2kcpZQILdffpF6M8Fi5XPEhI
         CDyEO/hvZowgVmFypMbTMrbATNUoob/zYndtptXs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7b6b-1nAB6G3Ln3-0080Jw; Sat, 29
 Jan 2022 10:52:13 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: [PATCH 4/5] clk: qcom: Declare mux table as const u32[]
Date:   Sat, 29 Jan 2022 10:51:57 +0100
Message-Id: <20220129095159.2202366-5-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220129095159.2202366-1-j.neuschaefer@gmx.net>
References: <20220129095159.2202366-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uwp4dzzhhwbJM5makTwlwtp2N5eApP48DwAPSe0hk9JLwycThiY
 2MUj4FKwb6auuycF27LwU/l/EWpnEH0YXAvmndGMerAOhR42WEJl7QqEvcvPIhXXFT3PPLA
 8CosYEPrUcmAZvT28jrijfFhyBbJ2PiJomY9YHIe/vkj00ggn5WwGYiUYcM8jAIA1yLWWYz
 rXV8n2zEHBY9ACGqMiDPA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iYe1hMHmwFg=:CcsxAEilFaU7hb3BMmW6IU
 mqxqawEDxV/hnLznDrDtzJE1hI8b8EacwHkIkCXEn93Pw2IqPmuML4LKQg69UVoUlUvvYbyto
 IYd7pzYDqct/5Ht/QycqKtT1JCSL7OCmNSa/sGTX/6WIMmkoy2klu76FTvId2U2VCNBO7WOux
 xZswuTV95pirvtFO6iI7vYB36GapOqWiy4FEXLp9u7XXxEvSlTLvfisHoVERrZuATWxsQn9Sz
 PtLgpkwKyV2V91/+uoUkmfgYLy7qNFrg98IxoncbkFAAon4r7ONVnFrWaozlMq+h7wmkIoKh/
 ESaFTmrdOmlz1ee4K0do5iQPt1wULnkTH6Ei041TonFhIwepwuQDHKTSQjZK8eKh8fC+/QseN
 n8vU7rb0+P3aG3NBWzIqqhjqMrkWCHicdAqisWfMGq3+8VbUKIBNtyJDCpy4yI5YeVFAfRxNf
 i4KDbBiei1JgCtpEDjL2bkcvMtWgS7G1Vwj0rTbk/C2SEapwRIo/buL/gPtYs/4+HW6wh8WQQ
 r5jRyhOvM0Py+zYiG5v7+IBsZaLY4B+RSLUywdZAVv7M2yQSMAm0FYgBytF07Nq01szUv3/ga
 tzJz6vfxCepIc0Qq+jpmnW3YEif1wEz1tMo9hCxww6gRpKk0UclqLI5vmV75gT++LWOXXbduC
 0WM/Y1WS8+on2NdqX4EX2DzIdCEjSNJk+nTRLiZXxw5xSOFnL3EN/J4C/2h6IXfMpnYI46CaW
 1i60lpilaRXQWsR2n8HOEJPZX2lKrXKVWk9fyZ2PG2NzNci98OZniEZ8dqLzWBD62BeCQKv0z
 7iNJQJ93fnfEujTb5EEgJATyE3DepBvCMG5f3Zz7G6g4EI4e8snaRxqz8WIlxbDaoKwKIdJCt
 B95f7odsXi+0EeTGxnTwM8vmAeU2pnQ1q5o3esXY1sQ0URux6xcI7k8DjTl8re1nzaiWiED/W
 o877P/6I8nbev0IvaU9kNX0aAfkzQ8Zl304u3BoKhPimCDsOy4gs8/NAKMRMh15JFX2u9AI0A
 Nd+gkVG/hNl9XEqFjjM5QNi/6VIZfAAniDT2c6MZIyoTn9WrSrQs7WJCenSXMYBJ6c8hI9oqe
 Q0qCk7RmQfr1/g=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that clk_register_mux_table takes a const u32 *, we can declare the
mux tables as const u32[].

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
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

