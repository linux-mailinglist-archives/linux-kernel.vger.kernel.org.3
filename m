Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9CA46B66E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbhLGI4N convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 7 Dec 2021 03:56:13 -0500
Received: from mail4.swissbit.com ([176.95.1.100]:57044 "EHLO
        mail4.swissbit.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhLGI4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:56:12 -0500
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 2D4FC122ECB;
        Tue,  7 Dec 2021 09:52:41 +0100 (CET)
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 1C428122C34;
        Tue,  7 Dec 2021 09:52:41 +0100 (CET)
X-TM-AS-ERS: 10.149.2.84-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (SBDEEX02.sbitdom.lan [10.149.2.84])
        by mail4.swissbit.com (Postfix) with ESMTPS;
        Tue,  7 Dec 2021 09:52:41 +0100 (CET)
Received: from sbdeex02.sbitdom.lan (10.149.2.84) by sbdeex02.sbitdom.lan
 (10.149.2.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 7 Dec 2021
 09:52:40 +0100
Received: from sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74]) by
 sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74%8]) with mapi id
 15.02.0986.014; Tue, 7 Dec 2021 09:52:40 +0100
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Nishad Kamdar <nishadkamdar@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bean Huo <beanhuo@micron.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Huijin Park <huijin.park@samsung.com>,
        Yue Hu <huyue2@yulong.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: core: Add support for the eMMC RTC feature in
 mmc_ops
Thread-Topic: [PATCH] mmc: core: Add support for the eMMC RTC feature in
 mmc_ops
Thread-Index: AQHX6gvXWeR51ae/h0Scepl+xaO8nawlJez1
Date:   Tue, 7 Dec 2021 08:52:40 +0000
Message-ID: <cc8415c87d894a59af20d6057d9eb650@hyperstone.com>
References: <20211205191009.32454-1-nishadkamdar@gmail.com>
In-Reply-To: <20211205191009.32454-1-nishadkamdar@gmail.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.153.3.51]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-8.6.1018-26574.006
X-TMASE-Result: 10--0.065300-10.000000
X-TMASE-MatchedRID: oMBNC5/fKrXUL3YCMmnG4vHkpkyUphL9T5ysQDj6eFmk7Bk3i0ppq9BK
        hYxPftuoDQ9P/LulPI8HoI85YD6sWrl7A3O5D6aX488+83HB4A1UV5Q8COx3xiWxD2S0xfx/eZX
        GHLTfPrmm5erfzZawqa/qz5iTmPa3ZbWI1a7GzLah9EBVEAaUF5q8Ko/+QvuCY4zJvUjGrxXu9g
        RHMmKpI7DoL9ytuR9pf+pDHdeWxgygnAe3u/3zBv9XRIMLUOjQa2pCAnJvQFHcUlQs8YFKzq2DS
        mR6ZniiO1NNIxUUzbKudjtJNc/3dgZt9ETkaD4zPwKTD1v8YV5MkOX0UoduuT8+jJyNeEYplYui
        BD2rlTf3yWZzGwbdgKkJ3ES0dIP3r9wTAKg0Z/IgCPGiZqtI8PG6GRFYrbYYcczbkY6oLP5liN9
        oqQCEYOLzNWBegCW2dLi9Cu3ziTcgBwKKRHe+r2y/Pcqs6Cp76IoW7JSPMADBp/hUDHfmdwO8Hc
        qOfryZBAfZtGL0QD0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: f0f03dd1-85a9-4066-bfb0-8717ba14ca66-0-0-200-0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>There is no way however, to read the RTC time from the
>device. Hence we rely on the response of the CMD49 to
>confirm the completion of the operation.

The spec does not mention anything special about error cases where the device can reject CMD49,
if you want some meaningful possibility of this anyway you should get the R1 of the command following on the CMD49, though,
as the raised error would likely be of detection mechanism type X, see table 68.
IMO it would likely only be bit 19 ("ERROR"), but maybe try it with some cards.
So CMD49->CMD13 would be an option.
You could also check if and how some cards reject CMD49 by e.g. setting 
Regards,
Christian

