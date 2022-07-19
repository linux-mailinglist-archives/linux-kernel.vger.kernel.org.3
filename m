Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427795798C1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 13:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbiGSLuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 07:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbiGSLuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 07:50:22 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175A09FF1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 04:50:21 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id r24so613938plg.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 04:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qafXaXkIM/uHsJQqJP5nDPOn9hfjFKGF8wnaV/Bkdes=;
        b=tusAWoyw3TsYqhLLXBcTMYpo1xp/IdnAPgB7Z1dyi9njONTu1eYg82N8fG1GIDEY5+
         ReXJ4EprggsoH0SPnIRE26aQEu8Ve8VOmPz2M/hpYAGDWS5TauLNj3v9BXFG8lAd28tJ
         z4LYvPRw650AAxwx5IHSEiYYpk/anDTIJ6hhSYVZdu2JJXvW8ZtS8uc8XE+SsCpqeOik
         nRnKbqUC3x+qHxLZ/jIW6nVT/3Jbzsod7fr5cq9YW3NGz/Xrv6o4lppbwQzbV4zC27N3
         GDeLdI9nuXOJRYdsAU7LBQCceS/S5BTGyN1QCreL1KcWgNRXX2LIar+oHPfqmFX6qwNX
         jwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qafXaXkIM/uHsJQqJP5nDPOn9hfjFKGF8wnaV/Bkdes=;
        b=6DR9ewbM4ga7RzSF+9kz/FKQP+YcUor7SBbX8HK3uZIbAEvMIr29SDuxu+ox54MSV8
         RIAyldKRmDF+3MzPip5UrjIDH8TK9N2nfMlqRV+aTp8NG3bghgs0baeal6zSSD30Idl7
         tyjeqMRpjDDFn6MzOoRa5WoCGs/zOYNShHG1wTW1fBjz280ksF9DituGbNo/GZX0BZEr
         47oNRzEzgEvGxDgp91Bn8FH+c3SR1frIfQwNPZwH8suF4l9AqRUvat5BTKts3fBDY7yc
         sMrd5EhexlWkjOIZqWw1BZxOAfsdTk5HJNET7aYO0aYJ8lFzqFM/D+5QzLuh4zAWRJI2
         JeGQ==
X-Gm-Message-State: AJIora/Qc8Hx7eS4eSPtWT13hb6P0cq8Aw5EcbExcSeyGCxcSetlmLgP
        /2gBJgGOvVVwWKclnRmxj6lhSA==
X-Google-Smtp-Source: AGRyM1uLQnncqRk8F0w7HNZ+X3qpphGJmFRIOJpOFskO1lX2aBT2K5cte86IfEZhj9Rm4LxS3RDJYw==
X-Received: by 2002:a17:902:aa82:b0:16c:4bee:1f90 with SMTP id d2-20020a170902aa8200b0016c4bee1f90mr33458243plr.69.1658231420542;
        Tue, 19 Jul 2022 04:50:20 -0700 (PDT)
Received: from n37-155-090.byted.org. ([121.30.179.126])
        by smtp.gmail.com with ESMTPSA id a3-20020a170902ecc300b0016be4d78792sm11372606plh.257.2022.07.19.04.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 04:50:19 -0700 (PDT)
From:   Qifu Zhang <zhangqifu@bytedance.com>
To:     rafael@kernel.org
Cc:     lenb@kernel.org, jarkko@kernel.org, tony.luck@intel.com,
        dave.hansen@linux.intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qifu Zhang <zhangqifu@bytedance.com>
Subject: [PATCH] Documentation: ACPI: EINJ: Fix obsolete example
Date:   Tue, 19 Jul 2022 19:50:13 +0800
Message-Id: <20220719115013.744751-1-zhangqifu@bytedance.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 488dac0c9237 ("libfs: fix error cast of negative value in
simple_attr_write()"), the EINJ debugfs interface no longer accepts
negative values as input. Attempt to do so will result in EINVAL.

Signed-off-by: Qifu Zhang <zhangqifu@bytedance.com>
---
 Documentation/firmware-guide/acpi/apei/einj.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
index 55e2331a6438..d6b61d22f525 100644
--- a/Documentation/firmware-guide/acpi/apei/einj.rst
+++ b/Documentation/firmware-guide/acpi/apei/einj.rst
@@ -168,7 +168,7 @@ An error injection example::
   0x00000008	Memory Correctable
   0x00000010	Memory Uncorrectable non-fatal
   # echo 0x12345000 > param1		# Set memory address for injection
-  # echo $((-1 << 12)) > param2		# Mask 0xfffffffffffff000 - anywhere in this page
+  # echo 0xfffffffffffff000 > param2		# Mask - anywhere in this page
   # echo 0x8 > error_type			# Choose correctable memory error
   # echo 1 > error_inject			# Inject now
 
-- 
2.20.1

