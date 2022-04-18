Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEAA2505C6B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241262AbiDRQaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234285AbiDRQaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:30:19 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131D82FE70
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:27:40 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id k29so19723021pgm.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jg3I++lP3pbQpRoWlcxdvPAkXeaHQxo24ELrvPlKM/E=;
        b=cH2GtU4LOPOi/+XBRfxwnugAfu0MPMQBxc9Wu2WamMHh0/XU0iB5aWy/x2QibxbdMz
         jonHhv2fpMfGsFFdksSLpzTUCMwZW3YH/LkQrMxrFq6/o1NgYMv/3a4SpODk1IojLyvY
         IYHpnEVbqsTZvSEfJSCeZAJMTEcXlse58I9/w5JeWubORPPRGql+zsoMRWU7KaWJXA6r
         s9zRR7+JN8jVq2cZJfhsYYNiX0z7gs7nWbFIP3tyG5Ic9AGftrDTlerwTY6jj1rfzrVl
         cueDDFT9gAbj8d2+mXLK15eFIneY7baVO3j+ySLaQ1a+tJIHrQYJZaxyhVKGs6JqoMBr
         IbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jg3I++lP3pbQpRoWlcxdvPAkXeaHQxo24ELrvPlKM/E=;
        b=ijuqQ+9g+vvdNMuLoKvFKl4Ylc1DgQ5rD80akG8ZCMp0gGMNraP7reWi20u3mi+4ns
         YDrePwLN8xbiMI1qCpAc9PTjRqL6DTucji1AsRDtH+RI00JbF6nZchCqUOXfRvGIFP+i
         VaZiRsJx3McC01PU4RBfnLVTR5UdZHi+rnXhGdq0nM0TztWQBvNIxS+AiRp9yUO583oa
         alqaC88oXPs6DEihSR7WFVmD+kSU7MFWj0DZn+dAgs8ijoj1oYolQ7e/YGBrjr8h6ehK
         GnUORf2lJWPtIjD2c9vf8VNViN12RyfBKUJ64FM5TBE4qgPErGEQpwRUcSfPtUCsvHQI
         6r0w==
X-Gm-Message-State: AOAM533GopID+Rf+oqm9iqmwrbwmjF8V5zuql3l+5V+ydKV63L55uqRF
        Ulu6fEOyf3J5IGBJTnhDFwV8FZ1bP8dWlA==
X-Google-Smtp-Source: ABdhPJy/wZWcx8WwfVMjBPe1HkCVD8WdLwNDNvqg6YytGt/MvW2eDtFq6Wm1AVa01LsHpGX2s6ntKw==
X-Received: by 2002:a05:6a00:cc4:b0:505:6998:69b8 with SMTP id b4-20020a056a000cc400b00505699869b8mr13078108pfv.19.1650299259424;
        Mon, 18 Apr 2022 09:27:39 -0700 (PDT)
Received: from aliyar-HP-Laptop-15-da1xxx.domain.name ([14.139.241.88])
        by smtp.gmail.com with ESMTPSA id h18-20020a63c012000000b0039cc3c323f7sm13295602pgg.33.2022.04.18.09.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:27:39 -0700 (PDT)
From:   Aliya Rahmani <aliyarahmani786@gmail.com>
To:     clabbe@baylibre.com
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        Aliya Rahmani <aliyarahmani786@gmail.com>
Subject: [PATCH v2 0/3] staging: media: zoran: fix warnings reported by checkpatch
Date:   Mon, 18 Apr 2022 21:52:42 +0530
Message-Id: <20220418162244.15346-1-aliyarahmani786@gmail.com>
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

changes since v1: Rework commit description and subject.

Aliya Rahmani (3):
 staging: media: zoran: use seq_puts() instead of seq_printf()
 staging: media: zoran: else is not generally useful after a break or return
 staging: media: zoran: avoid macro argument precedence issues

drivers/staging/media/zoran/videocodec.c | 9++++-----
1 file changed, 4 insertions(+), 5 deletions(-)


-- 
2.25.1

