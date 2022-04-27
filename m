Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9575511D8D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244453AbiD0RzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiD0RzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:55:06 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6DD53E33
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:51:54 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id y11so458174ilp.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=jcGF5ee5d5gcdGFp8udDONBjk3OGukZcjYRZ4NJqw9c=;
        b=FaLKOOKuIdrn57kpSid4Wmw71Z6sq/J2Cq2j2APQOA60ikgu3X/aYJBSa6JGvbxGmy
         am5wLgn8vUiC/zRd//fPMcRWtN6xnD5EqzakfJTyMeYtNzAXIaDvTmyhsd37gxdzEmW+
         cgE5BSX0lYWk7ZTd5nNbgIxbc523hyPPRVS0NLmpbTebBRkmugjihoB6DXdkpETvxppv
         227QQQ9wqPdx9rUa5XtvR4VRGmXDV307aptnLS741QmJOkNpPJ6hMshhSH+zAK/oi9k2
         cQT4jc3pgqpZtATqRq/LtgxsFFDCzFe38oihcx1ytOLJAz9jpMno+mYXXSSiV5Zzc5kL
         l4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=jcGF5ee5d5gcdGFp8udDONBjk3OGukZcjYRZ4NJqw9c=;
        b=hr/z2Ok1efRkfcDH3mVlh68lFbRhyltW5KPdfHh5ab02oSJL+kLBKLcm+0vAJH6nSS
         q2uthum+KrT8PtTCjM4GZx9ePnuuheBe+bbSrUih0o3X8g1Y0RWbny+5XEJ7sCb3EByz
         dxzWPpAr9yK+0iZql7UbD52zWwIuDaH9Nc1qZLF1Rh5cuvFqQ98z3R80efhHg/BGsxHS
         EwiJ2plK2sosw+ldDyTB5rmwL04sxYzPRDeewd5WP0BOwa4bg/OaEKsxPE14g3KZQOHb
         M5FL/TWPV+etvGVeUF0uWLOFZi7H1X/8FskjQeTyTXPiwf3nC5JfYUfz9Rb4Gx+UxIHi
         SvVw==
X-Gm-Message-State: AOAM533EisrdYhZnLdPwc5syavkn3Yp9Z5rzYk3MbfX2Pu6mVPb+XA2o
        rOY4aem+CWdcQYz5pGtbL84TjkQtLdCNuo2OBIk=
X-Google-Smtp-Source: ABdhPJxyUpZDsim4RFW0k8nui/MjSUMPdy26EEw70Ufu3EbS+3Kma/ap91LowI5b9hCo1R/eDDJ27YBKKkukeMd4lZI=
X-Received: by 2002:a92:cf01:0:b0:2cd:aeb6:b3f8 with SMTP id
 c1-20020a92cf01000000b002cdaeb6b3f8mr4588123ilo.265.1651081913845; Wed, 27
 Apr 2022 10:51:53 -0700 (PDT)
MIME-Version: 1.0
Sender: mrsalinaa24@gmail.com
Received: by 2002:a05:6602:3157:0:0:0:0 with HTTP; Wed, 27 Apr 2022 10:51:53
 -0700 (PDT)
From:   Lisa Williams <lw4666555@gmail.com>
Date:   Wed, 27 Apr 2022 18:51:53 +0100
X-Google-Sender-Auth: 6I7DqgrBcMYkhjN8daBs_89G6IA
Message-ID: <CAL9XJ1C=FX9okOB1ELtR9oHmmw-Jd737BTN9NadG8-4BgjPO2Q@mail.gmail.com>
Subject: Hi Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hi Dear My name is Lisa Williams, I am from United States of America,
Its my pleasure to contact you for new and special friendship, I will
be glad to see your reply for us to know each other better

Yours
 Lisa Williams
