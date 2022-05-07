Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E7A51E79D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 16:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446454AbiEGOHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 10:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354959AbiEGOHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 10:07:31 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEFE34B97
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 07:03:44 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-ee1e7362caso5942123fac.10
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 07:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PV+EeBijh9A4kZgO63AfPY6+PswP9Y1ZZJKInC8tF8o=;
        b=mKK+yYv6Tl6QMPiOH1V9tfiQUzi+baRi8UmsnBuhfW95KqeYQsBaobOeQ5LNu9khPu
         opR7cOBV3pM4G/UPC0706eWCaKWd97ZR5S908skwo8ylqK0P3FEsSr7yvCBZC08xU3Tc
         xzMu3dQlA1CKZ994kkXRoWE5mDFf7dheIrviq2jPjuxfLLTIUKaGhq/E+C4/skZxbTkc
         t7gJtBgHdMiLfaAXarXvttLOUs4lxzOVXUL6Wasl2drrvOraIEjORfY9OjcMvB/p0dxD
         16PR5+1UFarCTld+MnuUOLSH9FGvu6GkqU13TTy9F6+nAvAUTqO3BswNoOUyuXlwkM0v
         CcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PV+EeBijh9A4kZgO63AfPY6+PswP9Y1ZZJKInC8tF8o=;
        b=2J64zPt1Ji797XzPpVtZtqqBEdu1cf6gF01pf/YMVXrGUNUdhH+4seBcUd/BRVaeXv
         46Drl9nPyfEZgNdrGrhKGm+krrqK/j0Vjzyde2smR2aMpdLndYbSQYl33qKOE8Ct+6t9
         jVp9Q0CXJy29AUuvRL+vEzAQm4OvKgbt6YTQ2ZxIiTwYiCmI2zstQ4PAwKYmZ40mkmTR
         r3UYh8sHgKLkO9TFYfGIK0WeiiBSD7pWtKVyEUS7wjrK6OMNVon5vQy2RkdZCcu8xrBc
         OcZ13loshJOlXw4/yC7rmwfl+otKwkpUnEon7717ltrLO3IetfgnmGmbDZJm5YY+2OLa
         1sIw==
X-Gm-Message-State: AOAM531+/vkUKkV5uNBV1zV2mZiCBiFj19CEFjyzrU9NKmT1Xd8TDAfL
        kRFfm5g4ce62H/mFYptTMK7HK/sF3NT6Q+PbYS1eL5dBDRI=
X-Google-Smtp-Source: ABdhPJzKy/PuIgwIztY7o3Bf/MpJeuhGMOr1D3RbkTPu6Jcs7rb9PUs09EjbZZx9Wz3Q5HpgFNHkutCcixhdVzq7Beo=
X-Received: by 2002:a05:6870:6087:b0:e1:dc8b:56ba with SMTP id
 t7-20020a056870608700b000e1dc8b56bamr3287248oae.22.1651932224142; Sat, 07 May
 2022 07:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <CANL0fFQRBZiVcEM0OOxkLqiAKf=rFssGetrwN6vWj5SsxX__mA@mail.gmail.com>
 <bf281951-aff0-2d02-895d-8b2527975133@lockie.ca>
In-Reply-To: <bf281951-aff0-2d02-895d-8b2527975133@lockie.ca>
From:   Gonsolo <gonsolo@gmail.com>
Date:   Sat, 7 May 2022 16:03:33 +0200
Message-ID: <CANL0fFR+4Mq9WMzrw0tQmsFvAuLSFEzCJE72KOQbSuewaWXs+Q@mail.gmail.com>
Subject: Re: Suspend/resume error with AWUS036ACM
To:     James <bjlockie@lockie.ca>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> What is UBSAN?

https://www.kernel.org/doc/html/v4.19/dev-tools/ubsan.html

It seems to be included in my kernel.

Best regards,
g
