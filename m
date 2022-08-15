Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2738D5928ED
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 07:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiHOFI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 01:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiHOFIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 01:08:23 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23C913FB8;
        Sun, 14 Aug 2022 22:08:22 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 463CC32000F9;
        Mon, 15 Aug 2022 01:08:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 15 Aug 2022 01:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660540100; x=1660626500; bh=82
        aHbrLCSoT5U9kGABruP9x0FLrrxpsyk9rS6RQN/R4=; b=Is1nximSTVadIwS9Lx
        /ecE+EeEWF7G749+VQ8a+08/9suOTuMBm0M5ykij/IRS40pqjKD0NJCjy4BJgIWQ
        SggC1eCba4rTMoGViX+7lh2XKteJN2UsWTyR8okwd2DN1lVD8iDkZyXLuWNfP3Bg
        HA0gvt7hlreefRuPqn0FsfVi6vwbeEV/MKB6c1ozvDrk2qWLciZd/W+tzyPMbKuG
        pLhFD97bz0/q1oFz0Jt78mydf/ru5oui4THLkvglWY1qECyjK5wbYtz64dgzOqp/
        yIUChmTbeO5EIg9HPBmuFX5VD7K0JbvkshMlNHZInj+VECzlNQAtGPX01W+u2IUf
        2EJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660540100; x=1660626500; bh=82aHbrLCSoT5U
        9kGABruP9x0FLrrxpsyk9rS6RQN/R4=; b=HaF1KphRmbMy0fp8Ltfq7b2n7mKLo
        WfhnzesoiIY6MIeM4XwPUCJbop11SiJ03Podax6FfyCj8OoZnqP1SbO6pJ/DziGY
        aloS+2p05nW4uDkmjmWvumzzcNWhW9rD3hNRQWr1dLMsysXQ6OyF1m4dqYjZAI5K
        RJAvyXKR71etuYaslaer9OCZuyiHjPv34clnUGJLpTTzkLl2a5k1CKxt6M3Vibjz
        xEa7plxvBJOVoLSHhu8mpg8arslKepVgdI400TewgK+Q4kDksyvHDJhKbPjZ2tf/
        cjN8URv+cXwwY3sBq7HCJmhKIHtONCtSTRb83F+nqVXx7ZrA8lmIcWA7A==
X-ME-Sender: <xms:xNT5YtOUfUZmrOkLpKceBVJLRflmBVGIxD8xFhLRrw19Ahscxj8XFA>
    <xme:xNT5Yv8LqEvO3Z-AittGYvNWC3lybBDYIT8SiOiODBwLEvKFIK-_vqqS7Ygqln4ng
    ZLngmXXfV85W4Y3lg>
X-ME-Received: <xmr:xNT5YsSNyFnykBNpCQy8cCsLRfEeMQ41C_FBkJvWAKyh6WT_2FCUSXdT1Jm1q3MmUjck9iQEHKBL-A6HyIT5MOBXU7r4nUTorUk-hCjVeywcJHpDdw2zrUiqaAme4ZA1aAkQRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:xNT5YpvgVVeoD7VsPjRUfTQnkLIkD16q6NCxi7k4UFMBIM_hlueG4Q>
    <xmx:xNT5YleogwwIU-vIc3UCrfegzIxWpQ0YL75xwCdU-KFrSbH1nAu_Jg>
    <xmx:xNT5Yl1zZ8D5wxqzoNTRtREKxgwa2-EiLf5ABMTvmWhryneFkLOgXw>
    <xmx:xNT5YmX-kKwXX4nHKXzZ5-0_t6a-SbnJpEGOvWGjc5RNvJALtAz1wg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 01:08:20 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 01/12] MAINTAINERS: Match the sun20i family of Allwinner SoCs
Date:   Mon, 15 Aug 2022 00:08:04 -0500
Message-Id: <20220815050815.22340-2-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220815050815.22340-1-samuel@sholland.org>
References: <20220815050815.22340-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner sunxi SoCs with a RISC-V CPU use the sun20i designator. Match
that pattern in addition to the designators for 32 and 64-bit ARM SoCs.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8a5012ba6ff9..59bcaa405a6f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1800,7 +1800,7 @@ F:	drivers/pinctrl/sunxi/
 F:	drivers/soc/sunxi/
 N:	allwinner
 N:	sun[x456789]i
-N:	sun50i
+N:	sun[25]0i
 
 ARM/Amlogic Meson SoC CLOCK FRAMEWORK
 M:	Neil Armstrong <narmstrong@baylibre.com>
-- 
2.35.1

