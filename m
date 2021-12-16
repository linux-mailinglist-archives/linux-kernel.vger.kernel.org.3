Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6134766DC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 01:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbhLPAQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 19:16:34 -0500
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:64533 "EHLO
        esa6.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbhLPAQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 19:16:33 -0500
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Dec 2021 19:16:33 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1639613793;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=SZZJ//s3+3ZzTEDrC/sSOmJIyeW4tH8BdxhznJcFRm0=;
  b=clSQ+WDUwHQAm7wF868OKOe8Lbfhj3r3kXFzFnbLUSEy2oOX/vLOaHwW
   6kOW5DpVeOqMOeAtATGfXveoVsz5hdOSD+PwDPzinRLcHxbHtzmvoYKV4
   iGj0CIG+rGuEvHQh40Gl5DFpIWFyy38zjx7XEYdY/59bs7UHMQW/cp8AJ
   U=;
Authentication-Results: esa6.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: nWUtCjCISF4zFhLumypKeu8ZMpqd3jCOmjPIEFmFfl3KwTIiTWx+VVJqlX0a9AEAKARzibdm+/
 PG/EzQ7JstRru8rvOUsL/FqBxpeNWmdbK2JmWdHhOBCrhOSwmyoTjEy1wUfjld7aHEEImSJigS
 Dt8Lpte7fxIrhcmt8suWpfG+oyv+Cn8S46z45+8lreD/6CS3D+230lk8+sl77k7/CHZtuMvMFc
 vUjx8gRi6o8Y59kwepPRJPuObLTY5k2cNpAurFEAe7e2J59Lnx+DIuRrfZ2opMMmhbbYaehoK7
 s9OEiZUrSGpPuBGuo7LTscBA
X-SBRS: 5.1
X-MesageID: 60078440
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:4YWQ+KPQwRuSpy/vrR0HkMFynXyQoLVcMsEvi/4bfWQNrUoqhjBVm
 2AcXD+GbqyNNmX2edpzbNizp0pUu8OBnd8wGgto+SlhQUwRpJueD7x1DKtR0wB+jCHnZBg6h
 ynLQoCYdKjYdpJYz/uUGuCJQUNUjMlkfZKhTr6UUsxNbVU8En5400s+w7VRbrNA2rBVPSvc4
 bsenOWHULOV82Yc3rU8sv/rRLtH5ZweiRtA1rAMTakjUGz2zhH5OKk3N6CpR0YUd6EPdgKMq
 0Qv+5nilo/R109F5tpICd8XeGVSKlLZFVDmZna7x8FOK/WNz8A/+v9TCRYSVatYoy+zjeI24
 oVficfudRcAN52Vluc+FAYNRkmSPYUekFPGCX22sMjVxEzaaXr8hf5pCSnaP6VBpLwxWzsXs
 6VFdnZdNXhvhMrvqF6/YsBqit4uM4/AO4QHt2s75TrYEewnUdbIRKCiCdpwgm9o2ZASQa62i
 8wxUSBmZjGYb0V1IFIoJLU5mtr3wV7/WmgNwL6SjfVuuDWCpOBr65DhOcTYPNyDQ95YmG6cp
 2Tb7yL4BA0XMJqUzj/t2ni0rubLnC79CMQeGdWQ9uZjqE+C2msJThYRUDOTsannok2zQdRSL
 woT4CVGhaE3/x31ZsLnVBP+pnOY1jYYWtxNA6g55RuLx678/QmUHC4HQyRHZdhgs9U5LRQv1
 1mGmPvzCDBvuaHTQnWYnp+IojeiESwUK3IefygCTBtD79SLnW0opkuRFJA5Svfz14CrX2Grq
 9yXkMQgr68pn/xM/fWpwQuZvyKFr6iQQA0WoRqCCwpJ8ThFTIKiYoWp733S4vBBMJuVQzG9g
 ZQUpySNxLtQVM/QzURhVM1IRej0vKjdbFUwlHY2R8F5nwlB7UJPamy5DNtWAE5yevgJdjbyC
 KM4kVMAvcQDVJdGgEIeXm5QNyjI5fSwfTgGfqqNBjarXnSXXFXdlM2JTRTPt10BaGB2zckC1
 W6zKK5A90oyB6V91yaRTOwAy7ItzS1W7TqNHsGmnk/4gefEPCX9pVI53L2mNLpRAESs+lq9z
 jqiH5HSl0U3vBPWPEE7DrL/3XhVdCNmVPgaWuRcd/KZIxoOJY3SI6S5/F/VQKQ8x/49vr6Rp
 hmVAxYEoHKi1CWvAVjbMRhLNeKwNauTWFpmZETAy37zgCN9CWtuhY9CH6YKkU4PqLY+kKUqF
 qZdIK1twJ1nE1z6xtjUVrGlxKQKSfhhrVLm0/ONbGdtcph+aRbO/9O4LALj+DNXVni8tNcko
 q3m3QTeGMJRSwNnBcfQSfSu01Lu4iRNxLMsBxPFcotJZUHh0Il2MCit3PU5FN4BdEfYzTyA2
 gfIXRpB/bvRo5U4+cXijLyfq9v7CPN3G0dXRjGJ7bu/OSTA0HCkxItMDLSBcTzHDTum86S+f
 +RFifr7NaRfzlpNtoN9FZdtzL4/uISz9+MLkFw8ESySPVqxC75mLn2X5uV1t/VAlu1DpA+7e
 kOT4d0Ga7+HD9zoTQwKLw0/Y+XdifxNwmvO7e44KVnR7TNs+ObVSl1bOhSBhXAPLLZxN495k
 +4ttNRPtl66gxsudN2HkjpV5yKHKXlZC/crsZQTAYnKjAs3yw4dPcyAW3GuuJzfOc9RNkQKI
 yOPgPuQjrtR8UPObn4vGCWfxuFan5kP5EhHwVJqy45lQTYZaivbBCFszAk=
