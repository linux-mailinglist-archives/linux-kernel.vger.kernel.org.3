Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA964FEB3C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiDLXgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbiDLXcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:32:48 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A32BB0BD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 15:20:18 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso45660wml.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 15:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=QMR6lx7WMoCdegQHQIp637QYsvU6+ltNhqOFfDF2Lck=;
        b=GwzkPE/FrAYSYvj1YZdM1ifPs5j/ZSCulhiHdZ/wPAIMW2o9zw0Iewo5FhxtBG8is5
         LtaWbh7YBWbCSGTIfdCOa5oEjvghI0cMjGGJ89hWkfueAmsMs7DhjHo/b4jUXVcUwnzM
         LGxLKk7Znuiyod7NS0X5dlOimWG1/FiCf4rN41h5ZOGQ2HUpRhD/2R/joO7miMou6xKM
         Qo1GwfUjFrLV/pbCMkQUwEszsznu2Pkxv7KFdhMGQ+6voKmMoBoJPX4eQ8t2YRepKfY2
         qTa/j/9kBA5ZWSc7jAgzv8EOTVLST1XzTV7sOIBgyhUEjFiNi8+JAiF6z7P7YEUofbV9
         p5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=QMR6lx7WMoCdegQHQIp637QYsvU6+ltNhqOFfDF2Lck=;
        b=jFqLBh6vNIheBj/GPBFxtVQsCwXq1sIqig0AXhG7WXmYHoUHJGy5Ci9w8gbk4LkUb3
         wwRyGdZG+9m4k6ftnHRDZQdDzm7GT+sk13ENwCf8+iyOtm3K+l1A2EnNBWr9aJn4/ABu
         I8RZWA/G7G2mZm9Z1BB/DE7zYio1Z0Xux12xF1OEFS3gDXK3MjBF+N2W7kpVc8nKrzRZ
         19G7L2/NdxH8H4KqMi09nteeit9xHfxfNutglScF40QloKaY8THoZM5uGeN4Kf+HlC/K
         HZd0eQ5RcD3iTLQPhOwC0Upj9Av3a9EHTKt4rwkqjDaci4pQ4Dy516W+9haymF48lBNI
         IjgQ==
X-Gm-Message-State: AOAM532nECqRIq8muuoFUaIw9/oRxSucyiFIk1c98ktFCLkQBUu17rCs
        OaJPc9RI9RVQmm15GtMsHD+i8t6A0Jw0XigZBoSkMg==
X-Google-Smtp-Source: ABdhPJzqkbWNNUql01VC8IRTGAJWTLrraa3k3BalUDO8lzcnFDV5OWJzELfFvFWZn1boq9gyZDoNudu7O/uL8uMU7XQ=
X-Received: by 2002:a7b:cbc1:0:b0:38e:7c42:fe38 with SMTP id
 n1-20020a7bcbc1000000b0038e7c42fe38mr6029946wmi.51.1649802017276; Tue, 12 Apr
 2022 15:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220405183953.2094007-1-pceballos@google.com>
In-Reply-To: <20220405183953.2094007-1-pceballos@google.com>
From:   Pablo Ceballos <pceballos@google.com>
Date:   Tue, 12 Apr 2022 15:20:05 -0700
Message-ID: <CAO9JgFyoqTn5A01EU4NHsbfZyKxxzo6qVvsDHCZSUn1QwdoQgw@mail.gmail.com>
Subject: Re: [PATCH] HID: Driver for Google Hangouts Meet Speakermic
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 5, 2022 at 11:39 AM Pablo Ceballos <pceballos@google.com> wrote:
>
> This driver works around a problem with the HID usage sent by this
> device for the mute button. It prevents key events from being generated
> for that HID usage since they would be incorrect.
>
> Signed-off-by: Pablo Ceballos <pceballos@google.com>

Following up on this patch request. Please take a look.
