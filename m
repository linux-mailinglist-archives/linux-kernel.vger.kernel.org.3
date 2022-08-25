Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BB45A0AA0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbiHYHr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbiHYHrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:47:25 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16679D104
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:47:23 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 054785C010B;
        Thu, 25 Aug 2022 03:47:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 25 Aug 2022 03:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1661413641; x=
        1661500041; bh=8JWOzf32GRpIDkXSkVqxDewn7LWG2w+DtZqaLHYL6Mk=; b=l
        8JoX4ibDUsCMUTjE6hXvNSd1F7ZiCtmby1NEHX7d/jgCiGmr/IWPftx9eNYUE4Hn
        yvspo6arUJA7r0pdnbxa1R4GAH+sDVkicesrpWjGGzh7l4B93c4iJo0OzpNd/5Jm
        2txn5aUucAORn9ebKbM1/CsMN1YQd1kSxKpkkXdw99QkPIIv6lWLxO2Asxj4GbT8
        uKC4tpTd6Sx/IXwoQnpUvg4LHpWvCoKLzYfVxHXMEUUDuNbYRIJsQPlegj3IgcFc
        DETjEfaB6odlJavHczRT5WcHy7ngWd6VspY8g1Lh4x969+cK7XL2GP4EB4vZ9kHK
        mpuzZujTx2mG27wuDOLDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1661413641; x=
        1661500041; bh=8JWOzf32GRpIDkXSkVqxDewn7LWG2w+DtZqaLHYL6Mk=; b=V
        R2pTT4dZgDH8Q1MRInhpVviTZjn4g9TgZycqA+1zRkO1Jh71GN58mkPS8Pzqfjdv
        +I+v4/2wxQH9jpOtjVSdP5hyfTTQXxjDdA7wljSFnU79v7i/fDSbUGrt4FvV3M3T
        d4dLWikBGAolNGJtLPrqaB9b8NgzQijTFMvEIPAcCmwEX6gf3PmYvHwxJ29u+JVW
        h4RQF3x+QFXVxmoI8BibwpB54hII9hGkCibbf0IhufaziKkHQOY1+5RT0MTYu9kg
        EF4KVaRV1F04EGFnFdY7nMpsDXgttG4oayOVQ8ouLpPMLOV2rGiy35ZwxASGTjGY
        ZRVD4869o/8uwTe0naqLQ==
X-ME-Sender: <xms:CCkHYzvEdLzsaXO0HxiBM8r_pJpTHn1EjebxtqcA77D3scowPHnFpQ>
    <xme:CCkHY0erXn41gXp5pQH6jslUWlDsD8hZwET9BenOClioHcbNpx5iccl4YcTN4-aoT
    SExkM0fzO5PkldXkhc>
X-ME-Received: <xmr:CCkHY2wPBUsGZZQk39pjuqgciwVqzcAskmg5XbDHHQd9keJDzQ2JWhYcHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejvddguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgse
    htkeertdertdejnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgihimhgv
    segtvghrnhhordhtvggthheqnecuggftrfgrthhtvghrnhepueeigefghfffffeifeehud
    eiuedvteegueefffevgfetvdffheehkeffvedufeeinecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:CCkHYyMFdqGzik2BP4KXKdcvLiPXv1oaUVRCbVrbMqzQuenFuI_abQ>
    <xmx:CCkHYz9mZRouIaUGAWAcI2inU326NYN8F6x6XY8BEUla9oYptTcaZw>
    <xmx:CCkHYyW_A7ztE_YfIAjNuQSbLGpRyMjMUplCAj76vkL5Xk_C2LokPQ>
    <xmx:CCkHYzyuV3lhVSvjaESp23lDfoY1CB9OwtRGunLT9LEyzcRmWzHRbA>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Aug 2022 03:47:19 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     airlied@linux.ie, daniel@ffwll.ch, tzimmermann@suse.de,
        dakr@redhat.com, mripard@kernel.org
Cc:     Maxime Ripard <maxime@cerno.tech>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH drm-misc-next v3 0/4] Fixes for vc4 hotplug rework
Date:   Thu, 25 Aug 2022 09:47:14 +0200
Message-Id: <166141363051.357827.14816951155409708010.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220824161327.330627-1-dakr@redhat.com>
References: <20220824161327.330627-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Aug 2022 18:13:23 +0200, Danilo Krummrich wrote:
> I've found a few potential issues left after the hotplug rework.
> 
> In vc4_hdmi.c we're missing two mutex_unlock() calls when the device is
> unplugged.
> 
> vc4_crtc and vc4_plane seem to miss some drm_dev_enter()/drm_dev_exit() calls
> to protect against resource access after the device/driver is unbound, but the
> DRM potentially isn't freed yet and userspace can still call into the driver.
> 
> [...]

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime
