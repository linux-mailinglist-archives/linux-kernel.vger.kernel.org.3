Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB324760FF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 19:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343938AbhLOSrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 13:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbhLOSrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 13:47:01 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8030C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 10:47:01 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id i13so21144263qvm.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 10:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=/XlINfexVmx8rR53lLcQFAGfRVMnbOfUcY9LiIgE4Is=;
        b=fm8w49rxGYFEUQbcsHnxtqMk5geTxkhyYopNt1F+uE9hyp4N95WsbwxcyFPuQuTjQC
         wQvzRi4SxHFw5TU0el30ZlGd54oHirKKsed7Q1rI79joAczhMurG6hmTayS3DLRPSgph
         DWpSEGZtZbw7inqsg0Nd1XNV5fN322CLK/lqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=/XlINfexVmx8rR53lLcQFAGfRVMnbOfUcY9LiIgE4Is=;
        b=GcONS8+ganOpZ9tG+3BbYb3tCVCHjFaPULGfjg8Hijo872ofnFKywp+M/18vBzlnBz
         A+2wmzNWMRtSaDKNyJI8CZUV3tb+BMAtjOMhFY2JOS43gdjs35EHOIijxNN/nNnoIHT2
         MPUr7eC5KG0kmIda2DcnfIiEEPaznUfNp9/FZyMfhUJ+o4R64LqOdx8DygPpCarQtLsG
         e9OQ5xq7/BlCiwjOc6yBweljDASx4mJj+9J3djFhRd+Vh0Cd1QBUidC54s+xmqSD+2+E
         xiknbg+DHygVmh06wIiDT1J46peBB9aBHWjZlB6sw0gEYRrRKf8qMUdCfiHR9MD8SI+d
         UGYQ==
X-Gm-Message-State: AOAM5323iIFRyqvTeGMqu+EptbvO9U4OIheopZ3km4Qty2bWvozjGYEt
        zBw8Vvsx42ZuaIZACQrGqOoAqVHYaGNWzSugfIt3rCZvV8s=
X-Google-Smtp-Source: ABdhPJxuj4MMrxf6Gh/5JpCFXQJNS8jl6pNiIz5xlEowmMBMIrRNoK5pvc+v2a85m9kwwVsYyr2wHPTedCV8pgB+f9k=
X-Received: by 2002:a05:6214:984:: with SMTP id dt4mr12674040qvb.120.1639594020724;
 Wed, 15 Dec 2021 10:47:00 -0800 (PST)
MIME-Version: 1.0
References: <20211214150032.nioelgvmase7yyus@meerkat.local>
In-Reply-To: <20211214150032.nioelgvmase7yyus@meerkat.local>
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Date:   Wed, 15 Dec 2021 13:46:50 -0500
Message-ID: <CAMwyc-TArqDjcyTiLJTdWMPSJioBiyqppuYR3YsUMr7cQDdQMg@mail.gmail.com>
Subject: Re: Please switch intel.com DKIM signatures to c=relaxed/simple
To:     postmaster@intel.com, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Dec 2021 at 10:00, Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
> So, please reconfigure intel.com's DKIM signature setting to use
> c=3Drelaxed/simple. It will have the exact same security effect (nobody c=
ares
> about whitespace in headers), and it will greatly improve the lives of ma=
ny
> kernel developers at Intel.

It looks good now, thank you very much for listening! :)

Best regards,
--=20
Konstantin Ryabitsev
Director, IT Core Projects
The Linux Foundation
Montr=C3=A9al, Qu=C3=A9bec
