Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A124FBF66
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347373AbiDKOn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbiDKOn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:43:56 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4515430E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:41:42 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id g18so6396406ejc.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=/gRCW+/ZTWkX63u3kC8DaXNcDlDy5LeY+/2rCoAscbg=;
        b=o3rvsNcwXqpdR4iGcJPzcyYcMXiquCyyz49ayLTWtv+FaYPAhUbN/JyRW8vdASExdF
         ktcfOTTOBcoQKpWl8o3Ija+WHWGhkB8fzC6y//IkE6mS5v5PQfRa1+PROJzWxud1kIuj
         tcfvuQ6dcpJoyWJoBBmXWW94AKiPD74T7pZRVgsBUgorKqc2QpReT0L+LO2Lbn4T+5hn
         odvjvT0mnNoxzdCXrI6GlpVETlrPfnUGgQ92EMQ/IafsRZQPtV0ZWC0pA4kYWbTAFke5
         OrGzt8cjOJBl2+2xZrRkcng42tTsroaH/BfczOd3JTlWOn9aWclffQYztzuaM3kMFhZW
         NOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=/gRCW+/ZTWkX63u3kC8DaXNcDlDy5LeY+/2rCoAscbg=;
        b=7NaPfGBSKCf2HykZ05VjmT7G7Mu/9HhHWh6UEkdZhPDHOtwzB+AVYfKLZd/o1eBp/M
         H+0uDCYsRd1tAoP6RrJ/phamOXdWVZg6+6/Uuba3yHJHB92AYqcHj+IXl5krCuaTw0v7
         jqmnaAzfj8/EJgjBpjhWuTeuM5NyPMCd9lSs2kHXWrbVwCoaYP4pJB82Y0hQHqoPUo9W
         HJi+fAxDATAEpLLzAxWPQtH3trNM2BG0JTpS7z3PLVsA/1oxCD2A/jaCoQLS7xpAeV22
         V3pdH6Yn5Z88MP4v9cCW87SUtFlr/evyEeTaEj9CMPZ8QUvx5a/D1YAP/VZz7xoiw/Kk
         U9vw==
X-Gm-Message-State: AOAM533phupJEt9XKD883WSZb5pXsNLqblaGlbeSUVJbEb7H4b+i5X1e
        kh9NmjLVfWDu7XellQGa4Ja34VmzXgIUZVlC5Go=
X-Google-Smtp-Source: ABdhPJxH3ICGudwtJ6F+kuaI3wtoUbONd5Nxb3I/R10tdCnACtVF3jN0oqi4wwEfK9tloBXbO4m18JE18U5eUijvl8c=
X-Received: by 2002:a17:906:1692:b0:6e8:7641:c620 with SMTP id
 s18-20020a170906169200b006e87641c620mr9097636ejd.183.1649688100804; Mon, 11
 Apr 2022 07:41:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6400:121e:0:0:0:0 with HTTP; Mon, 11 Apr 2022 07:41:40
 -0700 (PDT)
Reply-To: oolivep60@yahoo.com
From:   ftota paua <ftotapaua@gmail.com>
Date:   Mon, 11 Apr 2022 14:41:40 +0000
Message-ID: <CAAeonxz-GeBjKdETYdV5Dfgo=ft6PpSmYw1a=EmNggHiq9z6DQ@mail.gmail.com>
Subject: hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.2 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:644 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.7942]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ftotapaua[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [oolivep60[at]yahoo.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Hi nice to meet you my name is olivia ,i am a single honest woman
,lookig for a good honest man to spend rest of my life with, if you
are interested reply me back , i will send you some of my photo when
you reply, mind you age, color,distance,religion is not barrier to
relationship what most important is love that we will build together
thanks and God blesss  olivia



Hallo, sch=C3=B6n, Sie kennenzulernen, mein Name ist Olivia, ich bin eine
ehrliche Single-Frau, die nach einem guten, ehrlichen Mann sucht, mit
dem ich den Rest meines Lebens verbringen kann. Wenn Sie interessiert
sind, antworten Sie mir. Ich werde Ihnen einige meiner Fotos senden,
wenn Sie antworten , wohlgemerkt Alter, Farbe, Entfernung, Religion
ist kein Hindernis f=C3=BCr eine Beziehung, was am wichtigsten ist, ist die
Liebe, die wir zusammen aufbauen werden, danke und Gott segne Olivia
