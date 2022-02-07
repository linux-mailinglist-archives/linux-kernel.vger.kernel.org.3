Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13114ABF74
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448655AbiBGNMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442697AbiBGMzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 07:55:15 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCAFC043189
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 04:55:12 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id i34so26720511lfv.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 04:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=+zB79ok8+scrzrgYKxLKHdTPGXHaNMs4/kAV8iB60HM=;
        b=Ls8SEqK0c5NiJAhO44BAIz23+e/3nbYZ02VnkH7mNS2HNVw3oDZU9Vp9JYIYpRsRkW
         /vuNfSrvHcE2BVXBFGRHd8gVLDSdv63HcEy/sA3dF84afTwLIwuMhNKBeI8YNtoj4tvE
         ZloSfKI8tniDWFRjv8iflLRO4RSv9EAviP2rDF9pfgSba1+qnqf1MjvDpRqFSXhU+6Dx
         L+2DX3KrdSKDKd+qnd5h0qAOBsmZxzSvmnT1udBTbpvQzF0TxagyomL15iDHxXiAhrfv
         cIeFEXAioZGCKcM7syHdhKvd4kjljlTc0eg5gjOxlksTGQ578JlNkq4RTzSLGLFSoydd
         6kKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=+zB79ok8+scrzrgYKxLKHdTPGXHaNMs4/kAV8iB60HM=;
        b=C97PIM+SwkIOFSMZJeZoiDuo/5qRzkPLW8qoUcjqgAVOLsoeYou+lnj9/xi9fU/yc6
         OuRRBroGrDVVHxWqKo+Mfva0WmVfiYOVj2pJWWWRZmcIsIyJFVuVgUoOWNdjeriZpbAl
         2Gty4E3gUC1ShO2SCMXwvhySOqNnbe4Lkn92S1MQZ33jc1waO7z6oGLhK5bU87M4032w
         IDRwa0YQDHqPp5Oea0e3ef+Ltduo52S3jIqkYc8NlFSZIUuEuGoV3bGnqv5oQ1ds5BVu
         OyGCoFc5z9JQ8wXiWy9V9Ol5LKB6VWp3b5ljE9dWir/i8IxBuEn+HXkHgnYV513JB1Uj
         /vlw==
X-Gm-Message-State: AOAM531OH2N+YEKeVIl+PW+MW94bAZrW+iX7Y7zcfUd64ySMRkq6dy8L
        uT9tFCf8s+UVGLlSOkkHn1Kx0xWzPzQ+LUsnOdQ=
X-Google-Smtp-Source: ABdhPJxrTjk5sK7v7NECMxKrdB5/t8FBSNikYM7xLKPhDrSiKRaPOfNjkYHXu7gYZV5kYCH63+7VMvKaoD5sq7u5eJM=
X-Received: by 2002:a05:6512:3991:: with SMTP id j17mr8247958lfu.391.1644238510181;
 Mon, 07 Feb 2022 04:55:10 -0800 (PST)
MIME-Version: 1.0
Reply-To: avas58158@gmail.com
Sender: kingevido56@gmail.com
Received: by 2002:a05:6512:3b98:0:0:0:0 with HTTP; Mon, 7 Feb 2022 04:55:09
 -0800 (PST)
From:   Ava Smith <avas58158@gmail.com>
Date:   Mon, 7 Feb 2022 04:55:09 -0800
X-Google-Sender-Auth: s9QlXpTVIA4oWyRCX37InPHKtSQ
Message-ID: <CAH+=8uQwmXxUytW-PjoAUw3RfspZW-jX9j2E=rVohPRmmg1ejg@mail.gmail.com>
Subject: From Ava
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dear,

My name is Ava Smith from United States. I am a French and American
national (dual) living in the U.S and sometimes in the U.K for the
Purpose of Work. I hope you consider my friend request and consider me
Worthy to be your friend. I will share some of my pics and more
details about myself when i get your response.

Thanks

Ava Smith
