Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73035832B3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 21:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbiG0TDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 15:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbiG0TCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 15:02:36 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD40B617F;
        Wed, 27 Jul 2022 11:19:20 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id m10so13503362qvu.4;
        Wed, 27 Jul 2022 11:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sv2OvnfK+ly8it9Ot2HpoNH1vK1oSywKBPdopl6H5R8=;
        b=Twlrq0tNdqqveLigPpocGVsZXRU2r9eAEaUUylTV26/b6aqH6kKTOZlJ7c7zFpsSUG
         8JPcZUHR/YO0EylnHF/925QFeleH0Ub+IKPiEkqNfkIE/DjlcR5mv8JPFiv+bbhxO62U
         msFl2XrFDtLc17p1nAl/lOmcoq6uDw5GZGemJ7NGU8TsHUZH5FTQ/39H23FZvhc9JkZa
         s3JhmZQeqi3GQhwdyY+yAfBXsmYxGGCzehgKvNF3AomD37eZbXKjMoDjprabRVI7p1kU
         PEzyqm7//tQfh4jnGh2/N6PeGW7u/yLILgnPc8I8p1zkBdEGTsyWIvWU8MIVussAJGYv
         vENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sv2OvnfK+ly8it9Ot2HpoNH1vK1oSywKBPdopl6H5R8=;
        b=4bml9UYGMgqGU1d/lWI9PiWB8r159PnHi1pwP0gs2OxqvBDqMMvISZ6XnbFYRd2nTO
         daPyyXC1jCWwJNQ7lfGdCkcXdV27yB5XJeI8YX51G9NtcmxwMzEr2dFQwGHZhzToPVML
         5O58eYH84sOScMl4WnsyNQFovzEKza9RemfFC2kzAuX8SRnVAzURv5rfK/8NE4KPkMIW
         HcuaVClkvsTxSTRfk8GRNKIj1vhLPVgyLTjtfCgpoqgBhXOpThcI4frGRY9zEFd9rfsU
         t1QCe6Tt0A6nlAzC7fU07jGhGc8p3WPbteb5l7RGdwX2dTrmLwXKNe3XOKuKqHYafeF8
         yqQQ==
X-Gm-Message-State: AJIora/+EXiqvEU+gsqCDLtz2argOveLG75wa1JMC847RBBsUBmRl6lW
        9OPWICwAns+TzKnNuUEojfdQN8FkN6U=
X-Google-Smtp-Source: AGRyM1tYsvDYgGXdzQUrtSBXjoLLmRNU+zuMAssdoC44h45+6ZECyNwpwOyuvjcvn5+d/x/O6YfU9g==
X-Received: by 2002:a05:6214:2aa1:b0:473:2cc2:63e with SMTP id js1-20020a0562142aa100b004732cc2063emr20989931qvb.26.1658945960021;
        Wed, 27 Jul 2022 11:19:20 -0700 (PDT)
Received: from spruce.. (c-71-206-142-238.hsd1.va.comcast.net. [71.206.142.238])
        by smtp.gmail.com with ESMTPSA id bk27-20020a05620a1a1b00b006af1f0af045sm13195972qkb.107.2022.07.27.11.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 11:19:19 -0700 (PDT)
From:   Joe Simmons-Talbott <joetalbott@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Joe Simmons-Talbott <joetalbott@gmail.com>
Subject: [PATCH 0/2] iio: Whitespace cleanup
Date:   Wed, 27 Jul 2022 14:18:53 -0400
Message-Id: <20220727181855.589052-1-joetalbott@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Fix whitespace warnings reported by checkpatch.pl.

Joe Simmons-Talbott (2):
  iio: Add blank lines after declarations.
  iio: Fix indentation for multiline conditional.

 drivers/iio/industrialio-buffer.c  | 5 +++--
 drivers/iio/industrialio-core.c    | 7 +++++++
 drivers/iio/industrialio-trigger.c | 1 +
 3 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.36.1

