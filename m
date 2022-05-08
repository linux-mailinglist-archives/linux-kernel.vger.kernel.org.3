Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A1851ED45
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 13:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbiEHMDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 08:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbiEHMDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 08:03:00 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DDEA185
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 04:59:10 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id x8so11377978vsg.11
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 04:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=q53aWBo2POLPXZIQvbuup5tJtEk9/0Okk56wj0k9R8g=;
        b=AT0L56aqiJtP8+zckxMXrydciiVFhFHW0QePYhn5axDgsRE5t8aDJWVumaD0tiCP4z
         hcowoB7vLs/IdnIvehywDO+gJ4kdPigMaUaw4FBwbwS2zdGcXcy75LVyQlc4CyappG0B
         INI4DQ0hnVLCmUL0ccAG3b6v4CcPWJQAv2INtfk81jxfYHAgz9NDYV3097gG1y0gWt03
         /8VoBUo44NQWAQmzoRiOMSmg7SReUgOrFk9x8v4ldymCjDPAkd270T3q/P7/v63aG7YZ
         b2g8RGct8x+jetfKKmwYHn4Y4WnmFCQ/PCYH2WodwSIbnjCfyfV195UjRzuos2iZ3xoc
         h/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=q53aWBo2POLPXZIQvbuup5tJtEk9/0Okk56wj0k9R8g=;
        b=Qy+TZKrZJeNmQFJFqkjVpbdr5kXSPQNykJscEWlmPzehrQ5K3rTOTguLuwJ3s5gGNh
         3qH+jDShUNpBMQ7jOFVlJLemXDpZOBpz9HNEOInwZwdJ4uue3MKBjJ+k9Fbm4iUo9v5H
         JILKCl0KZQRmjgDSxaXTzkvR4Ck5+0aUtqVj9u4bWWQ24mskrJX8AkgyBTXVwf1yRZua
         b7DakMFzRSO85OIvBMPySStWnj96/hzfS1SBdXIs4+8YE65LBkjoS2lGAPvh5bGRjoQx
         ocsrIvESy05CeZ3xpdFMfvNE14eEm/NYMSlXKfowlDXksw5BG03LP5T1+eIDiBeRC5Yp
         8YZA==
X-Gm-Message-State: AOAM531JUWZFTOTzhulN8ezZ2RtV4Me62sv1wFrLhUcT1f0lka/jfhF6
        CXJWA5gDzM3kQjd7TANZ9ohg6+viUiAsWCguA9Q=
X-Google-Smtp-Source: ABdhPJx5n7Fy6Um5EYNAF7/BbKIqgzBSafMLEvKYpWciM6Q0t0wLByFkbBL1g+4gpOLsdyHEbdVAzou5jOBK5PAqKzg=
X-Received: by 2002:a67:f511:0:b0:32c:c7d0:de66 with SMTP id
 u17-20020a67f511000000b0032cc7d0de66mr5299542vsn.82.1652011148801; Sun, 08
 May 2022 04:59:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6124:1aaa:b0:2e7:e7dd:73aa with HTTP; Sun, 8 May 2022
 04:59:07 -0700 (PDT)
Reply-To: abcl389@outlook.com
From:   America Bank Capital Loan <brianhsei@gmail.com>
Date:   Sun, 8 May 2022 12:59:07 +0100
Message-ID: <CAKN=_3OyS1bBRro4nTARx8xvtsUdx3AfdpJdkOM-FW3R-VSdtA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e33 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4585]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [brianhsei[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [abcl389[at]outlook.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Are you in need of a loan (money)? Amadeo Giannini.
