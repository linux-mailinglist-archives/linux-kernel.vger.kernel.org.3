Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD354AA820
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 11:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379700AbiBEKgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 05:36:47 -0500
Received: from mout.gmx.net ([212.227.15.15]:41089 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229907AbiBEKgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 05:36:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644057397;
        bh=7Jnhrvq7jRctQBKS0gpYrwPxRFguQ8hr+Yc62pb/vc4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=h5xsDfehoCDPNAR4CqXfY7qEdmJ+UiwSXXUx4GhwL/DsiVmXrRDbmAwvSbgArXBgA
         Lx3+uXP2PK98ZLschL1H92KDwhsQ7K4YK6WsSiINYhlZktk+Xdfjv2mz0a2XTgyXpj
         5oO8qnU+huyXj16752LWYpwk1LTwxNaQFweEec4g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1ML9uK-1my4pD2x1e-00IGtB; Sat, 05
 Feb 2022 11:36:37 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v2 3/7] clk: mux: Declare u32 *table parameter as const
Date:   Sat,  5 Feb 2022 11:36:09 +0100
Message-Id: <20220205103613.1216218-4-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205103613.1216218-1-j.neuschaefer@gmx.net>
References: <20220205103613.1216218-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2D604PBdLT4aQ0NrLOoct9Yj4ORp9f+pTiavGBxkK+l4ExfPbNu
 6omMJ+9sB+rUfJ/HjP5GrPQVPKRcQ+BCWK1L5lnUH/NTA9HMkwuWPORUYZpkoMV9NQPVyAo
 S6dnuR05xlN3R5TzXmqtB6U/oSLCESJwsY7U7NdozfjZp7UUIaBfegp9ByyVzaQqInwX7/l
 ESA651GAKBGOsmUWU3B5w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zeIonvdIsVs=:9ahvsbG6OrJxncXAPnYrh7
 D9c5I8BD9T1tpxsmmgL1EgMpuH+JudYHN+HJp0GlN01aL3thwzAULR/uqv/TR8J2sukh7zXJx
 k/Uqil5oR2ETLEIepha2Fb7AfVse7xIuce4WzRCCtqb3c0fjrUTjVsyfqZaKinwQ+j/Q6DYJW
 dlIk3NxxLsQ5K9WqhRyzLcmyKThgm6kTA/hjf5rqSnFsGQG3U2oZzcQrdVrqSqskQYW+0ymot
 leSy7eXTOZPgK6mfSpmTbTb5+sm+7N/7yE/0S93jsns2hv+chhGkCly3sN4EkTKUh1UlMg8GI
 Kn5ziB+NojK80bAxfd2y99XvBzhRz67kiqiDR7LVX3IdZjTvC4U7eZFr6dop2ih7JJZZxhoYC
 O/KEolzZeWFHQBL5n2sPGPN28Tw4MQIZ6XCD5IbA5MKJJxshit5sRGHWpss53uvEhD8j0r82m
 QA1ejjFOsCr2uwpwLHi2iKVp2Z99m8ZfZI2lsL89wrN356o6UL2qk98eR+FHdiV2f5jI6gJqs
 mf3NkKZ3v+iiMnTBDf5XK8EIra4NIKt7D6EIyx3Ed/oi/ZqWQBR9jBZprVPIph91g0u51UKs1
 ZpIb1hZqRLkBEEa4b1Bz9n+jxYMOWr8fjkFNr15aoJwhOVRzmUyIKbRT58Jl3srizrOSl3ReG
 wHws+3YzbO+y8QqgVqcf0POHIt1wHu5ulZ4dLIb9dJaPO+6m3U/VzzyKH847IsTFv558UuGLR
 L2+KelCiHSQyHkHaSqu6npjOa+JPsF/h7EqmnLOYTAR29Ytb2NVPHtCeKNC9pXkCftvldjUSe
 9ko3b1MPZkujO7qk+6XU+s3YKPwyQGkHKZkcCZStmkxgL7qU7DieeaSKaDyKq4PhUkOQBhO8O
 mUTaC+VPwM/L66kDm8M3/81j6CKf782kV4/zlrI+D64WZY9flJMIUgZ5AlJK5E78GGlPawghc
 J8o684Li36dVmpt72mP6rOHeY4CEg0jPNelYGbcvQz1/MA/VH2JEsc6e0tEj1i5I2orwmhKam
 v0QnkULmV0bOPSP+t4K2v4lliqxuatQHrRfySKwDG4DBC+GMuDwQobyP3VFt48cqZWJyYTsMr
 za9lWFA9wX0n6A=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The elements of the table are never modified in clk-mux.c. To make this
clear to clock drivers, declare the parameter as const u32 *table.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v2:
- no changes
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

