Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB3A4B7816
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238671AbiBOUEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 15:04:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239220AbiBOUER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:04:17 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC437EDBA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:04:07 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 124so31436684ybn.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:cc;
        bh=AT2vVSkbs5Z2AlPH3lVSxISBm4g33VFLgVGD3BjUf+w=;
        b=GFlR2gBRGin6bBPP4+r+TXYscaajd7RXT5KOw1r8dOfN92bN/4GaGERmmflMuUbE8p
         MijMv1QYcbNWIDArpzHO0m2m28YVr4o1Tg/7hS/1dKROOeBirz+vscMowxa4Ec7Ex7fq
         KRd9OaOCy4GpwDbythpCB21B1CaSVWploH2ek1vWy4nhrzZoaq/KQiKuzaz58Vfhtz8N
         ye2qmmcLEjtOysi9w6kWHWgduXUsxrki/FLuz3CRwykokqr7eeNL8zsMYz1Q2M3SHITA
         o2pYDnQ2KUnkTVUe5G74CX3QGHgXXEMKnf+BD/isuROY+DJ5DX2PcGBFaRFmTyxyZmn/
         km4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:cc;
        bh=AT2vVSkbs5Z2AlPH3lVSxISBm4g33VFLgVGD3BjUf+w=;
        b=tOOa9OW3dYPrnB7L5yrDrSL+KkXjiUFuZWx94oQDqLEJ8wts6GMZCp8aYdxAhTV38n
         k8pKB+01ZfSM6z+VgruGArloPrV0PkV3vV3VETzt33bVmFsDTZR4g6/1/9x8VMmv3wd8
         eHEdaD4jgn++ywY+pMlfAf67c1iTQTaEv64CEAS3z9x80dayaver6l1KE69Lychw778x
         R829CUP1FEGe8aciS/dbX3eTDHRARrRjla/zsjmZLuekDjhXAfVNgeJIgle02qD2rO+A
         AlHKmq2W2gZn3Tdmg8FvmtzjfrhS3tvTV7PGDNpYyvxHOhmSLYtq+QoWy5LN3TS3rUpm
         ZqlQ==
X-Gm-Message-State: AOAM530wSLrEf4cN3mRDuEYw38XN5tUGjl19j0Pg/ktWx3C/vnLHZJQe
        ZVzhMVPPVWiaBqB2OB/8dRDxBA3GeBxNYX5ey+A=
X-Received: by 2002:a81:7046:: with SMTP id l67mt467746ywc.303.1644955446862;
 Tue, 15 Feb 2022 12:04:06 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7011:309:b0:202:87aa:d2df with HTTP; Tue, 15 Feb 2022
 12:04:06 -0800 (PST)
Reply-To: lisamuna2001@gmail.com
In-Reply-To: <CAOpEvtgN9_QbDKF6bPx1TuZA2a4qB6ijS3SviGyXAJy+Js9WMg@mail.gmail.com>
References: <CAOpEvtgcsLBo4KYLh4TytortfQyXOEuZMMD-AoTKs8cH4eZCWA@mail.gmail.com>
 <CAOpEvthc216rfsKnOQDc-V6pkaFet4i34YeGbuiXDi7Rt4Yvmw@mail.gmail.com>
 <CAOpEvtjx5H-USfSECRTP9Dh+9X6CRTJBK-0dHMz3NtK_Y9FCcQ@mail.gmail.com>
 <CAOpEvtgrHyzgmPoC2EkNxpCeBhYgBbcBKJdbzYmmvOVgj8S0GA@mail.gmail.com>
 <CAOpEvtj388=Tec2XvAPLWpf20+rR5-W4Zx5u07yAZ5N85Kq6VQ@mail.gmail.com>
 <CAOpEvtg9W7DLWf9=dpe+6KXndJvRRAiKaDGgZEuO1kZ73kQyKg@mail.gmail.com>
 <CAOpEvtj+YQ-w617odpXS3+sn6ZV8QLoAZ6Bgc-m7pa4c+fCPKg@mail.gmail.com>
 <CAOpEvtgCidzefoFEJmFCvt_s=FUBZs=ydiJ1iiyzZJXetN9ZSA@mail.gmail.com>
 <CAOpEvtgtdZBaAoHkBnFd0gJaVo-s4ViHFi2zPD5E9YF_0UxZWw@mail.gmail.com>
 <CAOpEvtgbu-QQ0EvU-_8VC57Pexpcq1e8ejOJfDM9SHaGkzM1jw@mail.gmail.com> <CAOpEvtgN9_QbDKF6bPx1TuZA2a4qB6ijS3SviGyXAJy+Js9WMg@mail.gmail.com>
From:   lisa muna <amedodziyaovi@gmail.com>
Date:   Tue, 15 Feb 2022 21:04:06 +0100
Message-ID: <CAOpEvtgyC+L-WQyXqmrKxFhD3=Adhtq_+=Xv7+DHs66XUyG6OA@mail.gmail.com>
Subject: hello
Cc:     lisamuna2001@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do you receive my massage
