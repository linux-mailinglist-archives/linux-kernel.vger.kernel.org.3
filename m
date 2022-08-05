Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CD958AE49
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 18:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241222AbiHEQkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 12:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241135AbiHEQju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 12:39:50 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E2A79EE5
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 09:39:46 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id bf13so3085793pgb.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 09:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc;
        bh=KaXqnPrSeRiUFYXdAWLSE5nZAIZiti4oQlNPbQaT/uc=;
        b=NzzcZTJcaDh9dk+slsK/g5e7PlS8Zc8DX8phr6cWjVAQVzpPD8WHwp2u4GFJxDedzJ
         KxHStOfUfOonZ8ZrEH8Ka/oXdI90kOQlDTl+C4RQJedu59YQHFyaaoaZPpokQTCc7HZ+
         Ls5uqrkI1ImpiDb34GwwnXJd8jmjATn9fW6Z+yYddxy24y/+6j+UUjs/Q2FKMpqlVKv8
         kqWWZAdosK2oImekLphLk1h7a5wqYYtYnTF5hS3h8pXQGYi/QGZJI2e28RaRkwYP9NA9
         OM2DnIs2i/8Fp+RcVA5mo8M9xQ06R/Y9h6lkXJ/xOiVrGWmoI3hZUSMDtjCMyZXoIYpP
         zYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=KaXqnPrSeRiUFYXdAWLSE5nZAIZiti4oQlNPbQaT/uc=;
        b=VKdY3ahiFx3/r9PY8/DbS1EbYSd05vgQhD+B394vfIxqaBTJIVtJeuOVepfhE5RIbT
         v7HEFDmmEMpA4IHpeeBXEyRXjrMsu16DXlYrybyEq+7euwuUdqKdJ0hZj0m5YV69OkEi
         +4zQLYkOd8XQBmqm0oo2i2n5y4xnKcUmQjwMu5w184PMawXF3VmxOMgFNKiKEeVMfT72
         mK+aR3S2gXq5rnUnHmP9tWCUbDsayFAkDk5HwlMArh1rdAa3UTU+zU/+LAntxrhWOVBI
         U/AbNjplGF8mRJpokQElj41yWDu21nMne096dm19rCt07/2f/DALU2YvOyw5Myue/ktL
         NmHQ==
X-Gm-Message-State: ACgBeo0/QNzeA8KJvWs61AAJnd+UVQ1GKQxNGzdNqmRKuo5IMsJ2p3kS
        Oh2iSok4+wMF+XXlFR5mFsKKg5JHAEyWuw==
X-Google-Smtp-Source: AA6agR66kbCj8jr9qzfI6RQCl2kTuBFyodbI5RkxkXorWl9S2I+tqoH45jx+ILW8ji+7md56MOtsdg==
X-Received: by 2002:a05:6a00:1709:b0:52e:677b:702b with SMTP id h9-20020a056a00170900b0052e677b702bmr7775274pfc.19.1659717585745;
        Fri, 05 Aug 2022 09:39:45 -0700 (PDT)
Received: from autolfshost ([2405:205:c8af:3bdd:c05c:f3bc:26ee:52b2])
        by smtp.gmail.com with ESMTPSA id z66-20020a626545000000b0052d3a442760sm3207910pfb.161.2022.08.05.09.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 09:39:45 -0700 (PDT)
Date:   Fri, 5 Aug 2022 22:09:29 +0530
From:   Anup K Parikh <parikhanupk.foss@gmail.com>
To:     skhan@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] Doc fix for dget_dlock
Message-ID: <Yu1HwVoTYOeaCh4v@autolfshost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removes the warning for dget_dlock in include/linux/dcache.h and
enables generation of its API documentation

Signed-off-by: Anup K Parikh <parikhanupk.foss@gmail.com>
---
 include/linux/dcache.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index f5bba5148..ce0b36f72 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -297,7 +297,7 @@ extern char *dentry_path(const struct dentry *, char *, int);
 /* Allocation counts.. */
 
 /**
- *	dget, dget_dlock -	get a reference to a dentry
+ *	dget_dlock -	get a reference to a dentry
  *	@dentry: dentry to get a reference to
  *
  *	Given a dentry or %NULL pointer increment the reference count
-- 
2.35.1

