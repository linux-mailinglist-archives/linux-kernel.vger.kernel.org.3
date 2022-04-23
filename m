Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E46550CDDF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 00:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbiDWWIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 18:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiDWWIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 18:08:48 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC671656D
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 15:05:49 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bv19so22735066ejb.6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 15:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=WiFwTh79e/vDiEl2X1EIBN4kgkhCfNrDRpDpgRmEVDk=;
        b=GpuB+1ubhT2BD3XCTrdY/EqBZmMRTF4U5R6sqoE2ix7rWg07Yv9Mp1Z61AVrv6zGa+
         pKUozdrZj+VQtsADxvXQsWyM1hLUCn0+kRfmDfGkOsncvBAaSfd5VCVG6P8SbbznP8tS
         QhYJp7xyoYhYFbULOcho7W5wwzuBZAXP1MWa/Q16ZR0pvf7rqgxobG+m3lrA5RPQi6SE
         7E3IqW/C9y7ta7/CNuDbdMkBezqImjCj9JA2Fi4sXlBIxM0IUvdQcOPlQNz5n03sfq/b
         TMv0Md2vqhka2Tj6aN5a7bW+hFJ/3QFh+v/Y+O6oXBtZQZYEOjf+VoUn6eE2bCx767l/
         Fp5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=WiFwTh79e/vDiEl2X1EIBN4kgkhCfNrDRpDpgRmEVDk=;
        b=bgkNac4GykFOQCTkbUhqwjTr0zGCvoKuV7eEFM2KpT+ggAG9ylDxMmd6HHpIx/Kaqa
         xR7hG+BzJ9MiVizqHJ+uzv3WX0rm78ItcHB/QtiRHxfcOCuer0KyfXAeM4hXtVnJPRSD
         1JTY5zCUj5DSPkjdReT6Bt5i7BcEfvTumyHibQV3zQ9+PRmYj0fuPY95QLvDIj0NmUhX
         4lw2mQ8ExOLvqDTPPYa9NcqMRTDb90mSM3uG1BL4Yam+Ukd50MIfRs0MwkIbEr77kNG9
         0y+y6+Yp68F+6yAgveLFJob/XjOMmuoS+NfWOTI4VCvQ1j1RlyQDc4g2ZXWbsrSv15DY
         vLIQ==
X-Gm-Message-State: AOAM530ItzWVYQ+/ZGQCILYupn35Uf4fA1SJYTX4uTJ7Ulpot2nQcURb
        YGuF/+xphn46F8C26nmaycKOLwpSuoSraryfM2U=
X-Google-Smtp-Source: ABdhPJzWuO26zWYAGqo1A1d8yoxs/IYnTcT34lSOkxx8xs5sazLfklLgF5fElBPmpSpErpmgqvj/3AsxvbR5wosmNxE=
X-Received: by 2002:a17:906:c0e:b0:6f0:2b1e:9077 with SMTP id
 s14-20020a1709060c0e00b006f02b1e9077mr9759059ejf.411.1650751548262; Sat, 23
 Apr 2022 15:05:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6f02:39b:b0:1a:6c4e:3ca7 with HTTP; Sat, 23 Apr 2022
 15:05:47 -0700 (PDT)
Reply-To: wijh555@gmail.com
From:   "Mr. Yakubu Abubakar," <yakubuabubakar1884@gmail.com>
Date:   Sat, 23 Apr 2022 15:05:47 -0700
Message-ID: <CANt38eu7083QKs-K6se4Mk2auKWth9igO_cs==LKBt0HOnyG=Q@mail.gmail.com>
Subject: Good Day,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:633 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4906]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [yakubuabubakar1884[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [wijh555[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [yakubuabubakar1884[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
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
Greetings,
I'm Mr. Yakubu Abubakar, how are you doing hope you are in good
health, the Board irector
try to reach you on phone several times Meanwhile, your number was not
connecting. before he ask me to send you an email to hear from you if
you are fine. hope to hear you are in good Health.

Thanks,
Mr. Yakubu Abubakar.
