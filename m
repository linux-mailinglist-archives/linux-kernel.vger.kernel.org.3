Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88375648D6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 19:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiGCRbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 13:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiGCRbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 13:31:12 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185EA1149
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 10:31:11 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-31c89111f23so13078227b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 10:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=T4i2po2uElGVo+nqyJx12LBVBz4gj+grHwJPqtV6MtU=;
        b=SNBWWFMHWP5ID7dAebzapHQqZ862JjXjriWW98lPoMZJdqeWxYR+WNZPVqHUE2e4Oi
         BtqrwL4+FQEMdRwt+kVQ0bgoJhHPWJySOsFLCxnjeIdNGFW5ytWkciqN8jBHK59mvhhg
         MMjsBwncemxo8/nZA4laJmAT7j8k3a6MUpObz9y38VI9EyhXZNiu/cqTXaOS51gmgWRY
         BUgOCMA8nUk/ctBmKGy/Blj1oP5JkVzCeyRri1J9zhF7YvpucwZh1zsf7llmEcuggoSS
         xyE8GaYzmmxupiE2fmPQwYeu6tziZ02GwAM4GOJ7rKSyW/twa0ljbG4HzPjw/lG3scgM
         42Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=T4i2po2uElGVo+nqyJx12LBVBz4gj+grHwJPqtV6MtU=;
        b=nDrTJ0eiZSihBP3xcF0oWob0nklICymbx7h/WQU6BPByo0UzGzMF3ZZdIPDba9pNl9
         DcugpjAH6e/HShPs2FDeK2lUmR3cf8kPluO7pn/z6zOtPdreyN4jHEeo52U+q7lQ/OQ2
         KFLSz9G/5rGNUVJiTLqHZgSWxOcHn9M3HbjC99owyKJAgYxjtDHWCDR+vN9C6qfeYyJ/
         UMHQFnbM8YD23555jMzZL4kQECJS9nrlJw/HlymR3pPDja6MpPY93JV2N/8wMJG3PMn+
         fPr5bx5MaFmExXuowdh1YqnSJCnlDNruFeGLxPHIlJttfVk3iDkEM7YqXspAlkUNzmx+
         hIzg==
X-Gm-Message-State: AJIora+pMqFwuRRK3GHXRqr7bbQxwcdj7RPzPfyAKAmGxI+Jc+FA4ztI
        UzIm2YylF6y6HOrSPst17h2FU35mA5DqDXKzMcs=
X-Google-Smtp-Source: AGRyM1sTZvaYiFeLiViC2gmuD/cbnpQINEToFwpelc9cwtc1WaxJVsq36FGlwqik8Ey6+hZVvXL3EkwsM2kp3C8z/1s=
X-Received: by 2002:a81:cc4:0:b0:31c:839c:7e27 with SMTP id
 187-20020a810cc4000000b0031c839c7e27mr7729939ywm.151.1656869470424; Sun, 03
 Jul 2022 10:31:10 -0700 (PDT)
MIME-Version: 1.0
Sender: oliviahamilton706@gmail.com
Received: by 2002:a05:7010:4d98:b0:2df:3b39:789d with HTTP; Sun, 3 Jul 2022
 10:31:10 -0700 (PDT)
From:   Maya Williamson <mayawillmson@gmail.com>
Date:   Sun, 3 Jul 2022 17:31:10 +0000
X-Google-Sender-Auth: m5I3kd7mn_BeSVdPr4Bi5MIULmk
Message-ID: <CA+k-=v+2bW6x9Mak9xuFomhA4bq4=xF96ywyDeKi0k2KtiUA7w@mail.gmail.com>
Subject: re
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello there,
I'd like to talk to you,its important..

Maya
