Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62FA048A71C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 06:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239805AbiAKFUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 00:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbiAKFUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 00:20:41 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1343BC06173F;
        Mon, 10 Jan 2022 21:20:41 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id r16-20020a17090a0ad000b001b276aa3aabso3044947pje.0;
        Mon, 10 Jan 2022 21:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rVTQrxq8gWwOCWfb8L3X/MWGyTwgjaV02YyDhdXm2CA=;
        b=jMp9T8hhnAzNrk6T7C1TrJpjyOSjPUQBxFXgKmxqTT9SsSOa981JtEhFKMsbGlQ7Dg
         HCmIHKhlC1u9QsJuYy6FaTBy3VB9k4fgViLTYBORZNNeTQe1XDJ7GMUcwjIEEb8c61vb
         rPbeDib6FAAeDZP6DZzrF3H6HY4iYIm9Mra0aI3F6lU5Kgrg7WUhkiw37I3tdMHYgkP8
         /CFtifrvopCybLm5SXX/PT/giTlgSseoqyn7j982tyWEHEpyVOj48RLWHQBNq91Dx1RU
         J0FqZS4PWeuXswLV5RGLXneGiWF2OGbJD85fgHZWpViPOAMtoWKi5uQEbb95alPEr7RO
         4i7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rVTQrxq8gWwOCWfb8L3X/MWGyTwgjaV02YyDhdXm2CA=;
        b=6ksa0y5To7hjpj6nkk40G2YA3PMgAlcadjDoskLwvIyyYgo8GWMUePR3iim1MbGmSR
         kPHzwLN2PoaThj0AJwch98nNRfLcCzZwT7ZXtLTDiglYKyD93sx62v58PkfuibY8tHub
         3xXUzWL6GEJ0lZ4LwK4qzNBorsQOuQfCuwYjZKU02G83BAuYvWZYEMYz+r3yn3xNR5HH
         7Y3mddtdhFGMKGRJFrgGf/YFbNTYIAmVUY1cIzmVwO5pPL+/83TfyEhLp/cz+1V0FueX
         SXLUnT29YFcR2BTtFueOKliivZ1E776NCFEmFBCG/uN95DdWCS2izo1y7ui/6kWx/lEe
         SDxw==
X-Gm-Message-State: AOAM530qLorL6blDD+IZoALQ+3z6PVRuc0DAd1z5z6B2uYVfZpTkKLLK
        NgMacpPOAxMsgCSN7S96aoF7weelOQyO3yVJ
X-Google-Smtp-Source: ABdhPJxgrID7aYlmb57xT1LdjiDw7CEZjcdac6NPfDlWs2OHXy35NqiIWoARgFWVzqbV0ckqcjpOXw==
X-Received: by 2002:a05:6a00:1990:b0:4bb:4cad:be3 with SMTP id d16-20020a056a00199000b004bb4cad0be3mr2981072pfl.58.1641878440218;
        Mon, 10 Jan 2022 21:20:40 -0800 (PST)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.gmail.com with ESMTPSA id w6sm6762251pga.25.2022.01.10.21.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 21:20:39 -0800 (PST)
From:   Huichun Feng <foxhoundsk.tw@gmail.com>
To:     corbet@lwn.net
Cc:     rostedt@goodmis.org, mingo@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Huichun Feng <foxhoundsk.tw@gmail.com>,
        Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
        Chun-Hung Tseng <henrybear327@gmail.com>
Subject: [PATCH] docs: ftrace: fix ambiguous sentence
Date:   Tue, 11 Jan 2022 13:20:01 +0800
Message-Id: <20220111052000.2675944-1-foxhoundsk.tw@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sentence looks ambiguous, rephrase it by adding ", there".

Signed-off-by: Huichun Feng <foxhoundsk.tw@gmail.com>
Signed-off-by: Ching-Chun (Jim) Huang <jserv@ccns.ncku.edu.tw>
Signed-off-by: Chun-Hung Tseng <henrybear327@gmail.com>
---
 Documentation/trace/ftrace.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index b3166c4a7..45b8c56af 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -3370,7 +3370,7 @@ one of the latency tracers, you will get the following results.
 
 Instances
 ---------
-In the tracefs tracing directory is a directory called "instances".
+In the tracefs tracing directory, there is a directory called "instances".
 This directory can have new directories created inside of it using
 mkdir, and removing directories with rmdir. The directory created
 with mkdir in this directory will already contain files and other
-- 
2.34.1

