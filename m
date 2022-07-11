Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BB8570C4D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbiGKVEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGKVEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:04:39 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2004F682
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 14:04:38 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id e28so7135828lfj.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 14:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=+UgIDtYPSeAAdD0Bhb7fjqhPnzO92RXBeyjlk68eVD0=;
        b=Pn3lXvc3RSscT298QBon2VZJrIKoT5d3gH0WSdAjSZ4ZYinFkJz+R5b+8sbLpVOJGq
         gMxlpRhH2yWd+GeC6SpQEAhzX4OLnFIR0rGwv07hsqkUQPOQEd9dULO8WMaCvZYUj99X
         IPL7TUqhZiHSd8O30oe2RN/fBMQUCBY/i1YXu2RRv0jocIhGMW1TXFshnsblN6+2WNlU
         WKpsupjJRmtxcCsaxECBZIJNPFK1e1z8tyLm4L6xbzTyzTs2M7N5bZgz6bJJxoCsm82W
         g5Lu4kdQoMk2LRR6KRLmtgo5CYFUOPpvYXaRgqbrtWYJY8PdabLEysWz1Xbm2kcfYkbq
         588w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=+UgIDtYPSeAAdD0Bhb7fjqhPnzO92RXBeyjlk68eVD0=;
        b=xhOx1xGiaaNUYBo90+ijtdV8Pm6Lpwga3aiicNJHUoPZpojmmPQv/EAL1cI+/7QhJX
         t9IbR87+kxzcgKXNAIq1Fk4QkRWPsH3GLKEJN9iTgE+SHxJ48aq1vZEq1tA4rjMnJEJY
         tRyf8cTEuMEoDEguXJQrs8oCgaGTe2W7+L6+JUkq6J+yCqrcsxl+y69qhIftw05e4w5T
         7tOlhX2SWrvT14bwq/peMbeq6hYLw32suzZIaJ8IytMubXIYN478FLD2Nwp5DU7RdxMF
         NUGz3jtVKVCEGEnqzgAGprBjPyiOYGHvkHbwuVpVCVWciaZ3Q8TlItTv1BBStubR8cn1
         lTEw==
X-Gm-Message-State: AJIora++/5B90TMoEjnqHfPFeUPeitrGfAVj7AL8fOn7ylXSJKQ3e9VG
        AlY+qjHihcZBJnhZBAtTpNifdwETXETNrB4vLHIKasqZYEs=
X-Google-Smtp-Source: AGRyM1vrIVWTlesS+/6RjGjt32fb8NL55Mn1eZ2mG5C1ujUuWkg55pL4yLqMDi3Jfk8BNnvs1aZS6SOVpO+V17W/FXg=
X-Received: by 2002:ac2:4a86:0:b0:489:c5eb:3403 with SMTP id
 l6-20020ac24a86000000b00489c5eb3403mr10911944lfp.603.1657573476573; Mon, 11
 Jul 2022 14:04:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220708095714.127736-1-michael@allwinnertech.com>
 <0cef31e4-7e07-087a-1d4b-241cdce76970@gmail.com> <e87feac9-e00e-1c83-79fe-c790e2f99e15@allwinnertech.com>
In-Reply-To: <e87feac9-e00e-1c83-79fe-c790e2f99e15@allwinnertech.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Tue, 12 Jul 2022 06:04:00 +0900
Message-ID: <CAGTfZH1YzEM+PjSvADtbeH8EoyA+opH5gAEFOvc8d6wsZ1cYuw@mail.gmail.com>
Subject: Re: [PATCH] extcon: Add EXTCON_DISP_CVBS and EXTCON_DISP_EDP
To:     Michael Wu <michael@allwinnertech.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        allwinner-opensource-support@allwinnertech.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 11:23 PM Michael Wu <michael@allwinnertech.com> wrote:
>
> On 7/9/2022 9:03 AM, Chanwoo Choi wrote:
> > On 22. 7. 8. 18:57, Michael Wu wrote:
> >> Add EXTCON_DISP_CVBS for Composite Video Broadcast Signal.
> >> Add EXTCON_DISP_EDP for Embedded Display Port
> >>
> >> [1] https://en.wikipedia.org/wiki/Composite_video
> >> [2] https://en.wikipedia.org/wiki/DisplayPort#eDP
> >>
> >> Signed-off-by: Michael Wu <michael@allwinnertech.com>
> >> ---
> >>   drivers/extcon/extcon.c | 10 ++++++++++
> >>   include/linux/extcon.h  |  2 ++
> >>   2 files changed, 12 insertions(+)
> >>
> >> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> >> index d3a32b8064994..774607a616f7b 100644
> >> --- a/drivers/extcon/extcon.c
> >> +++ b/drivers/extcon/extcon.c
> >> @@ -167,6 +167,16 @@ static const struct __extcon_info {
> >>              .id = EXTCON_DISP_HMD,
> >>              .name = "HMD",
> >>      },
> >> +    [EXTCON_DISP_CVBS] = {
> >> +            .type = EXTCON_TYPE_DISP,
> >> +            .id = EXTCON_DISP_CVBS,
> >> +            .name = "CVBS",
> >> +    },
> >> +    [EXTCON_DISP_EDP] = {
> >> +            .type = EXTCON_TYPE_DISP,
> >> +            .id = EXTCON_DISP_EDP,
> >> +            .name = "EDP",
> >> +    },
> >>
> >>      /* Miscellaneous external connector */
> >>      [EXTCON_DOCK] = {
> >> diff --git a/include/linux/extcon.h b/include/linux/extcon.h
> >> index 685401d94d398..3c45c3846fe94 100644
> >> --- a/include/linux/extcon.h
> >> +++ b/include/linux/extcon.h
> >> @@ -76,6 +76,8 @@
> >>   #define EXTCON_DISP_VGA            43      /* Video Graphics Array */
> >>   #define EXTCON_DISP_DP             44      /* Display Port */
> >>   #define EXTCON_DISP_HMD            45      /* Head-Mounted Display */
> >> +#define EXTCON_DISP_CVBS    46      /* Composite Video Broadcast Signal */
> >> +#define EXTCON_DISP_EDP             47      /* Embedded Display Port */
> >>
> >>   /* Miscellaneous external connector */
> >>   #define EXTCON_DOCK                60
> >
> > Applied it. Thanks.
> >
> > Do you have a plan to send extcon driver with newly added connector type?
> >
>
> Hi Chanwoo,
> Thank you for the inviting. I'd like to send more patches for extcon,
> unfortunately the SoCs I'm using only covers CVBS and EDP among the new
> connector types. Once I had a chance to verify a new type, I'll surely
> send it here.
> BTW, should I send a patch-v2 with 'Reviewed-by Chanwoo Choi
> <cwchoi00@gmail.com>' or 'Acked-by Chanwoo Choi <cwchoi00@gmail.com>',
> or should I just wait?

No, I already applied this patch to extcon-next branch[1].
[1]https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git/log/?h=extcon-next

Your patch will be merged into v5.20-rc1.

Thanks.

-- 
Best Regards,
Chanwoo Choi
