Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC744E2407
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 11:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346219AbiCUKKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 06:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbiCUKKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 06:10:36 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EABE12638;
        Mon, 21 Mar 2022 03:09:11 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id u26so1613588eda.12;
        Mon, 21 Mar 2022 03:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SkmT2FABHkpew7E/cN4TVjK7zuvf5Ns9Fgh4qceQpwU=;
        b=g4lAMpd74Jf9YpklzhPxjUQUv6yx2iLEHHrQvVOpWo0P6cDCLzRZeaI8Ih5pJWPbGJ
         7n9oX0SwQOmCtFvFMO+G0Rd7mU2awVCk3z91ghHm05HGrCDAvQZ0f2zaZnGvMZ4hlKEX
         5eiCaY073OpARgfDga9fO5BfL+P8wcEuBgQ7JDSbqKpY27/QvKbKHHjqQETF9em1iDlL
         rqtc0HINi+FpQRfRa1B6wy1sZD6SqeNwJSePP5ZpNj131PXVDScJBe/hZka2doRISQWL
         rYX3PVx1wQ8RL3d9Oiu/hooyx/FRX/yCufrU//hVvfe66KcR66FATEP8nwhUWSd2EzEX
         apNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SkmT2FABHkpew7E/cN4TVjK7zuvf5Ns9Fgh4qceQpwU=;
        b=1/gz+brS8E1xU45CqwbZbes10r/2OlyU8wnrELDVF/8DwOVVKgVxGLS3RA2TEm78wy
         uJR+cH5amxghPGbziW1DrAoHLAfKXwgVzttN7cEPunyt/zl+KK8iT30FrOwhkwp7/9PX
         6f/qx246XEGO1Ar29rPTn3dkAOVuwuOUpGb1Ui8qqq2+Hsl4oITXov68pe6UuiSSzF36
         eIMFuB3xrOEuHkgdYEc6VwKki9gl+Y5wpz6kCoZen5uvqxzJyZG7D41wPXqrqCRszd9I
         vzYrm2H+ioeVzB4UQ7JhbcqPV0tMnRi6fIo5Ti0ePveuP9mOy+yZJQd9+CD5U37uRbeB
         uRFQ==
X-Gm-Message-State: AOAM532SnYNXxCv7LkhcvTOiA/gcnaG/FNnM/Y8VzwtinaIj1Ly4UlRl
        SM+l+JtfkhSZNYp9yu3qUMbvhKYuz4QsbJ0cRyw=
X-Google-Smtp-Source: ABdhPJwjMzeDiM1jhIZC9vO3K6bKkPd1fvqJ2Pl9h9z60Lq9e+0K81GLeFaZGDHFPc4KxsZDKtn8yaYZu4f7CiF1fUc=
X-Received: by 2002:aa7:c30f:0:b0:419:2af:4845 with SMTP id
 l15-20020aa7c30f000000b0041902af4845mr18184178edq.296.1647857349742; Mon, 21
 Mar 2022 03:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220316213055.2351342-1-morbo@google.com> <20220319222228.4160598-1-morbo@google.com>
 <CAHk-=wh4B42bYZmGoY8=UsqHDuq_th2KN7TmXuTnhwyYWzQ5pg@mail.gmail.com> <CAHk-=wgH3kbKcNwBO7os3BuU523Gd2aqdu0dVvf50bJbLKrLJg@mail.gmail.com>
In-Reply-To: <CAHk-=wgH3kbKcNwBO7os3BuU523Gd2aqdu0dVvf50bJbLKrLJg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 21 Mar 2022 12:07:58 +0200
Message-ID: <CAHp75Vc+T3eM9=yu9XccXKmf1ZnR6dz1ZP_eL4faPnM8ZNbbnQ@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: acpi: use correct format characters
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Bill Wendling <morbo@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
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

On Sun, Mar 20, 2022 at 1:06 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sat, Mar 19, 2022 at 3:54 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:

...

> End result: I think the simplest and cleanest option is simply this:

Would you sign off on this? I will then replace the original patch
with your version.

And for the record I have a follow up patch to clearly show that pin
is always unsigned, induced by this discussion.

-- 
With Best Regards,
Andy Shevchenko
