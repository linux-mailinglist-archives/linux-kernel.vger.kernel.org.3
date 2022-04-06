Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1BF4F5E12
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbiDFMeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbiDFMdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:33:07 -0400
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com [IPv6:2001:4860:4864:20::44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF046C31E4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:31:13 -0700 (PDT)
Received: by mail-oa1-x44.google.com with SMTP id 586e51a60fabf-deb9295679so2160784fac.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 01:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S9flbCkJYuVABiicICutS8TqtTcgIuX5XFJ+AGVGGGY=;
        b=SDrOFDQpY8TrN61Lqs+EP5/M63Ben1p41dMcLTv+yz4Hd2sn8N/eBkIZ8aTuCA60ut
         j1mVjYZ5V9j7+Xyug71GPGIWtuxDN8EP4Ja4gZkV7E5Fu8tHOUhDhcUsdHs9x1uf+x/k
         9SEYi03YEDWC29kyKLSM4qkqXQ4i71sQgvhPCyXE23kxfSAWsX5+NJg5MpVOwZzvMorP
         dyT7IR6OnvnLm00qx+SGjp7V7nS6naLSjvuKWzr30FAadUt0swTklXNrN2S2ZQVXicNB
         NXgDZ7bOs+SSzyfClt2z7WbvJTITgaLGoiFlFIl4TplGCtoIU3jeN1R5I1qg3oAQi4gO
         HlIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S9flbCkJYuVABiicICutS8TqtTcgIuX5XFJ+AGVGGGY=;
        b=F2Sx7gfWLsCL/7UJt119BrjBnz9LeidmkLYUv1kZYrVHyMcZjmmqFKeUubCeRkLFjB
         EO8umW8sh6RapYPUmtg5D7p5an+sO0+w41V+njyWFAMKkaRjUIhOWZLRBxhz/wrVpZ8Y
         tv0IjeYg3KzBR66BOnp234tc+40g5yH+PmDWlie/KjHbIHJrvcbb1aFssiZWJRZDiLnK
         qjMANcO7myyOTFWnKZiftuYhNVb3JOJORdaYAdNX05QZscE3ycfUatQSvQrLDuM9lkwy
         GFdlX2soEswF8UWsHmd3kIUi/OAzj16jK5W4/WX7JdiQFfNGUasw7ZJF94/e437y3hIu
         lk4A==
X-Gm-Message-State: AOAM531nPYWQyVyINaxFrfwWLNNd9V5iUkaPyJHCnRv4aUe2DcerRnuP
        KHPLH/CeJprPXSzr3FO9ftgtXcSNMMc=
X-Google-Smtp-Source: ABdhPJwQxMex7QdCiVZfJ/X40BVXFbIQs+k7npdRhHGZjrSb/ziy9wt+gF+ZrbVmmEjxle8qk+8YSA==
X-Received: by 2002:a05:6870:58aa:b0:dd:a976:5e8f with SMTP id be42-20020a05687058aa00b000dda9765e8fmr3447113oab.112.1649233873174;
        Wed, 06 Apr 2022 01:31:13 -0700 (PDT)
Received: from bertie ([172.58.102.145])
        by smtp.gmail.com with ESMTPSA id o19-20020a056870969300b000dea1b17aacsm1812813oaq.36.2022.04.06.01.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 01:31:12 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 0/4] staging: r8188eu: cleanup of style and typos
Date:   Wed,  6 Apr 2022 03:30:56 -0500
Message-Id: <cover.1649233201.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.32.0
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

These patches address style issues and typos found by checkpatch
or suggested by Dan Carpenter or Larry Finger.

Rebecca Mckeever (4):
  staging: r8188eu: format comments in drivers/net style
  staging: r8188eu: remove extra 'the'
  staging: r8188eu: correct misspelling in comment 'tppe' -> 'type'
  staging: r8188eu: use sizeof(*pvar) for allocating structs

 drivers/staging/r8188eu/core/rtw_cmd.c | 81 +++++++++++++-------------
 1 file changed, 39 insertions(+), 42 deletions(-)

-- 
2.32.0

