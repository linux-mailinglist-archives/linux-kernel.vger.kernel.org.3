Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083754A2D7E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 10:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238288AbiA2JwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 04:52:23 -0500
Received: from mout.gmx.net ([212.227.15.18]:56499 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236293AbiA2JwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 04:52:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643449928;
        bh=xTWzcTiWk4YA2tgswfLeYY/DO6Jr+fPSD7NraKsPUy0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=R7Rc+kGRnuLNrLfmwHQTPvfUQvrJG8N9h7+Ph/uoLFg6rM9HsqGUNdxPfYllnX+jl
         uteHw8TDp0LDHseF71H463WrNCKPOLGFM/Wi5GowuIBX+VPBgtLZWxm6RPdg41vkkY
         Cxvadr3rCbsN77H9Rfk/900yZm/tfnZCYcv3u+gs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5mGH-1mCTVz358F-017Ggl; Sat, 29
 Jan 2022 10:52:08 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 1/5] clk: mux: Declare u32 *table parameter as const
Date:   Sat, 29 Jan 2022 10:51:54 +0100
Message-Id: <20220129095159.2202366-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220129095159.2202366-1-j.neuschaefer@gmx.net>
References: <20220129095159.2202366-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PnniRrvUYxGGNMKgN9w6YLraC7UpxANcb4qbqIXoj4oF0zmXxKq
 Q+qwfbuwclzwDNteW7M/FROYeYfwjvjQCyD/eCXb0GSDKu1snhQj9lVm26n2y+7AJjANsJo
 4u33ZxwXBVz37ZbyEr+Ax2xdjJZs1WFWJkR8c9fW9V3c56fBxj8BS4uKlBE01VJIxh2kBbr
 k4B+sQm/q/R/suMKlAs8g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:z8J9H01kks0=:khXNAhObsF6T4KNAmurPpX
 /ZjXTaMEdQ5CMTv7hrrT8EEiqWNqNFMnf4OKrYWKd1YTELbzfT5TDioooQuUtTydO5Bzve6Qe
 obIVwd0CfzOs13PCaduLNa6kXD+54IfCBQe2dpcxJe4SG5QYZu8xtcuIlP4/BcP5G5RhdxQwa
 vpAuC9L12/tQPaELTrHFgvGPjP2af6k/cUarkots0cCpwvJf9w7sr/2aJVP2/Cs2M+AZF+uyh
 ZBh4l09HTtSHA81jfVxMvg+BDLXXAwp+w67LyMeB7gGT9fGKOyAo/n5Pc9nT3AKIzSDFAR8Ia
 CVBxs8YF2fsMYYsqmejhZ2XqQeM541nKbaplw0irWfyFghRpbOxY+1YpICYEFH+DP6lpNgu3D
 MYw6E6V3iQI3rJcihfeP3KiYkK952w2X42CYbKOpXGy8g1x/xj/E+rWLFzyNGPE9DTt/K7KhB
 WMaDXvV2HNFmcxU8wpb4sRFPph6G+jhbMfbDCk9JT5o5gl2aDz7bjP8pxsr5PPoUHyuVLlxVv
 BKk8McTiHolS8DFeXntn93utgbTe2YwjnEk07WOTD4KClHuTTzUZosU+kkfB6tHmWV8H8QTe8
 t8ntX/kJWJJmFcWYliTAOO5n5k+iSV5ofhlUqe7jAkw/nUPhaZ3DrDxXaJNDqU/WGAKDJo1AN
 VfMTopnPAylUdCF9+aDbxS/x8SAEDZ03UvTCVlHXgDpbP6OCX7vD+jEkGaOG+A7yYaZAl1AZv
 Gts4hWug9V4tz6CWB9WzGre1QcwsXQjVm4j+/5cGs5Fc2r9W5sh/lFPfP1y1YRpHhnwm1CtP6
 iLs+vwKAcbfqc/yI3rEXy6Xtc/KfEJYyG/Akei7OWx2rtvkDBXaU2zipH0o4u+d0HxbOorffQ
 dXxw7Wum7IDIEE/GVA3KqJ8zO+OvRyKA7ek9dOv69e8pEuv7v8Y1KFtEy63R+QR787HqcJZ7/
 JJ5e3MAt+jpF/9bZ7uaKVPyHjaoFRydxZmzFMjV4vM67peyaCuFGTF49i+8/nfdm60c9a/sK1
 AXfRQqlbKWuDxR6jbjBSGTlwVWIRUG/GpFNlUjD3IjByr27LC1iORGoIHZF5G/6qOBaxAx08V
 fLUnXF8m96SQJQ=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The elements of the table are never modified in clk-mux.c. To make this
clear to clock drivers, declare the parameter as const u32 *table.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/clk/clk-mux.c        | 10 +++++-----
 include/linux/clk-provider.h | 12 ++++++------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 20582aae7a35f..214045f6e9895 100644
=2D-- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -40,7 +40,7 @@ static inline void clk_mux_writel(struct clk_mux *mux, u=
32 val)
 		writel(val, mux->reg);
 }

-int clk_mux_val_to_index(struct clk_hw *hw, u32 *table, unsigned int flag=
s,
+int clk_mux_val_to_index(struct clk_hw *hw, const u32 *table, unsigned in=
t flags,
 			 unsigned int val)
 {
 	int num_parents =3D clk_hw_get_num_parents(hw);
@@ -67,7 +67,7 @@ int clk_mux_val_to_index(struct clk_hw *hw, u32 *table, =
unsigned int flags,
 }
 EXPORT_SYMBOL_GPL(clk_mux_val_to_index);

-unsigned int clk_mux_index_to_val(u32 *table, unsigned int flags, u8 inde=
x)
+unsigned int clk_mux_index_to_val(const u32 *table, unsigned int flags, u=
8 index)
 {
 	unsigned int val =3D index;

@@ -152,7 +152,7 @@ struct clk_hw *__clk_hw_register_mux(struct device *de=
v, struct device_node *np,
 		const struct clk_hw **parent_hws,
 		const struct clk_parent_data *parent_data,
 		unsigned long flags, void __iomem *reg, u8 shift, u32 mask,
-		u8 clk_mux_flags, u32 *table, spinlock_t *lock)
+		u8 clk_mux_flags, const u32 *table, spinlock_t *lock)
 {
 	struct clk_mux *mux;
 	struct clk_hw *hw;
@@ -218,7 +218,7 @@ struct clk_hw *__devm_clk_hw_register_mux(struct devic=
e *dev, struct device_node
 		const struct clk_hw **parent_hws,
 		const struct clk_parent_data *parent_data,
 		unsigned long flags, void __iomem *reg, u8 shift, u32 mask,
-		u8 clk_mux_flags, u32 *table, spinlock_t *lock)
+		u8 clk_mux_flags, const u32 *table, spinlock_t *lock)
 {
 	struct clk_hw **ptr, *hw;

@@ -244,7 +244,7 @@ EXPORT_SYMBOL_GPL(__devm_clk_hw_register_mux);
 struct clk *clk_register_mux_table(struct device *dev, const char *name,
 		const char * const *parent_names, u8 num_parents,
 		unsigned long flags, void __iomem *reg, u8 shift, u32 mask,
-		u8 clk_mux_flags, u32 *table, spinlock_t *lock)
+		u8 clk_mux_flags, const u32 *table, spinlock_t *lock)
 {
 	struct clk_hw *hw;

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 2faa6f7aa8a87..27be575288747 100644
=2D-- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -888,7 +888,7 @@ void clk_hw_unregister_divider(struct clk_hw *hw);
 struct clk_mux {
 	struct clk_hw	hw;
 	void __iomem	*reg;
-	u32		*table;
+	const u32	*table;
 	u32		mask;
 	u8		shift;
 	u8		flags;
@@ -913,18 +913,18 @@ struct clk_hw *__clk_hw_register_mux(struct device *=
dev, struct device_node *np,
 		const struct clk_hw **parent_hws,
 		const struct clk_parent_data *parent_data,
 		unsigned long flags, void __iomem *reg, u8 shift, u32 mask,
-		u8 clk_mux_flags, u32 *table, spinlock_t *lock);
+		u8 clk_mux_flags, const u32 *table, spinlock_t *lock);
 struct clk_hw *__devm_clk_hw_register_mux(struct device *dev, struct devi=
ce_node *np,
 		const char *name, u8 num_parents,
 		const char * const *parent_names,
 		const struct clk_hw **parent_hws,
 		const struct clk_parent_data *parent_data,
 		unsigned long flags, void __iomem *reg, u8 shift, u32 mask,
-		u8 clk_mux_flags, u32 *table, spinlock_t *lock);
+		u8 clk_mux_flags, const u32 *table, spinlock_t *lock);
 struct clk *clk_register_mux_table(struct device *dev, const char *name,
 		const char * const *parent_names, u8 num_parents,
 		unsigned long flags, void __iomem *reg, u8 shift, u32 mask,
-		u8 clk_mux_flags, u32 *table, spinlock_t *lock);
+		u8 clk_mux_flags, const u32 *table, spinlock_t *lock);

 #define clk_register_mux(dev, name, parent_names, num_parents, flags, reg=
,    \
 			 shift, width, clk_mux_flags, lock)		      \
@@ -962,9 +962,9 @@ struct clk *clk_register_mux_table(struct device *dev,=
 const char *name,
 			      (shift), BIT((width)) - 1, (clk_mux_flags),     \
 			      NULL, (lock))

-int clk_mux_val_to_index(struct clk_hw *hw, u32 *table, unsigned int flag=
s,
+int clk_mux_val_to_index(struct clk_hw *hw, const u32 *table, unsigned in=
t flags,
 			 unsigned int val);
-unsigned int clk_mux_index_to_val(u32 *table, unsigned int flags, u8 inde=
x);
+unsigned int clk_mux_index_to_val(const u32 *table, unsigned int flags, u=
8 index);

 void clk_unregister_mux(struct clk *clk);
 void clk_hw_unregister_mux(struct clk_hw *hw);
=2D-
2.34.1

