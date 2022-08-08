Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4038A58C1FA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 05:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236181AbiHHDMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 23:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbiHHDMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 23:12:05 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA42D13B;
        Sun,  7 Aug 2022 20:11:42 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 710825C00E2;
        Sun,  7 Aug 2022 23:11:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 07 Aug 2022 23:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1659928301; x=1660014701; bh=BWrq530Yi1I3dmxdq8vxnTzT+
        iGogUxpXiCb2TQsl9M=; b=jnItUAoTOjbFkOCaxufe/kX8E6k/F1rDt507harOu
        5/aONHuHeoPXesH6Jtpco2HQ7Vzk679oAMCcNOZgzuDL5mnZRKVpkha7mVHWvBTv
        tEGPUURRCKAVOFI3wTHsoAix1QP3F94Tzi2yGnkI2DF6qlKwUxbWI2KvipybyrSk
        nnz5audqxEaZhvOiaOf7G+gkdGpttYP8TnyyU5lpU3jyARXjg1ZKK3C8/BYSaTB8
        rWvOUxaOELWFihuw2L4H2zIHM7EgWcu+scsi6NuFq5+QkeSGGdvHrAhacX7Adhoz
        b9fCF5rx/NcbmsAYC7511qHwNZ7g/BE0ngWfPZrqCSlyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1659928301; x=1660014701; bh=BWrq530Yi1I3dmxdq8vxnTzT+iGogUxpXiC
        b2TQsl9M=; b=ydqxetggBK/kaZqvy3By/8sgSiNKEZSQrm3M9xuIZ9b+UzK8XKm
        3KNUF2WevPx4qFLadQB/oMr/N3MzGbbClxoWOa5ETY/Wtbvk2eZLLtveXgJLrZOf
        lebwxDE/NPMsTEB+t3MDfMwGQ8/HHh0za677jS4y1GFRBvTIiTB6xb3j6GSOiS8d
        SzBQfTGcPteSBFGX4WFbL7gc3O7txypFtVfZ7FPO8yKeeOvCN0PV1YPefBOzs7NN
        RxOx5ozp7rGEQ6frE5bqeEQV2w3YQO8GndFf1t8J9LoYg7WGXCVnrLANBq6PDx2P
        dJ722ZU35HaYXPBWTnbLQsvdr5k9JsfReqg==
X-ME-Sender: <xms:7X7wYuV9lMAhS7cR6kNQYgMM2st4Rfpj27MRK-imZLEDSB82dJ5ONg>
    <xme:7X7wYql0Z1XF6d0rN7epiLhjjsXa-QS1a97DybxT1kqKUA8cMqLo6KleHuRBf7pt8
    hYl73oU1FV802Ynyc0>
X-ME-Received: <xmr:7X7wYibaCGGTgqveO4SIAKi2RV7Ax81XDTp_qHPMWUvyzdzpy06Q20ZwqtBT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefjedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgeegieevfeekleejvefhkedvhfffue
    egudeljeeiieeuhfegkeehtdevuedujeejnecuffhomhgrihhnpehlkhhmlhdrohhrghen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvg
    eslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:7X7wYlVyrph1-cLHnnOhoJ6pDkn_5t7TqaQCk1K6ZY4z3xBPXnQEBQ>
    <xmx:7X7wYonQnhWZsiQzH7fGY-APWPGXnJNWpfmh5DW0YFnX5Y6KWv3yVw>
    <xmx:7X7wYqd8LHG985gnRf9OZNVVDkqFwp1KJR8rfLtBoK5Ntsy7ao-m_Q>
    <xmx:7X7wYtwFlmRyXVjnUHtbRH4d9atk32Y_iy7ychJduIWdZuSkRt6m-Q>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Aug 2022 23:11:38 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 0/2] asus-wmi: add support for ROG XFlow tablet mode
Date:   Mon,  8 Aug 2022 15:11:30 +1200
Message-Id: <20220808031132.10075-1-luke@ljones.dev>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series refactors a part of the tablet/lid-flip code to
use an enum to set the different behaviours, and adds support for
the ASUS ROG XFlow (X13) 2-in-1 laptop.

Changelog:
- V2:
  + Refactor the base handling paths of tablet modes to use enum
  + Add support for ROG XFlow using the refactored code

This obsoletes a previous patch I submitted:
- https://lkml.org/lkml/2022/8/3/94

Luke D. Jones (2):
  asus-wmi: Adjust tablet/lidflip handling to use enum
  asus-wmi: Add support for ROG X13 tablet mode

 drivers/platform/x86/asus-nb-wmi.c         | 30 +++++---
 drivers/platform/x86/asus-wmi.c            | 89 ++++++++++++++++++----
 drivers/platform/x86/asus-wmi.h            | 10 ++-
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 4 files changed, 103 insertions(+), 27 deletions(-)

-- 
2.37.1

