Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB43C4A66F5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 22:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiBAVWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 16:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiBAVWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 16:22:36 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA23C06173B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 13:22:36 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id z18so6607271ilp.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 13:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=0aXtKIckOn4Zcx2oBeMc9tD8O36p2eaWx4lB71IeDwA=;
        b=eippPACVM0VPVVuT8bMJf0jrBaBjagKL3vjYaUY/KW9aHj/v7mN4t7R1moqYAOc2sP
         utOc2AYR38grB7m/v7FxlaqL41eBf60HA91Q6bOcq6rBTsYiv6v/5qFfm+KrEcY67Co9
         x0cZ6QYh7/OzbjQgjEGN0I4Ns9zG+87ZQL9aU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=0aXtKIckOn4Zcx2oBeMc9tD8O36p2eaWx4lB71IeDwA=;
        b=qVDR+C8jBT1xVkDEcgp0HL2gMv+Zc5/K9OE4VHg7jVu05DzhegGbVMcosy14w4Tpoj
         EQy2iQLzzONzSDwS2O3UhH3dbhu3x0I/hrGYveEGcV9YsG7AcO/OfKZ94HMpvdi0i6Gv
         KVhpRhHEgNWJ5L+xUufIv8+f9IO860Qi29DkjEDjycrhEV6sv6jrhZPemjhURxsS8EKD
         N8furyzBfehc0lelWB5tOzz2CNk4NWwaT38M4qWoM/hbm7zutBt8ydYyhygJ9HEGY1dr
         2rDq+X8mBZLsUmPqVAkDa3ggFN7BxZUpBzHzX3wG904VAddvHPyRc9VfVnKUe0KHS4zF
         AXbQ==
X-Gm-Message-State: AOAM531B4nPid1txspd1rMqpPwYtk9+AWKa05+3p1yEwlN5sHUTu5h97
        Wh4OZSYtocsT+D3TtdUelyeP6Hdbw7nwgA==
X-Google-Smtp-Source: ABdhPJz5/xTeH260aF3zWim+WnacdS87Ni5BcqpF3KUVGtY4cPc7PMB21axZD8yYH4Y8+dzwRYBSqA==
X-Received: by 2002:a92:a053:: with SMTP id b19mr16808207ilm.234.1643750555223;
        Tue, 01 Feb 2022 13:22:35 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id o4sm16034866iou.42.2022.02.01.13.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 13:22:34 -0800 (PST)
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] cpupower update for Linux 5.17-rc4
Message-ID: <1fbd35ba-4921-9dcc-959d-ff8f7270d3a7@linuxfoundation.org>
Date:   Tue, 1 Feb 2022 14:22:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------98142272BA9C13B1786CF14A"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------98142272BA9C13B1786CF14A
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull the following cpupower update for Linux 5.17-rc4 or to be
included in your next pull request to Linus.

This cpupower update for Linux 5.17-rc4 consists of minor typo fix
and renaming of file TODO to match the kernel naming convention.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

   Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-5.17-rc4

for you to fetch changes up to 101025ff8e47d3c938ad2ae646a1794b9a8aa730:

   tools/power/cpupower/{ToDo => TODO}: Rename the todo file (2022-01-24 09:07:11 -0700)

----------------------------------------------------------------
linux-cpupower-5.17-rc4

This cpupower update for Linux 5.17-rc4 consists of minor typo fix
and renaming of file TODO to match the kernel naming convention.

----------------------------------------------------------------
Andreas Rammhold (1):
       tools: cpupower: fix typo in cpupower-idle-set(1) manpage

ozkanonur (1):
       tools/power/cpupower/{ToDo => TODO}: Rename the todo file

  tools/power/cpupower/{ToDo => TODO}          | 0
  tools/power/cpupower/man/cpupower-idle-set.1 | 2 +-
  2 files changed, 1 insertion(+), 1 deletion(-)
  rename tools/power/cpupower/{ToDo => TODO} (100%)
----------------------------------------------------------------

--------------98142272BA9C13B1786CF14A
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-cpupower-5.17-rc4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-cpupower-5.17-rc4.diff"

diff --git a/tools/power/cpupower/ToDo b/tools/power/cpupower/TODO
similarity index 100%
rename from tools/power/cpupower/ToDo
rename to tools/power/cpupower/TODO
diff --git a/tools/power/cpupower/man/cpupower-idle-set.1 b/tools/power/cpupower/man/cpupower-idle-set.1
index 21916cff7516..8cef3c71e19e 100644
--- a/tools/power/cpupower/man/cpupower-idle-set.1
+++ b/tools/power/cpupower/man/cpupower-idle-set.1
@@ -4,7 +4,7 @@
 cpupower\-idle\-set \- Utility to set cpu idle state specific kernel options
 .SH "SYNTAX"
 .LP
-cpupower [ \-c cpulist ] idle\-info [\fIoptions\fP]
+cpupower [ \-c cpulist ] idle\-set [\fIoptions\fP]
 .SH "DESCRIPTION"
 .LP
 The cpupower idle\-set subcommand allows to set cpu idle, also called cpu

--------------98142272BA9C13B1786CF14A--
