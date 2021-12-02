Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23CE146622E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357289AbhLBLVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:21:36 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:38692 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357270AbhLBLVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:21:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638443888; x=1669979888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nl5CWwCo+HyJCS82sRYKOmxVIBP7Goz/nQOWZ6792B8=;
  b=PugC9wAb4MZRY1dGXvhFqf+eUdvlD20KFaFgSw5pWlE4yV0eg0DGyBu/
   xDTKjf8U5DpwFjQQmy9lKVXKrL9BPdZU+43gYadczDMiMisDrNZKpEFg2
   1NGKJ7t7WGX542hz/wRgO8+EVfjDa5kAgNFofiSVHGOldUV13D1hdu+S8
   U9TFSfsaWXHKYE1LPrzR8XlKCfZF4ysr3jkE9RSfmrp2nwEPeOJTgv2Sf
   YBTDqmFuIoswdx+yKwynNluktOrjheTugW0+saaKHurTc0P9zf1/kdYKb
   QIjY3ZHuMVCSYqY7JlBRe5PVPicvvb5JnTkOF3FLe4IKNTUode3fSVtpg
   A==;
X-IronPort-AV: E=Sophos;i="5.87,281,1631548800"; 
   d="scan'208";a="186259548"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2021 19:18:07 +0800
IronPort-SDR: rFRG9VxI5dTI4mvL13f01gWZKW4pYuGoT8kvzHi5KvtMQlLH6OmRSeBGIx7uh14d8BpqfqGuAD
 FKo0+ZeKmWQ7z+l6YlJwL3m+jyf0CSBFfjoBK5Wnei3HUf6HcwpUuvGjYoXiaRK9oXbTodM62G
 4xfm844yEnMdr0emdOJMNoGe9oXvy9+hG4cZMOdFCiwt5TfK1jJHuVWlh69BnvHfAunGWIxR3u
 4OG+LwR+cz/4pYSSEQLIVhlDHugDPU6CRW/rfNsBpoJCPemlpiaVFBVnts2dA1q/sxK6RIgzRx
 CIxiSrGmrNTfOqAJq98yFBBJ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 02:52:50 -0800
IronPort-SDR: 7pIRTlCmBrmZ18SjUva2mq6zU3UAwDv4j09ieVCJRZ4BUiEv9mUeXUvt2MlQCPSP4mWRh6ORS9
 qEuBLpzMlTBkWGPaY8uRucKvVWeKlUhjIjuWdtk2E4HJbmDdIxWbl9FtmkLjlipUqmw/J6sqpb
 rrqhVparX2Sg3XR53ybjNKbAJW8XL6CbBLLJFUVSzJf2LnAZ/bQJ7eiZGVuuYxeWCgQN+8TrZT
 M7oDoQf8aBFdmb4xBVkHPkKoXcy0ytMduBk5HUDNuRHwRTtNPZzPhB5v6yu3cEUNXxm4Q64kG1
 eRs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 03:18:07 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J4YNH1jnGz1TFlr
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 03:18:07 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1638443886; x=1641035887; bh=nl5CWwCo+HyJCS82sR
        YKOmxVIBP7Goz/nQOWZ6792B8=; b=ZBaBgjYBGtfY2X8siccP2z8zE8wIXrCR5W
        meKK49dRKRY/dOVcZixP6TxnjRvI+ZBY9brrPuACeRI1AUCFKjLgIXRWahkoPX+T
        +tUSQSUC/t2AbEoK75jo6LjsiyUEUi7LYvAtvL6RzMY/0oT2tLigwWwjRDbRj0jM
        MogY7ddNcXl3v9y3JSnJ68qoh7ypTX3Y2K0SSpdDcruK2aEaHc1j60qOkxcylBkv
        E3e1L6uzD/e5v0ZCsIFNHCwb1kpDegWADl/5nsISoRsld3A72GyEgZiZVU883pRy
        ozB7KhYuhhUJ8qHCagtJuWd4aOQSaYfB7q6WqYuQhd6ASxyq5Tcw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id i22ORIt7hBN7 for <linux-kernel@vger.kernel.org>;
        Thu,  2 Dec 2021 03:18:06 -0800 (PST)
Received: from toolbox.alistair23.me (unknown [10.225.165.64])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J4YN50X3fz1TFlx;
        Thu,  2 Dec 2021 03:17:56 -0800 (PST)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     jolsa@redhat.com, mingo@redhat.com, dave@stgolabs.net,
        linux-perf-users@vger.kernel.org, arnd@arndb.de,
        namhyung@kernel.org, alistair23@gmail.com, mark.rutland@arm.com,
        tglx@linutronix.de, acme@kernel.org,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        dvhart@infradead.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 6/6] selftests: futex: Use futex_waitv helper function
Date:   Thu,  2 Dec 2021 21:16:59 +1000
Message-Id: <20211202111659.2077911-6-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202111659.2077911-1-alistair.francis@opensource.wdc.com>
References: <20211202111659.2077911-1-alistair.francis@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alistair Francis <alistair.francis@wdc.com>

Use the publically exposed __kernel_futex_syscall_waitv() helper
function for the futex_waitv tests.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tools/testing/selftests/futex/include/futex2test.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/include/futex2test.h b/tools/t=
esting/selftests/futex/include/futex2test.h
index 9d305520e849..fdc0a0a270cd 100644
--- a/tools/testing/selftests/futex/include/futex2test.h
+++ b/tools/testing/selftests/futex/include/futex2test.h
@@ -5,6 +5,7 @@
  * Copyright 2021 Collabora Ltd.
  */
 #include <stdint.h>
+#include <linux/futex_syscall.h>
=20
 #define u64_to_ptr(x) ((void *)(uintptr_t)(x))
=20
@@ -18,5 +19,5 @@
 static inline int futex_waitv(volatile struct futex_waitv *waiters, unsi=
gned long nr_waiters,
 			      unsigned long flags, struct timespec *timo, clockid_t clockid)
 {
-	return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, timo, cloc=
kid);
+	return __kernel_futex_syscall_waitv(waiters, nr_waiters, flags, timo, c=
lockid);
 }
--=20
2.31.1

