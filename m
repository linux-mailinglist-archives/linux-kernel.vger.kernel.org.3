Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC1058C701
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 12:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242385AbiHHK4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 06:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242501AbiHHK4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 06:56:11 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1969425CF;
        Mon,  8 Aug 2022 03:56:06 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id tl27so15906006ejc.1;
        Mon, 08 Aug 2022 03:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OfXUJVLnl6t1vs9K722W72H/lAtYaMeuRcuxla5w7PQ=;
        b=MxuBMpTCznH+agh0qoyleDhHBC46Hm5BoiZhxHHnM+jGUWY1fbWAFirCSDUAbTiA7p
         WwXUSYLc1DGG1s4ozVYMh8c8x5uhRjmOLYJoZmUSnxg1kC3NnWhVXDYsg+hRkoqqBWbR
         QolsKsHo2MAunnH1+swt3d8AjDxf9lWQPl2ySHYunxOBK2CDwrZD/5OxD9+9Pd1JSchW
         lsIg7Df70wufCJ6QxaOwi6fHCua+xqhPMPHOuGEfovhoXZOeEWXdQTsW+zVQPqKqTaE4
         4sHzcIYm/9RmjcsqYngm5ld6rMBGcdWYtGvofJdya0oofoIAnljqKbOWL/JaRzKOZkIJ
         lvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=OfXUJVLnl6t1vs9K722W72H/lAtYaMeuRcuxla5w7PQ=;
        b=ZauPnrcM4QRtYGgA5QR+pqi4n85OiHG93D+X2yk0KueJ2oy9IB+Q2k8yJOHYHn4VrY
         qA/PNmLqADa9hPtzJIIJRxo5M2r1oWOpYXDVkDOBoNDZ/JASnmPaa8qYXWuYW/b+qyJK
         sWAH9RIwzoz27pmKH9UpisvDq/6hN5ZYXij7BPDjAAvNOodIjKZrf9hea+nxCMK5Qwb+
         Lij24r9p/kJLcJlP3MX7yOsyMGww2/SpZ6aEAutDqsh2rb9gN2F0IXxB/emygwh13eao
         y+K+Qesu5ss79hVMmfyfKp65OuTyEgMFL1EjUkXHiU2oQvfiLnADUpY8R2OXZqD+1jT0
         ckZg==
X-Gm-Message-State: ACgBeo1pSqJxIgpCI2i3/5dOx0oYQ5JiExprHOAB9JEZm6FIWdKe2XIK
        qwwK1iDoThGTUx5m+FNavE0=
X-Google-Smtp-Source: AA6agR51CaFBVR3DasK6z+7ZBW8E5TyMvNqm7BlTN+Tkr8bzNkO8oDqEVagGuXc/JoL2o5usXiwFfA==
X-Received: by 2002:a17:906:6a10:b0:730:e9bd:1110 with SMTP id qw16-20020a1709066a1000b00730e9bd1110mr11034384ejc.88.1659956164575;
        Mon, 08 Aug 2022 03:56:04 -0700 (PDT)
Received: from gmail.com (195-38-112-141.pool.digikabel.hu. [195.38.112.141])
        by smtp.gmail.com with ESMTPSA id kg21-20020a17090776f500b0073132fa9393sm2644405ejc.65.2022.08.08.03.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 03:56:03 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 8 Aug 2022 12:56:02 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] hwmon updates for v5.20
Message-ID: <YvDrwutzv1zqQmzJ@gmail.com>
References: <20220730022529.497941-1-linux@roeck-us.net>
 <Yu+OzWv2JDbI89mW@gmail.com>
 <CAHk-=wiGO=pfxyW6E7HdxCnRwWOF_STL=z7yUNwZK__DrV1WmQ@mail.gmail.com>
 <20220808053441.GA556090@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808053441.GA556090@roeck-us.net>
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Guenter Roeck <linux@roeck-us.net> wrote:

> On Sun, Aug 07, 2022 at 09:45:08AM -0700, Linus Torvalds wrote:
> > Added Kees - this *looks* like it's a compiler bug.
> > 
> > On Sun, Aug 7, 2022 at 3:07 AM Ingo Molnar <mingo@kernel.org> wrote:
> > >
> > > Just a quick build regression report, i386 allmodconfig fails to build due
> > > to a 'string overread' compiler warning in drivers/hwmon/lm90.o:
> > 
> > I tried to see it here with gcc-12.1, but it's not triggering, so it's
> > presumably compiler-dependent.
> > 
> 
> I don't see it with gcc 11.3. either, but I do indeed see the problem
> with gcc 11.2.

Yeah, I'm seeing it with GCC 11.2:

   gcc version 11.2.0 (Ubuntu 11.2.0-19ubuntu1) 

> The problem is in lm90_detect_nuvoton() which returns ERR_PTR(-ENODEV)
> instead of NULL on error. I'll send a patch.

Thanks!

	Ingo
