Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E09A562424
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 22:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236247AbiF3Uaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 16:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbiF3Uae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 16:30:34 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34512D1EA
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 13:30:32 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id a13so266759lfr.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 13:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=r7BZ1uLXiCYtoGWqu+Wm9i+dqx8VhlWlmcV7AumSYp8=;
        b=Oiwmmi0+jQC+r/NxTB8Q0HAF0BiecJppMWrub2pZ63OI+HkRtBgOIO25KkeQKGd/P3
         OPlMIpkp7lFh4FACeK2866/LQjDrQEE4yyOY8q9IGplIdp6TdKQ+cqQsL/PhKZYeTkBI
         F5SDqqejqhcej6KNM8lFmYn3uGpGoXvtOv/e9xLIgXgYrg5H4jS3BgFlUe7ej+e4fcGL
         rCMNEVlOldf5XIOqCUj1cbKXfZI5XYS6jahxMgMMMmdM4bv1l2sKQguM3/ABz/X2oqHN
         4xei0r31qtIAexJfbB0Ozf2k3cxwQvdhkGKSpG5tmwJ+lCvyt++YqsQGOaclsK5P/TIR
         sxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=r7BZ1uLXiCYtoGWqu+Wm9i+dqx8VhlWlmcV7AumSYp8=;
        b=SbVSSIHFiShwEda94ZfzDaX+G7w8Tv9KZ25VOgJyODhTfQ9xYiu3P9touA442uxT08
         6fchXxrMoVgMcMv03td91bKvPBxjKkb2rV3hPXL4sh0R3439KLAVyMAsKv7DzHNFMeSj
         9M8s7M8YOurgf86GtndN2W2LbuYToD5Xsxw1ORxixEndT9sWDRxwpYh9AFeP/XeVtUeG
         1Nw6TgBY2dlr1WB0sajMN9D9E967S0UUuG0y49fY2tdStJpI7ljBvBVvPEQAMhidv4u4
         bcG/wK8Cn6dxjgMY82Emd/mUrLGSwZhsmO3pX8XWMUm/afvZn1phKndmp3QQ62yE9gyL
         vDmQ==
X-Gm-Message-State: AJIora+7SLc31a7i28ylJkQf8/6LpOFpfWGGeODliZdHv7zkqTlQJr3t
        lhR5FuSmNzgOh7JODkz0OlgDq6/PmHbnmrDrBIw=
X-Google-Smtp-Source: AGRyM1t9h0euxQQnKpYfVD1ojtp4Uhw1F93FnDp9yZejDkU0uQQdt/DOHh+bJlnChPE7dribGH22HlepLT4lHDK+0PQ=
X-Received: by 2002:a05:6512:22d4:b0:47f:706b:23b5 with SMTP id
 g20-20020a05651222d400b0047f706b23b5mr6767956lfu.44.1656621030733; Thu, 30
 Jun 2022 13:30:30 -0700 (PDT)
MIME-Version: 1.0
Reply-To: oprincekufour@gmail.com
Sender: dr.modiga.marten@gmail.com
Received: by 2002:ab3:518f:0:0:0:0:0 with HTTP; Thu, 30 Jun 2022 13:30:29
 -0700 (PDT)
From:   PRINCE KUFOUR OTUMFUO <oprincekufour@gmail.com>
Date:   Thu, 30 Jun 2022 21:30:29 +0100
X-Google-Sender-Auth: jTn7H4TDlKqzbK4D0gnNg5QISh4
Message-ID: <CAD91S9Lefju3R6ppog7nN2Qg0m_HmZwiUaBAiDvRvn1XokYcow@mail.gmail.com>
Subject: PRINCE KUFOUR OTUMFUO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.3 required=5.0 tests=ADVANCE_FEE_4_NEW,BAYES_60,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:143 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.7358]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [dr.modiga.marten[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.3 ADVANCE_FEE_4_NEW Appears to be advance fee fraud (Nigerian
        *      419)
        *  2.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am Prince Kufour Otumfuo the elder son of the late King
Otumfuo Opoku ware II whose demise occur following a brief illness.
Before the death of my father, King Otumfuo Opoku ware II, I was
authorised and officially known as the next successor and beneficiary
of my father's property according to African Traditional rite.

Most of my father's wealth includes Gold and Diamond worth the
following qualities.

(1) 99kg alluvial gold dust Best quality GEM/Servce 100

(2) 22 karat Quantity 3000 S.A

(3) 9.0 purity Colour : Brown (unpolished) Size: 3/8 carats

As a result of polygamous family, there has been a dead luck over the
issue of division of my father's property between members of my family
and community as a whole. In conjunction with this, the thrown which
is only left to me as the eldest man in the family is been battled by
the member of the twenty one hamlet that made up of Ashanti kingdom.

This ugly situation made me to secretly move the gold dust having the
above mentioned qualities into a security and finance firm with the
assistance of my uncle whom serves as a secretary to Ashanti council
of elders.

If you are interested to buy it just contact me or just look for a buyer for me.

I have promise to run the deal with you, base in the degree of
sincerity and trust in you. Having receive your reply, I will feed you
with the relevant information covering the consignment.

Note, I and my mother hoped heavily on this transaction. Please reach me
to avoid much publicity.

Thanks. Yours faithfully,

PRINCE KUFOUR OTUMFUO
