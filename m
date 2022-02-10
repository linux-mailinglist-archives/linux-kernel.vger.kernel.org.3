Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931BA4B16AB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 21:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244692AbiBJUCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 15:02:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239246AbiBJUCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 15:02:22 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC0D5595
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 12:02:22 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id n5so5258054ilk.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 12:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language;
        bh=q9BQkY9/bsdcNqzrqiGJlipJ/U8/3m/snLiGHC4NOug=;
        b=NHPAM8WqSogOX6IOd7vjaLXEaMg8oSAr40lFInvdoYd1PPLSX/c93+NLB5O/nS4EgS
         zEp2kJpKAf6UXYs/6lGql7Op6v0c2hribfFydNR2tJ7RCfFzxlR5oP9YiQlnCXbPVKo1
         H6mOtLYOnW3bsj9OnI7Zf/XFo3/CoTm00BVjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language;
        bh=q9BQkY9/bsdcNqzrqiGJlipJ/U8/3m/snLiGHC4NOug=;
        b=nag65UexRfp/RF8fQvWHvDuK4QW5w2fgElyM3eROWwoT54hl5DXHbIpLuUuVF2QNbp
         HBMaWLSTdeNdyaI3J+BD2gKnpHb8DzSfyTkXmZ4C7IMF2l8o/wJiF9VO4TnKi4K7E5kN
         hCXrQIxSBQN7G3I0YS9bRRCkYxV1p0tduoNkFrEk8nddXVmeX1eP27w+LSQlUpl5FD/j
         gGOsuAxjeFYoqAI/7LZpKk7navBwE6tgKycfyrcFFj/2Fkr3qZtRaXGjEzJZTOexmj+5
         +yoW7TST+yUj66IztmitI3F40mXzs/IUF1HT0C0rgzm+KRC6ZcaNDeK3lFpFlgJSspqT
         W5/A==
X-Gm-Message-State: AOAM532y7B2+7ZGGd7LmTVkydkBqdBQ04XuDd7D5LjqNpreUdFdT9lD3
        YATAOyk9dQIaEfNNIavfq5L52iyTu0BukA==
X-Google-Smtp-Source: ABdhPJzhwg//+iILtTe5CMQKGul1Y0xRjp3+boym/DzmEQ7G76eLETPfL6tJLDCAQRVc7PIRXeyVxQ==
X-Received: by 2002:a92:cecb:: with SMTP id z11mr4540304ilq.116.1644523341494;
        Thu, 10 Feb 2022 12:02:21 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id m4sm11046812iln.48.2022.02.10.12.02.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 12:02:21 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] KUnit fixes update for Linux 5.17-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <3a0311b2-33af-d13e-e92b-111bfb357a19@linuxfoundation.org>
Date:   Thu, 10 Feb 2022 13:02:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------6F0591AA410D673919C28020"
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6F0591AA410D673919C28020
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following KUnit fixes update for Linux 5.17-rc4.

This KUnit fixes update for Linux 5.17-rc4 consists of bug fixes
to the test and usage documentation.

Note: The doc fix patch resolves a bugzilla issue.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 235528072f28b3b0a1446279b7eaddda36dbf743:

   kunit: tool: Import missing importlib.abc (2022-01-25 12:59:43 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-5.17-rc4

for you to fetch changes up to 92a68053c3468705e2c7c752c9a3f256304a35a6:

   Documentation: KUnit: Fix usage bug (2022-02-08 13:16:20 -0700)

----------------------------------------------------------------
linux-kselftest-kunit-fixes-5.17-rc4

This KUnit fixes update for Linux 5.17-rc4 consists of bug fixes
to the test and usage documentation.

----------------------------------------------------------------
Akira Kawata (1):
       Documentation: KUnit: Fix usage bug

Daniel Latypov (1):
       kunit: fix missing f in f-string in run_checks.py

  Documentation/dev-tools/kunit/usage.rst | 2 +-
  tools/testing/kunit/run_checks.py       | 2 +-
  2 files changed, 2 insertions(+), 2 deletions(-)

----------------------------------------------------------------

--------------6F0591AA410D673919C28020
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-kunit-fixes-5.17-rc4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-kunit-fixes-5.17-rc4.diff"

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 76af931a332c..1c83e7d60a8a 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -242,7 +242,7 @@ example:
 
 	int rectangle_area(struct shape *this)
 	{
-		struct rectangle *self = container_of(this, struct shape, parent);
+		struct rectangle *self = container_of(this, struct rectangle, parent);
 
 		return self->length * self->width;
 	};
diff --git a/tools/testing/kunit/run_checks.py b/tools/testing/kunit/run_checks.py
index 4f32133ed77c..13d854afca9d 100755
--- a/tools/testing/kunit/run_checks.py
+++ b/tools/testing/kunit/run_checks.py
@@ -61,7 +61,7 @@ def main(argv: Sequence[str]) -> None:
 		elif isinstance(ex, subprocess.CalledProcessError):
 			print(f'{name}: FAILED')
 		else:
-			print('{name}: unexpected exception: {ex}')
+			print(f'{name}: unexpected exception: {ex}')
 			continue
 
 		output = ex.output

--------------6F0591AA410D673919C28020--
