Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991A95A0242
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 21:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239928AbiHXTrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 15:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbiHXTrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 15:47:22 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6D179ED1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 12:47:21 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id w129so9165202vkg.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 12:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=1WzdQc60kQFcuCijtsbZKgiFqjkRFGJBENyAUnBYwFc=;
        b=E+1aPhSC3SDJsi6mXiWPYeos2d0konbK1h79ttrhzr84uw/TJ4A7uZfy3g9xFFCMQ3
         7oiy+RkEU7pwY3aDh9M3uFK0DYc6AAG/PAqE0ICMUdjrR1TILRRnCUK+bhiyXhRikPzR
         9/Vqqg3o07m0uqOT4qSsgIAj00knsd53br2c2nKxrrlEMIPU+DrTy3Ai/2pkimoZ9o79
         zPQInb/IJOX7Nz0XXUDrYdLwSGX/QTas9dFoh2/TlUjn47BQ94I9+T8kaJ6p9yTGR9UP
         szMrmCVufawRvVlTOWtASq9J2o4LJ+3JdHyL9m15+DsdK78HZBZKs8HGKwP944K65rsr
         Cz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=1WzdQc60kQFcuCijtsbZKgiFqjkRFGJBENyAUnBYwFc=;
        b=LbQ8iCFAnEnIzkB2DjBEP9IZtTsvZflh+QS2jfL8ZyRy7US0EA0m/27cL7QqaXpc5L
         8QkABG4dtQiiq80XTE3LZcUF503EdAn4ZV2q2n5uUhy2NStboVg2DAXFl0LubEo5fhdH
         ynubHKnaW2bx7mh8MLJ40FPVo/9ZHJtxAIYfaQSAMX3XoBhFLngKwhEcpN0A0qwLTTJE
         wB6rVOQH6fwFjISoyqTldhe51H3H+mz6IV15JA8FRrY6GChXGw4WyGzCKIFMj73nTrrC
         R3GNp7OFn71+VXrUTm9711J3NYQtm+HMVfUOExzfhXEevOGW6c/vHuFy3r6yt40Dx3f5
         gArQ==
X-Gm-Message-State: ACgBeo1e2GlA2w9nNuoLSQw4IprePIfxiA867kTIMmecGc/A+uZmnpWD
        bJBpw4JNjkbx5ekbqhDThj1rm9dnaVT6yzljAz0=
X-Google-Smtp-Source: AA6agR7X0XXxZwlxwjdQqPcyl6ft9mIiA54zpEXxBa6SsuoNCz/+4x/tgSyIBFJozfv2FA5aWRJ9+zUwiYmvT4pOW18=
X-Received: by 2002:a1f:ac83:0:b0:388:9d97:b5a9 with SMTP id
 v125-20020a1fac83000000b003889d97b5a9mr226624vke.22.1661370441087; Wed, 24
 Aug 2022 12:47:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:6209:0:0:0:0:0 with HTTP; Wed, 24 Aug 2022 12:47:20
 -0700 (PDT)
Reply-To: ab8111977@gmail.com
From:   Ms Nadage Lassou <kadirifalila@gmail.com>
Date:   Wed, 24 Aug 2022 12:47:20 -0700
Message-ID: <CAB=uj4NnUseD65KxYE_fGrj+X7Pe6JgBfZrkj7MmAprrcBG9rw@mail.gmail.com>
Subject: Waiting to hear from you >>>
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

Greetings.

I am Ms Nadage Lassou, I have a important  business  to discuss with you,
Reply back to my email to have the  full details,Thanks for your time
and  Attention.

Regards.
Ms Nadage Lassou
