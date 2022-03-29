Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5A84EA878
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 09:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbiC2H02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 03:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbiC2H00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 03:26:26 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB17098581
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 00:24:44 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id d129so9260359vkh.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 00:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pL+Cp4iZbwgLcxUWKxODDZPNpYMnhx3erX4iFxsT0IY=;
        b=T2X5MvUivqE5mgGVO92sTOil53SIfwWtVoWix5F1x5/LbLmTJinRQzydeIjsOg+oYm
         pKDi6tgHEHYKB3OTiYFgcyri+RIF4Qn9qCIuKBnQ1Ol/qoEXzmd+qvThYxVafmsd6YDd
         3UpcuL/FjUuxWcpFOoyJFuVabitOWYdb87YBN4vgSkLQRa3MovqdaeuuHzbtqdC8ModF
         4y/cffHuq9h74/FNSFBBxy5AHd26Gv6zhaEEGx++3d5FVkVSDcR5K58YEvvQiFM9FtZq
         z87LdY/aWEQ2eZk6XGd97IZzuVcXmea6pv2SlMJqokJ9cY6SzGdMyMCMZw1lYb4rHAYy
         +QZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pL+Cp4iZbwgLcxUWKxODDZPNpYMnhx3erX4iFxsT0IY=;
        b=leeJsw7Qfr39kpU1ig8lEFA4aAOgPDGe2gWYx9qYqeTeOLH7jMnITBBku1FySnk896
         fjEkzNsh4/IvGk6Rf+dL7C0xHjcc19M2OOd8kcHbw+HP0fZUjVSJWRld+/iLCzpu8QnK
         Iypd4LFFJAprbGnCWRiAe0QhmtJVnKox3llOkdObzj+6wY+6oHJnl9ZptlQpOtDg4JEu
         MMbESQP/8T54bNk7QKSC8LMQxhpqJs76HbSn0M02R5SnvR73gkaqUwy1wr2ER4bk8YiX
         YDZT4EMT+CiYiP5MHe72juBkzMUEpoG3lTFFnhH7zA1DJfuQiCOyBdEWMbmjWBJagrTv
         X2qg==
X-Gm-Message-State: AOAM532IH96gF+AuXyi+FrrIWZpHTYU7aY4RsKSFCYPXdOZmkAzgUxw1
        Mw4GA/Nu0Fugj3HsiEB6Wu+XDocGGmAl6lWlBxvFNqNJruq1ww==
X-Google-Smtp-Source: ABdhPJx+IvOLBtbExo85GXpQ1kupYL8mOSu3U3yGjfkVfzkRpmTZcfCSmQYoicsRKDWxcSVJxNJYCXyWphBtDzrQDWQ=
X-Received: by 2002:a1f:6a82:0:b0:33f:7eeb:5989 with SMTP id
 f124-20020a1f6a82000000b0033f7eeb5989mr15757736vkc.29.1648538683833; Tue, 29
 Mar 2022 00:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220329070618.GA20396@lst.de>
In-Reply-To: <20220329070618.GA20396@lst.de>
From:   Philipp Reisner <philipp.reisner@linbit.com>
Date:   Tue, 29 Mar 2022 09:24:33 +0200
Message-ID: <CADGDV=XrhzSxLyES9dtKj1-cQq6Zh32psipLJCoDGRNzAYaZwA@mail.gmail.com>
Subject: Re: state of drbd in mainline
To:     Christoph Hellwig <hch@lst.de>
Cc:     Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

what do you expect for the DRBD changes? Usually, they fall into the
category: yes, obviously. When you are changing the block layer in
this way, then that is necessary for the in-tree DRBD code.

Regarding users: Yes, there are users of the in-tree DRBD code. Very
big corporations. And, yes, we see pressure building up that we get
our act together and re-sync the in-tree DRBD with the out-of tree
DRBD.

best regards,
 Phil


On Tue, Mar 29, 2022 at 9:06 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi all,
>
> while I've been reworking large parts of the block layer over the
> last months I've basically never gotten drbd reviews, and in general
> drbd seems to be completely maintained upstream.  Do we even have users
> for it?  Is it time to drop drbd from the kernel tree?
>
> Thanks,
>         Christoph
