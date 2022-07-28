Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC79584204
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 16:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbiG1Omq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 10:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbiG1OmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 10:42:23 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008C112D24
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 07:41:53 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 8B7185C00ED;
        Thu, 28 Jul 2022 10:41:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 28 Jul 2022 10:41:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1659019311; x=
        1659105711; bh=XYhfyDVH0yHI3jIlMNs9kEOh1alcltQ7znsPGjCUPlA=; b=h
        fBqnTr/PrWy8B8BCKM9HIsotNih32VBh8Mi72h8yG9BBdpFFdAPVKPRKpg7EMNrI
        8aGO3Q04xxu7zWtEHdz7F7Thy3xeg63r2mQ+DWXpe+uMUU3kZ15sNE7ojQ19ySk3
        SCpA2kVP4HHwg9a3l121ycXXk+kF8BVkHLEon2VjcDWpQ9vx/ofkwpMhABGRsGIU
        ece+DYg2wAN8DF/mN701BYBqU0DBNS5Pvdk2WKakvhg4Y+sJ57ZBhlYaLt8GVgNd
        UNXXRssv7D7H7c+VfnctAfuCmdVNgmKxa4su97i1Dpm2ZCXd3kcI0IE15DR9QptL
        zYd8yg/doMj3fUX6vOh8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1659019311; x=
        1659105711; bh=XYhfyDVH0yHI3jIlMNs9kEOh1alcltQ7znsPGjCUPlA=; b=O
        qyaHRyMP1iAz23MRnfnPg4UFHAgFoXsTSnp7UVtpr55OSfmlsxNoZdEghOOEcz0G
        LqQiAvY2gufzN/znLIlYDVjqi9woC27EjcMiPvpZpA+4i/W9uRqBGTJebumfBvt9
        lStBldI9d+ezKLjKC7wHH7hftN0UUseTtzyg4oP/t/n2vDI3Ox5b34ZYZgFMAn2J
        ozuNQlc56PBagyfJtd4GlgBvafPXldVHD1wSAE4gkV4AZxPlt/0tNXUjhO2mov30
        3/BQI3k++ctwMML5qJI09URCwclRo3iUTbN9LQd5c6265WmVNchi7b+/oKpE1s94
        L+PEgRiWN587zOXENEkYg==
X-ME-Sender: <xms:LqDiYk62tEB--HnAFE6B1qLXh2XZfj2sxjKs_8UkN3n5qAc0ytIZyg>
    <xme:LqDiYl7PmeQ-XYTCVVCeq3lUicAWB3ojpIuGjdtOEMkS0R_zPKtNDoriyuPXE3GP4
    HhY0gUyPxfH_nYhR-Q>
X-ME-Received: <xmr:LqDiYjcX1Ctb6AIBN6sLV_QW2iEUAfglg1ntQsx5R6sicvozXIxg2JS1eyo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdduhedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepofgrgihimhgvucftihhprghrugcuoehmrgigihhmvges
    tggvrhhnohdrthgvtghhqeenucggtffrrghtthgvrhhnpeeuieeggffhffffieefheduie
    euvdetgeeufeffvefgtedvffehheekffevudefieenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:L6DiYpK4wJM9422Q8LwfH-Q3J3HvUbpAIkD3aNhiQP9Ls8Zp_Q6h3g>
    <xmx:L6DiYoKGvQ1XPM_rkbAX9CzYDyvNf3ZkQ8xd9fNcocQK0qc75kBWqQ>
    <xmx:L6DiYqytSV1Bhgb8d9Yf45v-3fZf062Rp89EOVeDEX6z1JggEst7Hw>
    <xmx:L6DiYg9LFF6nKG_SuQVB5_MuWV5jQ8_GwbZ-bmbyl6ksYoimtFUj5w>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Jul 2022 10:41:47 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     emma@anholt.net, daniel@ffwll.ch, dakr@redhat.com,
        airlied@linux.ie, christian.koenig@amd.com
Cc:     Maxime Ripard <maxime@cerno.tech>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 00/10] drm: use idr_init_base() over idr_init() if applicable
Date:   Thu, 28 Jul 2022 16:41:41 +0200
Message-Id: <165901911294.5946.5075667196143577988.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220701185303.284082-1-dakr@redhat.com>
References: <20220701185303.284082-1-dakr@redhat.com>
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

On Fri, 1 Jul 2022 20:52:53 +0200, dakr@redhat.com wrote:
> From: Danilo Krummrich <dakr@redhat.com>
> 
> This patch series initializes IDRs with idr_init_base(&idr, 1) rather than
> idr_init(&idr) in case for the particular IDR no IDs < 1 are ever requested -
> this avoids unnecessary tree walks.
> 
> Danilo Krummrich (10):
>   drm/amdgpu: use idr_init_base() to initialize mgr->ctx_handles
>   drm/amdgpu: use idr_init_base() to initialize fpriv->bo_list_handles
>   drm: use idr_init_base() to initialize master->magic_map
>   drm: use idr_init_base() to initialize master->lessee_idr
>   drm: use idr_init_base() to initialize mode_config.object_idr
>   drm: use idr_init_base() to initialize mode_config.tile_idr
>   drm/sis: use idr_init_base() to initialize dev_priv->object_idr
>   drm/v3d: use idr_init_base() to initialize v3d_priv->perfmon.idr
>   drm/via: use idr_init_base() to initialize dev_priv->object_idr
>   drm/todo: remove task for idr_init_base()
> 
> [...]

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime
