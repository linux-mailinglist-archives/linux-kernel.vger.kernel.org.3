Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAAB5A0272
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 22:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240117AbiHXUEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 16:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbiHXUEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 16:04:32 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233CD7C1F9;
        Wed, 24 Aug 2022 13:04:31 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 9C2A05C00FD;
        Wed, 24 Aug 2022 16:04:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 24 Aug 2022 16:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flux.ci; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1661371468; x=1661457868; bh=NPbNMhmf4CJLdJ3iB6KsqUGsg
        lvPQTKvSwbqWfOSQnM=; b=Y+4tkFT9TB03Pt9wUla+qpcrM//6mpUA93VKKBOo8
        SktWce1Bkr9lCetsL6byq0oJlA9Rnr/T6i/LKimeBQgyjDoQOJXas8V+09FwPZrB
        WJ0dQndp1aMk8pq5s6Sh1KV5k5cpv3mXrWhtXG/7ZVpSxG05A3MmKiZQ+VVPLlkH
        WBwYXY+ssChQTVCpbygqXwq/CkZLSQEBv35mIL7ulQsldDQR7hk04XHIZyle6rEW
        d1pieTcOmgxeBg7K814VPXag6jxisqvqupctXcXLUGLZQV6Pn6jySrp2OxSsgmGs
        s49aIjCDwLClFkGN3RKz/PyQ1UcP6YRERZmLTldNLr//w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1661371468; x=1661457868; bh=NPbNMhmf4CJLdJ3iB6KsqUGsglvPQTKvSwb
        qWfOSQnM=; b=IeZBrKCenhpU51FTR8KJRQ5vLAkJVOjLXVYMy2wYU93JjMFsitk
        xrpOAk373SYHsiT54uZpYArrjQMansdEBlMCbd2onoe9JnsTjhpWHtpYnkwEdCvp
        e/ifHStfUlSIV9iFV9wZwcWLsziFaW1vKNAO4tPLr3sVbLFanV0t0adGFD7ydNcx
        h08BqlPRVPausWmWF389q71VYYsVeODsl8NoBZ86SJwca39xKt50PimChA5fOUOX
        v3SiJoei2wGK1QkdTcFBvCMl8OLPpTBXrZ/+sUxMPUUXPREt9+6AV3xGqmjAKskV
        SmJAsPHKVavdhQtnpMRn1Aw9xFIJni6BNmQ==
X-ME-Sender: <xms:S4QGY9WP8pABdAqQm6lES-fw1yYH3zC-Mhx-WZkx7YA8gwgSz1bujw>
    <xme:S4QGY9m30jrWKkyNbs-SJInLRA_ulCHMQtRsUqvKXhwML0LI-BWBlb6zP0hvJWjUn
    oWOl_KnTrwvwynm1Fc>
X-ME-Received: <xmr:S4QGY5aVUf4poPa7JLhmwGlikM1uF539O4088hxJVh40tI3V-QE4Att5pQxF3Z9lSao0Q_WE7XP1xYK9BFkeZel4QggJLgAMLpZSYgOO4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejuddgudegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvhhhithgr
    thcutehurghrvggvshhukhhsrghkuhhluceothhhihhtrghtsehflhhugidrtghiqeenuc
    ggtffrrghtthgvrhhnpeetvdeijeeludevgeeiffevgefffeeivedvffdvteevgeeuteej
    ieeuffehkeevhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehthhhithgrthesfhhluhigrdgtih
X-ME-Proxy: <xmx:S4QGYwXhTNTxXKGOiO_hKpljXbvix2AuweOsPTGBX3jbjJ8SbXEaiQ>
    <xmx:S4QGY3kRxnm9Vg5OaJbyogZKVf-4aqgiVlQreF8_BYFC90WOPRrH9Q>
    <xmx:S4QGY9fCelfBI15K97ni0Y6zah5jkYpYNgIzxiOi0T090EP0oAiL8w>
    <xmx:TIQGYwDx-VeNICW0-c0n8rypT7cD5C5DLH8CgJGezBHs82YyM3fo3g>
Feedback-ID: i6a314685:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Aug 2022 16:04:25 -0400 (EDT)
From:   Thitat Auareesuksakul <thitat@flux.ci>
To:     linux-kbuild@vger.kernel.org
Cc:     Thitat Auareesuksakul <thitat@flux.ci>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/extract-ikconfig: add zstd compression support
Date:   Thu, 25 Aug 2022 03:03:40 +0700
Message-Id: <20220824200340.45673-1-thitat@flux.ci>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
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

Add extract-ikconfig support for kernel images compressed with zstd.

Signed-off-by: Thitat Auareesuksakul <thitat@flux.ci>
---
 scripts/extract-ikconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/extract-ikconfig b/scripts/extract-ikconfig
index 3b42f255e2ba..8df33e7d6daa 100755
--- a/scripts/extract-ikconfig
+++ b/scripts/extract-ikconfig
@@ -62,6 +62,7 @@ try_decompress 'BZh'          xy    bunzip2
 try_decompress '\135\0\0\0'   xxx   unlzma
 try_decompress '\211\114\132' xy    'lzop -d'
 try_decompress '\002\041\114\030' xyy 'lz4 -d -l'
+try_decompress '\050\265\057\375' xxx unzstd
 
 # Bail out:
 echo "$me: Cannot find kernel config." >&2
-- 
2.37.2

