Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10900560EAB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 03:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiF3B2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 21:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiF3B2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 21:28:47 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D60327FEE;
        Wed, 29 Jun 2022 18:28:46 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id s13-20020a0568301e0d00b00616ad12fee7so12638509otr.10;
        Wed, 29 Jun 2022 18:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HKwqbCq/ayM91H1pK6Ejh+0xhF+H4GaxtXkErwTFOeU=;
        b=WJCxPAxmmu3l/WBMcoCqMLyFQ/qPtpHS+9olRFC/mRCBO/0g4aqUsO7N4MnDpTuwhb
         b64PsXTtHULC+j+IeuZe3UB1pSxQEGO75WBjzOI9damQSChdJgLySkkGT2FrBSswIQaJ
         9l12EaSw7oMgXTCOeF3D7xsdW2VSWuWpT1hGEciGfoRu9k8CeoBCPVDVhDslu7MFZJrZ
         Fng9O8Etio2ETgkWULhXNarrnf3ZbqM6DdCCU9Enp8Mn1BD5s58Uw6biluuovYaLccU7
         KMIxUFZ/F0ls+jzfz7ar7VYnGZqJoCYIB5YqHptS+mFDl6sf/L9gnFMvfFPS4Bw3gviN
         /09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HKwqbCq/ayM91H1pK6Ejh+0xhF+H4GaxtXkErwTFOeU=;
        b=qYQW3l6dj73NPZT9pvBBS8AwN15PiJS25vKXdn51OHJim40F4E2si04tArTYgTz3Rq
         B8n80XVOWwPJQSeruskElc9PSS7QIOq8x39V7FL39wrixfy4k0MUwIq+Jq4RD9VpkoNR
         1Q7cKP9BmN8c20NwclZjvES5PvtAPnCWo91+xuyJmfYgv56ypaoPHgXVjm2asmtk4/gQ
         f6a5LnlvCA2pJkOuDCbRgpZpOr0AEe8l79ttbW+KROnCNBNRSamGbng50PkVfDjed1uh
         zi3eCRmJFuCoVQi+FLEj0BZCtRhJul+j3nQ/7XLDp7EyBWbcF7sCtLC9z+UyamBTGYtm
         9tDQ==
X-Gm-Message-State: AJIora8R6iHfxjsH0C38eA3M1HhZ525APiZSLJtOsvhMV0MU+z9q0X32
        Q5wHR7cjQ3vLVjzYovYh3hDTeU5jGismQ2T3cPyvnsQS0Pg=
X-Google-Smtp-Source: AGRyM1unsycrhNhWvFmeSfbLmQqD2NrN4I2WFnjJ5qbg9WxHn9kms7zxA0HmoheqTg47KfFpm3RQnoBdMxXe+RpA03s=
X-Received: by 2002:a9d:32f:0:b0:616:aa29:291d with SMTP id
 44-20020a9d032f000000b00616aa29291dmr2818111otv.312.1656552525776; Wed, 29
 Jun 2022 18:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220620153045.11129-1-gch981213@gmail.com> <CAJZ5v0hDe39COAfy+Fsxi7FeUs-u4ikSU-v_dt+=x57CcLHcSw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hDe39COAfy+Fsxi7FeUs-u4ikSU-v_dt+=x57CcLHcSw@mail.gmail.com>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Thu, 30 Jun 2022 09:28:34 +0800
Message-ID: <CAJsYDVJ7TqF=XotbXkuzgpbd2SQ3bdyC34D7wXgF=oKQFHV4QQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Skip IRQ1 override for two laptops
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 1:44 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Jun 20, 2022 at 5:30 PM Chuanhong Guo <gch981213@gmail.com> wrote:
> >
> > The IRQ1 of these laptops with Ryzen 6000 and Insyde UEFI are
> > active low and defined in legacy format in ACPI DSDT. The
> > kernel override made their keyboard non-functional.
> > This patchset skips override for them.
>
> Can you please merge the three patches in this series into one patch
> and put the above information into its changelog?

OK. I'll do that.

-- 
Regards,
Chuanhong Guo
