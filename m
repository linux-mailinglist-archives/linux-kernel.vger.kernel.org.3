Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9FE462D4A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 08:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238953AbhK3HHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 02:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238943AbhK3HHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 02:07:14 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F49C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 23:03:55 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id u22so39240491lju.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 23:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=szhL5QTmS2bN5B3PECUs+b+yXZvUR0mps5IDDhm4xs0=;
        b=rmRO2GBGwGWqJc2t/xlmcDeT314JfFtgEqSSS/MxMRT1FLq1E8nMMUB4sXxT5UluCC
         AUaENTk9kBFgb+i5ihy2XZZ2UgCQWb2I0BA4U+Wg4WlSkBPrViWibRx9xz9fVeueKHbk
         cqD9S37qSboUk5WQfB2Co47e5G9q0hY4nlfRubmXOsm6TSuCHfl/IQ5U9Yir43RbOjdU
         Vpyh3YKtEbXVz74ymcbBFSYffCDHezaTp6iq87qb/Z49jO14BgDS9p93P1TziDOG47CR
         HDCNSAkqJxbd4i+6jjHI2H4NwDbU3uw6LzHkEkImAoxWqjQIaUaiM6BO/tmD7JTgxJqh
         EQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=szhL5QTmS2bN5B3PECUs+b+yXZvUR0mps5IDDhm4xs0=;
        b=Lcul1scjLsVnQpYb7GEYAYdhtoJsTLSC7YUuTZHKKtKOylMH0AJlVVmEiGQvnDYMPy
         CCnY7i7AAvTlsKeeX2gLVdbt4EZBhBCM76/8p/XMMNS+tOxseE8qlqZAjW8YbpmRpVGw
         4O25YW1f0SV1zlgZNDrP5vszmA1hIu0SB1/ySARRO8cvMD6JAVhpBGCCbNHzDkpeos2x
         a0w87unNcqaZcvuWQzMF0VJ60cQazkESb9BveRmjjobWL8HhpSZp1dtMXGkkGW5bv61Q
         l6JoVXppawxmZN0SkoxFfXajfPWMnTC0/rEIitdfP47C5/txiEHUw9aQJLBk3gweoyKu
         Xg2Q==
X-Gm-Message-State: AOAM531pz1TBwi4pE8zsggik9JUEMIpi1BN0QjeAsmnRjr5NalVyMDRh
        id9DTm7dINJX0viAN4HT2agFlw==
X-Google-Smtp-Source: ABdhPJzfiq1GEnhN+ppW5GH1nCQCECE1ASmCX4M4QJp/08lycIuUonrIkxeVqWNwlPZaBOiYq17sSA==
X-Received: by 2002:a05:651c:c3:: with SMTP id 3mr52346139ljr.170.1638255833674;
        Mon, 29 Nov 2021 23:03:53 -0800 (PST)
Received: from jade (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id e6sm1615747lfn.172.2021.11.29.23.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 23:03:53 -0800 (PST)
Date:   Tue, 30 Nov 2021 08:03:51 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [GIT PULL] AMD-TEE fix for v5.16
Message-ID: <20211130070351.GA2308099@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this AMDTEE driver fix which takes care of a bug where
IS_ERR() was used instead of a NULL check for the return value from
__get_free_pages().

Note that this isn't a usual Arm driver update. This targets AMD instead,
but is part of the TEE subsystem.

Thanks,
Jens

The following changes since commit d58071a8a76d779eedab38033ae4c821c30295a5:

  Linux 5.16-rc3 (2021-11-28 14:09:19 -0800)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/amdtee-fix-for-v5.16

for you to fetch changes up to 9d7482771fac8d8e38e763263f2ca0ca12dd22c6:

  tee: amdtee: fix an IS_ERR() vs NULL bug (2021-11-29 09:55:49 +0100)

----------------------------------------------------------------
AMD-TEE fix IS_ERR() bug

----------------------------------------------------------------
Dan Carpenter (1):
      tee: amdtee: fix an IS_ERR() vs NULL bug

 drivers/tee/amdtee/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)
