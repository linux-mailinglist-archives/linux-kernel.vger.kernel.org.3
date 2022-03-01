Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0133D4C84AC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 08:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbiCAHKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 02:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbiCAHKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 02:10:06 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36A43BF8A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 23:09:25 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 139so13705587pge.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 23:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=66Sxg9TTb1+vJx2kh2rsB4ZZCACi/8CIbGkiP6YgOiQ=;
        b=cyFY5zdVAMynn2mS9YKvfPe5YBDSyA0Dmjum+j0w7KGJtzWuteLYnUtF45IXOMokX9
         UFyFvkVFCXPE9vqSKQnC6STvUHgFQ4iVtw+0o8AdwKzhCdoBP0mSSjShlGjj43IePk+m
         apBW8vzf/YhvkdwADs0dvefU3S9fIkkc92h1md5f7jbUuvwKjiSOkN3cBz600GaR5Zaq
         4SGQoHo/yEI7IaIBd8GjeWK8AO6k3HmcwZKyfZS30Tm3VCzSjjfp9/vFee9R3YxkhrnN
         HtOyNS8se2ifhL7T3mGtiRVASsWZP8V57+I8vhMl7kFOPq7Ik841jE9vO98aN5ru0iMH
         YsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=66Sxg9TTb1+vJx2kh2rsB4ZZCACi/8CIbGkiP6YgOiQ=;
        b=zzhmflLIhsDSKk0YbMVq1vWw9DkblvoV5nYADz3QAHw0Mnvb1q1/N57+IonptN8TNA
         waeO0ZZ4/vBmQ3FMS4UxCKiXZG/pzcBtnDrEOwVszFeovVfcfWmb+w21p/RwT0tOwwaR
         bKIMNU9x8dIebo/mWesVr2bt3i9x43lJqND0/qk+gWWwKPfgW0HYnqZzriXFydXGxzsZ
         kySAY7OGVSMasQGpQt4lVpuPbseiNHYVyPKGG9t/ciPEcztEONfKJTtAFfTcaKAKDqTO
         UuS/TPe/1VFRgNlWz6nSebyPSQxt0s+av4AlcHfDtAaS14wK7GX2FVTqZktnqZ8VJ4Rz
         UG+Q==
X-Gm-Message-State: AOAM5303+rn7ExwviC4R9cvQHAXHScrabHKnVpc9ST4lxE6HyNjOWLpl
        bspc9Q+gfL00JOGvfbgx36Vs/CizBvMC7S8FOL0=
X-Google-Smtp-Source: ABdhPJxjOxbWlhTQRSxDBBpVXd3UGjPHQzcLI8DztgPM+0iQqEyUrAMVvsr+PHcWnVgd8qSf6IHEviMX6i5NMlchQ68=
X-Received: by 2002:a05:6a00:1954:b0:4e1:f25:ce41 with SMTP id
 s20-20020a056a00195400b004e10f25ce41mr25968987pfk.44.1646118565041; Mon, 28
 Feb 2022 23:09:25 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:90a:2a83:0:0:0:0 with HTTP; Mon, 28 Feb 2022 23:09:24
 -0800 (PST)
Reply-To: eshahat.desmond@gmail.com
From:   DESMOND <diallocherif836@gmail.com>
Date:   Tue, 1 Mar 2022 15:09:24 +0800
Message-ID: <CAEEG7pcBoeSaWnLnyGy866fchMJzJHQLQE4JW29jDZBARCB4xg@mail.gmail.com>
Subject: Hello kindly reply
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello good day

I sent you a mail last week i have been waiting for your reply. is
about the fund i want you to claim i will explain better to you when
you reply to me this time. am very serious about this i will be
waiting to your reply thank

Eshaha Desmond
