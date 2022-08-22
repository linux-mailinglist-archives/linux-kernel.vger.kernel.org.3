Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76A159C584
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 19:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237311AbiHVRyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 13:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236898AbiHVRyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 13:54:39 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CFC4455C
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:54:38 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id g8so6716753plq.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=kVfoZhmtTtg50QC8HN2WpAxI8M7n5JgORmykDE3kKsE=;
        b=ex8+AFJr958wVkeLDtFOFTNG4S6PuxUOEUJ302qWzN1ns6MzQDhh5xNOf4cebaELXZ
         JE1xEvJAZda5+vGNaYhg6BZGpjObgPfWfjcOuxsDsYZnZwgue3H5y1XospGYbe1b49kd
         s6JAibLMo8RrAbyiGULc8Eu4sz1YYttLG+pTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=kVfoZhmtTtg50QC8HN2WpAxI8M7n5JgORmykDE3kKsE=;
        b=uxiHB1G7/zwRHb/SItE9rEWYKt32Vtl9qoqFz537llBBi89m3x+r1771emSU2C8yxG
         DvkX0k/0YI+80o48/8D9wjSNrh7OL55kbEZnoJO6aVpUZKozo4lb8xnqS0GM+NpJ9bSk
         pPmyYQACBx7CXF8cuyqqlEqf/9LyvdDKrHxu0ujNyQQG1VAUQaCd1+q1/Oq+YGR7lSST
         92X+b8DoqWzvBNDwyIErsBUgZrvJBx+Dsk+YtsXTg+OMwZUFbaS+Izjwy70tlbLE+x1w
         OoQ1TuHo0XH7vbsAqxCl8wtuDLdqtY5ATAHmSPBbPQDWkPCMKnTmPYptfsqxQzuL8ZWM
         kBJQ==
X-Gm-Message-State: ACgBeo3o2xGdCWnAmzCExSj1X6SnR+NHaNaE65RdTBb9dBfqnlaiSmVf
        ZFt7nG6Z+TbX0GTDQJPjaFn43w==
X-Google-Smtp-Source: AA6agR57wxjf/2ZQ0TI1hnwsMJDxfzNE1alik7oxQcsLCLejTac3WzelCkKFF9Ccs9X2LyWZYvgSjw==
X-Received: by 2002:a17:90b:4d0e:b0:1f7:ae99:4d7f with SMTP id mw14-20020a17090b4d0e00b001f7ae994d7fmr29382895pjb.200.1661190878070;
        Mon, 22 Aug 2022 10:54:38 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:2d6b:83ed:6a4a:9f9e])
        by smtp.gmail.com with ESMTPSA id z12-20020aa7990c000000b00536431c6ae0sm5297578pff.101.2022.08.22.10.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 10:54:37 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add myself as a reviewer for panel-edp.c
Date:   Mon, 22 Aug 2022 10:53:59 -0700
Message-Id: <20220822105340.1.I66a9a5577f9b0af66492ef13c47bc78ed85e5d6b@changeid>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

panel-edp changes go through the drm-misc tree (as per the "DRM PANEL
DRIVERS" entry in MAINTAINERS), but ever since splitting panel-edp out
of panel-simple I've been trying to keep a close eye on it. Make that
official by listing me as a reviewer.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f9366144d31..fc62434f693f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6343,6 +6343,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml
 F:	drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
 
+DRM DRIVER FOR GENERIC EDP PANELS
+R:	Douglas Anderson <dianders@chromium.org>
+F:	Documentation/devicetree/bindings/display/panel/panel-edp.yaml
+F:	drivers/gpu/drm/panel/panel-edp.c
+
 DRM DRIVER FOR GENERIC USB DISPLAY
 M:	Noralf Trønnes <noralf@tronnes.org>
 S:	Maintained
-- 
2.37.2.609.g9ff673ca1a-goog

