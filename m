Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A4E514A39
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 15:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbiD2NJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359750AbiD2NJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:09:12 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4326A2124B
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:05:49 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2f83983782fso84513007b3.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h+Ch5FrsaH2wGj7krM14MGWI0na4ZGCNNKlBF0nMo54=;
        b=iULbLhZoU9Pl0qb1QjcJhvwJGcVVeHrTQCEoZyv5zz3YOIvDfPv4rAbRJVo+kEOwKM
         lNwcDXkrPrJabcmN0qQZ+woNEJsU5gOYCkUE9VUW14CMZPLpoGQsrG5qJV2XfoRG0/2p
         bOM9n96H7FvFGYx1dERd4vrBvH7L1NoYQyTFOHJ1x+cPCeTT6KJ6RD36ivLFGfoKcuyr
         ER0andT2ZySXczvvaWlMWrBLqHzVOqkqLX3dnCPb+hL/Nfrlv+GnFcZ0sjuKXRDIJMZY
         gU0g1UJkfiUAxPSZGUUEqsJOjxKwhIl0ZYDQTGDe62XVZFkilPXU2mExyc170VAvGbmp
         Df7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h+Ch5FrsaH2wGj7krM14MGWI0na4ZGCNNKlBF0nMo54=;
        b=Ot4+4u+hDBn3sCpdRiqH8xUKu43KN7zvL3KBHyFVha9oiN5v7JwyWXZNAiSnIcv5Ti
         TCQ+IbK+M8UbwzpfAy/fWeuJ4khZy4AJ6g9V4Nvb41OIiafUQDICje/bIAubQKWnnRfy
         Op8F5mss7dqR9fgcFyoNcHZKaqOW3p3l6ydWA5uR9HTvUxGlCFmEVucAXZnj9xHzedj0
         SH2szOv/GwTY0pn1bx2sKjfm+Iv9ssxSQ3DBnR7Wg5NsOG4kErnLOJs4WTPrrEeiSg15
         azkhoc6waFaj0iOMCHEftEJ8T8KVSz99A8CgFnIWkBXP79qsVA1CC+Drn6H9R0TIW59J
         gRaQ==
X-Gm-Message-State: AOAM5311s9zFSA2gHjifZn8hWm7dA+JzFeun7KaiX612ZXsGLCh8s43N
        NU3dNQbvPb/Qov7DsHJ1moGtY3VPg6lDKDlc60LxXO0=
X-Google-Smtp-Source: ABdhPJwhtwpU8LT9AahrofrKtL9DhX8YkmTeR4qVA2q0IBXfsK38afZHMnxzahiHpRCcR2V8Po7rHdQfccaLpNAKoTo=
X-Received: by 2002:a0d:e64e:0:b0:2f4:ddb9:b108 with SMTP id
 p75-20020a0de64e000000b002f4ddb9b108mr36140248ywe.245.1651237548529; Fri, 29
 Apr 2022 06:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220429084225.298213-1-rsalvaterra@gmail.com> <91d8eb87-adf0-da62-0c7b-dbf94442f535@gmail.com>
In-Reply-To: <91d8eb87-adf0-da62-0c7b-dbf94442f535@gmail.com>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Fri, 29 Apr 2022 14:05:37 +0100
Message-ID: <CALjTZvYdvGrfjTWaP=LjX0UGJPJVxuF9RtgbneDwu7KCnSdtJg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mt7622: specify the number of DMA requests
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        ryder.lee@mediatek.com, daniel@makrotopia.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Matthias,

On Fri, 29 Apr 2022 at 12:57, Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
> Applied, thanks!

Would this and the cache topology patch qualify as stable material?
Intuitively, I'd say yes, but I'm not really sure.

Thanks,
Rui
