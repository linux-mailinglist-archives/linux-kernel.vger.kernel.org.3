Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2A655ACC7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 23:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbiFYVQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 17:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiFYVQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 17:16:01 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D3E13E03
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 14:16:00 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id E4AAD32001AB;
        Sat, 25 Jun 2022 17:15:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 25 Jun 2022 17:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1656191757; x=1656278157; bh=yU6PtcQq7u
        0n+cPB1KiGbXPCKjXCKL2anlAUYGXIPgs=; b=U3epBhHTCvLRnjMXrll6ITkFFS
        bEh0WldNQhj8JDd+XYvhNLAT9oVDUbedBTqFq4Yqh158dP/w8zhwv1f+1WiDkdME
        AmlK+Sj2jmQjBtVt2XgXSvSm9bL1fK07Wb1OjO8ZM8MqkGAbW0hx4FqVi4Zwudmc
        mW+LOq5vXeToXqiugQHrYvnw7yhJjsYnMEQ8pBxSUF9Q2IfB5n65hfbGsEXVs22w
        XFbsKCnXtTIhDSneSUWWikKKbzqPQGW7PRqdScD0acEY25vV2MzHnfkY0w3E39mH
        vlzBny1S6XnlmKgYL46/DM92uuovoxCedvBR8k4F4JU3KzwtTPjyG4aZyR2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1656191757; x=1656278157; bh=yU6PtcQq7u0n+cPB1KiGbXPCKjXCKL2anlA
        UYGXIPgs=; b=Y03Wk+wFkfpqlaYa2KsZpxdsmYUtrN4h9E0QgCC6Y0Pk4iT7A9O
        HPa1BlzkVa/6so0bxyyRWTXI/LRsfgGnktl7bRNjQFW+ZzFDS2XNHb0k2INFIwZ5
        zmtYun8n43vy7UmlfxZWth0SK7YFDdHK45TMavf9yQvbzP98OupJVTJP/FlG2MXe
        So7ht5j4NDmho4nbeeT0zVvOSG2G8hBMpVwIL9ckH8RBHdFWa1R6pF2MwTYg8/2/
        QE1JQgUHsqeN9Wk4UY7K7BUi2XL3ojt8yrgLDE3vMk7eq9JL19HFKpBpyfaolZiY
        99yIB4ZDG5jVRIW9sXAUgK6XesUnNLdu92Q==
X-ME-Sender: <xms:DXu3YhoZoXUgt-FU79zyWIq08PjMRuiFKHhePyMNCzdJS5Azf9n2wg>
    <xme:DXu3YjooE8oGiKXEyfqVj8l-tOt1aBNOfxZ7pLV5gf_xIagfZgxetQjQmaxmeWtAX
    dyrwGQVq28-ulepg3A>
X-ME-Received: <xmr:DXu3YuOUJJm_updR_a9y6LuRyD6qb2KZu47tlygJ_Ptni4pxznOm4zIEllkaqs_K176dV1Tl3gbrJmsjfQrcqUVGbxM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeguddgudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enmhhishhsihhnghcuvffquchfihgvlhguucdlfedtmdenucfjughrpefhvfevufffkffo
    ggfgsedtkeertdertddtnecuhfhrohhmpeffrghvihguucftvggrvhgvrhcuoehmvgesug
    grvhhiughrvggrvhgvrhdrtghomheqnecuggftrfgrthhtvghrnhepvddvieefleeggfef
    tdejtdffheeuieffheejgefgffejveduueeugeetkeehjedvnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgvsegurghvihgurhgvrghvvghr
    rdgtohhm
X-ME-Proxy: <xmx:DXu3Ys7CfnI8Ap3PtlxHf9oNRDVuvzCR1VI8lubayQ-IwFwRum0QzA>
    <xmx:DXu3Yg7KKRmj5c9x4glreVWFHlL9WC9ZVJQgKq_xob55DQ3vZyfUUg>
    <xmx:DXu3Ykg4IiweK2UAUWEx1Jg6wqatyfJjJdAbnp9MNhiz-IT9JVwaBA>
    <xmx:DXu3YgHLstUs6ALkNMSwRTpWnUTF4udVcOAkUzF_gcgl6svycYafFQ>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Jun 2022 17:15:55 -0400 (EDT)
From:   David Reaver <me@davidreaver.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Reaver <me@davidreaver.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] scripts: get_feat.pl: use /usr/bin/env to find perl
Date:   Sat, 25 Jun 2022 14:15:48 -0700
Message-Id: <20220625211548.1200198-1-me@davidreaver.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I tried running `make pdfdocs` on NixOS, but it failed because
get_feat.pl uses a shebang line with /usr/bin/perl, and that file path
doesn't exist on NixOS. Using the more portable /usr/bin/env perl fixes
the problem.

Signed-off-by: David Reaver <me@davidreaver.com>
---
 scripts/get_feat.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/get_feat.pl b/scripts/get_feat.pl
index 76cfb96b59b6..5c5397eeb237 100755
--- a/scripts/get_feat.pl
+++ b/scripts/get_feat.pl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 # SPDX-License-Identifier: GPL-2.0
 
 use strict;
