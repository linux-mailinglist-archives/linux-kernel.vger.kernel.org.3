Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5A459B97C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 08:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbiHVGbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 02:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiHVGbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:31:40 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC78327FDA
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 23:31:36 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id d5so5035708wms.5
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 23:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=o31t8HDG7QptfeLJ+04Jkz8j9NFHlDWTE2XxPfy4mY4=;
        b=nXdTjGlnhudFxIULXG/Imuer1FBF5QttsVJUNuE8RTXM5C/6Hh8iEeWMnwLFcxHn2s
         /pOYmLChPtPBoD1ZA0KVijHczoiAa/ZLO50Riwv8id5Fh345+RYFItUzc8o2vUEaarTr
         h7uTl5MiB0DofRC5lZKGuqHlYxMYXm/Ferz8C1PMyFX6JfAqmngLjHNoh/WLFbM8KH1R
         xuRNZOnuPed9Yvoqn4FBmW2vr0K88VPsw3pYVhetmKVXbwHIZlstWb5J7cnrDQ+3wdoW
         wrA3fMAc3pibXlYcIMnzKGaROrb734u/84lK30J0WNaTrGyDV3o19oomLmdUgdWrTiDE
         O8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=o31t8HDG7QptfeLJ+04Jkz8j9NFHlDWTE2XxPfy4mY4=;
        b=w5DYTve+7Xz6Uktnh3pMNNpn0ZtBbfiuKb6MpxMQp9qJKqrPVIx/ET2ioI9zJSXmsP
         8yAY126/yrGIkBg21YP8G8/DSCeDp3Gcu9O8tDp09qye+8Pip6kN8Js80X2jJ0d2T8+z
         IrlAkCAbeA1d4BiFLEW1FUgjU4ig4dcny8XF0pxhy6g56yvazhFejxsy60JiEMuBRo9j
         s+LtSAk3tSq4gEWKVGh7D47yrMEioyDV/gaqzsRMk2LNe6qUf6ucwdmEEUZN+o4D3wyk
         6c5k5XldcWc37XbU7Myb/PP1EJQ79HpXHRohgXQE2i4WtKm3MxX25bRXkM8UVLBcrwy6
         jukg==
X-Gm-Message-State: ACgBeo1U3WAjEe+c8mze8C+JXiBIieRJZKYmD2sPnF+RXD9pw0xhA47A
        uYxvHHbC7MBCAadBlpCP6oD4VCXp3WKhMjySVMg=
X-Google-Smtp-Source: AA6agR7VytG5uU4ICP9ConS9lCx8i2GG3ET1WYDCO6z8zpe1XC2sLQs36WnIzlr6IWonrnLZ7Ke8T7KwJYbsfqdM+aw=
X-Received: by 2002:a05:600c:35cc:b0:3a6:f08:9b1 with SMTP id
 r12-20020a05600c35cc00b003a60f0809b1mr10836713wmq.22.1661149894636; Sun, 21
 Aug 2022 23:31:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:5444:0:0:0:0:0 with HTTP; Sun, 21 Aug 2022 23:31:33
 -0700 (PDT)
Reply-To: maddahabdwabbo@gmail.com
From:   Abd-jaafari Maddah <sheishenalyeshmanbetovichu@gmail.com>
Date:   Sun, 21 Aug 2022 23:31:33 -0700
Message-ID: <CALX-7+21dS29D3_6jHpnGsmqcyRhFFSw5xbbmAihrA8D-vCsaQ@mail.gmail.com>
Subject: Why No Response Yet?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Dear,
I had sent you a mail but i don't think you received it that's why am writing
you again,it's important we discuss.
Am waiting,
Abd-Jafaari Maddah
