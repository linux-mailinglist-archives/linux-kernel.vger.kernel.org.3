Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D6A515B31
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 09:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241414AbiD3IDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 04:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240257AbiD3IC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 04:02:59 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4D592304;
        Sat, 30 Apr 2022 00:59:38 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id s14so8930399plk.8;
        Sat, 30 Apr 2022 00:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=DJBq99qO9Tsa58nKQyvLM/DpS2b10vTbYH8zK8EmJoU=;
        b=jrdM+BzsGglIBJVvzc2PsQYWbzSYjmVi2Z7UKzDjBGQJlaPqkuvRYoH3Tf9oJmuwFs
         lF9bFR81JgcbSwsvJcuSOCdw9YOMnSw+SanfoEuAL4pouTC/dIFCV08EP2aZkbxVkgdV
         RA9w04i91Nu41slYpq0OAnb06MamdSyNkPG10xvcn1NVZCcR6gHHb5pZK2KExpJOTD/p
         XI1HBAUZE/HZezR97lVrjNltwRz4Sy0S56NdKhd9YlejxFRx3hV4SS6HehEfyvMZ7H6J
         RFnhiFEkDL24b4+ymiKeeBrtUCkhl2PXCdlTLH/4yoQDl315LVU6JyLaa/Gl9kb0Zc9G
         4NsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=DJBq99qO9Tsa58nKQyvLM/DpS2b10vTbYH8zK8EmJoU=;
        b=0UGPPri+dgPOzTdRLW5BT6oDk5bjMqzSwhZHOtd/s7IG+HlzNKGdLVzGyg91173l1A
         otXfR73r+FjL+dZaLeHhb/UIoost71lcLK9LmeEpr5sZ5zIEmDnbo0xLw9BgjLXuGh7a
         D6Or6YDdaXLGdWfGveHv1Wi2lub+rVu6hHoyR5TtFbJEc3b803vK2XSL23VAdDsvbv/Z
         z05Br2e7MrRi/pLqrhS0uOZlYzgR9Hnxe2JLe97SrcaeqTAVi999HXVmWNsmOCDOvoUV
         L8Ur2N6SGFZNyWSJ1l9XYExjyAvf10hGqlVnS8d5zJrmBEqHR/aZf7B8njZez2+2pOgf
         EiVw==
X-Gm-Message-State: AOAM53095SbzQyBzrjZv/helkYT/SkkNUy/BUBg9DagbQGy5ZkukTpcw
        czTu7ZNqkMw16D1YJaqe8WY=
X-Google-Smtp-Source: ABdhPJyBlCluj+mzHILcI0ZGhLDL6AWyexTWYsFm7TkN0LmVdH1ZSq1OvYRiqS5FchtPpyrel1iMrw==
X-Received: by 2002:a17:90b:1649:b0:1d2:bdc9:df2d with SMTP id il9-20020a17090b164900b001d2bdc9df2dmr8083646pjb.158.1651305578212;
        Sat, 30 Apr 2022 00:59:38 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902c2c200b0015e8d4eb2d9sm844062pla.291.2022.04.30.00.59.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Apr 2022 00:59:37 -0700 (PDT)
Message-ID: <7689b502-8c34-85b1-54e0-7a3b5e3c2bd1@gmail.com>
Date:   Sat, 30 Apr 2022 16:59:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Tsugikazu Shibata <shibata@linuxfoundation.org>,
        Kosuke Fujimoto <fujimotokosuke0@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH] MAINTAINERS: Add entry for DOCUMENTATION/JAPANESE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the lack of an entry for the Japanese translation of
documentation, Kosuke Fujimoto needed to ask the status of
its maintenance [1].

Add an entry for DOCUMENTATION/JAPANESE as a sub-subsystem
under the DOCUMENTATION subsystem to make it easier for
another prospective contributor to know there is someone
who takes care of Japanese translation.

As a first step, install myself as a designated reviewer.
Hopefully, other interested members get accustomed to the
kernel-dev workflow and would get ready to be
(co-)maintainers/reviewers shortly.

[1]: https://lore.kernel.org/r/172fa015-26df-c978-853d-3aba67c581cc@gmail.com/

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Jonathan Corbet  <corbet@lwn.net>
Cc: Tsugikazu Shibata <shibata@linuxfoundation.org>
Cc: Kosuke Fujimoto <fujimotokosuke0@gmail.com>
---
Hi Jon,

So this took a little longer than I had originally expected.
Shibata-san says he is not confident enough to be in MAINTAINERS
at the moment, as he has just woken up from several-year
"hibernation"

I'm installing myself in the "R:" field.
I don't think being in "M:" or "R:" matters much in practice,
but I think I'd be better suited as a reviewer.

If there exists such a rule that every entry in MAINTAINERS is
required to have at least one member listed in the "M:" field,
I'm OK with filling the role.  Thoughts?

        Thanks, Akira
--
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fd768d43e048..c31ba28a6b58 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5987,6 +5987,12 @@ L:	linux-doc@vger.kernel.org
 S:	Maintained
 F:	Documentation/translations/it_IT
 
+DOCUMENTATION/JAPANESE
+R:	Akira Yokosawa <akiyks@gmail.com>
+L:	linux-doc@vger.kernel.org
+S:	Maintained
+F:	Documentation/translations/ja_JP
+
 DONGWOON DW9714 LENS VOICE COIL DRIVER
 M:	Sakari Ailus <sakari.ailus@linux.intel.com>
 L:	linux-media@vger.kernel.org

base-commit: a477b94d657875c81775b7e5147fd2671ff25ce0
-- 
2.25.1

