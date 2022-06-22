Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0E655440B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 10:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352950AbiFVH35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 03:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351000AbiFVH3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 03:29:55 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF66536176
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:29:53 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 323365C00F5;
        Wed, 22 Jun 2022 03:29:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 22 Jun 2022 03:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1655882993; x=
        1655969393; bh=AmPPkv8TRJDdVGdwTv7YeNX5VQuwyhjTDffwx2abUjM=; b=Z
        Ps8FYZ5Securp3Rllk7t7HgNxbdvSo4DmwyMmxRAH0ZPFqe5sSs4Pq5iri3/bybw
        jEfFR1YPwUI+9i7v8WwIpNbYvWmaBdrivSrV7ndYCwaNruXPTVItx956QNbTToz5
        l/tHxbs1OvKQphuIN+xwsnoKgpBfZzDA9VBXSgY8xNffe64FYVYR+N3ptJ9hzTUg
        er4MoxQIS3dAYuGKVJyk8R0jpt31XRAQpJjDHj3iMTVfaNr0FX18Y4oMv7sWhXa8
        Sle8ajU5zSCRjKvVsO+hl7B8LeDcdoHCx6TPganDVpe4yShwr8lxedgJLO7pwRI7
        wgpmXsg0xZy/CtJzsaF/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1655882993; x=
        1655969393; bh=AmPPkv8TRJDdVGdwTv7YeNX5VQuwyhjTDffwx2abUjM=; b=a
        Nl9T+M47Yltv7enDnSjcsoQiQDcuZ7P0FEnrA7oYagEB9kD8MEq/JdyBP6S6h5ph
        toCbSpE5Lt495J9qqLzl8v+HpCCfPCgb/YuR9MA/aJGmKv337EvNPzaTSzhmrbjT
        JvLM+MPn1rss42kTilTQew4PaB6e6JD8uqacYZ0/GbP38Wxn5YS45wdidtleJYsX
        gRhkU+knjkrv3ff29YcZ8auAPAi+WozGPbydZs8uJRcyIHEsdux9Sus/HVAVwd7u
        fbkrQkiEGJ7qe4M3tO8mZ3xYQCyVI5tB5286F7lwQEqaYEVwo9t9z8/YajzzyQB5
        aPtvpv0HNMILfZKtiTmxQ==
X-ME-Sender: <xms:8MSyYj-GnKXvNAlhbhlm_rPdFLRS1Sg98yYYaiMdiLBOhVBR9sjgkg>
    <xme:8MSyYvveS9A7Qa9AjjGFD8wqOixUQDpKZw5JHd0n44dkT48LlVZhcA3AVPufDA_2n
    DPVZI6m5NHkDJSi684>
X-ME-Received: <xmr:8MSyYhDLZwtp-98XnVRiGAlPd-B3QTy7dlTKRujDZ_2v4GgcMImFinrzuldtHrRhi2Olh4E_tq-d4EpOSgNFq3nICYbMAPoJTPvxASI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefgedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgse
    htkeertdertdejnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgihimhgv
    segtvghrnhhordhtvggthheqnecuggftrfgrthhtvghrnhepueeigefghfffffeifeehud
    eiuedvteegueefffevgfetvdffheehkeffvedufeeinecuvehluhhsthgvrhfuihiivgep
    udenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:8cSyYvdBRXP8abMapwkYg1SLF8TIUkHiNo331Rg2w1gCNTZZXhDzdw>
    <xmx:8cSyYoPEuIvWx1cLTfpU12cePCXQ4lDxeXa6VgS52XG0tFeO30dbZQ>
    <xmx:8cSyYhn648FqhcumcstyBBKdS8UhiUk5kEvl_FKk3unjwAluYyDgxg>
    <xmx:8cSyYkD5w2Wi7527k9EQg5KnNfWMJLUpI8xyuNer_qMwkxnYFTh-Uw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jun 2022 03:29:52 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     daniel@ffwll.ch, jiangjian@cdjrlc.com, airlied@linux.ie
Cc:     Maxime Ripard <maxime@cerno.tech>, mripard@kernel.org,
        dri-devel@lists.freedesktop.org, emma@anholt.net,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH] drm/vc4: drop unexpected word "the" in the comments
Date:   Wed, 22 Jun 2022 09:29:43 +0200
Message-Id: <165588297922.13818.9995811624453114633.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621130550.126915-1-jiangjian@cdjrlc.com>
References: <20220621130550.126915-1-jiangjian@cdjrlc.com>
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

On Tue, 21 Jun 2022 21:05:50 +0800, Jiang Jian wrote:
> there is an unexpected word "the" in the comments that need to be dropped
> 
> file: drivers/gpu/drm/vc4/vc4_regs.h
> line: 267
> /* Set when the the downstream tries to read from the display FIFO
> changed to
> /* Set when the downstream tries to read from the display FIFO
> 
> [...]

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime
