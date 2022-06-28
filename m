Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E63155CCAE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244771AbiF1Iw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245702AbiF1IwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:52:24 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDDA2F675
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:52:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D22D6CE1CDB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E165C341CF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656406336;
        bh=AaIcKctsIEzMKmBHpTdPbPmlHIj0HjICfR6f84Ff/oc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ka1oqoRy+iEmVLFErMzf9zWQLCCET231/63udHFJoC8EF3oiO3a41W1hPgUjwAgA3
         FjTOQ1PVy4GYfMqmQnBzleWsZl2dIXxH3AvOnp3FjMcVXt5BqXl8I5A8LIV/XU73FC
         mio7y/HWHpqjpbfhjwlGS7yxBleErxGws/6HRugQbgeQwEJrI0Frr3UhZapQuwfI3a
         C9tTXYAv3rzGKaiSRj9/JND+C3yK6FEH77LFzMXe2TbZCFvpk4fZ69uRVAhQ9/py2o
         Ue5E1DiJV6YNkHmxWunr/Nw+YBAHACM/H5Almq4CCzjnxR2zOBlLUMla2aLC5+T1xA
         648+cKAbr6ZMw==
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-3137316bb69so109313407b3.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:52:16 -0700 (PDT)
X-Gm-Message-State: AJIora+qjaURlhX6nLm+sxuAYSEHUHfH8E3yizVaNO0W2ktGuTDy4O/K
        zR0PlWLyH1915GSRhhf6vnp8G5r60VkjdoIHOHU=
X-Google-Smtp-Source: AGRyM1vn6PtVIyH2WRu02X6dTQTAKErf5OrFcvq8UJJCl/Z/89z+cs37BRQGlyFyyc957kYwYbSzoPsCclgS1MK8cwg=
X-Received: by 2002:a81:7c42:0:b0:317:7789:85aa with SMTP id
 x63-20020a817c42000000b00317778985aamr20504436ywc.93.1656406335187; Tue, 28
 Jun 2022 01:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220627202620.961350-1-ogabbay@kernel.org> <20220627202620.961350-12-ogabbay@kernel.org>
 <YrqhaBuzY/GkQXHx@kroah.com>
In-Reply-To: <YrqhaBuzY/GkQXHx@kroah.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Tue, 28 Jun 2022 11:51:48 +0300
X-Gmail-Original-Message-ID: <CAFCwf13eVS4iETpdgRp72KoNw-X5h1Japf=pNQ-8MdQcJ4h8WQ@mail.gmail.com>
Message-ID: <CAFCwf13eVS4iETpdgRp72KoNw-X5h1Japf=pNQ-8MdQcJ4h8WQ@mail.gmail.com>
Subject: Re: [PATCH 11/12] habanalabs/gaudi2: add tpm attestation info uapi
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Dani Liberman <dliberman@habana.ai>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 9:36 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jun 27, 2022 at 11:26:19PM +0300, Oded Gabbay wrote:
> > From: Dani Liberman <dliberman@habana.ai>
> >
> > User will provide a nonce via the ioctl, and will retrieve
> > attestation data of the boot from the tpm, generated using given
> > nonce.
>
> Why not use the normal TPM api instead of a new/custom one?  Or is this
> not a "normal" TPM device?  If not, you should say what it really is.
>
> thanks,
>
> greg k-h

Honestly, I'm not that knowledgeable about it. It is hidden behind our
firmware code. We just provide a communication method between the
userspace and the firmware, as the userspace can't interact directly
with the f/w. i.e. The driver is a transparent tunnel, it doesn't
interact with registers of the TPM device itself. The "real" driver is
in our firmware.

So basically we just got definitions from the f/w how to fetch the
data from them and how to expose it to the user and that's it.

What to do in this case ? Is this considered a "real" TPM ? I imagine
I won't be able to connect to a standard tpm driver in the kernel as
the h/w is not exposed to me.

Oded
