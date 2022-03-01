Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54B14C8929
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 11:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbiCAKV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 05:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbiCAKVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:21:54 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1993D8E1A9
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 02:21:07 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id bn33so21224901ljb.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 02:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=YPpWhxw82S0Ui95Y0GkaQINSCNzHySAZMXX05f1FWL8=;
        b=J9iEjwlQdQTySZjcaZijI4KLfx1niCZJdYDkC8pgurCsUFpzEcgdofwpj88P+dBYVb
         /MVzdO/sH8veJlKZDPjeQ8xr85DlOKqnJcJT1+v3Q2JZMnuCU++TbhnXK8C6J4HQvCrj
         /TOnCHisB1kO/DN0YUfgcAkk9YbgruFO+a/LQTZaGOHySHFcHe0kPtoSPlLYaiaHx8CJ
         NOSO2MMTpDsGKmD5T9QfkMDA1zRznqRkjsfLn1np5YOg8l1N+BHBblA15jdfNylDmL+H
         zRPmQBrkHZKxTurMxKh4O9XoiVIfdqXuVWk1KlsXIYZopYOkY0bUDQwdKgjDBqeHdsIc
         ew5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=YPpWhxw82S0Ui95Y0GkaQINSCNzHySAZMXX05f1FWL8=;
        b=aMHFefg8brJEtrLPpV63mLmXMaNlKAQPUPQZFOSda0l5fjFH+l/EABeWMHLBVeC5HL
         U+dtIW7cWqN0ZH/N8+T6SVmcH0ir9sg1EU35Yzj/zlrq/m8qJU1ynI9NWIpAtWiZz1r+
         jy9AB5Pd0HrM6inUBudHvbWPcEuNStCA9j/duqRMmWo9LocMpdctkc66MhiDQOzVZAo3
         K4iFWZdy5AtbJsXiGmoSuzC/CC05Oaes91x57ZJ3Qnlxzv+/AUpQOh7j7UqYFK1DvDl9
         e8ltOLt2sQ24Z2TqV15mPDHFxsQ2uj8pXFsv5OzQTxLBGTWXTR2XyTpndxnv/VK1YaXj
         qKyQ==
X-Gm-Message-State: AOAM5303v5YRwVGOfsMhoLnjwWK0TDuqBRHc7rMEhs9iQ18bLtersSFX
        hMj3lt75mOB8eqogcp5c9v+0O51YLnffmmFUnaA=
X-Google-Smtp-Source: ABdhPJz8V2EPHjb4JtZMX24yv9Tw2PhmexxrY/vh1WRLZ7MK/RuewD8KTu58d9NzRgzUSxsQuLPQIFKsBTBjUd+tOi8=
X-Received: by 2002:a2e:b60d:0:b0:246:3889:4755 with SMTP id
 r13-20020a2eb60d000000b0024638894755mr16843201ljn.387.1646130065239; Tue, 01
 Mar 2022 02:21:05 -0800 (PST)
MIME-Version: 1.0
Sender: jenniferoscar85@gmail.com
Received: by 2002:ab3:7546:0:0:0:0:0 with HTTP; Tue, 1 Mar 2022 02:21:04 -0800 (PST)
From:   Aisha Al-Qaddafi <aisha.gdaff21@gmail.com>
Date:   Tue, 1 Mar 2022 02:21:04 -0800
X-Google-Sender-Auth: Q4Ql7qsKN6p9JSoa7p2HEU19bUA
Message-ID: <CADQEMHQJD8LBzf_G3gpNJsQEXM9GLeO7xVVDwf2oQuWg149hoA@mail.gmail.com>
Subject: Your Urgent Reply Will Be Appreciated
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_HUNDRED,MONEY_FRAUD_5,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY,URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:22b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [aisha.gdaff21[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [jenniferoscar85[at]gmail.com]
        *  0.0 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.6 URG_BIZ Contains urgent matter
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.1 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assalamu Alaikum Wa Rahmatullahi Wa Barakatuh
I came across your e-mail contact prior a private search while in need
of your assistance. I am Aisha Al-Qaddafi, the only biological
Daughter of Former President of Libya Col. Muammar Al-Qaddafi. Am a
single Mother and a Widow with three Children.
I have investment funds worth Twenty Seven Million Five Hundred
Thousand United State Dollar ($27.500.000.00 ) and i need a trusted
investment Manager/Partner because of my current refugee status,
however, I am interested in you for investment project assistance in
your country, may be from there, we can build business relationship in
the nearest future.
I am willing to negotiate investment/business profit sharing ratio
with you base on the future investment earning profits.
If you are willing to handle this project on my behalf kindly reply
urgent to enable me provide you more information about the investment
funds.
Best Regards
