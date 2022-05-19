Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BD652CB86
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 07:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbiESFjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 01:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbiESFjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 01:39:02 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A95313D33;
        Wed, 18 May 2022 22:39:01 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id n13so5880167ejv.1;
        Wed, 18 May 2022 22:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P9rIEKsSILY2Q59oY5ioABEPgKHA8CZ903o6eHfSe5c=;
        b=pQyCywemE0ZVZ/u0pYa2M2UxCCJs0mAjSDgBv20LeVfgYJR9cyDwaq0fpQDC5nXV0B
         LLtRB6IwrBAC8CTWIPvKRU5uIc4zfbmNOLCWb07Esc49VNTH1wwnQ1MJJr03H0Ek/l08
         lG7ATX3AQnqODimEkBldoQx+doTm3lpFCr0MSrVY5U3DmmlGTFxEZcUmJpFzpqZ1DUD4
         YasMpwUQYcZK6IdgVRmkpLMh8KowIeVKxeRGk3OOUdPbBsuPew34aPj0FoKu9b4Iqq37
         mvETCditHYNU9LGIfmoec00LUbh8Oab5Md2OogTXr5eQ11DtFWMVZFHYxnVrlshBsMdk
         0WjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P9rIEKsSILY2Q59oY5ioABEPgKHA8CZ903o6eHfSe5c=;
        b=jCoUp+dpkTvd6t7oNmC7VYJM6IxaW6mPnAi6AhdX96M62BuZO2H9nn0PzbDuMHRWSB
         BpuJMQ1HSk45uxekXs6xtxMqP1r8NXrUg19RcnYZcKbDvGu/zvdV6RHrKe1XzJBSViaW
         jm/5ttwWA1EHbE5IF3x1MSTNn1RJUBhpftP7CvWfONgvrq2a5NxqNa6Fy0HalkUUFhY3
         lKWHsjUwb1nYpvEzVfPRnFXgZbCmEwPHLEy+Px8DdS7Mf31Is/z0goa1bngFfyhmtwuq
         rrLTfJbtZH6LVqO2LFv8wrxoZcJaiG2xIeetndfToixrRSHDPr4KkJ9ttIbEF5cO0HSg
         n8+Q==
X-Gm-Message-State: AOAM530tFpMINkOVZhXdqaOnRnCmlbB+H5pa9/dE5iHJET2JspDvI3SL
        5xZlP/Jy0kaj7MvlhrncEL/H0ZUlFZlZXZfKqFs=
X-Google-Smtp-Source: ABdhPJzQCjfijG3DwS8WZQOnjr+xn/kqkfB6v5casriPimAqTQoX7x/u4Oe9NXyu/RWHKRxbCQ040+B4SlB02C+KBUg=
X-Received: by 2002:a17:906:6a1b:b0:6f4:a9b8:e027 with SMTP id
 qw27-20020a1709066a1b00b006f4a9b8e027mr2689709ejc.222.1652938739964; Wed, 18
 May 2022 22:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220513033450.7038-1-kflin@nuvoton.com> <20220513033450.7038-6-kflin@nuvoton.com>
 <YoOje2L13q7d7KeI@latitude>
In-Reply-To: <YoOje2L13q7d7KeI@latitude>
From:   Kun-Fa Lin <milkfafa@gmail.com>
Date:   Thu, 19 May 2022 13:39:01 +0800
Message-ID: <CADnNmFoa6=BWs74oQxEtP4TO-mL_vc0py4+4V1wjdtetW4Vy5w@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] drivers: media: platform: Add NPCM Video
 Capture/Encode Engine driver
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, CS20 KWLiu <kwliu@nuvoton.com>,
        tmaimon77@gmail.com, avifishman70@gmail.com,
        openbmc@lists.ozlabs.org, tali.perry1@gmail.com,
        Marvin Lin <kflin@nuvoton.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

Thanks for your comment.

> Similar to what I said in reply to the bindings patch, I would prefer to
> have the VCD code and the ECE code in two separate files, if possible,
> to make reuse of the VCD code alone (on WPCM450) easier.

This video driver is bassed on V4L2 framework to implement the
required interfaces,
and the V4L2 application in user-space (e.g., openbmc/obmc-ikvm) will
interact with
these interfaces to get compressed video data for supporting KVM
features. In this
architecture, for the case of WPCM450 (though it's in EOL for several
years), I'd prefer
to try to let ECE be an optional node instead of separating ECE code
from this V4L2
video driver. However, this patch series could be the base version and
keep reviewing,
and afterwards we could make another patch for optional ECE, is it OK for you?

Regards,
Marvin
