Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B451594E44
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 03:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240269AbiHPBvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 21:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiHPBuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 21:50:24 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D664B2068B7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 14:43:41 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-3321c2a8d4cso52594287b3.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 14:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=h9ZGOtBRPWJ0waHFsj4axYTCXQdVozrtN77u6fLXCPI=;
        b=JR78/aMztcth91yafLml6LDDar2/onRJHyvsdiI4uSYGFdZBvkOCpDL6JHzHZa68uA
         OYImZDa88jx/3v2HHrip1C5rjsppsfbXyn+teD3/uXVjYWTRg5WCHpQm5BVS1wJYn/IK
         jTUzvMjivF+TPEDepQsbpw0FShubPelY5NCZtuOsZRJNmjkpNHJiuRfcVKfZcsBJ3Agw
         Sewh4X4VW9BL4N3qzxN2qLphhgNHM0kmWqyN0lpkqt1AOnW0Xom1QQFQ2ocJBlMXQF1h
         w1WH7w7T5fzbkecjKNElWvAv2ESKCNf8SNqNuFC9NdAuyavr1KIEj5P3FBwjL16TDQiX
         ujPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=h9ZGOtBRPWJ0waHFsj4axYTCXQdVozrtN77u6fLXCPI=;
        b=VChKL0pH6f9/PQ4f2KFZD032CmJPCcs+OTjaMzk35ghu2qXjw+AnUpEKcJ9NKVJXwD
         l4uC4J4lvwE+L+yyjf/JtOc6dXpIja6g5e2gckII76bLExQFKJax9YcgYjhA7x46iL33
         VE5Dk2hJbfFCR3EnvYfHquuzj+lFYQfctBEbEVjhlFbVeq/RsF+ge7a9Jhu6Md814y25
         rqX1OqLg5d6yM+e4/YPc3iwTb6A75HhSpnG6r1foyRKXDRQsIFbIFi+5gh3/HDC0j258
         9LsX9f6SAVgQhANt1bGuLI+rIUutHjMRrjOCKpnL98QIFoWXfEDvLSBVDiE3hG2kfbPM
         XSCw==
X-Gm-Message-State: ACgBeo0/Bx6QMwzopKjrce1gsF1jRQdzuUpcPhDwiITV4qBHRhD9IfcW
        ooVyVPILa8QwWgPx2PMsuqI2O+aXvJdE/NDC2cA=
X-Google-Smtp-Source: AA6agR69E8DkuieQqA3kn6NUZsBS4BxgDagv3y/c1O/GPJUErsdG0QyKY0Rvq6G9Cjtj2uFvLCHmI6+U0nGHkLhrjsk=
X-Received: by 2002:a0d:d404:0:b0:333:7fcc:95b2 with SMTP id
 w4-20020a0dd404000000b003337fcc95b2mr103356ywd.387.1660599819503; Mon, 15 Aug
 2022 14:43:39 -0700 (PDT)
MIME-Version: 1.0
Sender: www.garbaabdoulnazif@gmail.com
Received: by 2002:a05:7000:804e:0:0:0:0 with HTTP; Mon, 15 Aug 2022 14:43:39
 -0700 (PDT)
From:   "Sgt. Rebecca01" <a45476302@gmail.com>
Date:   Mon, 15 Aug 2022 21:43:39 +0000
X-Google-Sender-Auth: XOwM5foT4VBe3hu7IfMBnxFR61Y
Message-ID: <CACTHTZGQeJVamP7kmytD9sGwG3zabLPHggASBUnVAAgQQ-xfnA@mail.gmail.com>
Subject: Hi,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Did you receive my previous email?
Regards,
Sgt. Rebecca.
