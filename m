Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3E6496838
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 00:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbiAUX3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 18:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiAUX3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 18:29:04 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBF5C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 15:29:03 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id a2so2336650ljp.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 15:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=S3JtR5HtN5TgHtZRkOpXh8ju3yrdK90cRx1M8SbEib4=;
        b=V4HYEx/yXHYm6F5nSIIZOdZUgAk+RQyQ+0aRzuyJOYPuYOepeP55tFnJjKv8ioumTZ
         WdStoy2juCKoy3Yg1VeSQOBkmKW8GBYVh5Y7s+YEvZniHLkAD7IoXUJVsYqkDTvNbRSz
         aeD36vfuZPmgBjCKaaIq0V+t4c13AkQ348o0MS8heNoLUhyOq4pVJESoOemaNbo80o/U
         HDGYalOI+///cjhVQp3oVXynFXpuzWFs2PMNbN2NXEXSYsK2ZYsrhdnkXhBpx4hGPvQl
         iNnLcz4GoDzamWydU001mO5t0ZVYTGrRrdXvOMugEePWIJ2fTyNkt/UsjQwSDBUeLLrt
         Habg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=S3JtR5HtN5TgHtZRkOpXh8ju3yrdK90cRx1M8SbEib4=;
        b=gcrZzAMGaRHde75vbaljRLZccJCBrAnTIUMt3vihdUrD7K16xDn1fmxStf0yESxXO7
         yYvxX0FVRJj0RMzkSt7kcd0WlFPJWtWWVy5c/Z2xg5q4QD6kbOnKqZoOhBQq9clm1wJB
         wc0YXBqELqu1KiKHeOeXY5KhFoRhxw7ZXQfwZMZH8JrEABTepiEOrKnZlXTeWit+NnFF
         rs1ytAXY2gL7Ku2NPLql9Gp/NhXaNDLTCzI831158RijcQEFIqJ6bTs8+EzHhGONA36H
         RU4Pabw8A/zaNhMUsCH9y3UBLpIKLWZVkdqy+l46wTit575s7R72mwuHEoWxVa3ESNES
         e2AQ==
X-Gm-Message-State: AOAM5321H5J5TroCUzRJwBWiajeWiviKeTEjgN9v2wEygfs3D646UFO5
        P2jgeRvMB0I4mpl2C2hiIxU+SBSRQNoRoNzzyBw=
X-Google-Smtp-Source: ABdhPJyBX3TCGk34ZL454LW0npWGn7MPEpzH0q24RPiN5JdCU4DxS7lHGlRbZi9xR26Rk7hHnMWNVhNW5lF5HL4mAH0=
X-Received: by 2002:a2e:7d19:: with SMTP id y25mr4416995ljc.138.1642807742328;
 Fri, 21 Jan 2022 15:29:02 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a2e:aa14:0:0:0:0:0 with HTTP; Fri, 21 Jan 2022 15:29:01
 -0800 (PST)
Reply-To: fionahill.usa@outlook.com
From:   Fiona Hill <xaviergbesse.2020@gmail.com>
Date:   Fri, 21 Jan 2022 15:29:01 -0800
Message-ID: <CABEvWU+xL8VCFMYHCz99Notgic1RpGNry-wcRoRNbYWqZP7qNA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Please with honesty did you receive my message i send to you?
