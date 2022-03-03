Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C4A4CBB5C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 11:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbiCCKa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 05:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiCCKa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 05:30:57 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B58179A24
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 02:30:11 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id g1so9278396ybe.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 02:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=k6NYZQl2rxZhVB/aKDQvMsV5vW2gUENZyGD3qWaMtBI=;
        b=laI23BgcZDhcP/9hP+X1hN4Z14KZUKGolqcmzFNHfC/QP77+/OCeZliYYDIoDxHIhq
         Er6kZ4beuigKECI77wyuP8XEZwNksjnAyFqNiOR7p1P+T311fTmdihj9HOMhuqdD6RWZ
         JtsBDx5EBlsmMT7MLsvDi1fF1zISaIlPX3Hj6dBeq/0S84+J7KtEZ3daFtE8U/6exz/1
         bJCbcWr4SnHdNiEu2v/nHIB855YWAD85bmXyz2TbZgNxpF3w26gm1WP/DrCb9MDtkB4P
         pVfCYprDC69SaXck8MTcHOC1fxM7Rj1UquaWXRYcS7WZHs0iydCd7TiRphLYJulRp6c6
         WcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=k6NYZQl2rxZhVB/aKDQvMsV5vW2gUENZyGD3qWaMtBI=;
        b=Oc+Sqk3Z4616Au7VQf0OHKp0X2jwgzDCbaNwRT7YR9hseSHfISMUJxr76WMpV8VqFc
         rZEKbDSlLtmqG049S/Dj2sqdU5svXN+g/47zaeX+1GIjQqE9TWxbztoy28+jRaFdAiTz
         HvLIOyEttif3PevT+kYED7Brw0lKZ4LViFhFfGa0MW0coitYWPYzG2dGHnEJQLkg9xJ1
         aUyY/Q71nrAvOe87hLvIyM4BddxHHJfbQTxlyXdPtTKAuUMFAw252MIRQx2Rnq0SF4AM
         gsJeEMHWUgumpm1F0Oz2aa87gOEWz65vO5g5MpUBXuzVVVSV9YD4HlMoH/OSwEXSlwS0
         O5Lw==
X-Gm-Message-State: AOAM530Rh8lSaEjn76hM/Cl9KGX07DwQn3BGufvSylpeF6c7n5T8w6xd
        /+tKmDI2+3LnBQQAr5tnXlPTMi2VDE5+tcIcGG8dFYf+
X-Google-Smtp-Source: ABdhPJxEBxT1/3gEl0Cmj58oRDigp0Sxrtcf/ZvyRdaOy0OJ8lqfzAkUQOs+16l4KSHCIlDpuNxUChHdam22Ke8yKOY=
X-Received: by 2002:a05:6902:1506:b0:628:7962:6682 with SMTP id
 q6-20020a056902150600b0062879626682mr12156012ybu.59.1646303410821; Thu, 03
 Mar 2022 02:30:10 -0800 (PST)
MIME-Version: 1.0
Sender: edithbrown0257@gmail.com
Received: by 2002:a05:7010:cc8a:b0:210:741f:4d30 with HTTP; Thu, 3 Mar 2022
 02:30:10 -0800 (PST)
From:   Rose Funk Williams <rosefunkwilliams02577@gmail.com>
Date:   Thu, 3 Mar 2022 11:30:10 +0100
X-Google-Sender-Auth: MDLx6wFUgHexXojOEAxZtWZA-tk
Message-ID: <CAEbKRu2pY9b+z52qm=P3Z9KDRnN0bqW+LYqfTC3_jXAPjnO=LQ@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello,

My name is Rose Funk Williams, I will be honored if we talk and know
something about ourselves, share pictures and life experiences, I look
forward to your reply, thank you.
