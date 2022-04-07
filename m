Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A25C4F7FF4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 15:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343591AbiDGNF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 09:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245710AbiDGNEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 09:04:55 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFC425DA87
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 06:02:39 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id p26-20020a05600c1d9a00b0038ccbff1951so4286748wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 06:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=zePmYqnoiJyf+1Lf8/w9HZZrf5s74LQRywQYpmtC4Uo=;
        b=aOtDhxVV4qjk0xfUuYqHziiA8VGeTKF1HElejfxHi6BQbXmmCkiv8kWyP0iMKE1eoj
         I6Qa3hAe/L+8kDlFT7sD6wIyZV9D52crpKAVD4J1fKpWNCe+rvEvnhxDk7S9hUxds/Jr
         pAvnhcZA7EdhNUp7iKILsao9UF+gP3bfXsEevBuMX0XybZIxieBglRU55IH0Wms2TPRx
         WLkUamhH7AYoQeh7/RoUIIXBdAChNILAi8Bm5HnYDa6XOjyH2xmKH1xZdaAx3SVjJIbo
         AUUehMr2RCeewHPVIj+Ek0GLYfs0rKDz6hFZlR7UK6phFEWaOeFRKRhJWnsoB4jTjDbF
         ilNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=zePmYqnoiJyf+1Lf8/w9HZZrf5s74LQRywQYpmtC4Uo=;
        b=4MOIKJ8nnFNBIfFGhzekgk7+0Qrpmg2wyUEz0kDgI7dQJD51Wp5SiTvLtrHfn+VEX0
         CSM8flQBQFJdG+5UpzCinfB2+8JK6zGkcCWIM15x3ao7nns+24NKCxAYIqbaG2AAMtqk
         EhBOJvN98UdeoNgVr62ULqFtcXKEx4rYJg9EK4RfllTbobbSheZBRmCNksBU7y/uVnSw
         jcsO1Sr1ZRGWm6GDFG7lVbrqjrsTxuQgzjbqaRaVj6YXP2h+AdREYQZ9N8F0KlUxnbJ+
         +Ke+778AoaGnlaEnB4hZCiD24LMIZkc4xYGO64nvRZ8gRjCR9bPTkhtdnOEgjDWkEbGS
         WItg==
X-Gm-Message-State: AOAM533hMpSOjlfkPd7QX7iYaZdL5OcXEKY/KqprQIk3WRub2wnj6kCk
        WJgN2Xi61PIQNn2rZT/2iPI=
X-Google-Smtp-Source: ABdhPJwyfNjZTadB4RQVa25gJ8ziL0lzUyqXFZTMngsm8aIgnegzsop9odb48NysuAyExw/+jjJyQQ==
X-Received: by 2002:a05:600c:1c8d:b0:38c:db69:5759 with SMTP id k13-20020a05600c1c8d00b0038cdb695759mr12503401wms.204.1649336557820;
        Thu, 07 Apr 2022 06:02:37 -0700 (PDT)
Received: from [192.168.8.100] ([197.210.8.128])
        by smtp.gmail.com with ESMTPSA id 3-20020a5d47a3000000b0020412ba45f6sm20614453wrb.8.2022.04.07.06.02.31
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 07 Apr 2022 06:02:36 -0700 (PDT)
Message-ID: <624ee0ec.1c69fb81.402d4.61a5@mx.google.com>
From:   John Madueke <harunamusa1026@gmail.com>
X-Google-Original-From: "John Madueke" <info@agromail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re: Greetings, (CAN I TRUST YOU)
To:     Recipients <info@agromail.com>
Date:   Thu, 07 Apr 2022 14:02:24 +0100
Reply-To: john.madu@aliyun.com
X-Spam-Status: Yes, score=5.4 required=5.0 tests=ADVANCE_FEE_2_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        LOTS_OF_MONEY,MONEY_FRAUD_3,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_US_DOLLARS_3,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: vanguardngr.com]
        *  0.1 RCVD_IN_SBL RBL: Received via a relay in Spamhaus SBL
        *      [197.210.8.128 listed in zen.spamhaus.org]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:343 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [harunamusa1026[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [harunamusa1026[at]gmail.com]
        *  0.0 T_US_DOLLARS_3 BODY: Mentions millions of $ ($NN,NNN,NNN.NN)
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.1 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  1.4 MONEY_FRAUD_3 Lots of money and several fraud phrases
        *  2.0 ADVANCE_FEE_2_NEW_MONEY Advance Fee fraud and lots of money
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings, (CAN I TRUST YOU)

My name is CHIMEZIE John Madueke, I got your contact from the chamber of co=
mmerce as an accredited Investor.
My mother, Mrs. Dieziani Alison-Madueke was the former Minister of Petroleu=
m from April 2010 =E2=80=93 28 May 2015 Under the Administration of the for=
mer President of Nigeria, Mr. Goodluck Ebele Johnathan.

During my mother's tenure in office, she was able to acquire millions of do=
llars through deals done with several multinational oil corporations using =
her office as the Minister of Petroleum. A lot of these funds were invested=
 and deposited in SECURITY BANK. One of such investments is the acquisition=
 of Gold mines and bullion in excess of two hundred and fifty million dolla=
rs ($250,000,000.00) .

As you can see from the current trend of events and change of Government in=
 Nigeria, the present administration and wicked enemies of my mother are wi=
tch-hunting and accusing her of bribery and corruption. She stands to lose =
it all if care is not taken,  all that we have suffered for. I reject it an=
d will not stand by and watch this happen!

Currently, my hard working mother is ill with cancer and battling for her d=
ear life in a London hospital. As if this is not enough suffering already, =
the British National Crime Agency has arrested her for questioning on these=
 corruption charges.

So read the news below:

http://www.vanguardngr.com/2015/10/diezani-alison-madueke-arrested-in-londo=
n/

I will want you to help me secure my mothers properties (fund) so that we c=
an invest it in your Country. Can you assist me? You will be greatly reward=
ed. I believe we can do business together...

Please reply if you think you can be of assistance and we can establish com=
munication. l am ready and willing to divulge more information to you upon =
your positive response. Please let me know your thoughts.

My best wishes,

CHIMEZIE John Madueke
john.madu@aliyun.com
