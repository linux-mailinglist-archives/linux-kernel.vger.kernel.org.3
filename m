Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588AE4DE737
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 10:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240987AbiCSJZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 05:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbiCSJZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 05:25:10 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAB01D66FF
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 02:23:49 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id g24so12810628lja.7
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 02:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=0K96R68hBgO1EWLqzQ4BAwW3O89DvHEgV0QckNXXgTg=;
        b=qdB07GM2bAjF/zZ0GVRknpXAPBlbm0aYCvWp+IeSENBAWaV9eKSgXnFC5myVk1ntCH
         vmQRRsEl1VdP+BcBa/hBkZ1yzvV7xajFubDldlCymCc2xPhE0/c8iQ3q5CQHyFaNFZMA
         KPDK4hlhc7V1RY4q17taQf2RSWv37zj2fOeN+y2nn5CUHRHdRaVrzZYDtM/0zzyh5+20
         MUI5CfvQUBlFx8lnnTbORL7UFSgnJGj1GOI63ybLKO1KClCkmoEYrY+5gL7JLVPRZ2lY
         dnFyyCRdcxELy9y1zqnVDq14+DqeG5ebBONVCpTCQRcQd76eyo7q/dll+NEsSWtb9B3p
         5hFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=0K96R68hBgO1EWLqzQ4BAwW3O89DvHEgV0QckNXXgTg=;
        b=cg/2iOvWGnh0C23WNhXclKC2p2wt6oUBbCzU56GgTtp5Jp7clG71o312ScT0MnSHD+
         o/0241fqGvvLMBB3PbNxGwB9ce4cxBP9xT4JVctKjp5VuIgr9qkc9GPI8/6HzwcFyblH
         yj8dnpmNfO4SuN6/0PhREgtVm/A+NWrT724esUnBP1QSwkQjtxaTirXKzspIIYc/aACN
         tWZE95ofHwSygtKPGG9dTUxGqWYIovqZZ0toME4ZCkU9Q0Evn/AdpI+dTrt4PxtyQX8S
         gSAAYqEu4iJ3NeVcSVIJGoICqNbizaF0vUe9lfvdHTQ2wutE5MLrH7FjGHPMqv1ihiod
         iBHQ==
X-Gm-Message-State: AOAM533vIO93L4uV7LpQ+AOWo5WcElyl3W/KUOrYpwvF5AnMdBp1mBjF
        rSi/qg+egAgN9/5G1Z7DtJZ2vNiyHE9/Ib0SHxI=
X-Google-Smtp-Source: ABdhPJxKRmY+jXte72HbK0Wimz4C53wkQYETYKtQ0Uz46y15xXGhxXOtEcJbInfEO/NPKFaNdB68LutwJ4skzzTE//M=
X-Received: by 2002:a05:651c:a05:b0:249:7cbe:5d7c with SMTP id
 k5-20020a05651c0a0500b002497cbe5d7cmr456372ljq.207.1647681827473; Sat, 19 Mar
 2022 02:23:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:651c:545:0:0:0:0 with HTTP; Sat, 19 Mar 2022 02:23:46
 -0700 (PDT)
Reply-To: susannelegitfirm155@gmail.com
From:   Susanne Klatten <babalolafaith008@gmail.com>
Date:   Sat, 19 Mar 2022 10:23:46 +0100
Message-ID: <CAPgj9+KMeVjj21C=4JGFaU53OVtf0+GpKZJkvmRBbLtJjXgA9Q@mail.gmail.com>
Subject: =?UTF-8?B?UE/Fu1lDWktB?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,FUZZY_CREDIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:22c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [babalolafaith008[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [babalolafaith008[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [susannelegitfirm155[at]gmail.com]
        *  1.7 FUZZY_CREDIT BODY: Attempt to obfuscate words in spam
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cze=C5=9B=C4=87

Nazywam si=C4=99 Susanne Klatten i jestem Z Niemiec, mog=C4=99 kontrolowa=
=C4=87 Twoje
problemy finansowe bez uciekania si=C4=99 do Bank=C3=B3w w zakresie Pieni=
=C4=85dze
Kredytowe. Oferujemy po=C5=BCyczki osobiste i po=C5=BCyczki biznesowe, jest=
em
zatwierdzonym i certyfikowanym po=C5=BCyczkodawc=C4=85 z wieloletnim
do=C5=9Bwiadczeniem w udzielaniu po=C5=BCyczek i udzielamy po=C5=BCyczek z
zabezpieczeniem i bez zabezpieczenia w zakresie od 10.000,00 =E2=82=AC ($) =
do
maksymalnie 500 000 000,00 =E2=82=AC ze sta=C5=82ym oprocentowaniem 3% w st=
osunku
rocznym. Czy potrzebujesz po=C5=BCyczki? Napisz do nas na:
susannelegitfirm155@gmail.com

  Mo=C5=BCesz r=C3=B3wnie=C5=BC zobaczy=C4=87 m=C3=B3j link i dowiedzie=C4=
=87 si=C4=99 wi=C4=99cej o mnie.

  https://en.wikipedia.org/wiki/Susanne_Klatten
  https://www.forbes.com/profile/susanne-klatten

  E-mail: susannelegitfirm155@gmail.com
  Podpis,
  Przewodnicz=C4=85cy Wykonawczy
  Susanne Klatten
