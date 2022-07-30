Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABCD585A21
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 12:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbiG3Kdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 06:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiG3Kdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 06:33:52 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9349F25594
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 03:33:51 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id n15so3374590vkk.8
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 03:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc;
        bh=AgBxG7NhRBxLxgpdghm8A1CMy+t04iquRmuR9zFRteY=;
        b=FS3EiViQelkMqnTOLITX6xLWEPwVHpvduywQv0frcmSbAX0OFP3FEV8I73t/lKooOn
         PauokmM78bAuzpMFcb979Is1ENCC1Pved09FnUn3FX6e+3IxoNKaoSz4/EPkwq3k8dt5
         FFTZ1L152OHTpnoKazNqjvbm2sCRweieXCa9FMhgYSKlwrz4ZKpeJGTP4U6MP+xiLbH/
         HOFBpjAofCfAim8TxjATgLah9dpE6LaoOurbrlZU+KUqHR4ZCuNVHMQ5wuirx1w/FSyB
         8qELXeW4e17AW5u4YL4FrRPCatFnrInG5iir/irokMemq7JTKlEzMTA3z9uuQQXJZM5R
         +46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc;
        bh=AgBxG7NhRBxLxgpdghm8A1CMy+t04iquRmuR9zFRteY=;
        b=LVpcAqxRLEvdTFQVuQ8x21P/8P+HKt77H51BO7DhvWg4YDQncXAA8J1iolBkIbIPN5
         LWi21kztsGPsSzgZ1XKFgemlFAjE/tyRsTdDvXGozfVsYBFbc/1Q+Pe4DoFeRR3mVRzf
         ZnfIG4RaEUXLAJ95AU8LksG6sW9EvR4iWJAei9xVbqK9LyYHGqTsZx9L0KWb8kSkxMaa
         yP+7KKO1DrIuL2IkDQutvcuxgkU9DsMC/KICkLTB2QspHdZnU8sSM/dxdfXbuV2GcWmR
         ZfWYSMRs0XPrNb0GYwXsQ6fjXYSCiQBHaJYXoWNCb3tnT/7nuRWMj5E4M2fixz1m/tP6
         bKfw==
X-Gm-Message-State: AJIora+q1e0EG9+ovdyK299tg5pDswegd5BOkO5WQvoeUH+hrCzR3Xa6
        asog/IlcYi7cclsn6oYrSfEgiKkdaiC60Y8tB98=
X-Google-Smtp-Source: AGRyM1vosb9T6QlOtraPWEgJ6eHYd/BTVLlPDDVVHvk/iXpanBdvdwoF1pkK0zcms1MMlimepT10ieT4wiqNegZ5i5g=
X-Received: by 2002:a1f:a7c4:0:b0:375:52b4:8249 with SMTP id
 q187-20020a1fa7c4000000b0037552b48249mr3039507vke.31.1659177230324; Sat, 30
 Jul 2022 03:33:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:ba0a:0:b0:283:5abb:9e93 with HTTP; Sat, 30 Jul 2022
 03:33:49 -0700 (PDT)
Reply-To: anwilliam152@citromail.hu
From:   "Anna S. William" <miss.elainarden@gmail.com>
Date:   Sat, 30 Jul 2022 03:33:49 -0700
Message-ID: <CAHxDTNy+yRUN56_WE4BquAbr96N-VR29H5euSnOcxRovNu6m2w@mail.gmail.com>
Subject: =?UTF-8?B?R8O8bmF5ZMSxbiw=?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

G=C3=BCnayd=C4=B1n,

Ki=C5=9Fili=C4=9Finize olan sayg=C4=B1mla ve =C3=A7ok samimiyetimle
Bu ileti=C5=9Fimin sizinle =C3=A7ok yard=C4=B1mc=C4=B1 olabilece=C4=9Fine i=
nand=C4=B1=C4=9F=C4=B1m i=C3=A7in
benim i=C3=A7in, ben Anna S. William, bu mektup son derece ayr=C4=B1cal=C4=
=B1kl=C4=B1 ve
m=C3=BC=C5=9Fterimizden birini kaybetti=C4=9Fimiz i=C3=A7in acilen ilgilenm=
enizi gerektiriyor
sizin =C3=BClkenizden olanlar da ayn=C4=B1 aile ad=C4=B1na sahip
sen ve o daha =C3=B6nce Bankam=C4=B1zda 4,7 Milyon Dolarl=C4=B1k sabit vade=
li bir
Mevduat=C4=B1n=C4=B1z vard=C4=B1
onun =C3=B6l=C3=BCm=C3=BC.

Merhum M=C3=BC=C5=9Fterimiz Mustafa ile uyru=C4=9Funuz g=C3=B6z =C3=B6n=C3=
=BCne al=C4=B1nd=C4=B1=C4=9F=C4=B1nda,
sizi miras fonunun lehdar=C4=B1 olarak bankaya sunmak
ve ikimiz de paray=C4=B1 %50 %50'ye b=C3=B6l=C3=BC=C5=9Ft=C3=BCrece=C4=9Fiz=
.
hesab=C4=B1n=C4=B1za aktar=C4=B1l=C4=B1r.

Acil cevab=C4=B1n=C4=B1z=C4=B1 bekliyorum.

Sayg=C4=B1lar=C4=B1mla,
Anna S. William.
