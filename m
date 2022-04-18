Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3030504FAA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 14:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237957AbiDRMEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 08:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbiDRMEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 08:04:40 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AD113D3C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 05:02:01 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id u5-20020a17090a6a8500b001d0b95031ebso6917604pjj.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 05:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gKolG0XQSgiHwIBW1X2xlM9KdTrIkpbhaF1LVD8QWbA=;
        b=WwtsObfUy3X8kQq0ag32kuwqF0SbNvHSCJvveICT7tu2BXjLQIKdonv4p5+9reTdhZ
         EFmjjmCW7RwT5lMWrQyHk71f7rcJfebUf2xt2S2ZY0nMGlaafG50NPJeKbwUw89hw6I0
         D+Mc+KrjBDsD9Guc6lKvgGr+Z7TOsUeVosxRLRuWcGTilmmUN1ZDMk1pQXhI41CJ28sP
         Q27U2h34lIvrVloq0VZSHKRyRonSkF7cW3q6MwZccl1O5hHfSxvYrKuD1vU3fULJs2tY
         LuXYJjLGpLw42XGk3EPoiJIjQXHNpHr4pJm+ZPMXgaF9U36EcU8cXGubtibttECwZZZx
         sIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gKolG0XQSgiHwIBW1X2xlM9KdTrIkpbhaF1LVD8QWbA=;
        b=s+JsEDLNsYL62dAJ3ImfvI9CFTHzPmVvXCCtwcFqgM5Zl/LE3Dj4OvtLZTbDdCG0+n
         bUdjyQIR2waDJQx2DBVgX09IYFPVYUWaU5QL/nfNQJpkR3zFrh4OIwb2A9b3W+4bmStZ
         tIUL2HtRsMoeWgCPresdmKDKsfIGc9qgEBpySX9BPiXobuQhloRNWSan6O0pFgjUWm2t
         QeEreyDcEWp+1x7OUxZCf0QM8Eiz9xhiM/T9hfv3EKCsAX7ZZvIPJNd+el/56MiF5kpP
         l4fSjjBu5dtTTtgJC1CneNtJarwl91clNvQ9tZ4Ja+OQ1zED25D+lRUU3Sfh3zkIX4Fg
         iNjw==
X-Gm-Message-State: AOAM5313Ml+jRLGyDRlXsw1ObC6l9SyTHr9kldRqdzDnccHnZGwQiVn3
        EshcqoinGzlae0RxtS2ckos=
X-Google-Smtp-Source: ABdhPJznztowHDMO7det1bQWcePkzjntiqWp8qdvE06Y1zne+ZhGdDMSAsjRmM3tkaSmemAsn7L3ug==
X-Received: by 2002:a17:90b:4c84:b0:1c7:7769:3cc7 with SMTP id my4-20020a17090b4c8400b001c777693cc7mr17887207pjb.73.1650283320894;
        Mon, 18 Apr 2022 05:02:00 -0700 (PDT)
Received: from aliyar-HP-Laptop-15-da1xxx.domain.name ([14.139.241.88])
        by smtp.gmail.com with ESMTPSA id p1-20020a17090a680100b001d28905b214sm3840628pjj.39.2022.04.18.05.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 05:02:00 -0700 (PDT)
From:   Aliya Rahmani <aliyarahmani786@gmail.com>
To:     clabbe@baylibre.com
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        Aliya Rahmani <aliyarahmani786@gmail.com>
Subject: [PATCH 0/3] staging: media: zoran: fix warnings reported by checkpatch
Date:   Mon, 18 Apr 2022 17:29:46 +0530
Message-Id: <20220418115948.5456-1-aliyarahmani786@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches address style issues found by checkpatch in the
zoran/videocodec.c file.

Aliya Rahmani (3):
 staging: media: zoran: use seq_puts() instead of seq_printf()
 staging: media: zoran: else is not generally useful after a break or return
 staging: media: zoran: avoid macro argument precedence issues

drivers/staging/media/zoran/videocodec.c | 9++++-----
1 file changed, 4 insertions(+), 5 deletions(-)

-- 
2.25.1

