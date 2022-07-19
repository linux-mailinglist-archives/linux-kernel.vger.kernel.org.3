Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD6057A4AE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 19:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237509AbiGSRL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 13:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiGSRL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:11:56 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F72C115F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 10:11:56 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id f73so27463110yba.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 10:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i9cWtsNaADxiOtp8Z1ab41SdVNMY6iARUMpAO2YuQ4k=;
        b=cBltdFKR+a7IgWbfDJv5a54sSqg6m4h1Kf2ud6yMVxz4DVOaj6eYpthSHG9DRhlUq7
         vfRtob1hbfI7lO9ukY1xMfkDiz6iVId0vVx1DrGSHM5bE4pT/FL7t4W0/TUH9dJep5Wk
         20+MSvYt3J+v9ahRa33lmZSWMPXB0EZT+h6YU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i9cWtsNaADxiOtp8Z1ab41SdVNMY6iARUMpAO2YuQ4k=;
        b=wutaoy6T9zZi51J0ChK3yUDl8y38PR+IAtmbVQEShBBP7zMkxyc1VANfn7Bu7Z1hdF
         4QeQF+XKp+Y9v8bbL9xGR0LyeDeB2cZamz7hb2MfpwilhQuUw0OU+N7/FProilKifcr4
         J/N5dmv38uMsJpOdrqIyRWsknmI2UH2zK5+fBnaql+L67kHER5yxjgeZ5CLrI5o8y9KX
         hnxpTt9ZcU9wXkGlHXRwEw1msIUl/LQvRXNJ/hkRqJsx2gJKV221+gJl+s8Bzd+Ge5Kz
         Cc9VXHBWX7y4kc5aAp4xIfWpVTXgPvLtSQ+JBg7Pm3UT07LwRfKuyDMFW5OjfrQvOgrc
         Cu5Q==
X-Gm-Message-State: AJIora9dxz2oSx5dfGK/PW7h5ZLxhtKkAaqwDAbWxtI3rS0Ci1mEIQDH
        sYyIwNjgP4Ra9TsMSK3I9QyMdq/G78RdlnxAEB/8Jg==
X-Google-Smtp-Source: AGRyM1tV4H0pvx6jCGVXpjfX3HEHe69QXE28jHkC4yOWHBxMtM3zcR6FWLJn4RF4eAipbUchHcN9zF67OpwINJ2IazI=
X-Received: by 2002:a25:3184:0:b0:670:8123:c0ef with SMTP id
 x126-20020a253184000000b006708123c0efmr3904842ybx.240.1658250715432; Tue, 19
 Jul 2022 10:11:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220718163158.42176b4e@canb.auug.org.au> <YtXF8TUZHNRUUyJh@kroah.com>
 <CACeCKafbgLmhLoYQiTTDkeeJ26HqFYBHXtcpwQkzOyO9LESEFw@mail.gmail.com>
 <YtZUJr4oIIALgdO+@kroah.com> <YtadE201j+dt5jJx@kroah.com>
In-Reply-To: <YtadE201j+dt5jJx@kroah.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 19 Jul 2022 10:11:44 -0700
Message-ID: <CACeCKae5aeK4wU_=+EXFnEHKsFbRnvxo14KtZgMAYw+zNpnKBg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the usb tree
To:     Greg KH <greg@kroah.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Benson Leung <bleung@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 5:30 AM Greg KH <greg@kroah.com> wrote:
> > > 3. Revert the entire cros-typec-switch (patches 3-9) series from
> > > usb-next and wait till after the merge window to apply it to
> > > chrome-platform directly.
> >
> > I think I'll just do #3 to resolve the issue.  I'll do it in a few
> > hours.
>
> Now all reverted from my tree.  Please send these changs through the
> platform tree after the next -rc1 is released so that you don't end up
> with build problems again.

Will do. Thank you for catching this and reverting the patches. Sorry
for the trouble.

BR,

-Prashant
