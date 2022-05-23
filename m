Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72933530E42
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbiEWJsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbiEWJsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:48:03 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E0A120B5
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 02:48:02 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id m20so27540119ejj.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 02:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=SUWQMmwZSct1NUq5pHL/uGOr0m/f9iWjJQkP63QJuAY=;
        b=azKjS4ElvAg4jEl6WQlDHo7TcelF5MERUE93Vh07tglEskfBGJzaA4dm7tYlBCJEpu
         OoDpY1+9kb7Wkm+kz34/kRjVPL/lFufjqRzv4X5/qacGjw5tKF7c/dojnASemfaFKdNu
         6/7U6w49cGIhs0takWebjYSVljyX1O9JbCOcLxUEDjTm9Ex2t/X4zUSURIWkyYI7ENwY
         fAUBFUKtwY0hRqPcdHgCtzdTHSQs+pwivx2M74TIcDyq5Sj5uX8sHjz+w69uEetvJd4u
         e0sJXwYVOT/k5MqnjOsOwIyttK51FUdL0tsrysEFah+nQh/w9Tk1dcvOWWGZnN48yB10
         yVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=SUWQMmwZSct1NUq5pHL/uGOr0m/f9iWjJQkP63QJuAY=;
        b=W/qoXpGJ8f8HbeWpJXLQPp/UbAS0iQm0EdLip+IcDzzG3S3Nu6UJR9yjOZzpwVpm9Z
         6tZrDspR/gKI3xvBxbS22eArcS2npthCXR9uNcpPPgpPOTdpcP1N9717DqlaJr/uP13d
         ils4QwdV1rOgq84IF4MeztAUvpyMm2vUPCXKISQlR3r1qLIYoS5YQp8p9LwVOibTrmDY
         pKiPNuaNF7WqzMbXwqGco5WgDFo25pN5CYQL8nK4BH+9wxOsHBK7fF2ERlIHiCuQp7lP
         ens4J7+q1eukCG7jbJ2gntLks0+KB9YnvcusQHXgpaPQABw9Rqc6U+vbr2SlJtnpOfVt
         1B2w==
X-Gm-Message-State: AOAM533vncM6sKWr97FkG/mDo3V/7tzLt1V41mgJkZKpZW4Rt+dr06Eh
        0+bpS4aWREoU/L72xm9dLFFY4dfv2ShfrDPDJME=
X-Google-Smtp-Source: ABdhPJxCoSAZ44xjqaMFfyEclwVl1wygPGZx+QCYSsK9/XGSWWp+P2jncZPWsvAQ5Ln6wA2UI8FuvifF8ajPmgS9iu8=
X-Received: by 2002:a17:906:9b8a:b0:6f3:fcc9:f863 with SMTP id
 dd10-20020a1709069b8a00b006f3fcc9f863mr19248547ejc.672.1653299280666; Mon, 23
 May 2022 02:48:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:6910:0:0:0:0:0 with HTTP; Mon, 23 May 2022 02:48:00
 -0700 (PDT)
Reply-To: jub47823@gmail.com
From:   Julian Bikarm <julianbikarm@gmail.com>
Date:   Mon, 23 May 2022 09:48:00 +0000
Message-ID: <CAHsvH4kEV2QS64sdij5CaguTHYByr=kEcBb-Yp4MCeF1-=zb2Q@mail.gmail.com>
Subject: Please can i have your attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:62d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4677]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [jub47823[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [julianbikarm[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.3 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear ,


Please can I have your attention and possibly help me for humanity's
sake please. I am writing this message with a heavy heart filled with
sorrows and sadness.

Please if you can respond, i have an issue that i will be most
grateful if you could help me deal with it please.

Julian
