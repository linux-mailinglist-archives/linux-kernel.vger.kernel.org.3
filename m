Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66A55083ED
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376393AbiDTIrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244150AbiDTIrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:47:03 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DBB3B3DA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:44:18 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id B70663200953;
        Wed, 20 Apr 2022 04:44:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 20 Apr 2022 04:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1650444256; x=
        1650530656; bh=t7DoobfDMY7dUicjX+qlluqPD7Zao8qnodbFi7wyI5A=; b=t
        ygCaxN0wtkpwICLP3YBCcWZFOQ4IbeDTJ8em3/45AGOJ6ytwCMYqq/oG24e0QZHQ
        549yvDtJMZgSjAvEV9MHcf7kN8tTO0Kh4dNGmrXOEcbzdu9cm2Me7iPKjBSfc0Mq
        r6zLomXir+eHc0dCBaKgC4XtiY4QRke/BF7JHUQQJF4pYVl31V4Np895UBik6753
        HrhSuPYG9x7SYY6rCGoPp2r+qQ6AJAsmcPr39gy3ELrmEoqmhntiHT9vPKFDiEvW
        qsLpPo3hQ5vCwT3BBQhwEs3rsFzjii90Ap7s/8cfg8tY0pgMXATz51rVqHYQO8VN
        hdMx+U3dqQ3Snhq0lYurw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1650444256; x=1650530656; bh=t7DoobfDMY7dU
        icjX+qlluqPD7Zao8qnodbFi7wyI5A=; b=DQczOr0mdxvfH63u3aRSvK33yUvkg
        hwVbbAnAuu6w71U03yBmgffc5IPBWtEWYaqFWIIpYcBI5gFRfYcxxz3IvpAabkZp
        BRSCYNaHOjdylO6Nit0AfRBpUxqgiJkAbyAk9cZSl841k5QXDSL8MkPXh6p9Muui
        h6VG5/zm4gGr8A0rYKfZdnI31WUiaxIvNxUivA4c0jb8kv43g7X+q4w+1SZiORJZ
        HWx9qyxkxJZ4JdS2ayxEkQN+/lhSZrKrjC02hq1xeo21uvj5bmo7CMHjlFZnuDl8
        Ux0FvlppZhBiL0FQ0ysyNunFaTfM1g03gHiupkqO4q8sG7FEKr+iPsC3A==
X-ME-Sender: <xms:4MdfYrIMOf7vpJZ6IzW6U5gk0MbuYJ-apbWZY8i_1_cu7yCvsBk2ow>
    <xme:4MdfYvJvwNfQXpTgDqqES-TroPLS1t6QdhnHmMd-li4hm97Hapt4kUI39EsDAocuK
    tI365fdUBKRHhy8hgc>
X-ME-Received: <xmr:4MdfYjtu-8dtpKX3Xr2T7ZCN73WjGcNifmV0f2_6bLijrK_mODM7zJYV-5mhdFSHAQHRsjkrHehz2IyCooDQwcDEsQlIOWe8CRGsYN8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrvddthedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeejuefggeekfffgueevtddvudffhfejffejjedvvdduudethefhfefhfeeg
    ieekkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:4MdfYkZdXhgiPBHJe1laeM8vkDWI63we8zrIoe3Dpn8oLgQkM7Y-1w>
    <xmx:4MdfYiZfxhSel47962QfHcz05I3V0iuPfT-dpHJcIbvREVj88ssr9w>
    <xmx:4MdfYoBD4T0JUPARMGR5f15Shu6XU6f2pWg7DUJDHdNk1RferhAjfw>
    <xmx:4MdfYq7azbT0uE5736JSIsiMJfWp3EO8iPivYieFh11DLk5Ygpt8Cg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Apr 2022 04:44:15 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     mripard@kernel.org, emma@anholt.net, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, Zheng Bin <zhengbin13@huawei.com>,
        airlied@linux.ie, linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime@cerno.tech>, tangyizhou@huawei.com
Subject: Re: (subset) [PATCH v3 -next] drm/vc4: Fix build error when CONFIG_DRM_VC4=y && CONFIG_RASPBERRYPI_FIRMWARE=m
Date:   Wed, 20 Apr 2022 10:44:13 +0200
Message-Id: <165044423683.307255.11242921417617655496.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411024325.3968413-1-zhengbin13@huawei.com>
References: <20220411024325.3968413-1-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Apr 2022 10:43:25 +0800, Zheng Bin wrote:
> If CONFIG_DRM_VC4=y, CONFIG_RASPBERRYPI_FIRMWARE=m, CONFIG_COMPILE_TEST=n,
> bulding fails:
> 
> drivers/gpu/drm/vc4/vc4_drv.o: In function `vc4_drm_bind':
> vc4_drv.c:(.text+0x320): undefined reference to `rpi_firmware_get'
> vc4_drv.c:(.text+0x320): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `rpi_firmware_get'
> vc4_drv.c:(.text+0x34c): undefined reference to `rpi_firmware_property'
> vc4_drv.c:(.text+0x34c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `rpi_firmware_property'
> vc4_drv.c:(.text+0x354): undefined reference to `rpi_firmware_put'
> vc4_drv.c:(.text+0x354): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `rpi_firmware_put'
> 
> [...]

Applied to drm/drm-misc (drm-misc-fixes).

Thanks!
Maxime
