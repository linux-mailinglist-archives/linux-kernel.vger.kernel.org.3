Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76740504EAA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 12:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237531AbiDRKMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 06:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236280AbiDRKMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 06:12:02 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2CA12773
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 03:09:23 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2eafabbc80aso134429557b3.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 03:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=WK6OLngTEGMQZnXAmgyK8gksEaTtYBKX+MRhgq0dtFw=;
        b=HJn6S23ZeOO0hGYA1J3PCyZky7QQuc76vBC0WFoC8Hc6+PzsLjaklqi82dSOWFWESf
         XG5zr8TAwJ1tsKeUvWYcFRBP82SNRplDBAc4kQsdT+C4IORtJ0ZKw0HSXXD45R3nSydS
         As5vdE/Pv14cP1MYzAesAikWxOSs4B8lzMt9wZKjngetFx0+4J+MaOAWwM6T5R7riicA
         wGT0ZcP8EhMuoJrYFKWHK66mXVC/iXXR6igV5szyC5soH8cO5SPD5k0jFMvbN6W3IZLV
         FPnjQ6RhBUBPCM0FeUkYBwae5XSTP9y++RFV3zGO0Tpl2jOVC/ckAL7NVG7ztBBUV0EE
         y48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=WK6OLngTEGMQZnXAmgyK8gksEaTtYBKX+MRhgq0dtFw=;
        b=rU8lc+qujwqCdH/DsAK7DYXvxudjaSvse4kKQTjBAYitZggL7+Ws0EEjk6hR5HddWR
         bxsL5ufLXsHmPnpLZk5DNBcXh2b8Jhcz/DO5BofwxApkZLE5kJmMtslDAxwa8HVsIX/h
         fj8mdssjsQEMyPV9aTIEM9wJ/N2qu0H+cVtF9z15RcQuzXEnbcAozJzrlVj/9yIcFC1j
         UD+MxHvpn8VNjLjWnQQdU+bLaXWlEAYp4qGdS46dPe8VBGF6wyroXDmciBajxPvMHNaK
         g5DwvjYJILH9CYkp84sCp7NcM7ciL++xhOMFrKZ4WxA5QSUtUwBZquRPkBkzDycHYpdQ
         Kkfg==
X-Gm-Message-State: AOAM532AuM4AiYQWW7JXDDPM63xKfgauy8/CfwjZ7UZw3cDZLIIfMHMu
        1wNNqIzwzgz0DFAtnCGE1a7mxpeRwdYrO+rij6E=
X-Google-Smtp-Source: ABdhPJzjQHCumufwkjDLA6m/B8wjtsh692iGlIG8jI5CFM67fFHWxTcNmU3JZow55lG9tLx9ggQZYsNQH12MgWPEnCA=
X-Received: by 2002:a0d:e813:0:b0:2ec:1e83:e5f0 with SMTP id
 r19-20020a0de813000000b002ec1e83e5f0mr9789418ywe.151.1650276562993; Mon, 18
 Apr 2022 03:09:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:9608:b0:24c:923e:bb04 with HTTP; Mon, 18 Apr 2022
 03:09:22 -0700 (PDT)
Reply-To: sgtkaylam28@gmail.com
From:   sgtkayla manthey <faustinanagono@gmail.com>
Date:   Mon, 18 Apr 2022 04:09:22 -0600
Message-ID: <CALXzmeKJkUqToupSFpON4ZEC5-EXBvMT7VMdp0fmmW29R56c3g@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_40,DKIM_SIGNED,
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
Please did you receive my previous message? Write me back
