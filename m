Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC3E57452C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 08:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbiGNGmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 02:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiGNGmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 02:42:14 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4F41F62D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 23:42:13 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r6so1147841edd.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 23:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=RC9NTSXuyCF50is5JSFEvJn6He6oJ5ev3DmXRdNSNpU=;
        b=WFAFQtnZE6zd4UnCnPWv/sBsjd8aDNCf0hpSMaaEgLIzm2cZXzyJ+1D4M/2rtLmw0n
         vEOgcwsE47zbQQk5AWCqttstrYb9z7FIoH8Wtr+BHv7y9cAFmjdgtM0Ai7NajXAOXGHD
         DU5un868zivpnB/LOWQDxeX7J1wyRBjix1MpMcLY977273xW72DAKziY6zAco460AtKU
         ueG0JL8PHhPMcDwQjeBkF6OFwK2Hn3Onsn3R2TCCB8vi8aQuKuQCZIvr0LN/iSllXu8+
         a1RV/vaX7HU9aHDcgE749GkcfeQ2cFSCgT0UkF9pOIWJ1EJxUJS8FyyexZH3WXo7tRwX
         Cmrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=RC9NTSXuyCF50is5JSFEvJn6He6oJ5ev3DmXRdNSNpU=;
        b=TVlkCuIm9PWVT5RUqghkahEOMl8+tQTuqGOJFFmHE3jWiYa57st1JEOZuaECNVu6HZ
         J/mqqtU/5HfehkrccPDLB/760/qHaZWmfxfXA3Nt18NXMLKBHiXIsUTYVqs0yKJG0ioz
         t+YOXlqCLdQMv7r3CEhJXh6hDH/UB3zPkdjiIwBrLySEJXfxU1Vn8IXQdTt12DOgT1mh
         /ojP8tm4ioVpJeaJkfV0tVzMPn88/7iF+o5qZ77rHUE9ihxRfVcNFt61ZGU4l6pgTMWE
         3WS7+5HNwg5F0mXrja1zlU+U+InsUOH8EvmeqsgSYrBigBkqJB3npXnjNkAdW8RfCjGT
         uJeg==
X-Gm-Message-State: AJIora+g//osEZlq58U+r+QO6BBa1MfoLXu6AExnqY4OdUw6upGEXmMP
        CRnwBQE2hLAdvcrUXhuQdJWbx1ubIOA1vEMcwb4=
X-Google-Smtp-Source: AGRyM1vTne/ODFljjzQak436zzvuL4mLciWFdJzvWY8l2+QWnVzp4xfYFzIjcjz47jSOiJaeVH/aIgormC8oaH1YEG0=
X-Received: by 2002:a05:6402:298b:b0:435:20fd:d65d with SMTP id
 eq11-20020a056402298b00b0043520fdd65dmr10432721edb.190.1657780929536; Wed, 13
 Jul 2022 23:42:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab4:924d:0:0:0:0:0 with HTTP; Wed, 13 Jul 2022 23:42:09
 -0700 (PDT)
Reply-To: dossojerry14@hotmail.com
From:   Jerry Dosso <jerrydosso20@gmail.com>
Date:   Thu, 14 Jul 2022 08:42:09 +0200
Message-ID: <CAK7AM3qcbH8OJD1xGPoh7Jw0xPdRpGyxgX+zBuEXSqS7Dcjh4A@mail.gmail.com>
Subject: Mr Jerry Dosso
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:533 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5004]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jerrydosso20[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dossojerry14[at]hotmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [jerrydosso20[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS0gDQpNeSBEZWFyIEZyaWVuZCwNCg0KRGlkIHlvdSByZWNlaXZlIHRoZSBtZXNzYWdlIGkgc2Vu
dCB0byB5b3U/DQoNClJlZ2FyZHMsDQoNCk1yIEplcnJ5IERvc3NvDQouLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4NCg0K64K0IOyGjOykke2VnCDs
uZzqtawsDQoNCuuCtOqwgCDri7nsi6Dsl5Dqsowg67O064K4IOuplOyLnOyngOulvCDrsJvslZjs
irXri4jquYw/DQoNCuusuOyViCDsnbjsgqwsDQoNCuuvuOyKpO2EsCDsoJzrpqwg64+E7IaMDQo=
