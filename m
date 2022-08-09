Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F38158D260
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 05:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbiHIDbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 23:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbiHIDa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 23:30:57 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BD8640B;
        Mon,  8 Aug 2022 20:30:56 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 9EEA95C01CA;
        Mon,  8 Aug 2022 23:30:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 08 Aug 2022 23:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1660015855; x=1660102255; bh=qF550eH5VOcKt9w3Exq04HQ5z
        lTuCvWjlWMtOxOLmk0=; b=D1nZs5rDmuK1GJKOP/gQjqUE5mZvIFC5GDp4zUa6i
        WY3IlFx2YEQJ62V1VgC4/Cf+M7pGqGnHgqnjyyNQJOEtTINw81hS7/JFbKFYpjiu
        OFPiY8m4e1tmIWGTQbJRZeCgdH5fvNXE95yhdBcDFSoHPThTgaG7GX7leqxQNdMo
        qHQowAaZpVSmyTjTMimsIMLhkF8I3bD0WTfhpTXgzijZQ4OEnqBdFiGmbmYvDtiU
        H8X6GGjE3iLjnDvPZQm2xkhWD4PaatNuggnwk4KVMUyrKJY2MlEUEVRyEIm5G4LO
        k7z0ey0DSM+nARXWXIoKeSeH0e9fOrXFLDe86y/XYFnBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1660015855; x=1660102255; bh=qF550eH5VOcKt9w3Exq04HQ5zlTuCvWjlWM
        tOxOLmk0=; b=ETTRJhy67dbmH6DIRTwyCnVtxZCpr1yW6gZrYMkw2+vtguaMzWm
        4F+Uvyz2px5y1SsG/zLnakR678bu5nU7Toq4S9aRNLxMvGd0YToZ1QKG2Vsi2EaU
        dTdjoSn+6n1qQaIDvv52YwYa60hzvF8IGjne6tG3DaUf6Rc0dVLTMceuEgpUtqDu
        QgUdbHtTxskk/ttoGp50CmK/r/6oOkv0x49oH+0BxNgxlXQc7+pZMkW60xe8bpji
        cqCyoWYGgh7HZLfFZesLSnGN1cY8mQCM1CULSCVm1DYDi8HAJqzI/FTj5H6a4DKs
        k3tLTYK0pBSZXtb6OLfGS6Mq0PjKroVkGCQ==
X-ME-Sender: <xms:79TxYu33cXQWZfGhVRXArXQFEHzoKZQppf42BNTjKQ0DK1zP45Rl1A>
    <xme:79TxYhGat1VliB2TrZJI5ITys3JM7WOvJXwAAUkBOR0YulTQyT1PUShyOmK8EptgD
    I61_jP8pnVmt9VutHk>
X-ME-Received: <xmr:79TxYm43pDAPJyOeDO6ifaQ4ZCbZQd8YDVJ_o6rYigTlwg6c7-Utzjnyd6OC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefledgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgeegieevfeekleejvefhkedvhfffue
    egudeljeeiieeuhfegkeehtdevuedujeejnecuffhomhgrihhnpehlkhhmlhdrohhrghen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvg
    eslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:79TxYv3ZAwJ6HFu4oxadwdgLKYRrL1mNpMOXZftBqOrcu5YjooT2oQ>
    <xmx:79TxYhHj_OgeQgSjPLOH4upCIvHtgvJWkJblCrFJUE7KaHEehlhFhA>
    <xmx:79TxYo-QQPoSJlMc2s_h_WMUQ12UQM8DjGPSCGvViX_PSs17FSeY9A>
    <xmx:79TxYmTh4DZxzLEQDBW6kuC0mFjAup_F9_4YRSR2lm0Kw6_B-LM2-A>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Aug 2022 23:30:52 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     andy.shevchenko@gmail.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v3 0/2] asus-wmi: add support for ROG XFlow tablet mode
Date:   Tue,  9 Aug 2022 15:30:46 +1200
Message-Id: <20220809033048.1634583-1-luke@ljones.dev>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series refactors a part of the tablet/lid-flip code to
use an enum to set the different behaviours, and adds support for
the ASUS ROG XFlow (X13) 2-in-1 laptop.

Changelog:
- V3:
  + Use dev_err() in place of pr_err() in asus_wmi_input_init()
  + Adjust declaration of variables vs instantiation to match expected pattern
- V2:
  + Refactor the base handling paths of tablet modes to use enum
  + Add support for ROG XFlow using the refactored code

This obsoletes a previous patch I submitted:
- https://lkml.org/lkml/2022/8/3/94

Luke D. Jones (2):
  asus-wmi: Adjust tablet/lidflip handling to use enum
  asus-wmi: Add support for ROG X13 tablet mode

 drivers/platform/x86/asus-nb-wmi.c         |  28 ++++--
 drivers/platform/x86/asus-wmi.c            | 104 ++++++++++++++++-----
 drivers/platform/x86/asus-wmi.h            |  10 +-
 include/linux/platform_data/x86/asus-wmi.h |   1 +
 4 files changed, 112 insertions(+), 31 deletions(-)

-- 
2.37.1

