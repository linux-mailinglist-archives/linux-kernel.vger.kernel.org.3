Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD9D58CBB4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 17:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243586AbiHHP6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 11:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243686AbiHHP62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:58:28 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCD11580E
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 08:58:27 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id o2so6000296lfb.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 08:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=vZpVaQ5rPegmIVzNyaxOfoM0VNwkqKKWPatO1YAhChk=;
        b=Tsq4kZXIUweATdFjwFU+DS09JDiQKpQBdnIQoeIeGz6JVFbuXWM++4JlPXIbZvwCo3
         5COcaq1JT6TOvB5NF1QWxozRFaRYT7nhNYY4Rdxzl71DvzA0ysfS0Jm0DIl2zQYrp4FY
         QEX4Z9HIN004RwKPlivw+0L1xEaFns4EXAkg9cM5tuB9F9N8fo0fPkxYB3DLilY6p6yT
         ubyZ41pPChoQeLNl48ypNEAR/RNtiONb0NTNpkZ99+Zr4TyJz5CUkv8x+ah04iYd1E9k
         DZnmNkJSMleMP+fWG1XNLXnYET+8biDyJcES2JwRBkqYhk76h9o+rpozzOYQLyNshcUN
         y2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=vZpVaQ5rPegmIVzNyaxOfoM0VNwkqKKWPatO1YAhChk=;
        b=LMXKd7QSJ6TjfwaaPBqOR59C8HCoLEFI1x8vG8bDmzKNDtajDAHt3Gm7vbVyyFEM37
         VcfnBfZJXo2g9All4R6GdAt30bSwNSWamDO5sZmaCXJ8pOFu83Ao9nFd90CNT0a7zbhz
         sV8bcaH0ersXC56S3wXlLHTDdEKhtnKuqLzodcUSJCftv0cAaeamKpwuPEVAuAvXjqgK
         VHM+QF9Zd2n+BO1xf8gjpkTWvDYteONaVmrRrqA++c3QGhhcKVY5eIEkm7ZLwdxpxkXh
         U8YIsYyf/PIZps0dCEuCoMo2DBbHDpEZEO8rk3tEgLOfHbS64mFKewWN6YfwfnBG4DkN
         0pmw==
X-Gm-Message-State: ACgBeo1Rz9Mm5CyKYNhS9hJ82aE8D9weR+79kSCklr8oIJi4K1HfYF3D
        VLplPTDRI3HeAf+32DWSIJBlnwABgGLjPjInLhM=
X-Google-Smtp-Source: AA6agR5QOJoR8oI7qYnBCLSuNex/zwsQ4t3Ti/KymJULDE8i+BnBtvYL3RkoQx7PeLj5W66uQW0EPPB6TSSQGb1GI5w=
X-Received: by 2002:a05:6512:3dac:b0:48b:694:bb35 with SMTP id
 k44-20020a0565123dac00b0048b0694bb35mr7310877lfv.215.1659974306171; Mon, 08
 Aug 2022 08:58:26 -0700 (PDT)
MIME-Version: 1.0
From:   Sara Jack <getdatalistss@gmail.com>
Date:   Mon, 8 Aug 2022 10:58:14 -0500
Message-ID: <CADHezymY_Mf0XUjf_O_cgAVicEW1vz-QZ8C8fRepPJhV8cn03Q@mail.gmail.com>
Subject: RE: Gartner IT Symposium/ Xpo Attendees Email List- 2022
To:     Sara Jack <getdatalistss@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,
        FILL_THIS_FORM_LONG,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I hope you're doing great and staying healthy!

Would you be interested in acquiring the Gartner IT Symposium/ Xpo
Attendees Data List 2022?

List contain: Company Name, Contact Name, First Name, Middle Name,
Last Name, Title, Address, Street, City, Zip code, State, Country,
Telephone, Email address and more,

No of Contacts:- 8,969
Cost: $ 1,426

Looking forward for your response,

Kind Regards,
Sara Jack
Marketing Coordinator
