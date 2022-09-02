Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240DB5AA408
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 02:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbiIBAGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 20:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234832AbiIBAGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 20:06:14 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6526013E8F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 17:04:56 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id a19-20020aa780d3000000b0052bccd363f8so136732pfn.22
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 17:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=/526doRFxCke+4oGUSFsWspuqWK+hTewvkNBfSz6Em8=;
        b=BB6oqe5rZ5FGtAs2cn6KNVrIN3PexgUcyFrjA3Epe5PYA5dARSbh9Ohrtotf09nIMB
         xLVEMct7GdbjamE8dY4jNJHy/8d0S/1SzMiO0vfO5GZ9VE59/GN05bhxa9nbQBIw+QZS
         6e2RtPiLgmZMNGMlhN2prxjPxvJnRnbHwT9unG+3s8ReyQxUQD9scoYjkFeEHiyz1bvw
         4ov7siRs6TVuXvW6RNE0glsWISKUSOSbbaNbGTsaGZZojD7lF99QFUC3zToU5rcCxcpP
         SxxWt9A4/0qRjKTwpuK5WIKVcNWAfq07+lC40PB6TqsoH6ZFDe6cXMOvvX4+F33r0BZ/
         bk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=/526doRFxCke+4oGUSFsWspuqWK+hTewvkNBfSz6Em8=;
        b=wxTS1g1J0BYTog5BkDoo0SDBI490Dkw/fsu86BLGy3c+jbKs75GyVDnFfcuTkpefoB
         OSvdUuEk0OWG0nCwFmPv99iQu36aMkQ8L0TVXOvMckk2Rtn0Q6BvUFz7rMHtyf0tqoYz
         YE2wJTbPQRIATmSCGVSzAbg5vN7/xvly5KySIbBU+2iMNA37x2QHB0NqBMwh8lGlGEa5
         HMcZFcRB+dIFGNmdulIzPCmFs2DgtVMk8lDaxqAdVfTFAOWaEOT0bwTMoC5qQAOP/eEW
         eS0l1xSHAS09ZIDdLKJbvTPnAMAwGc7T1kxbmkwwN6bdZFvxoXNK3ZEBh6YEfQh0dRtA
         7Ckg==
X-Gm-Message-State: ACgBeo0qBXifIF0iYgJ6EhQ0J4/shtfA2OVsVCPyjoFssBhGcKVAnOYF
        AiPM5LDRZc6U+gksLGXwP9NRkine2bmm/U9WMb9MoxjVQ3mhBntqQDS0fbSalEkWnGQT0PttIGP
        Pe2XWeOYWq0tCXsUhO7ZxaZNw15/8ov3z/5VwMLkkVE2qLz5cA6KHTsSa/ylelCfAchdgPEbZ2g
        gP1HedHmI=
X-Google-Smtp-Source: AA6agR5jty8XBsrTJ1UfmJF+bSe3vgZLQ/UWZxbEDPQnsu+/WWsKD1sD3iUyBOaFfZy1I6FPieEllKkgeJwITMkfyg==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a17:90a:e558:b0:1fb:c4b7:1a24 with
 SMTP id ei24-20020a17090ae55800b001fbc4b71a24mr151401pjb.1.1662077095016;
 Thu, 01 Sep 2022 17:04:55 -0700 (PDT)
Date:   Fri,  2 Sep 2022 00:04:39 +0000
In-Reply-To: <20220902000439.875476-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20220902000439.875476-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220902000439.875476-2-dionnaglaze@google.com>
Subject: [PATCH 2/2] x86/sev: Document KVM_SEV_SNP_{G,S}ET_CERTS
From:   Dionna Glaze <dionnaglaze@google.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the KVM_MEMORY_ENCRYPT_OP documentation to include the new
commands for overriding the host certificates that the guest receives
from an extended guest request.

Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 .../virt/kvm/amd-memory-encryption.rst        | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/virt/kvm/amd-memory-encryption.rst b/Documentation/virt/kvm/amd-memory-encryption.rst
index c7332e0e0baa..699bde86948e 100644
--- a/Documentation/virt/kvm/amd-memory-encryption.rst
+++ b/Documentation/virt/kvm/amd-memory-encryption.rst
@@ -529,6 +529,50 @@ Returns: 0 on success, -negative on error
 
 See SEV-SNP specification for further details on launch finish input parameters.
 
+22. KVM_SEV_SNP_GET_CERTS
+-------------------------
+
+After the SNP guest launch flow has started, the KVM_SEV_SNP_GET_CERTS command
+can be issued to request the data that has been installed with the
+KVM_SEV_SNP_SET_CERTS command.
+
+Parameters (in/out): struct kvm_sev_snp_get_certs
+
+Returns: 0 on success, -negative on error
+
+::
+
+	struct kvm_sev_snp_get_certs {
+		__u64 certs_uaddr;
+		__u64 certs_len
+	};
+
+If no certs have been installed, then the return value is -ENOENT.
+If the buffer specified in the struct is too small, the certs_len field will be
+overwritten with the required bytes to receive all the certificate bytes and the
+return value will be -EINVAL.
+
+23. KVM_SEV_SNP_SET_CERTS
+-------------------------
+
+After the SNP guest launch flow has started, the KVM_SEV_SNP_SET_CERTS command
+can be issued to override the /dev/sev certs data that is returned when a
+guest issues an extended guest request. This is useful for instance-specific
+extensions to the host certificates.
+
+Parameters (in/out): struct kvm_sev_snp_set_certs
+
+Returns: 0 on success, -negative on error
+
+::
+
+	struct kvm_sev_snp_set_certs {
+		__u64 certs_uaddr;
+		__u64 certs_len
+	};
+
+The certs_len field may not exceed SEV_FW_BLOB_MAX_SIZE.
+
 References
 ==========
 
-- 
2.37.2.789.g6183377224-goog

