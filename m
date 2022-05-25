Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8D4533EBD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbiEYOHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245656AbiEYOFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:05:55 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5085C353
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:05:03 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id q184so7581131ybg.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:cc;
        bh=jcv14XD1FEIAH5YEbByn5Xomdekt/dYfYEZFWkwU5FU=;
        b=keTo4FJJxHZh+gTKCdQdLk8BHiR++6kQVHTSnx9CYaXZ/lifenV2Q6uLlClxmgee/j
         138aU5Mcy3WEbdxL+Dinm82aFvV3DZtg5mcpkTfF8kOMPsgmkAPcreG/yACVwS6FWrrH
         nUqwLXKJZIPG0fxObVmKysBHfR1JMnMH6uO+6a/u1mYeEWzTnbKkiVURcffxHX4ai8Fu
         +RIlvpsjz/bdQ7dgg9RSowiIHdaHhx0uNz0BVfPcoFE00ob9/uARhpWSwPx1uZydBtvg
         wG+kJ3kVk9bU/e8sym+gbUUFZmfefki+E7DtAtr/CDmsY6FpDHxebQK3Uiyz9J69eSHK
         P2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:cc;
        bh=jcv14XD1FEIAH5YEbByn5Xomdekt/dYfYEZFWkwU5FU=;
        b=CRd0Jp3EHCUhA406kiJBnWdlSdzZXwmUPWadP53wodPkK5PgLoBphjBnBnr86ITg3o
         HDRyC5G5aKHtR7jSNlBDfGA/fkRhvvpnbOKXHxdh7oCrJ9B0pPYzeL2Q2P1xbOKrohFE
         aSBV4q2lgVHdY/v4JUFlYRPTtLVi9kBBWB5yNH2vGScMGTJHnKZjPP6a6sIaGEKjXezq
         6/2ArqP/rO0+0l2b4WwM5iKFrYwJQZEkF3ySZfcyNhNtEOlCAO0a4iwgUt2tyHNeS9P9
         i2zBoKwtwk7hbc/0trZu/J5/mNBGL0fEa7f/DqYDjwJ1jGXdHAVPSa1FLtbh85/Eftfo
         vk0Q==
X-Gm-Message-State: AOAM531kUBdnkMl0LCqB19xzOEWA0qY5HhEw9de4PRJbN6yXk8q6cCi1
        DlzLXX99dUl6S+K26aNdb0WXLmo0QlsE3fhYohc=
X-Received: by 2002:a05:6902:11ca:b0:653:1762:5c5a with SMTP id
 n10-20020a05690211ca00b0065317625c5amt5917038ybu.247.1653487502725; Wed, 25
 May 2022 07:05:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:61c5:0:0:0:0:0 with HTTP; Wed, 25 May 2022 07:05:01
 -0700 (PDT)
Reply-To: israelbarney287@gmail.com
In-Reply-To: <CAB+02OHG4qRXR9VtFY_p18=+H448jDJJ4v6mKiBWwz72X+XP9A@mail.gmail.com>
References: <CAB+02OH=iZbhU6XkKnLMFFeM0KnQDP3q=UTcdx+TuppajzAyRw@mail.gmail.com>
 <CAB+02OFytK3OGxm9qsK+PMogkXgOJDeZpjug062=Kr3i3Tdm9g@mail.gmail.com>
 <CAB+02OH1Oogs0fOSO7BRqS9-ULAwPgXA5hNaZ5d0219RFNzugQ@mail.gmail.com>
 <CAB+02OFqr9q6BZ5ev5Hbz=1p78FfoMoGqFf6u+oi5evDczT8sg@mail.gmail.com>
 <CAB+02OHv1zg=-uOVEwoAM1MC+vuPt118=7Ez2yCd9Nku53K7rg@mail.gmail.com>
 <CAB+02OEpULj-YAvuW7bG7efq13M0SQ+vcJyBQ0aBktioYguQSQ@mail.gmail.com> <CAB+02OHG4qRXR9VtFY_p18=+H448jDJJ4v6mKiBWwz72X+XP9A@mail.gmail.com>
From:   israel barney <abasszakari0@gmail.com>
Date:   Wed, 25 May 2022 15:05:01 +0100
Message-ID: <CAB+02OFE=9turvuGPm-AvWEwX3OWmPt7638jfsQg=eXiRe74uA@mail.gmail.com>
Subject: hello
Cc:     israelbarney287@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        MISSING_HEADERS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URG_BIZ autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings to you! Please did you receive my previous message? I need
your urgent response.

My regards,
Mr. Israel Barney.
