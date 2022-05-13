Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1104F526296
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 15:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380553AbiEMNHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 09:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380550AbiEMNHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 09:07:09 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666112A726;
        Fri, 13 May 2022 06:07:08 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so10433572fac.7;
        Fri, 13 May 2022 06:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OhMSg1GLkly/CCEU2JB+IenKQ93DJgHS6kPAjmLfY2M=;
        b=qIQVTTe0byUcK60Fd66C5A21M+nOKGCZfaOdXSxVDvoQOHQ0sKWrvBBzSRFK43Mr5h
         xMoSY82aACS8hv6h6iqiqKw2Z1M8WqVVUznBg8zUuFaj7gSOkZ7UOxc+z5FpSijIoB85
         QbHIXce02acIgGXzpjYrmsoOVZlvr3ZtZq/FbVA4Bje0sZLW/KZpkPuo40E/aIH6DzcJ
         0THRtqbA5nxzdpiRhibYxQqTX7u9OGy7/OMJ1sgOT1JX8mBNHfXTcyie0UoKAUqRL5Fk
         w3Y0vIOq3C7cDEbAvkVU7s9nF0pPbUJM0XJJnNvpMStLQNp0U81Wc5NcrOl6cOzsBfaz
         GHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=OhMSg1GLkly/CCEU2JB+IenKQ93DJgHS6kPAjmLfY2M=;
        b=MPoGbIY+COeKAFQzpfMRPzSrPe3T94wKiLL5Zl0yuvPYW81ii2B9KvcGRNvz3JJGzV
         6oxkeFq484pqGi3bLRBysn8aY5wfwD26/JUbvIp4zM1POyWQzdWrdRBnN7qlXtfHcGb7
         pvvezzJUcc2hOglxG/dEExZXhDiBRDWF2HYaQno9fTyQLTWY29DRf1bjhsgxOYUpLsxE
         nFpRGqQROai974hCIr1DIdlGdp7sYCwUIwzKeVRHQyb0zHdXX5sFxVG7dlxROv1c/09d
         cqKEByLoT6x7E+cfF3Th90b0QMtl8cqTHkoZRyDYXsTg1K9V8TNzmFJ6q3DCjQXvGKdJ
         R0LQ==
X-Gm-Message-State: AOAM533J52ATzohFH9Y+tKqZ/2RMiWgiI5flXC4pV50KeHMA8qYDvcrf
        joWfv5JaKtMZ0WvlzvPu9O7AfnEZXE7FYQ==
X-Google-Smtp-Source: ABdhPJyvh58yldSJBVc3NDjCcMsgCZn6INaCdMBB/N3N+McGxGKmHkcQhwO1AqZ+E4AG0Th1f7/rmg==
X-Received: by 2002:a05:6870:a446:b0:ed:a968:645a with SMTP id n6-20020a056870a44600b000eda968645amr2482575oal.216.1652447227491;
        Fri, 13 May 2022 06:07:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v10-20020a05683018ca00b0060603221274sm909091ote.68.2022.05.13.06.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 06:07:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v5.18-rc7
Date:   Fri, 13 May 2022 06:07:05 -0700
Message-Id: <20220513130705.2488340-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux v5.18-rc7 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.18-rc7

Thanks,
Guenter
------

The following changes since commit 08da09f028043fed9653331ae75bc310411f72e6:

  hwmon: (pmbus) delta-ahe50dc-fan: work around hardware quirk (2022-04-27 04:52:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.18-rc7

for you to fetch changes up to 151d6dcbed836270c6c240932da66f147950cbdb:

  hwmon: (ltq-cputemp) restrict it to SOC_XWAY (2022-05-09 17:27:24 -0700)

----------------------------------------------------------------
hwmon fixes for v5.18-rc7

- Restrict ltq-cputemp to SOC_XWAY to fix build failure

- Add OF device ID table to tmp401 driver to enable auto-load

----------------------------------------------------------------
Camel Guo (1):
      hwmon: (tmp401) Add OF device ID table

Randy Dunlap (1):
      hwmon: (ltq-cputemp) restrict it to SOC_XWAY

 drivers/hwmon/Kconfig  |  2 +-
 drivers/hwmon/tmp401.c | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)
