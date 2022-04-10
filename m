Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE04F4FAF91
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 20:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239522AbiDJSZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 14:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbiDJSZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 14:25:31 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F693465F;
        Sun, 10 Apr 2022 11:23:19 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bh17so26680427ejb.8;
        Sun, 10 Apr 2022 11:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dTlWD/+DNG8ntKC7giRASd1M2RQMGgWr/+DdcAwn+Oo=;
        b=fTMuFY8NJsqQxEy1jImsyfghQ41FlphmGwdVAypDvJrGJG2TOyyBp3sU9/lk4Kc9Wa
         xFgHQAGmcPPsFV6W11Q81eQ4wpQPF1dLb4D7RQmZjOYkAruuMeO3XDoWUxqp+nEuJvQh
         KMz/x6PEMXjlOF+/ZlB5sDl+tvPVvflC8yZfWH0bqxAAKfGY94w8ltirJIz+QbcF2VJU
         E+7Vxuws97vPnDn+UXE2RsRm4PGBAThfQ/b4xbSqTnw20vKKn83Le92BW5Xm9jX5QB5g
         kN+66pwcJb2dlKsTN5NrTRH51kqBUenTm8K/8CmiCeY7tOZ4WQnqgF0/P3Ohs8c9i/3x
         +9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dTlWD/+DNG8ntKC7giRASd1M2RQMGgWr/+DdcAwn+Oo=;
        b=nW879R4TszUWVsfpK5rBIFvB2CdCsBV37lKXhPwgQtV8rZ32fjpxKhF0svSt55Z84z
         cnTl+ANSgnVTPYZYeAGJiog521QDMk02n8AZntK2s0cIYEU/MYnSm4nFVSyLWkK+wwYm
         jKom//mHDoKkMtcXoGTk7WbpUghbN37JNEPG8ZKAtbTlJPioqCsjUSu/PSNrCc4NmH18
         bxw+zW3Afgm5lGhAGIt6+9kqhgC5aJ4V3BdeNQlEjWof78/pHoRto/eBe2GTf51MO3Ye
         zHpHRgu+8mmlns8p3wQdZ3nEIcW6gMGp1+hZcagTrjzK606HzW47M9Lb7y46YEGQ23YG
         FGwg==
X-Gm-Message-State: AOAM532VFwwgQSfjcHC09aNIpv5IUfKBi6Ln72e6KH69uIwxauwFojOu
        QrZp8XE99agvFr8DtKp1e0w=
X-Google-Smtp-Source: ABdhPJyWiHyfZYk23/sjFDvNph0NWHcmJxJcH7zcPzkJBZmYJp2g9edrzfKJENEPKt00hjEItaEJIw==
X-Received: by 2002:a17:906:9743:b0:6d8:632a:a42d with SMTP id o3-20020a170906974300b006d8632aa42dmr27490055ejy.157.1649614998151;
        Sun, 10 Apr 2022 11:23:18 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id e22-20020a170906505600b006da7d71f25csm11054135ejk.41.2022.04.10.11.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 11:23:17 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Philip Rinn <rinni@inventati.org>, wens@csie.org,
        Samuel Holland <samuel@sholland.org>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v4] arm64: dts: allwinner: a64: olinuxino: Enable audio
Date:   Sun, 10 Apr 2022 20:23:16 +0200
Message-ID: <4727823.31r3eYUQgx@kista>
In-Reply-To: <40976a35-2241-a2f0-c9be-dd32c1b51814@sholland.org>
References: <4fc41278-c46c-6486-a336-f2a329bd6bd0@sholland.org> <20220407155145.10891-1-rinni@inventati.org> <40976a35-2241-a2f0-c9be-dd32c1b51814@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 08. april 2022 ob 00:06:01 CEST je Samuel Holland napisal(a):
> On 4/7/22 10:51 AM, Philip Rinn wrote:
> > Enable the audio hardware on the Olimex A64-OLinuXino board family.
> > Tested on the A64-OLinuXino-2Ge8G-IND variant.
> > 
> > Signed-off-by: Philip Rinn <rinni@inventati.org>
> 
> Acked-by: Samuel Holland <samuel@sholland.org>

Applied to sunxi/dt-for-5.19. Thanks!

Best regards,
Jernej


