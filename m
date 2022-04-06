Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8C94F5E2F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiDFMew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbiDFMdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:33:11 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D62830AD9D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:31:26 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id i11-20020a9d4a8b000000b005cda3b9754aso1245018otf.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 01:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e2nIgPNh3LZLtjXU7XO/QsmWtjivZoy3EzJLLI+3/RM=;
        b=GzXIj9P51h2wKssIFpZU6VktIrPFOKUFfby38bTBRySx0eRoIGPrId2GUiPWIiEMeE
         OJ8yJvfDsmS5BptMR5Wz0Pfxau9wqrCmZYiyCL/SlO23cyUgvuUhwjidVX2qNpuKaA90
         QkHPW2Rjp/8+w0S2n57adAl23CQ2GnQss6q1lUDOeKdOZ5wb3+n2hppUtC5oDWFB0vsa
         VPcQvsdb1KIf0iLdiEZn2cToz2bXUHhS9D+gpExEoCTRK8xqCJVZB2cc+/Zi9XYAQixJ
         9EA/xE17zxKmzq04uPrLWE8l27kHJ+VsaBMtlCqCvEVheqeremAYugdoaq0+DKnin3gt
         uvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e2nIgPNh3LZLtjXU7XO/QsmWtjivZoy3EzJLLI+3/RM=;
        b=taZRwepBIqLecRLed3PqkKd/77HUBTYLhZ9bQVEntQjihQiPSIHhZqpo4NzZ3qcfWD
         ZOAV22z/7JQhWtF3BNhITLjPH4KTKKdADHvgaLS90hnPdwIvwEK9tJ2PyAnsq6e2cZe3
         E5CNJYhPSXj1Sp4ApxWDJg+ho45ss4OCO8RaDiWTXiRd7Ymc0hJNyTsF2k2vPv5Sd068
         Pbx7fm34SObvDiv7N7UFYz/4zXQXba1zqUib3lV93gi6xKrfEoiBxcHiLzR/nFORJsAB
         mMZ6HguoOB8HZycD5pnxttwBG0Sm+3KB6fO3Ec7hghbYpvNn0r/gSE1z46951U0fd6Bd
         +7dA==
X-Gm-Message-State: AOAM531o7DEk/B7k1MASnsTrB5O58PAYQtv7WQNhxY/smsIN1jD+CqhR
        xZ7V/RsUpHMWB/zcQEJVaDU=
X-Google-Smtp-Source: ABdhPJzHhSgEnNlc69E9Z7Tfy3nTedvFPS05swID/wqc4IRETGcRigFh2BUGlaUy0LCA0mCqbdVKDA==
X-Received: by 2002:a05:6830:201a:b0:5e6:8de6:9922 with SMTP id e26-20020a056830201a00b005e68de69922mr2543389otp.3.1649233885645;
        Wed, 06 Apr 2022 01:31:25 -0700 (PDT)
Received: from bertie ([172.58.102.145])
        by smtp.gmail.com with ESMTPSA id u22-20020a4ae696000000b0032158ab4ce9sm5877502oot.26.2022.04.06.01.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 01:31:25 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rebecca Mckeever <remckee0@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 3/4] staging: r8188eu: correct misspelling in comment 'tppe' -> 'type'
Date:   Wed,  6 Apr 2022 03:30:59 -0500
Message-Id: <edaab7d38893e4f1cbb3c281b617c74fa91f0fe7.1649233201.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1649233201.git.remckee0@gmail.com>
References: <cover.1649233201.git.remckee0@gmail.com>
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

Correct spelling typo.

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index cd20811ae152..f4a277e6b654 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -1162,7 +1162,7 @@ u8 p2p_protocol_wk_cmd(struct adapter *padapter, int intCmdType)
 	}
 
 	pdrvextra_cmd_parm->ec_id = P2P_PROTO_WK_CID;
-	pdrvextra_cmd_parm->type_size = intCmdType;	/*	As the command tppe. */
+	pdrvextra_cmd_parm->type_size = intCmdType;	/*	As the command type. */
 	pdrvextra_cmd_parm->pbuf = NULL;		/*	Must be NULL here */
 
 	init_h2fwcmd_w_parm_no_rsp(ph2c, pdrvextra_cmd_parm, GEN_CMD_CODE(_Set_Drv_Extra));
-- 
2.32.0

