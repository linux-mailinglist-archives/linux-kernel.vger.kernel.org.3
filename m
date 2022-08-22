Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0F159C351
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbiHVPqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236948AbiHVPpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:45:54 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F34E2AE29
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:45:15 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 1so3521160pfu.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=mFpLjOBd6FsQNzTU/+8aQZgqijitjvM0xNslnXbp78o=;
        b=dY85xiJKnTqlTRQKnIeLaQd2MQxAU02jkC6LboK/zgmnD9JW3tTwP6ouSkMmbV3D3l
         lFnF3wwasQeGJyfb5uz/PIeGbRcZ7WKvgR8dqsb7XowWKXQ1O1PF26lL7sUUCFhmSx5e
         A2QCHLoNc84dMrPujZePUTXvqkWek7Mao0DGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=mFpLjOBd6FsQNzTU/+8aQZgqijitjvM0xNslnXbp78o=;
        b=Gr26QupOLeJf0OH0UANfOicAe5fav6oLJovf6GaaQGp0gTRmKjXKb1baXHsMQFgwDW
         m+Lgx6bbcTEbN3IZr0k4fMEvYjTOvHnjrrF3Pc2rFbNjOsRhye4eINIS+9wMOX5vJ2bL
         sdC+POSH6jdOsjssNpQ4hTCmehQF1glG/utuxJHNaMmtJUySNjKwqxSFB1NCd/BTrWzK
         dMWfmhBPx9Rf+sDEiV1s2gEcvvp/+c3v5t1jdANWWJ5EzWfrHF2thubc1RnROU6TB8yf
         ronBM4YBtXPL0DXEsIAnmjzHBJhGvjpTAb8EIznLr4RrB9irDnYqgzBVvToxZ7fiaulX
         al6A==
X-Gm-Message-State: ACgBeo3ukrDz06Wk9wLexdQjo3T52Dn+4p3eVElXOiSdE5TL9B5X2HJu
        wS+TBrw6r8+RXlGvxsO0x5VWQA==
X-Google-Smtp-Source: AA6agR6qoyklkhj9bTQkRcd+0zthQT56//piWGCtY5xv2ysnGIl4DT/dUSsYExrWmfoHKRbkOYxjWQ==
X-Received: by 2002:a65:6d89:0:b0:421:94bc:cb89 with SMTP id bc9-20020a656d89000000b0042194bccb89mr17277379pgb.129.1661183114598;
        Mon, 22 Aug 2022 08:45:14 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:1969:d650:d765:53ef])
        by smtp.gmail.com with UTF8SMTPSA id ay24-20020a17090b031800b001ef8ab65052sm5096719pjb.11.2022.08.22.08.45.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 08:45:14 -0700 (PDT)
Date:   Mon, 22 Aug 2022 08:45:11 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Christian =?utf-8?Q?Kohlschu=CC=88tter?= 
        <christian@kohlschutter.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: core: Remove "ramp_delay not set" debug
 message
Message-ID: <YwOkh45V3iRWYCJz@google.com>
References: <20220820122453.13071-1-christian@kohlschutter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220820122453.13071-1-christian@kohlschutter.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 20, 2022 at 12:24:54PM +0000, Christian Kohlschütter wrote:
> This message shows up occasionally but in bursts (seen as up 30 times
> per second on my ODROID N2+).
> 
> According to Matthias Kaehlcke's comment in 'regulator: core: silence
> warning: "VDD1: ramp_delay not set"', this message should have been
> removed after restructuring previous code that assumed that ramp_delay
> being zero in that function was an error.
>
> Link: https://lore.kernel.org/lkml/625675256c0d75805f088b4be17a3308dc1b7ea4.1477571498.git.hns@goldelico.com/T/
> Signed-off-by: Christian Kohlschütter <christian@kohlschutter.com>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
