Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A2E4729FB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240926AbhLMK2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241590AbhLMK0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:26:52 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1924BC08EB4F;
        Mon, 13 Dec 2021 02:01:07 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id t18so25978727wrg.11;
        Mon, 13 Dec 2021 02:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WPZA9gRkqDLMYp6+mF0W8zeDD7JXBBR/yD8P8ozoEHs=;
        b=lTRohng/ek5bUhGyzs9yhqj0AFjXhJZNV2mTG4xQ8QBSnaPGdwxJtRWcsLxu+5bVvK
         JZy7J9AELWjaRkKNRXbK7sojEG+6eR9KEBC2TWDFPLg/LeOilJKz8jtxJ74sXXZ5EDzZ
         elPvbe+rHC5cOmE/889pCOjE1Y0vGXPa8PO3AzfZDjryHaZdxaItXtW8bIzxdBC6AIMD
         Tyi6EHEPUJW1jOebzybSyATejI4EADM9qP4EouQeWxvWg8XcvbbGk736WwfX7cafyLwt
         JFTBDHNw0rTuVdrPVmYZDxUJGfB3w1sPQete4oBqu4LpmKEvqHgxFlFzf0eRUkBGtvG1
         yrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WPZA9gRkqDLMYp6+mF0W8zeDD7JXBBR/yD8P8ozoEHs=;
        b=eoC2HC3Arr0sPMfOP0tpXy/7NEcxWPwWJ4MGrZDLGdAOFMpflTDgXhisSykolxTpO2
         n9LmZKnefby2AQklgJYRrdQtvFoK+U2HFK6fxI34f2AvBFcZXj/BE2Arh6CbdADxxG1N
         A6WEIAURzJxz9N8lSFHuRCI0svOfX70i/2TieyHnI8uRAFVHo2Ptoejc/gWZ0f/zhrmp
         XBEnyxbP/xddo0Rx2BGVQ17G62I97pq2nQfxz/Yr7OTNNqDU33e40dSSyhGkbdkUrmGc
         Opu8CgESxAQnTQCxblkNGbIMXx5TUaauTKx082sfCZYhOzA3DnzxyncKGHZSSfrztWAA
         0JVQ==
X-Gm-Message-State: AOAM531fc0z/X8i0FXKA3w/GpyeMWnTM3M8SKoJ43/Zvt7UsEf3B18qh
        XOY5MaxEDxiLthffvZ/UQ2w=
X-Google-Smtp-Source: ABdhPJz/4rbWZ7qUzST/4tUrc8MMfWVMlZ0VIrRbqzbkIug1yPPDFy1EZRp/eDGulYe7ee4IYdsJ2g==
X-Received: by 2002:adf:bc89:: with SMTP id g9mr30095418wrh.578.1639389665783;
        Mon, 13 Dec 2021 02:01:05 -0800 (PST)
Received: from localhost.localdomain ([2a00:a040:197:458f:acc5:ce9c:f048:f197])
        by smtp.googlemail.com with ESMTPSA id s8sm11826590wra.9.2021.12.13.02.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 02:01:05 -0800 (PST)
From:   Ariel Marcovitch <arielmarcovitch@gmail.com>
To:     masahiroy@kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ariel Marcovitch <arielmarcovitch@gmail.com>
Subject: [PATCH 2/2] kconfig: Make comments look different than menus in .config
Date:   Mon, 13 Dec 2021 12:00:43 +0200
Message-Id: <20211213100043.45645-3-arielmarcovitch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213100043.45645-1-arielmarcovitch@gmail.com>
References: <20211213100043.45645-1-arielmarcovitch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the same code that handles menus in the write to .config
handles comments as well. That's why comments look exactly like menus in
the .config except for the 'end of menu' comments that appear only for
menus. This makes sense because sometimes comments are used as sort of
submenus. However for the other cases, it looks kinda weird because one
might attempt to look for the 'end of menu' for comments as well and be
very confused.

Make comments look different than menus. For the following:
```kconfig
menu "Stuff"

config FOO
	def_bool y

comment "Some comment"

config BAR
	def_bool n

endmenu
```

The .config will look like this:
```
 #
 # Stuff
 #
 CONFIG_FOO=y

 ### Some comment
 # CONFIG_BAR is not defined
 # end of Stuff

```

Signed-off-by: Ariel Marcovitch <arielmarcovitch@gmail.com>
---
 scripts/kconfig/confdata.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 9f2c22f46ee0..d3ec1ad67d92 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -880,10 +880,16 @@ int conf_write(const char *name)
 
 			if (type == P_MENU || type == P_COMMENT) {
 				str = menu_get_prompt(menu);
-				fprintf(out, "\n"
-					"#\n"
-					"# %s\n"
-					"#\n", str);
+
+				if (type == P_MENU)
+					fprintf(out, "\n"
+						"#\n"
+						"# %s\n"
+						"#\n", str);
+				else
+					fprintf(out, "\n"
+						"### %s\n", str);
+
 				need_newline = false;
 			}
 		}
-- 
2.25.1

