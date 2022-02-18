Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B38E4BBA94
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 15:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236021AbiBRO05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 09:26:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbiBRO0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 09:26:55 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2EEA2;
        Fri, 18 Feb 2022 06:26:38 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id v4so8741409pjh.2;
        Fri, 18 Feb 2022 06:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Tl1qAGSp1vbK3qa2hW0s4M5fyrIzlh1pOe1T73qOAJU=;
        b=NrrLS9xLNyIf02IMsCAtqfVs21Qp5t8h4q/x8nkYwSieduxrUw5+BeIfm4Uwar+jcW
         dM4dxLeCtQsrnRPocGf3CxPLuJvU5bKrbqBChJDeceDDvKjV4eS2sSAvY5FmVlwIUqNm
         lQzSLOyVmj362cmgXQR05y6GiDK7RGEjgTi23OpghAqCinSGPVgmfxDKWG6oRt+APycn
         lCIeq/g3u/lrsJoeC73vXXTBRO2CnjhbEJu8RFApvSs9zISHxXMQh/a67He6AJ00+0Dh
         lFUZnchcVOFtO8J22MIXNnqoiTVl/nbwntLe8unI6ZEWjVuW2SShAkOrINjEk0p/pM+R
         Ur5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Tl1qAGSp1vbK3qa2hW0s4M5fyrIzlh1pOe1T73qOAJU=;
        b=TjHJjPf3lRVNL1/jYRLOd+fVYl9E1oG3HyLYgmdk5LvDYFLuyalWBYH3ZoFAlv8oGY
         ZaPQbD3Yamhs1/tJdRQCHRqiEXvDIDSX/cGeJA3/S5TEa+CHGdwnQ0dlRVJnygsINIH4
         3JZ4qwao3IoD5e0dzJEheqocg7QkCLB++pbeHaNfGW5ybPdn+fBUjfThRaaVok4jmU7S
         YgofXUHPQP7S4662WszJwOmcexHVow5/5UzfcaoNZHrSaBYrJzG6mE0Of05t4UeScRUn
         awWuw0YwpJcUQeLwBtPNfwZx11L1meFBOmRfxnUjsh9gO8KWMBpIBwwLro85EZs53Kn/
         a6ew==
X-Gm-Message-State: AOAM5317OUBWVYtiPyVc3qe1iyN769AcHRDV7PRSyRkwrxqazCpM25QP
        Fi1ey8UJGxrXEeoHuw+ydfY=
X-Google-Smtp-Source: ABdhPJx/R4JNDN3idZ4sf8zooEzhxC/z1ndVSQDsJY2yXemagSaEnaVTBCFkVfZw802ARmO4HEkIgw==
X-Received: by 2002:a17:90a:d786:b0:1b8:bd2a:d804 with SMTP id z6-20020a17090ad78600b001b8bd2ad804mr8651674pju.245.1645194398416;
        Fri, 18 Feb 2022 06:26:38 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id j10sm3512553pfu.93.2022.02.18.06.26.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 06:26:38 -0800 (PST)
Message-ID: <dfefa601-c58d-c86c-953f-5e4454db9409@gmail.com>
Date:   Fri, 18 Feb 2022 23:26:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: [PATCH 3/3] Reword note on missing CJK fonts
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <aaa9dca1-27c0-c414-77f3-c5587db0cc5b@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <aaa9dca1-27c0-c414-77f3-c5587db0cc5b@gmail.com>
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

Use past tense as the fonts can be installed after the fact.
Add suggestion to install "Noto Sans CJK" and "Noto Serif CJK"
font families. ("Noto Serif CJK" is optional.)

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
---
This note won't be seen by many, but feedback from a native
speaker would be much appreciated.

To see this note, you need a system without the "Noto Sans CJK"
font.  (Not expecting you'd actually do it.)

    Thanks, Akira
--
 Documentation/sphinx/kerneldoc-preamble.sty | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/sphinx/kerneldoc-preamble.sty b/Documentation/sphinx/kerneldoc-preamble.sty
index 5e59900e994d..9d0204dc38be 100644
--- a/Documentation/sphinx/kerneldoc-preamble.sty
+++ b/Documentation/sphinx/kerneldoc-preamble.sty
@@ -205,9 +205,16 @@
     %% CJK chapters can be ignored.
     \newcommand{\kerneldocBeginSC}[1]{%
 	%% Put a note on missing CJK fonts in place of zh_CN translation.
-	\begin{sphinxadmonition}{note}{Note:}
-	    ``Noto Sans CJK'' fonts are not found while building this PDF\@.
-	    Translations of zh\_CN, zh\_TW, ko\_KR, and ja\_JP are skipped.
+	\begin{sphinxadmonition}{note}{Note on missing fonts:}
+	    Translations of Simplified Chinese (zh\_CN), Traditional Chinese
+	    (zh\_TW), Korean (ko\_KR), and Japanese (ja\_JP) were skipped
+	    due to the lack of suitable font families.
+
+	    If you want them, please install ``Noto Sans CJK'' font families
+	    by following instructions from
+	    \sphinxcode{./scripts/sphinx-pre-install}.
+	    Having optional ``Noto Serif CJK'' font families will improve
+	    the looks of those translations.
 	\end{sphinxadmonition}}
     \newcommand{\kerneldocEndSC}{}
     \newcommand{\kerneldocBeginTC}[1]{}
-- 
2.17.1


