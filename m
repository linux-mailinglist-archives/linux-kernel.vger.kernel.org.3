Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A15B4EE365
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241913AbiCaVn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235449AbiCaVny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:43:54 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3967E23193B
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:42:06 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id pv16so2135555ejb.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DKD1bQMEvuE8Up33LGpgdo8uQklweCtt7yjePFKMDsQ=;
        b=U32eRLu4vnX3/Y3/RNhdQ76Tdc4z8Xs0aUmiEXtAz/HfttzZkQ55hKUx7Ug6JUnZCi
         r88FFbZRnk5/mmd4F9V1QkSqJ3UdqpeVWaoTIA/UfDbC/aGfAE01DL75DKnHun5b5oM/
         tqfpsmvHJmVldYLkGOfoXZiPUww0wZlwrj4F8bpia2fkk5PzvUVttr9l2QRlMk6HUiE6
         TiAbR6fEWTNJD3QhC6trKnVOcn0eBeF00feVt8299uX45fRg5x9Y2ij2puuOD/uAwEkw
         /8AUwfkIr8v2j8Fn2WJ1JZm4BnDzjoZGzMqRYOvPkJTHJhjiQ3c7r12zBja/l+V2Ojx7
         OaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DKD1bQMEvuE8Up33LGpgdo8uQklweCtt7yjePFKMDsQ=;
        b=ayeosuPsCJ/2zBu1qhD8JtkP/0lx1cu/sDp+Ki4WO7bWB330WW8xD0HwMttJMMnfw7
         4iZw1a8HzBl/XQfm3gWMlgkOSMUIXFfA7ZBz5xhM0ZmQjwCAdRQt/UuFAdnHaKG75lXE
         D+k5zna2tA7VVNoQhADid38bQDrYJrqrzc5nOEnkG9GG2Cm2Q4J+SqF3c7Lv8Zbx1OzX
         h39Pgeccc1U95gKAwZLnWtnMLAuAmJRPXducT7GTcvCI78Dcmtq3IF9XD40UZ3EgLKiV
         fu8H4vhzoiKoNt4miuSJUFSOMuC7Xb3zp8rmERV30q9J0T84nAp2723SDhp4oQxpIc65
         YlyQ==
X-Gm-Message-State: AOAM530ItcBXLogcU1hqesqP1zcl8MYDw4o+7pgdNcA9uBACbaPPL28e
        RDfaRWUgsR2/A8SEIxKiqko=
X-Google-Smtp-Source: ABdhPJxCE3Li5Ud8OlSvbT5DbLd0bufUXAEx9CtdlnI92CUbZ0itj3evNCa6LpvTaB7gCetu/Y068w==
X-Received: by 2002:a17:907:7f0c:b0:6e1:42ee:3e71 with SMTP id qf12-20020a1709077f0c00b006e142ee3e71mr6841207ejc.127.1648762924781;
        Thu, 31 Mar 2022 14:42:04 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id dn4-20020a17090794c400b006dbec4f4acbsm244387ejc.6.2022.03.31.14.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 14:42:04 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/2] staging: rtl8723bs: remove some 5 GHz code
Date:   Thu, 31 Mar 2022 23:41:44 +0200
Message-Id: <20220331214146.15161-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This two patches remove 5 GHz channels from the ch_freq_map array in
rtw_rf.c and simplify the rtw_ch2freq() function.

Michael Straube (2):
  staging: rtl8723bs: remove 5 GHz channels from ch_freq_map
  staging: rtl8723bs: refactor rtw_ch2freq()

 drivers/staging/rtl8723bs/core/rtw_rf.c | 56 ++++++++-----------------
 1 file changed, 18 insertions(+), 38 deletions(-)

-- 
2.35.1

