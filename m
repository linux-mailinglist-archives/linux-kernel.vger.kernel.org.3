Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0337B4FE311
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356169AbiDLNtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349515AbiDLNtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:49:00 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D61053E28
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 06:46:43 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id i27so37455748ejd.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 06:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=mTe6rsF1WlocKfWRCIawejpNJl6lRYSIlYxDz8jltlQ=;
        b=hM7BO8dCSw5pItsxBnVyn0Gajj26jifGRtPyfoouTAHcytDw0y/HXjvBRNH7yYXCWt
         pj3KhrNIKoWQFg6+pcxIWBSiSEWDDQbLhJlHXhMJoVdgy7AHb+SagP5RnPy3TTWTTgCr
         cax0OQW9IKt8x94Ap5LPL+tat4qk0lLse86y1hC4Y8Pogwj80bniDixCiKrdexbqzY40
         utL4SWX8on5pnPd8ldNMbz2M1cIh2ZutZh7q0v6p9HNVKtruGkom0zwAgfn684+KloUA
         x+tI7DVkEM2itRwuL7ZJ6YVfiwO1W0nsdVUPVE3RoSmL7xLAjIcAbPggSwdYvQL6hgv/
         KzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=mTe6rsF1WlocKfWRCIawejpNJl6lRYSIlYxDz8jltlQ=;
        b=K1EilzS8kKSRBvYfBfgAYRVZ1RCML2mcVIpGlBeO7a1pQQ+A7dN8rAQGNd3SxUHXhF
         JUJV212zJEG6qf1vC7H1GyG8b5CnGuwZFo+hPtPD8223E9oO/gPV7459swC0hu1bT4NQ
         pcNwAD3PMcpV0VFY+1T+K+P4uoWlv/D8TeFi+k9NbwaSwq4bNtdZaSGDh6UsjNrQ76dO
         OSzhITl0jn27FpGulYOK6tszO5Z9Ptje9D9ztiqNd7vF64ahhPoSVY3gya4CKYFZ97Jq
         8TpcTbRaHJeBDOmlJ13Z7xp1xgwlia+wQdOaM+ylcy9NNIX/Rewqk0/w1VVbcMd3Zdpr
         jwbQ==
X-Gm-Message-State: AOAM531ilBfshwqH3YQRwRCYxAnL0aShIj3XzIA4r6Jvw523fS5U2N9N
        RNCjS0ELN5BbQgt/Wyob+rJrmo7furn0gCRm57g=
X-Google-Smtp-Source: ABdhPJxgDII2j6kDRF16ra9GiID9M7WhQy34h4mFcFpswL3AkR8xZr/9cxX+5fvEb2/uxl1vlhHmKI6xYbcWSPgWlDc=
X-Received: by 2002:a17:906:a057:b0:6cf:2736:ba65 with SMTP id
 bg23-20020a170906a05700b006cf2736ba65mr34594674ejb.171.1649771200214; Tue, 12
 Apr 2022 06:46:40 -0700 (PDT)
MIME-Version: 1.0
Reply-To: zahirikeen@gmail.com
Sender: mr.bellotom1@gmail.com
Received: by 2002:a54:31d1:0:0:0:0:0 with HTTP; Tue, 12 Apr 2022 06:46:39
 -0700 (PDT)
From:   Zahiri Keen <zahirikeen2@gmail.com>
Date:   Tue, 12 Apr 2022 15:46:39 +0200
X-Google-Sender-Auth: Sple-LCSqW2PjLkSzii6J1h_CCY
Message-ID: <CAEF+kN9gjs125JPghi5Zqkxe62D2jE=FS=sodkZf=z9tyuF64Q@mail.gmail.com>
Subject: Very Urgent Please.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:642 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mr.bellotom1[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [zahirikeen2[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Day,

I know this email might come to you as a surprise because is coming
from someone you haven=E2=80=99t met with before.

I am Mr. Zahiri Keen, the bank manager with BOA bank i contact you for
a deal relating to the funds which are in my position I shall furnish
you with more detail once your response.

Regards,
Mr.Zahiri
