Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1AA4EFEB2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 06:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350510AbiDBElw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 00:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238032AbiDBElq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 00:41:46 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF52291AF8;
        Fri,  1 Apr 2022 21:39:55 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id bp39so3769990qtb.6;
        Fri, 01 Apr 2022 21:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KxlRcHlf9WptZzIbNjAlRZkX4N9ThmOiCIHI+MjC7Pk=;
        b=ZQNMxvgJKGPoSmeih1hR8LTaZ683pXmmvz05pztmV2Bhul0JKHkZA4oYoGongu/Wac
         ApNjJcrJ4icRXs57gtnxRjNRHE0L/ce8+5AocNTMCfcWO4qsHMWSNTgcTmQU1hTaDb0O
         JIMvHLCBxyO2Gimj6Mj3BMv2ZZNWPuza6J2fXuCtTO5q5GToILImhCnUz5DdCbhkcga9
         p+nr3TKj+zxGv4Ph0NnjoH0ZlT2dMbSnU/3YJFxEKIZfsabnVsOR/8xICFhYYiphoCnG
         uWt8dpx4Nyef1+6MPYxFtF9WJMkKWMnbhSsUYBYKLYCtRLqs5kcptLWV8BjQhCgODG7w
         DZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=KxlRcHlf9WptZzIbNjAlRZkX4N9ThmOiCIHI+MjC7Pk=;
        b=i1+VPCUi9+hVyRx+aU0W/RiW2yIrNW5G9LhUBVdxmAB8zJm35FLiN7GYUm4S08AFiM
         Uq0ssxhDFcDZi1IZjVu4S95/PavV2ZFBwJdMri2b01PJjxZOdDDU09N+0I1nNFkSIUC0
         HyFWX5JUsQybE5Z0AgEhyOv7UGCoDaK5q3j2krzZ+dwPCjLstVy+Jr+8S3DCeSOIURZY
         deiD+iwwKGpuZPrKN4Giv/Qayue1fSIqloV94ci0V/vMftg2l+iRmj67habHp7A57PWA
         MptfGJRgT1OeNo4x17BPkG7SBqmzEbXLx+nMxbhOZcRvlDE0wyu+3aa+HZj/LvUpphDR
         Fceg==
X-Gm-Message-State: AOAM530uc5rUMxBVFAFnzZRpek200SkYVPHGR+7wGNNS7+0RH75fPAka
        gBEd09HQ0ZQpkNbuKJsbqRc=
X-Google-Smtp-Source: ABdhPJyfSQHJYniFpnlUOAlloqrS8f2BAaliAxDXkkxxTMBqBVWcwj7RzFUoeSAVXKkHFnkqcA9y/g==
X-Received: by 2002:a05:622a:1996:b0:2e0:ffd3:a2d5 with SMTP id u22-20020a05622a199600b002e0ffd3a2d5mr10708131qtc.390.1648874394922;
        Fri, 01 Apr 2022 21:39:54 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-11-174-88-121-127.dsl.bell.ca. [174.88.121.127])
        by smtp.gmail.com with ESMTPSA id e15-20020a05622a110f00b002e1ed105652sm2996957qty.2.2022.04.01.21.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 21:39:54 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveria <bristot@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        RT <linux-rt-users@vger.kernel.org>,
        linux-trace-devel@vger.kernel.org, John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/2] rtla: Minor fix to grammar in README.txt
Date:   Sat,  2 Apr 2022 00:39:39 -0400
Message-Id: <20220402043939.6962-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220402043939.6962-1-jkacur@redhat.com>
References: <20220402043939.6962-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"The rtla" doesn't make sense, change it to "The rtla tool"
This is better than removing the word "The" since some packaging tools
need the description to start with a capital letter.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tools/tracing/rtla/README.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/README.txt b/tools/tracing/rtla/README.txt
index 6c88446f7e74..3b809eeff5f9 100644
--- a/tools/tracing/rtla/README.txt
+++ b/tools/tracing/rtla/README.txt
@@ -1,6 +1,6 @@
 RTLA: Real-Time Linux Analysis tools
 
-The rtla is a meta-tool that includes a set of commands that
+The rtla tool is a meta-tool that includes a set of commands that
 aims to analyze the real-time properties of Linux. But, instead of
 testing Linux as a black box, rtla leverages kernel tracing
 capabilities to provide precise information about the properties
-- 
2.31.1

