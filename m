Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A79D565D89
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 20:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbiGDSlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 14:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiGDSli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 14:41:38 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A5711A1E;
        Mon,  4 Jul 2022 11:41:37 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id d12-20020a4aeb8c000000b004214e709b72so2008535ooj.6;
        Mon, 04 Jul 2022 11:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yM39wnvtyqASP4s69Wbn0ukCsXaJ2EFTLlEB4IeMOaQ=;
        b=YI6pe5dIIagH2tQDNT7wg7mQv2QQCvwDpJ43+tHTxeoBpZjSYt19KBQ/I4tOBVSTkZ
         xtHteAtGs1l67ws0PkJ0kp9fWfKMd8MbdZ29iOb3bRUeLaCb6QEHpmHKl3mWgijtQE/8
         5Wx573Eo9UJ6fTxlHgJaJYHJx+xp9oSxf4FHug7LJTabMIHrJCZVuhunQH5yTEF2OkLC
         qUNxdnCn7zoeqTqqbkM4ltOgUT/9RU490APjTu5VkqyV+lz748qaEFLTuuDbmZlhDOY5
         8KBszSb/UaZWOM/2YLQXBaBkzgwODsEFe5aeUoeSaaOf6B6/lzzXNKUob2g93QkMl4Vx
         7WNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yM39wnvtyqASP4s69Wbn0ukCsXaJ2EFTLlEB4IeMOaQ=;
        b=TdO4TNHIow0D90UojfV2l8pgNXgNIcedLuBP8ESDpukdK9mvIMBVadx39p3HmtXNir
         eeraRZwyTVo2bVT0W0xQUAdzQkQrfm9wCo+urNnVlsEak178VTwa6qWQ7oZs+ZTgassa
         sEPl0/UBgEZyXCoozwGzqRXV9A6wW/eY9lWTXqafva+E+OTmAsGWP3AzYUlfv3ZHAWT4
         QeCI1sZpMkDO4WTldKpIk1UjOz0wFU49jM4jemYEL5FtwQxjAOsxSf2pgOOtOulpbuXK
         LSu/+GaKTsqpOwtogbLdcPdydknnLcEKSO/lLJjRi/zkv8A3t42tFbQYp+KQLou6nPRq
         Q/xQ==
X-Gm-Message-State: AJIora/FKI6e2YRZw9GmQicM5itvUNHSeByfaB9AR4nOMdaREC1Er4FN
        7gNFNoYSAr4ftLaTQShXRtID8VzV4MBc5hZsCjE=
X-Google-Smtp-Source: AGRyM1uvFWi23TqTNmHrNiLDZPDKf5YbWXOPakKI9vkNoHxqJ9baQPYGmh8wQbwxaJyJbbyvAtKdYGxI18BzX8BYakk=
X-Received: by 2002:a4a:4115:0:b0:425:68df:6133 with SMTP id
 x21-20020a4a4115000000b0042568df6133mr12488926ooa.76.1656960096937; Mon, 04
 Jul 2022 11:41:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:18f1:0:0:0:0 with HTTP; Mon, 4 Jul 2022 11:41:36
 -0700 (PDT)
In-Reply-To: <CAKEH-64QJ3HbPwNhPy1T2YKR19w5XfDBiFhWD2M1oQqkHfs70A@mail.gmail.com>
References: <495ce212-addc-8ab1-a851-4fd5f6c5c8d9@gmail.com>
 <01b66305-4dc2-3825-eb59-c0882b662bab@infradead.org> <CAKEH-64QJ3HbPwNhPy1T2YKR19w5XfDBiFhWD2M1oQqkHfs70A@mail.gmail.com>
From:   Greg T <greg.iforce@gmail.com>
Date:   Mon, 4 Jul 2022 20:41:36 +0200
Message-ID: <CAKEH-65f_8771=qiZXpytrTT4J0TMRHCsg4KCcphhDDMw__wug@mail.gmail.com>
Subject: Re: |Question] iforce Boeder Force Feedback Wheel
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
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

2022-07-04 4:19 GMT+02:00, Greg T <greg.iforce@gmail.com>:
> Call Trace:
>  <TASK>
>  _raw_spin_lock_irqsave+0x41/0x50
>  uart_write+0x69/0x1e0
>  serport_serio_write+0x2b/0x40 [serport]
>  iforce_serio_xmit+0xa8/0x1a0 [iforce_serio]
>  serport_ldisc_write_wakeup+0x59/0x70 [serport]

I've found this in tty_ldisc.h:

 * @write_wakeup: [DRV] ``void ()(struct tty_struct *tty)``
 *
 *	This function is called by the low-level tty driver to signal that line
 *	discpline should try to send more characters to the low-level driver
 *	for transmission. If the line discpline does not have any more data to
 *	send, it can just return. If the line discipline does have some data to
 *	send, please arise a tasklet or workqueue to do the real data transfer.
 *	Do not send data in this hook, it may lead to a deadlock.

Does iforce-serio.c have a maintainer? It looks to me that
iforce_serio_write_wakeup should not call iforce_serio_xmit in it.
