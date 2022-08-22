Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BADE59B740
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 03:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbiHVBZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 21:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbiHVBZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 21:25:12 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F3521247;
        Sun, 21 Aug 2022 18:25:11 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E87FB5C00C0;
        Sun, 21 Aug 2022 21:25:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 21 Aug 2022 21:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tom-fitzhenry.me.uk; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1661131507; x=1661217907; bh=5rywm4FJkA/bbgcbZKDHp12cJQNkVOO3Ete
        nBFznHF0=; b=VKGZ1PpDSntcxPb6PHDsGy3gdeL6CHW7g2PbxZX7UkmA7fwU+Fw
        wNTOymrSI+4YHp0iSlWamP896CPcFMfsaGaZh758f0unOVkr4J/xlLbQaM8nlZ4p
        HAMUekWS93GOP0iiasVesmhubOm+CNHBZRnrdii25WRwlZ8m3XfUhKh+MIgPfrAZ
        LyqAkabOwdgWKrZj0GkuVUoFE2z7qSDjthLQZmH2k7VlDfVzwKlhbc9v2FjSDVEr
        yGUv1xzs0/jZdBjSjDXVfR+73VDOEAMEDCM3tuHDkhRKzS5KswtLZsJBqJL88fw/
        7FvwVwdSniVMdXWwXxijsrR+Dbugo0aokIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1661131507; x=1661217907; bh=5rywm4FJkA/bb
        gcbZKDHp12cJQNkVOO3EtenBFznHF0=; b=zUsnJtMezl9lBjOFyAItSlrzPenSf
        fD8ha8pCwp7Y/f+FUFja6O3BGF3gqE7In5TQ7img1UBNiKXspuvGgH3hOSBhlpGm
        Z6pO0MRDtZOYluTKdXCbgXdC3+woArm+li7/mOayahgKmmVBDKB1T4XIUR3wTjp3
        ykPxtV5Cf9UDElEUn8VMH93i7PiCQH50/tBzUUJi3Tryy8DXW+7DMacrV466MpHR
        Xn9fzZRgWz1v2m9DI9h1eY9pnhu1EBPTmFtTQ+ErEbGVy8DfF2v3D9opkwUPVmqv
        cg9529OjzmZAi8TPoXJK9PHWiNdSLJ4r/UAGIgyrmw1QIk4lh3Pzwe5tQ==
X-ME-Sender: <xms:89oCY8NWhwmjLzfDFEJyzOUPNRVizZ1RpXA5Eh361ZwW2N55fBQ0aQ>
    <xme:89oCYy8_TQTRcq_RjYC7NOtak65BXijeRYd8cmI481Y1ZCdxCPoLQppgL0tJwHEM6
    CD3s3gEVCXVPD4oNg>
X-ME-Received: <xmr:89oCYzR5XDR2EjvGjJ3AWXaG7f2or-h2jCasXgTkukQA7v3fLV0Y7VrMJC4l-Ewvhmjjx-Y0fLBqTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeiiedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpefvohhmucfh
    ihhtiihhvghnrhihuceothhomhesthhomhdqfhhithiihhgvnhhrhidrmhgvrdhukheqne
    cuggftrfgrthhtvghrnhepteeffffggfekffdvjeekhfettdfhveettedukeduleduvdev
    ffettdffhfelueevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohhmsehtohhmqdhfihht
    iihhvghnrhihrdhmvgdruhhk
X-ME-Proxy: <xmx:89oCY0u_F3nrOMS7EqL7aBfJxzEtoVgJ1GNy6UslQ0SikUsGIWO9_Q>
    <xmx:89oCY0eZYYR2Gg8J3pUKaO5iQdZ0y7doUNPGpFL_KCvu-AVfIlWAxw>
    <xmx:89oCY42pnm3QV38Ig01p8t0DkfksKR6TPYevVMd3sryFchsQVUr9SA>
    <xmx:89oCY405FgXhT89j2nDhar3-6TnhLGI6986Zi6C1RqjZrv0oTRQw2A>
Feedback-ID: iefc945ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 Aug 2022 21:25:06 -0400 (EDT)
From:   Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Subject: [PATCH v4 0/1] Add support for the Pine64 PinePhone Pro phone
Date:   Mon, 22 Aug 2022 11:24:48 +1000
Message-Id: <20220822012449.21005-1-tom@tom-fitzhenry.me.uk>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a basic DTS for it. This is a working base that will allow myself and
others to add more nodes.

Relies on "dt-bindings: arm: rockchip: Add PinePhone Pro bindings"[0].

0. https://lore.kernel.org/all/20220815123004.252014-2-tom@tom-fitzhenry.me.uk/

dtbs_check found some violations, but they were all common to rk3399.dtsi
and thus occurred on other RK3399 SoC DTs too.

Changes since v3:
* Fix regulator min/max voltages, to align with RK3399-T datasheet.
* Re-enable cluster1_opp/opp06, with freq/volts as per RK3399-T datasheet.
* Fix gpu_opp_table voltages to align with RK3399-T datasheet.
* Change regulator names, to align with PinePhone Pro datasheet.
* Use DT Generic Names Recommendation: power -> key-power.
* Remove unused label vcc_wl on regulator.
* Fix code style.

Changes since v2:
* Used rk3399-opp.dtsi (+ disabled) rather than introdu4cing rk3399-t-opp.dtsi
* Removed superfluous comments.
* Followed DT Generic Names Recommendation
* Set 'From:' of DTS patch to be Martijn, the primary contributor to the DT.

Changes since v1:
* Simplified the DT to a minimal base.
* Introduced the RK3399-T OPPs.

Martijn Braam (1):
  arm64: dts: rockchip: Add initial support for Pine64 PinePhone Pro

 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../dts/rockchip/rk3399-pinephone-pro.dts     | 422 ++++++++++++++++++
 2 files changed, 423 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts


base-commit: 2e1170c71ec0c0fb785ce76fca7c682e930af2b8
prerequisite-patch-id: 41a5419f57b2712f7127d5c6cf1dbf062f6570da
-- 
2.37.1

