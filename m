Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5F45037E2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 21:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbiDPTMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 15:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiDPTME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 15:12:04 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286303CA6A;
        Sat, 16 Apr 2022 12:09:31 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id y20so459507eju.7;
        Sat, 16 Apr 2022 12:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wc5pFB9cFV9X8b0ifj+g9eVrc/4oE6DJhMyg+0grg+A=;
        b=g6SviAzwXAp09tyT7R2XRj717VnDS6GwDtEcvKbhHtciTAYMqsQMA11jPSRytxv9XW
         VFUNpY7EV8Y5oPQJ9ZEoGLCrgx1HKdushCUIVTi1NtwrIybOWklDz4kcdjRsSZskXWLw
         zh1eEM9Ek3muGqX4M+Qk9UWBUD9QHNjpYj6b/i9o4VnZimj1LcebyvcDJ73l9LEG7ZxU
         SCw0yjEdDv5IlHMOo3a4dG2ZUOsIMVRkGOJQIn8KPp7vF8MJPb5nqrTvke/VHHa5NCsG
         2ppWyRQLDnz02tFJevSmSmYFvT/8WXGOQTEYLJNzXD70ecglJ1TRe9jwMuIf9DSxpXva
         vaRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wc5pFB9cFV9X8b0ifj+g9eVrc/4oE6DJhMyg+0grg+A=;
        b=wC7NZB8v289th7qJZdEn8FX/4rPCDBYW5DlPK6T/ATWPwqXbRjAl6moNtYwODeUQUw
         57MxB/vVwMPer+KOA7RdrEp8lPy0ml+4JY/Z+Q4LKF+yQFg/CYmhdPuny7ay3x8KgQj0
         r/IJwEBtZzW0ff1HrnJnEyDMqid333AN/2lhmygjpivjIlNnhiDgFPP5q8WQAbBoFG+g
         i2eLgda/iYfKBV/3q8OupiDaj7HlyUp081IimIM3zXgCALAyisydeJrESdG1BrOkV+d2
         UCa9TxctsnHyus0lm5LF8h9ZSS4tyFo+XSt7aE5KpufPWykTT6Adk54QJY0dkh5MEHAo
         WkaA==
X-Gm-Message-State: AOAM532fwohF6pW8BiJLIYtpZcor6zZRrvOjITpeBBsFwjH3TggYFQ3P
        G6TQK1/9x6GAHRmtqUJqtL8B1V0V9oqXe3/RgJA=
X-Google-Smtp-Source: ABdhPJy0dXUnDlNqpFSRWbTmBQ7n5zYVtmmJh0Ee6Th3tr80ERDWMczGFfIgI95tpj9HKKbOvbuOv7n6qhOInUV9gaw=
X-Received: by 2002:a17:907:2d0f:b0:6e8:b710:a68 with SMTP id
 gs15-20020a1709072d0f00b006e8b7100a68mr3471849ejc.510.1650136169569; Sat, 16
 Apr 2022 12:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220225155622.585621-1-ahamedhusni73@gmail.com> <20220320163618.41054-1-ahamedhusni73@gmail.com>
In-Reply-To: <20220320163618.41054-1-ahamedhusni73@gmail.com>
From:   Ahamed Husni <ahamedhusni73@gmail.com>
Date:   Sun, 17 Apr 2022 00:39:18 +0530
Message-ID: <CAFjpAKqT1eP4vXDPuTG50aBJPuosWTN3qddrURgp3zFS8pCz0A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] media: av7110: fix switch indentation
To:     mchehab@kernel.org, Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
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

Ping :)
