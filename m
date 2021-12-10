Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D21470B1E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343922AbhLJT6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:58:15 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:34645 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343809AbhLJT54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:57:56 -0500
Received: by mail-ot1-f43.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso10721885otj.1;
        Fri, 10 Dec 2021 11:54:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=y8dMmkuyWBxEw+uQhTxZh8vd7mO4Vqr5QSAk8M5BMAA=;
        b=uVxJss+/mqfPblCik7IK6igcfJ44u/5s32762oNYjqz46nUozmExku9uqnym8LL911
         rSe4ppgPmzPT6iTAx/qyt5FaFk3umbtSOG6/8VOTSINAx4WG0cgAs5rvZOg/dyj5xyA1
         tGVX98EIQEqanHSdmWJaAHxBXXPGyAV0c1T55b0wKudWXz7TwZgDP0AVwL3p4mZK9E64
         pqabTuE3DOnZAxC4hjzf7euMfq0orXsnL+BLwaodOVXNWhRkFsnTUoES+hkr9dQDCSvN
         Hqw5CHx2U9ISo2tq58pQtNBmZ1Sl3LARQuzSUe7ja6EM1nafBy+NhzJqMF0//7D/GIks
         rc3A==
X-Gm-Message-State: AOAM532zB71HPkIo4cvRtWRtlL7Z6QKSna3xmQjlU6ER3dywLaJzic0K
        lM9t4eRmlx5MQs4hFK2u73WIV71TrSfT2mocmcP+JB4pVPA=
X-Google-Smtp-Source: ABdhPJxao1cGmZ4+P4fad/nTr+Q66pNXl14J67d+7ioY5YFM+slNF+siELGwwYlW4kgYku1xqwbq+aQGB4IxI/ax3Wg=
X-Received: by 2002:a9d:4c10:: with SMTP id l16mr12849514otf.198.1639166060337;
 Fri, 10 Dec 2021 11:54:20 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 10 Dec 2021 20:54:09 +0100
Message-ID: <CAJZ5v0jqjgDHtBsdZuuEZjE=DRKq+5cWv9Eq35V8V1bLH4nscQ@mail.gmail.com>
Subject: [GIT PULL] Thermal control fix for v5.16-rc5
To:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-5.16-rc5

with top-most commit f872f73601b92c86f3da8bdf3e19abd0f1780eb9

 thermal: int340x: Fix VCoRefLow MMIO bit offset for TGL

on top of commit 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1

 Linux 5.16-rc4

to receive a thermal control fix for 5.16-rc5.

This fixes the definition of one of the Tiger Lake MMIO registers
in the int340x thermal driver (Sumeet Pawnikar).

Thanks!


---------------

Sumeet Pawnikar (1):
      thermal: int340x: Fix VCoRefLow MMIO bit offset for TGL

---------------

 drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
