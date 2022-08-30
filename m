Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63225A67F1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiH3QLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbiH3QLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:11:39 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A42F4908
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:11:38 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 202so11090115pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=nNR7DDEkndFjHp88OH9gG90k00O3/q9+O/QfOiiIZ8g=;
        b=aG7j5rVoVpvnfjWQ/jcBY2jT+vTDyaahEq+G9NvcUiaFOT5qJ7+hvaIY4nNRGgS2IL
         8BYRLh/iGxkyJC5HbIeHVK1ome2tuKsGRlx0UfLL5VIwm/USiNPsl6UAmQUqcc/qWQt5
         WTRwwdE2UITOJkBV68dwSsNbNyzhjg06AJ4xY+OMT7pOnWJ3ETSFCMezCCigcMv0WkvX
         qVVk+fUwhMpdXJXE5usZlbZ42QpL8AixyuJ5idSyfD5Nlc8SVn9cuGyZj3fuCvkHW3Zk
         PJIaflZdSTJFsjr2E10wsPFtPyXz9QpxaAl4Ahl9/y8C4qra3Ux5yWx7lBzZz+eBHWYx
         VjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=nNR7DDEkndFjHp88OH9gG90k00O3/q9+O/QfOiiIZ8g=;
        b=kju2LUJzTldY8OuK+0KXDKbzAI4lryb11kcWyCin5/3jFGcZ3mOCqqMz+CVUZtAITt
         i2B0CM5MOl2hdlAwKE0O6YTpP/yR+FORyMf13m4ZEPFEqEpJAcpyNTW5ZodkuNMp3did
         /wcc6s/l9LQJ+5szrESX2DmUkPFTz96iTSCJoI6Bw1sWZB0YkCJSUWhjHmMu6FyPSztK
         FJCfyc9VwPqpixXtPoYAsrj0uhRxH2xxDslfKVWRm955kalg9XgqQTzXOci0uhho7Vvh
         WRHHM1M9blwuuuwR2reMhhIRa/lHv/79bWGc6ca8GYKHFTF40QAe+7QkOfNMUO8g6WfM
         MS5Q==
X-Gm-Message-State: ACgBeo2+RgsmSdtO+ZdGLCxJHO4x9rpzbpLa3dW/lt0S3o1H6IG4pS5/
        GAqTsuNV15XBigN34EoEGoYMYxqYmYpQyz2KXQY=
X-Google-Smtp-Source: AA6agR7vZLpM9pqr0lvUBWxWmyr64WxGBP2jg7iMWSw7ZI1pqHMRck2bYWxDcueVeKXGfyIbMOR3Z2IWMorWx+MZfVg=
X-Received: by 2002:a05:6a00:9a5:b0:538:73c:bf8f with SMTP id
 u37-20020a056a0009a500b00538073cbf8fmr14574954pfg.9.1661875898204; Tue, 30
 Aug 2022 09:11:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a21:1014:b0:8e:ed13:ea42 with HTTP; Tue, 30 Aug 2022
 09:11:37 -0700 (PDT)
Reply-To: brunoso@currently.com
From:   Annah <woalbou@gmail.com>
Date:   Tue, 30 Aug 2022 16:11:37 +0000
Message-ID: <CADZJH_UDD3X7KTnSDu7i4SF42z+PE5WOZVeUyHY3uiGCHAaAqQ@mail.gmail.com>
Subject: Kindly Assist Me
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sincerely,

Please exercise a little patience and read through my letter. I feel
quite safe dealing with you
I will really like to have a good relationship with you and I have a
special reason why I decided to contact you.

Due to the urgency of my situation, my name is Miss. Annah Kabiru, a
21 years old female I'm from Kenya in East Africa.

My step-mother has threatened to kill me because of money ($10.6
Million Dollars), please reply ( brunoso@currently.com ) and I will
explain all to you.

Your Sincerely
Annah Kabiru
