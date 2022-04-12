Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A944FE94D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 22:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbiDLUIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 16:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbiDLUH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 16:07:27 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3A3606CD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 12:59:23 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 75so11831071qkk.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 12:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OSSxqX8tPYg/tg3+HY2atLHtEG2+4vSWaPUPQtk8FFs=;
        b=ME2rzraFEBzLQVyEICnGlhLGN3TYXUG40fsZvzk0YNOCUqDi+p+05CekzEMeh8zQJn
         IOe43DpXusxGAK420y04rWTM7YGwlp9Z1NW5W2U5fVSOeG95xLGy0K5CZoXHG2XG5Rrn
         Ci/TmgBDCP6sRQZtWU24HxbQg8FK8axzA8RvRss8FNfKxVojSWHjxNmIxUMZczaEpGjm
         IurY4UMmCo5QwbcVGiI6ZWXP3aOlHNYAXBlAcefoDYaeNeptXyn68wV2oqFAjeeZKBnP
         xpZOAPEeEx5U3NeK0IRuu8hqnfxwXJBRECsvswtiu1V4FZoYbi9y5BTZdgg6OwpKkdsn
         Ltzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OSSxqX8tPYg/tg3+HY2atLHtEG2+4vSWaPUPQtk8FFs=;
        b=1oRDchZw9IpvPFE+chRv67lh+Tv6JDUsTwYghCfZLsfBDfssEnJ9gR0UrhQUK8hoFE
         XN1obD7/C15xdZOfJxRNL/BUxyr1r5ZZslBwbNeKKywohTjyMHax0MnQiUYmWEawvFdT
         LjfRUibTPjTlCy5GfesncmKagI6oWDh12hTTGKmtNBAyVVadm/1TotZXlGoPqByVTGrX
         JxZC8TyraJ6vYHWAukVTsUlKWuiJCGJEKpyA0JOkZ7vVSHaB+4//NAumTqB0vpzT4fXu
         QheBzCrTAeTSCVbMVnrj1U0d4PAQcmQCLAbrWHCBI8W5X+30yGR9Dd3M5wJ9383i+/vA
         VfaQ==
X-Gm-Message-State: AOAM5328Lpk0eRg2m81U90YZA8R58Sjni6bdYm08BhWD8G0727biodVQ
        AN38iTsJL+7XHu+YfkJDMsg=
X-Google-Smtp-Source: ABdhPJzPGA2WvKxT8VEv/QVQmi6hhSwsxGpUOGCJCjo4PLAHqRM02+IDxZUA/gXJEnbYAbOmKtXTVQ==
X-Received: by 2002:a05:620a:4689:b0:67d:4c03:651c with SMTP id bq9-20020a05620a468900b0067d4c03651cmr4343932qkb.475.1649793562350;
        Tue, 12 Apr 2022 12:59:22 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme.wework.com ([4.34.18.218])
        by smtp.gmail.com with ESMTPSA id t7-20020a05622a01c700b002e1b3555c2fsm27270744qtw.26.2022.04.12.12.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 12:59:21 -0700 (PDT)
From:   Jaehee Park <jhpark1013@gmail.com>
To:     johan@kernel.org
Cc:     elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
        jhpark1013@gmail.com
Subject: [PATCH v2 0/2] staging: greybus: fix warnings reported by checkpatch
Date:   Tue, 12 Apr 2022 15:59:13 -0400
Message-Id: <cover.1649793138.git.jhpark1013@gmail.com>
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
an unneeded return.

Changes in version 2:
- edited the subject to be more concise.
- edited the log message to be more descriptive.


Jaehee Park (2):
  staging: greybus: correct typo in comment
  staging: greybus: remove unneeded return

 drivers/staging/greybus/arche-apb-ctrl.c | 2 +-
 drivers/staging/greybus/audio_codec.c    | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

-- 
2.25.1

