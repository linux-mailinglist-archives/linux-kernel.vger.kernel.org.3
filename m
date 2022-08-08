Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B46D58C231
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 05:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236882AbiHHDuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 23:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236162AbiHHDu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 23:50:29 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5AD6256
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 20:50:28 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id w11-20020a17090a380b00b001f73f75a1feso2447554pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 20:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc;
        bh=D6rQxTD2B5xb7MSrRz5kk0UcBFzyprbH0T2X8tSwRkE=;
        b=PYG9KLov6hjNFP3SqAlaFi1SgbPteI3DPD4lyke7w+purRgQOWU/ntyHUP/VpMfELT
         1WTCLc6Urs0xvTmO58uBG0OPQp3r54V+L8h3UaRkd0tVgeqErY3BK09C3j7hNx9uO6ja
         xyBKzXj+YWVqHCBb6ETr2C4V7Yr7Bvs7A6TVJ9TR4y6X6rSzQIuG69g9ZpzAesylokK6
         NJu3Xg3M6opZH4aGNyowUpbBe88XZDLMUoDFvlyeaKNOfmWAatLX05BekMGcjYRVhtQ8
         ee9fqzGWxn0W4FCb0NARfDDiPtd09FRCTXUxi8/yja2sAi3cbPf83uNzcn238m4IkS19
         c5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc;
        bh=D6rQxTD2B5xb7MSrRz5kk0UcBFzyprbH0T2X8tSwRkE=;
        b=Pizy5svK1l94+OKVhOxKuUw651Q5rZiIAd9eRz78ciO528lfs3QBYekmMKqnoSMYkN
         EqiNPakF2HLhhEGMvxqbNiN5f/WeZsgFgBkpjGcwL15t9C791eSe38dULasq4C7405Fs
         9h2/co5CZLy5DoYP9D3mojq5rKjGCRRsXSyZh72zZDujDMwu/fQo4NXGbhNSoA6SD7wi
         HiFNPDilNZhNbruGwViH9FiVe59paZI6/Icofjb/xOcoBF0pHSHejbp4PhvBMSAW63UN
         iy/G5GXhDO+wFEEXMBKyU1nYmh8nIwp1yIkfSm93viWRXmv3iqkYBJOMOGDnYnWsRnhZ
         G21A==
X-Gm-Message-State: ACgBeo2rphyC4P63HK1mkrzciMxWf61XhLlCfFNZ/7gu48fb/opKl4Dn
        rFun5oI9tOmN0DzvJ38RX7gaGcGv1SEKN/wHZWlabV5CtO8=
X-Google-Smtp-Source: AA6agR5pukroDhDCxm0crjldWTMSyCqXFIdFB+DMfDIU53S9mhrzbBNXLtzXASzJ18doEE8nBmjflmiRjiZyBGd6cM0=
X-Received: by 2002:a17:902:8644:b0:16b:ea77:a6cb with SMTP id
 y4-20020a170902864400b0016bea77a6cbmr17084007plt.59.1659930627519; Sun, 07
 Aug 2022 20:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <CADDGra2dyKsd8cODUpJ0O3+kCKLzwSHf7QFsOkXVpv3Q2tmgnw@mail.gmail.com>
In-Reply-To: <CADDGra2dyKsd8cODUpJ0O3+kCKLzwSHf7QFsOkXVpv3Q2tmgnw@mail.gmail.com>
From:   Mahendra SP <mahendra.sp@gmail.com>
Date:   Mon, 8 Aug 2022 09:20:16 +0530
Message-ID: <CADDGra0Fm8k-SpaaoXDxu_cb7g3myxniMu1nKdHGRznv=n544A@mail.gmail.com>
Subject: Re: TAHI IPv6 test failures on 4.19 LTS
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Could you please help with inputs for this TAHI failures query ?

Thanks
Mahendra

On Fri, Aug 5, 2022 at 11:13 PM Mahendra SP <mahendra.sp@gmail.com> wrote:
>
> Hi,
>
> We are seeing a total 18 failures when TAHI IPv6 conformance test tool
> is run against kernel version 4.19 ( specifically 4.19.29 )
>
> Here are  the tests that are failing:
> Section 1
> 13 tests failed out of 54 tests <test numbers:
> 16,17,42,43,44,45,46,47,48,49,50,51, 53>
>
> Section 2
> 1 test failed out of 236 tests <test number 138>
>
> Section 5
> 4 tests failed out of 25 tests <test numbers 12,17,20,24>
>
> Is anyone else seeing similar kinds of failures ?
> Could you please let me know if these are addressed in any of the
> latest kernel versions?
> If yes, please point me to commits/ fixed versions.
>
> Please let me know if you need any additional information regarding
> the above failures.
>
> Thanks
> Mahendra
