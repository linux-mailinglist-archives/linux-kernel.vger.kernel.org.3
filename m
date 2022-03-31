Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36ACC4EDBAC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 16:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237550AbiCaO3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 10:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237536AbiCaO3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 10:29:44 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E888421D7DB
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 07:27:56 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id by7so99313ljb.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 07:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H9zw51UkEooU51O6uDBnpMaIip01pIRg5ivq80VWb3U=;
        b=dRY7km9LLsGbpfH2PHYxfYob9jbeOynMEAO/kWim3KrRNdgJxJ3NK6SE6H8LDcWKNw
         HeMnEj8ohb2DYFBeUtTwi7U0DLfutVRkxhSZeMgozmQ3cDiaoXlpZHspOlEZOdKXi1Kz
         fnV4dJGMeVAlA0NfXAxoVYh4AIazbO9zGUmulBGJLzvyhGkAGn2sbPCWh6qBDk9P2vrV
         BsHv+pVCg2K0dyrBr9Z5e5XFjdkbJEgH0ZPnBkXLyyzc3bOLaRmEFv3tqRwHu+53DlmW
         OPYPgC0GzIVaabGz9lIl30Vc8A+Ext/OQZ3A0itOoqfLv1sOsVO7+kzlzRq9AtC8BTN8
         N1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H9zw51UkEooU51O6uDBnpMaIip01pIRg5ivq80VWb3U=;
        b=BDqH0SmLbUAm97UpklrZw9/xFI1LcoYU1cZCIM6gVdmx+kuZn8e45i2aAu59JKiyQ8
         t9FzsrkieGG2PWmLBVUf+fNxEW819CZ3dkXLSJdHf1cAApVYoazvb1oy5sS2/O8YCRwu
         wYzmgFT5w2YjbeUFoK6eK2q0IeJ6y66MYEI8kaviL1g+9e+n9RXTdcPg+cdxT3ZMZZS4
         bR1W0MMYDZeAweYDKNcXiy0w8E8q+pboX8HQnMSweN4yYI9T/ZF9e5yIi5boGOFkD5oc
         MGJZf4/FRQgAgqyzu5TGPPvwqWm3SbR+IQgUtZrKwS418pWx8UZEjOLp25/9k+R/Ke+l
         UoxA==
X-Gm-Message-State: AOAM531S/8BAl6NvUmTEgfBEVi+honDFRJaRP6/lpC4F6dLq0Fn2pJlR
        PBHj1lWrp1QT24tTzNUbraLuJvV3KdB7Dl7HZ+ZGTLgbsCY=
X-Google-Smtp-Source: ABdhPJxtcIvjAHcxVvUeKdeZsuMITYP3rijJH8qEnONOOmqnKTwnbUB8YtzM+WgoRvuTY4WQNTo2/qujvxZvRW5eoCQ=
X-Received: by 2002:a05:651c:158e:b0:248:1ce:a2a with SMTP id
 h14-20020a05651c158e00b0024801ce0a2amr10246261ljq.172.1648736874967; Thu, 31
 Mar 2022 07:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220331122618.GA434796@euclid> <20220331141456.GP3293@kadam>
In-Reply-To: <20220331141456.GP3293@kadam>
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Date:   Thu, 31 Mar 2022 10:27:43 -0400
Message-ID: <CAMWRUK5q8tadCVD-AbFCjQs2qvnvZG8Pyg+W+jt52g=sVDB5bw@mail.gmail.com>
Subject: Re: [PATCH v2] staging: rtl8723bs: place constants on the right side
 of tests
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
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

On Thu, Mar 31, 2022 at 10:15 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Thu, Mar 31, 2022 at 08:26:18AM -0400, Sevinj Aghayeva wrote:
> > Adhere to Linux kernel coding style.
> >
> > Reported by checkpatch:
> >
> > WARNING: Comparisons should place the constant on the right side of the test
> >
> > Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
> > ---
> >
> > v1 -> v2: Missed one case of constant being placed on the left. Now
> > checkpath reports no such warnings for this file.
>
> You need to send a reply to the original email "Hi, please ignore this
> one, I spotted another line I want to clean up" so that Greg does not
> apply it first before reading this one.

Got it, thanks! Will do so in the future.

>
> regards,
> dan carpenter
>



--

Sevinj.Aghayeva
