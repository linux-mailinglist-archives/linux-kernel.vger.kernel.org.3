Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353255775D9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 13:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiGQLCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 07:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiGQLCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 07:02:02 -0400
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44782167FF;
        Sun, 17 Jul 2022 04:02:01 -0700 (PDT)
Date:   Sun, 17 Jul 2022 11:01:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1658055719; x=1658314919;
        bh=gAVUIwHW6HFaxqYl2aNftxgq+8/oofJDopJ5uC21t/s=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=J99HcnXitoeHd0YR3kuTe0cMNLR3HE4SFofgkZecCNs6Ckh9zxLGNItP0THSwR7cA
         IlTu9tW69nhF95mnpTXCtfeVGdFZ+irF0rKBem6dxn37B9PjLVayMztIgbI3g1U59z
         NsV7clEcPsPdNxq1TKhdDt+OaSuIehRDXjgynSsn0wZ/+2q/D7YAo69x8q7OBEgdnb
         DQI1m8R5CiF7Gukjdn+woy8/w6zKpst9RxGBaOjhygNiV0IaOHiD09UsdbGKnR3u4y
         zMxL44WlVbAOCOTFJw+GA0U5Ahe76HJPguxIkgZlnUs9iJbVN/S5o61WogDu+Fayty
         iVNl7pZqsN8BQ==
To:     krzysztof.kozlowski+dt@linaro.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, konrad.dybcio@somainline.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        nikita@trvn.ru, robh+dt@kernel.org, stephan@gerhold.net,
        ~postmarketos/upstreaming@lists.sr.ht
Reply-To: "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Subject: Re: [RESEND PATCH 1/4] dt-bindings: qcom: Document bindings for new msm8916-samsung-e2015 devices
Message-ID: <20220717110020.6186-1-linmengbo0689@protonmail.com>
In-Reply-To: <20220715102055.3844-1-linmengbo0689@protonmail.com>
References: <20220715102055.3844-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, July 15th, 2022 at 10:00 AM, Krzysztof Kozlowski <krzysztof.kozl=
owski@linaro.org> wrote:
> I just received one patch, no cover letter, no threading (I asked for),
> no changelog against v1, no binding updates (I asked for).

I have had them all in a thread in latest resend. The v2 was accident.
There is nothing changed except dt-binding added in new commit.

> Sorry, the process does not work like that.
>
> You receive comments, so either you apply them or you keep discussing
> with reviewer.

Sorry for the confusing and inconvenience. Please have another look at my p=
atch.
Thank you for your patience.

Best regards,
Lin
