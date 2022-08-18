Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D295598C60
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 21:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244647AbiHRTLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 15:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240608AbiHRTLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 15:11:36 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC66C57A8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 12:11:35 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id p4so1883110qvr.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 12:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=vQ+wMNUUyM62PQcZ3cfsQhJSizHDV14WzncaejOXp/k=;
        b=iaATwjGuxNwb8WbMrrIWp+6tVJK8LPlvDTL1a19hjbpXAw+QyforsjimHjwpdTgbwu
         Iu81lywD9hDn65obB/PjUMeU9ImsiCE5kBLEAmgYodgc5wqRqX3RS1Nci/indqo4Rgxs
         S4BNcjL0peWMtgeLmglQjyaaZI/hi7eKJFUxqKh56fZHLReI8D3UH3M7LmUwBLTQ2xxE
         ejtymN1qc+Yfyq8mxR9hx6EGS2kjgRU5fe3MFRMjDmY0lebYCvJNRUJbTMGxJDryscpp
         Ybv2rAC5Qu4fc8EW37a+a5fCHBfIfssj+bu5qrPXdPoHq7qdJNWWoteAVPi6kjhA2WZ8
         DayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=vQ+wMNUUyM62PQcZ3cfsQhJSizHDV14WzncaejOXp/k=;
        b=oByKdAHp9DWs4L0tVmjCccH2BNYI/oRYxZre4wfk+5BrQJKVAoGJh7FEAPKveBMP/G
         mVpuWgtquHdvN511WL7rTv7t7K/JVRk6cRYDA6SFZ1Ojp7ELB4kJAnzh3sb0ZISkgbcy
         Vk/ElcwVtK6nwr3k6VjB6t7Z6GrAhU1fCTOb3w0/UPjBlchcZSWauyrIC+naUuaCDkYu
         ISOqluD0XsSKEP9T5QZ9/rFOIM1RDrMk9thueF00ZKlZRJY1WaiKnRG0CuUfuxnwkt/c
         yq0P5rIXMnDpl/5VvdLvheIpzt9AZA8KfUL3NgoOuMSj0napeEvQZ1ofL1wImzgc4ZY6
         +PWw==
X-Gm-Message-State: ACgBeo3rCbuyWiQXeUOlHPAKXp8PRw/KtWQmjV8ux5VJ4mpEkXbDypZb
        W2Rll1ZViaeMfl2KrNBoWN+xQTwTA6B7P+W8miI=
X-Google-Smtp-Source: AA6agR6DgHQppr2QHoAw1TkFyFvxTa4iDpvfxYu+a264DfSMj+psNtafEvdIeaYlC7SUlmrZ7r4Qprpb/IftYJ9ady8=
X-Received: by 2002:a05:6214:e69:b0:476:b991:586f with SMTP id
 jz9-20020a0562140e6900b00476b991586fmr3697817qvb.48.1660849894713; Thu, 18
 Aug 2022 12:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220817200335.911-1-kabel@kernel.org> <20220817200335.911-2-kabel@kernel.org>
In-Reply-To: <20220817200335.911-2-kabel@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 18 Aug 2022 22:10:58 +0300
Message-ID: <CAHp75VecURpGCBY3WVKqhd64Ngobjvi-w=PuHQBH2V-MqCzkuw@mail.gmail.com>
Subject: Re: [PATCH linux-phy v2 1/4] string.h: Add str_has_proper_prefix()
To:     =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Linux Phy <linux-phy@lists.infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        josef.schlehofer@nic.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 11:06 PM Marek Beh=C3=BAn <kabel@kernel.org> wrote:
>
> Add str_has_proper_prefix(), similar to str_has_prefix(), but requires
> that the prefix is proper: the string itself must be longer than the
> prefix.
>
> Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
> ---
> Andy, Kees, could you ack this if it is ok?

Seems to me there are too many strlen():s. One is hidden in strncmp().

Besides not the good naming (what 'proper' means), the entire function
is not needed. You may simply call

  str_has_prefix() && p[len] !=3D '\0';

Correct?

--=20
With Best Regards,
Andy Shevchenko
