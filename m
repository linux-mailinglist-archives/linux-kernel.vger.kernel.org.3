Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFD1565A9E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbiGDQHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbiGDQH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:07:28 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27380E0E9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 09:07:28 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id az35so4673366vkb.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 09:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=yHYbw2bx/nsQBLFF3gJlg+vRlUz37DtKoW4ftjnCRHI=;
        b=DEZo8/qcKzam91ZhCuWt6ztGIINzNjHdlp+khdJFALO6rlTKiljr2hObNMqdKLkZ3a
         p/7DHeuuHLx9+vzBHrRy8f23RIv67f4axyZlqfllUib4BFzM0O6dwv5iwTyYc8OHO1LV
         b4GHwcPbXi0x8e7w2KD2s7wYU3TInedu1Gis8QXNEVyLtRK8clXRRBGc47RYdpKtY1nV
         iIe4O5GvkzNY2EZvkB73PZ+M4We/fyd7MagloNgXWuROQqHmXEycpCFl/Da8nlXKtoc2
         s7ar4S2M9S4JAEfqQiiBIqw/5plUaKbwsJI5ejj+JjwooKV/BNOi/UZArPwWiKnDRKHx
         vcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=yHYbw2bx/nsQBLFF3gJlg+vRlUz37DtKoW4ftjnCRHI=;
        b=t6thzu8BdhbrW1wvQ11y0CX1PyWiEil901mxyeSZbgzvKpb/Iu06F0JAmrvZSM/96N
         t2zsc/awwuXETidVhDtjOGMYTtpH6KXYFDW4MRbu99bbAVxc1Qf5xvO7I8HyfeiIcHo4
         GZvZZPGys2G/dD1Lxhq51kbZvlUlzlzgZT2AGnD3zab/dwidRMoF0yVySOMcbkhNTEWv
         7cwyX9IGl7IKXt8+mp6kkMYEbatJ3wk+Vy9S0gt0aOlmV6xuj8xk1iAcqCxjOh2LDFnI
         B4iOSUQwnvJevn0ZoH8Y/niHeYMBOM+ck1hWY2p3BE19J4DqIie+23c1/LAVYHad1zs7
         gl6Q==
X-Gm-Message-State: AJIora/EwOoblRIbxP9Sj9BnuwFKUYz4Kq9XiEJG1U+xqy1FeQSIS0YB
        BJz+YhzWYSDSKxxB9qHcwT2kng3gawWYP867Tok=
X-Google-Smtp-Source: AGRyM1vK6VSNy8xxPpx3hC2Qugdb8bHujB/tTB6rAHD0yC1co71MMz932UqhxkvjMUViCDoWGpYjjOaXtKDDKJm3Q/U=
X-Received: by 2002:a1f:91cb:0:b0:36f:f605:ddbe with SMTP id
 t194-20020a1f91cb000000b0036ff605ddbemr18376761vkd.18.1656950846867; Mon, 04
 Jul 2022 09:07:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:907:369:b0:72a:4b5a:6883 with HTTP; Mon, 4 Jul 2022
 09:07:01 -0700 (PDT)
Reply-To: avamedicinemed3@gmail.com
From:   Dr Ava Smith <tracymedicinemed004@gmail.com>
Date:   Mon, 4 Jul 2022 09:07:01 -0700
Message-ID: <CAAqZ+HCszbMGGjT3YSw58jU2TXB+B0Rjt_4gnWDE+OaG5S6X9g@mail.gmail.com>
Subject: From Dr Ava Smith from United States
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear,
how are you today
My name is Dr Ava Smith,Am English and French
I will share pictures and more details about me as soon as i hear from you
Thanks
Ava
