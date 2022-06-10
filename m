Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E7254627A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347276AbiFJJdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbiFJJdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:33:05 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0084D6357
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:33:02 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id i66so34892954oia.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=vL9FKWf1eJshAufhdQmT2nBjoi8ltf+kqDBvIZzqoeo=;
        b=ffIp4RxOet4477io+Qx1M7/G57FT1rBYNVe4OmpFiE8wDPhOglrs2VXGf5k/g5Em/3
         41/WM5XE4OE5EiPauQGDe+SIy7whGLAz+lyXfXYefQI+dAMGkQh+ZdpbooAZj9IDbDHA
         ffOVoccTk9FS1GxCvg/G35exeOQfxniEce2tesgjGa32IziWs03r2SDbIrIl8FAq/TSV
         a8DZuoCzpVs5+FQgm2X/X/BWS1d3tMvWn1Eq3sjcuU4aAbnSyK3JSprZbohIt1xj0htb
         ehips994aW9PmPqZ2o9IFIvwbi1yihDWT+lxq731UHBdpiI/8cfgEDZ7KG4OzaQP7ruh
         v9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vL9FKWf1eJshAufhdQmT2nBjoi8ltf+kqDBvIZzqoeo=;
        b=OP9YnB+jG4Gnd9W4QuJoaAZXmUF6ylmvDzuVTPPVNvEvCbVcbVXcdfQ6xYrcYJcsyW
         e28/Pm6cj+Dtbk0PRUKTmD0T/Nm23eahTkjC4eMWU5IHl2gL/r1myE6mhkmKgFGG8P3o
         BPWYOgaGd/QDfTHwE947/p6QrZiNDAbXAPXCoJ7qvNC6tf2Oz/5jQ+ODohEkVkgpsbhS
         h366Bscj9nyTfTMjuBeAZavD3bu7DwsJ7pumpPuTFNqAT0rISG7dgW9xYBVUrrzw7R+F
         glHSfV3Wair4bNBXDHnKiWuwzPb31YsvZ7XkFdLatNmqCzuqCjlpyG39r4RrR9Sc2Gzf
         eSyg==
X-Gm-Message-State: AOAM532CXU3UNRnqT4HKtUVSgOmJjVi7x7WSLuyY30R5fTrF5qsRMBv/
        rtczJxQ6ia8us83S2vWBNDirh6S1yye8z3dvYKw=
X-Google-Smtp-Source: ABdhPJzwduJ1yhdFFItGgTw3FQgopem8MD+bac+LAiijWk3aJOzC5BZVxkP5qbMZaAJwR2FvKVr3nbhFfB4INFPLVpU=
X-Received: by 2002:a54:4607:0:b0:32e:d451:5c9f with SMTP id
 p7-20020a544607000000b0032ed4515c9fmr4121155oip.46.1654853582340; Fri, 10 Jun
 2022 02:33:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:d5c8:0:0:0:0:0 with HTTP; Fri, 10 Jun 2022 02:33:02
 -0700 (PDT)
From:   Frank Hughes <vgcxdd1@gmail.com>
Date:   Fri, 10 Jun 2022 10:33:02 +0100
Message-ID: <CAEXCZNO66o6iUizYMuQ1NDTDC3f7evLrxov+89s1h8OXSx0Stg@mail.gmail.com>
Subject: Good Day,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.3 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:232 listed in]
        [list.dnswl.org]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  1.0 HK_RANDOM_ENVFROM Envelope sender username looks random
        *  1.0 HK_RANDOM_FROM From username looks random
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [vgcxdd1[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [vgcxdd1[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Day,

I'm Frank Hughes. a former commander during the US Military Mission in
Afghanistan. Now that the United States has completed its mission in
Afghanistan, I am currently in Syria for more assignments but will
soon be assigned to the Joint Multinational Readiness Center (JMRC),

During my mission in Afghanistan, I was able to make the sum of
$25,000,000.00 Million Dollars. This money came from an oil deal, I'm
a uniformed person and I have to present someone as my foreign
partner. I am an American and an intelligence officer. I have 100%
authentic means of shipping the money through a diplomatic shipping
company. I just need your acceptance and everything is ready.

Regards.

Commander Frank Hughes.
