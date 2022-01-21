Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219A6496597
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 20:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbiAUT2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 14:28:30 -0500
Received: from mail-qk1-f180.google.com ([209.85.222.180]:35432 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiAUT22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 14:28:28 -0500
Received: by mail-qk1-f180.google.com with SMTP id j85so11106815qke.2;
        Fri, 21 Jan 2022 11:28:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=aVP8PFBXd1Xxg+tbVGye3w96ECP/nGu3md1d9/MaNT4=;
        b=Zv2ZZnBivOftFG+L9wl+GF9ahqkTN/9D0AxlQQBI0fEhUTE2tSfX1AzDcjesaeL8Iw
         5n5kRidrideMEZ6Gksj9zsz/EgLWl6fkjoUjWkasYXhhsaaxASn0eBUg0VcU+Y75e2F9
         uGo+VzQXSJct0J/HjcnZu+azxjNNSVPsDJxvrAAj8hE6Hn53gNV4XdEyyDWb4tQmCI4h
         zQjlHXXS8u9ejkJ8M291+bkn/TwYJsqckUoyH47zd5yYK7w1WAgOHTEmQURRByCzBLb9
         ntMKPmAPXx8i3DqoTQaYEcjmz60vZ/y5p8cf/3nYoI44imxW+WwNa8r9pJerWpBsrZ11
         +RtA==
X-Gm-Message-State: AOAM530xMEWT1bZxMv85JJFTIw0fxY3M8FTDyh3/41LSRmER4OR2wpPe
        shMYGEp1GHeAagN02Qb/Rqvi6Jd1WVBOSI2AgrkwVO60vbI=
X-Google-Smtp-Source: ABdhPJyqnGVO2slt+d58ce6ElzjuYQMAV8a3agJpSahkXFIVCTXyGsRs5RDTGU8ryyc/Hi1l7c1PrP50yiQGVYuct3Y=
X-Received: by 2002:a37:dc45:: with SMTP id v66mr3873828qki.516.1642793307637;
 Fri, 21 Jan 2022 11:28:27 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 21 Jan 2022 20:28:16 +0100
Message-ID: <CAJZ5v0hTjqYHH3WeN-jzrgsR8m7=LAvsq9Y7eQRWz3pz0=5bgQ@mail.gmail.com>
Subject: [GIT PULL] More thermal control updates for v5.17-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-5.17-rc1-2

with top-most commit e5b54867f47f765fcb439e09ed763b5de617af3e

 thermal: int340x: Add Raptor Lake PCI device id

on top of commit fe2437ccbd278af683d32196fdea59a3b95f144e

 Merge tag 'thermal-5.17-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more thermal control updates for 5.17-rc1.

These add device IDs for Raptor Lake to the int340x thermal control
driver (Srinivas Pandruvada).

Thanks!


---------------

Srinivas Pandruvada (2):
      thermal: int340x: Support Raptor Lake
      thermal: int340x: Add Raptor Lake PCI device id

---------------

 drivers/thermal/intel/int340x_thermal/int3400_thermal.c              | 1 +
 drivers/thermal/intel/int340x_thermal/int3403_thermal.c              | 1 +
 drivers/thermal/intel/int340x_thermal/processor_thermal_device.h     | 1 +
 drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c | 1 +
 4 files changed, 4 insertions(+)
