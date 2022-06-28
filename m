Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9F255D909
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244334AbiF1FGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 01:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243983AbiF1FGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 01:06:00 -0400
Received: from mail-yw1-x1144.google.com (mail-yw1-x1144.google.com [IPv6:2607:f8b0:4864:20::1144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF83112ACA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 22:05:59 -0700 (PDT)
Received: by mail-yw1-x1144.google.com with SMTP id 00721157ae682-317741c86fdso105202047b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 22:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=B83RvUTkVNBlwc5GSt4lR4SXBs0eo7Q77abZwsIYx1M=;
        b=obdaFH3ec0hJePYNDf+OJobKDYJaFzmJmidE668RtcAm6ILZSQF4ZyCf+09KEpZxnq
         eOK7xMt7OsTZBkuZxYbJdvcX874B7Eo6T2vPd2ystERhlHX4TF3GbPb3CcrkDvJcWpNt
         a11sQytmc5CNjWemqTfxASO8foIWelZ9+r1rUaAcLaVWEeIDIjYhmztDT3wGoV1Xpqse
         JE37coSHVGYemRBU/cbqa/LqxPlgLqiey3N1Yw1dDM1y1QD2rupf1B54HfREjinqYxPl
         NQ5crFAAJGQCALhZTsdWO8dWDJglX1nRh09QyFP4KF5tV4GfF+yu3kWZ7tHnUAZKENNI
         5gaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=B83RvUTkVNBlwc5GSt4lR4SXBs0eo7Q77abZwsIYx1M=;
        b=3Qmr268q2enV074y7B8PHxLDkGzxGA1dUGD/TOyEIYEMIuSoMMjqPxUw1JW01TdJnj
         Z/14DogJ/a7op5BcM5CAuaYKaR07FmkOccnO0u6I2wKhiBOlPjfBqBXoYwrP1aodEAFA
         xM66bMKlI6wgUsSMaH5WkbXW38QkuGwoyJKWgNuyWrWDBk2GDI4A4d+NKrtv7JZYpBtM
         1GrGRZINVoBXZstBfhfcXuF+Lq5GgbmXk4a1Dk5EIU27IBWFzETBd9FKY0E9FbFm+qIe
         YVoOofHx06H0use3S9gtTFBRkpCEXg8IPIHcg6x/x8+lIwYm+hQvY7V1D9LZrP+O3Efw
         oE/A==
X-Gm-Message-State: AJIora/oVNNXmwi6J2ya3IPxdUpPQ7M6wgn9MQWtqHpLQSInzS1575c2
        UY4luAde2UB8o+M28761MplTMMBUtYo0Fm3zW4/eWf6uIQ9VZA==
X-Google-Smtp-Source: AGRyM1t5MKABX7ywHUWVOfhZHxSn269R4SNY1b2RpuGkSV5pwxWQiK+/D47EegB1taNljCBNifujMGqUpBsoOCpnBv4=
X-Received: by 2002:a0d:d504:0:b0:31b:bb31:2c52 with SMTP id
 x4-20020a0dd504000000b0031bbb312c52mr11012444ywd.15.1656392758872; Mon, 27
 Jun 2022 22:05:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6900:2a09:0:0:0:0 with HTTP; Mon, 27 Jun 2022 22:05:58
 -0700 (PDT)
Reply-To: ava014708@gmail.com
From:   Dr Ava Smith <aj6882685@gmail.com>
Date:   Tue, 28 Jun 2022 06:05:58 +0100
Message-ID: <CAEVsvizuTD7p6jeP5txpr7+gFZZWWQ=sTYHK5-fgcGK0fKzFoQ@mail.gmail.com>
Subject: HELLO DEAR
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1144 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [aj6882685[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [ava014708[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [aj6882685[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.4 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 

Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