From: Nishad Kamdar <nishadkamdar@gmail.com>
Sent: Sunday, December 5, 2021 8:10 PM
To: Ulf Hansson; Jens Axboe; Adrian Hunter; Bean Huo; Shawn Lin; Avri Altman; Stephen Boyd; Huijin Park; Yue Hu; Wolfram Sang
Cc: Nishad Kamdar; Greg Kroah-Hartman; linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: core: Add support for the eMMC RTC feature in mmc_ops
    
This patch adds support to set the RTC information in
the eMMC device. This is based on the JEDEC specification.

There is no way however, to read the RTC time from the
device. Hence we rely on the response of the CMD49 to
confirm the completion of the operation.

This patch has been tested successfully with the ioctl
interface. This patch has also been tested suceessfully
with all the three RTC_INFO_TYPEs.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/mmc/core/mmc_ops.c | 59 ++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/mmc_ops.h |  2 ++
 include/linux/mmc/mmc.h    |  1 +
 3 files changed, 62 insertions(+)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index d63d1c735335..490372341b3b 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -1063,3 +1063,62 @@ int mmc_sanitize(struct mmc_card *card, unsigned int timeout_ms)
         return err;
 }
 EXPORT_SYMBOL_GPL(mmc_sanitize);
+
+int mmc_set_time(struct mmc_card *card, struct mmc_host *host,
+                u8 rtc_info_type, u64 seconds)
+{
+       struct mmc_request mrq = {};
+       struct mmc_command cmd = {};
+       struct mmc_data data = {};
+       struct scatterlist sg;
+       int err = 0;
+       u8 *data_buf;
+
+       data_buf = kzalloc(512, GFP_KERNEL);
+       if (!data_buf)
+               return -ENOMEM;
+
+       if (rtc_info_type == 0x01 || rtc_info_type == 0x02 ||
+           rtc_info_type == 0x03) {
+               data_buf[0] = 0x01;
+               data_buf[1] = rtc_info_type;
+               memcpy(&data_buf[2], &seconds, sizeof(u64));
+       } else {
+               pr_err("%s: invalid rtc_info_type %d\n",
+                      mmc_hostname(host), rtc_info_type);
+               kfree(data_buf);
+               return -EINVAL;
+       }
+
+       mrq.cmd = &cmd;
+       mrq.data = &data;
+
+       cmd.opcode = MMC_SET_TIME;
+       cmd.arg = 0;
+       cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
+
+       data.blksz = 512;
+       data.blocks = 1;
+       data.flags = MMC_DATA_WRITE;
+       data.sg = &sg;
+       data.sg_len = 1;
+       sg_init_one(&sg, data_buf, 512);
+
+       mmc_set_data_timeout(&data, card);
+
+       mmc_wait_for_req(host, &mrq);
+
+       if (cmd.error) {
+               err = cmd.error;
+               goto out;
+       }
+
+       if (data.error) {
+               err = data.error;
+               goto out;
+       }
+out:
+       kfree(data_buf);
+       return err;
+}
+EXPORT_SYMBOL_GPL(mmc_set_time);
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 9c813b851d0b..0c8695d1b363 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -55,6 +55,8 @@ void mmc_run_bkops(struct mmc_card *card);
 int mmc_cmdq_enable(struct mmc_card *card);
 int mmc_cmdq_disable(struct mmc_card *card);
 int mmc_sanitize(struct mmc_card *card, unsigned int timeout_ms);
+int mmc_set_time(struct mmc_card *card, struct mmc_host *host,
+                u8 rtc_info_type, u64 seconds);
 
 #endif
 
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index d9a65c6a8816..52a3bf873d50 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -64,6 +64,7 @@
 #define MMC_WRITE_MULTIPLE_BLOCK 25   /* adtc                    R1  */
 #define MMC_PROGRAM_CID          26   /* adtc                    R1  */
 #define MMC_PROGRAM_CSD          27   /* adtc                    R1  */
+#define MMC_SET_TIME            49   /* adtc                    R1  */
 
   /* class 6 */
 #define MMC_SET_WRITE_PROT       28   /* ac   [31:0] data addr   R1b */
-- 
2.17.1

    =
Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

