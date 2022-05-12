Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1A1525042
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355410AbiELOgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236997AbiELOgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:36:50 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5379549F29;
        Thu, 12 May 2022 07:36:49 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id bo5so4974282pfb.4;
        Thu, 12 May 2022 07:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:from:content-transfer-encoding;
        bh=vBCXkB1qSkIS16SbYowUF9XTh+lgeGc7WrxqFAqEQoI=;
        b=eBimJOVi0jjQ+6pApezhKgthZsHwrX7D9plBjpPTiXj/EUp0KISAnLqaLVa/XsQzPp
         4YQR0iUuMEGkifs4cR3ISAlXK26e3rdWYoyiqJ5626WmXqV/SUp6+FYgfQfkaxhclqYD
         4pSyHHwkasI1X2uoRuDphQdXJwz1YbMQj61PqIzFwea02bPZ3JXbKXv6PTqOv30D/4en
         iaRgVeC0sDAkpxrGjZwETPuZgi4tWTxCMkZhnak85iM1WizhLU7Gp5cGRQOvmL1q0eIY
         eoxugRVI+yOoeuq8xArZLF+1zjjv2o24r6gcC5MBApFYZrsdCZRz5XIWcnjdvo0RB8Yl
         nloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:from:content-transfer-encoding;
        bh=vBCXkB1qSkIS16SbYowUF9XTh+lgeGc7WrxqFAqEQoI=;
        b=IrLfUpr8l+KIgRuhU6sdRkJzQi4thugCRChRwR0T9NHtHqf228VmCOcI8inbExyNEj
         7C4AWJwTEq0sNOuybLKZbTV2a7HPtAeszL4CqWdKxKLRhIxPzvB94AKi8u0V00LMYtvM
         AzErfNYBrgKDrhCmn+Qwra2G5DQsKLzS3O2khnxKs1+9uZqcffOA+osfgjsUUIw9DqQy
         wRPPpU0QpOiYiclt1N4CkNlSQ7/Qhx+OZQWJTAekkzeUznNz/clvJVegHSMGOyJpTvFW
         5o4YFo0bgRJ1Z60kPOjkAq/A4uGKPyW1GsPcnFhyokxoz57ncW9SVJ6CFrOC9lUiD6xK
         36DA==
X-Gm-Message-State: AOAM533IW+1CpASUcU23vp5nhflSmW87z4iNNzjwd1KmqNQILYdqppvG
        ye2CaiRArND7gXQ+fKOBzW+n7Yw9lkIkmQ==
X-Google-Smtp-Source: ABdhPJxG5hF3kDe8iW+C+xsOfGGd5qLYzePD4+p24NcnZ2gfawl52ThXEi7FlM7pl2q3JeqAMBC7sw==
X-Received: by 2002:a63:c057:0:b0:3db:2558:3ea with SMTP id z23-20020a63c057000000b003db255803eamr35829pgi.222.1652366208755;
        Thu, 12 May 2022 07:36:48 -0700 (PDT)
Received: from [192.168.0.107] ([103.249.234.205])
        by smtp.gmail.com with ESMTPSA id a78-20020a621a51000000b0050dc76281easm3876334pfa.196.2022.05.12.07.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 07:36:48 -0700 (PDT)
Message-ID: <4e6187a4-d0f8-4750-e407-e09cc1c91789@gmail.com>
Date:   Thu, 12 May 2022 20:06:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: [PATCH] spi: Doc fix - Describe add_lock and dma_map_dev in
 spi_controller
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Shuah Khan (Linux)" <skhan@linuxfoundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Siddh Raman Pant <siddhpant.gh@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the corresponding warnings during building the docs.

Signed-off-by: Siddh Raman Pant <siddhpant.gh@gmail.com>
---
 include/linux/spi/spi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index f0177f9b6..d361ba262 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -349,6 +349,7 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  * @max_message_size: function that returns the max message size for
  *	a &spi_device; may be %NULL, so the default %SIZE_MAX will be used.
  * @io_mutex: mutex for physical bus access
+ * @add_lock: mutex to avoid adding devices to the same chipselect
  * @bus_lock_spinlock: spinlock for SPI bus locking
  * @bus_lock_mutex: mutex for exclusion of multiple callers
  * @bus_lock_flag: indicates that the SPI bus is locked for exclusive use
@@ -363,6 +364,7 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  * @transfer: adds a message to the controller's transfer queue.
  * @cleanup: frees controller-specific state
  * @can_dma: determine whether this controller supports DMA
+ * @dma_map_dev: device which can be used for DMA mapping
  * @queued: whether this controller is providing an internal message queue
  * @kworker: pointer to thread struct for message pump
  * @pump_messages: work struct for scheduling work to the message pump
-- 
2.35.1
