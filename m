Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4227B546CE3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 21:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350398AbiFJTCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 15:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243528AbiFJTC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 15:02:27 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20292ED912
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 12:02:25 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id g2so115447ljk.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 12:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=51RIadb6uMG8qQNL2W77cS297AVcIqUghNiTlwSKJng=;
        b=FiPYsscMlQl+BeMLe2HxazVfp2jVvqGd7sTS2ISdCOctWEMMKoeYeCgdDRoS3Cibi7
         AO8CMHWd16nSR2uWtZXYX/er438h/fjpyyfRx25adtondU83DkIzcJUWrzYh8AQGnqNO
         op8BwHS8lqWoR2AnNpZ4mOEKQu2wMHQiDIdvDYw1yumTfG35s/zI9UHY05Z1+lXDLO9H
         zaG5azzGBjKhp8YvssncuaaqP+219M5ceKymhaprFG1qozT9CRFwXjWHimPEBC7owqkd
         EmkMvkbaMK3NxI4N3uQ3bxUeQActwy2C0lU5/LNyq8PJeGSzOzXstyM5ZTeWW9TwPi/i
         V+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=51RIadb6uMG8qQNL2W77cS297AVcIqUghNiTlwSKJng=;
        b=ZLmft3bnTJT3QiQmh2gk5qBX3XWIo+vgjLQs41Jss5Bx5hbAqzceerXblYY3GwzfTt
         HPJY8v/TKmLyeuv4pToomh+ASOzFtCTSM1UU+sKHgyJKqz/soyw2JDZ37qDlyHxbpOLv
         S04EVJ0/82bYYCR3VsBXg5LCmeL4CgF6fVtA37BUPL511YvwWcNtJRG2q4k+UM52veo7
         6pVIXYXAeys+usk4qj1V7SuiSHa+0h9rB8/TezrzWywwfcpG8kWAXvlTqOOq4pLNtjFb
         3+OqNqa0tECvi++yJ5xZtJFpeJbW64s5pl0I91JA7Tkm0WgUsa+ezwLtMzkaYraFIGIV
         LQAw==
X-Gm-Message-State: AOAM532ovdM1fh37t1wPMbypmlyHdrAwGfmPcsSTWv6Rsh2wu8MjoDzV
        vCSZ4k1q1q0vpEO2zxakhHHKV/6RRhPn4CAvfmc=
X-Google-Smtp-Source: ABdhPJyBr1vZIZ7rozTSJdgpcgqVGna5k9FJe4ct8Ajh3+8OHzK7APbZduIwADFfEmX8YjKjj9GVeMQbLwcq/OmN0Ww=
X-Received: by 2002:a2e:8501:0:b0:249:17a0:ebf8 with SMTP id
 j1-20020a2e8501000000b0024917a0ebf8mr63484834lji.125.1654887744099; Fri, 10
 Jun 2022 12:02:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6504:3b2:b0:1cf:75f8:15f7 with HTTP; Fri, 10 Jun 2022
 12:02:23 -0700 (PDT)
Reply-To: nelsonbile450@gmail.com
From:   Nelson Bile <lynchjennifer099@gmail.com>
Date:   Fri, 10 Jun 2022 21:02:23 +0200
Message-ID: <CALFOzozOFsTR=TzV-uUPemEBDPsqu4ppvOuw3Dopqc5REDP1fg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:229 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6051]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [lynchjennifer099[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [lynchjennifer099[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [nelsonbile450[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.3 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo, ich habe dir vor ein paar Tagen eine E-Mail geschickt. Hast du
meine Nachricht erhalten? bitte um dringende antwort
