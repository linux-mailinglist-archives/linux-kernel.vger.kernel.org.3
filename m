Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BF35887A4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 09:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbiHCHA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 03:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235720AbiHCHAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 03:00:23 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF8B2DF0;
        Wed,  3 Aug 2022 00:00:19 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id AD2A55C0191;
        Wed,  3 Aug 2022 03:00:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 03 Aug 2022 03:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1659510017; x=1659596417; bh=+gTBcYC+2A1JB0zNrZSP+d5om
        3sDU0TQdNoYk8eLrMw=; b=DzB5OCMlbe0VN/tksufVYGwyc5noiHlem8W0aW38o
        0b5voTBdto96806uSnc8HGNQ0GVE0cPPTTNuXqarc6eOvC9idqkKEUZood4FctXP
        zAaXbcBzbbIJfHzEeJ5yxID8T+E3PIAjUJmi0baMojSGSpehCrf4LRTpDEdC3gWS
        o+JvO+5HZnChek7Nt83QXNmngx9jdfxO8xmRrmNKTAqeJQwhxNh42XEf3aPTWyuI
        empunrRMQRbUr2Hl/q/x2CgBDpSFQK2pqFPPoKjqg/8tjvp5vbRRSRN9x3mRfd+K
        W/Me4/elFwrM1p+B6ICSA7wHnGQBS0WAmM/cnov3hFKCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1659510017; x=1659596417; bh=+gTBcYC+2A1JB0zNrZSP+d5om3sDU0TQdNo
        Yk8eLrMw=; b=hVq7UuqZ+L57RVNU/NtfQjZzAqkN6V0RB/hZtQUU5OLilujslqW
        oqm93jWeuXDjDJlTJKYw7JqjfI4BoKBM05OBLB+Oh0ectnCUPQf9unECyIy2DP3x
        0XMzcL+4G7qZewJ5e2fEgbqlmzhwDRP3BpHF32Z7yhLGF4I+Z6jrtYeDsuAPnTye
        dWywEgbZ7bcfKeJ1gigcSMNkFyh+Sl5TvSj0siBRe+mh8ANLrqqGvMM1okRcBuGB
        sRa+B8xMLTAzQbN34OQ0VuZ801cCYPhTlnQSBVpsJmNPHzf0G4Hhcu4lCALmw3/5
        z9g2ofiMDPS+9E7xIWgW4E7cbF047/POK/w==
X-ME-Sender: <xms:AR3qYotCayDzUQHdqMXPUhUCss9jutiB7WOUcq55sP2ESp-rkOJSJw>
    <xme:AR3qYldTjlV9FoGqw0y7TTspO076V1_pyhNKpSY4CNp66zJTKmZADS-npulddpkmH
    f_zLVfujTovnePW_7s>
X-ME-Received: <xmr:AR3qYjz-DYrtkBkuhuSrECnDBRugsh18gOME_EPIrWa6G7ZgdqW_bM89eY4E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddviedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekre
    dtredttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhj
    ohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpefgudejtdfhuddukefffeekiefftd
    dtvdfhgeduudeuffeuhfefgfegfeetvedvgeenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:AR3qYrOTkgaMt6hd003OjinFeO9eiT8m-ILFYjMzPFDR2nxYCo7snQ>
    <xmx:AR3qYo95YxyNIeq6Af2RVIH9htQP62657rXYY9jBBNv2P_ZSYaxFSQ>
    <xmx:AR3qYjXYSwh_lubH2R5lsOL9fUhpZLtvLOMnRa_wAsU9zqp2tseTQQ>
    <xmx:AR3qYqKJyJDR1WAK_5psv5DA1Wrv21j-uwwKfKmtTJ135wklFvIzcQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Aug 2022 03:00:14 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 0/1] asus-wmi: Add support for TUF laptop keyboard states
Date:   Wed,  3 Aug 2022 19:00:07 +1200
Message-Id: <20220803070008.770147-1-luke@ljones.dev>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an update of a previous patch:
"asus-wmi: Add support for TUF laptop keyboard RGB"
to remove the RGB control, but add only the state management which
doesn't require the LED interfaces.

Luke D. Jones (1):
  asus-wmi: Add support for TUF laptop keyboard states

 drivers/platform/x86/asus-wmi.c            | 82 ++++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |  3 +
 2 files changed, 85 insertions(+)

-- 
2.37.1

