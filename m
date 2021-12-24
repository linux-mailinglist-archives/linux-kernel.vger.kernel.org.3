Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3BD47E9E8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 01:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350458AbhLXAqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 19:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhLXAqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 19:46:06 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85EEC061401;
        Thu, 23 Dec 2021 16:46:05 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id r22so11491274ljk.11;
        Thu, 23 Dec 2021 16:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Y7lGzIGJA/SrDoJPFHjLxzVUJb2W2HU99JuGJnsMimY=;
        b=bgsoOT2XqcPymxvpF+nTHe884XwvaE0m5QI6NmfCXH6chURLow0flQwGwuwpEDuNV6
         uHEfrZa8eM5JupXl2FiHzxMX+s8gn1yUaKXbtchjYJK1QwIpBKdVQULm3dOedNa4Fnj0
         i+NaN0pQv0hNk+4Fv+SQ+59uJNzwxkjfBw1VzgHXyTGUut8A7uPLeQZhopoOgmFbsGgu
         7sjADfvZzBWCsNIeZOeF8kKWtvJz59Z3AKF6MYzMb7+jsZaPYML93HLPgJm7XXESRpjv
         7WB5PAUoOgf2p52yh/wSRXsPcI6X9FaSLdI6nSJFcLAVjNTJWwD8mFGK0zrxP/jnSU3j
         Z7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Y7lGzIGJA/SrDoJPFHjLxzVUJb2W2HU99JuGJnsMimY=;
        b=dWkHvafPSlWpr+ffse3mLLFfzXmvU5UMkfM//xiEQsiz7LxF+VwmMewao/vqlJFVtd
         415kQd8u8Nq/Ft/AI5QRxwXHo0tJ52BwhBh5iDhVECHUP6A2mhm1V9R9ytZAG3jGnGPt
         uviF7F8YsbiuqiIoeIqZw6EyV6FJFLUSZBZ1BBeAd2oFOrmKgQhEUiwcoKVddbD9wzck
         Z4sDelEsWclbu3lqFYQGVOt98cOfWPwDS+6rvDEKC/5RF/Hjk3Lu/Z4RjVQbHu4OQWp4
         YAK8WcDOX7vXP0U0pjHUa8CaGtc+lLZHrv28DD0RcyLIY9R7kD3+XtHa3HU3r5S+rMwg
         iZGw==
X-Gm-Message-State: AOAM5302mzg3a8KyW3qCn3CI9wKaiEUK+YTeUDHWDk6wFjMTZ3ZW4cmO
        8vE5MS2zBypkMkgTeK3rZyTCElMvsBH2OL3GQcTWFLQWLpU=
X-Google-Smtp-Source: ABdhPJw8/MHMppQt0xYdXEcxyoLc8i4TYiwKCOxkwpO6+YVMLSojUAqW6PbxLziLZZTkfjT/vrk+wt9yUrrywkgiExU=
X-Received: by 2002:a2e:2a46:: with SMTP id q67mr3107394ljq.398.1640306763699;
 Thu, 23 Dec 2021 16:46:03 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 23 Dec 2021 18:45:52 -0600
Message-ID: <CAH2r5mvWBb7-Br3fz-Y6Jn4d3vQL_OEpRcnR_AjqEpSmNwxHtQ@mail.gmail.com>
Subject: [GIT PULL] ksmbd fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
2585cf9dfaaddf00b069673f27bb3f8530e2039c:

  Linux 5.16-rc5 (2021-12-12 14:53:01 -0800)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/5.16-rc5-ksmbd-fixes

for you to fetch changes up to 83912d6d55be10d65b5268d1871168b9ebe1ec4b:

  ksmbd: disable SMB2_GLOBAL_CAP_ENCRYPTION for SMB 3.1.1 (2021-12-17
19:19:45 -0600)

----------------------------------------------------------------
Three ksmbd fixes, all for stable.
- Two fix potential uninitialized memory
- One fixes a security problem where encryption ends up
unintentionally disabled from some clients

Regression test results:
http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/8/builds/97
----------------------------------------------------------------
Dan Carpenter (1):
      ksmbd: fix error code in ndr_read_int32()

Marcos Del Sol Vives (1):
      ksmbd: disable SMB2_GLOBAL_CAP_ENCRYPTION for SMB 3.1.1

Namjae Jeon (1):
      ksmbd: fix uninitialized symbol 'pntsd_size'

 fs/ksmbd/ndr.c     |  2 +-
 fs/ksmbd/smb2ops.c |  3 ---
 fs/ksmbd/smb2pdu.c | 29 +++++++++++++++++++++++++----
 3 files changed, 26 insertions(+), 8 deletions(-)

-- 
Thanks,

Steve
