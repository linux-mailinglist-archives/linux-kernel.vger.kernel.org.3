Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0FC57DEF9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbiGVJs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236774AbiGVJsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:48:17 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18249FF6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:45:17 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 17so4094722pfy.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=P/B2DayRTBF4502AmlTti3xwBWyIvpd694cllKH7GeU=;
        b=FGq9P+5zI8n16dIxsyx5yWnD8EyNM1VWPvzzGED7CBM5ePttwGqp8KsfBHBxIsGXeJ
         j0OVTp7IZsb4q2A3FGK8tXGmH6U4iDJ+MyqNpDQ3thmTpIMwf/P/Q9RupHQzzM5f5quJ
         UjoaYX3Qp78srfF0AZEZiZhWvnqYXd8oF/O5hCMhbrepJmMuoF30jG1CPzpXSjtfqBj4
         36n29L55Ksl05itMfWiI5BbCd/dj1LiN46MPT62qw+FWl+Cp0nTifDBvv2t5ezay1wy0
         xi1GH6RxLmN9wvCML6JVlpM7ioG0t+WOIcbV8uVceNtbMPBZuOkr899OyP0MYNmxL310
         RbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=P/B2DayRTBF4502AmlTti3xwBWyIvpd694cllKH7GeU=;
        b=W+3yGtXeejcV9pf+ajHJhAz2yNZWsi8GvMe6YQeLHZf3+k0EXMlJC7d27qLw8lz+r6
         NgIS3cJMwUNmWEXaGaQyHLvqjjM9RjjdjTCDJsfNevB+5eGL6OwKY3pNKEHb0nizH5lz
         viRKuauqDhbPgod6RdXD7xUs7l/II7WKGKgGWH5uh/ohAlQZLHKg2cqPuV97WkjkjVYq
         9DdYlBCQ7X8l/DutbgRmcjoMzQQ5N4jP7rAkmdxZIPypMGQc2RoPQS43uVl/CW+A3HEu
         YSh8Y4BgBl4d7rNzr+H/knqhuO+sfm+FxpGJstcA77Wcwt5HYqQzinqr82w1G2XXCNXu
         zCIw==
X-Gm-Message-State: AJIora+1FqxIErUnIy02/LQaNF6zKUqszKHk3BXBAv1ibPns+7OqtIAk
        KawwF2ZBJXlBn/h+nNx1ey4WEEQBViyA81BLKdQ=
X-Google-Smtp-Source: AGRyM1sDI670qNYf1rcf6SrsXNEo/E7He4cYBEMbvPUqyaN+TlW8I9vsuLHNIVTvILP+k/YEafa13MUPTGR8FyJgTvs=
X-Received: by 2002:a63:31c8:0:b0:41a:625e:7d77 with SMTP id
 x191-20020a6331c8000000b0041a625e7d77mr2443226pgx.246.1658483116106; Fri, 22
 Jul 2022 02:45:16 -0700 (PDT)
MIME-Version: 1.0
Sender: dr.alitrouni@gmail.com
Received: by 2002:a17:902:f54e:b0:16d:2967:1bf6 with HTTP; Fri, 22 Jul 2022
 02:45:15 -0700 (PDT)
From:   AISHA GADDAFI <madamisha00@gmail.com>
Date:   Fri, 22 Jul 2022 11:45:15 +0200
X-Google-Sender-Auth: IOsWD85pTrsB3-KEKrjLznmMnWc
Message-ID: <CAE+xecCs-Z_PX3zrqB2t0Lu_pw-EKyyRiCCUJ8KS3Uo3QRschQ@mail.gmail.com>
Subject: i wait for your responds
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.1 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:42e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5005]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [madamisha00[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.5 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Have a nice weekend,
I am Dr. Aisha al-Gaddafi, the daughter of the late Libyan president,
 i am contacting you, because I need a Partner or an investor
Who will help me in investing the sum of $27.5 MillionUSD  in his or
her country?
The funds are deposited  in Burkina Faso, but I am living in oman for
the moment with my children Please after reading this mail try to
contact me through  this my private email   if you really want me to
see yourresponse, Thanks, I await your response
Dr. Aisha al-gaddafi.
