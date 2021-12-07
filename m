Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB4646B398
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 08:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhLGHWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 02:22:50 -0500
Received: from out2.migadu.com ([188.165.223.204]:16284 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229803AbhLGHW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 02:22:29 -0500
Date:   Tue, 7 Dec 2021 15:18:30 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1638861535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=rJSFJdnGOsgrefe4hjyVrAPyii5dBjDjyGn54VG6MRc=;
        b=cuMNB2zCG+ZEYYQ+aDch1tKHOmb3wWIiBFfwwIbogiMGSeM3ivTQhwouzrNmIvMR1/63hM
        NfRjD1R4IgRs5e/rpilmMybI4vRiIFN4Imr9XuVbXiTQSvq/mzUL/oq3Oeo56RJmea0gM/
        +B6NsRPSlhUOJz77gMyqWPz5AuoLhuA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     ogabbay@kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Habanalabs, Ask for the linux firmware code which loads by
 coprocesseor
Message-ID: <20211207071830.GA14915@chq-T47>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oded Gabbay and habanalabs folks.

I'm insterested in this kind of AI acceralator.

After scanning the driver code.
It seems that there are a linux firmware which is loaded by
coprocessor(an slave cpu ?).
shows in the code.

./goya/goya.c:74:#define GOYA_LINUX_FW_FILE     "habanalabs/goya/goya-fit.itb"
./goya/goya.c:2436:     return hl_fw_load_fw_to_device(hdev, GOYA_LINUX_FW_FILE, dst, 0, 0);
./goya/goya.c:2507:     fw_loader->linux_img.image_name = GOYA_LINUX_FW_FILE;
./gaudi/gaudi.c:63:#define GAUDI_LINUX_FW_FILE  "habanalabs/gaudi/gaudi-fit.itb"
./gaudi/gaudi.c:3945:   return hl_fw_load_fw_to_device(hdev, GAUDI_LINUX_FW_FILE, dst, 0, 0);
./gaudi/gaudi.c:4011:   fw_loader->linux_img.image_name = GAUDI_LINUX_FW_FILE;

And the host driver(/driver/misc/habanalabs) communicate with the slave firmware
by MMIO or share memory, right?

If that, would you mind provide the source code of linux firmware
to avoid the confusion from code reading.

BTW, where can I find the register description datasheet

Many Thanks,
Cai
