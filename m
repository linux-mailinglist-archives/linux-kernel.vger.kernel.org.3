Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF0A51343B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 14:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346688AbiD1Mzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 08:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234288AbiD1Mzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 08:55:43 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E755FAFAD7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 05:52:28 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id e12so8785722ybc.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 05:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=AFlo+Q2OzdsQ4WZf8wvTJwPv5n4sQF9KWqid1ZdyAHg=;
        b=qP9h1q4t2Ah63q03rptapD2f/XCygwBWMtuQDP3wHy2mk1c+9GVOVZ6x1F1iEAGTED
         854fQVuqQuVbUgYgI1pEEOdhAn0GhA1v/EtQaHUw+bHslzFwReFG7EkGzLzQcWwvnlr7
         9/bFbIq/yY4rAe4ek4QrZqWUFc3+6nsIYJnajUZqZslYdU/A1iWYPFAp4pGTOjp1yegk
         FVMXYpJUSvyNbEyqf17Zj/shAS6JAnqG6qk1rL8pdzmI5KGPTaF4w5y7HGSJ7vChawlc
         czAKUUPtPhx3xtyuoETgb1uW8D10xPgGbpxNcxTKzV3o6Gpt15g3QI91rqD3jL60HCUo
         YEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=AFlo+Q2OzdsQ4WZf8wvTJwPv5n4sQF9KWqid1ZdyAHg=;
        b=ICA/+KJq8IGNzCe2t+4rgHhHwAYafyrt4lRTZVBYckWI7YZkY+SYRAfiSUvIXmJsl+
         OVjeBqW/zuwqZWXzp6FpXILAxfB1OoDhyQDCu2Zl3r3SqIGz2EuCTR9Xm/EUlYPG6ugp
         RUwPkmwOAypJXMZSTyMpmb79mb/bwUUZ0r+KaJc0x1ENI+0IU/zIv6CnyGq77cwdq0lz
         JewYXJ2P3yCo4KpY5S4VPyRt2RLj9xa4d9WH46oMEEVb1olMb+Ksfc9t1H5lbGmzzQ5n
         1gVbLj1dr49tvMNHDi14LX/N9S/5eugZCMY6VCIvU9r7mKcluuPfLSH7MSWDwBGJfHfY
         nRLQ==
X-Gm-Message-State: AOAM5317K4t7GHdmkIIfa/cwxrzxlSB4Jq8V/GssICLPt6jSpJE0laN6
        Mo0E3wvpwwh6kBLuV7S6+QTQ0uwS7F2CePtcKD4=
X-Google-Smtp-Source: ABdhPJzTIyWbEQQc4nTosdoGhxqLRttzcRbKHonop9KRyAwXtCXwCOPTvsBp+z93L2cNksiL7pCh88jgYRkJRJkF4mg=
X-Received: by 2002:a25:a344:0:b0:641:d32e:f3d4 with SMTP id
 d62-20020a25a344000000b00641d32ef3d4mr29119835ybi.130.1651150348108; Thu, 28
 Apr 2022 05:52:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:7e19:b0:247:c7c1:140e with HTTP; Thu, 28 Apr 2022
 05:52:27 -0700 (PDT)
From:   M Cheickna Toure <metraoretk2@gmail.com>
Date:   Thu, 28 Apr 2022 12:52:27 +0000
Message-ID: <CAPRwLEhObD0Gsdu7Ak9GD8QJHJ7MtWfSEGeAXbkv28OCP0VpFw@mail.gmail.com>
Subject: Hello, Good morning
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Good morning and how are you?
I have an important and favourable information/proposal which might
interest you to know,
let me hear from you to detail you, it's important
Sincerely,
M.Cheickna
mecheicknatoure@consultant.com
