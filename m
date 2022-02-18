Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB954BBF45
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 19:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239055AbiBRSRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 13:17:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbiBRSQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 13:16:58 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9E7B2B;
        Fri, 18 Feb 2022 10:16:41 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id bg21-20020a05600c3c9500b0035283e7a012so7027492wmb.0;
        Fri, 18 Feb 2022 10:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RUj5tv88ZrnAPtys6wyBXq2J8Bptpatax+XE2plB4SI=;
        b=XzUDz+MneXP8UeVJMav0LETmbRoamMxLS+y4uk91AN3ChYMedziqaOjMDOqgzswcTw
         xPPb+e3IrH8xTMAzn54BzdpSP4urAiyB/7zFzs6I95wayHrmDWSvmdjs7tRU5NTp6JIG
         t9jMa7a9K6rAw1YJD6Lg0uUickntxiQtSOQYZsOtTYgmk2R02nWfzHWROzs9sekNnczJ
         8YoLScDuUEvQjn0JX7mhhhdk0Zp6Q9J2BA8y0vmH741nC5+LicjIIbz6/xWy+GYSlRsm
         GQ//ubW8YJhQhK+3UcqwnKZP3yK2JHo4Ws00SM0vuloalSy4mHebCNftQoI9uvFTf4P6
         Yp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RUj5tv88ZrnAPtys6wyBXq2J8Bptpatax+XE2plB4SI=;
        b=4/rqxwzlUzMmbJElNMgy7OezovXSSuaPYC9Xx2LK3UQQjRDEdXUNylAuPb+W/l8sz5
         G2Z7s7dz/nr2OA51NgAK4WglcKjBeBNko8RMF3UGQ1Q/26u4CR0rBt1/NRHBl0CDAI/C
         LCi4/WVeEO90DsRNZ/zj8eu4Osp8wogTnjx+bAKaGiWyuXeZAxQEQWvH+LxzmVn/1s1L
         fx0ouUE4cqsu6ClkR5RLoxKBYLcNipf0RRNMcZeC+iCFFMRevB+BKbPaPIhk/XmS7eGn
         OrkEG7xmaGPGrU4B9FjIgBV16YT6ZosQLgRhswb4vl7aAHbFxBToyIkZY2ScurQi6BHw
         170A==
X-Gm-Message-State: AOAM530p+FGKTDhuhY7NkZk8NudhF4fc9kcZ8uX2kIpHdQECy63hXqf9
        SK9eAi9QL0LE5Nw5w3/HrG/7ocxB21vqCw==
X-Google-Smtp-Source: ABdhPJxdKtuQWwSWiJAteHW5fREyTroULIKXlkI1Y50k7wyiRcIBhu1wplROx8i05TvTmGeeLjMXgg==
X-Received: by 2002:a05:600c:5103:b0:37b:c134:cad with SMTP id o3-20020a05600c510300b0037bc1340cadmr11622649wms.32.1645208199555;
        Fri, 18 Feb 2022 10:16:39 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id b2sm20978639wri.35.2022.02.18.10.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 10:16:38 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/11] Transform documentation into POD
Date:   Fri, 18 Feb 2022 19:16:17 +0100
Message-Id: <20220218181628.1411551-1-tomasz.warniello@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series transforms the free-form general comments - mainly the usage
instructions and the meta information - into the standard Perl
documentation format. Some of the original text is reduced out. And some
is simply dropped.

The transformation includes language, paragraphing and editorial
corrections.

The only change in the script execution flow is the replacement of the
'usage' function with the native standard Perl 'pod2usage'.

The to-do suggestion to write POD found in the script is ancient, thus
I can't address its author with a "Suggested-by" tag.

This version follows the advice received on v3, except I'm leaving
the old copyrights untouched.

The process consists of 14 steps.

Patches beginning with no 3 are disfunctional until no 9 has been
applied.

1) Add the basic POD sections
2) Relink argument parsing error handling to pod2usage

The following subseries is disfunctional before its last part.

3) Translate the DESCRIPTION section
4) Translate the "Output format selection" subsection of OPTIONS
5) Translate the "Output format selection modifier" subsection of OPTIONS
6) Translate the "Output selection" subsection of OPTIONS
7) Translate the "Output selection modifiers" subsection of OPTIONS
8) Translate the "Other parameters" subsection of OPTIONS
9) Replace the usage function
    
Here the DESCRIPTION and OPTIONS subseries is finished. The -h and -help
parameters are handled by POD now.
    
10) Drop obsolete comments
11) Refresh the copyright lines

Let's see what's wrong this time.

Tomasz Warniełło (11):
  scripts: kernel-doc: Add the basic POD sections
  scripts: kernel-doc: Relink argument parsing error handling to
    pod2usage
  scripts: kernel-doc: Translate the DESCRIPTION section
  scripts: kernel-doc: Translate the "Output format selection"
    subsection of OPTIONS
  scripts: kernel-doc: Translate the "Output format selection modifier"
    subsection of OPTIONS
  scripts: kernel-doc: Translate the "Output selection" subsection of
    OPTIONS
  scripts: kernel-doc: Translate the "Output selection modifiers"
    subsection of OPTIONS
  scripts: kernel-doc: Translate the "Other parameters" subsection of
    OPTIONS
  scripts: kernel-doc: Replace the usage function
  scripts: kernel-doc: Drop obsolete comments
  scripts: kernel-doc: Refresh the copyright lines

 scripts/kernel-doc | 347 +++++++++++++++++++++------------------------
 1 file changed, 159 insertions(+), 188 deletions(-)


base-commit: 2a987e65025e2b79c6d453b78cb5985ac6e5eb26
-- 
2.30.2

