Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B7D4D42DE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 09:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240514AbiCJIyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 03:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiCJIyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 03:54:16 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70F0137021
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 00:53:15 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id g26so9497458ybj.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 00:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bD08i1b1Z+a0jckACUWyZF49FUKoI95aym7BAJB81+4=;
        b=d77zuTOMdWadP7QTexmBQhpN40kO9TgLiGdMXSZntTvlXCspc7CzVF1/iqV/ZhlCaR
         ytTvDiCt2AtGr7bw0sZKGQn4ljSwnKvlzmgzKC/6VAolV0p6K/Xh2H6UaLJ2NnuQIIqI
         TqK7dNe0dO1Jf3nKby0mgdH8xo6FqOgYaVhQTLvddmli64sHcWV/jOIoS1uLGOBft5+Z
         AKYXl4hCUQwH1TJ0+UyZcbS5D3JgtXGJy3i4P3mxduAEFJ0wCgW/N6azFGj4mvGfR5Wa
         QcJoFYUvSwLHT7RVg7L/5+MTROxcrTNJMXqxlIbldRKKti5Zj3yXSaGQjfufMTAiRzHr
         kCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bD08i1b1Z+a0jckACUWyZF49FUKoI95aym7BAJB81+4=;
        b=zUvqLIGfzgmKVZNk7BsoTPKHajZcmQuHoDb5YMaEoF9Px25vzGWl7F+JNvI8WsnxDs
         6UEPGmMTJDZqDnwZOGFuDtIrwKtM6PgtKCgDysiP16Djle085XZlDHWI3Ml7ZKvrHaHa
         UAOlC66juQeEdAu5qtGQsJdJSlslm9DqpcwuA4PvvTdVFwg9P47vpkBPZ0Xm3L5Z5cd/
         wyu01YBeeEI8pTWcl9j0CcWled/HIxjvUfWWHP68g45NLrRLMTqckM4yor2RlDBBy16e
         iuwvVCEgNFmV7aFeFFHXXX3CL/lw74C3jZGrhL8FX9KX1XyJT29QnmwGntB5ScQYjw7N
         4ZXA==
X-Gm-Message-State: AOAM533OfKxQR2I5G4bMc2BlE9NfizBXp616Laohmecub2lp/o/nd8ru
        CV1Cq6eenZbkpASfczTDKz9WFVS2ZjGdkBTRjF7dkQ==
X-Google-Smtp-Source: ABdhPJx4ZXsuU9Tb2NC5aJL7+W4AU+IuqrDW+XUD9ehGALWKJCvmPVJbiDN+x9sNKbRVBSm+dS5nJjfNNM6pejuu3UA=
X-Received: by 2002:a25:da85:0:b0:629:36f:5669 with SMTP id
 n127-20020a25da85000000b00629036f5669mr2988219ybf.492.1646902394927; Thu, 10
 Mar 2022 00:53:14 -0800 (PST)
MIME-Version: 1.0
References: <20220303173935.100622-1-cmirabil@redhat.com> <20220303173935.100622-7-cmirabil@redhat.com>
In-Reply-To: <20220303173935.100622-7-cmirabil@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 10 Mar 2022 09:53:03 +0100
Message-ID: <CACRpkdawz3YgzccnCXV1auyBRHH-zhcxCa1dakBu3EMF0mG5Gg@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] DO NOT MERGE: full sensehat device tree overlay
 for raspberry pi 4
To:     Charles Mirabile <cmirabil@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 3, 2022 at 6:43 PM Charles Mirabile <cmirabil@redhat.com> wrote:

> This patch should not be merged - dtbs files are not stored in the
> kernel tree. We just provide this file so the code can be tested.

A problem with that approach is that the DTS files are not reviewed
and that causes quality problems, and another problem is that the
kernel lack examples of real-world systems so people have to scout
to find those and that costs developer time.

I know many people are opposed to having this kind of stuff in the
kernel tree, but I am *for* having this kind of stuff in the kernel tree.

Mainly because there is no working community to shepherd it
otherwise, while we (the kernel maintainers) are still dependent on
there being one.

> +       lsm9ds1-magn@1c {
> +               compatible = "st,lsm9ds1-magn";
> +               reg = <0x1c>;
> +               status = "okay";
> +       };
> +
> +       lsm9ds1-accel@6a {
> +               compatible = "st,lsm9ds1-accel";
> +               reg = <0x6a>;
> +               status = "okay";
> +       };

These should typically have mounting matrices. I doubt they
are mounted according to the identity matrix, because electronics
designers usually have other concerns when layouting PCBs.

See
Documentation/devicetree/bindings/iio/mount-matrix.txt

Yours,
Linus Walleij

Yours,
Linus Walleij
