Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE16501760
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 17:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357237AbiDNP3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240267AbiDNOGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 10:06:19 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B242148E4F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:00:45 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id a8so5907165ljq.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=IT3baNs1cYLv1VfMNDHtjFEZoYHbdLniO99+ccrcjHo=;
        b=jtbSOTi+FLZRYM9u6g9elrinEQLE0TzdOu6MDDQbo1a37CGLfxHG4g4WtrFcNRSkQV
         5bNpka6mpDtSZII5ZpzDyzhkR9fWccdt3krWDHRyyWIunEWZ6bcRNv2yH6OJDGDCy7JC
         IkX9BFrGHCvBvfEYAAOtbWsKhss0oIFZfOzwD8baQ3BqhNbfyoVci9u3roxsDwbcCndg
         VmkzCVBQNBXsh3FIqV3nwrrQ529aF+KdKq3hROypJy45OrA4Db8agJjVomRfVNLql2Lv
         wBJMgTI65rOEm5VyTBk6fcSpAmuTMOUh86ZUBxbdB1tq9SW0d2NwowV/7OH+GfrH+Tfr
         5djA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=IT3baNs1cYLv1VfMNDHtjFEZoYHbdLniO99+ccrcjHo=;
        b=10bzFw0nPti0pDxDHKeBi3X8E1fErinnh+bXsmelcQX+RBbGqJ4C9ck56mOwIyihgX
         kmrlTNXTd5SmDVGM9/nY1+XQOMbEvU7pN0GlLtIjQvhm+k4bFjkrB0EP9gbie863a82N
         SHxLy7G4Py4Qg/HcS0i9+21umevoUPFOur3eaSKYhFmmkhYUInCrsQGt8NlUXT7ESQez
         pM0b/PjBBtdBeHmHX68H2fzsPE3/8S8PCyimLknRt8ayH1mu8AdcrjQJIzMXnxbnMXBV
         Fh/tUEvz/RDJ2sB4ILmX4WS1vWiaogFaZO42lZ61/TVMwe9ETfmTaCRIhkQHizFdPE7E
         id5Q==
X-Gm-Message-State: AOAM532oM9+eJy3dfR6dBv5joAXlutToHXID0/Oo6J+0jeK/qS2EQeha
        +plDpyL4uqjAwGnhcS5X8fCq6UlbwMCL+9ZmjvQ=
X-Google-Smtp-Source: ABdhPJxpItqo+37cE4AMSygohF3Nrku8cbRYiWDvjWana+xOUAbxdHv13VEfSPZVj4q7dftvyCQJY02DvdutcMoWvOk=
X-Received: by 2002:a2e:b8c2:0:b0:24b:6b07:fafd with SMTP id
 s2-20020a2eb8c2000000b0024b6b07fafdmr1741268ljp.207.1649944843461; Thu, 14
 Apr 2022 07:00:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6504:144f:0:0:0:0 with HTTP; Thu, 14 Apr 2022 07:00:42
 -0700 (PDT)
From:   rymond chan <graceel047@gmail.com>
Date:   Thu, 14 Apr 2022 07:00:42 -0700
Message-ID: <CAOTqtT5kQwjpy_+YZ5aNjwHACc02F3NHEwhPTztMODNG=4+Mqg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.5 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
a business proposal worth $47.1M USD for you.
