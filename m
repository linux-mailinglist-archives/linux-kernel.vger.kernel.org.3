Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD91259BD0A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 11:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbiHVJmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 05:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234528AbiHVJmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 05:42:04 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24F93135F
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 02:41:59 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id u12so1827989pgb.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 02:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=DBXVr+2yQA4Yc+mJwCPapHs1PcqJSd/+SbzdjhsE7eQ=;
        b=n/Ruz35r5yMtQLgcRFtsXNEZlwWwBibObjTg/Hsw9wiZ8L+pHhs3ebgEBMIkxFxvnv
         B+/8LmGJryDBPnfZLXJuCXT+mZnrnWdKLVBYuMJpJE1wEMdHpJM69dGlKU0IbdV9hSzl
         H4Hl2Nq5yZSYzqyvBbi+yUm11YdU/vcZNTJxqBN1kFaVJbu03BTWapAzJ+7VHTn9Pvl7
         J3xfYEhKa7Kvs/JfvFY5BWG/xh7wZrgs7CQIDlnA6nMsYWkKWHsvGT+OWwc032GvNBZq
         mYsIArqMHaxa98OHut2HcFCe3pX/5jK+n3m5H6beV6akBTbrbPrndQtw71XMeP4wIFxb
         dgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=DBXVr+2yQA4Yc+mJwCPapHs1PcqJSd/+SbzdjhsE7eQ=;
        b=qtVYF6WOxf0TGkZu6aPMHAaG1P3AQ7q+Sx3O8XJQLGb+yORpop7xHlUz6kRPVymT87
         hLuoLhNWKgvLrbnNAEI2BqKOHCqgwkCB0X6QcgP5xgH7T5i9cwdNQgH5T0jvvoTXAca6
         OUi0f7nZtYB32IKnNv4jymjl8F0AFV6pPQbudHKvJvucS1VA9x3Nl7vB4LPIQhtm4HOu
         jHm3RmQbdH/EMjouZM733cVTHGDcgztDaJADyuQx/okW+Ro2q2hkgZNpz82y0bo8vlzP
         0JCg7Qy5BWhS3M4Kz0ZqMsbAV6m/JHsVK21GsG3jlbbe5iFVTO9M6XKBh+0wTJanWhtU
         bh1g==
X-Gm-Message-State: ACgBeo1o8meXGxqOqTT1n9XxMBncyGs3e7bQ3zL2on5IBtCTwMhAioG5
        M3dNWnXd9wSHT/pRYGyWjy6Tkc5IOJfogQxuEA==
X-Google-Smtp-Source: AA6agR4uguvghoQvbIof3zyBlUsyLTVfpTHf0Eq1jrHaO3eqR0cqCK3xvog8zTXfxJK3UjOweQDEJK5ZBRDtP9n851A=
X-Received: by 2002:a05:6a00:1251:b0:536:b942:35c7 with SMTP id
 u17-20020a056a00125100b00536b94235c7mr2760333pfi.72.1661161319094; Mon, 22
 Aug 2022 02:41:59 -0700 (PDT)
MIME-Version: 1.0
Sender: adewigiwetigoma@gmail.com
Received: by 2002:a05:6a10:e946:b0:2d6:9144:63fb with HTTP; Mon, 22 Aug 2022
 02:41:58 -0700 (PDT)
From:   Chevronoil Corporation <corporationchevronoil@gmail.com>
Date:   Mon, 22 Aug 2022 10:41:58 +0100
X-Google-Sender-Auth: cuw8VAas9w-7jR1enB59eLu3OuI
Message-ID: <CANrx2Coh6tXggtN2p1M4NvbJ7Umzndcwyi1jGs4Z24whHg4q+Q@mail.gmail.com>
Subject: are you interested
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BEWARE, Real company doesn't ask for money, Chevron Oil and Gas United
States is employing now free flight ticket, if you are interested
reply with your Resume/CV.

Regards,
Mr Jack McDonald.
Chevron Corporation United USA.
