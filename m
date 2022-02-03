Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED5D4A8BD2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 19:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353551AbiBCSmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 13:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbiBCSmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 13:42:09 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFF5C061714;
        Thu,  3 Feb 2022 10:42:09 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id t7so5175292ljc.10;
        Thu, 03 Feb 2022 10:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+69gBDWXDsmklsuisXB2PTXgsG2vWmN63+2DybJAvcs=;
        b=C2Xt4eLlGESw1octZqyAjcJCmSbuxs1NQ9Y0UXgo0+kzShFcOpd7GV2IoqN8ifDtns
         I0vX0FXMduKIpeXsUcNC09fq7rzSiDB8pXvYRexNFb1cEOx9xG0CAqYEyMaN+f/WKIZP
         mNgj6e+dqz1sKg61RY6Fsf8j7b9IOiMArhRnI8xWcQ3b2ZH4jFB49AZCSOBJNzdZF0KL
         ed/GZYcA5DK0MMB8jNJaob3OgPWbw9iIS4XKSuT17N6OSlq/dRVx3W9jVw1oTuIJOKHt
         PE859PnVcsunIuyDOZ8XHtYwSrDdu/toGtG0splqrxS3Q6+amSgt/51F/o3VlOQLG0BL
         hMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+69gBDWXDsmklsuisXB2PTXgsG2vWmN63+2DybJAvcs=;
        b=TS/3SAbchRBhvQjqSvSXNaWduTAmP7e9t+Sih7KfV0R+Ojt/yPDu3weXNIXQJnIMmf
         Z/5NRFIrLpsNt/6v8DVtr9TW52yX37+GYVSxVD5hPkXhfbvjVeHjiHQ/C6tfwGZT1Aj3
         pppeHR7CRCcv7WkDniZD2DuAesGzX3oowKnVCpkmUPMJRiCvV9ymHBXI+BkOe97ilEMP
         M+e1sxirjcB9mXxz8xtRPBH6Pyjfp6uk2pIygc7aTLhu/4z7fHytQz/voGfdRvgcDGDX
         3IZj/S8wnFsgWRAgs53mH7eazQAg+nVvCKt2mUDRIZFB0Vk5QCtD3H6OVj39Ur0BCiks
         KVTg==
X-Gm-Message-State: AOAM5321qgd4n8ECRYj1KSQCVx/N6L6nZ6Kk9YRLHS2IYg5Udui5kNhn
        8oaDa5ffvGtr7kchLOLXrt0mMkFFjcaIV0zYh7X9WWhN+w==
X-Google-Smtp-Source: ABdhPJxoQzqjgP9cSw5ArliCNKBKBaas/iDtSXxzUciZ0I+USXYc8ZAd1w1EguVgBL1jHFoqFDBdFolDME4xblf8HyA=
X-Received: by 2002:a05:651c:1213:: with SMTP id i19mr23663462lja.116.1643913727207;
 Thu, 03 Feb 2022 10:42:07 -0800 (PST)
MIME-Version: 1.0
References: <CAEJqkgiV1_jXhoxoxVG4EwV7t=cA=j1F+T-LCEuajJN8x25mtQ@mail.gmail.com>
In-Reply-To: <CAEJqkgiV1_jXhoxoxVG4EwV7t=cA=j1F+T-LCEuajJN8x25mtQ@mail.gmail.com>
From:   Gabriel C <nix.or.die@googlemail.com>
Date:   Thu, 3 Feb 2022 19:41:41 +0100
Message-ID: <CAEJqkgg_YdwNiCMDED4289fMad9NPgScius2=nNrJEH4aaxVjA@mail.gmail.com>
Subject: Re: AX200 cards broken after firmware cc-a0-67
To:     linux-wireless@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Luca Coelho <luciano.coelho@intel.com>,
        Josh Boyer <jwboyer@kernel.org>, linux-firmware@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added Josh to CC and corrected linux-firmware mailing list.

Am Do., 3. Feb. 2022 um 18:58 Uhr schrieb Gabriel C <nix.or.die@googlemail.com>:
>
> Hello,
>
> I own 3 boxes with AX200 cards, one is a Killer AX1650x, the other two
> AX200 [8086:2723] (rev 1a).
>
> After commit 4474519a1fd4e7167afae7c5ca2c1b93e17b4d8a in
> linux-firmware tree, which updates
> the firmware to cc-a0-67.ucode, all cards are crashing with microcode
> errors. Firmware  cc-a0-66.ucode
> is still fine. The kernel doesn't seem to matter, as soon I update the
> firmware to >=67 ( I tested 68 too ),
> everything crashes in an endless loop.
>
> I'll attach a dmesg, from 5.17.0-rc2, the same crash happens with 5.16* etc.
>
> Please CC me.
>
>
> Best regards,
>
> Gabriel
