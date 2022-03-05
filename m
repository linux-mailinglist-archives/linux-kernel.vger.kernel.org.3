Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DAE4CE3AE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 09:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiCEIv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 03:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiCEIv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 03:51:27 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715DC120F43
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 00:50:37 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id u7so13857304ljk.13
        for <linux-kernel@vger.kernel.org>; Sat, 05 Mar 2022 00:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Qa5rECKJvlN1nk7iVriL5WpIcIm5alEZ4N0q0BCHVmc=;
        b=eFOK4SMNntXYy5HkmuC/92rjlbpOoNqyOyexw/Rws5rZMTR3pBy7r5h3n0eHkS3dPY
         LzLKQPWrwasbSBUpB8BwvAckBbf1tRn5c67glmucP+6UbmeTPFORKZiHxh5FwwZn4rI7
         w4C24W+fBjC1vlLrR96h4ZnZ2/rXu5/u3Pmlry4EYcdJvKh01Wzdk4kNLutv8o0siLwK
         YYRos73NUWXoTixfrgiZ4gTOzIp9hUXfKbRAEC3zPR7T1cq20SZCv0WbYdvslOMp8Kay
         lF8SsOVterwuriBjJTB/mkzFuJGo/3FSTfuY5gNMMa6KPDp1O3BVKSln2jMZfQR0i+Fo
         esLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=Qa5rECKJvlN1nk7iVriL5WpIcIm5alEZ4N0q0BCHVmc=;
        b=v+PW2vS9o7BDrl3wGVbjzZS2lMXPBrQihyT+wlKmcwnhkRxBdWym20ttky2Dt4VVXB
         s/IIl5/dShbd5do2+hv6ceYCC6WpobTagcL4kQ/hySHu74wjkf7oXKxc9SzCF5stB5Cm
         dAsg1XvMHA6BaW6aso1f7E4dbOUC/quEsLfyIy7lOAu1K6WCcPIkb1oZJchajRk7z0gP
         LHI0ec9KBnKFOraXB866x/c9RvirvDsS/vNNf/egIl0N/cfAQszldpSe1blTpaC4YX2j
         02nC4+GzM93ZAOUPCvVmX1MNci4jvQOeUvlbKPkcIrYKZ66SMd9L85pdlODxXOuejfpH
         m7Ug==
X-Gm-Message-State: AOAM532ZJjSfmO5u6Pf/QTZQNp7nngCTuLi1YVMv7iWX/1elbzzz2KdP
        Mncjukx0dsfzR6n/QZBimjmXEce6GygE8rpo1GY=
X-Google-Smtp-Source: ABdhPJwTcuRRbv+htyh6UWSZicHy3/ESeXX5KJ+UOTDPDsEomkyjXmBv4Bb27OPxnB9DhXULh+zZoQv50o9po4bGKoo=
X-Received: by 2002:a2e:9210:0:b0:246:323e:299a with SMTP id
 k16-20020a2e9210000000b00246323e299amr1622482ljg.34.1646470233908; Sat, 05
 Mar 2022 00:50:33 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac2:4c45:0:0:0:0:0 with HTTP; Sat, 5 Mar 2022 00:50:33 -0800 (PST)
Reply-To: orlandomoris56@gmail.com
From:   Orlando Moris <aliroulatifa@gmail.com>
Date:   Sat, 5 Mar 2022 08:50:33 +0000
Message-ID: <CAGEh6rq1_CFxN0LFuAppFLTJxVoajXBMFg7_MZxfgqSDwJkSNg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tere! Teavitage, et see teie postkasti saabunud e-kiri ei ole viga,
vaid see oli spetsiaalselt teile adresseeritud. Mul on (7 500 000 $)
pakkumine, mille j=C3=A4ttis mu varalahkunud klient insener Carlos, kes
kannab teiega sama nime, kes t=C3=B6=C3=B6tas ja elas siin Lome Togos. Minu
hiline klient ja perekond sattusid auto=C3=B5nnetusse, mis v=C3=B5ttis neil=
t elu
. V=C3=B5tan teiega =C3=BChendust kui lahkunu l=C3=A4hisugulasega, et saaks=
ite n=C3=B5uete
alusel raha k=C3=A4tte. Teie kiire reageerimise korral teavitan teid selle
viisist
selle lepingu t=C3=A4itmine., v=C3=B5tke minuga sellel e-kirjal =C3=BChendu=
st
(orlandomoris56@gmail.com )
