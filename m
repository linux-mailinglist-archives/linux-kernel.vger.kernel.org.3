Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C84C5A1DC3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 02:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbiHZAmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 20:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236252AbiHZAm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 20:42:26 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1101B7B8;
        Thu, 25 Aug 2022 17:42:25 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id D77F65C00AF;
        Thu, 25 Aug 2022 20:42:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 25 Aug 2022 20:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1661474541; x=1661560941; bh=AfgCL8boy2TW8uZyKX/Jg67NQ
        iKK/5+YTKm1qxIfL1o=; b=gREzFvfTPftKlll5MGh3sWccqtUAB7jkBUrjNNf6a
        AfAxmx82Rbmk7lfERMJpRBlf93+4BWfCkimX8J82wamxfWLB/TwWkhybXsPLjnle
        iqd6CI1WLE5jU1lXTWe403i48754R9sS/Iu//GIOZ1OKvuzQAmZ6EG8sFj6zRIA4
        0u4UOFvG4AQQyShWbDpW+1htAnkSq5xTk1rgA9kXrUD+8d63qr/lP1XazqCUt9LA
        2AHc1Mjf44dSvj35ysFFBr2+S5UQ3f7sA7DPDanOqZy3Wn9HVcKjiNENaSs5PBkE
        BPP4bIGLD7igkbBMlp2CFWNOSRr4ng4dchziPVffX3vjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1661474541; x=1661560941; bh=AfgCL8boy2TW8uZyKX/Jg67NQiKK/5+YTKm
        1qxIfL1o=; b=zJm6EKNP/7wW0wGVn22WfjoZYEeco8W/rjRhn/OIRZvpn9s7QJr
        h9pWJ6Tn/U3YeiK1f4o3Dq+gDrCkPlArc1S4e1faDGUReg2Xxh8uqvE5gOlI6KQQ
        xeP4XclwFxbYBjFXTa0Wnd2UZ7gDl/QfhkkyFEybDfZ0LRugNRU8Qw/0MvUvq1l0
        SVdmvsr5AljTAT40R2izI7LsH/NCPqqnuMeNFlEENOQ9QBesRLDriF/CDg6V+ewJ
        q6SoyYYN2Q+tnV4hLMjt090eWoArkhtIKGtl5pmy8FiBbdHaPL97G/4HCFCH8DfK
        6FNzZ7trR998pfdItvaFwAqiG4+J4uOMx2Q==
X-ME-Sender: <xms:7RYIY5w-Mkvdatyolrz8PaNXdNOSxV6cnqjIJbUdibyvBLI7le_p2Q>
    <xme:7RYIY5TsanBzqswDpB0WEIBirYZVFwG9HzvtzWxyIpetmZ0iJJfaqQR7CoRfpWiCu
    DtVg8WYYMmJd0Qkeps>
X-ME-Received: <xmr:7RYIYzUL5FVaCZdoNW6UB6Oc4RaDUzVOux8HPsjh0NVGgFsIk-k6pdTFaQvS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejgedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfdujedthfduudekffefkeeiffdttd
    dvhfegudduueffuefhfefggeefteevvdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:7RYIY7jP6QPA7JEbAxx3xVpGibgDZwDf3CKf-9atT1ztRdUh2l0UxQ>
    <xmx:7RYIY7CFEAWH8j2XjUbWjBXtum5Pi0LyFlz3a0iJiji2k5tZtKoiwQ>
    <xmx:7RYIY0KoS1_aIsM6BZDX9QHCFaD7NDPIoy7cdIELThtreVkArfqsGQ>
    <xmx:7RYIY-OYZEnu1f2fQxu7UDKs3cmWYT5T6-UxjgK2hWefa0el90VMag>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Aug 2022 20:42:18 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 0/2] asus-wmi: Modify fn+f5 and support GPU fan
Date:   Fri, 26 Aug 2022 12:42:08 +1200
Message-Id: <20220826004210.356534-1-luke@ljones.dev>
X-Mailer: git-send-email 2.37.2
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

Some TUF laptops have both fan_boost and thermal_throttle, and some in that
group may not actually have an effect on one or the other - this patch series
adjusts behaviour to try both. There doesn't appear to be any consistency
to check for so far.

Some laptops can also control the GPU fan between auto and boost.

Changelog:
- V2
+ Rebase on review-hans

Luke D. Jones (2):
  asus-wmi: Modify behaviour of Fn+F5 fan key
  asus-wmi: Support the GPU fan on TUF laptops

 drivers/platform/x86/asus-nb-wmi.c         |  1 +
 drivers/platform/x86/asus-wmi.c            | 82 ++++++++++++++++++++--
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 3 files changed, 78 insertions(+), 6 deletions(-)

-- 
2.37.2

