Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918565A0FCB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240993AbiHYMAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241363AbiHYL7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:59:54 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37525DEFD;
        Thu, 25 Aug 2022 04:59:49 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gb36so39018108ejc.10;
        Thu, 25 Aug 2022 04:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=3M+Fhxoyg91Vp2aX+QclTk7ormS7D2YMWBC3/wSZRAo=;
        b=T6VhRxHZKh3ydTDH8eyLIXVHKw5PE+3T+mPiOP/4cMWTVgELocwIa222zg93Iz2iXl
         KULHrQNnLCCAHlqxWVsWNkIKgcPE4yvcrG4CgxQYx53uEUD1+tYtNEfWaDciFY7mmdAr
         6OMj7asdMnF0IQqS75aGNIJfWGSemPH59vsma7GzGEsvGngzpCSE16AYTylIn4lNsgUh
         D7Mgg60B9cdiVptBnAtx+tN6tJyv4OvW9CCZGSPcDt7ELkfIeHUrTA7kOQQz7YVVu48U
         BD8QbkTV0RucZZFFhbetGm+zMrIzPovthtYnFqhprMBK9ypB2d19EpP6kzCSXqLYBckA
         NdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3M+Fhxoyg91Vp2aX+QclTk7ormS7D2YMWBC3/wSZRAo=;
        b=L04FbN8kGiLLpktYfwTWC+dOyldM3x1PBzDuPMfpFIUJwDIkbZkeOPEDFG4Fydtq0Z
         bDRpqdCKtZP1w1scMWYDbrNSBDlevIxidS/L1k0xEpLzPrz/0OfAeLeBZZHiq0d3xCoy
         aKMPFuehS/321POSJSARKKx9nDMZGbBJqk9QaMa3u08RTRk1NdkEGtO6kqv5wW57cVdP
         lHO5qogz8CuhBuR6y+vqUaolgBRS+YgSWrRwviSOMcGzwVIke73bxzd2cQCNncATVKJA
         MhasTAJptjZgJFvVPCgH7Pdf0OP5G1rvgjm/bEH/mC3OLGJRoJRviv/94Ux0ahfW1RGp
         KZdg==
X-Gm-Message-State: ACgBeo3TMwKPo807kDlLxn9seAMc3OKLv6r7OOa3h3H31xnZHFjDchpS
        8DKJ8pMbkyGKb/4+vqRoJ7R/eZYxfXQ=
X-Google-Smtp-Source: AA6agR4rzhafpBqSp4G2j/exoVRiAdAnjsbcwn+e+ZvXAHqYfB9jRqYi9rx2iBF8xM19C8giy5pIbg==
X-Received: by 2002:a17:907:971d:b0:73d:78c8:77b5 with SMTP id jg29-20020a170907971d00b0073d78c877b5mr2258032ejc.631.1661428788416;
        Thu, 25 Aug 2022 04:59:48 -0700 (PDT)
Received: from felia.fritz.box (200116b8261c3400205311ca607dec9d.dip.versatel-1u1.de. [2001:16b8:261c:3400:2053:11ca:607d:ec9d])
        by smtp.gmail.com with ESMTPSA id bs3-20020a056402304300b00446bf462203sm4751378edb.1.2022.08.25.04.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 04:59:47 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: add scripts/tracing/ to TRACING
Date:   Thu, 25 Aug 2022 13:59:27 +0200
Message-Id: <20220825115927.20598-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The files in scripts/tracing/ belong to the TRACING subsystem.

Add a corresponding file entry for TRACING.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8fd6a1721e69..8022a4dd2ef3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20643,6 +20643,7 @@ F:	include/*/ftrace.h
 F:	include/linux/trace*.h
 F:	include/trace/
 F:	kernel/trace/
+F:	scripts/tracing/
 F:	tools/testing/selftests/ftrace/
 
 TRACING MMIO ACCESSES (MMIOTRACE)
-- 
2.17.1

