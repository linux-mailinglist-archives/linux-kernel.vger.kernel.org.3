Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0901C582F04
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 19:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241706AbiG0RUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 13:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236313AbiG0RSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 13:18:31 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA8B79EE8;
        Wed, 27 Jul 2022 09:43:52 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 15-20020a17090a098f00b001f305b453feso2801865pjo.1;
        Wed, 27 Jul 2022 09:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jLl28q0YHHTxCCA5OBtJuL5L9i48jfBj5mPfPnOXWnU=;
        b=gTqC3mK7AhqDxoVzYGypLAHyHnuJyOHaNTyQjZSxbDDaLLMzHWR/WP9vjN+BEf7ZrN
         Fit/pgr3trM5rPWHk48OyLLH9RgVMVbUXkIkCk+Jf8UUq7Ixq10MdWG5TqYbEOGR31nV
         qsGV3q9SwnGIQePCh+MvO/t8bPRTd+8yYBHbLfqgUeg11NiAFrxhLg7KRX+lMGCNvMj5
         eshRUR5CIFKYl0Q/8ArSW7i1Kc7cq0Ija+q7nd/mvYJD++RTwcjdDwoerC5TwBXLzCDS
         jFvTidDTb5rxdGrTKSLMVxZmoCHN+DVOy2LOS3p+Gk01xSY112n3ooSyfPPZJeieGzO6
         h1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jLl28q0YHHTxCCA5OBtJuL5L9i48jfBj5mPfPnOXWnU=;
        b=4/ZJ/ClXYcD/5Rg5Ljcqv64J7b7yVW0c+Z7wSqsP8gxPq7iBVjlxaRGGz8+l/xSayS
         3UIFfLis3MYfysFlQOFr81jMn2azRqjIdhJUhf8U36WkRi0ikTBom2NkQbD8z+KtA/NX
         AvV2COgTpH3ovYsDRd2LPukSyt6ew87A+u4jJeQhDnrYhq0c19GlHrYNPYPB3xS/4lfJ
         SCWTQsMhcP6EfIa9xz2M8WuzMaUZMhzlOTB09t6JyCk9Wb70mFMnA9U72kRpJNZ00Y7f
         V+738uD11XhV/CXXjNKiUDjHIrJSpPEXm4asbHIcqLFKvPGOoOL6UfJ3ZXqlgNdqxi6h
         wTbw==
X-Gm-Message-State: AJIora+fL8jk8VZc5Mca85Aaw06XMH3UYaOhazKGrqV5If8c+d5KmnQ1
        QmQCuxFMMT48O4I0APgyhQt7bTpvcP+FKg==
X-Google-Smtp-Source: AGRyM1ts0wZ3ofA/neE3N1ENMf3fYKfoZeO2BR/ZDCXzFjjnHZTPpgl6A1YvRBAQn0cpHTliNUb18w==
X-Received: by 2002:a17:90a:62ca:b0:1f2:ef43:72a1 with SMTP id k10-20020a17090a62ca00b001f2ef4372a1mr5495888pjs.217.1658940231334;
        Wed, 27 Jul 2022 09:43:51 -0700 (PDT)
Received: from potin-quanta.. (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id h13-20020a17090a3d0d00b001ef3f85d1aasm2030480pjc.9.2022.07.27.09.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 09:43:50 -0700 (PDT)
From:   Potin Lai <potin.lai.pt@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH v3 0/2] iio: humidity: hdc100x: add manufacturer and device ID check
Date:   Thu, 28 Jul 2022 00:41:31 +0800
Message-Id: <20220727164133.973930-1-potin.lai.pt@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this patch series, we move the callback from probe to probe_new, and add
manufacturer and device ID check for hdc100x driver.

LINK: [v1] https://lore.kernel.org/all/20220722172035.44977-1-potin.lai.pt@gmail.com/
LINK: [v2] https://lore.kernel.org/all/20220727064415.940690-1-potin.lai.pt@gmail.com/

changes v1 --> v2:
- fix typo in commit message
- change to use probe_new
- use device_get_match_data instead of i2c_of_match_device

changes v2 --> v3:
- move probe_new part into a separate patch
- remove unsed variable
- remove redundant checking of matched data

Potin Lai (2):
  iio: humidity: hdc100x: switch to probe_new callback
  iio: humidity: hdc100x: add manufacturer and device ID check

 drivers/iio/humidity/hdc100x.c | 75 +++++++++++++++++++++++++++-------
 1 file changed, 61 insertions(+), 14 deletions(-)

-- 
2.31.1

