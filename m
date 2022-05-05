Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5F351C2D4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 16:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380748AbiEEOtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 10:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237470AbiEEOs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 10:48:59 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C0F6545
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 07:45:19 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id g23so5468362edy.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 07:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=NRsKFGIDkGHr/C8V+t8DnhNZU5FADxmt1ukPKfs0+qI=;
        b=c5ikg0iw+xkhPe37FFEtC4U5qxSuDAe010fSVIvZHP2qT3yAjfouMmAQcaxBVsMJfz
         e5tvSP60GpMwmnDf+0nbIH5nPVjrfyDoxyVc/Qd7kkRElsAMlHKGSs1pBqw3dxRe3yjb
         eK1fLlHDMm/0JmhTd6vSfdr8bvaOwYYx3nKMHimIrNXKlluid+VMlPDsu8CiCv9LEw1q
         xjWxDNezow5qnf3Nuu+3ln0TnK4cGO9afLc/ObNO+QfGRDhSrRU38Y0cKwB74VILuTdv
         v/AjZpR4me2JP8kFISQlxJ2hFJNPmHB95I4oga3utOtX1GQFui0cKqalXpX4AOTvnPqx
         LJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=NRsKFGIDkGHr/C8V+t8DnhNZU5FADxmt1ukPKfs0+qI=;
        b=XLZFBICNIxFsHEow5vNVa7dSqHAVjiYBZKmENIb3Dq+ZzSqBJ3irl33k7fHX8+knm2
         gYbBb8dp8RN51dhCi3gCZBufwnAEFL2A3rGtQf7psPxnPbWwt76vYd0uTIClu97T3zfr
         z4WaVFhC++R9Fq15I9qEEvZ+p7Ule9yVgI1ThoXRhdOC7y5zQcxWAkQs5otNKFk7gqve
         cXHvWRKQhFB5/qBJGxLof9mSGE5rPt9ICud2nuXuvpk7h9CVu/yA01rlK7AU23JDiPpJ
         tnV0EnHPEkLiP0CUKfLEAxoE6VMn2yspsyAW91knVMqnHba27cpm7sMf2t7BZP9LsCul
         j29w==
X-Gm-Message-State: AOAM5333B6WPJX6JQ6Rk0vBcDCq82BaWDqMfWiwv4YixWgjregvikzF6
        h9sFE0t7vw85ZB6rfQ/gtIY0LJ0HFB0SlY26Jpc=
X-Google-Smtp-Source: ABdhPJxJW3mnnsG7aF7ISQP0hagAkmwFrWkCOhylR6YCeCbILtvUtuX3jKIPj0rAeiXauHgC+XUDFgTrFZWoYrnz4o8=
X-Received: by 2002:a05:6402:35cd:b0:428:3831:1ba7 with SMTP id
 z13-20020a05640235cd00b0042838311ba7mr4091593edc.311.1651761917975; Thu, 05
 May 2022 07:45:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:ee96:0:b0:425:f70b:1e42 with HTTP; Thu, 5 May 2022
 07:45:17 -0700 (PDT)
Reply-To: sgtkaylam28@gmail.com
From:   sgt kayla manthey <mamancherif2018@gmail.com>
Date:   Thu, 5 May 2022 08:45:17 -0600
Message-ID: <CAHTj9E5Sy1B3n43iYwh-jApsa-kQamLNu52pBMvNb0N-mNxe7g@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
=C3=9Cdv=C3=B6zlettel,
K=C3=A9rem, megkapta az el=C5=91z=C5=91 =C3=BCzenetem? =C3=8Drj vissza
