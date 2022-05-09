Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C90E51F46B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 08:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbiEIGVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 02:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235760AbiEIGLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:11:16 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98F0170F25
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 23:07:23 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 204so8593237pfx.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 23:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dNam4NRqULz5ngQJv/Hr3VjArBiTEWxDny0ZL2+Io9U=;
        b=dPq3yY7EG5ylSK+rjMmRLKT+ixv0ENM3fCJuMlr93a3g3nsC3YidXBc7z1I53YnSt+
         G064wONruJW7U1oAvryn/yC/EH1CMKZAz8wPzoWibJ3aLmJ7LvjDMxXUpDb3c2XmRJOH
         A1zjn1n7BpVaeaiw7tApKppo7kZg8ythmCIJAP6je7afYD04nOqUbKMkKdfGrafqpald
         N+QaLI77ovp24bmcPODSy05aMrLtXd4smLr1AR5tfcVVWZg90iW3q5ROCMZKIfk1Io02
         hMvQdzr/JVJOHp2282+DZnEt+ldYKcWp5sDjZdj+n7oTp220vEB0MwDwCuMgStHr66VH
         Weow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dNam4NRqULz5ngQJv/Hr3VjArBiTEWxDny0ZL2+Io9U=;
        b=g8fQFyT92/JqJKsFP/Kt98ofM7PDb1Ag6FEnBfNM2+zJgQ2RYYd2zrFNatVsPvldKX
         X++LzbjtDjnlLe5DNEek5EeQhG9HXF+3Robjc+roBy/OT8z7DPyXVftKWkOXNHxViaJT
         B2rmc1ilXgAVUaO/n1pMatvnPa5DaSPrMY6uVK+/MxP/btueCWkI1jy6wXLGa741oOEU
         Nf/fJBw8GqE5DOxFC7nWLXwLVS9ZkCARGxkGeOnXwyou0vCacwLzy+0dKRaJZw/ou+73
         a/LkuEi4Y45zomPDPGfngpmCjO3EEaVBEr7MCA/73Ka76Nu4zyj1xhSCVMlxII4Gx+pc
         mqJA==
X-Gm-Message-State: AOAM533SCpznUbBrqXu/jQV59LamDntTFDq/11gKmiRL2sTua1G5hgCC
        /zmuUfx135n8MMQpI1oiOuPg0Xhakn2uBA==
X-Google-Smtp-Source: ABdhPJwhPZEA9MJp5FqlgDa6QmKne+WzgM7zzcJh6yNP8eD7tE4O+NrmEyx8KPG1/ObV9NbCTfC5Tw==
X-Received: by 2002:a63:165f:0:b0:3c6:ab6b:a6d2 with SMTP id 31-20020a63165f000000b003c6ab6ba6d2mr4338868pgw.610.1652076443185;
        Sun, 08 May 2022 23:07:23 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.80.217])
        by smtp.gmail.com with ESMTPSA id g6-20020a170902d5c600b0015e8d4eb291sm6126748plh.219.2022.05.08.23.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 23:07:22 -0700 (PDT)
From:   Anup Patel <anup@brainfault.org>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update KVM RISC-V entry to cover selftests support
Date:   Mon,  9 May 2022 11:36:34 +0530
Message-Id: <20220509060634.134068-1-anup@brainfault.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We update KVM RISC-V maintainers entry to include appropriate KVM
selftests directories so that RISC-V related KVM selftests patches
are CC'ed to KVM RISC-V mailing list.

Signed-off-by: Anup Patel <anup@brainfault.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e8c52d0192a6..ee73a71c1500 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10767,6 +10767,8 @@ T:	git git://github.com/kvm-riscv/linux.git
 F:	arch/riscv/include/asm/kvm*
 F:	arch/riscv/include/uapi/asm/kvm*
 F:	arch/riscv/kvm/
+F:	tools/testing/selftests/kvm/*/riscv/
+F:	tools/testing/selftests/kvm/riscv/
 
 KERNEL VIRTUAL MACHINE for s390 (KVM/s390)
 M:	Christian Borntraeger <borntraeger@linux.ibm.com>
-- 
2.34.1

