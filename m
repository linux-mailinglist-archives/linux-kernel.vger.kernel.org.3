Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223F2567840
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 22:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiGEUSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 16:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiGEUSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 16:18:50 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D53713DE4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 13:18:50 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id n10so11954653plp.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 13:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=CtqVVBeLYu1pExxAeQJYAswL1edRC3rBfuCQcsYUqxI=;
        b=abCUGy9NSFsXxhq8Kgxu/M4xHCi2qjRZwsojj/cCqKPITIeS7BEWLCpySPLS1F2GXM
         Z8XvUnSl/Af2mI8PaXJQtgaghANDjQNuaH4dZkULl8i8DTO1+DB1jsyS8P30F0WV3IHl
         r3HaWRJSh6R+JJHKCUB/tRPa0NchIyh4z+O5Z0g4gE313wiNONIvx4CZCWqa6h8qkva9
         eU2/OwJioKUFHTnFXVcJV7gEkY6HDWlpvBfP/ronH8I7/8NbUpm1VvRiQ58DnSPVGHfZ
         Jsr/lyb4v6BjaEnknP2qPIgnhESFbJrj06VOg9tybX51Nf+v5Svp5DyuH5bvHtrL/bOJ
         syPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=CtqVVBeLYu1pExxAeQJYAswL1edRC3rBfuCQcsYUqxI=;
        b=MMU6r+vua9J4TtDDIsEug75JsCYpoiJwQTsQ1HnUjsWKFOmQka2/8VzAqShAiBHkt4
         bMoU/ZF4fE3Hj9EFt/GVVwpLTUuTvlQrdlDL31gcBepxLHmZg/fnQAqf8AKwhOvKm+Zk
         32gSNRD7fHpZffKNMeHZ/dDXo91t8YUj3jc2xfrYCMIvPclGgk/cDcFQz7qEE0UYi9BS
         R0/oVQ96qGF5/NoLKTkKE4iK7uHaG9ozCjfURF02k8shvblfEBs9cOAy1yLiVViLq21V
         Xs+NkdCVJE06mu320QSnmbs0/eC8Z5tCNLGtxGRg3QrtZQTbbqRV4WnPHxcOpYRKU6Bu
         8oUQ==
X-Gm-Message-State: AJIora9VjbYyQgMV4MXwib7PMx2wT7zXcQG+/CHEnjUIYTXoYasF/68V
        ErKRhNPqPJRGxPuZ9eSu4x3Ld9BwljuBqQxKI+w=
X-Google-Smtp-Source: AGRyM1uAfTLXENGoGDMEV0DCv/56GW4LFkU/1rRPSmRugMe75Aq7GHmEp1lO9GOi8bM9UOXss1+/eviF/MHqMWnarxA=
X-Received: by 2002:a17:903:44b:b0:16b:ec58:3727 with SMTP id
 iw11-20020a170903044b00b0016bec583727mr8045538plb.171.1657052329857; Tue, 05
 Jul 2022 13:18:49 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sgtkalamanthey@gmail.com
Sender: admhbyballh9@gmail.com
Received: by 2002:a05:7301:1d0a:b0:6a:ddda:fa15 with HTTP; Tue, 5 Jul 2022
 13:18:49 -0700 (PDT)
From:   kala manthey <sgtkalamanthey@gmail.com>
Date:   Tue, 5 Jul 2022 13:18:49 -0700
X-Google-Sender-Auth: PCL8bNZyuDeFDlKR43ZSJ0voJVs
Message-ID: <CAHP8AhDttLHeyiPMihA9_1sBcwNksO-Oinw5CsF25TEh=SUT=w@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greeting! did you get my previous emails? Please check and reply me
