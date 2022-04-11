Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EC24FCC88
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 04:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243563AbiDLCku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 22:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235248AbiDLCkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 22:40:45 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3471F19C35
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 19:38:30 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-df02f7e2c9so19412538fac.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 19:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pa9WwzHadKlCjrvfcB9D4MgnDzHSCGlSrVswLImMa8I=;
        b=D72TXjIRRxAYUF1GhrIJuBx5NNanvsTIdEn3+x88WpFvr8xQvL9Okk2fyovtwES8im
         rjXE8JZEsJHZ+50iEyXzBCfhA0H7a9ghbwIyEo5RRHCX5CUvnxCb12+TN40zmDgzQrU+
         w+feNeZGB/zowaw/EuMMhc9s644RVHwPs8itqCEzBzb9N7Xs0yOOXwRQW+Sn+gsDLooD
         qI8DofOhBZLAQX/9GiPaHsi/I9Zbx8qAO0bBFKt+5D+lazIILxC6JOY284BEVlabuh/m
         DaLXJHuHws8JcJ5GdqhMoxW6X+RdoWdHxwN4I+ScA+JDDb2rchTTzjX/6Z0qAKSqvBkB
         02ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pa9WwzHadKlCjrvfcB9D4MgnDzHSCGlSrVswLImMa8I=;
        b=dWOd9k0mubiQAmHjZhP9cLbWTXWvrvDfB6jr5jijMW6dxV3szPOiQK9xdwyRqmzJhY
         oAlrFYA2LC51dzUSL/gm0uyBGVf7ri8qV1LqPF4e8NlxWKdO0kgTruGu5JV3QVAR99pB
         RkS5+Q/WY30zQFB+kRlwtg2VgLViWfyrV3MKg2w9Ri81973aVUwaovcfXMijNvKmm7Ep
         //tswuPTfoo5R+0SOBw2JE0/ZmfkkSVuaB6d+Sgb7ZcMe5eKpxYj/bXUwbRiJO0OEBs/
         DQCDNLJaVfypMT/hETvqlUTgjLqiJEJuOT2eiGwFsqe+Bqy9aPr1JKvG3YRYAL5gRWsA
         kvAw==
X-Gm-Message-State: AOAM532rUr6tlfani43+Xe9N7Mx+bCU/6YOhSkgiaFxUdGqNSQAgEzbM
        NwpiYs7jsxugSdiP19O28Ig=
X-Google-Smtp-Source: ABdhPJyCDg9ewqGRiwFCMT8iZhMryAHQAGR8IoOQ4I0nYRrdV4IAsb5Ni421s9WyGQK7M1Rg7wrRNA==
X-Received: by 2002:a05:6870:c20e:b0:e2:ae93:8ee1 with SMTP id z14-20020a056870c20e00b000e2ae938ee1mr1156567oae.12.1649731109593;
        Mon, 11 Apr 2022 19:38:29 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8a9b::1002])
        by smtp.gmail.com with ESMTPSA id p14-20020a9d744e000000b005b235f5cf92sm12995256otk.65.2022.04.11.19.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 19:38:29 -0700 (PDT)
From:   Tales Lelo da Aparecida <tales.aparecida@gmail.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        andrealmeid@riseup.net
Cc:     Tales Lelo da Aparecida <tales.aparecida@gmail.com>
Subject: [PATCH 0/1] drm/vkms: check plane_composer->map[0] before using it
Date:   Mon, 11 Apr 2022 20:38:00 -0300
Message-Id: <20220411233801.36297-1-tales.aparecida@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I'm interested in collaborating with VKMS, please let me know if there's
anything that I could better.

Tales Lelo da Aparecida (1):
  drm/vkms: check plane_composer->map[0] before using it

 drivers/gpu/drm/vkms/vkms_composer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.35.1

