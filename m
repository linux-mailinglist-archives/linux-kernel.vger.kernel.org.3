Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBCB59BBDD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbiHVImM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbiHVIlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:41:47 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873CD2E9FF
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 01:41:33 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id w19so19716500ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 01:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=jez7msLgIWIICbFgX2IiMRidWHzm1ZXCcmS33DC564g=;
        b=n+HrSwhiPMBDnTBVzRx5YDKo1jyoxV1MjjfSgLDESSZpSDir/vmUYTGmvVbMnIHwEG
         jOJNBozoELwGxR1TwCg8Ro4MnhkV8DH/n0gUc8h8hMZLBoLt41FASPG43IaDQyaehJu4
         ExF1V3OJdQ+HtMuBycNFCeYbBWlbtMIrtO9fmk8NQDSGYY4SKEQvNc6ea+ZDvCnyNe2y
         7+D9iCNbaoObj1vizQathRMGxyHFGBssEtayJgYJh7l6MDn3ElWQZLbDqGrkHYXwhVHz
         sNH9ZGaOobxaoU1chVba3J7NOGQfUBSc3dPOeTramcERHmkzd9LbyytxnCM0DoqimXc7
         dsag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=jez7msLgIWIICbFgX2IiMRidWHzm1ZXCcmS33DC564g=;
        b=GvA7Y51vEQvLip0ttkyvZBsPccJod+OSe/oD4I+sNSRpBiztGIcFFNnASM0wkyHpIh
         qLyBoeFKM8yTjnxoq4BH/ZUdlEJMWv7IBJcEVr1aslH5Sg4ZT3yULr7CS9FbTyUvy0+5
         LnoQPagKBYMwlAGB3Y5DOJg7R7zbDL7mbfP8EFnFcJQHdBktn7SPUHMXWVkdx9O4G2bi
         WUk1ruwCgnfF8aEXYRxPnsTHZErAVxg9XiwEBoR1Ux41yAtwLB7kZjpVYdzuzLf8zgwf
         02PYkuiUBNLhO2YbQdDcMbQcJgG2yILZDsLVmFuG9Jm49ymaPCb1JSbA3i16en83TaHX
         2p8w==
X-Gm-Message-State: ACgBeo29dLdO6WNUlx3fVnaVFLFnia9VEeryG6FiJPReGprh8SlMIicN
        bMK2SCOZF+P9rpCklwdMzDi3N20Twpb/x6JAAAi4AZowTJQ=
X-Google-Smtp-Source: AA6agR7wrH+fOY22wfSsYHsvfz6aZFNHuafBkrBNCXNbt8LEFyvfyVO6/2pyi3wJ886BfXt1lQibpQyWnLgfs5mXTWc=
X-Received: by 2002:a17:906:9b86:b0:73d:72cf:72af with SMTP id
 dd6-20020a1709069b8600b0073d72cf72afmr4046994ejc.440.1661157691796; Mon, 22
 Aug 2022 01:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220802200336.5467-1-wangborong@cdjrlc.com>
In-Reply-To: <20220802200336.5467-1-wangborong@cdjrlc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 Aug 2022 10:41:20 +0200
Message-ID: <CACRpkdaijxNXG=DVPZ4+EQazB2Gz+bUSK_DM3afUgY278Ad6sg@mail.gmail.com>
Subject: Re: [PATCH] power: supply: ab8500: Fix comment typo
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 2, 2022 at 2:03 PM Jason Wang <wangborong@cdjrlc.com> wrote:

> The double `the' is duplicated in the comment, remove one.
>
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
