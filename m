Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768204FEE53
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 06:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbiDMElV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 00:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiDMElT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 00:41:19 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C38724952
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 21:38:59 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id p1so592345qtq.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 21:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OhTnq07iXAtz0jfkYxAOZJL1OOd02wSKlJiI9TYbfoc=;
        b=AGtVO4+cZMr9M/H/by3ycSQcwTKZGco3sC/YjDjZnVp+eg47fCul7icjFh4ZVaaAjC
         1ksNqXwLJnfRWiQIoJjlV3M9qduhqlvC6Sa1V7yIeUV2RmLitit1jLpBCGvO/we3REs5
         WjqYpiU0lvs5SexnDQWUX/mB6P5PxhUyEzpHr1pVtWAcbOVd+7cpHtLjt7OOSpQLHXzM
         NCCJIazVyd6ClEFTvO8yx/VlUVQ4vWP6HM3S+DeknchS2UA9fXFRSZzCy1Y9/zoUD4TL
         59Eh338+qNlOpv+faTlRG6AkZaThnehaoJV38W6OiNL6co9nUC2g1z1WPId8If9OowQS
         vdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OhTnq07iXAtz0jfkYxAOZJL1OOd02wSKlJiI9TYbfoc=;
        b=s4T6IlUBQn+Wz0ckdKLj7Ds4+UwQvWzrLrGjRdsSKjl4cC3b+yEzSOTcYt+qM5FQwn
         ASMy7lauSpOGT83zD5lKNuhNzmW6lB0MACdPRQH4kX3kwVoxR58l4uR1GSHdfIffKZiP
         RdqTD+PlpXLVMk92TjlgTev8S/wIn1tX1TRR+4Jg0L3FU6irEY+fseY8qPPKyhBD9xTO
         TBauRMnoiNSmafn+zgnfXaA+ODVVoQIMN6gRFUYxWiPY8NZ+tCJgbnK4Z4+1yLru3Or+
         9YtEOXyzoZtoPF0J7slDnyVtNZz835n3i8Zr6nsfoXrT9PAlN3oJ60TM4tCJGbTuTmbv
         Bgng==
X-Gm-Message-State: AOAM532yNJak7O7HoHslCzdF6An+QN64ECPT5rz6qGo5ShOfhtnTRmDo
        oeXEZqjHaz3cgY2viB9X2u0=
X-Google-Smtp-Source: ABdhPJwo5/CqCf9GrYiQmYkurX8T2Klm+Wgvd1F5+7KxI5Lh1EoSUEBdsH6RMppjEk0+vxFVd1QTvw==
X-Received: by 2002:ac8:5c16:0:b0:2eb:db39:6591 with SMTP id i22-20020ac85c16000000b002ebdb396591mr5807695qti.623.1649824738317;
        Tue, 12 Apr 2022 21:38:58 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme.lan ([2607:fb90:50fb:900e:5e57:caff:f44b:33f4])
        by smtp.gmail.com with ESMTPSA id d126-20020a37b484000000b0067e60283d08sm21984056qkf.40.2022.04.12.21.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 21:38:57 -0700 (PDT)
From:   Jaehee Park <jhpark1013@gmail.com>
To:     johan@kernel.org
Cc:     elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
        jhpark1013@gmail.com
Subject: [PATCH v3 0/2] staging: greybus: fix warnings reported by checkpatch
Date:   Wed, 13 Apr 2022 00:38:50 -0400
Message-Id: <cover.1649824370.git.jhpark1013@gmail.com>
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

The first patch corrects a typo in a comment. The second patch removes
an empty callback function.

Changes in version 3:
Edited the second patch in the patchset to remove the entire empty
function with a void return type instead of removing just the return 
statement within the function.

Jaehee Park (2):
  staging: greybus: correct typo in comment
  staging: greybus: remove empty callback function

 drivers/staging/greybus/arche-apb-ctrl.c | 2 +-
 drivers/staging/greybus/audio_codec.c    | 8 --------
 2 files changed, 1 insertion(+), 9 deletions(-)

-- 
2.25.1

