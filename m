Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1005517DFB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 08:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiECHCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiECHCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:02:34 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4AE38BD0
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 23:59:03 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id m14-20020a17090a34ce00b001d5fe250e23so1263402pjf.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 23:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=hhdzQh6NErLwrcipVxgfQ208X5WMJANMx01AfJGHIYk=;
        b=DK+wyIzdLvCB9NCz1+rWaBfRPzALn6Y1Ehp9sYsCBDuIkJesXooJUFDBEUZX6cw5bG
         2+HU52OD8gUqFvQPzlDA3IsUQtqEYGwXJ1342GxlXvKaruoqXrONMBrQJov/JfTDoVbw
         a14JD59+qbnFoHwY8elNfB335AIJoAtJm+z3ius2RV21CXVLzZXDRNA7w5m2JYOyhuQv
         gKco+jfqS2K6QLLm9AWKZzdlQf0tLX3giOJjEr8/3wOcEEGz7lo3aTau8PnHzQdVERjD
         GGu+dRTz/3pAHWEjZeShFtj2XiVRmNp7VrxKOoYTGfhjGiucGsiSnato05yesOCJFD6D
         BQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=hhdzQh6NErLwrcipVxgfQ208X5WMJANMx01AfJGHIYk=;
        b=MQilz3uIrf6hk/FY/GM3IIODc58Ru1/jXOb2gWVO/eX9FXe0GIIB2IWSoVaUZdj2Dx
         vPD0RoXFTO40PXXDWCDIgmRmPvlABxS/yljNbl1eMBKRNB2ycW44huKMCM/FG17SPz2D
         yTQJLuC72aFIt3gtMtCm2EBh3dd8igtxD+bevXV9pAo2diTfPdi4NLFg725esf5o6tyL
         w/WRZ38xJ48GtmE1xJ7F0a0pCR5xd16Ly8nVnhPkM8+Ndiq90rYHnfrNPjsqEIQ7Kjvp
         8TMnNsGTVh1UhZHydCg2zorIeicX+NccV7KL3aas4reLUawJmbkueP75t1Q754eX9M77
         N26A==
X-Gm-Message-State: AOAM532pPiLewzklj+ZdKUZZc/KHpdj5pK60i9mdBAvrqjIiQNYXCYag
        EbIAKzt4pxWo8VH0vz96MAszjh3CGBKKliO7qVrFmRWm
X-Google-Smtp-Source: ABdhPJyN7RPAENLjN7lo+SOZ6wwCAiiJad0kKtn40LVoVhj968eVzuKJQ91z/fAvIcgr7G6r4tznspBRATCqtyupNNs=
X-Received: by 2002:a17:90b:4d11:b0:1d2:a600:3014 with SMTP id
 mw17-20020a17090b4d1100b001d2a6003014mr3281670pjb.108.1651561142450; Mon, 02
 May 2022 23:59:02 -0700 (PDT)
MIME-Version: 1.0
From:   Mighty M <mightymb17@gmail.com>
Date:   Tue, 3 May 2022 12:28:51 +0530
Message-ID: <CACLAQJEkZbXXOJAxvR7rj-uXv6PkAtLVXLqjKAz+UoYFDSSPxQ@mail.gmail.com>
Subject: SDIO detection on cold boot
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have a samsung-espresso3g, which is an omap4430 device and I have
been running mainline linux on it. But there is an issue that I have
been facing since quite a while, that is the SDIO (mmc5) does not get
detected on cold boot (that is completely power off device then
start). If I boot into TWRP (which has downstream kernel) and then
boot to mainline, the SDIO gets detected and wifi works fine. Any help
on how I can further investigate why it does not work on cold boot,
maybe downstream sets some registers which mainline doesnt?

Regards.