IronPort-HdrOrdr: A9a23:X0PHOK4W6bbzebDYZAPXwN7XdLJyesId70hD6qhwISY6TiX4rb
 HIoB1173/JYVoqNE3I+urwXJVoI0mslqKdiLN5VdzJMTUO0FHYSb2KhrGC/9SPIULDH5ZmpM
 VdT5Q=
X-IronPort-AV: E=Sophos;i="5.88,209,1635220800"; 
   d="scan'208";a="60078440"
From:   Andrew Cooper <andrew.cooper3@citrix.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     <amc96@srcf.net>, Andrew Cooper <andrew.cooper3@citrix.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/pkey: Fix undefined behaviour with PKRU_WD_BIT
Date:   Thu, 16 Dec 2021 00:08:56 +0000
Message-ID: <20211216000856.4480-1-andrew.cooper3@citrix.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both __pkru_allows_write() and arch_set_user_pkey_access() shift
PKRU_WD_BIT (a signed constant) by up to 30 bits, hitting the sign bit.

Use unsigned constants instead.

Clearly pkey 15 has not been used in combination with UBSAN yet.

Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
---
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: x86@kernel.org
CC: "H. Peter Anvin" <hpa@zytor.com>

Noticed by code inspection only.  I can't actually provoke the compiler into
generating incorrect logic as far as this shift is concerned, so haven't
included a fixes tag.

If wanted, it is:

  Fixes: 33a709b25a76 ("mm/gup, x86/mm/pkeys: Check VMAs and PTEs for protection keys")

except it will collide with the very recent code movement in 784a46618f634.
---
 arch/x86/include/asm/pkru.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pkru.h b/arch/x86/include/asm/pkru.h
index 4cd49afa0ca4..74f0a2d34ffd 100644
--- a/arch/x86/include/asm/pkru.h
+++ b/arch/x86/include/asm/pkru.h
@@ -4,8 +4,8 @@
 
 #include <asm/cpufeature.h>
 
-#define PKRU_AD_BIT 0x1
-#define PKRU_WD_BIT 0x2
+#define PKRU_AD_BIT 0x1u
+#define PKRU_WD_BIT 0x2u
 #define PKRU_BITS_PER_PKEY 2
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
-- 
2.11.0

