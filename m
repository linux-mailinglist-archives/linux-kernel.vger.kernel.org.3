Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432BC528199
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241002AbiEPKOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241818AbiEPKOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:14:01 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E406BBE17
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:13:52 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id e189so17991433oia.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=5G1LK9zGuVO6JEri/BTYszyBsrW5pWFuc0LjV2zPhuQ=;
        b=Qy0aF+w25MnNjIQYiPzHSKWE6c1frTpCUhQdbiPQvYcEIhinrCx6ydHcMi3519uJSA
         U1m2xxjmRU9mpwd211kVhcuMvBlzW83udnPLFgtiJsiUvC2ShVxtSs15RGxB0XFIkxNl
         ASj9qGBM5GOoLeIdzF1U1CkbREwfRggbqvDfY625k8uYkrS8pq7G6BSX9s+fggpf+CPH
         R5+AAlf4rdw3SQqdpmbTiJj8f3K/xasHTysKqygAChE5i5pLNZdCsoSPI3Vsnm73+hQJ
         /JXAW1qj97MxqivI0pkeerdPBtEVNG5N1vPj77U0wo5oxBBfzS+Pj+lbQ0iU6Jga1W6O
         3Oqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=5G1LK9zGuVO6JEri/BTYszyBsrW5pWFuc0LjV2zPhuQ=;
        b=eEs6sYXMlEDzvAlrYZtyyWDoyEZClJJ0/iOeHDrciixDpfz7ziDbafcuCA2JyUrj13
         cY5Xa+7JWE5v5RK0l/rJ57/y7+NBLyLHqjAgYoK3BpNMfjbumHN4fN+yF8Od8RVH4o8c
         Y14DMpFMfgImIqRla0JlPerpHRPi8UQ7aSp1Do0NEIAdY9FSQIjl4PoGqb9SMfPv6j4N
         g3PbkbCq9oY32vDuOTvWVcjBfCi3zRq3VqcSTJszUyq1hMobFqYe+yeRKt5T5ZNFt+Yr
         8qubvo+hlal/dMX14w99yneAWzdgS6P5aaxB5Y/3Bu95i7YR0jDY91wSdYOM0pG5kR/A
         6iFA==
X-Gm-Message-State: AOAM530KxXNMlE4+foQtyK3ieJbiyDctfu8GfntIUAzvnGyO9ZyXeDDL
        9KsanBZGq1oQEV9qVJkhwtHPjDyUA3l3refBTA==
X-Google-Smtp-Source: ABdhPJz5KIn6YZl5sCZrXmaS7AFpF9g1jhmpGzPzIWRnXInk0AyJ3dBrid1hnu5o1oCEcGzChjN1AgBElIiEg1XhB4A=
X-Received: by 2002:a05:6808:3027:b0:2f9:6618:ea55 with SMTP id
 ay39-20020a056808302700b002f96618ea55mr12944455oib.247.1652696032324; Mon, 16
 May 2022 03:13:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:e486:b0:a1:2c9:6266 with HTTP; Mon, 16 May 2022
 03:13:51 -0700 (PDT)
From:   Katherine Wilcox <goodhearts66@gmail.com>
Date:   Mon, 16 May 2022 11:13:51 +0100
Message-ID: <CAHtpm_Tj0d0XNGnDgMNpw1fELHcnRCrAGiRpvzPN=Kcnmfe9CA@mail.gmail.com>
Subject: ooo9ui
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Can you kindly notify me that this your Email account is correct and current.
Thanks.

Mrs Katherine Wilcox
