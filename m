Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5AA505E3C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 21:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237227AbiDRTMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 15:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiDRTMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 15:12:47 -0400
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE63286D5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 12:10:07 -0700 (PDT)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-2ef4a241cc5so142340507b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 12:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=WNY1ShG9lla/OuLBtEEoqdci2IRdQPcu4ZEDdmrUwVJVPQP6CdxKq8uXAU3T9uO9Af
         N4ydYe3xQb5ksn64E0Ay8col4hjpzakukGo6ZLxzjt+rC7O/o/Qy6JftT4Ogm0yeJ8dv
         7XZ937L0YbRWjeXemfq+NzEtdqT1RInzc3QquGFEIQcxQwDVHAeDybSUsDnmvFD+dGMp
         GYtia7ETGQQ8AdVVdIl5FeDlNqbEI7kIsiqVeYatWAvs4g7s8CHXoo1e6As42caiHrHY
         L/UyujgdCO3SzW53+NBbpZqn2hH5cT7782Ajo2beVGrM+vD7hQZwPY9Z/SiIo7t/G/ZS
         4fhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=Qiy8BFA9ATxXjyF0WNeGoso6N9rkl4FCvuWshNQfVTWJkhuG+lCl8lympzw9dChSLV
         QY1MnwtmyklxW+Tf1Tt7P9I6mZQW+qnICPhcSOFqn3o079VXyfKlcd9VIGqeCWAwQYAn
         upw6k4GKPoLCp06QasOaQTBywiqw3AhTdeFWMVOT3mI7PILnjX/kF4xHz2J86VhAWZ1a
         DBbN+9gpy0ChgaVp2R8z14ai1y3HzSH8GO8FU23jvE/NaLYmuv7UAbj2jXxxcsmaLY+L
         wCOhqCnjM8b76uN0HA9IEoxpeURs4rGhctIgdfrikt9CtSl7vRXmYatK3oTJC53mPHE4
         sDag==
X-Gm-Message-State: AOAM530JTub2oczVRn1Kstewf1N4sG8XKuCzP5wbnYixzg92S3b+SgH9
        iX13azdEuRRjokke9DS6Q3TsPblyxhyZttMAd/U=
X-Google-Smtp-Source: ABdhPJwQw9YtRtbhpCZ0YosRa0RafAMUJcpYmDWMJmizKHBlhLL7KI9JtZO8c2aHiFdEoTAQ8EAPn//VvTTMHfivqDw=
X-Received: by 2002:a81:1d4:0:b0:2eb:1b10:f43e with SMTP id
 203-20020a8101d4000000b002eb1b10f43emr12141474ywb.100.1650309005262; Mon, 18
 Apr 2022 12:10:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:214d:b0:175:2105:a7fb with HTTP; Mon, 18 Apr 2022
 12:10:04 -0700 (PDT)
Reply-To: dravasmith894@gmail.com
From:   Dr Ava Smith <avasmithsun@gmail.com>
Date:   Mon, 18 Apr 2022 20:10:04 +0100
Message-ID: <CA+T8hba3Hw5vqcDaSehE_Vmyt0mJvJJZzm-c=V5qNypjJLjqVQ@mail.gmail.com>
Subject: HELLO DEAR
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1141 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4806]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dravasmith894[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [avasmithsun[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
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
