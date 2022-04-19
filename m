Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE41507925
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356580AbiDSSa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357380AbiDSS2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:28:04 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7443B58
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:19:56 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id x20so13766968qvl.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tyQuLgB/CsR0aLvsOUcIg9iM46ZFr1ZTjXluFgbi8lw=;
        b=B20wYfz4Hb1BxrL/fu4aESxQ/t/xR+m+o443keOeSDnjV4EYZheiiNJhYlrKqhzE/w
         MvOWfD9K/i6kV7XDjTOT+BDRT9FTmdkB8a/fiYAky8GYsMX7BOMr4NAYJSyNV3EDwPg/
         fveSD6KO/2zu7LGV4GZ6+5fNYMb/co3/HUn4xN7ng8vai1aNRx24VJcwcYzrkfzheG30
         1/dq9xMW3haQNinqSuGFm3+RlkSckt6Cgbk9rPUssKpnzgP73OEcFggPpQ7vo/OmYATc
         lXjgc284WdMf72s9QxrY/OQvy1L3DAskNf/2YEgLsQuA7QFapsbjkbBmBXPYCZdJ9cts
         2kag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tyQuLgB/CsR0aLvsOUcIg9iM46ZFr1ZTjXluFgbi8lw=;
        b=pzDqA0TpyfM2PgiaI0I3H4YJlfRo++qT4SBNFrLV0iYdT7dSEKGHYEUonExfKylhXm
         G1gKesXs51e4+XPRkLXyU1F+TLKZlIHf7WgTrI6sUgOyewWD5vRi6IiVa6QDp+VMWMO3
         +3ToaBoYWWjr20AIZtoK1qahlL+FY+dULxOI7DuIH7HpxTK9liES3kB18kC/ekdcH3kf
         Y8Spm5Mt6zpcjNeA0kdgq8IyelRfqrRImTFSbvQo0jSSXXLnqFfPEEiga3xeY9VV5+ik
         w+pyYahS2Oxh5/JQjnYnScca0pamr945Xfr2SKK498fmAHtzksfJ+NtVrIOmGnwuQiG3
         XJRg==
X-Gm-Message-State: AOAM533WSHgauD/zwfdTUB9lEh8ZhR/9Jd2njj0qdAuANQT8rtRj/z3s
        GVGHgXqMistqn7x5Djb9lVc=
X-Google-Smtp-Source: ABdhPJxGveIMiH2/+BpxOK75542t0CmkWxPvzYE3z6vxlXQaMUeiB4aOiBvi3H8WlyWRA3nMyPSdMA==
X-Received: by 2002:a05:6214:29eb:b0:446:5742:1748 with SMTP id jv11-20020a05621429eb00b0044657421748mr8864930qvb.24.1650392396067;
        Tue, 19 Apr 2022 11:19:56 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme.wework.com ([4.34.18.218])
        by smtp.gmail.com with ESMTPSA id e126-20020a376984000000b0069c86b28524sm373334qkc.19.2022.04.19.11.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 11:19:55 -0700 (PDT)
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, jhpark1013@gmail.com,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH v3 7/7] staging: r8188eu: remove unused else condition
Date:   Tue, 19 Apr 2022 14:19:38 -0400
Message-Id: <abbd003237836f098b4360e8208bc463cd758aff.1650392020.git.jhpark1013@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1650392020.git.jhpark1013@gmail.com>
References: <cover.1650392020.git.jhpark1013@gmail.com>
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

s_ret cannot return '2' so this else condition is unused. Remove this
unnecessary else statement.

Suggested-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 5ada336ac723..e60e1903950f 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -705,9 +705,6 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 			s_ret = rtw_select_and_join_from_scanned_queue(pmlmepriv);
 			if (s_ret == _SUCCESS) {
 				_set_timer(&pmlmepriv->assoc_timer, MAX_JOIN_TIMEOUT);
-			} else if (s_ret == 2) { /* there is no need to wait for join */
-				_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
-				rtw_indicate_connect(adapter);
 			} else {
 				if (rtw_to_roaming(adapter) != 0) {
 					if (--pmlmepriv->to_roaming == 0 ||
-- 
2.25.1

