Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE1C4A6795
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 23:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237883AbiBAWMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 17:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiBAWMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 17:12:20 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C399C06173B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 14:12:20 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id d188so23063054iof.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 14:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=xEClXmc0bdiu76CLg2SmNj+Tr5eO3D7n9NXH7Xz/xgQ=;
        b=LCANwjZ8OwvjINuQx4nynmz1zpRYCKxoZC5qyrnaTYevHgM2ATxAQih4yZLOBhamck
         HLUREtl41G47R1XHnjiffjUyjckvbuRGBVBlAW2LPZg9AwRl3+xIbJdWzCYESUXXtZjY
         SUP2nF7QXXMzr8fm6XleF2gux/pFuQ6nVL/dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=xEClXmc0bdiu76CLg2SmNj+Tr5eO3D7n9NXH7Xz/xgQ=;
        b=R6ddlet99Bm+/aAtSBe4RMUHyj0F/IIwjTkBhAfuaMol+BrM7XeW3Oahoo28pGyAH2
         qWkHVXImrRVq8Ks0wSutG4AWKVHUGKqPzuBEgLym7CjmaBjAzCYlZdsJI5OZ2EwM8tll
         Asuic7SSK9Bja4BE3aGchBFEpYwKRTpRIi1YH6WriAOeBTTlMvoimfxFjyE8b0+Uf9ki
         bgC/8zjBXC8cnUq5y93Gc7KhHRA8eTFxN45g2EQEWXuRCQVLmm6ESX0Mlmw7dGYjFtMm
         hNVxoYs58YG5yxiXjMYsAmVgCkgPpmKGzuDGF5T2BsBApiBf/hrVPNkpMCQ2rS8lBTfj
         Eclg==
X-Gm-Message-State: AOAM53218Rv2/fIpEGKtPY/jDtoTHbH/qLlsLFW434JqQrOxHrN0iN9b
        hQSWbO664PeCkV3cf6Y23Y8TQPzZy8YLQA==
X-Google-Smtp-Source: ABdhPJxm7UQVOGaPxfCY3vsdsfYH+Y/xMGxuzMAgXCHF+eyBhR0WP/uOLE15WQsmrrmoZOUad6yanw==
X-Received: by 2002:a6b:6f09:: with SMTP id k9mr14992926ioc.61.1643753539459;
        Tue, 01 Feb 2022 14:12:19 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id a6sm11055813ilk.6.2022.02.01.14.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 14:12:18 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] KUnit fixes update for Linux 5.17-rc3
Message-ID: <714c5db3-dcf8-86ba-4e87-49c9a36f9862@linuxfoundation.org>
Date:   Tue, 1 Feb 2022 15:12:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------675B65142C724EC95E1400AE"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------675B65142C724EC95E1400AE
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull the following KUnit fixes update for Linux 5.17-rc3.

This kunit update for Linux 5.17-rc3 consists of a single fix to
an error seen on qemu due to a missing import.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

   Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-5.17-rc3

for you to fetch changes up to 235528072f28b3b0a1446279b7eaddda36dbf743:

   kunit: tool: Import missing importlib.abc (2022-01-25 12:59:43 -0700)

----------------------------------------------------------------
linux-kselftest-kunit-fixes-5.17-rc3

This kunit update for Linux 5.17-rc3 consists of a single fix to an error
seen on qemu due to a missing import.

----------------------------------------------------------------
Michał Winiarski (1):
       kunit: tool: Import missing importlib.abc

  tools/testing/kunit/kunit_kernel.py | 1 +
  1 file changed, 1 insertion(+)
----------------------------------------------------------------

--------------675B65142C724EC95E1400AE
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-kunit-fixes-5.17-rc3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-kunit-fixes-5.17-rc3.diff"

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 44bbe54f25f1..3c4196cef3ed 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -6,6 +6,7 @@
 # Author: Felix Guo <felixguoxiuping@gmail.com>
 # Author: Brendan Higgins <brendanhiggins@google.com>
 
+import importlib.abc
 import importlib.util
 import logging
 import subprocess

--------------675B65142C724EC95E1400AE--
