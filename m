Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD17468229
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 04:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384151AbhLDDlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 22:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354735AbhLDDlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 22:41:06 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3B0C061751;
        Fri,  3 Dec 2021 19:37:41 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id h24so3753721pjq.2;
        Fri, 03 Dec 2021 19:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=tR3k6WsOi2KAxsqU3J3bcHIMbZA+YBg7HU4EgK5M5dE=;
        b=SLfUz7WBySnqdrbkNcUuyPWvBp5Dr60NvKjO3bafkg2cW78DEALMeEelsIBg2Kbg3q
         8H43cme7jMpgxRF2ALQy/PT4ogq614zx5BpmHTVtbiGZaS8df6Hj93FJSY99CdxjmO5D
         Ehc1pv+rAFRLSkGoZZffi6FXNuZuGkXn7smXNpFTDN7TTXKrD2y+eiu7p4390IbLoJEj
         NbnSaoVW6Bihr02u8nOuPKFPu4L10UEcmQFKBC7eIYY0NOh23BjH2+h2s9mJRXafFZS0
         xuvrMOwVdzylNzKzyz3G+tNZnuKecsevhFnHLN5XqUfgCui9XhXn5XKuxKkaAmmPo1Hi
         Djew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=tR3k6WsOi2KAxsqU3J3bcHIMbZA+YBg7HU4EgK5M5dE=;
        b=EK+U9a7l4nWmYESqN7zm4Bwp7i1sSkINwuVwmRMoK2uQ1ahnOAih9NbnoUEl5pl7dL
         Za5qZEr64FxJKtFM+IVegPciEjw6d6/xHDwtrXHNGTmyDbvw0wWd7bi4yiQLnYAOwtIT
         55r4i4KEFp+XPUOeskBsYN6c9W6JzgXg0JFS8n1xtRa4+eGTRKjTPTp/h2Qx2m9O5SbH
         hg4ya0NO+uqeVKNEbmK7nGZj+zBzJ5h7oL2Fi4bbZs/uzFhIlbhY43AQ+eieHJS6fcdM
         l5EIdW0M0UCtP5MPPfF4kRtkjSc8I90s8V/qu5WUKExR1ILukGDIYYjcVSPB1mQTugjt
         77GQ==
X-Gm-Message-State: AOAM531WurVTljneNWnaErWgHBeuTWpjMeu9zqBzmBoBjaVbZE6S6VTW
        LM19NMfFHd/WvAqaX4t6hjtf44MwNQ8=
X-Google-Smtp-Source: ABdhPJxWZw9DqfpJFRLL3s38XVFCBjIXMCQnySgt8vXzziNjrqkvnvBcFRqvFPNLukN5TAnqprhTZQ==
X-Received: by 2002:a17:903:1210:b0:143:a088:7932 with SMTP id l16-20020a170903121000b00143a0887932mr27793180plh.11.1638589060733;
        Fri, 03 Dec 2021 19:37:40 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id 67sm3724587pgd.0.2021.12.03.19.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 19:37:40 -0800 (PST)
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-media@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH] docs: media: Fix imbalance of LaTeX group
Message-ID: <b3eeec4d-1a34-0a1a-3097-1ddea3b5f1c8@gmail.com>
Date:   Sat, 4 Dec 2021 12:37:35 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The beginning part of the "existing HSV/HSL formats" table (line 7742)
reads:

  .. raw:: latex

      \begingroup
      \tiny
      \setlength{\tabcolsep}{2pt}

However, the ending part (line 7834) reads:

  .. raw:: latex

      \normalsize


Fix the imbalance by replacing the \normalsize with \endgroup.

Note:
    Actually, the imbalance is harmless and just results in an
    informative message near the bottom of userspace-api.log:

      (\end occurred inside a group at level 1)

      ### semi simple group (level 1) entered at line 70696 (\begingroup)
      ### bottom level 

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
---
Hi,

This imbalance has existed ever since commit 70b074df4ed1 ("media:
fix pdf build with Spinx 1.6") authored by Mauro.
As it has no visible effect in the generated PDF, I'm not putting
a Fixes: tag.

Mauro, are you OK with this fix going through the -doc tree?
Otherwise, feel free to carry it through the -media tree.
Either is fine by me.

        Thanks, Akira
--
 Documentation/userspace-api/media/v4l/subdev-formats.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/media/v4l/subdev-formats.rst b/Documentation/userspace-api/media/v4l/subdev-formats.rst
index bd68588b2683..0cbc045d5df6 100644
--- a/Documentation/userspace-api/media/v4l/subdev-formats.rst
+++ b/Documentation/userspace-api/media/v4l/subdev-formats.rst
@@ -7833,7 +7833,7 @@ The following table lists existing HSV/HSL formats.
 
 .. raw:: latex
 
-    \normalsize
+    \endgroup
 
 
 JPEG Compressed Formats

base-commit: 065db2d90c6b8384c9072fe55f01c3eeda16c3c0
-- 
2.17.1

