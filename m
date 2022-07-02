Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87F55641C6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 19:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbiGBRHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 13:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiGBRHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 13:07:53 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5028EDFF7;
        Sat,  2 Jul 2022 10:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656781664;
        bh=DWchJ3xfpS91jZr/xweU7HX4n8j3A4bKeWPadknGdbY=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=VR7iyh0b3aUpTQCYX54/uHCnT5c1aLoROhfYX+YKxoTny/2wa0yh+EWM6Pn1zbNef
         TQVzQfmAnIJcs2m7Uvb12z33GLOoyWU9SW99k+IhoE5bmYy9YYOGauJiU9Adh0CM07
         2COPfkKk3jRq5n1nFfk89z96QHnAptLEfJZuq5K0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100 ([92.116.191.144]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8ykW-1oDikA1dxu-006AuJ; Sat, 02
 Jul 2022 19:07:44 +0200
Date:   Sat, 2 Jul 2022 19:07:39 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture updates for v5.19-rc5
Message-ID: <YsB7W2GLGRjR+TNr@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:SYOxSk/xJQre0VFIqJPOpDNpukMunHzf6Vc/crebMl50I5cR/VM
 K1CmIUJT2w13yb6MVm7fq6jaeRa+MRWOlnggyFouQnBJqs2d17bwoYTti9cY0tF67fOeQkR
 S8uu8MITRrV40d2R2llEQvphzv0ThoI7xvMap7i9pzuzQvb1Wf98c+V5A0oV7Vm5XOond+i
 6kQSLB8uPXKrYHqRhhiNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TKmaES4/OaY=:CnZG0ya2FP6dxOJExXMbrz
 UbYfOU4XNhUy03Z1LbtiykzP+m9ccGJzTmHkUYMV4ky2tpXOI3aFWWwBKok1hA3wn6jOf1vU3
 rywy8SpfuZ2IMfvxDen3057DtX7HeORqS0qP2YQqO/6ku0m7XPF45xeRntIWlRnATFjbv0/JL
 Tp7YiT18pf+WV7sw35ceNTbFI/yYhVZ/+QiVfJ/+/U6i9r3L4ObrK/VDxoHai3PKl76I42Zyj
 9CU3eXFAAJMEo42gLBsFoyFCBnHGE1LLcxHdL1jf6vACjgstBRWr1dPVOWyXq8YLT/tZu0d8c
 V1dFWYmGxPDcj5KiRqPHj5bjepU/0OG/GzjupiyTJCn6YgKa5zck7p6ItZ2E2lnznHoXWyE1K
 /J73vExCUA9gf6ioypDrPImfjkFEPuWNYp5j5VCFjeh9Wv2qxO2jnNZYY8izKoKaIElsd2x1c
 HEm1lCKerVcUYKB6sn3GfTZqZwx0SULj0wpZh9ii065JaCP7CrCsgjKQcCkK6GzQeSOEXOLfq
 4LxqppDJcyys6sI904JLCT5zhjzvSdoBmYgbyJ6hyNXgX87fbVX6tNCJFcELnurtgFB2X4H/v
 4HlRum527wmfAvhjqRlrDJEJ6ceOPJp5pOrUqyK3xy/2BpWh9I0lFMKhTx+C67EBcwjBU7BRg
 x+4Rc+DCfTefcK0S1NZgbPdLApGAa01Dj9L+HEHIBU45xGj6Q6q4BEWqBk2pujr/R4ijk/BQh
 Ab4Osj8hrZnPCSxvQV6WJxZiOLbJ3DFVWkUZVa/C25nYJR/Zd9YOBQ01sKUKTPNVrktelezMS
 pJ6wPfjIfNDaV2gbK4wxOwCCXBv5IK2D0pLvoLJ6zO+grLHYVHes0g8QuCpHODqEqhVSIH3q9
 iclg3Z3KQS9skTHSHcFyLkpZq3K0suIBXoXSzDOKb/JXsfphI5uWGB96/sUli2CpA7iYZBN0j
 7HwZtkJkO5c3cHlwR3v8NwXP4861q0CaoJPnvm8cEqYYAss2vFUdKGqlGyaG+eNnjI8D+0jfT
 3AOb8GLSnn20KM77/NbyjJsvxpXbCYsSWHyV6o0tD+OXGaOwJrHeRpgK9A06ig62dQLGTKCfR
 ZN34xIsrYBOczepRnF6/4ba8r0s6W6d8DeGdlvkqFXW5hCz3K2sNJwQDw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two small important fixes for the parisc architecture for v5.19-rc5.

They fix issues with signals in userspace and unaligned memory accesses
in kernel and userspace.

Thanks,
Helge

----

The following changes since commit 03c765b0e3b4cb5063276b086c76f7a612856a9a:

  Linux 5.19-rc4 (2022-06-26 14:22:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.19/parisc-4

for you to fetch changes up to aa78fa905b4431c432071a878da99c2b37fc0e79:

  parisc: Fix vDSO signal breakage on 32-bit kernel (2022-07-02 18:36:58 +0200)

----------------------------------------------------------------
parisc architecture fixes for kernel v5.19-rc5:

Two important fixes for bugs in code which was added in kernel v5.18:

* Fix userspace signal failures on 32-bit kernel due to a bug in vDSO

* Fix 32-bit load-word unalignment exception handler which returned
  wrong values

----------------------------------------------------------------
Helge Deller (2):
      parisc/unaligned: Fix emulate_ldw() breakage
      parisc: Fix vDSO signal breakage on 32-bit kernel

 arch/parisc/kernel/asm-offsets.c | 5 +++++
 arch/parisc/kernel/unaligned.c   | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)
