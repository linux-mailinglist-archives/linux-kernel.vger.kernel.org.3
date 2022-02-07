Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963B94AC2AA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443061AbiBGPKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392337AbiBGOyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:54:09 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E35EC0401C6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 06:54:09 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id m6so40646110ybc.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 06:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=esQoHIXBUKeWlBb18gKIHyQyGBz/GVasu56Sd80B2ng=;
        b=NXZLADXqUp0MUL87f2/h9T5AZFn36uTfKE/g+cxCA/fcXOh0GtD/tqns5X6ZG5vBb2
         ZFlf1AsXdmKlgPriNORNLH50yMtdqxQ6hOZ197PBUqQruCcnS0RXL+xF+dnQwr6lJ3ZD
         R2jDsfICg+kT736d/znyp3riLsc45Ib1eqFSLy1h1rLhqXWV/1JieCvFNfJSlrWPsjgG
         vjn05pUXzgr+udhHRunJLyBJE8L4BjBueVbGbtvk+PBK9+XgPffkhqPSFdzuy9z1WJT0
         /RTZ+PNheQlpq+zevsjsA7Xdo5VzoeAwLdbtqPjfjF6bp57dF9M1StDfcG+TVYAuu1Ys
         JsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=esQoHIXBUKeWlBb18gKIHyQyGBz/GVasu56Sd80B2ng=;
        b=aUqh6uwFeMg1oWBYyePpfHKWAqCjY4+aEqgWCCw78d+OuLGpQBsIThgxEu9tZ8KWZF
         tPEZh5fw+aJm/SwVhrDGX25fNQ0txd3cKACyfEgHy0l3abgXTf15XlDOEt1WLZjwwQtB
         T0m8wqBuVW0JSCC5LnD3xamNsMm7A8XoXjjnszcE/f2Pj4g3C61V/oEs++jimyU+f7CL
         +sI6X9Uarp/RbX0CIAbz5Jd7/SP+MHLWp77BNIGpLXdM0TKqWksz9IhKC7EZ5piJ/bzQ
         rvj8PaXnQ6TJsFor5W4krvcQFJJJrZ+1nlhZs6ugY+J83a2RR16+CJMF8piq0VjhT+xi
         Osvw==
X-Gm-Message-State: AOAM5325lgicC87woIpxy8bm9UERhoIVQRpHleT0hoJW1gO3ua6BbUpB
        mfCs1ZZKdzZtKXd0dNYW2JLSqQnUQeJ7jEUd0EFrccQg2t1EGw==
X-Google-Smtp-Source: ABdhPJwyjojZbZLSz96+eLILLBrCNDMpkVn/7RMLww9UP1UOQ8KZY6aRUXRmVeU553jV0E9WbViIzv9in2lugkd7GDc=
X-Received: by 2002:a25:e0d5:: with SMTP id x204mr44368ybg.224.1644245493370;
 Mon, 07 Feb 2022 06:51:33 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7010:6713:b0:208:f944:4664 with HTTP; Mon, 7 Feb 2022
 06:51:32 -0800 (PST)
Reply-To: lindajonathan993@gmail.com
From:   Miss Linda <ikennaubochi9@gmail.com>
Date:   Mon, 7 Feb 2022 14:51:32 +0000
Message-ID: <CACFJyUCmF8Lu2XX=2f-sAXrHE5Y2rKTnvyTLfs2o8JeNfO_owg@mail.gmail.com>
Subject: Hi my love
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.9 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b31 listed in]
        [list.dnswl.org]
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.1549]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ikennaubochi9[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ikennaubochi9[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [lindajonathan993[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.4 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  3.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey dear

Nice to meet you, Am Miss Linda I found your email here in google
search and I picked
interest to contact you. I've something very important which I would like
to discuss with you and I would appreciate if you respond back to me
through my email address as to

tell you more about me with my
photos, my private email as fellows??   lindajonathan993@gmail.com

From, Linda
