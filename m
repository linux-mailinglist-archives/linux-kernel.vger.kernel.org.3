Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E43C5AA177
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 23:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbiIAVXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 17:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiIAVXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 17:23:23 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C46B923FD
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 14:23:22 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-11ba6e79dd1so297848fac.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 14:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=//ULS9Zb97N/4Yv+yOVhZmRoDVyyid6vRrjZb2izzYo=;
        b=Ild0fr/Bo/d+eU32YpIS4qV07R3n8jic/XXbvDwHx7N6KuxNLq5TbGQ2g9LLRgfE3K
         +T7QVQExvLmxMEHTTd78L31EhHx6DpP76KmPl0iPQt3J8tEv/JF/AjsB+8cZEFxLuPkK
         ZnGbdGES67gy6M2YjYKDzES5dMv2Z+6Ug9w2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=//ULS9Zb97N/4Yv+yOVhZmRoDVyyid6vRrjZb2izzYo=;
        b=pnYp8esyor4aaV1sXRUMaQRn9z6+QnoX3snae7IVtPW/ofBqTPPnh+C/NAVq4evvLb
         jLPlcOO3dpa992iPIuqQRsJceUbudeJ7Pwrf11/Qwnqh7nnAyXsfoEJuW+/1hwAqZ59u
         /RGn3YgvRm/yNLMcDNeZkF3HKQ0S7z9QhP/5YJo++a1/R8SxN/F/Vb0Nx6sjugMGcMQa
         2GI7FceAZHIcRdusRIt2klvbZVfhHnOCMfvnuCjqbc0AJlYjGuM3wRnT/Eu+gkmHQ6qq
         FsfOmgj2WltvIvz5foAevFanR9+RRyOk6DSfIyhKQAepJnEXNpu//BKeObJtI/irg0X+
         qoXA==
X-Gm-Message-State: ACgBeo3E2IkUivrDZ+OTgpJTKre55JCyyZVaZUS0RZHV/gJpR7Hu8SUP
        1lHYc3V0guNeRgc44wbjh7RXTA==
X-Google-Smtp-Source: AA6agR5HjnUA9kZExmsvmX0g3NeFaEZgpWhKxVEXFWtzcBLkFy2AMwnGLmPO4EVE30Z5o2EWk/Ostg==
X-Received: by 2002:a05:6870:1481:b0:120:6e1b:8594 with SMTP id k1-20020a056870148100b001206e1b8594mr604785oab.277.1662067401783;
        Thu, 01 Sep 2022 14:23:21 -0700 (PDT)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id l15-20020a4ab0cf000000b0044884c40c8asm64153oon.30.2022.09.01.14.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 14:23:21 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     gregkh@linuxfoundation.org, corbet@lwn.net
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, joanna.lee@gesmer.com
Subject: [PATCH] docs: update mediator information in CoC docs
Date:   Thu,  1 Sep 2022 15:23:19 -0600
Message-Id: <20220901212319.56644-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update mediator information in the CoC interpretation document.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 Documentation/process/code-of-conduct-interpretation.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/code-of-conduct-interpretation.rst b/Documentation/process/code-of-conduct-interpretation.rst
index e899f14a4ba2..4f8a06b00f60 100644
--- a/Documentation/process/code-of-conduct-interpretation.rst
+++ b/Documentation/process/code-of-conduct-interpretation.rst
@@ -51,7 +51,7 @@ the Technical Advisory Board (TAB) or other maintainers if you're
 uncertain how to handle situations that come up.  It will not be
 considered a violation report unless you want it to be.  If you are
 uncertain about approaching the TAB or any other maintainers, please
-reach out to our conflict mediator, Mishi Choudhary <mishi@linux.com>.
+reach out to our conflict mediator, Joanna Lee <joanna.lee@gesmer.com>.
 
 In the end, "be kind to each other" is really what the end goal is for
 everybody.  We know everyone is human and we all fail at times, but the
-- 
2.34.1

