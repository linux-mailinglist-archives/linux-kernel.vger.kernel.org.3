Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186A94672D8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 08:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350914AbhLCHrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 02:47:36 -0500
Received: from mail-qv1-f52.google.com ([209.85.219.52]:43622 "EHLO
        mail-qv1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378957AbhLCHr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 02:47:26 -0500
Received: by mail-qv1-f52.google.com with SMTP id j9so1969940qvm.10;
        Thu, 02 Dec 2021 23:44:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=yoWs+PQyv74WJgIH/n8CVu6zibGf1hIQseWJziXNagc=;
        b=qrpv8K7TedhNzbZAYC+fOzgtCjShxLDZS6iaNSrPBnDAJuI//YObaj4E6bNMFEBY3W
         IYMgnRRWMwziLbvx0Ty23BkuGHzP/XvtZzURiyLprQhwmA/pmAPklss6fHwKxpgaNWPW
         vSt7/LILVikPBPhLqEx3cF96Sr+KOkkTA7b5MQv83xR0MachJJQds4utU8mow1XNm4+f
         39P+ydImxgB8y6/XTxvbYhIDFSMHcRA505PS4jbO9KWIeo6TdbinH/EUXBb8F3F4yH+j
         5vN4aCDl6YGy3F869xnfkSDkeVksIbrFAvvbcHgDlB/qhhU0C/ktZ9DALY5/7MyVGE5Q
         CRLQ==
X-Gm-Message-State: AOAM531RsregNlWbQgU3JGE2cXFbmF+r3hAjp33CJyE8d90xKEgmtUkP
        j+dhOEnlpxTv5pSwcldJQs+6j3i8f9Y=
X-Google-Smtp-Source: ABdhPJxVeZ+d7hec3YqPGJNBqE1cxPXxGtNWyC+Ls1jy4iKipaeOmpFQLs/YC493tYyNKP907pfZag==
X-Received: by 2002:ad4:4ee4:: with SMTP id dv4mr17712867qvb.59.1638517442789;
        Thu, 02 Dec 2021 23:44:02 -0800 (PST)
Received: from [192.168.1.110] ([213.87.144.207])
        by smtp.gmail.com with ESMTPSA id m20sm1693351qkp.112.2021.12.02.23.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 23:44:02 -0800 (PST)
Message-ID: <045df549-6805-0a02-a634-81aca7d98db5@linux.com>
Date:   Fri, 3 Dec 2021 10:42:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Linux-kernel <linux-kernel@vger.kernel.org>
From:   Denis Efremov <efremov@linux.com>
Subject: [GIT PULL] Floppy patches for 5.17
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

The following changes since commit 2bfdbe8b7ebd17b5331071071a910fbabc64b436:

  null_blk: allow zero poll queues (2021-12-02 19:57:47 -0700)

are available in the Git repository at:

  https://github.com/evdenis/linux-floppy tags/floppy-for-5.17

for you to fetch changes up to 9fae059d4cd88229661b3eccb0409f723129e5bd:

  floppy: Add max size check for user space request (2021-12-03 09:54:34 +0300)

Please, pull

----------------------------------------------------------------
Floppy patches for 5.17

Two patches. The patch from Tasos Sahanidis fixes a hung when the module
tries to read a broken floppy while ejecting it. The patch from Xiongwei
Song suppresses a syzkaller warning about allocation size.

Signed-off-by: Denis Efremov <efremov@linux.com>

----------------------------------------------------------------
Tasos Sahanidis (1):
      floppy: Fix hang in watchdog when disk is ejected

Xiongwei Song (1):
      floppy: Add max size check for user space request

 drivers/block/floppy.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
