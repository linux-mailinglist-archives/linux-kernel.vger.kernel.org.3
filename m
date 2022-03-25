Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8ECA4E6F53
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 09:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353858AbiCYIRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 04:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346416AbiCYIRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 04:17:36 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D995ECC525
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 01:16:02 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id a11so5893268qtb.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 01:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=A7SqxPeuATRIawRLPRXdbXUmc+x9RhbBGbJAJobYDWo=;
        b=QRA1kVy8SiSQhjgh4+VDFuGNP8J816bu/6iM7a3gi2CjMJxracxsSOYYjCuBXbuKT6
         4um4vh3trlRD0zVzGoi3ZI+3r1xb7UTDRhm/8d4V0ELs20R5cGwV724Rjhsywn8VVYKK
         Tp8AmVcx9mTGz36a7yJuYlw7NteKcgsU7jlydwHsLKao+VHceAvI3w4Ve8BKtrJdKs0D
         NztUMesiNvhwdbdwbbScF4d6vlndCLGgJrJrMwzpwJ5CMctcgvSTCd0Ahfxvr/2AWWtq
         JTP92f2eI6Pjn5Yyom9UVeQcvngaqg34gyrQuOkGb4ra2C6Mr9JgyTKnI+Vrw7w+5MmU
         lMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=A7SqxPeuATRIawRLPRXdbXUmc+x9RhbBGbJAJobYDWo=;
        b=vQeq4YmgiZVMgqrPg9sIWBEAlp+EXNcxnrvOeGEK26JE2eyAfSzmhNmH9g4BHE06n7
         f3O/6/nanuPGSptOFPTTh8NEKnmUTaPAogYnrQPtfc4mOirP3FXPdz27vj+9ew0FD9vq
         TOyi0eoMpv8UGO1vcobHNinFJ50aRus0HqsgKWX6TgvyCt7FzuAiDJgUmXUvXqMS5Boo
         Y+03myieNGnL7mMlL+7mW/B9waq0Sx3DRx4CnTVqmwdZevLQAOJadMph68LGzEwo8a5o
         tbbOA1Cd2WMqw3ZvWhChTei72xEmW3WvaKZgqp51QdM6qNWqY0DYdJ8Vms2SyrxAnbXR
         Jpvg==
X-Gm-Message-State: AOAM533ICsXZd3WQ4tSRVp7kF7EXBENOe/IVqihsjG4cotvd2/zhwMYP
        2eVHpJizMChNGlyjHlarjSaLbsO2IGl0bdo93sY=
X-Google-Smtp-Source: ABdhPJzuzuxX39wjr8Nttat3zexbb1rJfErQTimFLhuR4nUjaBMHmfttjN71u3/NeGFC0Ny+ZmAXi+zySy+CKm2vSTs=
X-Received: by 2002:a05:622a:1015:b0:2e0:6cd5:7ee1 with SMTP id
 d21-20020a05622a101500b002e06cd57ee1mr7827301qte.485.1648196161512; Fri, 25
 Mar 2022 01:16:01 -0700 (PDT)
MIME-Version: 1.0
Sender: mrs.sohairzulfakar101@gmail.com
Received: by 2002:a05:6214:20ed:0:0:0:0 with HTTP; Fri, 25 Mar 2022 01:16:01
 -0700 (PDT)
From:   Miss Qing Yu <qing9560yu@gmail.com>
Date:   Fri, 25 Mar 2022 08:16:01 +0000
X-Google-Sender-Auth: i-3Aa5c7Db_IZXuG0Xr0OtjghwA
Message-ID: <CAKYCDh_Ay_GZOx=hhz1y1E2i1mDdj=p7L=z8E3b57NfExJGwYg@mail.gmail.com>
Subject: Hello!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_SCAM,LOTS_OF_MONEY,MILLION_USD,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am Mrs Yu. Ging Yunnan, and i have Covid-19 and the doctor said I
will not survive it with the critical condition am in because all
vaccines has been given to me but to no avian, am a China woman but I
base here in France because am married here and I have no child for my
late husband and now am a widow.

My reason of communicating you is that i have $9.2million USD which
was deposited in BNP Paribas Bank here in France by my late husband
which am the next of kin to and I want you to stand as the replacement
beneficiary beneficiary and use the fund to build an orphanage home
there in your country.

Can you handle the project?

Mrs Yu. Ging Yunnan.
