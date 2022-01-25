Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDCCC49BAF9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 19:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241447AbiAYSIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 13:08:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22569 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242561AbiAYSHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 13:07:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643134062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wZ/YYJLB72Hf5p1POA1A36FlHc2x/OwYWfFRBmTnCrc=;
        b=HKHME8k3gUBg4vRPtQ7gsCqfKuWVUX2VNcW27a3v7xO7S27ex+0uAWYNqoFyhXEYYbV+tF
        Dx5RbvJLtVPPc/InhyQ1x/eKLF71p/OhvHGg8z2wOf/nCeB/oWUpjk/fdcONohb5n2Nd7U
        MSRfY/vA04nBm6xCXI2L5+xduCPhbFM=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-302-SwrammPyPWyBILg_zfRWeA-1; Tue, 25 Jan 2022 13:07:40 -0500
X-MC-Unique: SwrammPyPWyBILg_zfRWeA-1
Received: by mail-ot1-f72.google.com with SMTP id h36-20020a9d2f27000000b0059e33f1f8a0so7124470otb.19
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 10:07:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wZ/YYJLB72Hf5p1POA1A36FlHc2x/OwYWfFRBmTnCrc=;
        b=ZNAWM54ZhE6xlVl8rD3RqRbLZ71FyfvHoZbE8231mSxEmMT3MVLDqVxRqP0XD34ysX
         F02sk99t+AY9afYfDpZqfE1AW0X5nNpwiWldyfLhHsdd1wLbNJhU+NaIiHPzzejmkhs3
         8osWQZk+giwi4f4K7vjZeZrIzn2TS5uXvZshsA8rd8b2xErL2otEN6cttVI4puEPMQCO
         72s6N1lASXXNupY9XfELdExxXdFkL0wwYR/VtyHWx+fyI+ulePL/KCQUK7z9q0S1ZVKl
         ZwCtQxqM4aZjGut6vBYScHgpiCNFPdGK8dzO3WyqHrYmBpYqwG93YFeCuItZMsSa3jpw
         o1mQ==
X-Gm-Message-State: AOAM531EOufgB69r8CS+nMJVfRPog/87sOJDfs6d0vfBmUK+hX7oSWXl
        xC5bCbAqm2cjwgxvYvLoWWWugFl3PLbNkZ880DKBac3s4eFB0ovD1Sr7WPelk/jdJpFlrJFmmUB
        o6aYvqgpw8jpGCPhXxYn+Reyi
X-Received: by 2002:a4a:b24b:: with SMTP id i11mr13990794ooo.17.1643134059524;
        Tue, 25 Jan 2022 10:07:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJytoZMto/EuCrZnClcVErOkFB+/iGYfaRy6xZsTw6FNztkIPZWSOmFtpqPAHITjsWBX+8FnfQ==
X-Received: by 2002:a4a:b24b:: with SMTP id i11mr13990785ooo.17.1643134059351;
        Tue, 25 Jan 2022 10:07:39 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id a2sm8369284oiw.33.2022.01.25.10.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 10:07:38 -0800 (PST)
From:   trix@redhat.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] ieee80211: cleanup double word in comment
Date:   Tue, 25 Jan 2022 10:07:35 -0800
Message-Id: <20220125180735.1123792-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Remove the second 'that'.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 include/linux/ieee80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 559b6c6449384..5475383936f8b 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -467,7 +467,7 @@ static inline bool ieee80211_is_data_qos(__le16 fc)
 static inline bool ieee80211_is_data_present(__le16 fc)
 {
 	/*
-	 * mask with 0x40 and test that that bit is clear to only return true
+	 * mask with 0x40 and test that bit is clear to only return true
 	 * for the data-containing substypes.
 	 */
 	return (fc & cpu_to_le16(IEEE80211_FCTL_FTYPE | 0x40)) ==
-- 
2.26.3

