Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB4E50D9D8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbiDYHIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 03:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbiDYHHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:07:51 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691C21CB04
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:04:47 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id z2so16145547oic.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=NLijoYwk7hqoA8TsUJbQbQCYzScrvalH7Lc8MykkZrA=;
        b=DjMDt9TVVoB+1HfsJxHF+dY1bHo3CrzTCxQODKRvv7f60sTvz527shJXYZMrKnoA3i
         5VFgLLha8lmOXU/oGlgqusENSDjzXpzZNAwwuPh32iIh5HXe3+LRk7mYQ3KbE3KkFJKx
         LFwAjSyt92pdAYV7R0w4zjdGwp+Ilc2cDqrKeM9VDau2XkjeiBIiDU0Go/nANtt39ueg
         RX5NY0uNI09bJ1rjWtrGEhCqakUYWT6SMNc8VBvdYZs1Ia9H56tTUFoSTP0ezCxNfRIF
         MWUFsTCw3T1WugSEg2nyyegxhcQHmah+hlmRIyQCBjY27/BizEfzfNEKXq9r/5EPYxMA
         i3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=NLijoYwk7hqoA8TsUJbQbQCYzScrvalH7Lc8MykkZrA=;
        b=sq+OEU2iJyandLecMLhFkKBiQtQgHvR5Yz3SC58w9Yt5UtsX65UZMkewF28twwP26a
         rFzPfxc1ywEh++jyPrtYCggyvKDd5yquvKdttFnhyCJEFGZHOThvicFwKI6n5OI15pL5
         G/WtzP+6UfwhKgVX9J1qNQL2LGa3Eq9ySYqfc49SvuoX94NqIXIX78lkDU7lIavP2Kvl
         mWrNJD2hgUz38JFGW4qzTJKNVnNq1EylerEHzLwVb7NvlndXpQwvKNmXQU9rJH0HFrpt
         YOxUALAdwB+KJ6wKiz/2GRzHbwga60HuIRZ9QTGRa0ZnW0lOVkwqhevat6DrrjxZOigr
         Ynbg==
X-Gm-Message-State: AOAM533riptwUYF/rqBAFF7vbgZjHmrB5PxPaA4hABzpUHdzUzEtXIDC
        HLR0YTjjNStWtWGgCMsYtaaSl9PxvSJ+vW2mmsw=
X-Google-Smtp-Source: ABdhPJxFUqrXDb80WV9pUSPam/2339ShGdZTObagOaqDjF/+33KJZG+cl1/rC5HKJC/35ged0JqW3jk9zrc7HHJaZIk=
X-Received: by 2002:a05:6808:11ce:b0:2f9:d196:6597 with SMTP id
 p14-20020a05680811ce00b002f9d1966597mr11733664oiv.179.1650870286509; Mon, 25
 Apr 2022 00:04:46 -0700 (PDT)
MIME-Version: 1.0
Sender: mrs.awabello305@gmail.com
Received: by 2002:a4a:37cc:0:0:0:0:0 with HTTP; Mon, 25 Apr 2022 00:04:45
 -0700 (PDT)
From:   "Mr.Sal kavar" <salkavar2@gmail.com>
Date:   Mon, 25 Apr 2022 07:04:45 +0000
X-Google-Sender-Auth: MWtRHGufOvD6OTpr_llhWO8IAE4
Message-ID: <CAJpGuB-PduGOOOmrpUo=q3pCCvn1A6itQAz0-=6oRH5OG=Wtcg@mail.gmail.com>
Subject: Yours Faithful,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_HUNDRED,MONEY_FRAUD_5,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_MONEY_PERCENT,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I assume you and your family are in good health. I am the foreign
operations Manager

This being a wide world in which it can be difficult to make new
acquaintances and because it is virtually impossible to know who is
trustworthy and who can be believed, i have decided to repose
confidence in you after much fasting and prayer. It is only because of
this that I have decided to confide in you and to share with you this
confidential business.

overdue and unclaimed sum of $15.5m, (Fifteen Million Five Hundred
Thousand Dollars Only) when the account holder suddenly passed on, he
left no beneficiary who would be entitled to the receipt of this fund.
For this reason, I have found it expedient to transfer this fund to a
trustworthy individual with capacity to act as foreign business
partner.

You will take 45%  10% will be shared to Charity in both country and
45% will be for me.

Yours Faithful,
Mr.Sal Kavar.
