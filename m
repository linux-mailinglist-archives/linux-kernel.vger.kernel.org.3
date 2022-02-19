Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276774BC6F4
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 09:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241725AbiBSI10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 03:27:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241617AbiBSI1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 03:27:22 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908A9541AF
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 00:27:03 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id cm8so9706725edb.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 00:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=qzbieaFjfsVFljkLJ49gac8TbIdA1Ej3bCRvWn8o1iY=;
        b=WTWF+Mk6bIdQkkFPKaxfvcDds4WAa6LOPSRRBxqBH4q5Ev7omIJBG6Cf6yAjNGa6C8
         JNOlCR2wAY6QcKt7uIvu9xoZv1bvYtXIxzk0+bUlWxgws2+H5bL6LfdPPn1lNEDt8yFO
         RaoObV9KYk6L/4voh7FoZTYuIeDjSthHzQMEbuP1cJUlSBfW2apH8AQw/Hf7pmx4FK+y
         YdrfQdkh0L+p84/kdIGNesCLmzSkVXKqY8w6QnZBbkplEWMVXeePFZCIFnqVYZ2qXZ7J
         7oNbzIjEUiSysrk0n7ldSyy52L1iwVAGTKXFwnyw+jPShqMcM1ABNO5QNWYOiAtt4hBd
         7bqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=qzbieaFjfsVFljkLJ49gac8TbIdA1Ej3bCRvWn8o1iY=;
        b=DD1202hDd9q07wI1s9ni/oHwo+TE0+UswV/Dff6krL6BhJi1qOwKVaw4Tn95II9Zq/
         efocNlC+9ep8ocs6pYgu+8xaLUkPqkQNxmFzqCkk29W5IisiSf07JdjsXS9sXC7GLTmS
         wAcJb3Eyg//4f8brSZR7Jh8fSmUFziZU5w5a+5i6IKhC4cw1WXkvxEAwDCQtOpf9RNZa
         GLDqStstNWSyD+EbCIoe36WjM+1xBSBNbD+KORlUOF9ic4e5eBBDMCbwy5I95+3eqp7F
         MHLQMjf8SKrsJOx8iTmyIRmWhj/vDSGY9m7ZN1FdcA6DlFURwUZUx6cfZzuoT9kMsmJE
         tLMg==
X-Gm-Message-State: AOAM531aCJZdV1ONbK0RHB61KyJCo/fuZal73rOYhw/+1MEHYx3omSXZ
        s8jcjtNwcOEHJgNt+Gea3xPyrDqO/GZ5fq9Sa08=
X-Google-Smtp-Source: ABdhPJxGTm4dX2fxcZkCSmXAvazshr7F6Mf/y0L+NxuNWMS5/6kJ3TyD/L+aabjRpMy0EO4f6vK1XMyz4i3v+8Dv3NM=
X-Received: by 2002:a05:6402:51cb:b0:409:e99f:bc1c with SMTP id
 r11-20020a05640251cb00b00409e99fbc1cmr11861563edd.68.1645259221763; Sat, 19
 Feb 2022 00:27:01 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:907:8d0a:0:0:0:0 with HTTP; Sat, 19 Feb 2022 00:27:01
 -0800 (PST)
Reply-To: felecias261@gmail.com
From:   Dr Felecia Smith <ta.william11@gmail.com>
Date:   Sat, 19 Feb 2022 09:27:01 +0100
Message-ID: <CAOoCsS+wmWGxOqKo7-uujJGPxL_TJfa2f4aRTKy3Y=qyWZm2FQ@mail.gmail.com>
Subject: Dear Friend
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.4 required=5.0 tests=BAYES_40,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:531 listed in]
        [list.dnswl.org]
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3675]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ta.william11[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [felecias261[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ta.william11[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dear,

how are you today,I hope you are doing great.

It is my great pleasure to contact you,I want to make a new and
special friend,I hope you don't mind. My name is Felecia Smith from
the United States, Am a french and English nationality. I will give
you pictures and more details about my self as soon as i hear from
you.

Thanks
Felecia Smith
