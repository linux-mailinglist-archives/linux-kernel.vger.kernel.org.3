Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEC44D76C5
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 17:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbiCMQbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 12:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiCMQbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 12:31:06 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5421FA66
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 09:29:57 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id p15so29129023ejc.7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 09:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=WBcWHg0MjNRnhnHGAOyvHBEmp+CR73Ntkftw1OgXDJ1ZPgBRyVNFAIQfz4PWT8TYbG
         z4EGOCDK4GDz4L7qSTOB4zS5+VippG45F9YObS5EwScBNUpdITpvzPUCTEghQdxnZhTA
         dfJFOZYge9WpE293imqe5Xa9BnDRMdHQ+fy8YXPV522jTdHs1YHOSEAKj3jpg7rU7H4P
         XLNO+TtLb4LcPU4GFnHPc3gEz86D0NXr0hNQaJ3IoWMX7d9ZPe4xIXNM3ZLNHpijk5Dt
         hrL8sEWiroehWTiL1VfcqQbijsUs9ruLNoYvkTVk68R1zZTdfatnS4Az3yBOmCcKxK7F
         v62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=aIMA/WRlWhYWiHXrMr8M8CJOeRh849erRBId/sqCDhIzgU+8KUkXAbWlu8vgD18owA
         wcqeBVodtDmPa+SkXViUiIsQFtau/LIsjXJ+QjGVhINpleTPqdP8V2RQp7PSqlgzkD5l
         uTevSzYdcbevvxHfCHaT5zzixn0YPLjqjBDVne3b8oMVnZ7opGvOzcnOBxVupmEMqZ/c
         zlKgL7+1v2gIkGjd3S6YUx9RHqY5xI/HPZeyNQUv7TgMu82L3AMh/bRRKgOQra7M/bx7
         AkbCGaqIb26yoSJUI3WwSgsVfkFsSZNPrMQRTWKYI0zRHeur5wkGQxt6P9wrMliy7+/5
         Ql7w==
X-Gm-Message-State: AOAM531XfJ4WBA1RNEMo04UVLrap22X5CzJF3ZeB2qCgGhDkvv5/Z5oT
        8nLAwjs8sG2bjyFz0AYF4ujNBM0GycBL8o1mnWA=
X-Google-Smtp-Source: ABdhPJwmwc94+B6FPFPCleCzqWtW22aiaXUXmd9Br7xucxBqoDYZ7p9OCr72Y+4BLuDrxi5LxhJH3Mb6iQubTFm1aQY=
X-Received: by 2002:a17:906:c053:b0:6b5:fde8:af2 with SMTP id
 bm19-20020a170906c05300b006b5fde80af2mr15846201ejb.642.1647188996139; Sun, 13
 Mar 2022 09:29:56 -0700 (PDT)
MIME-Version: 1.0
Sender: genemannrattan@gmail.com
Received: by 2002:ab4:a1ad:0:0:0:0:0 with HTTP; Sun, 13 Mar 2022 09:29:55
 -0700 (PDT)
From:   Mathew Bowles <mathewbowles2021@gmail.com>
Date:   Sun, 13 Mar 2022 16:29:55 +0000
X-Google-Sender-Auth: 9K3NPcbtaPXvXyEfywvJwoE-zYI
Message-ID: <CAPGCBWFwMJDOzyp7mRNEi9Zf+n5Vbv2TUjogMLESjAhp5G0EGA@mail.gmail.com>
Subject: Hello,Did you receive my email message
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


