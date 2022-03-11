Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D574D5A14
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 05:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346399AbiCKEt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 23:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237888AbiCKEtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 23:49:19 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FF57DA92
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 20:48:15 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id b9so3840479ila.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 20:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WLJUfv+vtv2Xowd95rnmv6x57XGkiZ9Q0usZnZ/h/Fg=;
        b=BAdskuKI9VfM7g6MdIyYCX2934INAcfFZM/kOhzMVypR3K8e7NmjKtCM7hl7IYj5Kl
         EHeCr8unRoU01MBlC5kYDefRks2BQ1aUfmU96GgZYsl9bHnBJwvPZmXBF0TSKsqRBUpg
         C4RbYO3+IpyxYfjmmUpkMN4YzXG/4ZMp/8mTykqbL2hKdGvPsAFQTZZ6V6eOu0CnKrTg
         m3iT7oNE6t8/bpSlo7but+KoXGCgNFHgRkWb4tFZq2X73fyP88KLOV1ZUsTWe1dC41tO
         nsisO146qbke7GYP3PlH0YI7cu27QAqAGGVTyUj1jaemxEZNJTJCVP/ccw+syqddgWq0
         ef/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WLJUfv+vtv2Xowd95rnmv6x57XGkiZ9Q0usZnZ/h/Fg=;
        b=Og6BdnCw6gnB+xhOLmBj2X6P/HJTvpz71+XRMSIevUMytjWebArrZ6QZx6gLi9zvfZ
         jtsWMKONuZMYLyVRqVa6VsKZyX/k74eSiX4vVaEajsOIE93iNmaOuKELzRbAVjQVQZMK
         28Zqo/x4moz7b32EN5x2Pndh5UzoduTS0PDg0NgaB8zrmEgh4UmFvOvn2RoBz2usgio4
         rpIcf/o+Qb0KkJxYMNAnAhpA6+tHsAJv8vH6PliJopIVgXrnXAxVx1mKXGdXDJMieQA8
         Iy3JFFnJ+gvYtczFoyaVYaYz9/MN4cb35YHV/qOqCpJdyX+fkJn91+2NfjG6Ye6PbBuO
         lc2w==
X-Gm-Message-State: AOAM532D1gU0eHd9zOrX2KPm7ndwLZ3MTB02DqRqSVhRowKv5eLQKh8L
        XGa9+rlAPnARLk23lzny+PM=
X-Google-Smtp-Source: ABdhPJwLiyGCqptiiJ1W3yzIkkwWcID1+2qC+xRSz8O8HMrMBSJYhB88CICNm7rvIqvtvkU+lUdlog==
X-Received: by 2002:a05:6e02:1e02:b0:2c6:65a7:55fe with SMTP id g2-20020a056e021e0200b002c665a755femr6529739ila.269.1646974095002;
        Thu, 10 Mar 2022 20:48:15 -0800 (PST)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:2010::f10e])
        by smtp.googlemail.com with ESMTPSA id q9-20020a5edb09000000b00645c7a00cbbsm3529834iop.20.2022.03.10.20.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 20:48:14 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 0/5] dyndbg add exclusive class support
Date:   Thu, 10 Mar 2022 21:47:51 -0700
Message-Id: <20220311044756.425777-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
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

Hi Greg, Jason,

Please consider these for char/misc or linux-next/soon/mumble.

This patchset adds exclusive class support to dyndbg, allowing it to
directly represent drm's debug_category.

It is the dyndbg half of:
https://lore.kernel.org/lkml/20220217034829.64395-1-jim.cromie@gmail.com/

The DRM half of that patchset uses this support to reimplement
drm.debug on dyndbg, and uses its callsite patching to avoid the
runtime checking done by drm_debug_enabled().

Background:

In the past, various extensions to dyndbg/pr_debug have been proposed,
none seemed to gain any consensus.  This list is certainly incomplete.

https://lore.kernel.org/lkml/20200609104604.1594-1-stanimir.varbanov@linaro.org/

pr_levels was discussed around this patchset, in revs 3,4,5
This search helps:
	s:venus: s:dynamic f:stanimir.varbanov@linaro.org

IMO, pr_levels suffers from implied meaning between the levels: 2 > 1.
In contrast, DRM has logically disjoint categories, and is implemented
in an enum (despite its flag/mask values, a micro-optimization).

https://lore.kernel.org/lkml/20210813151734.1236324-1-jim.cromie@gmail.com/

That patchset used pr_debug in DRM, and prepended "drm:kms:" etc to
the format strings so each category was selectable; "format drm:kms:"
in the query.  This worked, but it made the format config-dependent,
and was hard to explain without undue "artifact".


So this patchset adds .class_id field (4-bits) to dynamic-debug
callsites, and 'class N' query/command support to select upon it.
Existing callsites and queries get .class_id=15, so 0-14 are available
for use by the client (DRM wants 0-10).

The DRM patchset then:
. renumbers drm_debug_category to fit into the 4-bit .class_id
  the new enumerations *are* the bit-positions in drm/parameters/debug.
. adapts the category-macro layer to use _CLS macros, mapping categories.
. adds macro layer under the category-macro layer
  which wraps drm_*dbg inside a dyndbg Factory macro
. uses DEFINE_DYNAMIC_DEBUG_CLASSBITS to tie to __drm_debug
  callbacks ref the var, so drm_debug_enabled(cat) just works.

Jim Cromie (5):

dyndbg: fix static_branch manipulation
  fixes a latent bug, before a 2nd "enable" flag exposes it.

dyndbg: add class_id field and query support
  will allow (with that drm patchset):
  #> # turn on DRM_ATOMIC in amdgpu
  #> echo module amdgpu class 4 +p > /proc/dynamic_debug/control
  #> # turn on DRM_CORE in drm
  #> echo module drm class 0 +p > /proc/dynamic_debug/control

dyndbg: add DEFINE_DYNAMIC_DEBUG_CLASSBITS macro
  adds macro & callbacks to support drm.debug bitmap
  #> echo 4 > /sys/module/drm/parameters/debug

dyndbg: drop EXPORTed dynamic_debug_exec_queries
  unused yet, obsoleted by 2,3

dyndbg: show both old and new in change-info
  minor debug improvement


 .../admin-guide/dynamic-debug-howto.rst       |   7 +
 include/linux/dynamic_debug.h                 | 111 ++++++++++---
 lib/dynamic_debug.c                           | 150 ++++++++++++++----
 3 files changed, 213 insertions(+), 55 deletions(-)

-- 
2.35.1

