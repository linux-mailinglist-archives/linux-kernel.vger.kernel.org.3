Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406E855F1CE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 01:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbiF1XJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 19:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiF1XJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 19:09:25 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E716620F69
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 16:09:24 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id n185so8240479wmn.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 16:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=8L3u9yLimYhqEYiPckuKAsVAuSvOnpygme4DEwcN/0I=;
        b=bG/G7jA9Y2U3qi6yyck8cysBllHFyXYKlkCWnhclAWbfPdEuOFgCGGDqxH/WgMWVaT
         3mGKqcKFEClHKqfu6vKxyqXWoqLzVcUJHzm46IJHtvbDOw2gVLQvQA/zJYocdPOzJQLB
         oP1FrB1pRRwFsVCW319cBYCD6QwwDjE/nPhmsQ68YCFau2Rm4SIH6c2FxB0Bg9ZhBOWe
         1Mb7tAiz7grGF5/yb+6ExitRzqf5ETriZ7bwXgBfHBFOv8+TQvKMZNJg6DZGTXwhE8SH
         toz7vA+WIp8ZWAsDIhdiXKjjNXvEk/fwIoKVlgXclt1X1CwIv9P5ckuVvp2Id1dEMXAs
         E1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=8L3u9yLimYhqEYiPckuKAsVAuSvOnpygme4DEwcN/0I=;
        b=33l8iukUzLTJKBOb0HpxO4IEeRRndr6pbv8uqOnVKCoRODb6sU7STEo2pzrGk2Sj8h
         J9xgOPnaBSXXxN4DY3XFO7/S9V9S24C40yZoqN9hEhIVW9RTcK9UJ7uqh4WDCCEnNuTm
         vz1HeIbhUg8RvefHQ2WqkVcAvKSlMjrvs7wEn8xs/62gtEBvYIYfAWk4/73JMozN5FA4
         uG8qEuuVDEWOOsQkmEbxJsyZqM6OlOV7bmKcAAWeXn2CzPgvgwOu0gGaCxmLh2U5z9jv
         VUrf6/UgB77qPAA/yTAIt4isdNRgKzNnN3XDJ9eNnlKJaiAR2ruwhZ2mNX+Yq5lzfT2Q
         PBHw==
X-Gm-Message-State: AJIora+adk1rQA4i9dfkEXFMyZcRsRc8Fir76JqU0u54R4RmzlJ7VEg8
        IfwImvcSzqe9tcyu9vYAlPBbHBaWl4XXmonA3zA=
X-Google-Smtp-Source: AGRyM1u0Qjvj6JUKUYk1Hbnsfzfu5MSBUpQPgt3zMbfPudhmluUkcEGGpiLH1N/B5nqAA7Bgs2mJ14mZhDP1VFDjCLg=
X-Received: by 2002:a1c:6a04:0:b0:3a0:4ddc:9a4b with SMTP id
 f4-20020a1c6a04000000b003a04ddc9a4bmr279169wmc.78.1656457763183; Tue, 28 Jun
 2022 16:09:23 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mayumisakimoto7@gmail.com
Sender: richardbirdwell2014@gmail.com
Received: by 2002:a05:600c:4f94:0:0:0:0 with HTTP; Tue, 28 Jun 2022 16:09:22
 -0700 (PDT)
From:   mayumi sakimoto <mayumisakimoto07@gmail.com>
Date:   Wed, 29 Jun 2022 02:09:22 +0300
X-Google-Sender-Auth: r3hcUEa00cVTCr_aoZvVSl1oImo
Message-ID: <CABHb6oZZDTx_Fg9cWztHqoH2F+Gz60M4F2OKC6EFfvSSF4cjOg@mail.gmail.com>
Subject: Urgent Reply
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM,UNDISC_MONEY,URG_BIZ autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:343 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mayumisakimoto7[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [richardbirdwell2014[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [richardbirdwell2014[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.6 URG_BIZ Contains urgent matter
        *  2.4 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.5 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

 I hope this email finds you well, Please accept my sincere apologies if
my email does not meet your business or personal ethics. Please I have something
very important to discuss with you.I need to entrust you with a
humanitarian project, Please reply to me as soon as possible.


Kind Regards,
mayumi sakimoto
