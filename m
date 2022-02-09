Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9964AF6E3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237286AbiBIQhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237225AbiBIQho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:37:44 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C2DC05CB97
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:37:46 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id y8so2485080pfa.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 08:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0vet+O2rGnFiskNlqhwxrF6FgDwyWi3qflGBq8sFXSg=;
        b=hYDsgSlSr/myCTMTPauwPSbIqJwq91i4Ad99E3j9EWZn3uYbMsG56XsgsM14Wud4uH
         9zXaI3AcGWOD5ap1n+xEwT7NFMlZEc9PhekO7isSG8nSZ2VpAVxBH3Odxk1VXCL+jhAo
         jr6/NkJPB2oKeOSdxOIVCOS/WGbQPfM2wTrC3R9EyzKO4zI3dpiQkMgAMiydQ3uvCp3M
         cxknrEYKq3i5DkEuMmyh6OIS11alEB6gb5WBuB7QqW9Diuy8rgjwIe6utWy6PokcE099
         +9kyqt92fosGAXLTJfqgD9JuZlnaaUbRPWP4bDA9s+4mfxR4XPc2sncnB+/oiwcA8zuZ
         NkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0vet+O2rGnFiskNlqhwxrF6FgDwyWi3qflGBq8sFXSg=;
        b=reJ6Roj8hSC+9IS/WKMKImI4iRWzITZDVrjtmVM+KcfxdGkr/7o/T9QTAw2pnpURGI
         RsNa2DGMGlIxab1jOJSXgPfnG1D+gmi1IDrCyNnJCVtqtTdPOshF2wvZRIab0H6sYhud
         yHbb7l3GWBaVgxdy5b0jHd7N7wn2WlVYNBNNwv73a1IRsrc/BJ+dqEhl1oOhKOPiNSpV
         VbPJdRWdyH01r70AZrvvhzizjCpl1G7TrZKQGq9sRjPmzkWinSbuwOmV/QFzrXTgdxR2
         UB+K7xFbXw+zpj/NDjkAPqlTAzEQN5Z5NVKtlLZY2NLxfzPyqKqLdpvmur1THAZWRcI1
         Pn2w==
X-Gm-Message-State: AOAM532NgRsJbaTogRmEYX6n1Gd4rO8UgDi+LprYuU6Jwq0LZAJoZw3I
        ygw9ypuuOczPJDb5vMn7DyA=
X-Google-Smtp-Source: ABdhPJz5ggxrou03TQF9NHVmn3tHgYV7ulu5h9yCm4AAab1Xu91lUCMmo+8gDrIF20eqGqk07uVBzw==
X-Received: by 2002:aa7:9576:: with SMTP id x22mr3229262pfq.56.1644424665939;
        Wed, 09 Feb 2022 08:37:45 -0800 (PST)
Received: from localhost.localdomain ([122.164.186.156])
        by smtp.googlemail.com with ESMTPSA id kb18sm7840199pjb.30.2022.02.09.08.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 08:37:45 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Abdun Nihaal <abdun.nihaal@gmail.com>
Subject: [PATCH 6/9] staging: r8188eu: remove unused argument in __nat25_has_expired
Date:   Wed,  9 Feb 2022 22:06:04 +0530
Message-Id: <eceb38329e108c1e440eb973492a5a1c17bd7927.1644422181.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644422181.git.abdun.nihaal@gmail.com>
References: <cover.1644422181.git.abdun.nihaal@gmail.com>
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

The argument priv is not used in function __nat25_has_expired. Remove it.

Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_br_ext.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index 088145118b41..5c40babcd45c 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -105,8 +105,7 @@ static int skb_pull_and_merge(struct sk_buff *skb, unsigned char *src, int len)
 	return 0;
 }
 
-static int  __nat25_has_expired(struct adapter *priv,
-				struct nat25_network_db_entry *fdb)
+static int  __nat25_has_expired(struct nat25_network_db_entry *fdb)
 {
 	if (time_before_eq(fdb->ageing_timer, jiffies - NAT25_AGEING_TIME * HZ))
 		return 1;
@@ -363,7 +362,7 @@ void nat25_db_expire(struct adapter *priv)
 			struct nat25_network_db_entry *g;
 			g = f->next_hash;
 
-			if (__nat25_has_expired(priv, f)) {
+			if (__nat25_has_expired(f)) {
 				if (atomic_dec_and_test(&f->use_count)) {
 					if (priv->scdb_entry == f) {
 						memset(priv->scdb_mac, 0, ETH_ALEN);
-- 
2.34.1

