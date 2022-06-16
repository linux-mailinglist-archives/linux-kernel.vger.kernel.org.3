Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0E354DC30
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359041AbiFPHxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359467AbiFPHxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:53:13 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E1E183B5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 00:53:12 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 39F1B5C02F5;
        Thu, 16 Jun 2022 03:53:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 16 Jun 2022 03:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1655365992; x=
        1655452392; bh=wG8AKxotIC4hOqs7tLCZFx1yAYerGnafok9svmkMztY=; b=A
        t1KF5yYBildNv/cPjbipuAlP1QT1ynvD+gCjnrzazE/qWno7Q8cElZJhaS/QUF7g
        2DpO3joO/yBPXs3HoyJ09M9Xwu/kMs4ACokFazmPQBAzGYXTDCWlCN1e+9EFzVEl
        Q3anL4Fd8uYYL/LFXcgNSpxsC+R8n20NGVT0MLxpPXN8FdlR5eYPJMAv5e/11pOu
        pGKOxpikPNdOumkdRFMIBzmwyyFJK1B8KYQmgjDu/eY3aA772K2EKZWNgcppzSPv
        LcabTueTDKnWj6JIeFdErfkZLfzfawmoAsysTIu5+JUnNcrOfr58Hjkj5Umx0Q0X
        il1F+0cQXXYTiSJNPo2aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1655365992; x=
        1655452392; bh=wG8AKxotIC4hOqs7tLCZFx1yAYerGnafok9svmkMztY=; b=I
        u0/ri7wBl8TnhW+xXSY9Lww5W7sWjep8d61JpS8QYqV1XvM+PukkizXdK3E7QQan
        gHmCuhMp0E0vjb0mjno2dz3iQsYiYT9AGY/KHpbr6ZstKce/KPk0jsQ561SXAeRH
        zKKKgD/Rit1d3cmSVM7pIoXH50ywUaolR/4ezmUr6N+bmJ1VqvmIe0VPEyEc1EbM
        laoVdZJLkHu8h15De/1+bPUI6I5AbuKLp2TDbRVOxR1PZw1dt6BKveKn3VDqgb4z
        7UgX5GkWBfEAHyWwlk1/dzVEOqJq2gojpBruRL2oEeeJo7GhfyYaKaOtdYIga74z
        gxkzuRZM6g3cBDAGzgirg==
X-ME-Sender: <xms:Z-GqYsVhp1Vk0wous0BFNtzgWTOtnyhGTS8BOdVOfQo7dIRZohBJ6A>
    <xme:Z-GqYgm7rRkcXsgDPWljk87RRf_xX_jbFc8MXzX1LynGPkJhlnBdDfQbt0M9CrXwg
    1VknAaZ6bEH7B5JxlY>
X-ME-Received: <xmr:Z-GqYgYRrzZVYdsZaKLwVwfGO9jukXLxjpZkurJfx8xPPO5IuJyYJkOYSSaFTpiwwIN7FaZ2-gb7JgFPjAEMJV1N2_5AIwEOjcmcNoU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddvvddguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgr
    gihimhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtf
    frrghtthgvrhhnpeeuieeggffhffffieefheduieeuvdetgeeufeffvefgtedvffehheek
    ffevudefieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:Z-GqYrUPQbyF0otCu17vCpGQiR0yzg8E48r8blP1qHqyQZmezzOPGw>
    <xmx:Z-GqYmkS8EhgTtyHNjkPxx0Jfss8h1jj-GgpMl1RvbS-zUqQ6qLCmQ>
    <xmx:Z-GqYgfJdEY1hxHUkdiNawozRLAn_tuJWqLmGSy7Qfb7wQPF_1VweQ>
    <xmx:aOGqYvcQFK3ScywFeot7yKTcfLXwf5Wj23Dj5o2Kqg9CpTzd-L1vXg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jun 2022 03:53:11 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Maxime Ripard <maxime@cerno.tech>, linux-sunxi@lists.linux.dev,
        Ondrej Jirman <megous@megous.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/sun4i: Fix crash during suspend after component bind failure
Date:   Thu, 16 Jun 2022 09:53:06 +0200
Message-Id: <165536598378.1275350.14174129398362283973.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220615054254.16352-1-samuel@sholland.org>
References: <20220615054254.16352-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2022 00:42:53 -0500, Samuel Holland wrote:
> If the component driver fails to bind, or is unbound, the driver data
> for the top-level platform device points to a freed drm_device. If the
> system is then suspended, the driver passes this dangling pointer to
> drm_mode_config_helper_suspend(), which crashes.
> 
> Fix this by only setting the driver data while the platform driver holds
> a reference to the drm_device.
> 
> [...]

Applied to drm/drm-misc (drm-misc-fixes).

Thanks!
Maxime
