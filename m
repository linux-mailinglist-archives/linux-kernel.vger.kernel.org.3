Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CFB5020BB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 04:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348827AbiDOCve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 22:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349114AbiDOCvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 22:51:16 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7DCB2449
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 19:48:43 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id c1so5859950qkf.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 19:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DuvNiOMRUwwQNAgae4RO4Yy4c00pHQf9eI9auEdw3WU=;
        b=cMwRXLbz/+KCr2KPo1BXciRxgs5UmkYQtzj2Cch1JQ1/he1OhcKzvHa7AmeyMK2GEr
         pQ14VkXnV4xb+T46aiZM+gIj3naedd4fkxSJwxHevi5kiw6rTBh/hEZQ9Jf7J+ee8Awn
         Zd4QAlmDqds78tLjDD4nnrss68DhU8CDksBhIbQb7SDvzSWqmA3Wiei623g1Ywe0I6hW
         tBGhbgEl3dQjI+sZRp6+YE6GHS3ZITCew+FIBU7gVNjbW0HIXjgGHPxOvY4wLaP2QV7J
         ZOWCJ1oSSTIJL5omAuhadPVoPkYrxZBEqIYeq9PP3RNLLr7QG94fTspiN0LtY4tiDNSd
         WfmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DuvNiOMRUwwQNAgae4RO4Yy4c00pHQf9eI9auEdw3WU=;
        b=IzaIg5Pld4JXj1uqL4CS3Mp4tSme0E/L3s4jpZYgRq/UFvNeACKP7UIK3Fu63rhVBb
         2kP4NH2z8JWLvPPNhOyXUkk1VXEkINEEVVne8gF91XM/u3Oron+TdGx7ebnqfvfyNfaz
         Jghs+/f9953zkpuXR4ncZma4WcDyzZsNoFr4uOO06fs9f3/KGF7enosm/jtGLUFiftcW
         PktwhJTImbLed6QEK/XYIhS//0PMms07ruBMOPdPnCttWuVEg97o29iOMUtAn5b0/MLj
         GgHo/j77KWkrhnE+ioTkZZr99MGpTdBxSzfBskIjtQOR5r0anpVETggDS825Q+DxLbQx
         8NFQ==
X-Gm-Message-State: AOAM5330DAnQ/bK960XGidrVjJhyXhKlibC1aVXRMzFlFAogG7b7361/
        yzX8l70EzuYcn3wKTJppnfY=
X-Google-Smtp-Source: ABdhPJyD5NNq/9/AN7WV0PFPNsXoc2Vjsp3xcRpCH4w7V1D1Hl9Ri8Nv+u+Ins4Hy7BL8+iQEfxwrg==
X-Received: by 2002:a37:c443:0:b0:69c:8386:f2e6 with SMTP id h3-20020a37c443000000b0069c8386f2e6mr3213525qkm.436.1649990922620;
        Thu, 14 Apr 2022 19:48:42 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme.lan ([2607:fb90:1b7a:2349:50b1:5db4:a2d5:7054])
        by smtp.gmail.com with ESMTPSA id p7-20020a05620a22a700b0069c37e2c473sm1800085qkh.94.2022.04.14.19.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 19:48:41 -0700 (PDT)
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, jhpark1013@gmail.com
Subject: [PATCH v2 0/6] staging: r8188eu: fix warnings reported by checkpatch
Date:   Thu, 14 Apr 2022 22:48:31 -0400
Message-Id: <cover.1649990500.git.jhpark1013@gmail.com>
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
core/rtw_mlme.c file.

changes in v2:
- changed the first patch to from removing braces around single-lined 
statements, to a patch that removes the entire if-statement (because it
was redundant). The member within that statement is not being used so 
this patch has been changed to a patch that removes this unused member.
- the log of the third patch has edited.
 
Jaehee Park (6):
  staging: r8188eu: remove unused member free_bss_buf
  staging: r8188eu: remove spaces before tabs
  staging: r8188eu: remove 'added by' author comments
  staging: r8188eu: place constants on the right side of tests
  staging: r8188eu: replace spaces with tabs
  staging: r8188eu: correct typo in comments

 drivers/staging/r8188eu/include/rtw_mlme.h |  1 -
 drivers/staging/r8188eu/core/rtw_mlme.c    | 46 +++++++++-------------
 2 files changed, 18 insertions(+), 29 deletions(-)

-- 
2.25.1

