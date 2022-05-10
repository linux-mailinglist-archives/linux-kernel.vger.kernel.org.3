Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAC25224D5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 21:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiEJTdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 15:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiEJTdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 15:33:37 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587ED5251B
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 12:33:36 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id n10so34950319ejk.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 12:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=p1Ouf6aRhnzgjFqiZTPHS9V4F1z5R6yc+jKioe+WBhU=;
        b=L+GK04IWx9af6yDadSb0ZUKzza52BeYd4J5EvS6ddsy3N8oeCXK9ApGOV5s5kwe3Eu
         jzxicXTn78nzcFUvrJ19uddPg+e0mBhMHey2orf4aBZkDix+/BKfFSkVrtVbaFw0xJgy
         yoTgQ+p8xxPgq3XYj4m9kTKpWdWJBx3gYDLJQ6pfgMfTTfJRISFB3xgMVC1sf6/iCVy3
         Yv54YhmXpUtmdlWWr8cb4/tqYtIXsEfuAXDjYdQpLLEzPjcnglgOMGhkiN3f7l3U/kAB
         CQKVvzawj5wr94V5t4CuzmBMpA3K/qJkYSWJAXNplvV22w7r4ElSj9PCUahdEnkob17u
         JYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=p1Ouf6aRhnzgjFqiZTPHS9V4F1z5R6yc+jKioe+WBhU=;
        b=fza9GEbnyJm43+N2xTxwpvFd//c4jj6GfK6TwB/CaUDpZI8ZjGRm/momiRd0MiYkLo
         7coJ8TlUZLY40W60JYlL0QoBpgJ65y0JJ40QCr/psD8hQMe/aoeHgOLsPb29rUx+eM3e
         bmVz2ku1yO99HA6d5iyIr7Uecd/zmar2oq9igHRRcwvaqBtHFKouVyTNq9Dx5H/hrZPQ
         /6ljswJkFUFjDBPngwvlqtX0GgCGytj2va8NZ/+0x/h49uzyA1vwhGxA43Ku3jqxWdQQ
         imqThZEfH4nj7xyEUSX84kbdLSLCqPe8j76DRboXZTbTz5RPZSOLNoeQZ0zzKSUmyeVp
         4IcA==
X-Gm-Message-State: AOAM530FCLERwhVWb8BT724ta29QraHm7KW31MSdQNl9DTpSMqYc6nuF
        zi5L3hmCczv9AUxd7ZUA7NNt2EzilE/e1F87lrU=
X-Google-Smtp-Source: ABdhPJwqW07tnEWZCSwQMeddhnw7Om1oTMKN6C504O0XF22te5JJw8pcBgcZgg4TPsfx7RZzY220/uoOZ65wtfbsjlM=
X-Received: by 2002:a17:907:1625:b0:6f4:55aa:4213 with SMTP id
 hb37-20020a170907162500b006f455aa4213mr21676213ejc.594.1652211214781; Tue, 10
 May 2022 12:33:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab4:a067:0:0:0:0:0 with HTTP; Tue, 10 May 2022 12:33:34
 -0700 (PDT)
Reply-To: barrannmariekaitlynn@gmail.com
From:   "Probate & Executors" <bkoole6262@gmail.com>
Date:   Wed, 11 May 2022 03:33:34 +0800
Message-ID: <CAH5eakg0WNYteUYfnLW3Qq5oA2+fpSdnNBwtFhOrPW71bhm5uw@mail.gmail.com>
Subject: 10.05.2022
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:642 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [bkoole6262[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [bkoole6262[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.5 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Probate & Executors
HRMC London,
United Kingdom.

By a proper analysis of the ESTATE of Late Eng. Richard Carlson, I
wish to let you know that Late Eng. Richard Carlson made you a
beneficiary to his WILL.


I await your prompt response.

Barrister John Cooke ESQ.
PRINCIPAL PARTNERS: Barrister Kim Howes, Barrister John Cluster,
Barrister Morgan Wilson
