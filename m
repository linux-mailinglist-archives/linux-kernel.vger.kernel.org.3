Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFBF53A5AC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 15:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353119AbiFANKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 09:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236589AbiFANKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 09:10:42 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7796325
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 06:10:40 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id v22so2821071ybd.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 06:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=RZq7zJW68AsB2c8MQdTOdMV2RE0j/waEnaPxwlHywbM=;
        b=S5N+aNmBEdBGrzNGLFwPofhO6cTzGAO1YIrXr2uEhjAVeggA/vcwxRNUpIiXPlpym1
         gq8bf8mORMx9dj3AKadS1mcmI3yYKL3dfbDCLniw7NIum28+rOY4dGPAKpt25o0acF90
         76mVwal/MFpuswdY5k9gstc6JridoylMEPjIwSUIovJAAeFsdMHOp82h4IMjct6Y6OvK
         LwRxAgNFXHZ1u09tdKXWFlWBBwX8z4wX4tKF1TfdojyN+KN56JYg1CJXGcBw6K2NyOhU
         2u48woXfHcODxx2sgSlbJQmAusNMlf/W8WkaF118XP/x9Y7yiZJuHZw3tCfVAJ3/8SlM
         Jffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=RZq7zJW68AsB2c8MQdTOdMV2RE0j/waEnaPxwlHywbM=;
        b=2unO2m8zqsE1e4zwh0s2Of+fy7FZxKeAHdLYMM0ZdpSf3YK5xpU/DquHlMtXEZWkXS
         Nu+bTH1iE2Ewfp7SgkTsEXsfa1HEqAMz1X7/tqVGfJ3iuEFuOfw7eokFcvt9shUJdPr8
         H9bSAykMFkfbKjUioj8ZN4WQTaM070/Pk2qUH3CEGWTmBx61YD5Z4mBvG17ajN1qEsJj
         9IHzFQIaiE1NtNM2fpa9pFzZIhrmpeC6GxyusY5o3S9nhMrvCZ0HO8P36Ugl+HeMOGtH
         2c4WztqOZ4Wyzuqueoicoza8Uj52aEpID/IKC3HypxeDT7/cj4s70hInQvyxHHW+HakE
         rmLg==
X-Gm-Message-State: AOAM533tuTzRY5N9Bz7N4caeY6D5Cm4gw2LW2zklTJ9Ifr+SVv+zMark
        2CH9piD5t6rZ9qNwjW5zJ0tk06VF28QCABUbMjE=
X-Google-Smtp-Source: ABdhPJxJFkXZIbZ5/v1IVkM8gLozWkzwZwIXSgLl6Yz50Jxw194DeHV0bnuOvHVF3b3uFiqTrEciYIgTwsxdWmEdowU=
X-Received: by 2002:a25:1dd7:0:b0:65d:4a5a:86dd with SMTP id
 d206-20020a251dd7000000b0065d4a5a86ddmr7965556ybd.602.1654089039485; Wed, 01
 Jun 2022 06:10:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:178c:b0:2b2:8275:30ba with HTTP; Wed, 1 Jun 2022
 06:10:39 -0700 (PDT)
Reply-To: sgtkaylam28@gmail.com
From:   sgt kayla manthey <assanaigbo@gmail.com>
Date:   Wed, 1 Jun 2022 07:10:39 -0600
Message-ID: <CACMOR7MerNtc93W_hQBw91G4GJCh_Xs=izwJsA3ZaJ=4g2pxQA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Greetings,
Please did you receive my previous message? write me back
