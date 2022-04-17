Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AFD5046F5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 09:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbiDQHft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 03:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbiDQHfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 03:35:47 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FAA1A055
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 00:33:11 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id g19so6216647lfv.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 00:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=2mFfvhV8B5IdF4RB4U1HjfvBu8xUEg0C0d2xtLCo9T0=;
        b=eTXWKuTHsTpqjyUXM6kCdGJYGEyKlqBkeU4/IxD/R3gJ/Rm8icJimIr2rFxsrJbGRc
         GFBRct+fTQxyDUNBzB+JVavIesfvUjzQ0Nj1SDGxwSaBwAryXtiqpJX8yG/XgGSQC/wa
         HT2Ue5Me9sRfpuOBp3EoAtOHy6y+7v1T7xcNV4Ss+4r2Wo6lOKm/ARndC2fB60gh/nd6
         QyHnmJ1peF6Q4GnXqNvGedDRB+iKA7xVsPabnLB1saCLr/vvqXv08dv40Iz44IUPTkc8
         w4+35qV0ER73HdPxw3rdXtyBsHtqiVSlk8ljwVQe06jG5ajV+OQ9lwtMn5Amm+4wtBi1
         pDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=2mFfvhV8B5IdF4RB4U1HjfvBu8xUEg0C0d2xtLCo9T0=;
        b=ClA6NKfoOPrZnhF50gWknnvrNagbShBX1kZgWi6gUhFm6SPL8wH3o6PsDsvV1Xzm+o
         81wFz4IrFgjxJMlv/gf4gSTOLBpHn4dUNXKVb7gTJUbvpg+yq6tCO+myCTFsWSRdLi00
         GI629vAwrbYpiaDmMpx0EA8jNHCIAOFrCUaHSi2UHisaWar4pD0l6oJGPU7E+rEB6y2j
         e3JAkuZvhYfje9ljRT3TRyGDP0u3fUTwAblOD4YfxJNbL5dvMtr71A/+rZBd0JPqoEPb
         a1VWp8d8QLo2hlwRcTEtmtELKzlA7EYo1EZB4AJIgBbvetPjCMq0/dl9f5fKvsF9JNbO
         fGbA==
X-Gm-Message-State: AOAM532ob7ypKOSmoeuRV4pZQos8hIjnuUgtAmQZlbpMxgfxELCvChVM
        Yhq0ll2sAr7Tt+0YdV60b96e8tDtjK8VDABzGIg=
X-Google-Smtp-Source: ABdhPJxprDYx3bPAIaIGLkbZLTo+Z+qEhAO9TeXZqC6zieCsiZjy/6h6QDugqycWyGrV9wEJNuRvUvchGwE8uPDiByw=
X-Received: by 2002:a05:6512:4006:b0:44a:7434:9829 with SMTP id
 br6-20020a056512400600b0044a74349829mr4429714lfb.661.1650180790329; Sun, 17
 Apr 2022 00:33:10 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sgtkaylama@gmail.com
Sender: sgtkaylamanthey32@gmail.com
Received: by 2002:a05:6520:4281:b0:18f:1b94:87b8 with HTTP; Sun, 17 Apr 2022
 00:33:09 -0700 (PDT)
From:   sgtkaylama <sgtkaylama@gmail.com>
Date:   Sun, 17 Apr 2022 07:33:09 +0000
X-Google-Sender-Auth: FYNtHz7alSvywAyzfA5hVPPc5a0
Message-ID: <CALsSCytuJb9-eue0=RKjqXTcOrx5r0QVFc6GkL52iWoq7XFbKA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cze=C5=9B=C4=87, dosta=C5=82e=C5=9B moje dwie wiadomo=C5=9Bci? prosz=C4=99 =
sprawd=C5=BA i odpowiedz mi
