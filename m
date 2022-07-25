Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB40D5805E2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbiGYUpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiGYUpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:45:16 -0400
X-Greylist: delayed 474 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 Jul 2022 13:45:14 PDT
Received: from forward104j.mail.yandex.net (forward104j.mail.yandex.net [5.45.198.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86E810B5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 13:45:14 -0700 (PDT)
Received: from sas1-1f4a002bb12a.qloud-c.yandex.net (sas1-1f4a002bb12a.qloud-c.yandex.net [IPv6:2a02:6b8:c14:3908:0:640:1f4a:2b])
        by forward104j.mail.yandex.net (Yandex) with ESMTP id EC7CB2F9856A;
        Mon, 25 Jul 2022 23:37:16 +0300 (MSK)
Received: by sas1-1f4a002bb12a.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id DUGn5l3VrV-bFhqUQZb;
        Mon, 25 Jul 2022 23:37:16 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1658781436;
        bh=jr647taVI1hG2t/ADBqRiMRSZSUJxUTshbW3JOsqCqA=;
        h=Date:Message-ID:Cc:To:Subject:From;
        b=r9zenRA2TdFI06wlX3732IV5+6vEHs7PGw12YIbW0UhzsH1rMpejM+dPmDqyRl+0/
         yfPU3DEfV/J52dXmUwQZa16OsTpGnt2op71tLJl6VMAdHsqhDfULHKcZPfk+6GiIPf
         In2uc7RbarPH2s/MOwp9SDRLsaROXFndy6WqC9U4=
Authentication-Results: sas1-1f4a002bb12a.qloud-c.yandex.net; dkim=pass header.i=@ya.ru
From:   Kirill Tkhai <tkhai@ya.ru>
Subject: [PATCH] mailmap: Update Kirill's email
To:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     kirill.tkhai@openvz.org, Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <14ca895b-e745-6ba2-8be8-652feacbc907@ya.ru>
Date:   Mon, 25 Jul 2022 23:37:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kirill Tkhai <tkhai@ya.ru>

I disconnected from both Virtuozzo and OpenVZ,
so this updates my email to point to my own.
I haven't used @openvz address for patches, so
let's rewrite the line instead of to add a new
one. CC all previous addresses.

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
.mailmap | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 71577c396252..876f926b6d82 100644
--- a/.mailmap
+++ b/.mailmap
@@ -230,7 +230,7 @@ Kees Cook <keescook@chromium.org> <kees@ubuntu.com>
Keith Busch <kbusch@kernel.org> <keith.busch@intel.com>
Keith Busch <kbusch@kernel.org> <keith.busch@linux.intel.com>
Kenneth W Chen <kenneth.w.chen@intel.com>
-Kirill Tkhai <kirill.tkhai@openvz.org> <ktkhai@virtuozzo.com>
+Kirill Tkhai <tkhai@ya.ru> <ktkhai@virtuozzo.com>
Konstantin Khlebnikov <koct9i@gmail.com> <khlebnikov@yandex-team.ru>
Konstantin Khlebnikov <koct9i@gmail.com> <k.khlebnikov@samsung.com>
Koushik <raghavendra.koushik@neterion.com>



