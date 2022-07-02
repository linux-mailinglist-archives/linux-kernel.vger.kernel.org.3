Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9851564193
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 18:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbiGBQpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 12:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbiGBQpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 12:45:13 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E79DF7D
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 09:45:11 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id b2so5006993plx.7
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 09:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=VSYpk3Of4FBRUJYqmq0M/j5cpHskb9czYUFMGWXE4WlIMNDhH/UtSjzwfIb14lYM1X
         YKvNLiIPfHKpQ2v2kBG3crgX1zdIy73JVu7GvNdfLEZbdub/pHTvAhIwLCp7JOgqHwLz
         YL8AVppw9gKGV+u/oUHYOb1qdE3T5T1TTz928Zauc4EhIvphJpIg1mxZIDfPbIvPY0pT
         /TNrhZAGLjyFwFYOt+3aOBrhbb08gsOsycHPPuDi7EKBJj+ZoUIShqlTiZq6aSDh0SJX
         3J0fA9NVZVcL3PYDtMFM8Nhhxvn1+H1gy4K9eyAvgLxNaIAR+3pwhKNoGkHhxmyTl/z4
         3Umw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=5NyOkDJOEZaP5+0xmZf3g7j7oumw3HwKKppmhiEb1b6cHSlZRIT3Z+DpOAguEz0Nlk
         vr/LAqs3bXYFMcXckYHXx7+FTEQ1IPQWvX3UGEYnRDuqAXIDbeR9g+yS8TKoxqPmxa+r
         6eVv5DkRlGeoCLCAPsBlSCcJm+Qp+XcyLA+Dh8HCMnJjPcNZmBLxTf/rNEaD9KIQDbms
         vkKXkEipdfB5TJnxlI4TtYzIm6upkrH/XZzGzRwcj+zluWFPLWPXZkcxKLWQ9Dnm/B4j
         O+1JPGHH8JamswBVZco2sSZkBVUL0UrcVLW9UUPtuq6xUNHCO9pCX9VMqjSoYF39LPyu
         RWOw==
X-Gm-Message-State: AJIora+uvRgD/W8EMCDFQQjqOw3+pqdInbX+4mtsHNiePErb4U1q2B3K
        ld5iJiRkJc3pQnqm3Cm/5psjYFM7iCzSONVbYDI=
X-Google-Smtp-Source: AGRyM1uyuKX74bCHjm1VI2Vn5AIuArSNDf3eHGmRGW/29wR/9JpvoKF1bRMpywiYD8rv/HW9szRVVXopOrREuibtIlA=
X-Received: by 2002:a17:90b:4f8c:b0:1ec:d1bf:8c64 with SMTP id
 qe12-20020a17090b4f8c00b001ecd1bf8c64mr24042197pjb.66.1656780310972; Sat, 02
 Jul 2022 09:45:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a20:3b2f:b0:88:139b:2e2a with HTTP; Sat, 2 Jul 2022
 09:45:10 -0700 (PDT)
From:   zenith banks <zenithbannknig11@gmail.com>
Date:   Sat, 2 Jul 2022 09:45:10 -0700
Message-ID: <CA+k8gY65q1G-p3jrNF6VG9p_rLQQ1V0Pc-37SGp7=zMcwYMVSA@mail.gmail.com>
Subject: Confirm the receipt of this mail
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


