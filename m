Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362CF57C8CF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbiGUKSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 06:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiGUKSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:18:07 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294BE82384
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 03:18:06 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 4FB0E5C004D;
        Thu, 21 Jul 2022 06:18:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 21 Jul 2022 06:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1658398685; x=
        1658485085; bh=VxmrbcgCBo8VRdl/iMbbYGK+hF+N5u4RIhBlQPOzlGk=; b=u
        yqzwxKYqY0IS6wTem5NwhoqoVXxPEG0gB0hSK/JvcRpU32o4uv5TUKkMflXojwyB
        5aIiBvF7Bx4cjFV5Giv8C1SV7+RROohvvVxJS/cWTAsv4QiaRuhuZ2tv1jg6uGPA
        szp19QbWKyCTxGBP2offWDA39eVUk96xpYoQ7F+A66Tx3CU9MkW+3UirMxA+6OmR
        hMd00/J6pYhkgKjIK/RU1MkSiqpfqMWPlUwUNDYhnQW8nYC9MTTu4Qz8xcS/0Vz1
        9oqNviHcOiDKuGlZzLZvKdJKcRl9DLxBfHTdVDNSfxUlvqmKJ0LPOXBCsmIO9uMJ
        nMYjXZkOKXhpg/A5LejNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1658398685; x=
        1658485085; bh=VxmrbcgCBo8VRdl/iMbbYGK+hF+N5u4RIhBlQPOzlGk=; b=W
        p/1baUl7P/D+SGtff+fQgqaEYoyAIYuPRBtVsl794hjIUAhtgzstu7/x6V7AwBog
        UB1xgq2HU7QDZsoQj3goRKQxBW5BPKfqXiB2ia1TkGNFmXKjXu6OKPPGvrPddMKk
        XjOYvJD+vucVrg3skL7a2tlenVzEepQvWHbTFAR6oz8rR7hcAyPXFkaj3+ce3922
        48h2Q5MInjI16AUSKzZoaCijc6r1fshWk/DTwldxcAIfwcA4f8f422o1/8JwjkcV
        6vMfMtMaaZAcg9hSpHm5NEBI9gx3MnXCCZPP9wsjQZprTZ2drv6vNGk3Ls1ypwAh
        Z8W86rBW5T4pb2e1+0o9Q==
X-ME-Sender: <xms:3CfZYotJgsFsGd5VeyJ-XDsIWM2BLqstygX7HnM_Nwg-UfmUft4aGQ>
    <xme:3CfZYldOphAjnKh9q7W1UbH3tTmDNHT_RNDyVpQTxRW9Fv-4x4QCXKd0-x1wB5W_S
    CoFfzeN3YS7lqPS7wg>
X-ME-Received: <xmr:3CfZYjzdxSJrbAFCIXtdf3jztsXBa7dKakbGHyTLEEv55M971Pp_j1LammMkn0OyMOqQkKho5I43z3Vbr8dTImv9LHF8zQ0jwEcS-_o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudelledgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepofgrgihimhgvucftihhprghrugcuoehmrgigihhmvges
    tggvrhhnohdrthgvtghhqeenucggtffrrghtthgvrhhnpeeuieeggffhffffieefheduie
    euvdetgeeufeffvefgtedvffehheekffevudefieenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:3CfZYrOGNtM0BZ4FWgK4y9hzYD1jDkcevdo7699GnofS-YS0ot946Q>
    <xmx:3CfZYo_wg47yyRMGYNi3aEC_sna0p_TfRVSg-xvUIKS8GbUkUU_fwg>
    <xmx:3CfZYjWDCH8a7_qrQpoGTGB2DmUmEZBSmVJWuLfV3lIOTz1D0Hkvng>
    <xmx:3SfZYja6FlTMQCcWavIjgCu3gnSZdR5sFk8UmaISbueW_pE0wj_klw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Jul 2022 06:18:04 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     mripard@kernel.org, maarten.lankhorst@linux.intel.com,
        airlied@linux.ie, dave.stevenson@raspberrypi.com, daniel@ffwll.ch,
        wangjingjin1@huawei.com, tzimmermann@suse.de
Cc:     Maxime Ripard <maxime@cerno.tech>, dri-devel@lists.freedesktop.org,
        zhengbin13@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH -next] drm/vc4: Add explicit declaration of 'drmm_of_get_bridge'
Date:   Thu, 21 Jul 2022 12:17:58 +0200
Message-Id: <165839867633.1851550.7144468143657941945.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220716020741.4124893-1-wangjingjin1@huawei.com>
References: <20220716020741.4124893-1-wangjingjin1@huawei.com>
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

On Sat, 16 Jul 2022 10:07:41 +0800, Wang Jingjin wrote:
> Fix the error of implicit declaration of function 'drmm_of_get_bridge':
> 
> drivers/gpu/drm/vc4/vc4_dpi.c:278:11: error: implicit declaration of function ‘drmm_of_get_bridge’; did you mean ‘devm_drm_of_get_bridge’? [-Werror=implicit-function-declaration]
>   bridge = drmm_of_get_bridge(drm, dev->of_node, 0, 0);
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime
