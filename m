Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD9D55A7A3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 09:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbiFYHEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 03:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbiFYHD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 03:03:59 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24919338AE
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 00:03:59 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id d14so4664506pjs.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 00:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=jE0JLsfEdPpE7rbsOBNLVDtif/ZpFdFdV55NgbKwOcE=;
        b=mdu71h/Qe/E3FurnyjYKHrigRQYjVO+zqpBWm+CLGe0uCHXEDOJGCJA6w60QHw/51y
         g+amuJDsfd73nui8vAsEC2hK8Yjn6ADXYQqS1KGZGEjGYFYRBrigNBFBWF4zwftdKhqe
         F9c+gm1w4XJ1Qc1voBHOVRliz5iW7+ioc7L3n4+wB4OBza887RYSchIaDbQAct86xGAt
         +jZxa0Gt5MOgCC9hc1Fyd8nOjo0tcIKOezceZO5OzM5tvxjCD71m8SW70kH0e4hR6DSH
         Xp1Q+sKtG+roh70EHMdyU0UTcJ5aR/9pgpnUZdPQbDHY+c+k69zOY5SeAbT2xa2ZRkV0
         LuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=jE0JLsfEdPpE7rbsOBNLVDtif/ZpFdFdV55NgbKwOcE=;
        b=0WxhySN9daKKU2lwGPLuMMdmulDF/CvONrOhVY3fHmzikkGcY7CU2N5+8P9FFN5YP5
         zxbM4YBKEXSv2HTy8D/Aa7hK80+3iWzpgvDIkRDC74zZnVBtOnQm9PGjdwcL52yLonTL
         X4YmkkACoHhaCNoLy76N1JfpJv8tQP258Cw9lnX5C2RbZ64YCC6oiOhpkFlFj4hPq1dX
         tKxw1yNsUeUBpPt/0rBcDY0UA0UiT8UipB8/KqBoNnhDeVyaQDUE2zyb3dI31+XR3cCt
         ByWb/7ccEK0LH5kSj3QbThDYpXMxrCfpaKOxKnfJqy0LaaqIA1RhnfUqGbEwQrKFWZsg
         q1Ew==
X-Gm-Message-State: AJIora9SMXXnWafvLRw0bTg+F7kDcs2kGf3xYMckz4aiN+ipJOoC0ZFI
        GbdraHreLHCCJ4TbA6GD+5uVY6FF/ymFohDDQPo=
X-Google-Smtp-Source: AGRyM1vhgbcLg84tHKYETHBUMh5oFKlHaZr6FgIiU+VPQKFX+Ko7BZKFzP4dY96CDqpj8177HTfJKCFS3OuWuuG3h4c=
X-Received: by 2002:a17:902:c2c6:b0:168:ddc7:6575 with SMTP id
 c6-20020a170902c2c600b00168ddc76575mr3097139pla.71.1656140638282; Sat, 25 Jun
 2022 00:03:58 -0700 (PDT)
MIME-Version: 1.0
Sender: natodtoday@gmail.com
Received: by 2002:a05:7022:2190:b0:41:e49a:3a35 with HTTP; Sat, 25 Jun 2022
 00:03:57 -0700 (PDT)
From:   "Mrs Yu. Ging Yunnan" <yunnanmrsyuging@gmail.com>
Date:   Sat, 25 Jun 2022 07:03:57 +0000
X-Google-Sender-Auth: dlgCu7qQUJwX5nuM7tyw4eRG_Oo
Message-ID: <CANfVWTTY0D04sV8wrffpJXN8rvFf_rMeyOThUJ=3V4nW50rDsA@mail.gmail.com>
Subject: hello dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_SCAM,
        LOTS_OF_MONEY,MILLION_USD,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello dear
I am Mrs Yu. Ging Yunnan, and i have Covid-19 and the doctor said I
will not survive it because all vaccines has been given to me but to
no avian, am a China woman but I base here in France because am
married here and I have no child for my late husband and now am a
widow. My reason of communicating you is that i have $9.2million USD
which was deposited in BNP Paribas Bank here in France by my late
husband which  am the next of  kin to and I want you to stand as the
beneficiary for the claim now that am about to end my race according
to my doctor.I will want you to use the fund to build an orphanage
home in my name there in   country, please kindly reply to this
message urgently if willing to handle this project. God bless you and
i wait your swift response asap.
Yours fairly friend,
Mrs Yu. Ging Yunnan.
