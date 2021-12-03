Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D90C4670F9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 04:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378438AbhLCD7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 22:59:14 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:38198 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhLCD7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 22:59:13 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 4J4zWQ250Yz9v8yF
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 03:55:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id A2lodB0tci6p for <linux-kernel@vger.kernel.org>;
        Thu,  2 Dec 2021 21:55:46 -0600 (CST)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 4J4zWQ0C4Pz9wjXS
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 21:55:45 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 4J4zWQ0C4Pz9wjXS
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 4J4zWQ0C4Pz9wjXS
Received: by mail-pj1-f69.google.com with SMTP id p12-20020a17090b010c00b001a65bfe8054so1008942pjz.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 19:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uL2yNvkA3EwvvLX30C2sN3DzOJq1PBcjm6fgTdzFxIY=;
        b=Y7hRR5jgfbMNFtMzlfpttQEcDHHEzIj9/EhXj9fjV8ZbonFzo7Z3446+4m1pHh5SW7
         eAuiBP6s293GQGKQxgIwWu3XDm8Lkg7HbNY0YZan4uaHTWWa89DHOB5hW1kgbSeQpApy
         yt+nqRltXpQsWoiiGDrTaoNOCx9x4mtznIJ+wAFwI7nKa9utnBOg0lj9s3AQ4/jDE2vJ
         uk6iQQVbZ/gH9fb62wSKoA706B6ZOdXsWiD30C4iDU6an8u+788pCquPp3h3EAkBPv8/
         QLEzo4cuiaw3af8liOSscYCITAJTNFUx6boJerq7Lh8IWMPjD9A0jvIf6BFKOAUt0hRL
         /mvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uL2yNvkA3EwvvLX30C2sN3DzOJq1PBcjm6fgTdzFxIY=;
        b=pGRsH0Xy+Qm+ZZy6yx5QUlXWRDH4hruZZlpYhwX5Kioc+zTpZ1/aLK9qsETcdnmdHS
         u+1SFDXAzth3cHCmKJIn7LFCEQ7pAqC9v6agOcidkvEaF1PsNMQhbN0QZ4dvbwEzKwqt
         U3BtaC5ImCIu93heZ8wK1+PLY5IfgwZLU/XO+gmFQU3Y210vyQPboTq/q/P50g7weOy6
         4vDeTsiSHfEIkyHKmtdsJPujOD48WiOK7RAdkQ/4w3JvkQl8q0L+wehJAdwJ0kB9Cldi
         WKrDbpodt+YYM1+jThm+TSfSJaFXhAPc5Ul+BxKoL+vhcVCBkZWnCvgSMsUawfatVbpb
         H18A==
X-Gm-Message-State: AOAM532Pm4SyiW1xsCelYcDQvstszvI5eWiobRc7j0IiJ/WbNIEp2dbB
        UVcfW3LLCbqZ5RTNrUor18iOrLvmLbjP6m/TICzY4jSIiR8UwKqEFXB7Gv5XR69NeOieRUAFo2W
        mLc+CUpzOErYSaGf1967ui9fFHuDT
X-Received: by 2002:a17:903:24d:b0:143:beb5:b6b1 with SMTP id j13-20020a170903024d00b00143beb5b6b1mr20071178plh.54.1638503745244;
        Thu, 02 Dec 2021 19:55:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwudyrYq9gQZ+R57vlzJMoUgCs0HJi/sF8Ao7ohFMNOx3e9v+E2exzSAkJ3YtKBdAq1kaOAFA==
X-Received: by 2002:a17:903:24d:b0:143:beb5:b6b1 with SMTP id j13-20020a170903024d00b00143beb5b6b1mr20071158plh.54.1638503745029;
        Thu, 02 Dec 2021 19:55:45 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.4.93.212])
        by smtp.gmail.com with ESMTPSA id w17sm1286471pfu.58.2021.12.02.19.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 19:55:44 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        Alan Cox <alan@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/gma500/psb_intel_lvds: Fix a wild pointer dereference in psb_intel_lvds_get_modes()
Date:   Fri,  3 Dec 2021 11:55:39 +0800
Message-Id: <20211203035539.34627-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAMeQTsYZuqqOGjernWKY=GL28DuW=0wXDbGsvaiuv+53CA36vg@mail.gmail.com>
References: <CAMeQTsYZuqqOGjernWKY=GL28DuW=0wXDbGsvaiuv+53CA36vg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In psb_intel_lvds_get_modes(), the return value of drm_mode_duplicate()
is assigned to mode and used in drm_mode_probed_add().
drm_mode_probed_add() passes mode->head to list_add_tail().
list_add_tail() will further call __list_add() and there is a
dereference of mode->head in __list_add(), which could lead to a wild
pointer dereference on failure of drm_mode_duplicate().

Fix this bug by adding a check of mode.

This bug was found by a static analyzer. The analysis employs
differential checking to identify inconsistent security operations
(e.g., checks or kfrees) between two code paths and confirms that the
inconsistent operations are not recovered in the current function or
the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Builds with CONFIG_DRM_GMA500=m show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: 89c78134cc54 ("gma500: Add Poulsbo support")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
Changes in v2:
  -  Use dev_err and return 0 instead of returning error code.

 drivers/gpu/drm/gma500/psb_intel_lvds.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/gma500/psb_intel_lvds.c b/drivers/gpu/drm/gma500/psb_intel_lvds.c
index ac97e0d3c7dd..3b3aa8fba6c9 100644
--- a/drivers/gpu/drm/gma500/psb_intel_lvds.c
+++ b/drivers/gpu/drm/gma500/psb_intel_lvds.c
@@ -505,6 +505,11 @@ static int psb_intel_lvds_get_modes(struct drm_connector *connector)
 	if (mode_dev->panel_fixed_mode != NULL) {
 		struct drm_display_mode *mode =
 		    drm_mode_duplicate(dev, mode_dev->panel_fixed_mode);
+		if (!mode) {
+			dev_err(dev->dev, "drm_mode_duplicate() allocation error\n");
+			return 0;
+		}
+
 		drm_mode_probed_add(connector, mode);
 		return 1;
 	}
-- 
2.25.1

